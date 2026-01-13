---@diagnostic disable: duplicate-set-field
if GetResourceState('cd_garage') == 'missing' then return end

local CDGarageAPI = {}

function CDGarageAPI.GetResourceName()
    return "cd_garage"
end

function CDGarageAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['cd_garage']:GiveKeys(plate)
end

function CDGarageAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    exports['cd_garage']:RemoveKeys(plate)
end

return CDGarageAPI