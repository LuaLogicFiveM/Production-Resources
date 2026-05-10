
local function debugPrint(message)
    if Config.Debug then
        print('[GRP AI Doctor - Debug] ' .. message)
    end
end

function Notify(message, type)
    if Config.Notify == 'ox' then
        if lib and lib.notify then
            lib.notify({
                title = type == 'success' and 'Success' or (type == 'error' and 'Error' or 'Info'),
                description = message,
                type = type or 'inform',
                duration = 3500
            })
        else
            print('^1[APOLLO][AI DOC] ox_lib notification failed: lib.notify not found^7')
        end
    elseif Config.Notify == 'qb' or Config.Notify == 'esx' or Config.Notify == 'qbx' then
        GRP.ShowNotification(message)
    elseif Config.Notify == 'bridge' then
        GRP.ShowNotification(message)
    else 
        SendNUIMessage({
            type = 'notification',
            message = message,
            notificationType = type 
        })
    end
end

function IsPlayerDead()
    if Config.AmbulanceJob == "VisnAre" then
        local healthBuffer = exports.visn_are:GetHealthBuffer()
        local isDead = healthBuffer.unconscious
        debugPrint('VisnAre death check: ' .. tostring(isDead))
        return isDead
    elseif Config.AmbulanceJob == "wasabi_ambulance" then
        local isDead = exports.wasabi_ambulance:isPlayerDead()
        debugPrint('Wasabi Ambulance death check: ' .. tostring(isDead))
        return isDead
    elseif Config.AmbulanceJob == "brutal_ambulancejob" then
        local isDead = exports.brutal_ambulancejob:IsDead()
        debugPrint('Brutal Ambulance death check: ' .. tostring(isDead))
        return isDead
    elseif Config.AmbulanceJob == "ars_ambulancejob" then
        local isDead = exports.ars_ambulancejob:isDead()
        debugPrint('Arius Ambulance death check: ' .. tostring(isDead))
        return isDead
    elseif Config.AmbulanceJob == "osp_ambulance" then
        local isDead = exports["osp_ambulance"]:isDead()
        debugPrint('OSP Ambulance death check: ' .. tostring(isDead))
        return isDead
    elseif Config.AmbulanceJob == "tk_ambulancejob" then
        local isDead = exports.tk_ambulancejob:isDead()
        debugPrint('tk_ambulancejob death check: ' .. tostring(isDead))
        return isDead
    elseif Config.AmbulanceJob == "default" then
        local isDead = GRP.GetIsPlayerDead()
        debugPrint('GRP Bridge death check: ' .. tostring(isDead))
        return isDead
    else
        local isDead = GRP.GetIsPlayerDead()
        debugPrint('GRP Bridge fallback death check: ' .. tostring(isDead))
        return isDead
    end
end

-- Function to show progress bar during revive process
function ShowReviveProgressBar()
    if not Config.UseProgressBar then
        debugPrint('Progress bar is disabled, using regular wait')
        Citizen.Wait(Config.ReviveTime)
        return true
    end
    
    debugPrint('Starting revive progress bar with duration: ' .. Config.ReviveTime .. 'ms')
    
    local success = lib.progressBar({
        duration = Config.ReviveTime,
        label = locale('progress_bar_label'),
        useWhileDead = true,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
            sprint = true
        }
    })
    
    if success then
        debugPrint('Progress bar completed successfully')
        return true
    else
        debugPrint('Progress bar was cancelled or failed')
        return false
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function RevivePlayer()
    debugPrint('Attempting to revive player using ' .. Config.AmbulanceJob)
    if Config.AmbulanceJob == "VisnAre" then
        debugPrint('Using VisnAre revive system')
        TriggerEvent('visn_are:resetHealthBuffer')
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    elseif Config.AmbulanceJob == "wasabi_ambulance" then
        debugPrint('Client: Triggering server event to revive with wasabi_ambulance')
        TriggerServerEvent('grp:server:reviveWasabi')
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    elseif Config.AmbulanceJob == "brutal_ambulancejob" then
        debugPrint('Using Brutal Ambulance revive system')
        TriggerEvent('brutal_ambulancejob:revive')
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    elseif Config.AmbulanceJob == "ars_ambulancejob" then
        debugPrint('Using Arius Ambulance revive system')
        TriggerEvent('ars_ambulancejob:healPlayer', {revive = true})
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    elseif Config.AmbulanceJob == "osp_ambulance" then
        debugPrint('Using OSP Ambulance revive system')
        local playerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('osp_ambulance:revive', playerId)
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    elseif Config.AmbulanceJob == "tk_ambulancejob" then
        debugPrint('Client: Triggering server event to revive with tk_ambulancejob')
        local playerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('grp:server:reviveTkAmbulance', playerId)
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    elseif Config.AmbulanceJob == "default" then
        debugPrint('Using GRP Bridge default revive system')
        local playerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('grp_aidoc:server:revivePlayer', playerId)
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    else
        debugPrint('Using fallback revive system')
        StopScreenEffect('DeathFailOut')
        TriggerEvent('grp_ai_doctor:client:ResetEMSCall')
    end
    

    if Config.SetHealthAmount then
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        local healthAmount = math.floor((Config.ReviveHealthAmount / 100) * 200) 
        SetEntityHealth(playerPed, healthAmount)
        debugPrint('Set player health to: ' .. healthAmount .. ' (' .. Config.ReviveHealthAmount .. '%)')
    else
        debugPrint('Health setting is disabled in config')
    end
    
    if Config.ClearInventoryOnRevive then
        debugPrint('Clearing player inventory after revive')
        Citizen.Wait(1000)
        TriggerServerEvent('grp:clearInventory')
        Notify(locale('inventory_cleared'), "primary")
    end
end

function setVehicleFuel(vehicle, fuelLevel)
    if not DoesEntityExist(vehicle) then
        debugPrint('Failed to set fuel: Vehicle does not exist')
        return
    end

    if GRP and GRP.SetFuel then
        GRP.SetFuel(vehicle, fuelLevel)
        debugPrint('Set fuel using GRP Bridge: ' .. tostring(fuelLevel))
    else
        SetVehicleFuelLevel(vehicle, fuelLevel)
        debugPrint('Set fuel using native (GRP Bridge not available): ' .. tostring(fuelLevel))
    end
end