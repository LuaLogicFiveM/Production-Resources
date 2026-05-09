local _debugMode = false
lib.locale()

function Trace(...)
    if not _debugMode then
        return
    end

    local logLine = ""
    local logString = { ... }

    if IsDuplicityVersion() then
        logLine = tostring(os.date('%Y-%m-%d %H:%M:%S', os.time()))
    end

    logLine = logLine .. " [" .. (GetCurrentResourceName() or "LOG") .. "] "

    for i = 1, #logString do
        logLine = logLine .. tostring(logString[i]) .. " "
    end

    print(logLine)
end

---@param t table
---@return number
function GetKeyCount(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end