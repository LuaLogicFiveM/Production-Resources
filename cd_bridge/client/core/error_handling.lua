-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          ERROR HANDLING                          │
-- └──────────────────────────────────────────────────────────────────┘ 

local resource_name = string.format('[%s - v%s - %s]', GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), 'client')
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

if GetCurrentResourceName() == 'cd_bridge' then
    RegisterNetEvent('cd_bridge:debug:charInfo', function(serverCharInfo)
        local clientCharInfo = {
            charName = GetCharacterName(),
            jobName = GetJobName(),
            jobLabel =  GetJobLabel(),
            jobGrade = GetJobGrade(),
            jobGradeLabel = GetJobGradeLabel(),
            onDuty = GetJobDuty(),
            gangName = GetGangName(),
            gangLabel = GetGangLabel(),
            gangGrade = GetGangGrade()
        }

        local mismatchFound = {}
        for k, serverVal in pairs(serverCharInfo) do
            local clientVal = clientCharInfo[k]
            if serverVal ~= clientVal then
                mismatchFound[#mismatchFound + 1] = {
                    info   = k,
                    server = serverVal,
                    client = clientVal
                }
            end
        end
        if #mismatchFound > 0 then
            local message = ''
            for _, m in pairs(mismatchFound) do
                message = message .. string.format('^1%s: server=[%s] | client=[%s]\n', m.info, tostring(m.server), tostring(m.client))
            end
            message = message:sub(1, -2)
            ERROR('7903', 'Character info mismatch found between server and client.\n\n'..message)
            TriggerServerEvent('cd_bridge:debug:charInfo', message)
        end
    end)
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