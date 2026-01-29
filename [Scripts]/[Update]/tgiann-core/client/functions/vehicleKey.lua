local tgiann_hotwire = GetResourceState("tgiann-hotwire") ~= "missing"
local qs_vehiclekeys = GetResourceState("qs-vehiclekeys") ~= "missing"
local qb_vehiclekeys = GetResourceState("qb-vehiclekeys") ~= "missing"

---@param vehicle number
---@param keyType? "giveKey" | "nonRemoveable" | "garage"
---@diagnostic disable-next-line: duplicate-set-field
tgiCore.GiveVehicleKey = function(vehicle, keyType)
    if tgiann_hotwire then
        if keyType == "giveKey" then
            exports["tgiann-hotwire"]:GiveKeyVehicle(vehicle, true)
        elseif keyType == "nonRemoveable" then
            exports["tgiann-hotwire"]:SetNonRemoveableIgnition(vehicle, true)
        elseif keyType == "garage" then
            exports["tgiann-hotwire"]:CheckKeyInIgnitionWhenSpawn(vehicle)
        end
    elseif qs_vehiclekeys then
        local plate = GetVehicleNumberPlateText(vehicle)
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
    elseif qb_vehiclekeys then
        TriggerServerEvent("tgiann-core:server:giveVehicleKey", NetworkGetNetworkIdFromEntity(vehicle))
    else
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
        TriggerEvent("x-hotwire:give-keys", vehicle)
        TriggerEvent('tgiann-hotwire:give-keys-with-carid', vehicle)
    end
end

RegisterNetEvent("tgiann-core:client:giveVehicleKey")
AddEventHandler("tgiann-core:client:giveVehicleKey", function(netId, keyType)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    tgiCore.GiveVehicleKey(vehicle, keyType)
end)
