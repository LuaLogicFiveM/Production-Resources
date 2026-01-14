--[[
███╗   ██╗ █████╗ ███████╗███████╗    ██████╗ ██████╗  █████╗  ██████╗ ███████╗████████╗██████╗ ██╗██████╗ ███████╗
████╗  ██║██╔══██╗██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝
██╔██╗ ██║███████║███████╗███████╗    ██║  ██║██████╔╝███████║██║  ███╗███████╗   ██║   ██████╔╝██║██████╔╝███████╗
██║╚██╗██║██╔══██║╚════██║╚════██║    ██║  ██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║   ██╔══██╗██║██╔═══╝ ╚════██║
██║ ╚████║██║  ██║███████║███████║    ██████╔╝██║  ██║██║  ██║╚██████╔╝███████║   ██║   ██║  ██║██║██║     ███████║
╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝

https://discord.gg/nass
]]
local webhook = "https://discord.com/api/webhooks/1370914424898195546/MPTd7bc5YmvW57bF2HGV_4lBgxuv9FMyl-X7f336x8KlyJP7B51UWcqsP9RFSH4H_OXs"
--add_ace group.admin command.dragstrips allow
RegisterCommand("dragstrips", function(source)
    TriggerClientEvent("nass_dragstrips:openDragstripMenu", source)
end, true)

function sendToDiscord(data)
    local embed = {
        {
            title = ""..data.strip.name .. " " .. namedDistance[data.strip.distance],
            fields = {},
            thumbnail = {
                url = "https://cdn.discordapp.com/attachments/224653951335792640/1218377071512911903/logopng.png"
            },
            color = data.color
        }
    }
    table.insert(embed[1].fields, {
        name = "**Name**",
        value = "" .. data.first.name .. "",
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Name**",
            value = "" .. data.second.name .. "",
            inline = true
        })
    end

    -- Spacer
    table.insert(embed[1].fields, {
        name = "",
        value = "",
        inline = false
    })
    -- Spacer

    table.insert(embed[1].fields, {
        name = "**Time**",
        value = "" .. data.first.time .. "",
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Time**",
            value = "" .. data.second.time .. "",
            inline = true
        })
    end

    -- Spacer
    table.insert(embed[1].fields, {
        name = "",
        value = "",
        inline = false
    })
    -- Spacer

    table.insert(embed[1].fields, {
        name = "**Top Speed**",
        value = "" .. data.first.speed .. " " .. (data.first.speed ~= Config.locale["dnf"] and (Config.MPH and Config.locale["mph"] or Config.locale["kph"])or""),
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Top Speed**",
            value = "" .. data.second.speed .. " " .. (data.second.speed ~= Config.locale["dnf"] and (Config.MPH and Config.locale["mph"] or Config.locale["kph"])or""),
            inline = true
        })
    end

    -- Spacer
    table.insert(embed[1].fields, {
        name = "",
        value = "",
        inline = false
    })
    -- Spacer

    table.insert(embed[1].fields, {
        name = "**Car**",
        value = "" .. data.first.model .. "",
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Car**",
            value = "" .. data.second.model .. "",
            inline = true
        })
    end

    PerformHttpRequest(webhook, function(err, text, headers) end,"POST",
        json.encode({
            username = "Nass Scripts",
            embeds = embed,
            avatar_url = "https://cdn.discordapp.com/attachments/224653951335792640/1218377071512911903/logopng.png"
        }),{["Content-Type"] = "application/json"})
end

nass.versionCheck(GetCurrentResourceName())

-- Automatically create required dragstrips tables and default row if not present
local function runTableAutoCreation()
    -- Create the tables if they don't exist
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `nass_dragstrips_data` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `data` longtext NOT NULL,
          PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
    ]], {}, function(result)
        if result.warningStatus == 0 then
            print("^2[nass_dragstrips] Data table initialized^0")
        end
    end)

    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `nass_dragstrips_records` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `strip_id` varchar(50) NOT NULL,
          `identifier` varchar(100) NOT NULL,
          `time` decimal(10,3) NOT NULL,
          `car` varchar(100) NOT NULL,
          `name` varchar(100) NOT NULL,
          `speed` decimal(10,2) NOT NULL,
          `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (`id`),
          KEY `strip_id` (`strip_id`),
          KEY `time` (`time`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
    ]], {}, function(result)
        if result.warningStatus == 0 then
            print("^2[nass_dragstrips] Records table initialized^0")
        end
    end)

    -- Check if the starter row exists, and insert it if not
    MySQL.query('SELECT COUNT(*) as count FROM `nass_dragstrips_data` WHERE id = 1', {}, function(result)
        if result and result[1] and tonumber(result[1].count) == 0 then
            MySQL.insert('INSERT INTO `nass_dragstrips_data` (`id`, `data`) VALUES (?, ?)', {
                1,
                '{"blipData":{"shortRange":true,"enabled":true,"scale":0.65,"sprite":309,"color":0},"name":"Sandy Shores","startPositions":[{"w":103.60369873046877,"z":40.18209457397461,"y":3248.548095703125,"x":1719.6097412109376},{"w":104.264404296875,"z":40.18209457397461,"y":3260.0107421875,"x":1715.69580078125}],"distance":1320,"maxTime":30,"dragtreeType":"nass_dragtree_pro","timingBoard":{"w":76.06320190429688,"z":40.14923858642578,"y":3265.572998046875,"x":1701.8902587890626},"dragTree":{"x":1696.71923828125,"y":3248.78076171875,"z":40.17494583129883,"w":104.62474822998047}}'
            }, function(rowsChanged)
                if rowsChanged and rowsChanged > 0 then
                    print("^2[nass_dragstrips] Default dragstrip row inserted^0")
                end
            end)
        end
    end)
end

CreateThread(function()
    Wait(500) -- Wait for the DB to load
    runTableAutoCreation()
end)
