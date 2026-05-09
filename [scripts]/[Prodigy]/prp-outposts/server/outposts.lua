---@class OutpostServerData
---@field id number
---@field type "money"|"drug"
---@field drugs number
---@field money number
---@field pedProfile number
---@field cornerIndex number

local MAX_PEDS_PER_OUTPOST <const> = SvConfig.MaxPedsPerOutpost
local TYPES <const> = { "money", "drug" }

local ROTATION_INTERVAL <const> = SvConfig.RotationInterval * 1000
local SELLING_INTERVAL <const> = SvConfig.SellingInterval

local outpostData = {}

---@param coords vector3
---@return integer | boolean
---@return table?
function GetClosestOutpost(coords)
    for outpostId, data in ipairs(Outposts) do
        local isActive = outpostData[outpostId] ~= nil

        local distance = #(coords - data.interior)
        if isActive and distance <= 150 then
            return outpostId, {
                label = data.cardLabel,
                description = data.cardDescription,
                image = data.cardImage
            }
        end
    end

    return false
end

---@class ServerOutpost : OxClass
local ServerOutpost = lib.class("ServerOutpost")

---@param outpostId number
---@param outpostType string
function ServerOutpost:constructor(outpostId, outpostType)
    self.outpostId = outpostId
    self.type = outpostType
    self.peds = {}

    if Config.Debug then
        self.kingPin = 1 -- stateId of owner

        local corners = Outposts[outpostId].corners

        if #corners < MAX_PEDS_PER_OUTPOST then
            error(
                string.format(
                    "Outpost %d needs at least %d corners, has %d",
                    outpostId,
                    MAX_PEDS_PER_OUTPOST,
                    #corners
                )
            )
        end
    end

    self.rotationTimer = lib.timer(
        ROTATION_INTERVAL,
        function()
            self:rotateCorners()
        end,
        true
    )

    self:startPassiveSelling()
end

