---@diagnostic disable: duplicate-set-field
if GetResourceState('okokGarage') == 'missing' then return end

local OkokGarageAPI = {}

function OkokGarageAPI.GetResourceName()
    return "okokGarage"
end

function OkokGarageAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['okokGarage']:GiveKeys(plate)
end

function OkokGarageAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['okokGarage']:RemoveKeys(plate)
end

return OkokGarageAPI