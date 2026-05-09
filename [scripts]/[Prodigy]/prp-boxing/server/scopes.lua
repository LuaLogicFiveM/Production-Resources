ScopePlayers = {}

AddEventHandler("playerEnteredScope", function(data)
	local source = tostring(data["for"])
	local target = tostring(data.player)
    
    if ScopePlayers[source] == nil then ScopePlayers[source] = {} end

    ScopePlayers[source][target] = true
end)

AddEventHandler("playerLeftScope", function(data)
	local source = tostring(data["for"])
	local target = tostring(data.player)

    if ScopePlayers[source] then ScopePlayers[source][target] = nil end
end)

AddEventHandler("playerDropped", function(reason)
    local _source = tostring(source)
    Citizen.Wait(100)
    if ScopePlayers[_source] then ScopePlayers[_source] = nil end

    for k, v in pairs(ScopePlayers) do
        if v and v[_source] then
            ScopePlayers[k][_source] = nil
        end
    end
end)

function GetClosestPlayers(sourcePlayer)
    return ScopePlayers[tostring(sourcePlayer)]
end

exports("GetClosestPlayers", GetClosestPlayers)

function TriggerClientEventForClosestPlayers(sourcePlayer, eventName, ...)
    local payload = msgpack.pack_args(...)
    local len = payload:len()

    TriggerClientEventInternal(eventName, sourcePlayer, payload, len)
    
    if ScopePlayers[tostring(sourcePlayer)] then
        for k, v in pairs(ScopePlayers[tostring(sourcePlayer)]) do
            TriggerClientEventInternal(eventName, tostring(k), payload, len)
        end
    end
end

exports("TriggerClientEventForClosestPlayers", TriggerClientEventForClosestPlayers)

Citizen.CreateThread(function()
    if not Config.Debug then return end
    local players = GetPlayers()
    for k, v in pairs(players) do
        ScopePlayers[tostring(v)] = {}
        local coords = GetEntityCoords(GetPlayerPed(v))
        for k2, v2 in pairs(players) do
            if v ~= v2 then
                local coords2 = GetEntityCoords(GetPlayerPed(v2))
                if #(coords - coords2) < 50.0 then
                    ScopePlayers[tostring(v)][tostring(v2)] = true
                end
            end
        end
    end
end)