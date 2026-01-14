
--this editable file contains some useful functions for ESX and QBCore combatibility
--if you are using a custom framework, you can add your own logic here
--dont hesitate to ask for help if you need it
function hasAcess(src)
    if src == 0 then
        return false
    end
    if DoesPlayerExist(src) then 
        local identifier = GetPlayerIdentifierByType(src, 'steam')
        if chatEditors[identifier] then
            return true
        end
        identifier = GetPlayerIdentifierByType(src, 'discord')
        if chatEditors[identifier] then
            return true
        end
        identifier = GetPlayerIdentifierByType(src, 'license')
        if chatEditors[identifier] then
            return true
        end
    end
    return false
end
function Framework.getPlayer(source)
    if FrameWorkInUse == 'ESX' then
        return Framework.ESX.GetPlayerFromId(source)
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        return Framework.QBCore.Functions.GetPlayer(source)
    else
        --Your code here for standalone mode or custom framework
        return nil
    end
end
function Framework.getName(source)
    local player = Framework.getPlayer(source)
    if FrameWorkInUse == 'ESX' then
        return player and player.getName() or GetPlayerName(source)
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        return player and player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname or GetPlayerName(source)
    else
        return GetPlayerName(source)
    end
end
function Framework.getJob(source)
    local player = Framework.getPlayer(source)
    if FrameWorkInUse == 'ESX' then
        return player and player.getJob() or { name = 'unemployed', grade = 0 }
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        return player and player.PlayerData.job or { name = 'unemployed', grade = {} }
    else
        --Your code here for standalone mode or custom framework
        return { name = 'unknown', grade = 0 }
    end
end
function Framework.isAdmin(source)
    local player = Framework.getPlayer(source)

    local isAdmin = false

    if FrameWorkInUse == 'ESX' then
        isAdmin = player and player.getGroup() ~= 'user'
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        isAdmin = (player and player.PlayerData.permission and player.PlayerData.permission ~= 'user') or Framework.QBCore.Functions.HasPermission(source, 'admin')
    end
    local toReturn = isAdmin or IsPlayerAceAllowed(source, "admin") or IsPlayerAceAllowed(source, "group.admin") or IsPlayerAceAllowed(source, 'command')
    return toReturn
end
function Framework.hasMoney(source, amount)
    local player = Framework.getPlayer(source)
    if FrameWorkInUse == 'ESX' then
        return player and player.getMoney() >= amount
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        return player and player.Functions.GetMoney('cash') >= amount
    else
        --Your code here for standalone mode or custom framework
        return false  
    end
end
function Framework.removeMoney(source, amount)
    local player = Framework.getPlayer(source)
    if FrameWorkInUse == 'ESX' then
        if player then
            player.removeMoney(amount)
        end
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        if player then
            player.Functions.RemoveMoney('cash', amount)
        end
    else
        --Your code here for standalone mode or custom framework
    end
end

function Framework.doIHaveItem(source, itemName)
    local player = Framework.getPlayer(source)
    if FrameWorkInUse == 'ESX' then
        return player and player.getInventoryItem(itemName) and player.getInventoryItem(itemName).count > 0
    elseif FrameWorkInUse == 'QBCore' then -- same for QBox
        return player and player.Functions.GetItemByName(itemName) ~= nil
    else
        --Your code here for standalone mode or custom framework
        return false
    end
end

function onChatMessage(playerId,channel,message)
	--you can add your own logic here, for example discord logs etc you can see codeSnippets.lua for examples

end
function canUseThisChat(playerId,channel)
    --you can add your own logic here or see codeSnippets.lua for examples
    --this function is called when a player sends a message
    --you can use this to check if the player has access to the chat chanel
    --for example, you can check if the player is in a specific job or group
    --or if the player has a specific item
    --or if the player is in a specific discord role
    --or if the player is criminal etc.....
    --EXAMPLE:
    -- if channel == 'pd' then
    --  if Framework.getJob(playerId).name ~= 'police' then
    --     return false, 'You are not a police officer!'
    --  end
    -- end
    return true
end



function filterBadWords(message)
    for _, word in ipairs(badWords) do
        message = message:gsub("(%w+)", function(w)
            if w:lower() == word:lower() then
                return string.rep("*", #w)
            else
                return w
            end
        end)
    end
    return message
end


extraAnnounces = {
    -- Uncomment the following lines to enable more auto announcements (you can already set one from chatEditor)
    --[[
    ["welcome"] = {
        msg = "Welcome to the server! Enjoy your stay and have fun!",
        interval = 600000 -- 10 minutes
    },
    ["rules"] = {
        msg = "Please remember to follow the server rules and respect other players.",
        interval = 300000 -- 5 minutes
    },
    ["events"] = {
        msg = "Check out our events page for upcoming events and activities!",
        interval = 900000 -- 15 minutes
    }]]
}

-- Start a thread for each announcement
for key, announce in pairs(extraAnnounces) do
    Citizen.CreateThread(function()
        while true do
            Wait(announce.interval)
            TriggerClientEvent('chat:addMessage', -1, {
                template = [[
                    <div class="chat-message autoAnnounce">
                        <span class="chat-icon"><i class="fa fa-bullhorn" aria-hidden="true"></i></span>
                        <div class="chat-text"><span class="chat-category">{0}</span> {1}</div>
                    </div>
                ]],
                args = {"AutoMessage", announce.msg}
            })
        end
    end)
end