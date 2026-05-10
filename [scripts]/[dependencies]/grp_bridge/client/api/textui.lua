---@diagnostic disable: duplicate-set-field
local TEXTUI = {}
local textUISystem = nil

---Auto detect textui system
---@return string|nil
local function detectTextUISystem()
    if config.TextUI:lower() ~= "auto" then
        local configured = config.TextUI:lower()
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
                DebugPrint("Using configured TextUI system: " .. configured, "info")
            end
            return configured
        else
            DebugPrint("Configured TextUI system '" .. configured .. "' not found! Falling back to auto-detection", "warning")
        end
    end
    
    -- Auto detection - priority order
    if GetResourceState("ox_lib") == "started" then
        if config.Debug then
            DebugPrint("Detected TextUI system: ox_lib", "success")
        end
        return "ox_lib"
    elseif GetResourceState("jg-textui") == "started" then
        if config.Debug then
            DebugPrint("Detected TextUI system: jg-textui", "success")
        end
        return "jg-textui"
    elseif GetResourceState("okokTextUI") == "started" then
        if config.Debug then
            DebugPrint("Detected TextUI system: okokTextUI", "success")
        end
        return "okokTextUI"
    elseif GetResourceState("cd_drawtextui") == "started" then
        if config.Debug then
            DebugPrint("Detected TextUI system: cd_drawtextui", "success")
        end
        return "cd_drawtextui"
    elseif GetResourceState("lation_ui") == "started" then
        if config.Debug then
            DebugPrint("Detected TextUI system: lation_ui", "success")
        end
        return "lation_ui"
    end
    
    -- Fallback to framework native
    if config.Debug then
        DebugPrint("No TextUI system detected! Using framework native", "warning")
    end
    return "native"
end

---Initialize TextUI system
local function initializeTextUI()
    textUISystem = detectTextUISystem()
    if textUISystem then
        if config.Debug then
            DebugPrint("TextUI system initialized: " .. textUISystem, "success")
        end
    end
end

-- Initialize on resource start
CreateThread(function()
    Wait(1000)
    initializeTextUI()
end)

---Show help text on screen
---@param message string The message to display
---@param position string|nil Position for textui (top, left, right, etc)
function TEXTUI.ShowHelpText(message, position)
    if not message then return end
    
    if textUISystem == "ox_lib" then
        exports.ox_lib:showTextUI(message, {
            position = position or "right-center"
        })
        
    elseif textUISystem == "jg-textui" then
        exports['jg-textui']:DrawText(message)
        
    elseif textUISystem == "okokTextUI" then
        local pos = position or "center"
        exports['okokTextUI']:Open(message, 'darkblue', pos, false)
        
    elseif textUISystem == "cd_drawtextui" then
        TriggerEvent('cd_drawtextui:ShowUI', 'show', message)
        
    elseif textUISystem == "lation_ui" then
        exports.lation_ui:showTextUI(message, position or "left")
        
    elseif textUISystem == "native" then
        -- Use framework native helptext
        local framework = GRP.GetFrameworkName()
        if framework == "esx" then
            TriggerEvent('esx:showHelpNotification', message)
        elseif framework == "qb" or framework == "qbx" then
            -- QB uses DrawText natively
            BeginTextCommandDisplayHelp('STRING')
            AddTextComponentSubstringPlayerName(message)
            EndTextCommandDisplayHelp(0, false, true, -1)
        end
    end
end

---Hide help text from screen
function TEXTUI.HideHelpText()
    if textUISystem == "ox_lib" then
        exports.ox_lib:hideTextUI()
        
    elseif textUISystem == "jg-textui" then
        exports['jg-textui']:HideText()
        
    elseif textUISystem == "okokTextUI" then
        exports['okokTextUI']:Close()
        
    elseif textUISystem == "cd_drawtextui" then
        TriggerEvent('cd_drawtextui:HideUI')
        
    elseif textUISystem == "lation_ui" then
        exports.lation_ui:hideTextUI()
        
    elseif textUISystem == "native" then
        -- Native systems auto-hide or use ClearHelp
        ClearAllHelpMessages()
    end
end

---Show advanced textui with icon (ox_lib specific, fallback to basic for others)
---@param options table Options table {text, icon, position, style}
function TEXTUI.ShowAdvancedText(options)
    if not options or not options.text then return end
    
    if textUISystem == "ox_lib" then
        exports.ox_lib:showTextUI(options.text, {
            position = options.position or "right-center",
            icon = options.icon,
            style = options.style
        })
    else
        -- Fallback to basic text for other systems
        TEXTUI.ShowHelpText(options.text, options.position)
    end
end

---Update textui message (ox_lib specific, for others hide and show)
---@param message string New message
function TEXTUI.UpdateText(message)
    if not message then return end
    
    if textUISystem == "ox_lib" then
        exports.ox_lib:showTextUI(message)
    else
        -- For other systems, hide and show again
        TEXTUI.HideHelpText()
        Wait(50)
        TEXTUI.ShowHelpText(message)
    end
end

---Check if textui is currently showing (ox_lib only)
---@return boolean
function TEXTUI.IsShowing()
    if textUISystem == "ox_lib" then
        return exports.ox_lib:isTextUIOpen() or false
    end
    return false
end

---Get current TextUI system name
---@return string
function TEXTUI.GetResourceName()
    return textUISystem or "none"
end

---Show key-based help text (Hold E to interact, etc)
---@param key string Key name (E, F, etc)
---@param message string Message to display
function TEXTUI.ShowKeyHelp(key, message)
    local formattedMessage = ("[~INPUT_%s~] %s"):format(key, message)
    
    if textUISystem == "ox_lib" then
        exports.ox_lib:showTextUI(("[%s] %s"):format(key, message))
    else
        TEXTUI.ShowHelpText(formattedMessage)
    end
end

---Draw 3D text at coords (native implementation)
---@param coords vector3
---@param text string
---@param scale number|nil
function TEXTUI.Draw3DText(coords, text, scale)
    scale = scale or 0.35
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - coords)
    
    if onScreen then
        SetTextScale(scale * (1 / dist), scale * (1 / dist))
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 150)
    end
end

---Show notification (alternative to framework notification)
---@param message string
---@param type string|nil Type: success, error, info
---@param duration number|nil Duration in ms
function TEXTUI.ShowNotification(message, type, duration)
    type = type or "info"
    duration = duration or 5000
    
    if textUISystem == "ox_lib" then
        exports.ox_lib:notify({
            description = message,
            type = type,
            duration = duration
        })
    elseif textUISystem == "okokTextUI" then
        -- okokTextUI has notification system
        TriggerEvent('okokNotify:Alert', "Notification", message, duration, type)
    elseif textUISystem == "lation_ui" then
        exports.lation_ui:notify({
            title = type:upper(),
            message = message,
            duration = duration
        })
    else
        -- Fallback to framework notification
        GRP.ShowNotification(message)
    end
end


-- Register events for server-triggered textui
RegisterNetEvent('grp_bridge:Client:ShowTextUI', function(message, position)
    TEXTUI.ShowHelpText(message, position)
end)

RegisterNetEvent('grp_bridge:Client:HideTextUI', function()
    TEXTUI.HideHelpText()
end)

RegisterNetEvent('grp_bridge:Client:ShowKeyHelp', function(key, message)
    TEXTUI.ShowKeyHelp(key, message)
end)

return TEXTUI

