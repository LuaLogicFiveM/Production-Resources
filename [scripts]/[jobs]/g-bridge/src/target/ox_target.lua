---@diagnostic disable: duplicate-set-field
if GetResourceState("ox_target") ~= "started" then
    return
end

local targetZones = {}

-- This functions from community_bridge
local function ConvertToOxTargetFormat(options)
    for k, v in pairs(options) do
        local action = v.onSelect or v.action
        local select = function(entityOrData)
            if type(entityOrData) == 'table' then
                return action(entityOrData.entity)
            end
            return action(entityOrData)
        end
        options[k].onSelect = select
        options[k].groups = v.job or v.groups

    end
    return options
end

TARGET.AddTargetModel = function(models, options)
    if type(models) ~= "table" then
        models = {models}
    end

    options = ConvertToOxTargetFormat(options)
    for i = 1, #models do
        exports.ox_target:addModel(models[i], options)
    end
end

TARGET.RemoveTargetModel = function(models, labels)
    if type(models) ~= "table" then
        models = {models}
    end

    for i = 1, #models do
        exports.ox_target:removeModel(models[i], labels)
    end
end

TARGET.AddTargetEntity = function(entities, options)
    if type(entities) ~= "table" then
        entities = {entities}
    end

    options = ConvertToOxTargetFormat(options)
    exports.ox_target:addLocalEntity(entities, options)
end

TARGET.RemoveTargetEntity = function(entities, labels)
    if type(entities) ~= "table" then
        entities = {entities}
    end

    exports.ox_target:removeLocalEntity(entities, labels)
end

TARGET.AddGlobalPed = function(options)
    options = ConvertToOxTargetFormat(options)
    exports.ox_target:addGlobalPed(options)
end

TARGET.AddGlobalVehicle = function(options)
    options = ConvertToOxTargetFormat(options)
    exports.ox_target:addGlobalVehicle(options)
end

TARGET.AddGlobalObject = function(options)
    options = ConvertToOxTargetFormat(options)
    exports.ox_target:addGlobalObject(options)
end

TARGET.RemoveGlobalPed = function(labels)
    exports.ox_target:removeGlobalPed(labels)
end

TARGET.RemoveGlobalVehicle = function(labels)
    exports.ox_target:removeGlobalVehicle(labels)
end

TARGET.RemoveGlobalObject = function(labels)
    exports.ox_target:removeGlobalObject(labels)
end

TARGET.AddBoxZone = function(name, coords, size, heading, options, debug)
    local invokingResource = GetInvokingResource()

    for i = #targetZones, 1, -1 do
        if targetZones[i].name == name and targetZones[i].creator == invokingResource then
            pcall(function()
                if targetZones[i].id then
                    exports.ox_target:removeBoxZone(targetZones[i].id)
                end
                exports.ox_target:removeBoxZone(targetZones[i].name)
            end)
            table.remove(targetZones, i)
        end
    end

    if type(size) == 'number' then
        size = vec3(size, size, size)
    elseif type(size) == 'vector3' then
    elseif type(size) == 'table' and size.x and size.y and size.z then
        size = vec3(size.x, size.y, size.z)
    end

    local parameters = {
        coords = coords,
        name = name,
        size = size,
        rotation = heading,
        debug = debug,
        options = options and ConvertToOxTargetFormat(options) or {}
    }

    local zoneId = exports.ox_target:addBoxZone(parameters)

    if zoneId then
        table.insert(targetZones, {
            name = name,
            id = zoneId,
            creator = invokingResource
        })
    end

    return zoneId
end

TARGET.RemoveBoxZone = function(idOrName)
    pcall(function()
        exports.ox_target:removeBoxZone(idOrName)
    end)
    pcall(function()
        exports.ox_target:removeZone(idOrName)
    end)

    for i = #targetZones, 1, -1 do
        if targetZones[i].id == idOrName or targetZones[i].name == idOrName then
            table.remove(targetZones, i)
            break
        end
    end
end

TARGET.CleanupResourceZones = function(resourceName)
    for i = #targetZones, 1, -1 do
        if targetZones[i].creator == resourceName then
            pcall(function()
                if targetZones[i].id then
                    exports.ox_target:removeBoxZone(targetZones[i].id)
                end
            end)
            table.remove(targetZones, i)
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    for _, target in pairs(targetZones) do
        if target.creator == resource then
            pcall(function()
                if target.id then
                    pcall(function()
                        exports.ox_target:removeBoxZone(target.id)
                    end)
                    pcall(function()
                        exports.ox_target:removeZone(target.id)
                    end)
                end
            end)
        end
    end

    for i = #targetZones, 1, -1 do
        if targetZones[i].creator == resource then
            table.remove(targetZones, i)
        end
    end
end)
