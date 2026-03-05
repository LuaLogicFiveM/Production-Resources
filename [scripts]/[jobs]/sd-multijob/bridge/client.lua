local EnableNotifOX = false -- Enable use of ox_lib for notifications if available
local EnableNotifLation = false -- Enable use of lation_ui for notifications if available

--- Capitalizes the first letter of a string and lowercases the rest.
---@param str string The string to capitalize.
---@return string The capitalized string.
CapitalizeFirst = function(str)
    return str:sub(1, 1):upper() .. str:sub(2):lower()
end

--- Selects and returns the most appropriate notification function based on the current game setup.
-- This function checks the available libraries and configurations to determine which notification method to use.
-- It then returns a function tailored to use that method for showing notifications.
---@return function A function configured to show notifications using the determined method.
local CreateNotificationFunction = function()
    if lib ~= nil and EnableNotifOX then
        return function(message, type)
            local title = CapitalizeFirst(type or 'inform')
            lib.notify({
                id = math.random(1, 999999),
                title = title,
                description = message,
                type = type or 'inform'
            })
        end
    elseif EnableNotifLation then
        return function(message, type)
            local title = CapitalizeFirst(type or 'inform')
            exports.lation_ui:notify({
                title = title,
                message = message,
                type = type or 'info',
            })
        end
    else
        if Framework == 'esx' then
            return function(message, _)
                ESX.ShowNotification(message)
            end
        elseif Framework == 'qb' then
            return function(message, type)
                QBCore.Functions.Notify(message, type or 'info')
            end
        end

        return function(message, type)
            error(string.format("Notification system not supported. Message was: %s, Type was: %s", message, type))
        end
    end
end

--- The chosen method for showing notifications, determined at the time of script initialization.
local Notify = CreateNotificationFunction()

--- Display a notification to the user.
-- This function triggers a notification with a specific message and type.
---@param message string The text of the notification to be displayed.
---@param type string The type of notification, which may dictate the visual style or urgency.
ShowNotification = function(message, type)
    Notify(message, type)
end

RegisterNetEvent('sd-multijob:notification', function(message, type)
    Notify(message, type)
end)

TextUI = {}

local EnableTextOX = true -- Enable use of ox_lib for TextUI if available
local EnableTextLation = false -- Enable use of lation_ui for TextUI if available
local lastInteractionTime = 0

-- Function to dynamically select the appropriate show and hide functions based on the current configuration.
local CreateTextUI = function()
    if lib ~= nil and EnableTextOX then
        return function(text, options)
            lib.showTextUI(text, options)
        end, function()
            lib.hideTextUI()
        end
    elseif EnableTextLation then
        return function(text, options)
            exports.lation_ui:showText({
                description = text,
                icon = options.icon or nil,
                position = options.position or nil,
            })
        end, function()
            exports.lation_ui:hideText()
        end
    elseif GetResourceState('cd_drawtextui') == 'started' then
        return function(text)
            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
        end, function()
            TriggerEvent('cd_drawtextui:HideUI')
        end
    elseif Framework == 'qb' then
        return function(text, options)
            exports['qb-core']:DrawText(text, options and options.position or 'left')
        end, function()
            exports['qb-core']:HideText()
        end
    else
        return function(text)
            error("TextUI system not supported. Text was: " .. text)
        end, function() end
    end
end

-- Initialize the show and hide functions
local ShowTextUI, HideTextUI = CreateTextUI()

-- Table to store points
TextUI.Points = {}
TextUI.Models = {}
TextUI.Entities = {}

--- Adds a point to the list of points.
---@param name string The unique name of the point.
---@param coords vector3 The coordinates of the point.
---@param message string|nil The message to display at the point.
---@param action string|function|nil The event to trigger or the function to call when the key is pressed.
---@param canInteract function|nil A function that returns true/false to determine if interaction is allowed.
---@param distance number The distance within which the interaction is allowed.
---@param options table|nil The options for interaction if multiple are available.
TextUI.AddPoint = function(name, coords, message, action, canInteract, distance, options)
    table.insert(TextUI.Points, { coords = coords, message = message, action = action, canInteract = canInteract, distance = distance, inside = false, secondaryThread = nil })
end

