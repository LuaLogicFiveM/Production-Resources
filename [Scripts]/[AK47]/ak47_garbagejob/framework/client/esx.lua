ESX = exports['es_extended']:getSharedObject()
PlayerData = {}
PlayerLoaded = false

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local data = ESX.GetPlayerData()
        if data and data.job then
            PlayerData = data
            PlayerLoaded = true
            CreateJobBlip()
        end
    end
end)

RegisterNetEvent('esx:playerLoaded', function()
    PlayerData = ESX.GetPlayerData()
    PlayerLoaded = true
    CreateJobBlip()
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
    CreateJobBlip()
end)

RegisterNetEvent('ak47_garbagejob:notify', function(msg, type)
    Notify(msg, type)
end)

GetPlayerJobName = function()
    return PlayerData and PlayerData.job.name
end

GetPlayerJobRank = function()
    return PlayerData and PlayerData.job.grade
end

IsSpawnPointClear = function(coords, radius, ignore)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(PlayerPedId())
    end
    local vehicles = GetGamePool('CVehicle')
    local closeVeh = {}
    for i = 1, #vehicles, 1 do
        if not ignore or (ignore and vehicles[i] ~= ignore) then
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = #(vehicleCoords - coords)
            if distance <= radius then
                closeVeh[#closeVeh + 1] = vehicles[i]
            end
        end
    end
    if #closeVeh > 0 then return false end
    return true
end

GetPlate = function(vehicle)
    return (string.gsub(GetVehicleNumberPlateText(vehicle), '^%s*(.-)%s*$', '%1'))
end