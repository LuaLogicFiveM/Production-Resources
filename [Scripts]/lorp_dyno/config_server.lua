
-- Discord webhook options
Config.webhook = {
    enabled = true, -- Whether to send the dyno sheets to the discord webhook

    -- To get the Discord webhook link, right click on a channel > Edit channel > Integrations > Webhooks > View webhooks > New webhook
    url = 'https://discord.com/api/webhooks/1234977058434711703/x61H-kvUezQ6UPqju2bE-87zW_EEPXlQm3MuMYFzR6NA--jhmcetFtBJIgdG56xoNPBC',

    -- Here you can add webhooks for specific dynos. Based on the dyno key/index name (same as in config.lua)
    dynoSpecific = {
        --['bennys'] = 'DYNO_SPECIFIC_WEBHOOK_URL_HERE', -- remove this line if you don't want to use a dyno specific webhooks
    },

    -- Replace this with the name of your server or a title you want on your dyno sheets
    title = 'Dyno',

    -- Whether to include certain parts of the users info in the webhook messages
    includeUserName = true,
    includeSteamId = false,

    color = 16723456,
}
