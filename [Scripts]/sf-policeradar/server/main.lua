
if(Config.ModelMode) then
    AddEventHandler("entityCreating", function(entity)
        if (GetEntityType(entity) == 2 and Config.Vehicles[GetEntityModel(entity)]) then
            GiveRadarToVehicle(entity)
        end
    end)
end

RegisterNetEvent("sf-policeradar:updateVehicle", function(vehNetId, newData)
    local playerPed = GetPlayerPed(source)
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    if(not DoesEntityExist(veh) or GetVehiclePedIsIn(playerPed, false) ~= veh or #newData > 15 or not Entity(veh).state.PoliceRadar) then
        return
    end
    if(msgpack.pack(newData):len() > 128) then
        -- network flood attempt
        return
    end
    Entity(veh).state.PoliceRadar = newData
end)

function GiveRadarToVehicle(vehicle)
    Entity(vehicle).state.PoliceRadar = { Config.AlwaysOn, 1, false, false, true, Config.DefaultFast, Config.DefaultFast, false }
end

function RemoveRadarFromVehicle(vehicle)
    Entity(vehicle).state.PoliceRadar = nil
end

function GiveScramblerToVehicle(vehicle)
    Entity(vehicle).state.RadarScrambler = true
end

function RemoveScramblerFromVehicle(vehicle)
    Entity(vehicle).state.RadarScrambler = nil
end

exports("GiveRadarToVehicle", GiveRadarToVehicle)
exports("RemoveRadarFromVehicle", RemoveRadarFromVehicle)
exports("GiveScramblerToVehicle", GiveScramblerToVehicle)
exports("RemoveScramblerFromVehicle", RemoveScramblerFromVehicle)

if(GetResourceState("qb-core") ~= "missing") then
    QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem("radar_scrambler", function(source, item)
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local Player = QBCore.Functions.GetPlayer(source)
        if(not DoesEntityExist(vehicle)) then
            TriggerClientEvent("sf-policeradar:showNotification", source, _L("no_vehicle"))
            return
        end
        if(Player.Functions.RemoveItem(item.name, 1, item.slot)) then
            -- here you can add progress bar
            GiveScramblerToVehicle(vehicle)
        end
    end)
elseif(GetResourceState("es_extended") ~= "missing") then
    ESX = nil
    if(ESXEvent) then
        while not ESX do
            TriggerEvent(ESXEvent, function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    else
        ESX = exports["es_extended"]:getSharedObject()
    end
    ESX.RegisterUsableItem("radar_scrambler", function(source)
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local xPlayer = ESX.GetPlayerFromId(source)
        if(not DoesEntityExist(vehicle)) then
            TriggerClientEvent("sf-policeradar:showNotification", source, _L("no_vehicle"))
            return
        end
        xPlayer.removeInventoryItem("radar_scrambler", 1)
        -- here you can add progress bar
        GiveScramblerToVehicle(vehicle)
    end)
end

if(Config.StandaloneCommands) then
    RegisterCommand("radar_add", function(source)
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if(not DoesEntityExist(vehicle)) then return end
        GiveRadarToVehicle(vehicle)
    end, false)

    RegisterCommand("radar_remove", function(source)
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if(not DoesEntityExist(vehicle)) then return end
        Entity(vehicle).state.PoliceRadar = nil
    end, false)

    RegisterCommand("scrambler_add", function(source)
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if(not DoesEntityExist(vehicle)) then return end
        GiveScramblerToVehicle(vehicle)
    end, false)

    RegisterCommand("scrambler_remove", function(source)
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if(not DoesEntityExist(vehicle)) then return end
        Entity(vehicle).state.RadarScrambler = nil
    end, false)
end

-- Dev things, remember to disable it in Config.DevMode before going into production
if(Config.DevMode) then
    print(("^3Warning: %s^0"):format("You have Config.DevMode enabled, remember to disable it starting this resource on your main server"))
    local rdrString = [[Config.Vehicles = {
%s
}
    ]]
    local configEntry = [[
    [%s] = {
        label = "%s",
        offset = %s,
        rotation = %s
    },
]]
    RegisterNetEvent("sf-policeradar:positionConfig", function(entityModel, offset, rotation, vehLabel)
        Config.Vehicles[entityModel] = {
            label = vehLabel,
            offset = offset,
            rotation = rotation
        }
        local configEntries = ""
        for k, v in pairs(Config.Vehicles) do
            configEntries = configEntries..configEntry:format(tonumber(k), v.label, v.offset, v.rotation)
        end
        TriggerClientEvent("sf-policeradar:newPositionEntry", -1, entityModel, offset, rotation)
        SaveResourceFile(GetCurrentResourceName(), "config_rdroffsets.lua", rdrString:format(configEntries), -1)
    end)

    local csrString = [[Config.ScramblerVehicles = {
%s
}
    ]]
    RegisterNetEvent("sf-policeradar:scrConfig", function(entityModel, offset, rotation, vehLabel, fromEditor)
        Config.ScramblerVehicles[entityModel] = {
            label = vehLabel,
            offset = offset,
            rotation = rotation
        }
        if(fromEditor) then
            local configEntries = ""
            for k, v in pairs(Config.ScramblerVehicles) do
                configEntries = configEntries..configEntry:format(tonumber(k), v.label, v.offset, v.rotation)
            end
            SaveResourceFile(GetCurrentResourceName(), "config_scroffsets.lua", csrString:format(configEntries), -1)
        end
    end)

    RegisterCommand('scrambler_pos_save', function()
        local configEntries = ""
        for k, v in pairs(Config.ScramblerVehicles) do
            configEntries = configEntries..configEntry:format(tonumber(k), v.label, v.offset, v.rotation)
        end
        SaveResourceFile(GetCurrentResourceName(), "config_scroffsets.lua", csrString:format(configEntries), -1)
    end, false)

    RegisterCommand('scrambler_pos_verify', function()
        local configEntries = ""
        for k, v in pairs(Config.ScramblerVehicles) do
            if(v.offset and #(v.offset) > 100) then
                v.offset = nil
                v.rotation = nil
            end
            configEntries = configEntries..configEntry:format(tonumber(k), v.label, v.offset, v.rotation)
        end
        SaveResourceFile(GetCurrentResourceName(), "config_scroffsets.lua", csrString:format(configEntries), -1)
    end, false)
end