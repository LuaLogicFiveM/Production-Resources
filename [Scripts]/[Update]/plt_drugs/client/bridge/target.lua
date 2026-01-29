bridge = bridge or {}

CreateThread(function()
    if Config.TargetSystem == 'ox' then
        targetSystem = 'ox_target'
    elseif Config.TargetSystem == 'qb' then
        targetSystem = 'qb-target'
    else
        local resourceName = 'ox_target'
        local resourceName2 = 'qb-target'

        if GetResourceState(resourceName) ~= 'missing' then
            targetSystem = resourceName
        elseif GetResourceState(resourceName2) ~= 'missing' then
            targetSystem = resourceName2
        end
    end
end)

function bridge.AddTargetModel(models, options)
    if targetSystem == 'ox_target' then
        local oxOptions = {}
        for _, option in ipairs(options) do
            table.insert(oxOptions, {
                label = option.label,
                icon = option.icon,
                distance = option.distance or 2.0,
                canInteract = option.canInteract,
                onSelect = function(data)
                    if option.action then option.action(data.entity) end
                end,
            })
        end
        exports.ox_target:addModel(models, oxOptions)
    elseif targetSystem == 'qb-target' then
        local qbOptions = {}
        for _, option in ipairs(options) do
            table.insert(qbOptions, {
                label = option.label,
                icon = option.icon,
                action = option.action,
                canInteract = option.canInteract,
            })
        end
        exports['qb-target']:AddTargetModel(models, {
            options = qbOptions,
            distance = options[1].distance or 2.0
        })
    end
end

function bridge.RemoveZone(zoneName)
    if targetSystem == 'ox_target' then
        exports.ox_target:removeZone(zoneName)
    elseif targetSystem == 'qb-target' then
        exports['qb-target']:RemoveZone(zoneName)
    end
end

function bridge.AddBoxZone(data)
    if targetSystem == 'ox_target' then
        local oxOptions = {}
        for _, opt in ipairs(data.options) do
            local newOpt = {
                label = opt.label,
                icon = opt.icon,
                onSelect = opt.onSelect,
                name = opt.name,
                distance = data.distance
            }

            if opt.jobs then
                newOpt.groups = {}
                for _, jobName in ipairs(opt.jobs) do
                    newOpt.groups[jobName] = 0
                end
            end
            table.insert(oxOptions, newOpt)
        end

        exports.ox_target:addBoxZone({
            name = data.name,
            coords = data.coords,
            size = data.size,
            rotation = data.rotation or 0,
            debug = data.debug or false,
            options = oxOptions
        })
    elseif targetSystem == 'qb-target' then
        local qbOptions = {}
        for _, opt in ipairs(data.options) do
            local newOpt = {
                type = 'client',
                action = opt.onSelect,
                icon = opt.icon,
                label = opt.label,
                name = opt.name
            }

            if opt.jobs then
                newOpt.job = {}
                for _, jobName in ipairs(opt.jobs) do
                    newOpt.job[jobName] = 0
                end
            end
            table.insert(qbOptions, newOpt)
        end

        exports['qb-target']:AddBoxZone(data.name, data.coords, data.size.x, data.size.y, {
            name = data.name,
            heading = data.rotation or 0,
            debugPoly = data.debug or false,
            minZ = data.coords.z - (data.size.z / 2),
            maxZ = data.coords.z + (data.size.z / 2),
            useZ = true,
        }, {
            options = qbOptions,
            distance = data.distance
        })
    end
end