--- Adds a scrollable point to the list of points.
---@param name string The unique name of the point.
---@param coords vector3 The coordinates of the point.
---@param options table The options for interaction.
---@param distance number The distance within which the interaction is allowed.
TextUI.AddScrollablePoint = function(name, coords, options, distance)
    TextUI.Points[name] = {
        coords = coords,
        options = options,
        currentIndex = 1,
        distance = distance,
        inside = false,
        secondaryThread = nil
    }
end

--- Removes a point from the list of points.
---@param name string The unique name of the point to remove.
TextUI.RemovePoint = function(name)
    local point = TextUI.Points[name]
    if point then
        if point.secondaryThread then
            TerminateThread(point.secondaryThread)
            point.secondaryThread = nil
        end
        TextUI.Hide()
        point.inside = false
        TextUI.Points[name] = nil
    end
end

--- Adds a target for specific entities.
---@param entity number The entity to target.
---@param options table The options for interaction.
TextUI.AddTargetEntity = function(entity, options)
    TextUI.Entities[entity] = options
end

--- Removes a target entity.
---@param entity number The entity to remove.
TextUI.RemoveTargetEntity = function(entity)
    if TextUI.Entities[entity] then
        if TextUI.Entities[entity].secondaryThread then
            TerminateThread(TextUI.Entities[entity].secondaryThread)
            TextUI.Entities[entity].secondaryThread = nil
        end
        TextUI.Hide()
        TextUI.Entities[entity].inside = false
        TextUI.Entities[entity] = nil
    end
end

--- Shows the TextUI with the given text and options.
---@param text string The text to display.
---@param options table|nil Options for displaying the text.
TextUI.Show = function(text, options)
    ShowTextUI(text, options)
end

--- Hides the TextUI.
TextUI.Hide = function()
    HideTextUI()
end

CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        local closestPoint = nil
        local closestEntity = nil

        -- Check points
        for name, point in pairs(TextUI.Points) do
            local distance = #(coords - point.coords)
            if distance <= point.distance and (not point.canInteract or point.canInteract()) then
                closestPoint = point
                break
            elseif point.inside then
                point.inside = false
                TextUI.Hide()
                if point.secondaryThread then
                    TerminateThread(point.secondaryThread)
                    point.secondaryThread = nil
                end
            end
        end

        -- Check entities
        for entity, options in pairs(TextUI.Entities) do
            if DoesEntityExist(entity) then
                local entityCoords = GetEntityCoords(entity)
                local distance = #(coords - entityCoords)
                if distance <= options.distance and (not options.canInteract or options.canInteract(entity)) then
                    closestEntity = { entity = entity, options = options }
                    break
                elseif options.inside then
                    options.inside = false
                    TextUI.Hide()
                    if options.secondaryThread then
                        TerminateThread(options.secondaryThread)
                        options.secondaryThread = nil
                    end
                end
            elseif options.inside then
                options.inside = false
                TextUI.Hide()
                if options.secondaryThread then
                    TerminateThread(options.secondaryThread)
                    options.secondaryThread = nil
                end
            end
        end

        if closestPoint then
            if not closestPoint.inside then
                closestPoint.inside = true
                if closestPoint.options then
                    local displayText = string.format("[E] %s  %s", closestPoint.options[closestPoint.currentIndex].label, "↕")
                    TextUI.Show(displayText, { position = 'right-center' })
                    closestPoint.secondaryThread = CreateThread(function()
                        while closestPoint.inside do
                            if IsControlJustReleased(0, 38) then -- E key
                                local currentTime = GetGameTimer()
                                if currentTime - lastInteractionTime >= 5000 then
                                    lastInteractionTime = currentTime
                                    local selectedOption = closestPoint.options[closestPoint.currentIndex]
                                    if type(selectedOption.event) == "string" then
                                        TriggerEvent(selectedOption.event)
                                    elseif type(selectedOption.action) == "function" then
                                        selectedOption.action()
                                    end
                                end
                            elseif IsControlJustReleased(0, 241) then -- Scroll Wheel Up
                                closestPoint.currentIndex = (closestPoint.currentIndex - 2) % #closestPoint.options + 1
                                TextUI.Show(string.format("[E] %s  %s", closestPoint.options[closestPoint.currentIndex].label, "↕"), { position = 'right-center' })
                            elseif IsControlJustReleased(0, 242) then -- Scroll Wheel Down
                                closestPoint.currentIndex = closestPoint.currentIndex % #closestPoint.options + 1
                                TextUI.Show(string.format("[E] %s  %s", closestPoint.options[closestPoint.currentIndex].label, "↕"), { position = 'right-center' })
                            end
                            Wait(0) -- Check every frame
                        end
                    end)
                else
                    local displayText = string.format("[E] %s", closestPoint.message)
                    TextUI.Show(displayText, { position = 'right-center' })
                    closestPoint.secondaryThread = CreateThread(function()
                        while closestPoint.inside do
                            if IsControlJustReleased(0, 38) then -- E key
                                local currentTime = GetGameTimer()
                                if currentTime - lastInteractionTime >= 5000 then
                                    lastInteractionTime = currentTime
                                    if type(closestPoint.action) == "string" then
                                        TriggerEvent(closestPoint.action or closestPoint.event)
                                    elseif type(closestPoint.action) == "function" then
                                        closestPoint.action()
                                    end
                                end
                            end
                            Wait(0) -- Check every frame
                        end
                    end)
                end
            end
        elseif closestEntity then
            if not closestEntity.options.inside then
                closestEntity.options.inside = true
                local displayText = string.format("[E] %s", closestEntity.options.label)
                TextUI.Show(displayText, { position = 'right-center' })
                closestEntity.options.secondaryThread = CreateThread(function()
                    while closestEntity.options.inside do
                        if IsControlJustReleased(0, 38) then -- E key
                            local currentTime = GetGameTimer()
                            if currentTime - lastInteractionTime >= 5000 then
                                lastInteractionTime = currentTime
                                local data = closestEntity.options.data or {}
                                if type(closestEntity.options.action) == "string" then
                                    TriggerEvent(closestEntity.options.action, data)
                                elseif type(closestEntity.options.action) == "function" then
                                    closestEntity.options.action(closestEntity.entity, data)
                                end
                            end
                        end
                        Wait(0) -- Check every frame
                    end
                end)
            end
        end

        for entity in pairs(TextUI.Entities) do
            if not DoesEntityExist(entity) then
                TextUI.Entities[entity] = nil
            end
        end

        Wait(500) -- Check every 500 ms.
    end
