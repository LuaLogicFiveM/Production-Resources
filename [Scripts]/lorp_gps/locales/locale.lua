Locales = {}

function _(str, ...)
    if Locales[Config.Locale] and Locales[Config.Locale][str] then
        local text = Locales[Config.Locale][str]
        if ... then
            return string.format(text, ...)
        else
            return text
        end
    else
        return 'Translation [' .. str .. '] not found'
    end
end
