Game = lib.class('Game')

function Game:constructor(data)
    self.groupId = data.groupId

    self.uniqueId = data.uniqueId

    self.taskId = data.taskId

    -- location setup
    local interior = nil

    for k, v in pairs(svConfig.interiors) do
        if v.key == data.interiorKey then
            interior = v
        end
    end

    self.enterTargetCoords = interior.enterTargetCoords
    self.exitTargetCoords = interior.exitTargetCoords
    self.insideCoords = interior.insideCoords
    self.outsideCoords = interior.outsideCoords
    self.interiorKey = interior.key
    self.chestCoords = interior.chestCoords
    self.chestRotation = interior.chestRotation
    self.chestModel = interior.chestModel
    self.shopCoords = interior.shop
    self.shopRotation = interior.shopRotation
    self.shopModel = interior.shopModel
    self.pedModels = lib.table.deepclone(interior.pedModels)
    self.soundPrefix = interior.soundPrefix
    self.soundVolume = interior.soundVolume
    self.bossModels = interior.bossModels or { `u_m_m_jewelsec_01` }
    self.eliteModels = interior.eliteModels or { `u_m_m_jewelsec_01` }

    self.bucketId = data.bucketId
    self.deadStateIds = {}
    self.playersInside = {}
    self.playersEntered = {}
    self.playersSavedData = {}
    self.involvedStateIds = {}

    -- perks
    self.purchasedPerks = {}
    self.purchasedPerkIds = {}

    -- peds
    self.bodyPoints = {}
    self.spawnedEntities = {}
    self.unprocessedHeadshots = {}

    -- waves
    if data.hardMode then
        self.maxWave = svConfig.hardModeTotalWaves
    else
        self.maxWave = data.maxWaves or math.random(svConfig.minWaves, svConfig.maxWaves)
    end
    self.currentWave = 0

    -- horde config
    self.state = 'LOOTING'
    self.timeoutAt = os.time() + (60 * svConfig.mission.timeout)

    --- currency
    self.currentLoadout = 'horde_1'
    self.currencyAmount = 0

    -- stats
    self.kills = 0
    self.headshots = 0
    self.currencySpent = 0
    self.currencyEarned = 0
    self.itemsCollected = 0

    -- shop
    self.usedItemUUIDs = {}
    self.finalShopPurchasedItems = {}

    -- hard mode setup
    self.mutations = {}

    self:createAction('initialize')
    self:createAction('end')
end

function Game:start()
    self:applyGroupLimits()
    self:event('prp-horde:client:addEnterExitTargets', self.uniqueId, self.enterTargetCoords, self.exitTargetCoords)
end

function Game:setupLocation(playerId)
    TriggerClientEvent('prp-horde:client:setupLocation', playerId, self.uniqueId, self:getLocationSetupData())
end

function Game:cleanupLocation(playerId)
    TriggerClientEvent('prp-horde:client:cleanupLocation', playerId, self.uniqueId)
end

function Game:generateNewStashes()
    local coords = {}

    local allStashes = MySQL.query.await('SELECT * FROM horde_stashes WHERE interiorKey = ?', { self.interiorKey })

    for k, v in pairs(allStashes) do
        table.insert(coords, vector3(v.x + 0.0, v.y + 0.0, v.z + 0.0))
    end

    local chosenCoords = selectWellSpaced(coords, 9, 5.0, true)

    local stashes = {}

    for k, v in pairs(chosenCoords) do
        local id = lib.string.random('.........')

        local item = getRandomWeightedItem(svConfig.groundLootTable)

        local model = nil
        for _, itemData in pairs(svConfig.groundLootItems) do
            if itemData.id == item.itemId then
                model = itemData.animation.prop.hash
                break
            end
        end

        stashes[id] = {
            coords = v,
            itemId = item.itemId,
            model = model,
            picked = false,
        }
    end

    self.stashes = stashes

    self:insideEvent('prp-horde:client:setGroundLoot', self:getGroundLootClientData())
end

function Game:getGroundLootClientData()
    local data = {}

    for id, stash in pairs(self.stashes or {}) do
        if not stash.picked then
            data[id] = {
                coords = stash.coords,
                model = stash.model,
            }
        end
    end

    return data
end

function Game:stashesMoveHook()
end

function Game:sendStartingSMS()
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
    if not group then
        return
    end

    for _, member in pairs(group.getMembers()) do
        local playerId = bridge.fw.getSrcFromIdentifier(member.identifier)

        if playerId and DoesPlayerExist(playerId) then
            bridge.phone.sendMessage(playerId, svConfig.phoneNumberForMessage, locale('HORDE_START_SMS'))
        end
    end
end

function Game:cleanupStashes()
    self.stashes = {}

    self:insideEvent('prp-horde:client:removeGroundLoot')
end

function Game:generatePerkPool()
    local pool = {}

    local buffPerks = lib.table.deepclone(svConfig.buffs)

    for buffId, v in pairs(buffPerks) do
        if self.hardMode or v.hardMode ~= true then
            pool[#pool + 1] = {
                id = buffId,
                weight = v.weight,
                description = v.description,
                debuffs = v.debuffs,
                type = v.type,
                amount = v.amount,
            }
        end
    end

    return pool
end

