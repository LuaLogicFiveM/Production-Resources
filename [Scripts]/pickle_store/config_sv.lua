ConfigSV = {}
ConfigSV.Webhooks = {
    ["onCoinProductPurchase"] = { 
        url = "https://discord.com/api/webhooks/1409396226948075602/fRsQMSdo4DO2vfVSpZYD3lJk1ISWH7iEvVvQgHMGSfQQMApWSTe6TTKwdZ9FbzTpBO6q",
        title = "Coin Product Purchase", 
        fields = {
            { name = "Product ID", value = "productId", inline = false },
            { name = "Product Label", value = "productLabel", inline = false },
            { name = "Price", value = "coins", inline = false },
            { name = "Player", value = "player", inline = false },
            { name = "Command(s) Executed:", value = "commands", inline = false },
        } 
    },
    ["onCoinAdded"] = { 
        url = "https://discord.com/api/webhooks/1409396226948075602/fRsQMSdo4DO2vfVSpZYD3lJk1ISWH7iEvVvQgHMGSfQQMApWSTe6TTKwdZ9FbzTpBO6q",
        title = "Coin(s) Added to Player",
        fields = {
            { name = "Player", value = "player", inline = false },
            { name = "Origin", value = "origin", inline = false },
            { name = "Amount", value = "playerCoins", inline = false },
        }
    },
    ["onCoinRemoved"] = { 
        url = "https://discord.com/api/webhooks/1409396226948075602/fRsQMSdo4DO2vfVSpZYD3lJk1ISWH7iEvVvQgHMGSfQQMApWSTe6TTKwdZ9FbzTpBO6q",
        title = "Coin(s) Removed from Player",
        fields = {
            { name = "Player", value = "player", inline = false },
            { name = "Origin", value = "origin", inline = false },
            { name = "Amount", value = "playerCoins", inline = false },
        }
    },
}
ConfigSV.WebhookHandler = function(webhookId, fields)
    local webhook = ConfigSV.Webhooks[webhookId]
    if webhook then
        if webhook.url == "DISCORD_WEBHOOK_URL" then return end
        local embed = {
            {
                ["title"] = webhook.title,
                ["color"] = 16711680,
                ["fields"] = {},
                ["footer"] = {
                    ["text"] = "In-Game Store - " .. os.date("%c"),
                },
            }
        }
        for i=1, #webhook.fields do
            local field = webhook.fields[i]
            table.insert(embed[1].fields, {
                ["name"] = field.name,
                ["value"] = fields[field.value],
                ["inline"] = field.inline or false
            })
        end
        PerformHttpRequest(webhook.url, function(err, text, headers) end, "POST", json.encode({embeds = embed}), {["Content-Type"] = "application/json"})
    end
end