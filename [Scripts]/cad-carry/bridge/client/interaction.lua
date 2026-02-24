if Config.Target == 'ox_target' or ((Config.Target == 'autodetect') and (GetResourceState('ox_target') == 'started')) then
    Config.Target = 'ox_target'
    exports.ox_target:addGlobalPlayer({
        {
            label = 'Carry',
            icon = 'fa-solid fa-hand-holding',
            distance = Config.CarryDistance,
            canInteract = function()
                return not LocalPlayer.state.carrying and not LocalPlayer.state.carried and not LocalPlayer.state.intrunk
            end,
            onSelect = function()
                exports['cad-carry']:CarryPerson()
            end
        }
    })
    exports.ox_target:addGlobalVehicle({
        {
            label = 'Put in seat',
            icon = 'fa-solid fa-person-arrow-up-from-line',
            distance = Config.VehicleDistance,
            bones = { 'seat_dside_f', 'seat_pside_f', 'seat_dside_r',  'seat_pside_r', 'seat_r' },
            canInteract = function(entity)
                return (Config.EnablePutInSeat and not IsVehicleLocked(entity)) and LocalPlayer.state.carrying and (not LocalPlayer.state.carried)
            end,
            onSelect = function(data)
                exports['cad-carry']:PutInClosestSeat(data.entity)
            end
        },
        {
            label = 'Remove Seat',
            icon = 'fa-solid fa-person-arrow-down-to-line',
            distance = Config.VehicleDistance,
            bones = { 'seat_dside_f', 'seat_pside_f', 'seat_dside_r',  'seat_pside_r', 'seat_r' },
            canInteract = function(entity)
                return Config.EnablePutInSeat and not IsVehicleLocked(entity) and (not LocalPlayer.state.carried)
            end,
            onSelect = function()
                exports['cad-carry']:RemoveSeat()
            end
        },
        {
            label = 'Put in trunk',
            icon = 'fa-solid fa-person-arrow-up-from-line',
            distance = Config.VehicleDistance,
            bones = { 'boot', 'platelight', 'bonnet' },
            canInteract = function(entity)
                return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (not IsTrunkFull(entity, false)) and LocalPlayer.state.carrying and (not LocalPlayer.state.carried) and (not LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity))
            end,
            onSelect = function(data)
                exports['cad-carry']:PutInTrunk(data.entity)
            end
        },
        {
            label = 'Get in trunk',
            icon = 'fa-solid fa-person-arrow-up-from-line',
            distance = Config.VehicleDistance,
            bones = { 'boot', 'platelight', 'bonnet' },
            canInteract = function(entity)
                return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (not IsTrunkFull(entity, false)) and (not LocalPlayer.state.carrying) and (not LocalPlayer.state.carried) and (not LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity))
            end,
            onSelect = function(data)
                exports['cad-carry']:GetInTrunk(data.entity)
            end
        },
        {
            label = 'Leave trunk',
            icon = 'fa-solid fa-person-arrow-down-to-line',
            distance = Config.VehicleDistance,
            canInteract = function(entity)
                return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (IsTrunkFull(entity, true) and LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity))
            end,
            onSelect = function(data)
                exports['cad-carry']:LeaveTrunk(data.entity)
            end
        },
        {
            label = 'Remove Trunk',
            icon = 'fa-solid fa-person-arrow-down-to-line',
            distance = Config.VehicleDistance,
            bones = { 'boot', 'platelight', 'bonnet' },
            canInteract = function(entity)
                return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (IsTrunkFull(entity, true) and not LocalPlayer.state.intrunk) and (not LocalPlayer.state.carried) and (not IsVehicleLocked(entity))
            end,
            onSelect = function(data)
                exports['cad-carry']:RemoveTrunk(data.entity)
            end
        }
    })
    if Config.EnableCarryPed then
        exports.ox_target:addGlobalPed({
            {
                label = 'Carry Ped',
                icon = 'fa-solid fa-hand-holding',
                distance = Config.CarryDistance,
                canInteract = function(entity)
                    return not IsPedAPlayer(entity) and not LocalPlayer.state.carrying and not LocalPlayer.state.carried and not LocalPlayer.state.intrunk
                end,
                onSelect = function(data)
                    exports['cad-carry']:CarryPedEntity(data.entity)
                end
            }
        })
    end