end)

Target = {}
local target = nil

--- Initialize the target system by checking available resources and setting the target module.
local Initialize = function()
    local resources = {"qb-target", "qtarget", "ox_target"}  -- List of potential target resources.
    for _, resource in ipairs(resources) do
        if GetResourceState(resource) == 'started' then
            if resource == 'ox_target' then
                target = 'qtarget'
            else
                target = resource
            end
            break
        end
    end

    if not target then
        error("No target resource found or started.")
        return false
    end
    return true
end

Initialize()

--- Add a box zone.
---@param identifier string The identifier for the zone.
---@param coords table Coordinates where the zone is centered.
---@param width number The width of the box zone.
---@param length number The length of the box zone.
---@param data table Additional data such as heading, options, and distance.
---@param debugPoly boolean Whether to debug the polygon.
---@return handler The handle to the created zone.
Target.AddBoxZone = function(identifier, coords, width, length, data, debugPoly)
    local handler = exports[target]:AddBoxZone(identifier, coords, width, length, {
        name = identifier,
        heading = data.heading,
        debugPoly = debugPoly,
        minZ = coords.z - 1.2,
        maxZ = coords.z + 1.2,
    }, {
        options = data.options,
        distance = data.distance,
    })
    return handler
end

--- Add a circle zone.
---@param identifier string The identifier for the zone.
---@param coords table Coordinates where the zone is centered.
---@param radius number The radius of the circle zone.
---@param data table Additional data such as options and distance.
---@param debugPoly boolean Whether to debug the polygon.
---@return handler The handle to the created zone.
Target.AddCircleZone = function(identifier, coords, radius, data, debugPoly)
    local handler = exports[target]:AddCircleZone(identifier, coords, radius, {
        name = identifier,
        useZ = true,
        debugPoly = debugPoly,
    }, {
        options = data.options,
        distance = data.distance,
    })
    return handler
end

--- Add a target entity.
---@param entityId number The entity ID to target.
---@param data table Additional data such as options and distance.
Target.AddTargetEntity = function(entityId, data)
    exports[target]:AddTargetEntity(entityId, {
        options = data.options,
        distance = data.distance,
    })