function ServerOutpost:rotateCorners()
    lib.print.debug("Rotating corners for outpost", self.outpostId)

    local corners = Outposts[self.outpostId].corners
    local cornerIndices = RollUnique(#corners, MAX_PEDS_PER_OUTPOST)

    for i, pedData in ipairs(self.peds) do
        local cornerIndex = cornerIndices[i]

        pedData.cornerIndex = cornerIndex

        lib.print.debug(
            "Moved dealer",
            i,
            "to outpost",
            self.outpostId,
            "corner",
            cornerIndex
        )
    end

    self:updateClients()

    self.rotationTimer:restart()
end

function ServerOutpost:getDealerInventories(pedProfileId)
    local inputInventoryName = "OUTPOST_DEALER_INPUT_" .. self.outpostId .. "_" .. pedProfileId
    local outputInventoryName = "OUTPOST_DEALER_OUTPUT_" .. self.outpostId .. "_" .. pedProfileId

    return {
        inputInventoryName,
        outputInventoryName
    }
end

function ServerOutpost:getDealerStock(pedProfileId)
    local inventories = self:getDealerInventories(pedProfileId)

    for _, inventoryName in ipairs(inventories) do
        local inventory = bridge.inv.getInventoryItems(inventoryName)
        if inventory and #inventory > 0 then
            return true
        end
    end

    return false
end

function ServerOutpost:getDealer(pedProfileId)
    for pedIndex, pedData in pairs(self.peds) do
        if pedData.pedProfile == pedProfileId then
            return pedIndex, pedData
        end
    end

    return nil, nil
end

function ServerOutpost:getFreeCorner()
    local usedCorners = {}

    for _, pedData in pairs(self.peds) do
        usedCorners[pedData.cornerIndex] = true
    end

    for cornerIndex = 1, MAX_PEDS_PER_OUTPOST do
        if not usedCorners[cornerIndex] then
            return cornerIndex
        end
    end

    return nil
end

function ServerOutpost:hireDealer(pedProfileId)
    local pedIndex = #self.peds + 1

    local pedData = self.peds[pedIndex]

    if not pedData then
        self.peds[pedIndex] = {
            pedProfile = pedProfileId,
            cornerIndex = self:getFreeCorner()
        }
    end

    self.peds[pedIndex].pedProfile = pedProfileId

    self:updateClients()

    return true
end

function ServerOutpost:fireDealer(pedProfileId)
    local fired = false
    for idx, pedData in pairs(self.peds) do
        if pedData.pedProfile == pedProfileId then
            self.peds[idx] = nil
            fired = true
            break
        end
    end

    if fired then
        self:updateClients()

        return true
    end

    return false
end


function ServerOutpost:setKingPin(stateId)
    self.kingPin = stateId
    self:updateClients()
end

function ServerOutpost:updateClients()
    TriggerClientEvent("prp-outposts:updateOutpost", -1, self.outpostId, self:getDTO())
end

function ServerOutpost:getMembersOfKingPin()
    local playerIds = {} ---@type number[]
    local group = exports["prp-bridge"]:GetGroupIdFromMemberByIdentifier(self.kingPin)

    if group then
        playerIds = exports["prp-bridge"]:GetGroupPlayerIds(group.uuid)
    else
        playerIds = {
            bridge.fw.getSrcFromIdentifier(self.kingPin)
        }
    end

    return playerIds
end

function ServerOutpost:getDTO()
    local returnData = {
        id = self.outpostId,
        type = self.type,
        peds = self.peds,
        kingPins = self:getMembersOfKingPin(),
    }

    return returnData
end

local SALE_MESSAGES <const> = {
    "OUTPOST_SALE_MESSAGE_1",
    "OUTPOST_SALE_MESSAGE_2",
    "OUTPOST_SALE_MESSAGE_3",
    "OUTPOST_SALE_MESSAGE_4",
    "OUTPOST_SALE_MESSAGE_5"
}

local CLEAN_MESSAGES <const> = {
    "OUTPOST_CLEAN_MESSAGE_1",
    "OUTPOST_CLEAN_MESSAGE_2",
    "OUTPOST_CLEAN_MESSAGE_3",
    "OUTPOST_CLEAN_MESSAGE_4",
    "OUTPOST_CLEAN_MESSAGE_5"
}

---@param inventoryId string
---@param attempt number?
---@return table | boolean
---@return number?
---@return table?
local function getRandomDrug(inventoryId, attempt)
    if attempt and attempt > (#SvConfig.DrugItems * 2) then
        return false
    end

    local drugs = lib.table.deepclone(SvConfig.DrugItems)
    local drug = drugs[math.random(1, #drugs)]

    local items = bridge.inv.searchInventory(inventoryId, drug.name)
    local itemCount = 0
    local drugSlots = {}

    for k, v in pairs(items) do
        if not drug.durability or (v.metadata.durability and v.metadata.durability >= drug.durability[1] and v.metadata.durability <= drug.durability[2]) then
            itemCount = itemCount + v.count
            drugSlots[v.slot] = v.count
        end
    end

    if itemCount == 0 then
        return getRandomDrug(inventoryId, (attempt or 1) + 1)
    elseif itemCount < 2 then
        return getRandomDrug(inventoryId, (attempt or 1) + 1)
    end

    local offerAmount = math.random(1, math.min(drug.maxPerOffer, itemCount))
    return lib.table.deepclone(drug), offerAmount, drugSlots
end

function ServerOutpost:startPassiveSelling()
    CreateThread(function()
        while true do
            Wait(1000)

            local sold, errorMsg = pcall(function()
                local totalSold = 0

                for pedIndex, pedData in pairs(self.peds) do
                    local pedProfile = PedProfiles[pedData.pedProfile]
                    local lastSold = pedData.lastSold or 0

                    if os.time() - lastSold < (SELLING_INTERVAL + (SELLING_INTERVAL * ((100 - pedProfile.stats.speed) / 100))) then
                        goto continue
                    end

                    local inventories = self:getDealerInventories(pedData.pedProfile)
                    local inputInventory = bridge.inv.getInventoryItems(inventories[1])

                    if inputInventory and #inputInventory > 0 then
                        if self.type == "drug" then
                            local randomDrug, offerAmount, slots = getRandomDrug(inventories[1])
                            if not randomDrug or not offerAmount or not slots then
                                goto jumpRemoval
                            end

                            local priceOfDrug = randomDrug.max[2] * 0.6
                            local moneyToAdd = math.floor(priceOfDrug / 10 * offerAmount * (pedProfile.stats.split / 100))

                            for slotIndex, _ in pairs(slots) do
                                local item = bridge.inv.getSlot(inventories[1], slotIndex)
                                if not item or item.count < offerAmount then
                                    lib.print.debug("Item count in slot is less than offer amount", offerAmount, item)
                                    goto notEnoughItem
                                end

                                local removed, e = bridge.inv.removeItem(inventories[1], randomDrug.name, offerAmount, nil, slotIndex)
                                if removed then
                                    bridge.inv.giveItem(inventories[2], SvConfig.PaymentItem, moneyToAdd)
                                    totalSold = totalSold + offerAmount

                                    local saleMessage = SALE_MESSAGES[math.random(#SALE_MESSAGES)]
                                    self:sendPhoneMessageToKingPins(
                                        "1442-42-EXCHG",
                                        locale(saleMessage, pedProfile.name, offerAmount, moneyToAdd * 10)
                                    )

                                    pedData.lastSold = os.time()

                                    self:alertPD()
                                    self:addRep()
                                end

                                ::notEnoughItem::
                            end
                        elseif self.type == "money" then
                            local randomSlot = inputInventory[math.random(#inputInventory)]
                            if randomSlot and SvConfig.MoneyWorth[randomSlot.name] then
                                local removeAmount = math.min(randomSlot.count, math.random(SvConfig.MoneyCounts[randomSlot.name][1], SvConfig.MoneyCounts[randomSlot.name][2]))
                                local removed = bridge.inv.removeItem(inventories[1], randomSlot.name, removeAmount)

                                if removed then
                                    local moneyValue = math.floor(SvConfig.MoneyWorth[randomSlot.name] * removeAmount * (pedProfile.stats.split / 100))
                                    local cleanMessage = CLEAN_MESSAGES[math.random(#CLEAN_MESSAGES)]

                                    pedData.money = (pedData.money or 0) + moneyValue

                                    self:sendPhoneMessageToKingPins(
                                        "1442-42-EXCHG",
                                        locale(cleanMessage, pedProfile.name, removeAmount, moneyValue)
                                    )

                                    pedData.lastSold = os.time()

                                    self:alertPD()
                                    self:addRep()
                                end
                            end
                        end

                        ::jumpRemoval::
                    end
                end

                if totalSold > 0 then
                    lib.print.debug(
                        "Outpost",
                        self.outpostId,
                        "sold a total of",
                        totalSold,
                        "items through passive selling."
                    )
                end

                :: continue ::
            end)

            if not sold then
                lib.print.error("Error during outpost passive selling:", errorMsg)
            end
        end
    end)
end

function ServerOutpost:addRep()
    if not SvConfig.Rep.enabled then return end
    local pSource = bridge.fw.getSrcFromIdentifier(self.kingPin)
    if not pSource then return end

    bridge.fw.addRep(
        pSource,
        SvConfig.Rep.type,
        SvConfig.Rep.amount,
        "exchange_sale"
    )
end

function ServerOutpost:alertPD()
    local chanceForAlert = math.random(1, 100) <= 10

    if not chanceForAlert then
        return
    end

    pcall(function()
        local dispatch = SvConfig.DispatchAlert
        bridge.dispatch.sendAlert(
            -1,
            dispatch.jobs,
            Outposts[self.outpostId].interior + vector3(math.random(-15, 15), math.random(-15, 15), 0),
            {
                code = dispatch.code,
                title = dispatch.title,
                description = dispatch.description,
            },
            {
                sprite = dispatch.blip.sprite,
                scale = dispatch.blip.scale,
                colour = dispatch.blip.colour,
                length = dispatch.blip.duration
            }
        )
    end)
end

function ServerOutpost:sendPhoneMessageToKingPins(number, message)
    local srcs = self:getMembersOfKingPin()

    for _, src in pairs(srcs) do
        if src and DoesPlayerExist(src --[[@as string]]) then
            bridge.phone.sendMessage(src, number ~= "RANDOM" and number or nil, message)
        end
    end
end

function RollUnique(maxRolls, amount, minValue)
    if amount > maxRolls then
        error("amount cannot be greater than maxRolls")
    end

    local pool = {}
    for i = minValue or 1, maxRolls do
        table.insert(pool, i)
    end

    for i = maxRolls, 2, -1 do
        local j = math.random(i)
        pool[i], pool[j] = pool[j], pool[i]
    end

    local result = {}
    for i = 1, amount do
        table.insert(result, pool[i])
    end

    return result
end

function GenerateOutposts()
    local outpostIds = RollUnique(#Outposts, #TYPES)

    for i, outpostId in ipairs(outpostIds) do
        local outpostType = TYPES[i]

        local outpost = ServerOutpost:new(outpostId, outpostType)

        outpostData[outpostId] = outpost

        lib.print.debug("Generated outpost", outpostId, "of type", outpostType, "with coords:", Outposts[outpostId].interior)

        for pedProfile in pairs(PedProfiles) do
            bridge.inv.createStash({
                id = "OUTPOST_DEALER_INPUT_" .. outpostId .. "_" .. pedProfile,
                label = locale("DEALER_STOCK"),
                slots = SvConfig.DealerStash.maxSlots,
                maxWeight = SvConfig.DealerStash.maxWeight
            })

            bridge.inv.createStash({
                id = "OUTPOST_DEALER_OUTPUT_" .. outpostId .. "_" .. pedProfile,
                label = locale("DEALER_MONEY"),
                slots = SvConfig.DealerStash.maxSlots,
                maxWeight = SvConfig.DealerStash.maxWeight
            })
        end
    end
end

lib.callback.register("prp-outposts:getOutpost", function(pSource, internalId)
    if not outpostData[internalId] then
        return nil
    end

    return outpostData[internalId]:getDTO(pSource)
end)

lib.callback.register("prp-outposts:hireDealer", function(pSource, outpostId, pedIndex, pedProfileId)
    local outpost = outpostData[outpostId]

    if not outpost then
        return false, locale("OUTPOST_DOESNT_EXIST")
    end

    local pedProfile = PedProfiles[pedProfileId]

    if not bridge.fw.removeMoney(pSource, "cash", pedProfile.price, "exchange_runner") then
        return false, locale("NOT_ENOUGH_MONEY")
    end

    return outpost:hireDealer(pedProfileId)
end)

lib.callback.register("prp-outposts:fireDealer", function(pSource, outpostId, pedIndex, pedProfileId)
    local outpost = outpostData[outpostId]

    if not outpost then
        return false, locale("OUTPOST_DOESNT_EXIST")
    end

    local success = outpost:fireDealer(pedProfileId)
    if not success then
        return false, locale("COULD_NOT_FIRE_DEALER")
    end

    outpost:updateClients()

    return true
end)

lib.callback.register("prp-outposts:talkToDealer", function(pSource, outpostId, pedProfileId)
    local outpost = outpostData[outpostId]

    if not outpost then
        return nil
    end

    local pedIndex, pedData = outpost:getDealer(pedProfileId)

    if not pedData then
        return nil
    end

    if not pedIndex then
        return nil
    end

    local selectedInventory = 1
    local inventories = outpost:getDealerInventories(pedProfileId)
    local inventoriesToOpen = {
        inventories[1]
    }

    if outpost.type == "drug" then
        inventoriesToOpen[#inventoriesToOpen + 1] = inventories[2]
    end

    if #inventoriesToOpen > 1 then
        local selected = lib.callback.await("prp-outposts:client:selectInv", pSource)
        if not selected then return end
        selectedInventory = selected
    end

    bridge.inv.openStash(pSource, inventoriesToOpen[selectedInventory])

    return nil
end)

lib.callback.register("prp-outposts:robDealer", function(pSource, outpostId, pedProfileId)
    local outpost = outpostData[outpostId]

    if not outpost then
        return false, locale("OUTPOST_DOESNT_EXIST")
    end

    local _, pedData = outpost:getDealer(pedProfileId)

    if not pedData then
        return false, locale("DEALER_DOESNT_EXIST")
    end

    local finished = lib.callback.await("prp-bridge:progress", pSource, {
        duration = 12500,
        label = locale("ROBBING_DEALER"),
        controlDisables = { disableMovement = true, disableCarMovement = true },
        canCancel = true,
        animation = {
            animDict = "random@shop_robbery",
            animClip = "robbery_action_b",
            animFlag = 49
        }
    })

    if not finished then
        return false
    end

    if outpost.type == "money" then
        local money = pedData.money or 0

        if money > 0 then
            bridge.fw.addMoney(pSource, "cash", money, "exchange_runner")
            pedData.money = 0
        end
    end

    local selectedInventory = 1
    local inventories = outpost:getDealerInventories(pedProfileId)
    local inventoriesToOpen = {
        inventories[1]
    }

    if outpost.type == "drug" then
        inventoriesToOpen[#inventoriesToOpen + 1] = inventories[2]
    end

    if #inventoriesToOpen > 1 then
        local selected = lib.callback.await("prp-outposts:client:selectInv", pSource)
        if not selected then return end
        selectedInventory = selected
    end

    bridge.inv.openStash(pSource, inventoriesToOpen[selectedInventory])

    outpost:sendPhoneMessageToKingPins(
        "1442-42-EXCHG",
        locale("OUTPOST_DEALER_ROB_MESSAGE", PedProfiles[pedProfileId].name)
    )

    return true
end)

lib.callback.register("prp-outposts:takeControl", function(pSource, outpostId)
    local stateId = bridge.fw.getIdentifier(pSource)
    if not stateId then
        return false, locale("PLAYER_DATA_INVALID")
    end

    local outpost = outpostData[outpostId]

    if not outpost then
        return false, locale("OUTPOST_DOESNT_EXIST")
    end

    if GetNumPlayerIndices() < GetConvarInt("sv_minPlayersForExchange", 0) then
        return false, locale("CANT_TAKE_CONTROL")
    end

    local finished = lib.callback.await("prp-bridge:progress", pSource, {
        -- duration = 12500,
        duration = 1500,
        label = locale("TAKING_CONTROL"),
        controlDisables = { disableMovement = true, disableCarMovement = true },
        canCancel = true,
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            animClip = "machinic_loop_mechandplayer",
            animFlag = 1
        }
    })

    if not finished then
        return false
    end

    outpost:sendPhoneMessageToKingPins(
        "1442-42-EXCHG",
        locale("OUTPOST_TAKEN_CONTROL_MESSAGE")
    )
    outpost:setKingPin(bridge.fw.getIdentifier(pSource))

    return true
end)

lib.callback.register("prp-outposts:requestDoorOpen", function(pSource, outpostId)
    local foundCard = nil ---@type InvSearchItem
    local cards = bridge.inv.searchInventory(pSource, Config.Items.exchangeCard)
    if not cards or #cards == 0 then
        return false
    end

    for i = 1, #cards do
        foundCard = cards[i]
        break
    end

    if not foundCard then
        return false
    end

    if foundCard.metadata.durability <= 0 then
        return false
    end

    if foundCard.metadata.outpost ~= outpostId then
        return false
    end

    ToggleOutpostDoor("outpost_" .. outpostId, false)

    return true
end)

lib.callback.register("prp-outposts:collectMoney", function(pSource, outpostId, pedProfileId)
    local outpost = outpostData[outpostId]

    if not outpost then
        return false, locale("OUTPOST_DOESNT_EXIST")
    end

    local _, pedData = outpost:getDealer(pedProfileId)

    if not pedData then
        return false, locale("DEALER_DOESNT_EXIST")
    end

    if pedData.money and pedData.money <= 0 or not pedData.money then
        return false, locale("NO_MONEY_TO_COLLECT")
    end

    bridge.fw.addMoney(pSource, "cash", pedData.money, "exchange_runner")
    pedData.money = 0

    return true
end)
