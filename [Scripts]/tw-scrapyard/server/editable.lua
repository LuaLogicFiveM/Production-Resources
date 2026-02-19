bot_Token = ""
bot_logo = "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png"
bot_name = "Tworst Store"


discord_webhook = {
    ['jobfinish'] =
    "https://ptb.discord.com/api/webhooks/1353276960373211186/yGe6wZzxcTemg7MdufCo6nc3WPEEdLotxvQHfltZksDzGHgUJavi7ZCm_KtIr6aruR8A",
}

local Caches = {
    Avatars = {}
}



DisconnectedPlayers = {} -- {identifier = {lobbyId, playerData, disconnectTime, reconnectAttempts, lastReconnectTime}}
ReconnectionTracking = {} -- {identifier = {attempts, lastStableConnection, totalDisconnects}}

function StoreDisconnectedPlayerState(identifier, lobbyId, playerData)
    if not Config.Reconnection.enabled then
        return 
    end

    if not ReconnectionTracking[identifier] then
        ReconnectionTracking[identifier] = {
            attempts = 0,
            lastStableConnection = os.time(),
            totalDisconnects = 0
        }
    end

    ReconnectionTracking[identifier].totalDisconnects = ReconnectionTracking[identifier].totalDisconnects + 1

    DisconnectedPlayers[identifier] = {
        lobbyId = lobbyId,
        playerData = playerData,
        disconnectTime = os.time(),
        reconnectAttempts = ReconnectionTracking[identifier].attempts
    }

    if Config.Reconnection.debugLogs then
        print(string.format("[Reconnection] Stored state for player %s (lobby: %s, attempts: %d/%d)",
            identifier, lobbyId, ReconnectionTracking[identifier].attempts,
            Config.Reconnection.maxReconnectAttempts == 0 and "unlimited" or Config.Reconnection.maxReconnectAttempts))
    end
end

-- Check if player can rejoin their lobby
function HasActiveGracePeriod(identifier)
    if not Config.Reconnection.enabled then
        return false
    end

    local state = DisconnectedPlayers[identifier]
    if not state then return false end

    -- Check if lobby still exists
    if not coopData[state.lobbyId] then
        DisconnectedPlayers[identifier] = nil
        if Config.Reconnection.debugLogs then
            print(string.format("[Reconnection] Lobby no longer exists for player %s", identifier))
        end
        return false
    end

    -- Check grace period expiration (if configured)
    if Config.Reconnection.gracePeriodSeconds > 0 then
        local elapsed = os.time() - state.disconnectTime
        if elapsed > Config.Reconnection.gracePeriodSeconds then
            DisconnectedPlayers[identifier] = nil
            if Config.Reconnection.debugLogs then
                print(string.format("[Reconnection] Grace period expired for player %s (elapsed: %ds)",
                    identifier, elapsed))
            end
            return false
        end
    end

    -- Check reconnection attempts limit (if configured)
    if Config.Reconnection.maxReconnectAttempts > 0 then
        local tracking = ReconnectionTracking[identifier]
        if tracking and tracking.attempts >= Config.Reconnection.maxReconnectAttempts then
            DisconnectedPlayers[identifier] = nil
            if Config.Reconnection.debugLogs then
                print(string.format("[Reconnection] Max reconnection attempts reached for player %s (%d/%d)",
                    identifier, tracking.attempts, Config.Reconnection.maxReconnectAttempts))
            end
            return false
        end
    end

    return true
end

-- Reset reconnection attempts after stable connection
function UpdateStableConnection(identifier)
    if not Config.Reconnection.enabled then return end

    local tracking = ReconnectionTracking[identifier]
    if not tracking then return end

    local now = os.time()
    local timeSinceReconnect = now - tracking.lastStableConnection

    -- Reset attempts if player stayed connected for configured duration
    if timeSinceReconnect >= Config.Reconnection.resetAttemptsAfterSeconds then
        tracking.attempts = 0
        tracking.lastStableConnection = now

        if Config.Reconnection.debugLogs then
            print(string.format("[Reconnection] Reset attempts for player %s after %ds stable connection",
                identifier, timeSinceReconnect))
        end
    end
end

