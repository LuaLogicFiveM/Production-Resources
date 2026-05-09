DebugOn = GetConvarInt("boxing_debug", Config.Debug and 1 or 0) == 1

AddConvarChangeListener("boxing_debug", function(name, oldValue, newValue)
    DebugOn = tonumber(newValue) == 1
end)

lib.callback.register("prp-boxing:getNearbyPlayers", function(source)
    return GetNearbyPlayers(source, GetEntityCoords(GetPlayerPed(source)), 50.0)
end)

Citizen.CreateThread(function()
    exports.oxmysql:query_async([[
        CREATE TABLE IF NOT EXISTS `boxing_matches` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `firstPlayer` varchar(255) NOT NULL,
            `secondPlayer` varchar(255) NOT NULL,
            `wonPlayer` varchar(255) DEFAULT NULL,
            `isKo` int(11) NOT NULL DEFAULT 0,
            `endTime` datetime DEFAULT current_timestamp(),
            PRIMARY KEY (`id`),
            KEY `firstPlayer` (`firstPlayer`),
            KEY `secondPlayer` (`secondPlayer`),
            KEY `wonPlayer` (`wonPlayer`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ]])
end)

RegisterNetEvent("prp-boxing:requestBoxingRings", function(stateId)
    local src = source
    TriggerClientEvent("prp-boxing:setBoxingRings", src, Config.BoxingRings or {})
end)

local function saveAdminRings()
    local toSave = {}
    for k, v in pairs(Config.BoxingRings) do
        if v.adminSpawned then
            toSave[k] = lib.table.deepclone(v)
            toSave[k].tutorialId = nil
            toSave[k].matchId = nil
        end
    end
    SaveResourceFile(GetCurrentResourceName(), "config/adminRings.json", json.encode(toSave or {}, { indent = true }), -1)
end

local setupEvent = nil
Citizen.CreateThread(function()
    Wait(200)
    local adminRings = LoadResourceFile(GetCurrentResourceName(), "config/adminRings.json")
    if adminRings then
        local decoded = json.decode(adminRings)
        if decoded and type(decoded) == "table" then
            for k, v in pairs(decoded) do
                v.tutorialId = nil
                v.matchId = nil
                v.position = vector4(v.position.x, v.position.y, v.position.z, v.position.w)
                v.rotation = vector3(v.rotation.x, v.rotation.y, v.rotation.z)
                Config.BoxingRings[k] = v
                Config.BoxingRings[k].adminSpawned = true
            end
        end
        TriggerClientEvent("prp-boxing:setBoxingRings", -1, Config.BoxingRings or {})
    end
    bridge.fw.registerCommand("boxingspawnring", locale("SPAWN_BOXING_COMMAND_HELP"), {
        {
            name = "ringIndex",
            type = "id",
            help = locale("RING_NAME_HELP"),
        }
    }, "group.admin", function(src, args)
        local ringIndex = args.ringIndex
        if not ringIndex then
            bridge.fw.notify(src, "error", locale("INVALID_ARGUMENTS"))
            return
        end
        local ringConfig = Config.BoxingRings[ringIndex]
        if ringConfig then
            bridge.fw.notify(src, "error", locale("RING_ALREADY_EXISTS"))
            return
        end
        local result = lib.callback.await("prp-boxing:spawnBoxingRing", src, ringIndex)
        if not result then
            bridge.fw.notify(src, "error", locale("INVALID_ARGUMENTS"))
            return
        end
        result.adminSpawned = true
        Config.BoxingRings[ringIndex] = result
        saveAdminRings()
        TriggerClientEvent("prp-boxing:setBoxingRings", -1, Config.BoxingRings or {})
        bridge.fw.notify(src, "success", locale("RING_SPAWNED_SUCCESS"))
    end)

    bridge.fw.registerCommand("boxingremovering", locale("REMOVE_BOXING_COMMAND_HELP"), {
        {
            name = "ringIndex",
            type = "id",
            help = locale("RING_NAME_HELP"),
        }
    }, "group.admin", function(src, args)
        local ringIndex = args.ringIndex
        if not ringIndex then
            bridge.fw.notify(src, "error", locale("INVALID_ARGUMENTS"))
            return
        end
        local ringConfig = Config.BoxingRings[ringIndex]
        if not ringConfig or not ringConfig.adminSpawned then
            bridge.fw.notify(src, "error", locale("INVALID_ARGUMENTS"))
            return
        end
        if Config.BoxingRings[ringIndex].matchId or Config.BoxingRings[ringIndex].tutorialId then
            bridge.fw.notify(src, "error", locale("WAIT_FOR_MATCH_TO_END"))
            return
        end
        Config.BoxingRings[ringIndex] = nil
        saveAdminRings()
        TriggerClientEvent("prp-boxing:setBoxingRings", -1, Config.BoxingRings or {})
        bridge.fw.notify(src, "success", locale("RING_REMOVED_SUCCESS"))
    end)

    bridge.fw.registerCommand("boxinglistrings", locale("LIST_BOXING_COMMAND_HELP"), {}, "group.admin", function(src, args)
        TriggerClientEvent("prp-boxing:boxingListRings", src, Config.BoxingRings or {})
    end)
end)

RegisterNetEvent("prp-boxing:removeRing", function(ringIndex)
    local source = source
    if not bridge.fw.isAdmin(source) then
        return
    end
    local ringConfig = Config.BoxingRings[ringIndex]
    if not ringConfig or not ringConfig.adminSpawned then
        return
    end
    if ringConfig.matchId or ringConfig.tutorialId then
        bridge.fw.notify(source, "error", locale("WAIT_FOR_MATCH_TO_END"))
        return
    end
    Config.BoxingRings[ringIndex] = nil
    saveAdminRings()
    TriggerClientEvent("prp-boxing:setBoxingRings", -1, Config.BoxingRings or {})
    TriggerClientEvent("prp-boxing:boxingListRings", source, Config.BoxingRings or {})
end)