end

--- Add a target model.
---@param models table|array Models to target.
---@param data table Additional data such as options and distance.
Target.AddTargetModel = function(models, data)
    exports[target]:AddTargetModel(models, {
        options = data.options,
        distance = data.distance,
    })
end

--- Remove a target entity.
---@param entity number The entity to remove from targeting.
Target.RemoveTargetEntity = function(entity)
    exports[target]:RemoveTargetEntity(entity)
end

--- Remove a zone.
---@param identifier string The identifier for the zone to remove.
Target.RemoveZone = function(identifier)
    exports[target]:RemoveZone(identifier)
end

--- Add a global ped target.
---@param identifier string The identifier for the global ped.
---@param data table Additional data such as options and distance.
Target.AddGlobalPed = function(identifier, data)
    exports[target]:AddGlobalPed({
        name = identifier,
        options = data.options,
        distance = data.distance,
    })
end

--- Remove a global ped target.
---@param identifier string The identifier for the global ped to remove.
Target.RemoveGlobalPed = function(identifier)
    exports[target]:RemoveGlobalPed(identifier)
end

Interaction = {}

Zones = {} -- Table to store zones
Entities = {} -- Table to store entities

-- Function to add a box zone
---@param interactType string The interaction type ('textui' or 'target').
---@param name string The name of the zone.
---@param coords vector3 The coordinates of the zone.
---@param length number The length of the box zone.
---@param width number The width of the box zone.
---@param options table The options for interaction.
---@param debug boolean Enable debugging for the zone.
Interaction.AddBoxZone = function(interactType, name, coords, length, width, options, debug)
    if interactType == 'textui' then
        if #options.options > 1 then
            TextUI.AddScrollablePoint(name, coords, options.options, math.max(length, width))
        else
            local interaction = options.options[1]
            TextUI.AddPoint(name, coords, interaction.label, interaction.action or interaction.event, interaction.canInteract, math.max(length, width))
        end
    else
        local handler = Target.AddBoxZone(name, coords, length, width, options, debug)
        Zones[name] = handler
        return handler
    end
end

-- Function to add a circle zone
---@param interactType string The interaction type ('textui' or 'target').
---@param name string The name of the zone.
---@param coords vector3 The coordinates of the zone.
---@param radius number The radius of the circle zone.
---@param options table The options for interaction.
---@param debug boolean Enable debugging for the zone.
Interaction.AddCircleZone = function(interactType, name, coords, radius, options, debug)
    if interactType == 'textui' then
        if #options.options > 1 then
            TextUI.AddScrollablePoint(name, coords, options.options, radius)
        else
            local interaction = options.options[1]
            TextUI.AddPoint(name, coords, interaction.label, interaction.action or interaction.event, interaction.canInteract, radius)
        end
    else
        local handler = Target.AddCircleZone(name, coords, radius, options, debug)
        Zones[name] = handler
        return handler
    end
end

Interaction.AddTargetEntity = function(interactType, entity, options)
    if interactType == 'textui' then
        local opt = options.options and options.options[1] or options
        TextUI.AddTargetEntity(entity, {
            label = opt.label,
            action = opt.action or opt.event,
            canInteract = opt.canInteract,
            distance = options.distance,
            data = opt.data
        })
        Entities[entity] = true
    else
        Target.AddTargetEntity(entity, options)
        Entities[entity] = true
    end
end

-- Function to remove a target entity
---@param entity number The entity to remove.
Interaction.RemoveTargetEntity = function(entity)
    if Entities[entity] then
        TextUI.RemoveTargetEntity(entity)
        Target.RemoveTargetEntity(entity)
        Entities[entity] = nil
    end
end

-- Function to remove a specific zone
---@param name string The name of the zone to remove.
Interaction.RemoveZone = function(name)
    if Zones[name] then
        Target.RemoveZone(Zones[name])
        Zones[name] = nil
    elseif TextUI.Points[name] then
        TextUI.RemovePoint(TextUI.Points[name].coords)
        TextUI.Points[name] = nil
    end
end

-- Function to remove all zones
Interaction.RemoveAllZones = function()
    if next(Zones) ~= nil then
        for name, handler in pairs(Zones) do
            Target.RemoveZone(handler)
        end
        Zones = {}
    end
end