elseif Config.Target == 'qb-target' or ((Config.Target == 'autodetect') and (GetResourceState('qb-target') == 'started')) then
    Config.Target = 'qb-target'
    exports['qb-target']:AddGlobalPlayer({
        options = {
            {
                label = 'Carry',
                icon = 'fa-solid fa-hand-holding',
                canInteract = function()
                    return not LocalPlayer.state.carrying and not LocalPlayer.state.carried and not LocalPlayer.state.intrunk
                end,
                action = function()
                    exports['cad-carry']:CarryPerson()
                end
            }
        },
        distance = Config.CarryDistance,
    })
    exports['qb-target']:AddTargetBone({ 'seat_dside_f', 'seat_pside_f', 'seat_dside_r',  'seat_pside_r', 'seat_r' }, {
        options = {
            {
                label = 'Put in seat',
                icon = 'fa-solid fa-person-arrow-up-from-line',
                canInteract = function(entity)
                    return (Config.EnablePutInSeat and not IsVehicleLocked(entity)) and LocalPlayer.state.carrying and (not LocalPlayer.state.carried)
                end,
                action = function(entity)
                    exports['cad-carry']:PutInClosestSeat(entity)
                end
            },
            {
                label = 'Remove Seat',
                icon = 'fa-solid fa-person-arrow-down-to-line',
                canInteract = function(entity)
                    return Config.EnablePutInSeat and not IsVehicleLocked(entity)
                end,
                action = function()
                    exports['cad-carry']:RemoveSeat()
                end
            },
        },
        distance = Config.VehicleDistance,
    })
    exports['qb-target']:AddTargetBone({ 'boot', 'bonnet', 'platelight' }, {
        options = {
            {
                label = 'Put in trunk',
                icon = 'fa-solid fa-person-arrow-up-from-line',
                canInteract = function(entity)
                    return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (not IsTrunkFull(entity, false)) and LocalPlayer.state.carrying and (not LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity)) and (not LocalPlayer.state.carried)
                end,
                action = function(entity)
                    exports['cad-carry']:PutInTrunk(entity)
                end
            },
            {
                label = 'Get in trunk',
                icon = 'fa-solid fa-person-arrow-up-from-line',
                canInteract = function(entity)
                    return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (not IsTrunkFull(entity, false)) and (not LocalPlayer.state.carrying) and (not LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity)) and (not LocalPlayer.state.carried)
                end,
                action = function(entity)
                    exports['cad-carry']:GetInTrunk(entity)
                end
            },
            {
                label = 'Leave trunk',
                icon = 'fa-solid fa-person-arrow-down-to-line',
                canInteract = function(entity)
                    return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (IsTrunkFull(entity, true) and LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity)) and (not LocalPlayer.state.carried)
                end,
                action = function(entity)
                    exports['cad-carry']:LeaveTrunk(entity)
                end
            },
            {
                label = 'Remove Trunk',
                icon = 'fa-solid fa-person-arrow-down-to-line',
                canInteract = function(entity)
                    return Config.EnablePutInTrunk and (GetVehicleTrunkAngle(entity) > 0.0) and (IsTrunkFull(entity, true) and not LocalPlayer.state.intrunk) and (not IsVehicleLocked(entity)) and (not LocalPlayer.state.carried)
                end,
                action = function(entity)
                    exports['cad-carry']:RemoveTrunk(entity)
                end
            }
        },
        distance = Config.VehicleDistance,
    })
    if Config.EnableCarryPed then
        exports['qb-target']:AddGlobalPed({
            options = {
                {
                    label = 'Carry Ped',
                    icon = 'fa-solid fa-hand-holding',
                    canInteract = function(entity)
                        return not IsPedAPlayer(entity) and not LocalPlayer.state.carrying and not LocalPlayer.state.carried and not LocalPlayer.state.intrunk
                    end,
                    action = function(entity)
                        exports['cad-carry']:CarryPedEntity(entity)
                    end
                }
            },
            distance = Config.CarryDistance,
        })
    end
else
    Config.Target = 'none'
end

if Config.EnableTextInteractions and Config.EnablePutInTrunk then
CreateThread(function()
    while true do
        local wait = 1000
        local vehicle = GetCloseVehicle()
        if vehicle and not Config.BlacklistVehicles[GetEntityModel(vehicle)] and not IsPedInAnyVehicle(PlayerPedId(), false) then
            if not LocalPlayer.state.carried then
                local plyCoords = GetEntityCoords(PlayerPedId())
                local boneIndex = GetEntityBoneIndexByName(vehicle, 'boot') or GetEntityBoneIndexByName(vehicle, 'platelight')
                local trunkPos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
                local distance = #(plyCoords - trunkPos)
                if distance < 1.5 and GetVehicleTrunkAngle(vehicle) > 0.0 then
                    wait = 7
                    if Config.AllowMultipleInTrunk then
                        wait = 7
                        if IsVehicleLocked(vehicle) then
                            ShowText(Language.vehicle_locked)
                        else
                            if LocalPlayer.state.intrunk then
                                ShowText(Language.leave_trunk)
                                if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
                                    exports['cad-carry']:LeaveTrunk(vehicle)
                                end
                            elseif LocalPlayer.state.carrying then
                                ShowText(Language.put_in_trunk)
                                if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
                                    exports['cad-carry']:PutInTrunk(vehicle)
                                end
                            else
                                ShowText(Language.remove_from_trunk ..'\n' ..Language.get_in_trunk)
                                if IsControlJustPressed(0, 74) or IsDisabledControlJustPressed(0, 74) then
                                    exports['cad-carry']:GetInTrunk(vehicle)
                                end
                                if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
                                    exports['cad-carry']:RemoveTrunk(vehicle)
                                end
                            end
                        end
                    else
                        if IsTrunkFull(vehicle, false) then
                            wait = 7
                            if IsVehicleLocked(vehicle) then
                                ShowText(Language.vehicle_locked)
                            else
                                if LocalPlayer.state.intrunk then
                                    ShowText(Language.leave_trunk)
                                    if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
                                        exports['cad-carry']:LeaveTrunk(vehicle)
                                    end
                                else
                                    ShowText(Language.remove_from_trunk)
                                    if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
                                        exports['cad-carry']:RemoveTrunk(vehicle)
                                    end
                                end
                            end
                        else
                            wait = 7
                            if IsVehicleLocked(vehicle) then
                                ShowText(Language.vehicle_locked)
                            else
                                if LocalPlayer.state.carrying then
                                    ShowText(Language.put_in_trunk)
                                    if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
                                        exports['cad-carry']:PutInTrunk(vehicle)
                                    end
                                else
                                    ShowText(Language.get_in_trunk)
                                    if IsControlJustPressed(0, 74) or IsDisabledControlJustPressed(0, 74) then
                                        exports['cad-carry']:GetInTrunk(vehicle)
                                    end
                                end
                            end
                        end
                    end
                else
                    HideText()
                end
            else
                HideText()
            end
        else
            HideText()
        end
        Wait(wait)
    end
end)
end
