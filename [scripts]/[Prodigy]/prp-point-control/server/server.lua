local locations = {}

ActiveMissions = {}
ActiveLocations = {}
MapDelivered = MainConfig.Debug and true or false

local function setupTestingCommand()
    if not Config.TestingCommand.enabled then
        return
    end

    bridge.fw.registerCommand(
        Config.TestingCommand.command,
        locale("START_POINT_CONTROL_COMMAND_HELP"),
        {
            {
                name = locale("STATE_ID"),
                type = "playerId",
                help = locale("STATE_ID_HELP"),
            }
        },
        Config.TestingCommand.restricted,
        function(source, args)
            local targetSrc = args[1]
            if not targetSrc then return end

            local members = {
                [tostring(source)] = true,
                [tostring(targetSrc)] = true,
            }

            local taskId = "test_" .. os.time()
            local mission = StartPointControl(nil, members, taskId)
            mission:start()
        end
    )
end

local function setup()
    setupTestingCommand()
end
SetTimeout(0, setup)

function StartPointControl(partyId, members, taskId)
    local missionId = taskId

    ActiveMissions[missionId] = PointControl:new({
        id = missionId,
        taskId = taskId,
        partyId = partyId,
        members = members,
    })

    return ActiveMissions[missionId]
end

function GetActiveMissionByPartyId(groupId)
    for missionId, mission in pairs(ActiveMissions) do
        if mission.groupId == groupId or mission.enemyGroupId == groupId then
            return mission
        end
    end
    return nil
end

function GetLootReward(lootRolls, lootTable, guaranteedRarities)
    if not lootRolls then
        lootRolls = 1
    end

    for _, loot in pairs(lootTable) do
        for _, item in pairs(loot) do
            if item.name:match("weapon_") then
                item.metadata = item.metadata or {}
                item.metadata.scratchedSerial = true
            end
        end
    end

    local loot = exports["prp-bridge"]:GenerateLoot(lootTable, lootRolls, guaranteedRarities)

    return loot
end

function GetActiveMissionByPlayerId(playerId)
    for _, mission in pairs(ActiveMissions) do
        if mission.members[tostring(playerId)] then
            return mission
        end
    end
end

AddEventHandler("playerDropped", function(reason)

end)

AddEventHandler('onResourceStop', function(resourceName)
    for k, v in pairs(ActiveMissions) do
        v:destroy()
    end
end)

