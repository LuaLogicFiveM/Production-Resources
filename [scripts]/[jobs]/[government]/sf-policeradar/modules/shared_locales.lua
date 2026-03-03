Locales = {}

function _L(name, ...)
    return string.format(Locales[Language][name], ...)
end

function _LOCALE(name, ...)
    return string.format(Locales[Language][name], ...)
end