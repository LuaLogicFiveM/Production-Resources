if Config.JailScript ~= "JAIL_SCRIPT" then
    return
end

---@param identifier string
---@param time integer The jail time in seconds
---@param reason string
---@param officerSource number
---@return boolean success
function JailPlayer(identifier, time, reason, officerSource)
    local minutes = math.floor(time / 60)
    local source = GetSourceFromIdentifier(identifier)

    if not source then
        return false
    end

    exports.tk_jail:jail(source, minutes, 'jail', math.random(1, 15), true, reason)

    return true
end

---@param identifier string
---@return boolean success
function UnjailPlayer(identifier)
    local source = GetSourceFromIdentifier(identifier)

    if not source then
        return false
    end

    exports.tk_jail:unjail(source, true)

    return true
end

---@param identifier string
---@return integer remainingTime seconds
function GetRemainingPrisonSentence(identifier)
    local source = GetSourceFromIdentifier(identifier)

    if not source then
        return 0
    end

    return exports.tk_jail:getSentence(source) or 0
end
