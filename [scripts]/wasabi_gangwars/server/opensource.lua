-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
Config.DiscordWebhook = ''

function IsStaff(src)
    for i = 1, #Config.StaffGroups do
        if wsb.hasPermission(src, Config.StaffGroups[i]) then
            return true
        end
    end

    if IsPlayerAceAllowed(src, 'gangwars.staff') then return true end

    return false
end


--[[
    CUSTOM GANG MEMBER CHECK FUNCTION
    This function is called before adding a member to a gang.
    Return true to allow, false to block with optional error message.
    
    Parameters:
        src (number): Player server ID
        identifier (string): Player identifier
        gangId (number): Gang ID they're joining
    
    Return:
        success (boolean): true = allow, false = block
        message (string, optional): Error message if blocking
    
    Examples:
        -- Block police (ESX):
        if xPlayer.job.name == 'police' then return false, 'Police cannot join gangs!' end
        
        -- Block police (QBCore):
        if Player.PlayerData.job.name == 'police' then return false, 'Police cannot join gangs!' end
        
        -- Block multiple jobs:
        local blockedJobs = {'police', 'ambulance'}
        for _, job in pairs(blockedJobs) do
            if xPlayer.job.name == job then return false, 'Cannot join gangs!' end
        end
--]]
---@param src any
---@param identifier any
---@param gangId any
---@return boolean
function CanPlayerJoinGang(src, identifier, gangId)
    return true
end