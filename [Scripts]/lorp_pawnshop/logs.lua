Logs = {}

-- What logging service do you want to use?
-- Available options: 'fivemanage', 'fivemerr', 'discord' & 'none'
-- It is highly recommended to use a proper logging service such as Fivemanage or Fivemerr
Logs.Service = 'discord'

-- Do you want to include screenshots with your logs?
-- This is only applicable to Fivemanage and Fivemerr
Logs.Screenshots = false

-- You can enable (true) or disable (false) specific player events to log here
Logs.Events = {
    -- table_received is when a table is issued to player
    item_sold = true,
}

-- If Logs.Service = 'discord', you can customize the webhook data here
-- If not using Discord, this section can be ignored
Logs.Discord = {
    -- The name of the webhook
    name = 'Pawn Shop Logs',
    -- The webhook link
    link = 'https://discord.com/api/webhooks/1415751495592448040/0SpayP2YfnCec4AxVgrw7drf9qHIDs00nASU0ddQ68kO3NNBC7KMDr64h4CD0PiSziEZ',
    -- The webhook profile image
    image = 'https://i.imgur.com/ILTkWBh.png',
    -- The webhook footer image
    footer = 'https://i.imgur.com/ILTkWBh.png'
}