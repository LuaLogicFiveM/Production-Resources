---@diagnostic disable: duplicate-set-field
if GetResourceState('wasabi_carlock') == 'missing' then return end

local WasabiCarlockAPI = {}

function WasabiCarlockAPI.GetResourceName()
    return "wasabi_carlock"
end

function WasabiCarlockAPI.GiveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    TriggerServerEvent("wasabi_carlock:giveKey", plate)
end

function WasabiCarlockAPI.RemoveKeys(vehicle, plate)
    if not DoesEntityExist(vehicle) then return end

    if not plate then
        plate = GetVehicleNumberPlateText(vehicle)
    end

    TriggerServerEvent("wasabi_carlock:removeKey", plate)
end

return WasabiCarlockAPI