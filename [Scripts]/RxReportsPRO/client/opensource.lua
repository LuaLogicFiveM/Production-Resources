--[[
BY RX Scripts © rxscripts.xyz
--]]

RegisterNetEvent('rxreports:healPlayer', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    ClearPedBloodDamage(playerPed)
    ClearPedTasksImmediately(playerPed)
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    SetPlayerSprint(PlayerId(), true)
    ResetPedMovementClipset(playerPed, 0.0)
end)

RegisterNetEvent('rxreports:spectatePlayer', function(spectateId)
    -- One of these is correct depending on your txAdmin version
    TriggerServerEvent('txsv:req:spectate:start', spectateId)
    TriggerServerEvent('txAdmin:menu:spectatePlayer', spectateId)
end)