-- Table debug print.
function TBL(t, src)
    if GetResourceState('cd_devtools') == 'started' then
        TriggerClientEvent('table', src or -1, t)
    else
        print(json.encode(t, { indent = true }))
    end
end

-- Notification wrapper.
function Notif(source, action, locale_key, ...)
    if not TypeCheck(source, 'number', '3000', 'source missing from Notif functiion, 1st arg. Locale Key: '..(locale_key or 'nil')) then
        return
    end

    if not TypeCheck(action, 'number', '3001', 'action missing from Notif functiion, 1st arg. Locale Key: '..(locale_key or 'nil')) then
        return
    end

    if action < 1 or action > 3 then
        return ERROR('3002', 'action not valid in Notif function, 1st arg: '..action..'. Locale Key: '..(locale_key or 'nil'))
    end

    if not TypeCheck(locale_key, 'string', '3002', 'locale_key missing from Notif functiion, 2nd arg. Locale Key: '..(locale_key or 'nil')) then
        return
    end

    local lang = Config.Language or 'EN'

    local function get(tbl)
        if not tbl then return nil end
        return (tbl[lang] and tbl[lang][locale_key]) or (tbl.EN and tbl.EN[locale_key])
    end

    local template = get(LocalesTable) or get(Locales) or get(BridgeLocalesTable)
    if not template then
        return ERROR('3003', 'locale not found in locales.lua: '..(locale_key or 'nil'))
    end

    local message = template

    if select('#', ...) > 0 then
        local ok, formatted = pcall(string.format, template, ...)
        if not ok then
            return ERROR('3004', 'Format failed for key: ' .. (locale_key or 'nil'))
        end
        message = formatted
    end

    local ok, err = pcall(Notification, source, action, message)
    if not ok then
        return ERROR('3005', 'Notification failed: ' .. tostring(err))
    end
end