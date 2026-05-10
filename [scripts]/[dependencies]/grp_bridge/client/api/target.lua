---@diagnostic disable: duplicate-set-field
local TARGET = {}
local targetSystem = nil
local targetZones = {}
local interactIds = {}
local targetDebug = config.Debug

---Generate unique ID for interact callbacks
---@return number id
local function generateUniqueId()
    local id = 1
    while interactIds[id] do
        id = id + 1
    end
    return id
end

---Create a cached interact callback
---@param callback function
---@return number id
local function createCanInteract(callback)
    if not callback then return nil end
    local id = generateUniqueId()
    interactIds[id] = {
        id = id,
        ableToInteract = -1,
        onInteract = callback
    }
    return id
end

---Check if player can interact (cached)
---@param id number
---@return boolean
local function canInteract(id, ...)
    local interactData = interactIds[id]
    if not interactData then return true end
    if interactData.ableToInteract == -1 then
        local callback = interactData.onInteract
        local canInteractStatus = callback(...)
        interactData.ableToInteract = canInteractStatus and 1 or 0
        SetTimeout(1000, function()
            interactData.ableToInteract = -1
        end)
    end
    return interactData.ableToInteract > 0
end

---Fix options to match different target systems
---@param options table
---@return table
local function fixOptions(options)
    if not options then return {} end
    
    for k, v in pairs(options) do
        local action = v.onSelect or v.action
        
        if targetSystem == "ox_target" then
            -- Wrap callback to handle both entity and table data
            if action then
                local select = function(entityOrData)
                    if type(entityOrData) == 'table' then
                        return action(entityOrData.entity)
                    end
                    return action(entityOrData)
                end
                v.onSelect = select
            end
            
            -- Handle serverEvent only when no action exists
            if v.event and v.type == "server" and not action then
                v.serverEvent = v.event
                v.event = nil
                v.type = nil
            end
            
            v.groups = v.job or v.groups
            v.items = v.item or v.items
            
        elseif targetSystem == "qb-target" then
            -- Wrap callback
            if action then
                local select = function(entityOrData)
                    if type(entityOrData) == 'table' then
                        return action(entityOrData.entity)
                    end
                    return action(entityOrData)
                end
                v.action = select
            end
            
            if v.serverEvent then
                v.type = "server"
                v.event = v.serverEvent
                v.serverEvent = nil
            elseif v.event and not v.type then
                v.type = "client"
            end
            
            v.job = v.job or v.groups
            v.item = v.item or v.items
        end
        
        -- Handle canInteract callback
        local optionsCanInteract = v.canInteract
        if optionsCanInteract then
            local interactId = createCanInteract(optionsCanInteract)
            options[k].canInteract = function(...)
                return canInteract(interactId, ...)
            end
        end
    end
    
    return options
end

---Get largest distance from options
---@param options table
---@return number
local function getLargestDistance(options)
    local largestDistance = -1
    for _, v in pairs(options) do
        if v.distance and v.distance > largestDistance then
            largestDistance = v.distance
        end
    end
    return largestDistance ~= -1 and largestDistance or 2.0
end

---Auto detect target system
---@return string|nil
local function detectTargetSystem()
    if config.Target:lower() ~= "auto" then
        local configured = config.Target:lower()
        local resourceName = configured:gsub("_", "-")
        
        -- Try different resource name variations
        local found = false
        if GetResourceState(resourceName) == "started" then
            found = true
        elseif GetResourceState(configured) == "started" then
            found = true
        elseif GetResourceState(configured:gsub("-", "_")) == "started" then
            found = true
        end
        
        if found then
            if config.Debug then
                DebugPrint("Using configured target system: " .. configured, "info")
            end
            return configured
        else
            DebugPrint("Configured target system '" .. configured .. "' not found! Falling back to auto-detection", "warning")
        end
    end
    
    -- Auto detection
    if GetResourceState("ox_target") == "started" then
        if config.Debug then
            DebugPrint("Detected target system: ox_target", "success")
        end
        return "ox_target"
    elseif GetResourceState("qb-target") == "started" then
        if config.Debug then
            DebugPrint("Detected target system: qb-target", "success")
        end
        return "qb-target"
    end
    
    DebugPrint("No target system detected! Target functions will not work", "error")
    return nil
end

---Initialize target system
local function initializeTarget()
    targetSystem = detectTargetSystem()
    if targetSystem then
        if config.Debug then
            DebugPrint("Target system initialized: " .. targetSystem, "success")
        end
    end
end

-- Initialize on resource start
CreateThread(function()
    Wait(1000)
    initializeTarget()
end)

---Toggle targeting system on/off
---@param disable boolean
function TARGET.DisableTargeting(disable)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:disableTargeting(disable)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AllowTargeting(not disable)
    end
end

---Add target options to all players
---@param options table
function TARGET.AddGlobalPlayer(options)
    if not targetSystem then return end
    options = fixOptions(options)
    
    if targetSystem == "ox_target" then
        exports.ox_target:addGlobalPlayer(options)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddGlobalPlayer({
            options = options,
            distance = getLargestDistance(options)
        })
    end
end

---Remove target options from all players
---@param optionNames string|table|nil
function TARGET.RemoveGlobalPlayer(optionNames)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:removeGlobalPlayer(optionNames)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:RemoveGlobalPlayer(optionNames)
    end
end

---Add target options to all peds
---@param options table
function TARGET.AddGlobalPed(options)
    if not targetSystem then return end
    options = fixOptions(options)
    
    if targetSystem == "ox_target" then
        exports.ox_target:addGlobalPed(options)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddGlobalPed({
            options = options,
            distance = getLargestDistance(options)
        })
    end
end

