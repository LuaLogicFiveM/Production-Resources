local ox_inventory = exports.ox_inventory
local fmsdk = exports.fmsdk
local types = {}
--[[local webhooks = {
    ['drop'] = '',
    ['pickup'] = '',
    ['give'] = '',
    ['stash'] = '',
    ['glovebox'] = '',
    ['gloveboxplayer'] = '',
    ['trunk'] = '',
    ['playertrunk'] = '',
}

local function sendWebhook(webhook, data)
    if webhooks[webhook] == nil then print('^1[Inventory Logs] ^0Webhook ' .. webhook .. ' does not exist.') return end
    PerformHttpRequest(webhooks[webhook], function(err, text, headers) end, 'POST', json.encode({ embeds = data }), { ['Content-Type'] = 'application/json' })
end]]

local hooks = {
    ['drop'] = {
        from = 'player',
        to = 'drop',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Player to Ground", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
            })
            --[[sendWebhook('drop', {
                {
                    title = 'Drop',
                    description = ('**Player Name:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n**Item Name:** %s\n**Item Count:** x%s\n**Metadata:** %s\n**Location:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['inventory_to_glovebox'] = {
        from = 'player',
        to = 'glovebox',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Player to Glovebox", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
                inventory = payload.toInventory,
            })
            --[[sendWebhook('glovebox', {
                {
                    title = 'Glovebox Transfer',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Stored in Glovebox:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Glovebox ID:** %s\n**Player Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        payload.toInventory, 
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['glovebox_to_inventory'] = {
        from = 'glovebox',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Glovebox to Player", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
                inventory = payload.fromInventory,
            })
            --[[sendWebhook('gloveboxplayer', {
                {
                    title = 'Glovebox Retrieval',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Retrieved from Glovebox:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Glovebox ID:** %s\n**Player Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        payload.fromInventory, 
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['trunk_to_inventory'] = {
        from = 'trunk',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Trunk to Player", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
                inventory = payload.fromInventory,
            })
            --[[sendWebhook('trunk', {
                {
                    title = 'Trunk Retrieval',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Retrieved from Trunk:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Trunk ID:** %s\n**Player Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        payload.fromInventory,  -- assuming `fromInventory` refers to the glovebox ID
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['inventory_to_trunk'] = {
        from = 'player',
        to = 'trunk',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Player to Trunk", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
                inventory = payload.toInventory,
            })
            --[[sendWebhook('playertrunk', {
                {
                    title = 'Trunk Transfer',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Storaged in Trunk:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Trunk ID:** %s\n**Player Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        payload.toInventory,  -- assuming `fromInventory` refers to the glovebox ID
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['pickup'] = {
        from = 'drop',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Ground to Player", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
            })
            --[[sendWebhook('pickup', {
                {
                    title = 'Pickup',
                    description = ('**Player Name:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n**Item Name:** %s\n**Item Count:** x%s\n**Metadata:** %s\n**Location:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['give'] = {
        from = 'player',
        to = 'player',
        callback = function(payload)
            if payload.fromInventory == payload.source then return end
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            local targetSource = payload.fromInventory
            local targetName = GetPlayerName(targetSource)
            local targetIdentifier = GetPlayerIdentifiers(targetSource)[1]
            local targetCoords = GetEntityCoords(GetPlayerPed(targetSource))
            fmsdk:Log("Inventory", "info", "Player to Player", {
                sourceId = payload.source,
                sourceName = playerName,
                sourceIdentifier = playerIdentifier,
                sourceCoords = json.encode(playerCoords),
                targetId = targetSource,
                targetName = targetName,
                targetIdentifier = targetIdentifier,
                targetCoords = json.encode(targetCoords),
                item = payload.fromSlot.name,
                count = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
            })
            --[[sendWebhook('give', {
                {
                    title = 'Give',
                    description = ('**Giving Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Receiving Player:** %s\n**Target Identifier:** %s\n**Target Source ID:** %s\n\n**Item Given:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Source Coordinates:** %s, %s, %s\n**Target Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        targetName,
                        targetIdentifier,
                        targetSource,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        playerCoords.x, playerCoords.y, playerCoords.z,
                        targetCoords.x, targetCoords.y, targetCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['stash_pick'] = {
        from = 'player',
        to = 'stash',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Player to Stash", {
                playerName = playerName,
                playerIdentifier = playerIdentifier,
                playerSource = payload.source,
                itemTaken = payload.fromSlot.name,
                countTaken = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
                stash = payload.fromInventory,
                coords = json.encode(playerCoords)
            })
            --[[sendWebhook('stash', {
                {
                    title = 'player -> stash',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Added to Stash:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Stash Location:** %s\n**Player Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        payload.toInventory,
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
    ['stash'] = {
        from = 'stash',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            fmsdk:Log("Inventory", "info", "Stash to Player", {
                playerName = playerName,
                playerIdentifier = playerIdentifier,
                playerSource = payload.source,
                itemTaken = payload.fromSlot.name,
                countTaken = payload.fromSlot.count,
                itemMeta = json.encode(payload.fromSlot.metadata),
                stash = payload.fromInventory,
                coords = json.encode(playerCoords)
            })

            --[[sendWebhook('stash', {
                {
                    title = 'stash -> player',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Taken from Stash:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Stash Location:** %s\n**Player Coordinates:** %s, %s, %s'):format(
                        playerName,
                        playerIdentifier,
                        payload.source,
                        payload.fromSlot.name,
                        payload.fromSlot.count,
                        json.encode(payload.fromSlot.metadata),
                        payload.fromInventory,
                        playerCoords.x, playerCoords.y, playerCoords.z
                    ),
                    color = 0x00ff00
                }
            })]]
        end
    },
}    


local function addTypeHook(name, from, to, callback)
    types[name] = {
        from = from,
        to = to,
        callback = callback
    }
end

for name, data in pairs(hooks) do
    addTypeHook(name, data.from, data.to, data.callback)
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if GetResourceState('ox_inventory') ~= 'started' then return end

    ox_inventory:registerHook('swapItems', function(payload)
        for name, data in pairs(types) do
            if payload.fromType == data.from and payload.toType == data.to then
                data.callback(payload)
            end
        end
    end, {print = false})
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if GetResourceState('ox_inventory') ~= 'started' then return end
    ox_inventory:removeHooks()
end)