-- Restore player to their lobby
function RestorePlayerToLobby(src, identifier)
    local state = DisconnectedPlayers[identifier]
    if not state then
        --print(string.format("[Reconnection] ERROR: No disconnected state found for player %s", identifier))
        return false
    end

    local lobby = coopData[state.lobbyId]
    if not lobby then
        DisconnectedPlayers[identifier] = nil
        TriggerClientEvent(_event('client:sendNotification'), src,
            Locales[Config.Locale]['lobby_no_longer_exists'],
            "error")
        return false
    end

    -- Update player's source ID in lobby
    for _, player in ipairs(lobby.players) do
        if player.playerIdentifier == identifier then
            player.source = src

            -- Increment reconnection attempts
            if not ReconnectionTracking[identifier] then
                ReconnectionTracking[identifier] = {
                    attempts = 0,
                    lastStableConnection = os.time(),
                    totalDisconnects = 0
                }
            end
            ReconnectionTracking[identifier].attempts = ReconnectionTracking[identifier].attempts + 1
            ReconnectionTracking[identifier].lastStableConnection = os.time()

            -- Notify player about reconnection attempts
            if Config.Reconnection.notifications.notifyAttemptsRemaining and Config.Reconnection.maxReconnectAttempts > 0 then
                local remaining = Config.Reconnection.maxReconnectAttempts - ReconnectionTracking[identifier].attempts
                if remaining > 0 then
                    TriggerClientEvent(_event('client:sendNotification'), src,
                        string.format("Reconnection successful! Attempts remaining: %d/%d", remaining, Config.Reconnection.maxReconnectAttempts),
                        "success")
                end
            end

            -- Clear disconnected state
            DisconnectedPlayers[identifier] = nil

            if Config.Reconnection.debugLogs then
                print(string.format("[Reconnection] Player %s reconnected (attempt: %d, total disconnects: %d)",
                    identifier, ReconnectionTracking[identifier].attempts, ReconnectionTracking[identifier].totalDisconnects))
            end
            -- Layer 1:  Main lobby state (mission, tasks, rewards)
            -- Layer 2:  Grate system (shredding machine grates)
            -- Layer 3:  Furnace state (furnace operations)
            -- Layer 4:  Client-side cleanup (prevents duplicates)
            -- Layer 5:  Pressed objects (world scrap objects)
            -- Layer 6:  Press area items (items in press zones)
            -- Layer 7:  Mission tasks (job progression)
            -- Layer 8:  Vehicles (rented vehicles)
            -- Layer 9:  Vehicle grid items (bagaj objeleri - trunk items)
            -- Layer 10: Active press cycles (ongoing operations)
            -- Layer 11: Scrap objects (world spawned items)
            -- Layer 12: Shredding cases (placed cases)
            -- Layer 13: Grate states (client-side grate sync)
            -- Layer 14: Dust states (shredding dust)
            -- Layer 15: Mission UI (final UI state)
            -- Layer 16: Vehicle keys (all rented vehicles)
            -- Layer 17: Rail system (rail/rope positions, bucket state, joysticks)
            -- Layer 18: Crafting tables (buckets, molds, cooling states, model transitions)
            -- Layer 19: Notification (reconnection complete)
            -- ============================================
            -- 1. Main lobby state (mission, tasks, rewards, etc.) - SILENT SYNC (NO UI)
            local jobTaskData = JobTask and JobTask[state.lobbyId] or nil
            TriggerClientEvent(_event('client:ReconnectStateSync'), src, lobby, jobTaskData)

            -- 2. Grate system sync
            TriggerClientEvent('scrap:requestGrateSync', src)

            -- 3. Furnace state sync
            TriggerEvent(_event('server:playerJoinedFurnaceLobby'), state.lobbyId, identifier)

            -- 4. Clear old client-side state before syncing (prevents duplicates)
            TriggerClientEvent(_event('client:clearReconnectState'), src)
            Wait(100) -- Small delay to ensure cleanup completes

            -- 5. Pressed objects sync (world objects)
            if Lobby.GetPressedObjects then
                local pressedObjects = Lobby.GetPressedObjects(state.lobbyId)
                if pressedObjects and #pressedObjects > 0 then
                    if Config.Reconnection.debugLogs then
                        for i, obj in ipairs(pressedObjects) do
                            print(string.format("  [%d] Model: %s, PressID: %s, Pos: %.1f,%.1f,%.1f",
                                i, obj.model or "nil", obj.pressId or "nil",
                                obj.position.x, obj.position.y, obj.position.z))
                        end
                    end
                    TriggerClientEvent(_event('client:syncPressedObjects'), src, state.lobbyId, pressedObjects)
                else
                    if Config.Reconnection.debugLogs then
                        print(string.format("[Reconnect] No pressed objects to sync for player %d (lobby: %s)", src, state.lobbyId))
                    end
                end
            end

            -- 6. Press area items sync (skip items being pressed)
            if Lobby.GetPressAreaItems then
                local pressAreaItems = Lobby.GetPressAreaItems(state.lobbyId)
                if pressAreaItems and next(pressAreaItems) then
                    -- Filter out press areas that are currently cycling
                    local filteredPressAreaItems = {}
                    for pressId, items in pairs(pressAreaItems) do
                        local isPressCycling = lobby.activePressOperations and
                            lobby.activePressOperations[pressId] and
                            lobby.activePressOperations[pressId].cycling

                        if not isPressCycling then
                            -- Only sync items from presses that are NOT currently cycling
                            filteredPressAreaItems[pressId] = items
                        else
                            --print(string.format("[Reconnect] Skipping press %s area items (currently cycling)", pressId))
                        end
                    end

                    if next(filteredPressAreaItems) then
                        TriggerClientEvent(_event('client:syncPressAreaItems'), src, state.lobbyId,
                            filteredPressAreaItems)
                    end
                end
            end

            -- 7. Mission task sync
            if JobTask and JobTask[state.lobbyId] then
                TriggerClientEvent(_event('client:syncMissionTasks'), src, JobTask[state.lobbyId])
            end

            -- 8. Vehicle and grid sync
            if lobby.roomSetting.Vehicle and next(lobby.roomSetting.Vehicle) then
                TriggerClientEvent(_event('client:syncVehicles'), src, lobby.roomSetting.Vehicle)
            end

            -- 9. Vehicle grid items sync (sync all items in vehicle grids for reconnection)
            if lobby.roomSetting.vehicleGrids and next(lobby.roomSetting.vehicleGrids) then
                -- Sync each vehicle's grid items
                for vehKey, gridData in pairs(lobby.roomSetting.vehicleGrids) do
                    if gridData.items and next(gridData.items) then
                        local vehNet = tonumber(vehKey)
                        if vehNet then
                            -- Get attach plan and items from grid
                            local plan = {}
                            local items = {}

                            for itemId, itemData in pairs(gridData.items) do
                                items[itemId] = itemData

                                -- Find item position in grid cells
                                for y = 1, gridData.gridH do
                                    for x = 1, gridData.gridW do
                                        for layer = 1, gridData.maxLayers do
                                            local rec = gridData.cells[y][x].layers[layer]
                                            if rec and rec.itemId == itemId and rec.baseLayer == layer then
                                                plan[itemId] = {
                                                    gx = x,
                                                    gy = y,
                                                    layer = layer
                                                }
                                                goto found_item_position
                                            end
                                        end
                                    end
                                end
                                ::found_item_position::
                            end

                            -- Send full repack to client to spawn all vehicle grid items
                            if next(plan) then
                                -- Count items in plan
                                local itemCount = 0
                                for _ in pairs(plan) do itemCount = itemCount + 1 end

                                TriggerClientEvent('scrap:fullRepack', src, vehNet, gridData.tierKey, plan, items)
                            end
                        end
                    end
                end
            end

            -- 10. Active press cycle sync (if press is running)
            if lobby.activePressOperations then
                for pressId, operation in pairs(lobby.activePressOperations) do
                    if operation.cycling and operation.startTime and operation.duration then
                        local elapsed = (os.time() - operation.startTime) * 1000 -- Convert to ms
                        local remaining = operation.duration - elapsed

                        if remaining > 0 then
                            -- Press is still running, notify reconnecting player to skip press cycle sync
                            -- because they will see the final result when press completes
                            --print(string.format(
                            --    "[Reconnect] Press %s is currently running (elapsed: %dms, remaining: %dms) - player will see results when complete",
                            --    pressId, elapsed, remaining))

                            -- Note: We intentionally don't start press cycle for reconnecting player
                            -- The press cycle is already running on other clients
                            -- When it completes, pressed objects will be synced automatically
                        end
                    end
                end
            end

            Citizen.SetTimeout(500, function() -- Small delay for client to be ready
                local count = syncScrapObjectsToPlayer(src, state.lobbyId)
            end)

            -- 12. Shredding state sync (placed cases and active shredding operations)
            if lobby.shreddingCases and next(lobby.shreddingCases) then
                local syncCount = 0
                local skipCount = 0
                for shredId, caseData in pairs(lobby.shreddingCases) do
                    -- Check if shredding is active for this machine
                    local isShredding = lobby.activeShreddingOps and
                        lobby.activeShreddingOps[shredId] and
                        lobby.activeShreddingOps[shredId].starting

                    if not isShredding then
                        -- Only sync cases that are NOT actively shredding
                        TriggerClientEvent(_event('client:syncPlacedCase'), src, shredId, caseData)
                        syncCount = syncCount + 1
                    else
                        skipCount = skipCount + 1
                        if Config.Reconnection.debugLogs then
                            print(string.format("[Reconnect] Skipping shredder %s case sync (currently shredding)", shredId))
                        end
                    end
                end
                if Config.Reconnection.debugLogs then
                    print(string.format("[Reconnect] Synced %d shredding cases, skipped %d (active)", syncCount, skipCount))
                end
            else
                if Config.Reconnection.debugLogs then
                    print(string.format("[Reconnect] No shredding cases to sync for player %d", src))
                end
            end

            -- 13. Grate state sync (shredding machine grates)
            -- Trigger grate sync request from client
            TriggerClientEvent('scrap:requestGrateSyncFromServer', src)

            -- 14. Dust state sync (shredding machine dust)
            -- Trigger dust sync request from client
            TriggerClientEvent('scrap:requestDustSyncFromServer', src)

            -- 15. Mission UI state
            TriggerClientEvent(_event('client:ReconnectStateSync'), src, lobby, JobTask[state.lobbyId])

            -- 15.5. Furnace states sync (lid, valve, cauldron level, melting state)
            Citizen.Wait(50)
            if lobby.furnaceStates and next(lobby.furnaceStates) then
                for furnaceId, furnaceState in pairs(lobby.furnaceStates) do
                    TriggerClientEvent(_event('client:syncFurnaceReconnect'), src, furnaceId, {
                        isLidOpen = furnaceState.isLidOpen or false,
                        valveOpen = furnaceState.valveOpen or false,
                        valveRotation = furnaceState.valveRotation or 0,
                        isMelting = furnaceState.isMelting or false,
                        cauldronLevel = furnaceState.cauldronLevel or 0
                    })
                    print(string.format("[Reconnect] Synced furnace %s state (lid: %s, valve: %s, cauldron: %.1f)",
                        furnaceId, tostring(furnaceState.isLidOpen), tostring(furnaceState.valveOpen), furnaceState.cauldronLevel or 0))
                end
            end

            -- 15.6. Blip sync (vehicle return, scrapyard, vehicle rental blips)
            Citizen.Wait(50)
            if lobby.roomSetting and lobby.roomSetting.startJob then
                TriggerClientEvent(_event('client:syncJobBlips'), src)
                if Config.Reconnection.debugLogs then
                    print(string.format("[Reconnect] Triggered blip sync for player %d (job active)", src))
                end
            end

            -- 16. Vehicle keys sync (give keys to all rented vehicles)
            if lobby.roomSetting.VehicleNetId and next(lobby.roomSetting.VehicleNetId) then
                -- Delay to ensure vehicles are spawned on client
                Citizen.SetTimeout(500, function()
                    TriggerClientEvent(_event('client:syncVehicleKeys'), src)
                end)
            end

            -- 17. Rail system sync (rail/rope positions, bucket state, joystick positions)
            Citizen.SetTimeout(600, function()
                local railSynced = false

                -- Sync rail and rope positions
                if lobby.railPositions then
                    if lobby.railPositions.rail or lobby.railPositions.rope then
                        TriggerClientEvent(_event('client:syncRailSpawn'), src, lobby.railPositions.rail,
                            lobby.railPositions.rope)
                        railSynced = true
                    end
                end

                -- Sync bucket states
                if lobby.bucketStates then
                    if lobby.bucketStates.hasBucket ~= nil then
                        TriggerClientEvent(_event('client:syncHookBucket'), src, lobby.bucketStates.hasBucket,
                            lobby.bucketStates.isFull or false)

                        railSynced = true
                    end
                    if lobby.bucketStates.fillLevel then
                        TriggerClientEvent(_event('client:syncBucketFill'), src, lobby.bucketStates.fillLevel)
                    end
                end

                -- Sync joystick positions
                if lobby.joystickPositions then
                    if lobby.joystickPositions.vertical then
                        TriggerClientEvent(_event('client:syncVerticalJoystick'), src, lobby.joystickPositions.vertical)
                        railSynced = true
                    end
                    if lobby.joystickPositions.horizontal then
                        TriggerClientEvent(_event('client:syncHorizontalJoystick'), src,
                            lobby.joystickPositions.horizontal)
                        railSynced = true
                    end
                end

                -- Sync rail controller state
                if lobby.railControllers then
                    TriggerClientEvent(_event('client:railControllerChanged'), src, lobby.railControllers.playerId, true)
                    railSynced = true
                end

                if not railSynced then
                    print(string.format("[Reconnect] No rail state to sync for player %d", src))
                end
            end)

            -- 18. Crafting tables sync (buckets, molds, cooling states, model transitions)
            Citizen.SetTimeout(700, function()
                local craftingSynced = false

                -- Sync all crafting table states
                if lobby.craftingTableStates and next(lobby.craftingTableStates) then
                    -- CRITICAL: Force update all cooling states BEFORE sending to reconnecting player
                    local currentTime = GetGameTimer()
                    local coolingTime = Config.MetalPouring and Config.MetalPouring.coolingTime or 10000
                    local transitionDuration = Config.MetalPouring and Config.MetalPouring.transitionDuration or 5000

                    for tableId, tableState in pairs(lobby.craftingTableStates) do
                        if tableState.molds then
                            for moldId, moldData in pairs(tableState.molds) do
                                -- CRITICAL FIX: If isCooling=true but isReady=true, cooling already finished
                                -- This happens when cooling completed but state wasn't cleaned up properly
                                if moldData.isCooling and moldData.isReady then
                                    -- Contradiction detected - cooling can't be both done and not done
                                    -- Force to ready state
                                    moldData.isCooling = false
                                    moldData.coolingStartTime = nil
                                    moldData.isTransitioning = false
                                    moldData.currentAlpha = 100.0
                                    moldData.beforeEntityExists = false
                                    moldData.afterEntityExists = true

                                    if Config.Reconnection.debugLogs then
                                        print(string.format("[Reconnect] Mold %s/%s: Fixed contradiction (isReady=true + isCooling=true) → Force ready",
                                            tableId, moldId))
                                    end
                                elseif moldData.coolingStartTime then
                                    -- Has coolingStartTime - check if cooling finished or still ongoing
                                    local coolingElapsed = currentTime - moldData.coolingStartTime

                                    if coolingElapsed >= coolingTime then
                                        -- Cooling COMPLETE - force ready state
                                        moldData.isReady = true
                                        moldData.isCooling = false
                                        moldData.coolingStartTime = nil
                                        moldData.isTransitioning = false
                                        moldData.currentAlpha = 100.0
                                        moldData.beforeEntityExists = false
                                        moldData.afterEntityExists = true

                                        if Config.Reconnection.debugLogs then
                                            print(string.format("[Reconnect] Mold %s/%s: Cooling COMPLETE (elapsed %dms, completed %dms ago)",
                                                tableId, moldId, coolingElapsed, coolingElapsed - coolingTime))
                                        end
                                    else
                                        -- Still cooling - force cooling state and calculate alpha
                                        moldData.isCooling = true
                                        moldData.isReady = false
                                        local transitionProgress = math.min(1.0, coolingElapsed / transitionDuration)
                                        moldData.currentAlpha = transitionProgress * 100.0
                                        moldData.isTransitioning = (transitionProgress < 1.0)
                                        moldData.beforeEntityExists = (transitionProgress < 1.0)
                                        moldData.afterEntityExists = (transitionProgress > 0.5)

                                        if Config.Reconnection.debugLogs then
                                            print(string.format("[Reconnect] Mold %s/%s: Still COOLING (%.1f%%, alpha: %.1f, %dms remaining)",
                                                tableId, moldId, transitionProgress * 100, moldData.currentAlpha,
                                                coolingTime - coolingElapsed))
                                        end
                                    end
                                end
                            end
                        end
                    end

                    -- Now send the updated states to reconnecting player
                    for tableId, tableState in pairs(lobby.craftingTableStates) do
                        local tableSyncData = {
                            tableId = tableId,
                            bucketMetalRemaining = tableState.bucketMetalRemaining,
                            molds = {}
                        }

                        -- Collect mold data (already updated above)
                        if tableState.molds then
                            for moldId, moldData in pairs(tableState.molds) do
                                tableSyncData.molds[moldId] = {
                                    fillLevel = moldData.fillLevel or 0,
                                    isCooling = moldData.isCooling or false,
                                    coolingStartTime = moldData.coolingStartTime,
                                    isReady = moldData.isReady or false,
                                    isTransitioning = moldData.isTransitioning or false,
                                    transitionStartTime = moldData.transitionStartTime,
                                    currentAlpha = moldData.currentAlpha,
                                    beforeEntityExists = moldData.beforeEntityExists or false,
                                    afterEntityExists = moldData.afterEntityExists or false
                                }

                                if Config.Reconnection.debugLogs then
                                    print(string.format("[Reconnect] Syncing Table %s Mold %s: isReady=%s, isCooling=%s, alpha=%.1f, fillLevel=%.2f",
                                        tableId, moldId, tostring(moldData.isReady), tostring(moldData.isCooling),
                                        moldData.currentAlpha or 0, moldData.fillLevel or 0))
                                end
                            end
                        end

                        -- Send table state to reconnecting player
                        TriggerClientEvent(_event('client:syncCraftingTableState'), src, tableSyncData)
                        craftingSynced = true
                    end
                end

                if not craftingSynced then
                    print(string.format("[Reconnect] No crafting table state to sync for player %d", src))
                end
            end)

            -- 19. Reconnection notification (notify other players if enabled)
            if Config.Reconnection.notifications.notifyOnReconnect then
                for _, otherPlayer in ipairs(lobby.players) do
                    if otherPlayer.source > 0 and otherPlayer.source ~= src then
                        TriggerClientEvent(_event('client:sendNotification'), otherPlayer.source,
                            string.format(Locales[Config.Locale]['lobby_player_reconnected'], player.playerName),
                            "success")
                    end
                end
            end

            return true
        end
    end

    -- Player not found in lobby, clear state
    DisconnectedPlayers[identifier] = nil

    return false