---Remove target options from all peds
---@param optionNames string|table|nil
function TARGET.RemoveGlobalPed(optionNames)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:removeGlobalPed(optionNames)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:RemoveGlobalPed(optionNames)
    end
end

---Add target options to all vehicles
---@param options table
function TARGET.AddGlobalVehicle(options)
    if not targetSystem then return end
    options = fixOptions(options)
    
    if targetSystem == "ox_target" then
        exports.ox_target:addGlobalVehicle(options)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddGlobalVehicle({
            options = options,
            distance = getLargestDistance(options)
        })
    end
end

---Remove target options from all vehicles
---@param optionNames string|table|nil
function TARGET.RemoveGlobalVehicle(optionNames)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:removeGlobalVehicle(optionNames)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:RemoveGlobalVehicle(optionNames)
    end
end

---Add target to local entity
---@param entities number|table
---@param options table
function TARGET.AddLocalEntity(entities, options)
    if not targetSystem then return end
    options = fixOptions(options)
    
    if targetSystem == "ox_target" then
        exports.ox_target:addLocalEntity(entities, options)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddTargetEntity(entities, {
            options = options,
            distance = getLargestDistance(options)
        })
    end
end

---Remove target from local entity
---@param entities number|table
---@param labels string|table|nil
function TARGET.RemoveLocalEntity(entities, labels)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:removeLocalEntity(entities, labels)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:RemoveTargetEntity(entities, labels)
    end
end

---Add target to networked entity
---@param netids number|table
---@param options table
function TARGET.AddNetworkedEntity(netids, options)
    if not targetSystem then return end
    options = fixOptions(options)
    
    if targetSystem == "ox_target" then
        exports.ox_target:addEntity(netids, options)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddTargetEntity(netids, {
            options = options,
            distance = getLargestDistance(options)
        })
    end
end

---Remove target from networked entity
---@param netids number|table
---@param labels string|table|nil
function TARGET.RemoveNetworkedEntity(netids, labels)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:removeEntity(netids, labels)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:RemoveTargetEntity(netids, labels)
    end
end

---Add target to model
---@param models number|table
---@param options table
function TARGET.AddModel(models, options)
    if not targetSystem then return end
    options = fixOptions(options)
    
    if targetSystem == "ox_target" then
        exports.ox_target:addModel(models, options)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddTargetModel(models, {
            options = options,
            distance = getLargestDistance(options)
        })
    end
end

---Remove target from model
---@param models number|table
---@param labels string|table|nil
function TARGET.RemoveModel(models, labels)
    if not targetSystem then return end
    
    if targetSystem == "ox_target" then
        exports.ox_target:removeModel(models, labels)
    elseif targetSystem == "qb-target" then
        exports['qb-target']:RemoveTargetModel(models, labels)
    end
end

---Add box zone target
---@param name string
---@param coords vector3
---@param size vector3
---@param heading number
---@param options table
---@param debug boolean|nil
function TARGET.AddBoxZone(name, coords, size, heading, options, debug)
    if not targetSystem then return end
    options = fixOptions(options)
    if not next(options) then return end
    
    local targetId
    
    if targetSystem == "ox_target" then
        targetId = exports.ox_target:addBoxZone({
            coords = coords,
            size = size,
            rotation = heading,
            debug = debug or targetDebug,
            options = options
        })
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddBoxZone(name, coords, size.x, size.y, {
            name = name,
            debugPoly = debug or targetDebug,
            heading = heading,
            minZ = coords.z - (size.z * 0.5),
            maxZ = coords.z + (size.z * 0.5)
        }, {
            options = options,
            distance = getLargestDistance(options)
        })
    end
    
    table.insert(targetZones, {
        name = name,
        id = targetId,
        creator = GetInvokingResource() or GetCurrentResourceName()
    })
    
    return targetId
end

---Add sphere/circle zone target
---@param name string
---@param coords vector3
---@param radius number
---@param options table
---@param debug boolean|nil
function TARGET.AddSphereZone(name, coords, radius, options, debug)
    if not targetSystem then return end
    options = fixOptions(options)
    if not next(options) then return end
    
    local targetId
    
    if targetSystem == "ox_target" then
        targetId = exports.ox_target:addSphereZone({
            coords = coords,
            radius = radius,
            debug = debug or targetDebug,
            options = options
        })
    elseif targetSystem == "qb-target" then
        exports['qb-target']:AddCircleZone(name, coords, radius, {
            name = name,
            debugPoly = debug or targetDebug
        }, {
            options = options,
            distance = getLargestDistance(options)
        })
    end
    
    table.insert(targetZones, {
        name = name,
        id = targetId,
        creator = GetInvokingResource() or GetCurrentResourceName()
    })
    
    return targetId
end

---Remove zone by name
---@param name string
function TARGET.RemoveZone(name)
    if not targetSystem or not name then return end
    
    for i, data in pairs(targetZones) do
        if data.name == name then
            if targetSystem == "ox_target" then
                exports.ox_target:removeZone(data.id)
            elseif targetSystem == "qb-target" then
                exports['qb-target']:RemoveZone(name)
            end
            table.remove(targetZones, i)
            break
        end
    end
end


---Get current target system name
---@return string|nil
function TARGET.GetResourceName()
    return targetSystem
end

-- Cleanup zones on resource stop
AddEventHandler('onResourceStop', function(resource)
    local currentResource = GetCurrentResourceName()
    if resource ~= currentResource then return end
    
    for _, zone in pairs(targetZones) do
        if zone.creator == resource then
            if targetSystem == "ox_target" then
                exports.ox_target:removeZone(zone.id)
            elseif targetSystem == "qb-target" then
                exports['qb-target']:RemoveZone(zone.name)
            end
        end
    end
    targetZones = {}
end)

return TARGET

