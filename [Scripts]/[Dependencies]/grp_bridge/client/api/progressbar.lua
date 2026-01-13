---@diagnostic disable: duplicate-set-field
local PROGRESSBAR = {}
local progressBarSystem = nil
local progressBarDebug = config.Debug

---Auto detect progress bar system
---@return string|nil
local function detectProgressBarSystem()
    if config.ProgressBar:lower() ~= "auto" then
        local configured = config.ProgressBar:lower()
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
                DebugPrint("Using configured progress bar system: " .. configured, "info")
            end
            return configured
        else
            DebugPrint("Configured progress bar system '" .. configured .. "' not found! Falling back to auto-detection", "warning")
        end
    end
    
    -- Auto detection
    if GetResourceState("ox_lib") == "started" then
        if config.Debug then
            DebugPrint("Detected progress bar system: ox_lib", "success")
        end
        return "ox_lib"
    elseif GetResourceState("lation_ui") == "started" then
        if config.Debug then
            DebugPrint("Detected progress bar system: lation_ui", "success")
        end
        return "lation_ui"
    elseif GetResourceState("progressbar") == "started" then
        if config.Debug then
            DebugPrint("Detected progress bar system: progressbar", "success")
        end
        return "progressbar"
    end
    
    DebugPrint("No progress bar system detected! Progress bar functions will not work", "error")
    return nil
end

---Initialize progress bar system
local function initializeProgressBar()
    progressBarSystem = detectProgressBarSystem()
    if progressBarSystem then
        if config.Debug then
            DebugPrint("Progress bar system initialized: " .. progressBarSystem, "success")
        end
    end
end

-- Initialize on resource start
CreateThread(function()
    Wait(1000)
    initializeProgressBar()
end)

---Convert QB progress bar options to ox_lib format
---@param options table
---@return table
local function convertQBtoOx(options)
    if not options then return options end
    local prop1 = options.prop or {}
    local prop2 = options.propTwo or {}
    local props = {
        {
            model = prop1.model,
            bone = prop1.bone,
            pos = prop1.coords,
            rot = prop1.rotation,
        },
        {
            model = prop2.model,
            bone = prop2.bone,
            pos = prop2.coords,
            rot = prop2.rotation,
        }
    }
    return {
        duration = options.duration,
        label = options.label,
        position = 'bottom',
        useWhileDead = options.useWhileDead,
        canCancel = options.canCancel,
        disable = {
            move = options.controlDisables and options.controlDisables.disableMovement,
            car = options.controlDisables and options.controlDisables.disableCarMovement,
            combat = options.controlDisables and options.controlDisables.disableCombat,
            mouse = options.controlDisables and options.controlDisables.disableMouse
        },
        anim = {
            dict = options.animation and options.animation.animDict,
            clip = options.animation and options.animation.anim,
            flag = options.animation and options.animation.flags or 49,
        },
        prop = props,
    }
end

---Convert ox_lib progress bar options to QB format
---@param options table
---@return table
local function convertOxtoQB(options)
    if not options then return options end
    local prop1 = (options.prop and options.prop[1]) or options.prop or {}
    local prop2 = (options.prop and options.prop[2]) or {}
    return {
        name = options.label,
        duration = options.duration,
        label = options.label,
        useWhileDead = options.useWhileDead,
        canCancel = options.canCancel,
        controlDisables = {
            disableMovement = options.disable and options.disable.move,
            disableCarMovement = options.disable and options.disable.car,
            disableMouse = options.disable and options.disable.mouse,
            disableCombat = options.disable and options.disable.combat
        },
        animation = {
            animDict = options.anim and options.anim.dict,
            anim = options.anim and options.anim.clip,
            flags = options.anim and options.anim.flag or 49
        },
        prop = {
            model = prop1.model,
            bone = prop1.bone,
            coords = prop1.pos,
            rotation = prop1.rot
        },
        propTwo = {
            model = prop2.model,
            bone = prop2.bone,
            coords = prop2.pos,
            rotation = prop2.rot
        }
    }
end

---Convert ox_lib progress bar options to lation_ui format
---@param options table
---@return table
local function convertOxtoLation(options)
    if not options then return options end
    local prop1 = options.prop or {}
    local prop2 = options.propTwo or {}
    return {
        duration = options.duration,
        label = options.label,
        description = options.description,
        icon = options.icon,
        iconColor = options.iconColor,
        iconAnimation = options.iconAnimation,
        useWhileDead = options.useWhileDead,
        canCancel = options.canCancel,
        disable = options.disable,
        anim = options.anim,
        prop = {
            {
                model = prop1.model,
                bone = prop1.bone,
                pos = prop1.coords,
                rot = prop1.rotation,
            },
            {
                model = prop2.model,
                bone = prop2.bone,
                pos = prop2.coords,
                rot = prop2.rotation,
            }
        },
    }
end

---Show progress bar
---@param options table
---@param callback function|nil
---@param isQBFormat boolean|nil
---@return boolean
function PROGRESSBAR.ShowProgress(options, callback, isQBFormat)
    if not progressBarSystem then return false end
    
    if progressBarSystem == "ox_lib" then
        if isQBFormat then
            options = convertQBtoOx(options)
        end
        
        local style = options.style or 'bar'
        local success = style == 'circle' and exports.ox_lib:progressCircle(options) or exports.ox_lib:progressBar(options)
        
        if callback then callback(success) end
        return success
        
    elseif progressBarSystem == "lation_ui" then
        if isQBFormat then
            options = convertQBtoOx(options)
        else
            options = convertOxtoLation(options)
        end
        
        local success = exports.lation_ui:progressBar(options)
        
        if callback then callback(success) end
        return success
        
    elseif progressBarSystem == "progressbar" then
        if not isQBFormat then
            options = convertOxtoQB(options)
        end
        
        if not exports['progressbar'] then return false end
        
        local prom = promise.new()
        exports['progressbar']:Progress(options, function(cancelled)
            if callback then callback(not cancelled) end
            prom:resolve(not cancelled)
        end)
        return Citizen.Await(prom)
    end
    
    return false
end

---Get current progress bar system name
---@return string|nil
function PROGRESSBAR.GetResourceName()
    return progressBarSystem
end

return PROGRESSBAR
