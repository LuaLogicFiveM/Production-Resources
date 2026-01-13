ESX = exports['es_extended']:getSharedObject()
PlayerData = {}
PlayerLoaded = false

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local data = ESX.GetPlayerData()
        if data and data.job then
            PlayerData = data
            PlayerLoaded = true
        end
    end
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded', function()
    while not ESX.GetPlayerData().job do Wait(1000) end
    PlayerData = ESX.GetPlayerData()
    PlayerLoaded = true
end)

RegisterNetEvent('ak47_radio:notify', function(type, msg)
    Notify(type, msg)
end)

IsDead = function()
    local ped = PlayerPedId()
    if IsEntityDead(ped) or 
        LocalPlayer.state.down or
        LocalPlayer.state.dead or
        IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3) or
        IsEntityPlayingAnim(ped, 'dead', 'dead_b', 3) or
        IsEntityPlayingAnim(ped, 'dead', 'dead_c', 3) then
        return true
    end
    return false
end