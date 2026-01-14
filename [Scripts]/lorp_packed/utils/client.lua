---@diagnostic disable: undefined-global
local utils = {}
local ox_inventory = exports.ox_inventory
local ak47_ambulancejob = exports.ak47_ambulancejob

utils.spawnVehicle = function(vehicleHandle, coords, heading, cb, networked, lock, keys)
    local model = type(vehicleHandle) == 'number' and vehicleHandle or joaat(vehicleHandle)
    local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
    networked = networked == nil and true or networked

    CreateThread(function()
        lib.requestModel(model)

        local vehicle = CreateVehicle(model, vector.xyz, heading, networked, true)
        if networked then
            local id = NetworkGetNetworkIdFromEntity(vehicle)
            SetNetworkIdCanMigrate(id, true)
            SetEntityAsMissionEntity(vehicle, true, true)
        end

        if lock then
            -- lock vehicle
        end

        if keys then
            -- car key export
        end

        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetModelAsNoLongerNeeded(model)
        SetVehRadioStation(vehicle, 'OFF')

        RequestCollisionAtCoord(vector.xyz)
        while not HasCollisionLoadedAroundEntity(vehicle) do
            Wait(0)
        end

        if cb then
            cb(vehicle)
        end
    end)
end

utils.notify = function(title, message, type, duration)
    return lib.notify({
        title = title,
        description = message,
        type = type,
        position = 'top',
        duration = duration or 5000,
        style = {
            backgroundColor = '#00000',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        }
    })
end

utils.showTextUI = function(text, position, icon)
    return lib.showTextUI(text, {
        position = position or "left-center",
        icon = icon or 'circle-info',
        style = {
            borderRadius = 5,
            backgroundColor = '#00000',
            color = 'white'
        }
    })
end

utils.hideTextUI = function()
    return lib.hideTextUI()
end

utils.createBlip = function(label, coords, sprite, scale, color)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
    SetBlipSprite(blip, sprite)
    SetBlipScale(blip, scale or 0.6)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)
    return blip
end

utils.createRadius = function(coords, data)
    local blip = AddBlipForRadius(coords.x, coords.y, coords.z, data.Radius)
    SetBlipSprite(blip, data.Type)
    SetBlipColour(blip, data.Color)
    SetBlipAlpha(blip, data.Alpha)
    SetBlipAsShortRange(blip, true)
    return blip
end

utils.teleportPlayer = function(coords)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    while not HasCollisionLoadedAroundEntity(cache.ped) do
        Wait(0)
    end

    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, false, false, false, false)
    SetEntityHeading(cache.ped, coords.w or coords.heading or 0.0)
end

utils.getPlayerJob = function()
    local playerData = ESX.GetPlayerData()
    return playerData and playerData.job or false
end

utils.hasJobGrade = function(jobs)
    local playerJob = utils.getPlayerJob()
    return playerJob and jobs[playerJob.name] and playerJob.grade >= jobs[playerJob.name] or false
end

utils.hasItem = function(item, count)
    local itemCount = ox_inventory:Search('count', item)
    return itemCount and itemCount >= count or false
end

utils.playerDead = function(target)
    return ak47_ambulancejob:IsPlayerDead(target or cache.playerId) or ak47_ambulancejob:IsPlayerDown(target or cache.playerId)
end

return utils