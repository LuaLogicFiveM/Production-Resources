local sh_repair = require 'resource.vehicle_repairs.shared'
local repairing = false

local maxRepairCount = 2
local repairCounts = {} 

for i = 1, #sh_repair.Locations do
    local zone = sh_repair.Locations[i]

    local point = lib.points.new(zone[1], zone[2])

    function point:onEnter()
        if not cache.vehicle or repairing then return end
        lib.showTextUI('[E] - Repair Vehicle')
    end

    function point:onExit()
        lib.hideTextUI()
    end

    function point:nearby()
        if IsControlJustReleased(0, 38) then
            local vehicle = cache.vehicle

            if not vehicle then return end

            if not cache.seat == -1 then
                return lib.notify({title = 'Vehicle', description = 'You have to be the driver of the vehicle', type = 'error', position = 'top'})
            end

            if repairing then
                return lib.notify({title = 'Vehicle', description = 'You are already repairing the vehicle', type = 'error', position = 'top'})
            end

            repairing = true

            if lib.progressCircle({
                duration = 8000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true
                }
            }) then 
                SetVehicleUndriveable(vehicle,false)
                SetVehicleFixed(vehicle)
                SetVehicleEngineOn(vehicle, true, false)
                lib.notify({title = 'Vehicle', description = 'The mechanic repaired your vehicle', type = 'error', position = 'top'})
                repairing = false
            end
        end
    end

    --Zen.Functions.CreateBlip(zone[1], sh_repair.Blip)
end

RegisterNetEvent('repair:vehicle')
AddEventHandler('repair:vehicle', function()
    local vehicle = cache.vehicle

    if not DoesEntityExist(cache.vehicle) or not cache.seat == -1 then
        return lib.notify({title = 'Vehicle', description = 'You must be in a vehicle', type = 'error', position = 'top'})
    end

    if repairing then 
        return lib.notify({title = 'Vehicle', description = 'You are already repairing', type = 'error', position = 'top'})
    end

    local vehicleHandle = tostring(vehicle)
    local repairCount = repairCounts[vehicleHandle] or 0

    if (repairCount >= maxRepairCount) then
        return lib.notify({title = 'Vehicle', description = 'You repaired your vehicle too many times', type = 'error', position = 'top'})
    end

    repairing = true

    if lib.progressCircle({
        duration = 8000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
			car = true
		}
    }) then 
        if GetVehicleEngineHealth(vehicle) < 325.0 then 
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineHealth(vehicle, 320.0 + 5)
            SetVehiclePetrolTankHealth(vehicle, 750.0)
            SetVehicleEngineOn(vehicle, true, false)
            SetVehicleOilLevel(vehicle,(GetVehicleOilLevel(vehicle)/3)-0.5)
            repairCounts[vehicleHandle] = repairCount + 1
            lib.notify({title = 'Vehicle', description = sh_repair.Messages.Fix[math.random(#sh_repair.Messages.Fix)], type = 'success', position = 'top'})
        else
            lib.notify({title = 'Vehicle', description = sh_repair.Messages.NoFix[math.random(#sh_repair.Messages.NoFix)], type = 'error', position = 'top'})
        end

        repairing = false
    end
end)
