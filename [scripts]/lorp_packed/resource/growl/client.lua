local hunger_sound = true

RegisterCommand('hungersound', function()
    hunger_sound = not hunger_sound
end, false)

CreateThread(function()
    while hunger_sound do
        Wait(60000*5)
        ESX.TriggerServerCallback('esx_status:getStatus', function(status)
            local hunger = status.hunger
            local thirst = status.thirst

            if hunger < 20 or thirst < 20 then
                TriggerServerEvent('xsound:server:playerNearby', 5.0, 'stomach_growl', 0.1)
            end
        end)
    end
end)