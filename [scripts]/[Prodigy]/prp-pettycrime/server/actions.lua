local availableActions = {} ---@type table<string, boolean>

--- Add a unique unrepeatable action
---@param actionIndex any
function CreateUnrepeatableAction(actionIndex)
    availableActions[actionIndex] = true
end

--- Check if an unrepeatable action exists
---@param actionIndex string
---@return boolean
function IsUnrepeatableAction(actionIndex)
    return availableActions[actionIndex]
end

--- Use a unique unrepeatable action
function PerformUnrepeatableAction(actionIndex)
    if not IsUnrepeatableAction(actionIndex) then
        return
    end

    availableActions[actionIndex] = nil
    return true
end