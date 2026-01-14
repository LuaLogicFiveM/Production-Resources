if Config.EnableWebhooks then
    local webHook = 'https://discord.com/api/webhooks/1236802856263352341/aSA6VWRY9aMpH4rNnf10wbiGEJMzeym5Et9pNbPS2gsy2fldV_kY0vKRRjo0XlOTs6rX' -- WEBHOOK URL , insert yours here
    local Colors = { -- https://www.spycolor.com/
        ['default']    = 14423100,
        ['blue']       = 255,
        ['red']        = 16711680,
        ['green']      = 65280,
        ['white']      = 16777215,
        ['black']      = 0,
        ['orange']     = 16744192,
        ['yellow']     = 16776960,
        ['pink']       = 16761035,
        ["lightgreen"] = 65309,
        -- ADD MORE HERE
    }

    AddEventHandler('tuff-wheelstancer:webhook', function(title, color, message)
        local defaultImageURL =
        "https://www.freepnglogos.com/uploads/discord-logo-png/discord-logo-logodownload-download-logotipos-1.png"
        local headerImageURL  = Config.Webhooks.HeaderImageURL

        -- Check if HeaderImageURL is not defined, empty, or contains uppercase letters, numbers, special characters, or underscores
        if not headerImageURL or headerImageURL == "" or string.match(headerImageURL, "[%u%d%W_]") then
            headerImageURL = defaultImageURL
        end

        local embedData = {
            {
                ['title']       = Config.Webhooks.WebhookTitle .. title,
                ['color']       = Colors[color] or Colors['default'],
                ['footer']      = { ['text'] = os.date('%c'), },
                ['description'] = message,
                ['author']      = { ['name'] = Config.Webhooks.LogHeader, ['icon_url'] = headerImageURL, },
            }
        }

        PerformHttpRequest(webHook, function() end, 'POST',
            json.encode({ username = Config.Webhooks.LogHeader, embeds = embedData }),
            { ['Content-Type'] = 'application/json' })

        Citizen.Wait(100)

        if Config.WebhooksOptions.TagEveryone then
            PerformHttpRequest(webHook, function() end, 'POST',
                json.encode({ username = Config.Webhooks.LogHeader, content = '@everyone' }),
                { ['Content-Type'] = 'application/json' })
        end
    end)
end
