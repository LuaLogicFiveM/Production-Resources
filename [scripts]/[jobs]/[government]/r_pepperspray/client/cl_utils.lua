-- [[ Functions ]]

-- Function to display a notification
function showHint(message)
    AddTextEntry('r_pepperspray', message)
    BeginTextCommandDisplayHelp('r_pepperspray')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

-- Function to deactivate controls when the player has been gassed
function disableControlGassed(ped)
    if Config.DisableControl.Sprint then
        DisableControlAction(0, 21, true)
    end

    if Config.DisableControl.EnterVehicle then
        DisableControlAction(0, 23, true)
    end

    if Config.DisableControl.Fight then
        DisableControlAction(0, 24, true)
        DisablePlayerFiring(ped, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 25, true)
    end
end

-- [[ Commands ]]

if not Config.UseFramework then
    -- Command to take a pepper spray
    for weaponName,_ in pairs(Config.PepperSpray) do
        RegisterCommand(weaponName, function(_, Args)
            local ped = GetPlayerPed(-1)

            if GetSelectedPedWeapon(ped) == Config.PepperSpray[weaponName].weaponModel then
                RemoveWeaponFromPed(ped, Config.PepperSpray[weaponName].weaponModel)
            else
                GiveWeaponToPed(ped, Config.PepperSpray[weaponName].weaponModel, 0, false, false)
                SetCurrentPedWeapon(ped, Config.PepperSpray[weaponName].weaponModel, true)
            end
        end, false)
    end

    -- Command to take a decontamination spray
    RegisterCommand(Config.Decontamination.command, function(_, Args)
        if GetSelectedPedWeapon(ped) == Config.Decontamination.weaponModel then
            RemoveWeaponFromPed(ped, Config.Decontamination.weaponModel)
        else
            GiveWeaponToPed(ped, Config.Decontamination.weaponModel, 0, false, false)
            SetCurrentPedWeapon(ped, Config.Decontamination.weaponModel, true)
        end
    end, false)
end