end

-- Cleanup lobbies that no longer exist (runs every 5 minutes)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000) -- Check every 5 minutes

        local cleanedCount = 0

        for identifier, state in pairs(DisconnectedPlayers) do
            -- Only cleanup if lobby no longer exists
            if not coopData[state.lobbyId] then
                DisconnectedPlayers[identifier] = nil
                cleanedCount = cleanedCount + 1
            end
        end

        if cleanedCount > 0 then
            print(string.format("[Reconnection] Cleaned up %d disconnected players (lobbies no longer exist)",
                cleanedCount))
        end
    end
end)

function discordloghistoryData(source, data)
    return {
        identifier = GetIdentifier(source),
        avatar = GetDiscordAvatar(source) or Config.ExampleProfilePicture,
        name = GetName(source),
        id = source,
        money = data.money,
        owneridentifier = data.owneridentifier,
    }
end

local FormattedToken = "Bot " .. bot_Token
function DiscordRequest(method, endpoint, jsondata, callback)
    PerformHttpRequest(
        "https://discordapp.com/api/" .. endpoint,
        function(errorCode, resultData, resultHeaders)
            if callback then
                callback({ data = resultData, code = errorCode, headers = resultHeaders })
            end
        end,
        method,
        #jsondata > 0 and json.encode(jsondata) or "",
        { ["Content-Type"] = "application/json", ["Authorization"] = FormattedToken }
    )
