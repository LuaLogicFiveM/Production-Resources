if Config.Framework ~= "ESX" then return end

local ox_inventory = exports.ox_inventory

---@param source integer
---@return boolean
function IsAdmin(source)
    return IsPlayerAceAllowed(tostring(source), "command")
end

---@param source number
---@param item string
---@param amount? number
---@return boolean
function HasItem(source, item, amount)
    if not amount then amount = 1 end

    if ox_inventory:Search(source, 'count', item) >= amount then
        return true
    end
    
    return false
end

---@param source integer
---@param item string
---@param amount? integer
---@return boolean
function GiveItem(source, item, amount)
    if not amount then amount = 1 end

    local success, resp = ox_inventory:AddItem(source, item, amount)
    if not success then
        Debug("Unable to add item to inventory (" .. resp .. ")", DebugTypes.Error)
    end

    return success
end

---@param source integer
---@param item string
---@param amount? integer
---@return boolean
function RemoveItem(source, item, amount)
    if not amount then amount = 1 end

    local success = ox_inventory:RemoveItem(source, item, amount)
    if not success then
        Debug("Unable to remove item from inventory (" .. source .. ")", DebugTypes.Error)
    end

    return success
end

---@param item string
---@param itemUse function
function CreateUsableItem(item, itemUse)
    ESX.RegisterUsableItem(item, itemUse)
end

---@param source integer
---@return table
function GetPlayer(source)
    return ESX.GetPlayerFromId(source)
end

---@param source integer
---@param amount number
---@param account "cash" | "bank" | "money"
---@param reason string
function AddMoney(source, amount, account, reason)
    local player = GetPlayer(source)
    if not player then return end
    if account == "cash" then return GiveItem(source, "money", math.ceil(amount)) end
    player.addAccountMoney(account, math.ceil(amount), reason)
end

---@return integer
function GetPoliceCount()
    local gsp = ESX.GetExtendedPlayers('job', 'sheriff')
    local sahp = ESX.GetExtendedPlayers('job', 'sahp')
    return (#gsp + #sahp)
end

---@return integer[]
function GetPolice()
    --local xPlayers = ESX.GetExtendedPlayers('job', 'sheriff')
    local formattedPlayers = {} -- Have to convert table to this format, for framework compatibility

    local players = ESX.GetPlayers()

    for _, playerId in pairs(players) do
        local player = ESX.GetPlayerFromId(playerId)
        if player then
            for i = 1, #Config.DispatchJobs do
                if player.job.name == Config.DispatchJobs[i] then
                    formattedPlayers[_] = playerId
                end
            end
        end
    end

    --[[local xPlayers = ESX.GetExtendedPlayers('job', 'sheriff')
    local formattedPlayers = {} -- Have to convert table to this format, for framework compatibility

    for _, xPlayer in pairs(xPlayers) do
        formattedPlayers[_] = xPlayer.source
    end]]

    return formattedPlayers
end

---@param source integer
---@return boolean
function CanReset(source)
    local player = ESX.GetPlayerFromId(source)
    if not player then return false end

    local jobId = player.job.name
    local gradeId = player.job.grade
    local playerGroup = player.getGroup()

    if Config.ResetAccess.Jobs[jobId] and Config.ResetAccess.Jobs[jobId] <= gradeId then
        return true
    end

    for i = 1, #Config.ResetAccess.Groups do
        if playerGroup == Config.ResetAccess.Groups[i] then
            return true
        end
    end

    return false
end

---@param source integer
---@param username string
---@param title string
---@param message string
---@param colour? integer
function SendLog(source, username, title, message, colour)
    local player = ESX.GetPlayerFromId(source)
    if not player then return false end
    SendWebhook(source, username, player.cid, title, message, colour)
end