function Game:startForcedPerkStage()
    self.state = 'PERK_VOTE'

    self.votingEndsAt = os.time() + svConfig.votingTime

    local numberOfPerks = 3

    if not self.buffPerkPool or (#self.buffPerkPool < numberOfPerks) then
        self.buffPerkPool = self:generatePerkPool()
    end

    local perkOptions = {}

    for i = 1, numberOfPerks do
        local buffPerk, index = getRandomWeightedItem(self.buffPerkPool)

        table.remove(self.buffPerkPool, index)

        local randomDebuff = getRandomWeightedItem(buffPerk.debuffs)

        local debuffPerk = getDebuffPerk(randomDebuff.id)

        local option = {
            id = lib.string.random('.........'),
            buff = {
                id = buffPerk.id,
                description = buffPerk.description,
                type = buffPerk.type,
                amount = buffPerk.amount,
            },
            debuff = {
                id = debuffPerk.id,
                description = debuffPerk.description,
                type = debuffPerk.type,
                amount = debuffPerk.amount,
            },
            votes = 0,
        }

        table.insert(perkOptions, option)
    end

    self.playersVoted = {}

    self.perkOptions = perkOptions

    self:insideEvent('prp-horde:client:showPerkVote', self.perkOptions, self:getPerkVotes(), self.currentWave,
        self.votingEndsAt)

    self:updateUI(locale('CHOOSE_PERKS'), self.votingEndsAt, true)
end

function Game:getPerkVotes()
    local votes = {}

    for k, v in pairs(self.perkOptions) do
        votes[v.id] = v.votes or 0
    end

    return votes
end

function Game:voteForPerk(playerId, optionId)
    if self.playersVoted[playerId] then
        return
    end

    self.playersVoted[playerId] = true

    for k, v in pairs(self.perkOptions) do
        if v.id == optionId then
            v.votes += 1
        end
    end

    self:insideEvent('prp-horde:client:updatePerkVote', self:getPerkVotes())

    self:shouldVotingEndEarly()
end

function Game:shouldVotingEndEarly()
    local totalVotes = 0
    local totalPlayers = 0

    for k, v in pairs(self.playersInside) do
        totalPlayers += 1
    end

    for k, v in pairs(self.perkOptions) do
        totalVotes += (v.votes or 0)
    end

    if totalVotes ~= totalPlayers then
        return
    end

    self.votingEndsAt = os.time() + 3

    self:insideEvent('prp-horde:client:winningPerk', self:getWinningPerk())

    self:updateUI(locale('CHOOSE_PERKS'), self.votingEndsAt, true)

    self:notifyInside({ title = locale('VOTING_END_EARLY') })
end

function Game:getLootingStageDuration()
    local time = svConfig.lootingTime

    for k, v in pairs(self.purchasedPerks) do
        if v.type == 'lootingExtend' then
            time = time + v.amount
        end
    end

    return time
end

function Game:startLootingStage()
    self:cleanupStashes()
    self:generateNewStashes()

    local timeNow = os.time()

    self.state = 'LOOTING'
    self.lootingEndsAt = os.time() + self:getLootingStageDuration()

    self:notifyInside({ title = locale('LOOTING_STARTED') })

    self:updateUI(locale('LOOTING_PHASE'), self.lootingEndsAt, true)
end

function Game:getMainInventoryId()
    if not self.inventoryId then
        self.inventoryId = bridge.inv.createTemporaryStash({
            label = locale('CHEST'),
            slots = 300,
            maxWeight = 1500,
            items = {},
        })

        self.inventoryHookId = bridge.inv.registerSwapItemsHook(function(payload)
            if payload.action ~= 'move' then
                return false
            end

            if self.state ~= 'LOOTING' then
                return false
            end

            if payload.fromInventory ~= self.inventoryId then
                local itemName = payload.toSlot.name
                local itemUUID = payload.toSlot.metadata?.uuid
                SetTimeout(0, function()
                    if not self then return end

                    if not svConfig.groundItemCurrency[itemName] then
                        return
                    end

                    if not itemUUID then
                        return
                    end

                    if self.usedItemUUIDs[itemUUID] then
                        return
                    end

                    self.usedItemUUIDs[itemUUID] = true

                    self:addCurrency(svConfig.groundItemCurrency[itemName])
                end)

                return true
            else
                return false
            end
        end, {
            inventoryFilter = {
                self.inventoryId,
            }
        })
    end

    return self.inventoryId
end

function Game:openMainInventory(playerId)
    if self.state ~= 'LOOTING' then
        bridge.fw.notify(playerId, 'error', locale('ONLY_LOOTING_STAGE'))
        return
    end

    bridge.inv.openStash(playerId, self:getMainInventoryId())
end

function Game:shopUpdated()
    self:insideEvent('prp-horde:client:currencyShopUpdated', {
        currencyAmount = self.currencyAmount,
        perks = self:getShopPerks(),
        shop = self:getShopItems(),
    })
end

function Game:getActivePerkIds()
    local ids = {}

    for k, v in pairs(self.purchasedPerkIds) do
        table.insert(ids, k)
    end

    table.sort(ids)

    return ids
end

function Game:perksUpdated()
    self:insideEvent('prp-horde:client:updateBuffIds', {
        buffIds = self:getActivePerkIds(),
    })
end

------------------------------------------------------------------------------PERKS
function Game:regenerateShopPerks()
    local perks = {}

    local perkPool = {}

    local allPerks = lib.table.deepclone(svConfig.shopPerks)

    for perkId, v in pairs(allPerks) do
        if not self.purchasedPerkIds[perkId] or v.allowMultiple then
            v.itemId = perkId
            table.insert(perkPool, v)
        end
    end

    for i = 1, 3 do
        if #perkPool == 0 then
            break
        end

        local id = lib.string.random('.........')

        self:createAction(('purchaseItem%s'):format(id))

        local item, index = getRandomWeightedItem(perkPool)

        table.remove(perkPool, index)

        table.insert(perks, {
            id = id,
            itemId = item.itemId,
            description = item.description,
            price = item.price,
            owned = false,
        })
    end

    self.shopPerks = {
        rerollCost = 200,
        items = perks,
    }
end

function Game:getShopPerks()
    if not self.shopPerks then
        self:regenerateShopPerks()
    end

    return self.shopPerks
end

function Game:buyPerksRegeneration(playerId, sectionId)
    if self.currencyAmount < self.shopPerks.rerollCost then
        self:notifyInside({ title = locale('NO_CURRENCY'), duration = 1000 })
        return
    end

    self:removeCurrency(self.shopPerks.rerollCost)

    self:regenerateShopPerks()

    self:shopUpdated()
end

------------------------------------------------------------------------------SHOP

function Game:generateShopSection(config, count)
    local items = {}
    for i = 1, count or 3 do
        local id = lib.string.random('.........')
        self:createAction(('purchaseItem%s'):format(id))
        local entry = getRandomWeightedItem(config)
        local entryData = getItem(entry.itemId)

        local rarity = entryData.rarity or 'COMMON'

        if entry.metaData and entry.metaData.rarity then
            rarity = entry.metaData.rarity
        end

        table.insert(items, {
            id = id,
            itemId = entry.itemId,
            name = entry.itemId,
            amount = entry.amount,
            label = entryData.label or 'Unknown',
            rarity = rarity,
            price = entry.price,
            metaData = entry.metaData,
        })
    end
    return items
end

function Game:generateShopItems()
    local itemPool = self.hardMode and svConfig.hardShopItems or svConfig.shopItems
    local weaponPool = self.hardMode and svConfig.hardShopWeapons or svConfig.shopWeapons

    self.shopItems = {
        weapons = {
            rerollCost = 200,
            items = self:generateShopSection(weaponPool, 3),
        },
        items = {
            rerollCost = 200,
            items = self:generateShopSection(itemPool, 6),
        },
    }
end

function Game:regenerateShopWeapons()
    local weaponPool = self.hardMode and svConfig.hardShopWeapons or svConfig.shopWeapons
    self.shopItems.weapons.items = self:generateShopSection(weaponPool, 3)
end

function Game:regenerateShopItems()
    local itemPool = self.hardMode and svConfig.hardShopItems or svConfig.shopItems
    self.shopItems.items.items = self:generateShopSection(itemPool, 6)
end

function Game:buyShopRegeneration(playerId, sectionId)
    local section = nil

    for k, v in pairs(self.shopItems) do
        if k == sectionId then
            section = v
            break
        end
    end

    if not section then
        return
    end

    if self.currencyAmount < section.rerollCost then
        self:notifyInside({ title = locale('NO_CURRENCY'), duration = 1000 })
        return
    end

    self:removeCurrency(section.rerollCost)

    if sectionId == 'weapons' then
        self:regenerateShopWeapons()
    elseif sectionId == 'items' then
        self:regenerateShopItems()
    end

    self:shopUpdated()
end

function Game:getShopItems()
    if not self.shopItems then
        self:generateShopItems()
    end

    return self.shopItems
end

function Game:openCurrencyShop(playerId)
    if self.state ~= 'LOOTING' then
        bridge.fw.notify(playerId, 'error', locale('ONLY_LOOTING_STAGE'))
        return
    end

    TriggerClientEvent('prp-horde:client:openCurrencyShop', playerId, {
        currencyAmount = self.currencyAmount,
        perks = self:getShopPerks(),
        shop = self:getShopItems(),
    })
end

function Game:getShopItem(itemId)
    if self.shopItems then
        for k, v in pairs(self.shopItems.weapons.items or {}) do
            if v.id == itemId then
                return v, 'weapons'
            end
        end

        for k, v in pairs(self.shopItems.items.items or {}) do
            if v.id == itemId then
                return v, 'items'
            end
        end
    end

    if self.shopPerks then
        for k, v in pairs(self.shopPerks.items or {}) do
            if v.id == itemId then
                return v, 'perks'
            end
        end
    end

    if self.finalShop then
        for k, v in pairs(self.finalShop.items or {}) do
            if v.id == itemId then
                return v, 'finalShop'
            end
        end
    end
end

------------------------------------------------------------------------------FINAL SHOP
function Game:regenerateFinalShopItems()
    local items = {}

    local itemPool = self.hardMode and svConfig.hardShopFinalItems or svConfig.shopFinalItems

    local itemCount = self.hardMode and svConfig.hardFinalShopItemCount or svConfig.finalShopItemCount

    for i = 1, itemCount do
        local id = lib.string.random('.........')

        self:createAction(('purchaseItem%s'):format(id))

        local item = getRandomWeightedItem(itemPool)

        local metaData = item.metaData

        if string.lower(item.itemId):match('weapon_') then
            if not metaData then
                metaData = {}
            end

            metaData.scratchedSerial = true
        end

        local itemData = getItem(item.itemId)

        local itemLabel = itemData.label or 'Unknown'

        if metaData and metaData.label then
            itemLabel = metaData.label
        end

        table.insert(items, {
            id = id,
            itemId = item.itemId,
            name = item.itemId,
            amount = item.amount,
            label = itemLabel,
            price = item.price,
            metaData = metaData,
        })
    end

    self.finalShop = {
        items = items,
        boughtItems = self.finalShopPurchasedItems,
        rerollCost = 200,
    }
end

function Game:getFinalShop()
    if not self.finalShop then
        self:regenerateFinalShopItems()
    end

    return self.finalShop
end

function Game:openFinalShop(playerId)
    TriggerClientEvent('prp-horde:client:openFinalShop', playerId, {
        currencyAmount = self.currencyAmount,
        finalShop = self:getFinalShop(),
        stats = self:getStats(),
        timeoutAt = self.timeoutAt,
    })
end

function Game:getStats()
    return {
        kills = self.kills,
        headshots = self.headshots,
        currencySpent = self.currencySpent,
        currencyEarned = self.currencyEarned,
    }
end

function Game:buyFinalShopRegeneration(playerId)
    if self.currencyAmount < self.finalShop.rerollCost then
        self:notifyInside({ title = locale('NO_CURRENCY'), duration = 1000 })
        return
    end

    self:removeCurrency(self.finalShop.rerollCost)

    self:regenerateFinalShopItems()

    self:finalShopUpdated()
end

function Game:addFinalShopPurchasedItem(item)
    if not item or not item.itemId then
        return
    end

    local itemAdded = false

    if not item.metaData then
        for k, v in pairs(self.finalShopPurchasedItems or {}) do
            if v.itemId == item.itemId then
                itemAdded = true
                v.amount += (item.amount or 1)
                break
            end
        end
    end

    if not item.amount then
        item.amount = 1
    end

    if not itemAdded then
        table.insert(self.finalShopPurchasedItems, item)
    end
end

function Game:finalShopUpdated(playerId)
    self:insideEvent('prp-horde:client:finalShopUpdated', {
        currencyAmount = self.currencyAmount,
        finalShop = self:getFinalShop(),
    })
end

function Game:addCurrency(baseAmount)
    local net = 0

    if self.activePerk and self.activePerk.buff and self.activePerk.buff.type == 'currencyIncrease' then
        net = net + self.activePerk.buff.amount
    end

    for k, v in pairs(self.purchasedPerks) do
        if v.type == 'currencyIncrease' then
            net = net + v.amount
        end
    end

    local finalAmount = baseAmount * (1 + net / 100)

    self.currencyAmount = math.floor(self.currencyAmount + finalAmount)

    self.currencyEarned += math.floor(finalAmount)

    self:insideEvent('prp-horde:client:setCurrency', self.currencyAmount)
end

function Game:removeCurrency(amount)
    if amount > self.currencyAmount then
        return
    end

    self.currencyAmount = self.currencyAmount - amount

    self.currencySpent += amount

    return self.currencyAmount > 0
end

function Game:getPedHealth(baseHealth)
    local net = self:getPerkNetValue('pedHealthIncrease')

    local health = increaseNumberByPercent(baseHealth, net)

    if self.mutations.juggernaut then
        health += self.mutations.juggernaut.health
    end

    return health
end

function Game:getPedArmor(baseArmor)
    local net = self:getPerkNetValue('pedArmorIncrease')

    local armor = increaseNumberByPercent(baseArmor, net)

    if self.mutations.juggernaut then
        armor += self.mutations.juggernaut.armor
    end

    return armor
end

function Game:getPedAccuracy(baseAccuracy)
    local accuracy = baseAccuracy

    if self.mutations.increasedAccuracy then
        accuracy += self.mutations.increasedAccuracy.amount
    end

    return accuracy
end

function Game:getPedDamageModifier()
    local net = self:getPerkNetValue('pedDamageIncrease')

    if self.hardMode then
        net += svConfig.hardDamagePercentIncrease
    end

    return increaseFloatByPercent(0.33, net)
end

function Game:getPlayerDamageModifier()
    local net = 0

    if self.activePerk and self.activePerk.buff and self.activePerk.buff.type == 'outgoingDamageIncrease' then
        net = net + self.activePerk.buff.amount
    end

    if self.activePerk and self.activePerk.debuff and self.activePerk.debuff.type == 'outgoingDamageDecrease' then
        net = net - self.activePerk.debuff.amount
    end

    for k, v in pairs(self.purchasedPerks) do
        if v.type == 'outgoingDamageIncrease' then
            net = net + v.amount
        end
    end

    if net == 0 then
        return 1.0
    end

    local damageMultiplier = 1 + net / 100

    if damageMultiplier <= 0 then
        return 0.1
    end

    damageMultiplier = math.floor(damageMultiplier * 100) / 100

    return damageMultiplier + 0.0
end

function Game:getPlayerDefenseModifier()
    local decreaseNet = self:getPerkNetValue('incomingDamageDecrease')

    local increaseNet = self:getPerkNetValue('incomingDamageIncrease')

    local net = decreaseNet - increaseNet

    return (1 - (net / 100))
end

function Game:getPlayerMaxHealth()
    local decreaseNet = self:getPerkNetValue('maxHealthDecrease')
    return reduceNumberByPercent(100, decreaseNet) + 100
end

function Game:handleShopPerkPurchased(perkId)
    local perk = getShopPerk(perkId)

    if not perk then
        return
    end

    perk.perkId = perkId

    self.purchasedPerkIds[perkId] = true

    table.insert(self.purchasedPerks, perk)

    if self.state == 'LOOTING' and perkId == 'lootingExtend' then
        self.lootingEndsAt = self.lootingEndsAt + perk.amount
        self:updateUI(locale('LOOTING_PHASE'), self.lootingEndsAt, true)
    end
end

function Game:purchaseItem(playerId, itemId)
    local item, regenerateKey = self:getShopItem(itemId)

    if not item then
        return
    end

    if self.currencyAmount < item.price then
        self:notifyInside({ title = locale('NO_CURRENCY'), duration = 1000 })
        return
    end

    if not self:performAction(('purchaseItem%s'):format(item.id)) then
        return
    end

    self:removeCurrency(item.price)

    if regenerateKey == 'weapons' then
        self:regenerateShopWeapons()
    elseif regenerateKey == 'items' then
        self:regenerateShopItems()
    elseif regenerateKey == 'perks' then
        self:handleShopPerkPurchased(item.itemId)
        self:regenerateShopPerks()
        self:perksUpdated()
    elseif regenerateKey == 'finalShop' then
        self:regenerateFinalShopItems()
    end

    self:notifyInside({ title = locale('ITEM_PURCHASED', item.label or item.description) })

    if regenerateKey == 'finalShop' then
        self:addFinalShopPurchasedItem(item)
        self:finalShopUpdated()
        return
    end

    if regenerateKey ~= 'perks' and item.itemId then
        local metaData = lib.table.deepclone(item.metaData or {})
        metaData.fromInventoryLoadout = true
        bridge.inv.giveItem(playerId, item.itemId, item.amount or 1, metaData)
    end

    self:shopUpdated()
end

function Game:revivePlayer(playerId, targetPlayerId)
    if self.mutations.noRevives then
        bridge.fw.notify(playerId, 'error', locale('REVIVING_IS_DISABLED'))
        return
    end

    local playerState = Player(targetPlayerId).state

    if not playerState.isDead then
        return
    end

    if self.hardMode and self.revivesLeft < 1 then
        bridge.fw.notify(playerId, 'error', locale('NO_REVIVES_LEFT'))
        return
    end

    if self.hardMode and self.revivePrice > self.currencyAmount then
        bridge.fw.notify(playerId, 'error', locale('REVIVAL_NOT_ENOUGH_CURRENCY', self.revivePrice))
        return
    end

    local finished = lib.callback.await('prp-bridge:progress', playerId, {
        label = locale('REVIVING'),
        duration = 5000,
        canCancel = true,
        disarm = false,
        controlDisables = { disableMovement = true },
        animation = { animDict = 'missheistfbi3b_ig8_2', animClip = 'cpr_loop_paramedic', animFlag = 1 },
    })

    if not finished then
        return
    end

    if self.hardMode and not self:removeCurrency(self.revivePrice) then
        bridge.fw.notify(playerId, 'error', locale('REVIVAL_NOT_ENOUGH_CURRENCY', self.revivePrice))
        return
    end

    if self.hardMode then
        self.revivesLeft -= 1
        local revivalWord = self.revivesLeft == 1 and locale('REVIVAL') or locale('REVIVALS')
        bridge.fw.notify(playerId, 'inform', locale('REVIVALS_LEFT', self.revivesLeft, revivalWord))
    end

    local removed = bridge.inv.removeItem(playerId, svConfig.reviveItem, 1)

    if not removed then
        return
    end

    bridge.medical.healPlayer(targetPlayerId, 100)

    bridge.fw.notify(playerId, 'success', locale('REVIVAL_SUCCESS'))
    bridge.fw.notify(targetPlayerId, 'inform', locale('YOU_HAVE_BEEN_REVIVED'))
end

function Game:initialize()
    if not self:performAction('initialize') then
        return
    end

    self.initialized = true

    self:startLootingStage()
end

function Game:applyGroupLimits()
    -- exports['prp-groups']:setGroupLocked(self.groupId, true)

    -- exports['prp-groups']:setGroupMaxMembers(self.groupId, svConfig.mission.maximumGroupSize)

    -- local stateIds = exports['prp-groups']:getGroupStateIds(self.groupId)

    -- for k, v in pairs(stateIds or {}) do
    --     self.involvedStateIds[v] = true
    --     exports['prp-groups']:setGroupCreationDisabled(v, true)
    -- end
end

function Game:resetGroupLimits()
    -- exports['prp-groups']:setGroupLocked(self.groupId, false)

    -- exports['prp-groups']:resetGroupMaxMembers(self.groupId)

    -- for stateId, v in pairs(self.involvedStateIds or {}) do
    --     exports['prp-groups']:setGroupCreationDisabled(stateId, false)
    -- end

    -- self.involvedStateIds = {}
end

function Game:endByPlayer(playerId)
    if self.state ~= 'LOOTING' then
        bridge.fw.notify(playerId, 'error', locale('GAME_ENDABLE_ONLY_IN_LOOTING'))
        return
    end

    if not self:performAction('end') then
        return
    end

    self.finished = true

    self.timeoutAt = os.time() + 60

    self:updateUI(locale('GAME_ENDS_IN'), self.timeoutAt, true)
    self:notifyInside({ title = locale('GAME_ENDS_IN_60_SECONDS'), duration = 6000 })

    for loopPlayerId, v in pairs(self.playersInside) do
        self:openFinalShop(loopPlayerId)
    end
end

function Game:endLootingPhase(playerId)
    if self.state ~= 'LOOTING' then
        bridge.fw.notify(playerId, 'error', locale('ONLY_LOOTING_STAGE'))
        return
    end

    local untilEnd = self.lootingEndsAt - os.time()

    if untilEnd < 5 then
        return
    end

    self.lootingEndsAt = os.time() + 3
    self:notifyInside({ title = locale('ROUND_START', self.currentWave + 1), duration = 3000 })

    self:updateUI(locale('LOOTING_PHASE'), self.lootingEndsAt, true)
end

function Game:applyLoadout(playerId)
    pcall(function()
        lib.print.debug('Applying loadout for player:', playerId)
        lib.print.debug('Loadout:', svConfig.loadout)
        bridge.inv.giveLoadoutItems(playerId, svConfig.loadout, svConfig.excludeLoadoutItems)
    end)
end

function Game:resetLoadout(playerId)
    pcall(function()
        lib.print.debug('Resetting loadout for player:', playerId)
        bridge.inv.returnItems(playerId, svConfig.loadout)
    end)
end

function Game:enter(playerId)
    if self.playersEntered[playerId] then
        bridge.fw.notify(playerId, 'error', locale('HORDE_MISSION_ENTER_ERROR'))
        return
    end

    self.playersEntered[playerId] = true

    if self.failed or self.finished then
        bridge.fw.notify(playerId, 'error', locale('GAME_FINISHED'))
        return
    end

    if not self.initialized then
        self:initialize()
    end

    self.playersInside[playerId] = true

    PLAYERS_INSIDE_GAMES[playerId] = self.uniqueId

    bridge.log.send(config.logWebhook, "Horde Entered", "A player entered a horde game.", {
        game_id = self.uniqueId,
        character_id = bridge.fw.getIdentifier(playerId),
        player_name = GetPlayerName(playerId),
        interior = self.interiorKey,
    })

    SetPlayerRoutingBucket(playerId, self.bucketId)
    Player(playerId).state.currentRoute = self.bucketId
    Player(playerId).state.isInHorde = true

    local v4 = vector4(self.insideCoords.x, self.insideCoords.y, self.insideCoords.z, self.insideCoords.w)
    TriggerClientEvent('prp-horde:client:teleport', playerId, v4)

    local entryTitle = locale('HORDE_ENTRY_TITLE_DEFAULT')

    local entryDescription = {
        ['default'] = locale('HORDE_ENTRY_DESCRIPTION'),
        ['hard'] = locale('HORDE_ENTRY_DESCRIPTION_HARD')
    }

    TriggerClientEvent('prp-horde:client:sendNotification', playerId, {
        type = 'info',
        title = entryTitle[self.interiorKey or 'default'],
        description = self.hardMode and entryDescription['hard'] or entryDescription['default'],
        duration = 8000,
    })

    if self.state == 'LOOTING' then
        self:sendUIEvent(playerId, locale('LOOTING_PHASE'), self.lootingEndsAt, true)
    elseif self.state == 'KILLING' then
        self:sendUIEvent(playerId, locale('GUARDS_REMAINING'), self.guardsLeft)
    elseif self.state == 'PERK_VOTE' then
        self:sendUIEvent(playerId, locale('CHOOSE_PERKS'), self.votingEndsAt, true)
    end

    self:savePlayerData(playerId)

    Wait(0)

    self:setupLocation(playerId)

    Wait(0)

    self:applyLoadout(playerId)
end

function Game:exit(playerId)
    self.playersInside[playerId] = nil

    PLAYERS_INSIDE_GAMES[playerId] = nil

    bridge.log.send(config.logWebhook, "Horde Left", "A player left a horde game.", {
        game_id = self.uniqueId,
        character_id = bridge.fw.getIdentifier(playerId),
        player_name = GetPlayerName(playerId),
        interior = self.interiorKey,
    })

    local v4 = vector4(self.outsideCoords.x, self.outsideCoords.y, self.outsideCoords.z, self.outsideCoords.w)
    TriggerClientEvent('prp-horde:client:teleport', playerId, v4)

    SetPlayerRoutingBucket(playerId, 0)
    Player(playerId).state.currentRoute = 0
    Player(playerId).state.isInHorde = nil

    self:resetLoadout(playerId)

    Wait(0)

    self:cleanupLocation(playerId)

    Wait(0)

    self:returnPlayerSavedData(playerId)

    Wait(0)

    self:shouldGameEndEarly()

    bridge.medical.healPlayer(playerId, 100)

    bridge.fw.notify(playerId, 'info', locale('ITEMS_CAN_RETREIVED_FROM_STORAGE'))
end

function Game:shouldGameEndEarly()
    if self.finished then
        return
    end

    local playersInside = 0

    for playerId, v in pairs(self.playersInside) do
        playersInside += 1
        break
    end

    if playersInside > 0 then
        return
    end

    self:performAction('end')

    self.finished = true

    self.timeoutAt = os.time() + 10

    self:event('prp-bridge:notify', 'info', locale('ALL_PLAYERS_LEFT'))
end

function Game:groupDisbanded()
    if self.finished then
        return
    end

    self.finished = true

    self:performAction('end')

    self.timeoutAt = os.time() + 10

    for playerId, _ in pairs(self.playersInside) do
        bridge.fw.notify(playerId, 'info', locale('GROUP_DISBANDED'))
    end

    TriggerClientEvent('prp-horde:client:removeEntranceTarget', -1, self.uniqueId)

    self:exitAllPlayers()
end

function Game:savePlayerData(playerId)
    local ped = GetPlayerPed(playerId)

    if not DoesEntityExist(ped) then
        return
    end

    local statuses = lib.callback.await('prp-horde:client:getStatuses', playerId)

    self.playersSavedData[playerId] = {
        stateId = bridge.fw.getIdentifier(playerId),
        health = GetEntityHealth(ped),
        armor = GetPedArmour(ped),
        coords = GetEntityCoords(ped),
        stress = statuses and statuses.stress or 0,
        hunger = statuses and statuses.hunger or 100,
        thirst = statuses and statuses.thirst or 100,
    }

    Wait(0)

    local payload = {
        health = {
            type = "set",
            value = 200
        },
        armor = {
            type = "set",
            value = 0
        },
        stress = {
            type = "set",
            value = 0
        },
        hunger = {
            type = "set",
            value = 100
        },
        thirst = {
            type = "set",
            value = 100
        },
    }

    TriggerClientEvent('prp-horde:client:setPedData', playerId, payload)
end

function Game:returnPlayerSavedData(playerId)
    if not self.playersSavedData[playerId] then
        return
    end

    local data = self.playersSavedData[playerId]

    local payload = {
        health = {
            type = "set",
            value = data.health
        },
        armor = {
            type = "set",
            value = data.armor
        },
        stress = {
            type = "set",
            value = data.stress
        },
        hunger = {
            type = "set",
            value = data.hunger
        },
        thirst = {
            type = "set",
            value = data.thirst
        },
    }
    TriggerClientEvent('prp-horde:client:setPedData', playerId, payload)
end

function Game:exitAllPlayers()
    for playerId, _ in pairs(self.playersInside) do
        self:exit(playerId)
    end
end

function Game:spawnPed(playerId, coords, data)
    data.coords = coords

    local netId = lib.callback.await('prp-horde:client:spawnPed', playerId, data)

    local entityId = NetworkGetEntityFromNetworkId(netId)

    local timeout = 10
    while entityId == 0 and timeout > 0 do
        timeout -= 1
        entityId = NetworkGetEntityFromNetworkId(netId)
        Wait(100)
    end

    table.insert(self.spawnedEntities, {
        entityId = entityId,
        isBoss = data.isBoss,
        isElite = data.isElite,
    })

    Entity(entityId).state.cantOfferDrugs = true

    if data.isBoss then
        Entity(entityId).state.hordeBoss = netId
    end
end

function Game:pedHeadshotted(playerId, netId)
    local entity = NetworkGetEntityFromNetworkId(netId)

    if not entity or not DoesEntityExist(entity) then
        return
    end

    if not self.unprocessedHeadshots then
        self.unprocessedHeadshots = {}
    end

    for k, v in pairs(self.spawnedEntities or {}) do
        if v.entityId == entity then
            self.unprocessedHeadshots[entity] = playerId
        end
    end
end

function Game:getLocationSetupData()
    local data = {
        chest = {
            coords = self.chestCoords,
            rotation = self.chestRotation,
            model = self.chestModel,
        },
        shop = {
            coords = self.shopCoords,
            rotation = self.shopRotation,
            model = self.shopModel,
            currencyAmount = self.currencyAmount,
        },
        bodyPoints = self.bodyPoints,
        buffIds = self:getActivePerkIds(),
        cratePoints = self.cratePoints or {},
        damagePoints = self.damagePoints or {},
        hardMode = self.hardMode,
        groundLoot = self:getGroundLootClientData(),
        reviveItem = svConfig.reviveItem,
    }

    return data
end

function Game:notifyInside(data)
    for playerId, v in pairs(self.playersInside) do
        TriggerClientEvent('prp-horde:client:sendNotification', playerId, {
            type = data.type or 'info',
            title = '',
            description = data.title or '',
            duration = data.duration or 3000,
        })
    end
end

function Game:tick()
    local timeNow = os.time()

    if self.timeoutAt and timeNow > self.timeoutAt then
        if not self.finished then
            self:notifyInside({ title = locale('OUT_OF_TIME'), duration = 7500 })
        end
        self:finish()
        return
    end

    if self.failed or self.finished then
        return
    end

    if self.state == 'LOOTING' then
        self:lootWaveTick(timeNow)
    elseif self.state == 'KILLING' then
        self:killWaveTick(timeNow)
    elseif self.state == 'PERK_VOTE' then
        self:perkVoteTick(timeNow)
    end
end

function Game:lootWaveTick(timeNow)
    if not self.lootingEndsAt then
        return
    end

    if self.lootingEndsAt > timeNow then
        return
    end

    self:cleanupStashes()
    self:setWave(self.currentWave + 1)
end

function Game:perkVoteTick(timeNow)
    if not self.votingEndsAt then
        return
    end

    if self.votingEndsAt > timeNow then
        return
    end

    local chosenPerk = nil

    for k, v in pairs(self.perkOptions) do
        if not chosenPerk then
            chosenPerk = v
        end

        if (v.votes or 0) > (chosenPerk.votes or 0) then
            chosenPerk = v
        end
    end

    self.activePerk = chosenPerk

    self:insideEvent('prp-horde:client:hidePerkVote', chosenPerk)

    self:startLootingStage()

    self:degradeTemporaryPerks()

    self:perksUpdated()
end

function Game:degradeTemporaryPerks()
    for k, v in pairs(self.purchasedPerks) do
        if v.roundsActive then
            v.roundsActive = v.roundsActive - 1

            if v.roundsActive <= 0 then
                self.purchasedPerks[k] = nil
                self.purchasedPerkIds[v.perkId] = nil
            end
        end
    end
end

function Game:getWinningPerk()
    local chosenPerk = nil

    for k, v in pairs(self.perkOptions) do
        if not chosenPerk then
            chosenPerk = v
        end

        if (v.votes or 0) > (chosenPerk.votes or 0) then
            chosenPerk = v
        end
    end

    return chosenPerk
end

function Game:getNPCSpawns()
    local spawns = {}

    local result = MySQL.query.await('SELECT * FROM horde_spawns WHERE interiorKey = ? ORDER BY RAND()',
        { self.interiorKey })

    for k, v in pairs(result) do
        table.insert(spawns, vector4(v.x + 0.0, v.y + 0.0, v.z + 0.0, v.w + 0.0))
    end

    return spawns
end

function Game:announceRound()
    if not self.soundPrefix then
        return
    end
end

function Game:getNumberOfGuards(baseAmount, totalSpawns)
    local net = 0

    for k, v in pairs(self.purchasedPerks) do
        if v.type == 'lessGuards' then
            net = net - v.amount
        end
    end

    local finalAmount = baseAmount * (1 + net / 100)

    if self.mutations.meleeZombies then
        finalAmount = finalAmount * 2
    end

    finalAmount = math.ceil(finalAmount)

    return math.min(finalAmount, totalSpawns)
end

function Game:setWave(nextWave)
    self.pedsAreDead = false

    local playerPositions = self:getPlayerPositions()

    local spawnsCovered = true

    local spawnPlayerIdMap = {}

    local wave = self:getWave(nextWave)

    local allSpawns = self:getNPCSpawns()

    local guardCount = self:getNumberOfGuards(wave.numberOfPeds or 1, #allSpawns)

    self.guardsLeft = guardCount

    local spawns = selectWellSpaced(allSpawns, guardCount, 5.0, true)

    for k, v in pairs(spawns) do
        local coordsV3 = vector3(v.x, v.y, v.z)
        local playerId, coords = self:getClosestPlayerToCoords(playerPositions, coordsV3)

        if not playerId then
            lib.print.debug('[^2PRP-HORDE^0] failed to find spawn for coords', coordsV3)
            spawnsCovered = false
            break
        end

        spawnPlayerIdMap[k] = { playerId = playerId, coords = coords }
    end

    if not spawnsCovered then
        lib.print.debug('[PRP-HORDE] spawns are not covered, cant spawn peds...')
        return
    end

    self.currentWave = nextWave

    self:announceRound()

    self:removeBodyPoints()

    local pedHealth = self:getPedHealth(wave.health)
    local pedArmor = self:getPedArmor(wave.armor)

    local modelPool = self.pedModels

    if svConfig.halloween then
        modelPool = svConfig.halloweenPedModels
    end

    for k, v in pairs(spawns) do
        local weapon = getRandomWeightedItem(wave.weapons or {})

        local chosen = spawnPlayerIdMap[k]

        local netId = self:spawnPed(chosen.playerId, v, {
            model = modelPool[math.random(#modelPool)],
            health = pedHealth,
            armor = pedArmor,
            accuracy = wave.accuracy,
            weaponHash = weapon and weapon.hash or nil,
            targetCoords = chosen.coords,
        })
    end

    local perksData = self:getPerksData()

    if perksData.extraArmorPlates and perksData.extraArmorPlates > 0 then
        for playerId, v in pairs(self.playersInside) do
            if playerId and DoesPlayerExist(playerId) then
                bridge.inv.addItem(playerId, svConfig.armorPlateItem, perksData.extraArmorPlates, {
                    fromInventoryLoadout = true,
                })
            end
        end
    end

    if wave.stress and wave.stress > 0 then
        perksData.stress = wave.stress
    end

    self:insideEvent('prp-horde:client:perkSetup', perksData)

    self.unprocessedHeadshots = {}

    self.killingStartedAt = os.time()

    self.state = 'KILLING'

    self:notifyInside({ title = locale('ELIMINATE_GUARDS'), duration = 3000 })

    self:updateUI(locale('GUARDS_REMAINING'), guardCount)
end

function Game:sendUIEvent(playerId, ...)
    TriggerClientEvent('prp-horde:client:updateUI', playerId, self.currentWave, self.maxWave, self.currencyAmount, ...)
end

function Game:updateUI(title, value, isTimer)
    for playerId, v in pairs(self.playersInside) do
        self:sendUIEvent(playerId, title, value, isTimer)
    end
end

function Game:getActivePerkData()
    local perks = {}

    if self.activePerk and self.activePerk.buff then
        if not perks[self.activePerk.buff.type] then
            perks[self.activePerk.buff.type] = 0
        end

        perks[self.activePerk.buff.type] += self.activePerk.buff.amount or 1
    end

    if self.activePerk and self.activePerk.debuff then
        if not perks[self.activePerk.debuff.type] then
            perks[self.activePerk.debuff.type] = 0
        end

        perks[self.activePerk.debuff.type] += self.activePerk.debuff.amount or 1
    end

    return perks
end

function Game:getPerksData()
    local perks = {}

    perks.damageModifier = self:getPlayerDamageModifier()

    perks.defenseModifier = self:getPlayerDefenseModifier()

    perks.maxHealth = self:getPlayerMaxHealth()

    perks.movementSpeed = self:getBuffValue('movementSpeed')

    perks.oneHealth = self:getDebuffValue('oneHealth')

    perks.noSprintJump = self:getDebuffValue('noSprintJump')

    perks.unlimitedSprint = self:getDebuffValue('unlimitedSprint')

    perks.heal = self:getPurchasedPerkAmount('roundHeal')

    perks.extraArmorPlates = self:getPurchasedPerkAmount('roundArmor')

    perks.pedDamageModifier = self:getPedDamageModifier()

    perks.blackout = (self.mutations.blackout ~= nil)

    perks.hardMode = self.hardMode

    return perks
end

function Game:getPurchasedPerkAmount(perkType)
    local net = 0

    for k, v in pairs(self.purchasedPerks) do
        if v.type == perkType then
            net = net + (v.amount or 1)
        end
    end

    return net
end

function Game:getPerkNetValue(perkType)
    local net = 0

    if self.activePerk and self.activePerk.buff and self.activePerk.buff.type == perkType then
        net = net + (self.activePerk.buff.amount or 1)
    end

    if self.activePerk and self.activePerk.debuff and self.activePerk.debuff.type == perkType then
        net = net + (self.activePerk.debuff.amount or 1)
    end

    for k, v in pairs(self.purchasedPerks) do
        if v.type == perkType then
            net = net + v.amount
        end
    end

    return net
end

function Game:getDebuffValue(perkType)
    if not self.activePerk or not self.activePerk.debuff then
        return
    end

    if self.activePerk.debuff.type ~= perkType then
        return
    end

    return self.activePerk.debuff.amount or true
end

function Game:getBuffValue(perkType)
    if not self.activePerk or not self.activePerk.buff then
        return
    end

    if self.activePerk.buff.type ~= perkType then
        return
    end

    return self.activePerk.buff.amount or true
end

function Game:killWaveTick(timeNow)
    local pedsAreDead = self:getWavePedsAreDead(timeNow)

    if not self.pedsAreDead then
        return
    end

    local wave = self:getCurrentWave()

    if self.currentWave == self.maxWave then
        self.finished = true

        self.state = 'FINISHED'

        self.timeoutAt = os.time() + 60

        self:updateUI(locale('GAME_ENDS_IN'), self.timeoutAt, true)
        self:notifyInside({ title = locale('GAME_END_COMPLETED'), duration = 6000 })

        for playerId, v in pairs(self.playersInside) do
            self:openFinalShop(playerId)
        end

        self:incrementCrimeBoardTasks()

        return
    end

    self:insideEvent('prp-horde:client:perkReset')

    self:startForcedPerkStage()

    self:incrementCrimeBoardTasks()
end

function Game:incrementCrimeBoardTasks()
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)

    for _, member in pairs(group.getMembers()) do
        waveCompleted(member.identifier, self.currentWave)
    end
end

function Game:rewardHeadshot()
    local baseAmount = svConfig.currencyPerHeadshot

    local multiplier = 1.0

    if self.activePerk and self.activePerk.buff and self.activePerk.buff.type == 'headshotCurrencyBoost' then
        multiplier = 1 + (self.activePerk.buff.amount / 100)
    end

    if self.activePerk and self.activePerk.buff and self.activePerk.buff.type == 'killCurrencyIncrease' then
        multiplier = 1 + (self.activePerk.buff.amount / 100)
    end

    local amount = math.floor(baseAmount * multiplier)

    self:addCurrency(amount)

    self.headshots += 1
end

function Game:rewardKill(data)
    local baseAmount = svConfig.currencyPerKill

    if data.isBoss then
        baseAmount = svConfig.boss.killReward
    end

    if data.isElite then
        baseAmount = svConfig.elite.killReward
    end

    local multiplier = 1.0

    if self.activePerk and self.activePerk.buff and self.activePerk.buff.type == 'killCurrencyIncrease' then
        multiplier = 1 + (self.activePerk.buff.amount / 100)
    end

    local amount = math.floor(baseAmount * multiplier)

    self:addCurrency(amount)

    self.kills += 1
end

function Game:getWavePedsAreDead(timeNow)
    if self.pedsAreDead then
        return true
    end

    local deadPeds = 0
    local alivePeds = 0
    local totalPeds = 0

    for k, v in pairs(self.spawnedEntities) do
        totalPeds += 1

        if not v.headshotted and self.unprocessedHeadshots[v.entityId] then
            v.headshotted = true
            self:rewardHeadshot()
        end

        if v.processed then
            deadPeds += 1
            goto skip
        end

        if not DoesEntityExist(v.entityId) then
            deadPeds += 1
            v.processed = true
            goto skip
        end

        if GetEntityHealth(v.entityId) < 50 then
            deadPeds += 1
            v.processed = true

            if self.mutations.explodingPeds then
                self:explodeBody(v.entityId)
            else
                self:addBodyPoint(v.entityId)
            end

            self:rewardKill({ isBoss = v.isBoss, isElite = v.isElite })

            goto skip
        end

        alivePeds += 1

        ::skip::
    end

    if self.lastPedsDead ~= deadPeds then
        self.guardsLeft = totalPeds - deadPeds
        self:updateUI(locale('GUARDS_REMAINING'), self.guardsLeft)
    end

    self.lastPedsDead = deadPeds

    local deadPercentage = (deadPeds / totalPeds) * 100

    pcall(function()
        if self.killingStartedAt and ((timeNow - self.killingStartedAt) > 300) then
            if self.guardsLeft == 1 or deadPercentage >= 90 then
                for k, v in pairs(self.spawnedEntities) do
                    if not v.processed and DoesEntityExist(v.entityId) then
                        v.processed = true
                        DeleteEntity(v.entityId)
                    end
                end
            end
        end
    end)

    self.pedsAreDead = deadPercentage >= 100

    return self.pedsAreDead
end

function Game:explodeBody(entityId)
    CreateThread(function()
        local explosionType = 7

        if not bridge.fw.isExplosionAllowed(explosionType) then
            bridge.fw.allowExplosion(explosionType, 10000)
        end

        if bridge.fw.isExplosionAllowed(explosionType) then
            for playerId, v in pairs(self.playersInside) do
                TriggerClientEvent('prp-horde:client:addExplosion', playerId, explosionType, GetEntityCoords(entityId))
                break
            end
        end

        Wait(1000)

        DeleteEntity(entityId)
    end)
end

function Game:getCurrentWave()
    local waves = self.hardMode and svConfig.hardWaves or svConfig.waves

    local wave = waves[self.currentWave]

    if not wave then
        wave = waves[1]
    end

    return lib.table.deepclone(wave)
end

function Game:getWave(number)
    local waves = self.hardMode and svConfig.hardWaves or svConfig.waves

    local wave = waves[number]

    if not wave then
        wave = waves[1]
    end

    return lib.table.deepclone(wave)
end

function Game:removeBodyPoints()
    local ids = {}

    for id in pairs(self.bodyPoints) do
        table.insert(ids, id)
    end

    self:event('prp-horde:client:removeBodyPoints', ids)

    self.bodyPoints = {}
end

function Game:addBodyPoint(entityId)
    local pedNetworkId = NetworkGetNetworkIdFromEntity(entityId)

    local pointId = lib.string.random('..........', 10)

    local pedOwnerId = NetworkGetEntityOwner(entityId)

    if not DoesPlayerExist(pedOwnerId) then
        return
    end

    local customization = lib.callback.await('prp-horde:client:getPedCustomization', pedOwnerId, pedNetworkId)

    local wave = self:getCurrentWave()

    local items = {}

    local pedLoot = svConfig.pedLootTable

    local loot = exports['prp-bridge']:GenerateLoot(pedLoot.lootTable, wave.pedLootRolls, pedLoot.guaranteedRarities)

    for k, item in pairs(loot or {}) do
        table.insert(items, {
            name = item.name,
            count = item.count,
            metaData = { fromInventoryLoadout = true },
        })
    end

    local newPoint = {
        anim = svConfig.deathAnimPool[math.random(#svConfig.deathAnimPool)],
        pointId = pointId,
        model = GetEntityModel(entityId),
        coords = GetEntityCoords(entityId),
        rotation = GetEntityRotation(entityId),
        distance = 60.0,
        customization = customization or {},
    }

    newPoint.inventoryId = bridge.inv.createTemporaryStash({
        label = locale('GUARD'),
        slots = 10,
        maxWeight = 20,
        items = items,
    })

    self.bodyPoints[pointId] = newPoint

    CreateThread(function()
        Wait(3000)

        if DoesEntityExist(entityId) then
            lib.print.debug('Deleting entity for body point:', pointId)
            DeleteEntity(entityId)
        end

        lib.print.debug('Adding body point:', pointId)
        self:event('prp-horde:client:addBodyPoint', newPoint)
    end)
end

function Game:openPedInventory(playerId, pointId)
    local point = self.bodyPoints[pointId]

    if not point then
        return
    end

    bridge.inv.openStash(playerId, point.inventoryId)
end

function Game:setParticipantAlive(playerId)
    if not self.deadStateIds then
        return
    end

    if not playerId or not DoesPlayerExist(playerId) then
        return
    end

    local stateId = bridge.fw.getIdentifier(playerId)

    if not stateId then
        return
    end

    self.deadStateIds[stateId] = nil
end

function Game:setParticipantDead(playerId)
    if not playerId or not DoesPlayerExist(playerId) then
        return
    end

    local stateId = bridge.fw.getIdentifier(playerId)

    if not stateId then
        return
    end

    self.deadStateIds[stateId] = true

    local playersInside = 0
    for playerId, v in pairs(self.playersInside) do
        playersInside += 1
    end

    local deadPlayers = 0
    for deadStateId, v in pairs(self.deadStateIds or {}) do
        deadPlayers += 1
    end

    if deadPlayers >= playersInside then
        self:performAction('end')

        self.finished = true

        self.timeoutAt = os.time() + 10

        self:updateUI(locale('GAME_ENDS_IN'), self.timeoutAt, true)
        self:notifyInside({ title = locale('GAME_ENDS_IN_10_SECONDS'), duration = 6000 })
    end
end

function Game:getClosestPlayerToCoords(playerPositions, coords)
    local closestPlayer = nil
    local closestDistance = 250.0
    local chosenChoords = nil

    for k, v in pairs(playerPositions) do
        local distance = #(v.coords - coords)

        if distance < closestDistance then
            closestDistance = distance
            closestPlayer = v
            chosenChoords = v.coords
        end
    end

    if not closestPlayer then
        return
    end

    return closestPlayer.playerId, chosenChoords
end

function Game:getPlayerPositions()
    local playerPositions = {}

    for playerId, v in pairs(self.playersInside) do
        if playerId and DoesPlayerExist(playerId) then
            local ped = GetPlayerPed(playerId)

            if ped and DoesEntityExist(ped) then
                table.insert(playerPositions, {
                    playerId = playerId,
                    coords = GetEntityCoords(ped),
                })
            end
        end
    end

    return playerPositions
end

function Game:event(event, ...)
    local group = exports['prp-bridge']:GetGroupByUuid(self.groupId)
    group.triggerEvent(event, ...)
end

function Game:insideEvent(event, ...)
    for playerId, v in pairs(self.playersInside) do
        TriggerClientEvent(event, playerId, ...)
    end
end

function Game:createAction(key)
    local actionKey = ('%s_%s'):format(self.uniqueId, key)

    local success, exception = pcall(function()
        MySQL.insert.await('INSERT INTO horde_actions (`key`) VALUES (?)', { actionKey })
    end)

    return success
end

function Game:performAction(key)
    local actionKey = ('%s_%s'):format(self.uniqueId, key)

    return MySQL.query.await('DELETE FROM horde_actions WHERE `key` = ? LIMIT 1', { actionKey }).affectedRows == 1
end

function Game:cleanup()
    for k, v in pairs(self.spawnedEntities or {}) do
        if v.entityId and DoesEntityExist(v.entityId) then
            DeleteEntity(v.entityId)
        end
    end

    self:event('prp-horde:client:removeEntranceTarget', self.uniqueId)

    MySQL.query.await('DELETE FROM horde_actions WHERE `key` LIKE ?', { self.uniqueId .. '%' })
end

function Game:purchasedItemsToStorage()
    if self.purchasedItemsInStorage then
        return
    end

    self.purchasedItemsInStorage = true

    local items = {}

    for k, v in pairs(self.finalShopPurchasedItems) do
        for _ = 1, (v.amount or 1) do
            table.insert(items, {
                name = v.itemId,
                count = 1,
                metaData = v.metaData,
            })
        end
    end

    if #items == 0 then
        return
    end

    addStorage(self.interiorKey, self.groupId, items)
end

function Game:finish()
    self.finished = true

    bridge.log.send(config.logWebhook, "Horde Finished", "A horde game has finished.", {
        game_id = self.uniqueId,
        interior = self.interiorKey,
        kills = self.kills,
        headshots = self.headshots,
        currency_earned = self.currencyEarned,
        currency_spent = self.currencySpent,
        waves_completed = self.currentWave,
        failed = self.failed or false,
    })

    self:exitAllPlayers()

    self:cleanup()

    self:resetGroupLimits()

    self:purchasedItemsToStorage()

    self.destroy = true
end

------ HARD MODE
HardGame = lib.class('HardGame', Game)

function HardGame:constructor(data)
    self:super(data)

    self.hardMode = true

    local firstWave = svConfig.hardWaves[1]

    self.revivesLeft = 0

    self.revivePrice = firstWave.revivePrice

    self.mutations = {}

    self.mutationPool = firstWave.mutations or {}

    self.mutationCount = firstWave.mutationCount or 0

    -- SPECIAL PEDS
    self.bossChance = 0
    self.bossesSpawned = 0
    self.eliteChance = 0
    self.elitesSpawned = 0

    -- CRATE/DAMAEG POINTS
    self.cratePoints = {}
    self.damagePoints = {}
    self.damagePointIds = {}
end

function HardGame:regenerateMutations()
    self.mutations = {}

    if self.mutationCount < 1 then
        return
    end

    for i = 1, self.mutationCount do
        if #self.mutationPool == 0 and svConfig.hardWaves[self.currentWave + 1] then
            self.mutationPool = svConfig.hardWaves[self.currentWave + 1].mutations or {}
        end

        if #self.mutationPool > 0 then
            local mutation, index = getRandomWeightedItem(self.mutationPool)
            table.remove(self.mutationPool, index)
            self.mutations[mutation.type] = getMutation(mutation.type) or true
        end
    end
end

function HardGame:shouldBossSpawn(nextWave)
    self.bossChance += svConfig.boss.baseChance

    if nextWave == self.maxWave and self.bossesSpawned == 0 then
        return true
    end

    if svConfig.boss.minWave > nextWave then
        return
    end

    local shouldSpawn = rollChance(self.bossChance)

    if shouldSpawn then
        self.bossChance = 0
        self.bossesSpawned += 1
    end

    return shouldSpawn
end

function HardGame:shouldEliteSpawn(nextWave)
    self.eliteChance += svConfig.elite.baseChance

    if nextWave == 5 or nextWave == 10 then
        return true
    end

    if svConfig.elite.minWave > nextWave then
        return
    end

    if nextWave == self.maxWave and self.elitesSpawned == 0 then
        return true
    end

    local shouldSpawn = rollChance(self.eliteChance)

    if shouldSpawn then
        self.eliteChance = 0
        self.elitesSpawned += 1
    end

    return shouldSpawn
end

function HardGame:setWave(nextWave)
    self.pedsAreDead = false

    self:regenerateMutations()

    local playerPositions = self:getPlayerPositions()

    local spawnsCovered = true

    local spawnPlayerIdMap = {}

    local wave = self:getWave(nextWave)


    local allSpawns = self:getNPCSpawns()

    local guardCount = self:getNumberOfGuards(wave.numberOfPeds or 1, #allSpawns)

    self.guardsLeft = guardCount

    local spawns = selectWellSpaced(allSpawns, guardCount, 5.0, true)

    for k, v in pairs(spawns) do
        local coordsV3 = vector3(v.x, v.y, v.z)
        local playerId, coords = self:getClosestPlayerToCoords(playerPositions, coordsV3)

        if not playerId then
            lib.print.debug('[^2PRP-HORDE^0] failed to find spawn for coords', coordsV3)
            spawnsCovered = false
            break
        end

        spawnPlayerIdMap[k] = { playerId = playerId, coords = coords }
    end

    if not spawnsCovered then
        lib.print.debug('[PRP-HORDE] spawns are not covered, cant spawn peds...')
        return
    end

    self.currentWave = nextWave

    self:announceRound()

    self:removeBodyPoints()

    if wave.crates and wave.crates and wave.crates.chance > 0 and rollChance(wave.crates.chance) then
        local totalCrates = math.random((wave.crates.min or 1), (wave.crates.max or 1))
        self:addCratePoints(totalCrates, wave.crates.lootRolls or 1, wave.crates.lootTable,
            wave.crates.guaranteedRarities)
    end

    if wave.fire and wave.poison then
        local totalFires = math.random((wave.fire.min or 1), (wave.fire.max or 1))
        local totalPoisons = math.random((wave.poison.min or 1), (wave.poison.max or 1))
        self:addDamagePoints(totalFires, totalPoisons)
    end

    local pedHealth = self:getPedHealth(wave.health)
    local pedArmor = self:getPedArmor(wave.armor)
    local pedAccuracy = self:getPedAccuracy(wave.accuracy)

    local weaponPool = wave.weapons
    local modelPool = self.pedModels

    if self.mutations.meleeZombies then
        weaponPool = svConfig.zombieWeapons
        modelPool = svConfig.zombiePedModels
    end

    if svConfig.halloween then
        modelPool = svConfig.halloweenPedModels
    end

    local spawnBoss = self:shouldBossSpawn(nextWave)

    local spawnElite = self:shouldEliteSpawn(nextWave)

    for k, v in pairs(spawns) do
        local playerId = spawnPlayerIdMap[k].playerId
        local targetCoords = spawnPlayerIdMap[k].coords

        if spawnBoss then
            spawnBoss = false
            self:spawnCustomPed(playerId, v, targetCoords, self.bossModels, svConfig.boss, { isBoss = true })
            goto continue
        end

        if spawnElite then
            spawnElite = false
            self:spawnCustomPed(playerId, v, targetCoords, self.eliteModels, svConfig.elite, { isElite = true })
            goto continue
        end

        local weapon = getRandomWeightedItem(weaponPool or {})

        self:spawnPed(playerId, v, {
            model = modelPool[math.random(#modelPool)],
            health = pedHealth,
            armor = pedArmor,
            accuracy = pedAccuracy,
            weaponHash = weapon and weapon.hash or nil,
            targetCoords = targetCoords,
            isZombie = (self.mutations.meleeZombies ~= nil),
        })

        ::continue::
    end

    local perksData = self:getPerksData()

    if perksData.extraArmorPlates and perksData.extraArmorPlates > 0 then
        for playerId, v in pairs(self.playersInside) do
            if playerId and DoesPlayerExist(playerId) then
                bridge.inv.giveItem(playerId, svConfig.armorPlateItem, perksData.extraArmorPlates, {
                    fromInventoryLoadout = true,
                })
            end
        end
    end

    if wave.stress and wave.stress > 0 then
        perksData.stress = wave.stress
    end

    self:insideEvent('prp-horde:client:perkSetup', perksData)

    self.unprocessedHeadshots = {}

    self.killingStartedAt = os.time()

    self.state = 'KILLING'

    self:notifyInside({ title = locale('ELIMINATE_GUARDS'), duration = 3000 })

    self:updateUI(locale('GUARDS_REMAINING'), guardCount)
end

function HardGame:killWaveTick(timeNow)
    self:getWavePedsAreDead(timeNow)

    if not self.pedsAreDead then
        return
    end

    local wave = self:getCurrentWave()


    if wave.reviveAdd and wave.reviveAdd > 0 then
        self.revivesLeft += wave.reviveAdd
    end

    if self.currentWave == self.maxWave then
        self.finished = true

        self.state = 'FINISHED'

        self.timeoutAt = os.time() + 60

        self:updateUI(locale('GAME_ENDS_IN'), self.timeoutAt, true)
        self:notifyInside({ title = locale('GAME_END_COMPLETED'), duration = 6000 })

        for playerId, v in pairs(self.playersInside) do
            self:openFinalShop(playerId)
        end

        self:incrementCrimeBoardTasks()

        return
    end

    self:removeCratePoints()

    self:insideEvent('prp-horde:client:perkReset')

    self:startForcedPerkStage()

    self:incrementCrimeBoardTasks()
end

function HardGame:getObjectLocations(model, limit, excludeIds)
    local locations = {}

    local result

    if excludeIds and #excludeIds > 0 then
        local query = ('SELECT * FROM horde_objects WHERE interiorKey = ? AND model = ? AND id NOT IN (%s) ORDER BY RAND() LIMIT ?')
            :format(table.concat(excludeIds, ','))

        result = MySQL.query.await(query, { self.interiorKey, model, limit })
    else
        result = MySQL.query.await(
            'SELECT * FROM horde_objects WHERE interiorKey = ? AND model = ? ORDER BY RAND() LIMIT ?',
            { self.interiorKey, model, limit })
    end

    for k, v in pairs(result) do
        table.insert(locations, {
            dbId = v.id,
            model = joaat(v.model),
            coords = vector3(v.x + 0.0, v.y + 0.0, v.z + 0.0),
            rotation = vector3(v.rx + 0.0, v.ry + 0.0, v.rz + 0.0),
        })
    end

    return locations
end

function HardGame:openCrate(playerId, pointId)
    local point = self.cratePoints[pointId]

    if not point then
        return
    end

    if point.unlocked then
        bridge.inv.openStash(playerId, point.inventoryId)
        return
    end

    local removed = bridge.inv.removeItem(playerId, svConfig.crateKeyItem, 1)

    if not removed then
        bridge.fw.notify(playerId, 'error', locale('CRATE_NO_KEYS'))
        return
    end

    point.unlocked = true

    self:insideEvent('prp-horde:client:setCratePointUnlocked', pointId)

    bridge.inv.openStash(playerId, point.inventoryId)
end

function HardGame:addCratePoints(amount, lootRolls, lootTable, guaranteedRarities)
    local locations = self:getObjectLocations('tr_prop_tr_adv_case_01a', amount)

    for k, v in pairs(locations) do
        local items = {}

        local pointId = lib.string.random('..........', 10)

        local loot = exports['prp-bridge']:GenerateLoot(lootTable, lootRolls, guaranteedRarities)

        for k, item in pairs(loot or {}) do
            table.insert(items, {
                name = item.name,
                count = item.count,
                metaData = { fromInventoryLoadout = true },
            })
        end

        local newPoint = {
            model = v.model,
            pointId = pointId,
            coords = v.coords,
            rotation = v.rotation,
            distance = 60.0,
        }

        newPoint.inventoryId = bridge.inv.createTemporaryStash({
            label = locale('CRATE'),
            slots = 10,
            maxWeight = 20,
            items = items,
        })

        self.cratePoints[pointId] = newPoint
    end

    self:event('prp-horde:client:addCratePoints', self.cratePoints)
end

function HardGame:removeCratePoints()
    local ids = {}

    for id in pairs(self.cratePoints) do
        table.insert(ids, id)
    end

    self:event('prp-horde:client:removeCratePoints', ids)

    self.cratePoints = {}
end

function HardGame:addDamagePoints(fireCount, poisonCount)
    local fireLocations = self:getObjectLocations('w_ex_arena_landmine_01b', fireCount, self.damagePointIds)
    local poisonLocations = self:getObjectLocations('prop_gascyl_01a', poisonCount, self.damagePointIds)

    local newPoints = {}

    for k, v in pairs(fireLocations) do
        local pointId = lib.string.random('..........', 10)

        local newPoint = {
            type = 'fire',
            dbId = v.dbId,
            model = v.model,
            ptfxDict = 'weap_ch_vehicle_weapons',
            ptfxEffect = 'muz_ch_tank_flamethrower',
            ptfxScale = 1.0,
            ptfxRotation = vector3(90.0, 0.0, 0.0),
            pointId = pointId,
            coords = v.coords,
            rotation = v.rotation,
            distance = 100.0,
        }

        self.damagePoints[pointId] = newPoint

        table.insert(newPoints, newPoint)

        table.insert(self.damagePointIds, v.dbId)
    end

    for k, v in pairs(poisonLocations) do
        local pointId = lib.string.random('..........', 10)

        local newPoint = {
            type = 'poison',
            dbId = v.dbId,
            model = v.model,
            ptfxDict = 'scr_weap_bombs',
            ptfxEffect = 'scr_bomb_gas',
            ptfxScale = 0.9,
            pointId = pointId,
            coords = v.coords,
            rotation = v.rotation,
            distance = 100.0,
        }

        self.damagePoints[pointId] = newPoint

        table.insert(newPoints, newPoint)

        table.insert(self.damagePointIds, v.dbId)
    end

    self:event('prp-horde:client:addDamagePoints', newPoints)
end

function HardGame:endByPlayer(playerId)
    if self.state ~= 'LOOTING' then
        bridge.fw.notify(playerId, 'error', locale('GAME_ENDABLE_ONLY_IN_LOOTING'))
        return
    end

    if self.currentWave ~= 5 and self.currentWave ~= 10 then
        bridge.fw.notify(playerId, 'error', locale('GAME_ENDABLE_ONLY_IN_PHASES'))
        return
    end

    if not self:performAction('end') then
        return
    end

    self.finished = true

    self.timeoutAt = os.time() + 60

    self:updateUI(locale('GAME_ENDS_IN'), self.timeoutAt, true)
    self:notifyInside({ title = locale('GAME_ENDS_IN_60_SECONDS'), duration = 6000 })

    for loopPlayerId, v in pairs(self.playersInside) do
        self:openFinalShop(loopPlayerId)
    end
end

function HardGame:spawnCustomPed(playerId, coords, targetCoords, models, config, extra)
    local weapon = getRandomWeightedItem(config.weaponPool)

    return self:spawnPed(playerId, coords, {
        model = models[math.random(#models)],
        health = config.health,
        armor = config.armor,
        accuracy = config.accuracy,
        weaponHash = weapon and weapon.hash or nil,
        targetCoords = targetCoords,
        isBoss = extra.isBoss,
        isElite = extra.isElite,
    })
end

function HardGame:getLootingStageDuration()
    local wave = self:getWave(self.currentWave + 1)

    local time = wave and wave.lootingTime or svConfig.lootingTime

    for k, v in pairs(self.purchasedPerks) do
        if v.type == 'lootingExtend' then
            time = time + v.amount
        end
    end

    return time
end
