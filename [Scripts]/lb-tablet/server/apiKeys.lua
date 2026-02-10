-- Set your API keys for uploading media here.
-- Please note that the API key needs to match the correct upload method defined in Config.UploadMethod.
-- The default upload method is Fivemanage
-- You can get your API keys from https://fivemanage.com/
-- Use code LBPHONE10 for 10% off on Fivemanage
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
API_KEYS = {
    Video = "z660Oh8VwDEuXfNcOgmOsJYsLBcetJEO",
    Image = "z660Oh8VwDEuXfNcOgmOsJYsLBcetJEO",
    Audio = "z660Oh8VwDEuXfNcOgmOsJYsLBcetJEO",
}

-- Discord webhook or API key for server logs
-- We recommend https://fivemanage.com/ for logs. Use code "LBLOGS" for 20% off the Logs Pro plan.
LOG_WEBHOOKS = {
    Default = "https://ptb.discord.com/api/webhooks/1236802856263352341/aSA6VWRY9aMpH4rNnf10wbiGEJMzeym5Et9pNbPS2gsy2fldV_kY0vKRRjo0XlOTs6rX", -- set to false to disable
    Police = "https://ptb.discord.com/api/webhooks/1236802856263352341/aSA6VWRY9aMpH4rNnf10wbiGEJMzeym5Et9pNbPS2gsy2fldV_kY0vKRRjo0XlOTs6rX",
    Ambulance = "https://ptb.discord.com/api/webhooks/1236802856263352341/aSA6VWRY9aMpH4rNnf10wbiGEJMzeym5Et9pNbPS2gsy2fldV_kY0vKRRjo0XlOTs6rX",
    Dispatch = "https://ptb.discord.com/api/webhooks/1236802856263352341/aSA6VWRY9aMpH4rNnf10wbiGEJMzeym5Et9pNbPS2gsy2fldV_kY0vKRRjo0XlOTs6rX"
}

DISCORD_TOKEN = 'MTA4NDU2NzQxMjE5MzYyODMzMQ.G_rt_-.20Gp2-fNI9GhmEz9Gn5vhK0kveERTHcPDWDxaQ' -- you can set a discord bot token here to get the players discord avatar for logs

-- Here you can set your credentials for Config.DynamicWebRTC
-- You can get your credentials from https://dash.cloudflare.com/?to=/:account/realtime/turn/overview
WEBRTC = {
    TokenID = nil,
    APIToken = nil,
}