RegisterNetEvent("prp-point-control:exchangeItems", function()
    local source = source
    local items = Config.ConvertPed.itemPoints
    local requiredPoints = Config.ConvertPed.requiredPoints
    local itemSearch = {}
    for k, v in pairs(items) do
        itemSearch[#itemSearch + 1] = k
    end

    local itemCount = bridge.inv.count(source, itemSearch)
    local hasItem = bridge.inv.hasItem(inventoryId, Config.ConvertPed.requiredItem)
    if not hasItem then
        bridge.fw.notify(source, 'error', locale("MISSING_REQUIRED_ITEM"))
        return
    end
    local itemsToRemove = {}
    for itemName, count in pairs(itemCount) do
        if items[itemName] and count > 0 then
            itemsToRemove[itemName] = math.min(math.floor(requiredPoints / items[itemName]) + 1, count)
            requiredPoints = requiredPoints - (itemsToRemove[itemName] * items[itemName])
            if requiredPoints <= 0 then
                break
            end
        end
    end
    if requiredPoints > 0 then
        bridge.fw.notify(source, 'error', locale("NOT_ENOUGH_POINTS"))
        return
    end
    for itemName, count in pairs(itemsToRemove) do
        if not bridge.inv.removeItem(source, itemName, count) then
            bridge.fw.notify(source, 'error', locale("NOT_ENOUGH_ITEMS"))
            return
        end
    end
    if not bridge.inv.removeItem(source, Config.ConvertPed.requiredItem, 1) then
        bridge.fw.notify(source, 'error', locale("NOT_ENOUGH_ITEMS"))
        return
    end
    
    bridge.inv.giveItem(source, Config.ConvertPed.rewardItem, 1)
end)

RegisterNetEvent("prp-point-control:deliverMap", function()
    local source = source
    if MapDelivered then
        bridge.fw.notify(source, 'error', locale("MAP_ALREADY_DELIVERED"))
        return
    end
    local hasItem = bridge.inv.hasItem(source, Config.TurnOnMission.requiredItem)
    if not hasItem then
        bridge.fw.notify(source, 'error', locale("MISSING_REQUIRED_ITEM_MAP"))
        return
    end
    if not bridge.inv.removeItem(source, Config.TurnOnMission.requiredItem, 1) then
        bridge.fw.notify(source, 'error', locale("MISSING_REQUIRED_ITEM_MAP"))
        return
    end
    MapDelivered = true

    bridge.fw.notify(source, 'success', locale("MAP_DELIVERED_SUCCESS"))
end)

local function sendConfig()
    local src = source

    local configs = {
        TurnOnMission = Config.TurnOnMission,
        ConvertPed = Config.ConvertPed,
        CRATE_MODEL = Config.CRATE_MODEL,
        Locations = Config.Locations,
        MapColours = Config.MapColours,
        Mission = Config.Mission,
    }

    TriggerClientEvent("prp-point-control:client:configs", src, configs)
end
RegisterNetEvent("prp-point-control:clientReady", sendConfig)

local function startingPoints()
    if Config.StartingNpc?.randomLocation then
        lib.print.debug('Choosing random starting NPC location')
        local randomCoords = Config.StartingNpc.locations[math.random(1, #Config.StartingNpc.locations)]

        locations[1] = {
            model = Config.StartingNpc.models[math.random(1, #Config.StartingNpc.models)],
            coords = randomCoords,
            scenario = Config.StartingNpc.scenario,
            anim = Config.StartingNpc.anim,
        }
    else
        lib.print.debug('Using all starting NPC locations')
        for _, coords in pairs(Config.StartingNpc.locations) do
            locations[#locations + 1] = {
                model = Config.StartingNpc.models[math.random(1, #Config.StartingNpc.models)],
                coords = coords,
                scenario = Config.StartingNpc.scenario,
                anim = Config.StartingNpc.anim,
            }
        end
    end
end
SetTimeout(0, startingPoints)

local function sendLocations()
    local src = source

    TriggerClientEvent("prp-point-control:client:startingLocations", src, locations)
end
RegisterNetEvent("prp-point-control:clientReady", sendLocations)

local function countTable(tbl)
    local count = 0
    for k, v in pairs(tbl) do
        count = count + 1
    end
    return count
end

local currentlyWaiting = {}
local function openStartingMenu()
    local src = tostring(source)
    if not src then return end

    if Config.TurnOnMission and not MapDelivered then
        bridge.fw.notify(source, 'error', locale("MAP_NOT_DELIVERED"))
        return
    end

    if not HasFreeLocations() then
        bridge.fw.notify(src, 'error', locale("POINT_CONTROL_NO_AVAILABLE_LOCATIONS"))
        return
    end

    local menu = {
        id = 'point_control_starting_npc_menu',
        title = locale('POINT_CONTROL_STARTING_NPC_MENU_LABEL'),
        options = {}
    }

    if currentlyWaiting[src] then
        local needToStart = Config.Mission.minimalPlayersToStart - countTable(currentlyWaiting)
        menu.options[#menu.options + 1] = {
            title = locale('POINT_CONTROL_ALREADY_WAITING'),
            description = locale('POINT_CONTROL_ALREADY_WAITING_DESC', needToStart),
        }

        menu.options[#menu.options + 1] = {
            title = locale('POINT_CONTROL_MENU_OPTION_LEAVE_QUEUE'),
            description = locale('POINT_CONTROL_MENU_OPTION_LEAVE_QUEUE_DESC'),
            serverEvent = 'prp-point-control:server:leaveQueue',
        }

        TriggerClientEvent("prp-point-control:client:openMenu", src, menu)
        return
    end

    menu.options[#menu.options + 1] = {
        title = Config.Mission.label,
        description = Config.Mission.desc,
        serverEvent = 'prp-point-control:server:joinQueue',
    }

    TriggerClientEvent("prp-point-control:client:openMenu", src, menu)
end
RegisterNetEvent("prp-point-control:server:openStartingMenu", openStartingMenu)

local function joinQueue()
    local src = source

    if not src then return end

    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then return end

    if Config.TurnOnMission and not MapDelivered then return end

    if exports['prp-bridge']:isCooldownActiveForIdentifier(identifier, Config.Mission.name) then
        bridge.fw.notify(src, 'error', locale("POINT_CONTROL_QUEUE_COOLDOWN"))
        return
    end

    local removed, err = bridge.inv.removeItem(src, Config.Mission.startItem, 1)
    if not removed then
        lib.print.debug("Player does not have the required item to join the queue", err)
        bridge.fw.notify(src, 'error', locale("START_MISSION_REQUIRED"))
        return
    end

    currentlyWaiting[tostring(src)] = true

    bridge.fw.notify(src, 'success', locale("POINT_CONTROL_JOINED_QUEUE"))

    if countTable(currentlyWaiting) >= Config.Mission.minimalPlayersToStart then
        local members = {}
        for playerSrc, _ in pairs(currentlyWaiting) do
            members[playerSrc] = true
        end

        local taskId = "queue_" .. os.time()
        local mission = StartPointControl(nil, members, taskId)
        mission:start()

        currentlyWaiting = {}
    end
end
RegisterNetEvent("prp-point-control:server:joinQueue", joinQueue)

local function leaveQueue()
    local src = source

    if not src then return end
    if not currentlyWaiting[tostring(src)] then return end

    currentlyWaiting[tostring(src)] = nil

    bridge.inv.giveItem(src, Config.Mission.startItem, 1)

    bridge.fw.notify(src, 'success', locale("POINT_CONTROL_LEFT_QUEUE"))
end
RegisterNetEvent("prp-point-control:server:leaveQueue", leaveQueue)
