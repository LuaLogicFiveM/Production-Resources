ESX = exports['es_extended']:getSharedObject()

IsDead = function()
    local ped = target and GetPlayerPed(target) or PlayerPedId()
    if IsEntityDead(ped) or ((target and Player(target).state.dead or (not target and LocalPlayer.state.dead))) or
        IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3) or
        IsEntityPlayingAnim(ped, 'dead', 'dead_b', 3) or
        IsEntityPlayingAnim(ped, 'dead', 'dead_c', 3) then
        return true
    end
    return false
end

RegisterNetEvent('ak47_ecommerce:notify', function(type, msg)
    Notify(type, msg)
end)