end

function GetDiscordAvatar(user)
    local discordId = nil
    local imgURL = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if discordId then
        if Caches.Avatars[discordId] == nil then
            imgURL = Config.ExampleProfilePicture

            local endpoint = ("users/%s"):format(discordId)
            DiscordRequest("GET", endpoint, {}, function(member)
                if member.code == 200 then
                    local data = json.decode(member.data)
                    if data ~= nil and data.avatar ~= nil then
                        if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then
                            Caches.Avatars[discordId] = "https://media.discordapp.net/avatars/" ..
                                discordId .. "/" .. data.avatar .. ".gif"
                        else
                            Caches.Avatars[discordId] = "https://media.discordapp.net/avatars/" ..
                                discordId .. "/" .. data.avatar .. ".png"
                        end
                    end
                end
            end)
        else
            imgURL = Caches.Avatars[discordId]
        end
    end
    return imgURL or Config.ExampleProfilePicture
end

function sendDiscordLogHistory(data)
    Citizen.CreateThread(function()
        local message = {
            username = bot_name,
            embeds = {
                {
                    title = botname,
                    color = 0xFFA500,
                    author = {
                        name = 'Tworst  Scrapyard - JOB FINISH',
                    },
                    thumbnail = {
                        url = data.avatar
                    },
                    fields = {
                        { name = "Player Name", value = data.name or false,            inline = true },
                        { name = "Player ID",   value = data.id or false,              inline = true },
                        { name = "Owner ID",    value = data.owneridentifier or false, inline = true },
                        {
                            name = "──────────Job Information──────────",
                            value = "",
                            inline = false
                        },
                        { name = "Job Price", value = string.format("%s%d", Config.MoneyType, tonumber(data.money) or 'undefined'), inline = true },

                    },
                    footer = {
                        text = "Tworst Store - https://discord.gg/tworst",
                        icon_url =
                        "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png"
                    },

                    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }
            },
            avatar_url = bot_logo
        }

        PerformHttpRequest(discord_webhook['jobfinish'], function(err, text, headers)
                if err and err ~= 204 then
                    print("Discord log error:", err)
                end
            end,
            "POST",
            json.encode(message),
            { ["Content-Type"] = "application/json" })
    end)
