--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.DiscordWebhooks = { -- Make sure the name is the same name as in the categories table
    -- Category-specific webhooks for when reports are opened
    ['Report Player'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
    ['Report Bug'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
    ['Report Other'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',

    -- Action-specific webhooks
    ['Claim Report'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
    ['Close Report'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
    ['Unclaim Report'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
    ['Delete Report'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
    ['Reopen Report'] = 'https://ptb.discord.com/api/webhooks/1303040596591640607/qJlIZZ7Gdwyh5mVY2pV1a5MVjHs7SYKScE-kOVJ8bCRvFkxFopG_azp27BXOAHsWmg4e',
}

--[[
    SERVER-SIDED ACTIONS
    Please, do not create actions when you have no idea what is going on. 
    In our discord, we got a customer section where you can ask for help or search for action snippets.
--]]
Config.ActionsFunctions = { -- Make sure the name is the same name as in the staff actions table
    ['heal'] = function (reportId, staffId, toPlayerId, isReported)
        local staff = FM.player.get(staffId)
        if not staff then return end

        -- Event below is put in client/opensource.lua, to make it more readable
        TriggerClientEvent('rxreports:healPlayer', toPlayerId)

        staff.notify(string.format('Successfully healed player (%s)', toPlayerId), 'success')
    end,
    ['spectate'] = function (reportId, staffId, toPlayerId, isReported)
        local staff = FM.player.get(staffId)
        if not staff then return end

        -- Event below is put in client/opensource.lua, to make it more readable
        TriggerClientEvent('rxreports:spectatePlayer', staffId, toPlayerId)

        staff.notify(string.format('Successfully spectating player (%s)', toPlayerId), 'success')
    end,
    ['goto'] = function (reportId, staffId, toPlayerId, isReported)
        local staff = FM.player.get(staffId)
        if not staff then return end

        -- Function below is put in server/opensource.lua, to make it more readable
        if not GoToPlayer(staffId, toPlayerId) then return false end

        staff.notify(string.format('Successfully teleported to player (%s)', toPlayerId), 'success')
    end,
    ['bring'] = function (reportId, staffId, toPlayerId, isReported)
        local staff = FM.player.get(staffId)
        if not staff then return end
        local report = GetReportById(reportId)
        if not report then return false end
        local oldCoords = GetEntityCoords(GetPlayerPed(toPlayerId))

        -- Function below is put in server/opensource.lua, to make it more readable
        if not BringPlayer(staffId, toPlayerId) then return false end

        if isReported then
            report.oldReportedCoords = oldCoords
        else
            report.oldReporterCoords = oldCoords
        end

        staff.notify(string.format('Successfully brought player (%s)', toPlayerId), 'success')
    end,
    ['tpback'] = function (reportId, staffId, toPlayerId, isReported)
        local staff = FM.player.get(staffId)
        if not staff then return end
        local report = GetReportById(reportId)
        if not report then return false end

        local backCoords = isReported and report.oldReportedCoords or report.oldReporterCoords

        if not backCoords then
            staff.notify('Player has no previous location to teleport back to', 'error')
            return false
        end

        -- Function below is put in server/opensource.lua, to make it more readable
        if not TeleportPlayer(toPlayerId, backCoords) then return false end

        staff.notify(string.format('Successfully teleported player (%s) back', toPlayerId), 'success')
    end,
    --[[['customExample'] = function (reportId, staffId, toPlayerId, isReported)
        Success('Look in server console, this is a custom example action')
        Success('Executed by Staff Player ID: ' .. staffId)
        Success('Used on Player ID: ' .. toPlayerId)
    end,]]
}

--[[
    API KEY (https://fivemanage.com/)
    DO NOT SHARE THIS WITH ANYONE, EVER!
    
    REQUIRES: screenshot-basic (https://github.com/citizenfx/screenshot-basic)
--]]
Config.FIVEMANAGE_API_KEY = ''