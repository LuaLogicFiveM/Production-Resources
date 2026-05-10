---Prettier print function
---@param text string Text to print
---@param type 'error' | 'warning' | 'config' | 'info' | 'success' | 'debug'
---@return any
function DebugPrint(text, type)
    local types = {
        ["error"] = "^7[^1 ERROR ^7] ",
        ["warning"] = "^7[^3 WARNING ^7] ",
        ["config"] = "^7[^3 CONFIG WARNING ^7] ",
        ["info"] = "^7[^5 INFO ^7] ",
        ["success"] = "^7[^2 SUCCESS ^7] ",
        ["debug"] = "^7[^6 DEBUG ^7] ",
    }
    return print("^7[^5 GRP BRIDGE ^7] " .. (types[string.lower(type or "info")]) .. text)
end