end

AddEventHandler('playerDropped', function(reason)
    local src = source
    local playerIdentifier = GetIdentifier(src)
    if not playerIdentifier then return end

    local isOwner = coopData[playerIdentifier] ~= nil

    if isOwner then
        -- Check if owner transfer is enabled
        if not Config.Reconnection.ownerTransfer.enabled then
            -- Owner transfer disabled - close lobby immediately
            local lobby = coopData[playerIdentifier]
            if lobby then
                if Config.Reconnection.debugLogs then
                    print(string.format("[Disconnect] Owner %s disconnected - closing lobby (owner transfer disabled)", playerIdentifier))
                end

                -- Notify all players and close lobby
                for _, player in ipairs(lobby.players) do
                    if player.source > 0 and player.source ~= src then
                        TriggerClientEvent(_event('client:resetjob'), player.source)
                        TriggerClientEvent(_event('client:sendNotification'), player.source,
                            "Lobby closed: Owner disconnected",
                            "error")
                    end
                end

                -- Clean up lobby (vehicles, objects, etc.)
                -- ... existing cleanup code ...
                coopData[playerIdentifier] = nil
                JobTask[playerIdentifier] = nil
            end
            return
        end

        local transferred, newOwner = Lobby.HandleOwnerDisconnect(playerIdentifier, src)

        if transferred then
            local lobby = coopData[newOwner.playerIdentifier]

            -- DON'T delete vehicles on owner disconnect - they should stay for reconnection
            -- Vehicles belong to the lobby, not individual players

            -- Notify remaining players about new owner
            for _, player in ipairs(lobby.players) do
                if player.source > 0 then
                    TriggerClientEvent(_event('client:sendNotification'), player.source,
                        string.format(Locales[Config.Locale]['lobby_owner_disconnected_new_owner'], newOwner.playerName),
                        "info")
                end
            end
        else
            -- Owner disconnected and no replacement found - delete entire lobby
            local lobby = coopData[playerIdentifier]
            if lobby and lobby.roomSetting then
                -- Delete all lobby vehicles and cleanup rental system
                if lobby.roomSetting.VehicleNetId then
                    for _, netId in pairs(lobby.roomSetting.VehicleNetId) do
                        -- Find and delete vehicle by netID
                        for plate, rental in pairs(rentalByPlate) do
                            if rental.netID == netId then
                                if Config.Debug then
                                    print(("[Editable:playerDropped] Clearing rental plate: '%s' (netId: %s) due to owner disconnect"):format(plate, tostring(netId)))
                                end
                                local vehicleKey = rental.vehicleKey
                                local info = spawnedByKey[vehicleKey]

                                if info and info.entity and DoesEntityExist(info.entity) then
                                    DeleteEntity(info.entity)
                                end

                                -- Clean up rental data
                                if info then
                                    info.rented = false
                                    info.rentedBy = nil
                                    info.rentedTime = nil
                                    info.lobbyId = nil
                                end

                                -- Remove from rental tracking
                                rentalByPlate[plate] = nil

                                -- Clean up grid state
                                if info and info.netID and vehicleGridStates[info.netID] then
                                    vehicleGridStates[info.netID] = nil
                                end
                                break
                            end
                        end
                    end
                end

                if Lobby.ClearPressedObjects then
                    Lobby.ClearPressedObjects(playerIdentifier)
                    Lobby.ClearAllPressAreaItems(playerIdentifier)
                end

                for _, player in ipairs(lobby.players) do
                    if player.source ~= src and player.source > 0 then
                        TriggerClientEvent(_event('client:resetjob'), player.source)
                        TriggerClientEvent(_event('client:sendNotification'), player.source,
                            Locales[Config.Locale]['lobby_closed_no_replacement'],
                            "error")
                        TriggerClientEvent(_event('client:clearLobbyPressedObjects'), player.source, playerIdentifier)
                    end
                end

                -- Clean up lobby data
                coopData[playerIdentifier] = nil
                JobTask[playerIdentifier] = nil
            end
        end
    else
        -- NON-OWNER PLAYER DISCONNECTED - Try grace period
        local lobbyInfo = Lobby.GetPlayerLobbyByIdentifier(playerIdentifier)

        if lobbyInfo then
            local lobby = lobbyInfo.lobbyData
            local ownerIdentifier = lobbyInfo.lobbyId

            -- Find player data in lobby
            local playerData = nil
            for _, player in ipairs(lobby.players) do
                if player.playerIdentifier == playerIdentifier then
                    playerData = player
                    break
                end
            end

            if playerData then
                -- DON'T delete vehicles on disconnect - they should stay for reconnection
                -- Only remove keys from disconnecting player to prevent abuse

                -- CRITICAL: Clean up active operations locks for disconnecting player
                -- This prevents deadlocks when player disconnects during operations
                -- NOTE: Cleanup is ALWAYS enabled (not configurable) to prevent deadlocks
                if lobby.activePressOperations then
                    for pressId, ops in pairs(lobby.activePressOperations) do
                        if ops.placing == src then
                            ops.placing = nil
                            if Config.Reconnection.debugLogs then
                                print(string.format("[Disconnect Cleanup] Cleared press %s placing lock for player %d", pressId, src))
                            end
                        end
                        if ops.cycling == src then
                            -- Don't clear cycling - press cycle continues for lobby
                            -- ops.cycling = nil
                        end
                        if ops.picking == src then
                            ops.picking = nil
                            if Config.Reconnection.debugLogs then
                                print(string.format("[Disconnect Cleanup] Cleared press %s picking lock for player %d", pressId, src))
                            end
                        end
                    end
                end

                -- Clean up shredding operations locks
                if lobby.activeShreddingOps then
                    for shredId, ops in pairs(lobby.activeShreddingOps) do
                        if ops.placing == src then
                            ops.placing = nil
                            if Config.Reconnection.debugLogs then
                                print(string.format("[Disconnect Cleanup] Cleared shredder %s placing lock for player %d", shredId, src))
                            end
                        end
                        if ops.starting == src then
                            -- Don't clear starting - shredding cycle continues for lobby
                            -- ops.starting = nil
                        end
                    end
                end

                -- Clean up carrying items state
                if lobby.carryingItems and lobby.carryingItems[src] then
                    lobby.carryingItems[src] = nil
                    if Config.Reconnection.debugLogs then
                        print(string.format("[Disconnect Cleanup] Cleared carrying items state for player %d", src))
                    end
                end

                -- Clean up pickup locks
                if lobby.pickupLocks then
                    for lockKey, lockedBySrc in pairs(lobby.pickupLocks) do
                        if lockedBySrc == src then
                            lobby.pickupLocks[lockKey] = nil
                            if Config.Reconnection.debugLogs then
                                print(string.format("[Disconnect Cleanup] Cleared pickup lock %s for player %d", lockKey, src))
                            end
                        end
                    end
                end

                -- Store player state for reconnection
                StoreDisconnectedPlayerState(playerIdentifier, ownerIdentifier, playerData)

                -- Update player's source to 0 (offline but in grace period, avoids -1 broadcast bug)
                playerData.source = 0

                -- Notify other players (if enabled in config)
                if Config.Reconnection.notifications.notifyOnDisconnect then
                    for _, otherPlayer in ipairs(lobby.players) do
                        if otherPlayer.source > 0 and otherPlayer.source ~= src then
                            TriggerClientEvent(_event('client:sendNotification'), otherPlayer.source,
                                string.format(Locales[Config.Locale]['lobby_player_disconnected'], playerData.playerName),
                                "error")
                        end
                    end
                end
            end
        end
    end
end)

