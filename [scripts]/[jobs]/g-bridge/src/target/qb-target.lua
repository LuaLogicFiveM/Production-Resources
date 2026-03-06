---@diagnostic disable: duplicate-set-field
if GTargetType ~= 'qb' then return end

local targetZones = {}

-- this logic from community_bridge resource
local function ConvertToQBTargetFormat(options)
    for k, v in pairs(options) do
        local action = v.onSelect or v.action
        local select = function(entityOrData)
            if type(entityOrData) == 'table' then
                return action(entityOrData.entity)
            end
            return action(entityOrData)
        end
        options[k].action = select
        options[k].job = v.job or v.groups
    end
    return options
end

TARGET.AddTargetModel = function(models, options)
    if type(models) ~= "table" then
        models = {models}
    end

    options = ConvertToQBTargetFormat(options)
    exports['qb-target']:AddTargetModel(models, options)
end

TARGET.RemoveTargetModel = function(models, labels)
    if type(models) ~= "table" then
        models = {models}
    end

    exports['qb-target']:RemoveTargetModel(models, labels)
end

TARGET.AddTargetEntity = function(entities, options)
    if type(entities) ~= "table" then
        entities = {entities}
    end

    options = ConvertToQBTargetFormat(options)
    exports['qb-target']:AddTargetEntity(entities, options)
end

TARGET.RemoveTargetEntity = function(entities, labels)
    if type(entities) ~= "table" then
        entities = {entities}
    end

    exports['qb-target']:RemoveTargetEntity(entities, labels)
end

TARGET.AddGlobalPed = function(options)
    options = ConvertToQBTargetFormat(options)
    exports['qb-target']:AddGlobalPed(options)
end

TARGET.AddGlobalVehicle = function(options)
    options = ConvertToQBTargetFormat(options)
    exports['qb-target']:AddGlobalVehicle(options)
end

TARGET.AddGlobalObject = function(options)
    options = ConvertToQBTargetFormat(options)
    exports['qb-target']:AddGlobalObject(options)
end

TARGET.RemoveGlobalPed = function(labels)
    exports['qb-target']:RemoveGlobalPed(labels)
end

TARGET.RemoveGlobalVehicle = function(labels)
    exports['qb-target']:RemoveGlobalVehicle(labels)
end

TARGET.RemoveGlobalObject = function(labels)
    exports['qb-target']:RemoveGlobalObject(labels)
end


TARGET.AddBoxZone = function(name, coords, size, heading, options, debug)
    local sizeX = size.x
    local sizeY = size.y
    local sizeZ = size.z
    
    options = ConvertToQBTargetFormat(options or {})
    if not next(options) then return end
    
    local largestDistance = 0.0
    for _, option in pairs(options) do
        local dist = option.distance or 2.5
        if dist > largestDistance then
            largestDistance = dist
        end
    end
    
    local coordsZ = coords.z
    
    exports['qb-target']:AddBoxZone(name, coords, sizeX, sizeY, {
        name = name,
        debugPoly = debug or false,
        heading = heading or 0.0,
        minZ = coordsZ - (sizeZ * 0.5),
        maxZ = coordsZ + (sizeZ * 0.5),
    }, {
        options = options,
        distance = largestDistance,
    })
    
    table.insert(targetZones, { name = name, creator = GetInvokingResource() })
    return name
end

TARGET.RemoveBoxZone = function(idOrName)
    if not idOrName then return end
    for i, data in pairs(targetZones) do
        if data.name == idOrName then
            exports['qb-target']:RemoveZone(idOrName)
            table.remove(targetZones, i)
            break
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for _, target in pairs(targetZones) do
        if target.creator == resource then
            exports['qb-target']:RemoveZone(target.name)
        end
    end
    targetZones = {}
end)
