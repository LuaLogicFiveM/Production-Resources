lib.locale()
local stevo_lib = exports['stevo_lib']:import()
local config = lib.require('config')
--local webhooks = lib.require('feedbackWebhooks')
local lastSubmitted = {}

local function sendWebhook(source, identifier, data)

    local sourceName = GetPlayerName(source)
    local message = (locale('webhook')):format(data[2], sourceName, identifier)
    --local webhook = webhooks[data[3]]
    local category = 'idk??!!'

    for i=1, #config.feedbackCategories do 
        local feedbackCategory = config.feedbackCategories[i]
        if feedbackCategory.value == data[3] then 
            category = feedbackCategory.label
        end
    end

    exports.fmsdk:Log("Feedback", "info", string.format('%s (%s)', data[1], category), {
        playerSource = source,
        playerName = sourceName,
        message = message
    })

    --[[local embed = {
        {
            ["title"] = string.format('%s (%s)', data[1], category),
            ["description"] = message,
            ["type"] = "rich",
            ["color"] = config.webhookColor,
            ["footer"] = {
                ["text"] = 'Leaned Out Roleplay - https://discord.gg/lorp',
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Feedback Forms", embeds = embed}), { ['Content-Type'] = 'application/json' })]]
end

lib.callback.register('lorp_feedback:submittedForm', function(source, feedback)
    if lastSubmitted[source] then
        if os.time() - lastSubmitted[source] < config.formCooldown then 
            local name = GetPlayerName(source)
            local identifier = stevo_lib.GetIdentifier(source)

            lib.print.info(('User: %s (%s) tried to exploit lorp_feedback'):format(name, identifier))

            if config.dropCheaters then 
                lastSubmitted[source] = nil
                DropPlayer(source, 'Trying to exploit lorp_feedback')
            end
        end
    end

    local identifier = stevo_lib.GetIdentifier(source)
    sendWebhook(source, identifier, feedback)

    lastSubmitted[source] = os.time()

    return true
end)

lib.callback.register('lorp_feedback:canSubmitForm', function(source)
    if not lastSubmitted[source] then
        return true
    end

    if os.time() - lastSubmitted[source] > config.formCooldown then 
        return true
    end

    return false
end)