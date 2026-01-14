local postals = require 'data.postals'

RegisterNetEvent("lorp_postals:client:requestWaypoint", function(selectedPostal)
    local userPostal = string.upper(selectedPostal)
    local setPostal = postals[userPostal]

    if not setPostal then
        return lib.notify({title = 'Postals', description = 'Postal ' .. userPostal .. ' does not exist', type = 'error', position = 'top'})
    end

    if IsWaypointActive() then
        DeleteWaypoint()
    end

    SetNewWaypoint(setPostal.x, setPostal.y)
    lib.notify({title = 'Postals', description = 'You set your postal to '..userPostal, type = 'success', position = 'top'})
end)

local function getNearestPostal()
    local playerCoords = GetEntityCoords(cache.ped)
    local px, py = playerCoords.x, playerCoords.y

    local nearest = nil
    local shortestDist = math.huge

    for _, postal in pairs(postals) do
        local dist = #(vector2(px, py) - vector2(postal.x, postal.y))
        if dist < shortestDist then
            shortestDist = dist
            nearest = _
        end
    end

    return nearest or "Loading..."
end exports('getNearestPostal', getNearestPostal)