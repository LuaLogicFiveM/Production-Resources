--Theese are example code snippets that can be used in our chat system they are not part of the chat system itself you should add them if you like!

--[Allow More Than One Job To Write In Channel]
--1) dont activate setjob only can write in chat from the editor!
--2) in server/editable.lua add the following logic to canUseThisChat function

local allowedToUseDarkChat =
{
    criminaljob1 = true,
    criminaljob2 = true,
    criminaljob40 = true
}


function canUseThisChat(playerId,channel)
    if channel == 'DarkChat' then
        if not  allowedToUseDarkChat[Framework.getJob(playerId).name]  then
            return false, 'You are not a police officer!'
        else
            return true
        end
    end
    return true
end


--[Allow More Than One Job To Read In Channel]
--1) dont activate setjob only can read in chat from the editor!
--2) in client/editable.lua add the following logic

local allowedToReadDarkChat =
{
    criminaljob1 = true,
    criminaljob2 = true,
    criminaljob40 = true
}

function canReadThisChat(channel)
    if channel == 'DarkChat' then
        local playerData = FrameworkClient.getPlayerData()
        if not allowedToReadDarkChat[playerData.job.name] then
            return false
        else
            return true
        end
    end
    return true
end

--[Log All Chat Messages To Discord]
--1) in server/editable.lua add the following logic to onChatMessage function

function onChatMessage(playerId, channel, message)
    local jobName = Framework.getJob(playerId).name or 'Unknown Job'
    local playerName = Framework.getName(playerId) or 'Unknown Player'
    
    
    local discordWebhookUrl = "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL" -- Replace with your actual webhook URL
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local logMessage = string.format("[%s] [%s] [%s]: %s", timestamp, channel, playerName, message)

    PerformHttpRequest(discordWebhookUrl, function(err, text, headers) 
        if err ~= 200 then
            print("Failed to send message to Discord: " .. tostring(err))
        end
    end, "POST", json.encode({username = GetCurrentResourceName(), content = logMessage}), {["Content-Type"] = "application/json"})
end


--[Allot To Wite In Channel If Player Has Item]
--1) in server/editable.lua add the following logic to canUseThisChat function
function canUseThisChat(playerId, channel)
    if channel == 'itemchat' then
        if not Framework.doIHaveItem(playerId, 'itemname') then
            return false, 'You do not have the required item to write in this chat!'
        end
    end
    return true
end

--Basically this integration allows players to buy a VIP Name tag in DoItDigital_chat system with Pickle In-Game Store currency 
--server/namePerksEditable.lua replace the function with this one
--thanks RebornHxnTeR for the integration

RegisterNetEvent("did_chat:unlockPerks")
AddEventHandler("did_chat:unlockPerks", function()
    local src = source
    local Player = Framework.getPlayer(src)
    if not Player then return end

    local identifier = GetPlayerIdentifierByType(src, 'license')
    local hasPerks = hasPlayerUnlockedPerks(src)

    if not hasPerks then
        local coins = exports.pickle_store:GetCoins(src)
        if coins >= namePerksPrice then
            exports.pickle_store:RemoveCoins(src, namePerksPrice)

            playersWithPerks[identifier] = defaultNamePerk
            local jsonData = json.encode(playersWithPerks, { indent = true })
            SaveResourceFile(GetCurrentResourceName(), "configs/playersWithPerks.json", jsonData, -1)

            TriggerClientEvent("did_chat:unlockPerks", src, defaultNamePerk)
            TriggerClientEvent("ox_lib:notify", src, {
                type = "success",
                description = "Perks unlocked successfully!"
            })
        else
            TriggerClientEvent("ox_lib:notify", src, {
                type = "error",
                description = "You don't have enough coins!"
            })
        end
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "info",
            description = "You already have this perk!"
        })
    end
end)




--1) dont activate setjob only can write in chat from the editor!
--2) in server/editable.lua add the following logic to canUseThisChat function
--allow specific jobs and job grades to write in a specific chat channel
local jobsAndGradesAllowedToWriteInChannel = {
    ['customChat'] = {
        ['police'] = { grades = { 0, 1, 2, 3, 4, 5 } }, -- Police can write in customChat
        ['ambulance'] = { grades = { 0, 1 } }, -- Ambulance can write in customChat
    },
}



function canUseThisChat(playerId,channel)
    if jobsAndGradesAllowedToWriteInChannel[channel] then
        local playerData = Framework.getPlayerData(playerId)
        local jobName = playerData.job.name
        local jobGrade = playerData.job.grade

        if jobsAndGradesAllowedToWriteInChannel[channel][jobName] then
            local allowedGrades = jobsAndGradesAllowedToWriteInChannel[channel][jobName].grades
            for _, grade in ipairs(allowedGrades) do
                if jobGrade == grade then
                    return true
                end
            end
            return false, 'You do not have permission to write in this channel!'
        end
    end
    return true
end
