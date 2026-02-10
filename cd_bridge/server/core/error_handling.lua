-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          ERROR HANDLING                          │
-- └──────────────────────────────────────────────────────────────────┘ 

local resource_name = string.format('[%s - v%s - %s]', GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), 'server')
local end_line = '^8==================[END]===================^0'
local total_length = #end_line-4
local side = math.floor((total_length - #resource_name) / 2)
local left = string.rep('=', side)
local right = string.rep('=', total_length - #resource_name - side)
local start_line = ('^8%s%s%s^0'):format(left, resource_name, right)
local error_support_message = '^2NEED SUPPORT?^0\n^0Discord: ^3https://discord.gg/codesign.\n^0Documentation: ^3https://docs.codesign.pro.\n'..end_line

function ERROR(error_code, explanation)
    Citizen.Trace(string.format('\n\n%s\n^1ERROR CODE: %s^0\n^1EXPLANATION: %s^0\n\n%s\n\n', start_line, error_code, explanation and tostring(explanation) or 'No explanation provided', error_support_message))
end

function TypeCheck(value, expected_type, error_code, explanation)
    local actual = type(value)
    if actual == expected_type then
        return true
    end
    Citizen.Trace(string.format('\n\n%s\n^1ERROR: %s expected, got %s : [%s]^0\n^1ERROR CODE: %s^0\n^1EXPLANATION: %s^0\n\n%s\n\n', start_line, expected_type, actual, value, error_code and tostring(error_code) or 'NULL', tostring(explanation) and tostring(explanation) or 'No explanation provided', error_support_message))
    return false
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          PRE START CHECKS                        │
-- └──────────────────────────────────────────────────────────────────┘ 

CreateThread(function()
    if GetCurrentResourceName() ~= 'cd_bridge' then return end
    Wait(1000)

    if Cfg == nil then
        ERROR('configuration_error_found', 'Cfg.lua Syntax Error')
    end

    if BridgeLocalesTable[Cfg.Language] == nil then
        ERROR('configuration_error_found', 'Cfg.Language/locales.lua Typo : ['..Cfg.Language..']')
    end

    if GetCurrentResourceName() ~= 'cd_bridge' then
        ERROR('configuration_error_found', 'Resource Name Changed : '..resource_name..'')
    end

    if Cfg.Database ~= 'mysql-async' and Cfg.Database ~= 'ghmattimysql' and Cfg.Database ~= 'oxmysql' and Cfg.Database ~= 'none' then
        ERROR('configuration_error_found', 'Cfg.Database Error : ['..Cfg.Database..']')
    end

    if Cfg.Database == 'mysql-async' and not MySQL then
        MySQLErrorPrint()
    end

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
    if source then
        Citizen.Trace('^3PLAYER^0\n')
        Citizen.Trace(string.format('^6Source:^0 %s\n', source))
        Citizen.Trace(string.format('^6Identifier:^0 %s\n', GetIdentifier(source)))
        local admin = GetAdminPerms(source)
        Citizen.Trace(string.format('^6Admin Perms:^0 %s\n', type(admin) == 'string' and admin or json.encode(admin)))
        Citizen.Trace(string.format('^6Has Admin Perms:^0 %s\n', HasAdminPerms(source, admin)))
        Citizen.Trace('^6-----------------------^0\n')

        if Cfg.Framework == 'esx' or Cfg.Framework == 'qbcore' or Cfg.Framework == 'qbox' or Cfg.Framework == 'other' then
            Citizen.Trace('^3CHARACTER^0\n')
            local charInfo = {
                charName = GetCharacterName(source),
                jobName = GetJobName(source),
                jobLabel = GetJobLabel(source),
                jobGrade = GetJobGrade(source),
                jobGradeLabel = GetJobGradeLabel(source),
                onDuty = GetJobDuty(source),
                gangName = GetGangName(source),
                gangLabel = GetGangLabel(source),
                gangGrade = GetGangGrade(source)
            }
            Citizen.Trace(string.format('^6Character Name:^0 %s\n', charInfo.charName))
            Citizen.Trace(string.format('^6Job Name:^0 %s\n', charInfo.jobName))
            Citizen.Trace(string.format('^6Job Label:^0 %s\n', charInfo.jobLabel))
            Citizen.Trace(string.format('^6Job Grade:^0 %s\n', charInfo.jobGrade))
            Citizen.Trace(string.format('^6Job Grade Label:^0 %s\n',  charInfo.jobGradeLabel))
            Citizen.Trace(string.format('^6On Duty:^0 %s\n', charInfo.onDuty))
            Citizen.Trace(string.format('^6Gang Name:^0 %s\n', charInfo.gangName))
            Citizen.Trace(string.format('^6Gang Label:^0 %s\n', charInfo.gangLabel))
            Citizen.Trace(string.format('^6Gang Grade:^0 %s\n', charInfo.gangGrade))
            Citizen.Trace('^6-----------------------^0\n')
            TriggerClientEvent('cd_bridge:debug:charInfo', source, charInfo)
        end
        Notification(source, 2, 'DEBUG INFO: OPEN F8 CONSOLE TO VIEW^0')
    end

    Citizen.Trace('^3CONFIG^0\n')
    Citizen.Trace(string.format('^6Framework:^0 %s\n', Cfg.Framework))
    Citizen.Trace(string.format('^6Database:^0 %s\n', Cfg.Database))
    Citizen.Trace(string.format('^6BridgeDebugSQL:^0 %s\n', tostring(Cfg.BridgeDebugSQL)))
    Citizen.Trace(string.format('^6BridgeDebug:^0 %s\n', tostring(Cfg.BridgeDebug)))
    Citizen.Trace(string.format('^6DisableDuty:^0 %s\n', tostring(Cfg.DisableDuty)))
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
    Citizen.Trace(string.format('^6Gang:^0 %s\n', Cfg.Gang))
    Citizen.Trace(string.format('^6Duty:^0 %s\n', Cfg.Duty))
    Citizen.Trace('^6-----------------------^0\n')
end

if GetCurrentResourceName() == 'cd_bridge' then
    RegisterCommand('debugbridge', function(source)
        local isConsole = source == 0
        local isAdmin = HasAdminPerms(source, {'owner', 'superadmin', 'god', 'admin', 'moderator', 'mod'})
        local debugEnabled = Cfg.BridgeDebug

        if isConsole then
            DebugPrints(nil)
            return
        end

        if isAdmin or debugEnabled then
            DebugPrints(source)
            return
        end

        Citizen.Trace('You cannot use this command. You must have admin permissions, enable Cfg.BridgeDebug, or run it from the server console.\n')
    end, false)

    RegisterServerEvent('cd_bridge:debug:charInfo', function(message)
        ERROR('7903', 'Character info mismatch found between server and client.\n\n'..message)
    end)
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                 OTHER                            │
-- └──────────────────────────────────────────────────────────────────┘ 

function MySQLErrorPrint()
    Citizen.Trace([[
        ^5===============================================================
        ^3[cd_bridge] ^7mysql-async not enabled
        ^5===============================================================

        ^7To enable ^2mysql-async^7 support:

        ^6• Open the ^2fxmanifest.lua^6 file
        ^6• Go to the ^2shared_scripts^6 section
        ^6• Remove the ^4--^6 from the beginning of the ^2@mysql-async/lib/MySQL.lua^6 line

        ^3After editing the file:
        ^6• Type ^2refresh^6 in your server console
        ^6• Restart this resource for the changes to apply

        ^5===============================================================
    ]] .. '^0\n')
end

function CheckAllItemsExist(needed)
    if Config.Inventory == 'none' then
        return
    end

    local have = {}

    local items = GetItemList()
    if not items then
        ERROR('0010', 'Inventory items table not available: '..Config.Inventory)
        return
    end
    for name, _ in pairs(items) do
        if name then have[name] = true end
    end

    local missing = {}
    for _, item_name in pairs(needed) do
        if not have[item_name] then
            missing[#missing+1] = item_name
        end
    end

    if #missing > 0 then
        table.sort(missing)
        local string = ''
        for _, item in ipairs(missing) do
            string = string..item..'\n'
        end
        ERROR('configuration_error_found', 'Item(s) Not Found in Inventory Database/Table:\n\n'..string)
    end
end