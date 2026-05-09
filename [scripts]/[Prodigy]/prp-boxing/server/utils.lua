function CreateHitbox(center, width, length, height, heading)
    local rad = math.rad(heading)
    local cosH = math.cos(rad)
    local sinH = math.sin(rad)

    local hw = width / 2
    local hl = length / 2
    local hh = height / 2

    local corners = {
        vector3(-hw, -hl, -hh),
        vector3(-hw,  hl, -hh),
        vector3( hw,  hl, -hh),
        vector3( hw, -hl, -hh),
        vector3(-hw, -hl,  hh),
        vector3(-hw,  hl,  hh),
        vector3( hw,  hl,  hh),
        vector3( hw, -hl,  hh)
    }

    for i, c in ipairs(corners) do
        local x = c.x * cosH - c.y * sinH
        local y = c.x * sinH + c.y * cosH
        corners[i] = vector3(center.x + x, center.y + y, center.z + c.z)
    end

    return corners
end

function CheckHitbox(point, center, width, length, height, heading)
    local rad = math.rad(-heading)
    local dx = point.x - center.x
    local dy = point.y - center.y
    local dz = point.z - center.z

    local x = dx * math.cos(rad) - dy * math.sin(rad)
    local y = dx * math.sin(rad) + dy * math.cos(rad)
    local z = dz

    return math.abs(x) <= width / 2
       and math.abs(y) <= length / 2
       and math.abs(z) <= height / 2
end

function OffsetPosition(position, heading, offsetX, offsetY, offsetZ)
    local rad = math.rad(heading)
    local sinH = math.sin(rad)
    local cosH = math.cos(rad)

    local x = position.x + offsetX * cosH - offsetY * sinH
    local y = position.y + offsetX * sinH + offsetY * cosH
    local z = position.z + offsetZ

    return vector3(x, y, z)
end


function DebugPrint(...)
    if DebugOn then
        print("[Boxing] ", ...)
    end
end

function ShowNotification(playerSource, message, notifyType)
    TriggerClientEvent("prp-hud:notify", playerSource, notifyType, message)
end

function GetNearbyPlayers(playerSource, coords, distance)
    local closePlayers = {}
    local players = GetClosestPlayers(playerSource)
    if(not players) then return {} end
    for source, _ in pairs(players) do
        local ping = GetPlayerPing(source)
        if(ping < 500 and ping > 0) then
            local playerPed = GetPlayerPed(source)
            if(DoesEntityExist(playerPed) and #(GetEntityCoords(playerPed) - coords) <= distance) then
                local stateId = bridge.fw.getIdentifier(source)
                table.insert(closePlayers, { source = tonumber(source), name = bridge.fw.getCharacterName(stateId) })
            end
        end
    end

    if Config.Debug then
        lib.print.info("all players", players)
        lib.print.info("nearby players", closePlayers)
    end
    
    return closePlayers
end
