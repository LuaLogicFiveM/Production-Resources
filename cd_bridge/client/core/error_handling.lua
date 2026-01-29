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
-- │                               DEBUG                              │
-- └──────────────────────────────────────────────────────────────────┘ 

local function DebugPrints(source)
    Citizen.Trace('^6-----------------------^0\n')
    Citizen.Trace(string.format('^1CODESIGN DEBUG^0 (%s - v%s - %s)\n', GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), source and 'client' or 'server'))
    local admin = GetAdminPerms(source)
    Citizen.Trace(string.format('^6Admin Perms:^0 %s\n', type(admin) == 'string' and admin or json.encode(admin)))
    Citizen.Trace(string.format('^6Has Admin Perms:^0 %s\n', HasAdminPerms(source, admin)))
    Citizen.Trace('^6-----------------------^0\n')

    if Cfg.Framework == 'esx' or Cfg.Framework == 'qbcore' or Cfg.Framework == 'qbox' or Cfg.Framework == 'other' then
        Citizen.Trace('^3CHARACTER^0\n')
        Citizen.Trace(string.format('^6Character Name:^0 %s\n', GetCharacterName(source)))
        Citizen.Trace(string.format('^6Job Name:^0 %s\n', GetJobName(source)))
        Citizen.Trace(string.format('^6Job Label:^0 %s\n', GetJobLabel(source)))
        Citizen.Trace(string.format('^6Job Grade:^0 %s\n', GetJobGrade(source)))
        Citizen.Trace(string.format('^6Job Grade Label:^0 %s\n', GetJobGradeLabel(source)))
        Citizen.Trace(string.format('^6On Duty:^0 %s\n', GetJobDuty(source)))
        Citizen.Trace(string.format('^6Gang Name:^0 %s\n', GetGangName(source)))
        Citizen.Trace(string.format('^6Gang Label:^0 %s\n', GetGangLabel(source)))
        Citizen.Trace(string.format('^6Gang Grade:^0 %s\n', GetGangGrade(source)))
        Citizen.Trace('^6-----------------------^0\n')
    end

    Citizen.Trace('^3CONFIG^0\n')
    Citizen.Trace(string.format('^6Framework:^0 %s\n', Cfg.Framework))
    Citizen.Trace(string.format('^6Database:^0 %s\n', Cfg.Database))
    Citizen.Trace(string.format('^6BridgeDebugSQL:^0 %s\n', tostring(Cfg.BridgeDebugSQL)))
    Citizen.Trace(string.format('^6BridgeDebug:^0 %s\n', tostring(Cfg.BridgeDebug)))
    Citizen.Trace(string.format('^6Language:^0 %s\n', Cfg.Language))
    Citizen.Trace(string.format('^6Notification:^0 %s\n', Cfg.Notification))
    Citizen.Trace(string.format('^6DrawTextUI:^0 %s\n', Cfg.DrawTextUI))
    Citizen.Trace(string.format('^6Target:^0 %s\n', Cfg.Target))
    Citizen.Trace(string.format('^6Inventory:^0 %s\n', Cfg.Inventory))
    Citizen.Trace(string.format('^6TimeWeather:^0 %s\n', Cfg.TimeWeather))
    Citizen.Trace(string.format('^6VehicleKeys:^0 %s\n', Cfg.VehicleKeys))
    Citizen.Trace(string.format('^6VehicleFuel:^0 %s\n', Cfg.VehicleFuel))
    Citizen.Trace(string.format('^6Phone:^0 %s\n', Cfg.Phone))
    Citizen.Trace(string.format('^6Dispatch:^0 %s\n', Cfg.Dispatch))
    Citizen.Trace(string.format('^6PersistentVehicles:^0 %s\n', Cfg.PersistentVehicles))
    Citizen.Trace('^6-----------------------^0\n')
end

if GetCurrentResourceName() == 'cd_bridge' then
    RegisterCommand('debugbridge_client', function(source)
        local isAdmin = HasAdminPerms(source, {'owner', 'superadmin', 'god', 'admin', 'moderator', 'mod'})
        local debugEnabled = Cfg.BridgeDebug

        if isAdmin or debugEnabled then
            DebugPrints(source)
            return
        end

        Citizen.Trace('You cannot use this command. You must have admin permissions or enable Cfg.BridgeDebug.\n')
    end, false)
end

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