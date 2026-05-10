RegisterNetEvent('lorp_peacetime:client:toggle')
AddEventHandler('lorp_peacetime:client:toggle', function()
    if GlobalState.peacetime then
        NetworkSetFriendlyFireOption(false)
        TriggerEvent('ox_inventory:disarm')
        SendNUIMessage({ action = 'isPeaceTimeOn', status = true })
    else
        NetworkSetFriendlyFireOption(true)
        SendNUIMessage({ action = 'isPeaceTimeOn', status = false })
    end
end)

lib.onCache('weapon', function(weapon)
    if weapon and weapon ~= `WEAPON_UNARMED` and GlobalState.peacetime then
        TriggerEvent('ox_inventory:disarm')
    end
end)