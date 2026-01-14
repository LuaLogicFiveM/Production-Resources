-- [[ Exports ]]
-- Follow our documentation for more information: https://docs.rytrak.fr/scripts/advanced-police-grab-ped/general-exports

-- Export to grab a player
exports('GrabPlayer', function(playerId)
    if not verifyPlayerJob() then return end

    grabPlayer(playerId)
end)

-- Export to put the grabbed player into a nearby vehicle
exports('PutPlayerInVehicle', function()
    if not verifyPlayerJob() then return end

    putPlayerInVehicle(true)
end)

-- Export to remove a player from a nearby vehicle
exports('RemovePlayerFromVehicle', function()
    if not verifyPlayerJob() then return end

    removePlayerFromVehicle(true)
end)

-- Export to get out the player of the nearby vehicle
-- @return boolean `true` if the player is grabbed, `false` otherwise.
exports('IsGrabbed', function()
    if draggedByPlayer ~= nil then
        return true
    else
        return false
    end
end)