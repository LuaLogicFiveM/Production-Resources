Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for k, v in pairs(Config.TreeZones) do
        for _, tree in pairs(v.trees) do
            tree.maxHealth = tree.health
        end
    end
    while true do
        for zoneName, zone in pairs(Config.TreeZones) do
            for treeId, tree in pairs(zone.trees) do
                if tree.cutDown and os.time() - tree.cutDown > Config.Trees[tree.treeName].cooldown then
                    tree.health = tree.maxHealth
                    tree.cutDown = nil
                    TriggerClientEvent("prp-lumberjack:updateTreeData", -1, zoneName, treeId, "cutDown", nil)
                end
            end
        end
        Citizen.Wait(1000)
    end
end)


function GetDoubleDropChance(source)
    local stateId = bridge.fw.getIdentifier(source)

    if stateId then
        local level = GetLevel(stateId, Config.Job.Lumberjack.customRep)
        local doublePay = Config.Job.Lumberjack.doublePayChance[level] or 0
        doublePay = math.floor(doublePay * 100)
        return doublePay
    end

    return 0
end

function GetJobSpeedBonus(source)
    local stateId = bridge.fw.getIdentifier(source)

    if stateId then
        local level = GetLevel(stateId, Config.Job.Lumberjack.customRep)
        local speedIncrease = Config.Job.Lumberjack.speedIncrease[level] or 0
        return speedIncrease
    end

    return 0
end

function ShouldDrainDurability()
    return math.random(0, 100)
end

local eventLogCount = {}
RegisterNetEvent("prp-lumberjack:treeDamaged",
    function(zoneName, treeId, damage, weaponSlot, isOverheated, logCorrectCoords)
        local source = source

        if not weaponSlot then
            lib.print.debug("Weapon slot missing for tree damage event")
            return
        end
        
        local tree = Config.TreeZones[zoneName].trees[treeId]
        if not tree then return end
        local playerPed = GetPlayerPed(source)
        local coords = GetEntityCoords(playerPed)
        if #(coords.xy - tree.c.xy) > 10.0 then return end
        local item = bridge.inv.getSlot(source, weaponSlot)
        if not item or not Config.LumberjackWeapons[joaat(item.name)] then return end
        local weaponData = Config.LumberjackWeapons[joaat(item.name)]
        if weaponData.debounce <= 0 and damage > weaponData.damage[tree.treeName] then return end
        local treeConfig = Config.Trees[tree.treeName]
        if not treeConfig then return end
        if tree.cutDown then return end
        if treeConfig.chainsawOnly and item.name ~= string.lower("WEAPON_CHAINSAW") then
            bridge.fw.notify(source, "error", locale("CAN_ONLY_USE_CHAINSAW"))
            return
        end
        local stateId = bridge.fw.getIdentifier(source)
        local level = GetLevel(stateId, Config.Job.Lumberjack.customRep)
        if treeConfig.requiredRepLevel and level < treeConfig.requiredRepLevel then
            bridge.fw.notify(source, "error", locale("NOT_ENOUGH_REP", treeConfig.requiredRepLevel))
            return
        end
        if Config.RequiredRepLevel[item.name] and level < Config.RequiredRepLevel[item.name] then
            bridge.fw.notify(source, "error", locale("NOT_ENOUGH_EXP_TO_USE_ITEM"))
            return
        end
        local durabilityDrain = weaponData.durabilityDrain
        if not ShouldDrainDurability(source) then
            durabilityDrain = 0
        end
        if item.name == string.lower("WEAPON_CHAINSAW") then
            durabilityDrain = weaponData.durabilityDrain * math.floor(damage / weaponData.damage[tree.treeName])
        end
        if durabilityDrain > 0 then
            item.metadata.durability = (item.metadata.durability or 100) - durabilityDrain
            if item.metadata.durability < 0 then
                item.metadata.durability = 0
            end
            item.metadata.durability = round(item.metadata.durability, 2)
            bridge.inv.setItemMetaDataKey(source, weaponSlot, "durability", item.metadata.durability)
        end
        damage = math.floor(damage + (GetJobSpeedBonus(source) * damage))

        tree.health = tree.health - damage
        if tree.health <= 0 then
            TriggerEvent("prp-lumberjack:task:" .. tree.treeName, source, 1)
            bridge.fw.notify(source, "success", locale("CUT_DOWN_TREE", treeConfig.label or tree.treeName))
            local logName = tree.treeName .. "_log"
            local itemDrop = {
                { name = logName, count = 1 }
            }
            local doubleDropChance = GetDoubleDropChance(source)
            if doubleDropChance > 0 then
                if math.random(1, 100) <= doubleDropChance then
                    itemDrop[#itemDrop + 1] = { name = logName, count = 1 }
                end
            end
            tree.cutDown = os.time()
            TriggerClientEvent("prp-lumberjack:updateTreeData", -1, zoneName, treeId, "cutDown", true)
            local fallenCoords = lib.callback.await("prp-lumberjack:fallenTree", source, zoneName, treeId)
            bridge.inv.createCustomDrop(
                "logs",
                itemDrop,
                fallenCoords or logCorrectCoords,
                #itemDrop,
                5.0,
                nil,
                treeConfig?.model or nil 
            )
            local reputationReward = treeConfig.reputationReward or 0
            eventLogCount[tostring(source)] = (eventLogCount[tostring(source)] or 0) + 1
            if eventLogCount[tostring(source)] >= 10 then
                eventLogCount[tostring(source)] = 0
            end
            if reputationReward > 0 then
                local group = exports['prp-bridge']:GetGroupFromMember(source)

                if group then
                    for _, member in pairs(group.getMembers()) do
                        AddReputation(member.identifier, reputationReward)
                    end
                else
                    AddReputation(stateId, reputationReward)
                end
            end
        end
    end)

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

AddEventHandler("playerDropped", function()
    eventLogCount[tostring(source)] = nil
end)

lib.callback.register("prp-lumberjack:getCutDownTrees", function()
    local cutDownTrees = {}
    
    for zoneName, zone in pairs(Config.TreeZones) do
        for treeId, tree in pairs(zone.trees) do
            if tree.cutDown then
                cutDownTrees[#cutDownTrees + 1] = {
                    zoneName,
                    treeId,
                }
            end
        end
    end

    return cutDownTrees
end)
