-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          ERROR HANDLING                          │
-- └──────────────────────────────────────────────────────────────────┘ 

local resource_name = '['..GetCurrentResourceName()..']'
local end_line = '^8==================[END]===================^0'
local total_length = #end_line-4
local side = math.floor((total_length - #resource_name) / 2)
local left = string.rep('=', side)
local right = string.rep('=', total_length - #resource_name - side)
local start_line = ('^8%s%s%s^0'):format(left, resource_name, right)

function ERROR(error_code, explanation)
    Citizen.Trace(string.format('\n\n%s\n^1ERROR CODE: %s^0\n^1EXPLANATION: %s^0\n%s\n\n', start_line, error_code, explanation and tostring(explanation) or 'No explanation provided', end_line))
end

function TypeCheck(value, expected_type, error_code, explanation)
    local actual = type(value)
    if actual == expected_type then
        return true
    end
    Citizen.Trace(string.format('\n\n%s\n^1ERROR: %s expected, got %s : [%s]^0\n^1ERROR CODE: %s^0\n^1EXPLANATION: %s^0\n%s\n\n', start_line, expected_type, actual, value,  error_code and tostring(error_code) or 'NULL', tostring(explanation)and tostring(explanation) or 'No explanation provided', end_line))
    return false
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          PRE START CHECKS                        │
-- └──────────────────────────────────────────────────────────────────┘ 

--framework checks
CreateThread(function()
    if GetCurrentResourceName() ~= 'cd_bridge' then return end
    Wait(1000)

    if not HasFrameworkLoaded() then
        ERROR('framework_configuration_error_found', Cfg.Framework..' object not found. Please ensure that your framework resource is installed and running properly.')
    end
end)

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                        NOTIFICATION WRAPPER                      │
-- └──────────────────────────────────────────────────────────────────┘ 

function Notif(action, locale_key, ...)
    if not TypeCheck(action, 'number', '3001', 'action missing from Notif functiion, 1st arg. Locale Key: '..(locale_key  or 'nil')) then
        return
    end

    if action < 1 or action > 3 then
        return ERROR('3002', 'action not valid in Notif function, 1st arg: '..(action or 'nil')..'. Locale Key: '..(locale_key or 'nil'))
    end

    if not TypeCheck(locale_key, 'string', '3002', 'locale_key missing from Notif functiion, 2nd arg. Locale Key: '..(locale_key or 'nil')) then
        return
    end

    local template = (Locales and Locales[Config.Language][locale_key]) or (LocalesTable and LocalesTable[Config.Language][locale_key])
    if not template then
        return ERROR('3003', 'locale not found in locales.lua: '..(locale_key or 'nil'))
    end

    local ok, message = pcall(string.format, template, ...)
    if not ok then
        return ERROR('3004', 'Format failed for key: ' .. (locale_key or 'nil'))
    end

    local ok, err = pcall(Notification, action, message)
    if not ok then
        return ERROR('3005', 'Notification failed: ' .. tostring(err))
    end
end