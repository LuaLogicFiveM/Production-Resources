local recentLogs = {}

local function sendToDiscord(title, description, playerInfo)
    local logIdentifier = playerInfo.source .. "_" .. title .. "_" .. math.floor(GetGameTimer() / 1000)
    if recentLogs[logIdentifier] then return end

    recentLogs[logIdentifier] = true

    SetTimeout(2000, function()
        recentLogs[logIdentifier] = nil
    end)

    local time = os.date("%H:%M:%S")
    local date = os.date("%d.%m.%Y")
    local embed = {
        {
            ["title"] = "📝 " .. title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = 3447003,
            ["author"] = {
                ["name"] = playerInfo.name .. " (ID: " .. playerInfo.source .. ")",
                ["icon_url"] = "https://ui-avatars.com/api/?background=random&name=" .. playerInfo.name
            },
            ["thumbnail"] = {
                ["url"] = "https://repository-images.githubusercontent.com/183337178/699b2500-cad9-11e9-9e0a-96af2a134587",
            },
            ["footer"] = {
                ["text"] = date .. " | " .. time .. " | Leaned Out RP",
                ["icon_url"] = 'https://i.ibb.co/YLLNHJP/lorp-logo-main.png'
            },
            ["fields"] = {
                {
                    ["name"] = "📍 Location",
                    ["value"] = "X: " .. math.floor(playerInfo.coords.x) .. ", Y: " .. math.floor(playerInfo.coords.y) .. ", Z: " .. math.floor(playerInfo.coords.z),
                    ["inline"] = true
                }
            }
        }
    }

    PerformHttpRequest('https://ptb.discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa', function(err, text, headers) end, 'POST', json.encode({
        username = 'TxAdmin Logs',
        embeds = embed,
        avatar_url = 'https://i.ibb.co/YLLNHJP/lorp-logo-main.png'
    }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('lorp_packed:server:send')
AddEventHandler('lorp_packed:server:send', function(title, description, playerInfo)
    sendToDiscord(title, description, playerInfo)
end)

RegisterServerEvent('txsv:req:tpToPlayer')
AddEventHandler('txsv:req:tpToPlayer', function(targetId)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    local targetName = GetPlayerName(targetId)
    sendToDiscord('Teleport To Player', 'Teleported to player: ' .. targetName .. ' (ID: ' .. targetId .. ')', playerInfo)
end)

RegisterServerEvent('txsv:req:bringPlayer')
AddEventHandler('txsv:req:bringPlayer', function(targetId)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    local targetName = GetPlayerName(targetId)
    sendToDiscord('Summon Player', 'Summoned player: ' .. targetName .. ' (ID: ' .. targetId .. ')', playerInfo)
end)

RegisterServerEvent('txsv:req:clearArea')
AddEventHandler('txsv:req:clearArea', function(radius)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Clear Area', 'Cleared area with radius: ' .. radius, playerInfo)
end)

RegisterServerEvent('txsv:req:healPlayer')
AddEventHandler('txsv:req:healPlayer', function(targetId)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    local targetName = GetPlayerName(targetId)
    sendToDiscord('Heal Player', 'Healed player: ' .. targetName .. ' (ID: ' .. targetId .. ')', playerInfo)
end)

RegisterServerEvent('txsv:req:healEveryone')
AddEventHandler('txsv:req:healEveryone', function()
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }

    sendToDiscord('Heal All Players', 'Healed all players on the server', playerInfo)
end)

RegisterServerEvent('txsv:req:sendAnnouncement')
AddEventHandler('txsv:req:sendAnnouncement', function(message)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Announcement', 'Sent announcement: ' .. message, playerInfo)
end)

RegisterServerEvent('txsv:req:tpToCoords')
AddEventHandler('txsv:req:tpToCoords', function(x, y, z)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Teleport To Coordinates', 'Teleported to coordinates: X: ' .. x .. ', Y: ' .. y .. ', Z: ' .. z, playerInfo)
end)

RegisterServerEvent('txsv:req:tpToWaypoint')
AddEventHandler('txsv:req:tpToWaypoint', function()
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Teleport To Waypoint', 'Teleported to waypoint', playerInfo)
end)

RegisterServerEvent('txsv:req:healMyself')
AddEventHandler('txsv:req:healMyself', function()
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Heal Self', 'Healed themselves', playerInfo)
end)

RegisterServerEvent('txsv:req:tpBack')
AddEventHandler('txsv:req:tpBack', function()
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Teleport Back', 'Teleported back to previous location', playerInfo)
end)

RegisterServerEvent('txsv:req:freezePlayer')
AddEventHandler('txsv:req:freezePlayer', function(targetId)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    local targetName = GetPlayerName(targetId)
    sendToDiscord('Player Freeze', 'Toggled freeze status for player: ' .. targetName .. ' (ID: ' .. targetId .. ')', playerInfo)
end)

RegisterServerEvent('txsv:req:spectate:cycle')
AddEventHandler('txsv:req:spectate:cycle', function(currentTargetId, isNextPlayer)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    local direction = isNextPlayer and "next" or "previous"
    sendToDiscord('Player Spectate', 'Cycled to ' .. direction .. ' player from: ' .. GetPlayerName(currentTargetId) .. ' (ID: ' .. currentTargetId .. ')', playerInfo)
end)

RegisterServerEvent('txsv:req:vehicle:fix')
AddEventHandler('txsv:req:vehicle:fix', function()
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Vehicle Fix', 'Repaired current vehicle', playerInfo)
end)

RegisterServerEvent('txsv:req:vehicle:boost')
AddEventHandler('txsv:req:vehicle:boost', function()
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Vehicle Boost', 'Boosted current vehicle', playerInfo)
end)

RegisterServerEvent('txsv:req:vehicle:spawn:fivem')
AddEventHandler('txsv:req:vehicle:spawn:fivem', function(model, modelType)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Vehicle Spawn', 'Spawned vehicle: ' .. model, playerInfo)
end)

RegisterServerEvent('txsv:req:vehicle:delete')
AddEventHandler('txsv:req:vehicle:delete', function(vehNetId)
    local playerInfo = {
        name = GetPlayerName(source),
        coords = GetEntityCoords(GetPlayerPed(source)),
        source = source
    }
    sendToDiscord('Vehicle Delete', 'Deleted a vehicle', playerInfo)
end)

RegisterServerEvent('txsv:logger:menuEvent')
AddEventHandler('txsv:logger:menuEvent', function(src, eventType, allowed, data)
    if not allowed then return end

    local playerInfo = {
        name = GetPlayerName(src),
        coords = GetEntityCoords(GetPlayerPed(src)),
        source = src
    }

    local title = 'TxAdmin Action'
    local description = 'Unknown action'
    local skipEvents = {
        ['vehicleRepair'] = true,
        ['vehicleBoost'] = true,
        ['spawnVehicle'] = true,
        ['deleteVehicle'] = true
    }

    if skipEvents[eventType] then return end

    if eventType == 'teleportCoords' then
        title = 'Teleport To Coordinates'
        description = 'Teleported to coordinates: X: ' .. data.x .. ', Y: ' .. data.y .. ', Z: ' .. data.z
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'teleportWaypoint' then
        title = 'Teleport To Waypoint'
        description = 'Teleported to waypoint'
        if data then
            description = description .. ' at X: ' .. data.x .. ', Y: ' .. data.y .. ', Z: ' .. data.z
        end
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'healSelf' then
        title = 'Heal Self'
        description = 'Healed themselves'
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'healPlayer' then
        title = 'Heal Player'
        local targetName = "Unknown"
        if type(data) == 'number' then
            targetName = GetPlayerName(data) or "ID: " .. data
        end
        description = 'Healed player: ' .. targetName
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'freezePlayer' then
        title = 'Player Freeze'
        local targetName = "Unknown"
        if type(data) == 'number' then
            targetName = GetPlayerName(data) or "ID: " .. data
        end
        description = 'Toggled freeze for player: ' .. targetName
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'drunkEffect' then
        title = 'Troll - Set Drunk'
        local targetName = "Unknown"
        if type(data) == 'number' then
            targetName = GetPlayerName(data) or "ID: " .. data
        end
        description = 'Set player drunk: ' .. targetName
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'setOnFire' then
        title = 'Troll - Set On Fire'
        local targetName = "Unknown"
        if type(data) == 'number' then
            targetName = GetPlayerName(data) or "ID: " .. data
        end
        description = 'Set player on fire: ' .. targetName
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'wildAttack' then
        title = 'Troll - Wild Attack'
        local targetName = "Unknown"
        if type(data) == 'number' then
            targetName = GetPlayerName(data) or "ID: " .. data
        end
        description = 'Triggered wild attack on player: ' .. targetName
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'vehicleRepair' then
        title = 'Vehicle Fix'
        description = 'Repaired current vehicle'
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'vehicleBoost' then
        title = 'Vehicle Boost'
        description = 'Boosted current vehicle'
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'spawnVehicle' then
        title = 'Vehicle Spawn'
        description = 'Spawned vehicle'
        if data then
            description = description .. ': ' .. data
        end
        sendToDiscord(title, description, playerInfo)
    elseif eventType == 'deleteVehicle' then
        title = 'Vehicle Delete'
        description = 'Deleted a vehicle'
        sendToDiscord(title, description, playerInfo)
    end
end)

--[[AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    local reason = eventData.reason
    local author = eventData.author
    local playerId = eventData.targetNetId
    local playerKicked = ESX.GetPlayerFromId(playerId)

    if playerKicked then
        TriggerClientEvent("chat:addMessage", -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.6); border-left: 4px solid rgb(200, 25, 0); border-radius: 7px;"><img src="https://i.ibb.co/5x4dPVRN/Caution-Warning.png" height="18" width="18" style="position: absolute; border-radius: 50%; left: 20px;"></img><i class="fas fa-globe"></i> <text style="position: sticky; margin-left: 4.5%;">^1 Admin System:^0 {2} has been banned by {1} for {0}.</div>',
            args = { reason, author, playerKicked.getName() },
        })
    else

    end
end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    local reason = eventData.reason
    local author = eventData.author
    local playerId = eventData.target
    local playerKicked = ESX.GetPlayerFromId(playerId)

    TriggerClientEvent("chat:addMessage", -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.6); border-left: 4px solid rgb(200, 25, 0); border-radius: 7px;"><img src="https://i.ibb.co/5x4dPVRN/Caution-Warning.png" height="18" width="18" style="position: absolute; border-radius: 50%; left: 20px;"></img><i class="fas fa-globe"></i> <text style="position: sticky; margin-left: 4.5%;">^1 Admin System:^0 {2} has been kicked by {1} for {0}.</div>',
        args = { reason, author, playerKicked.getName() },
    })
end)]]