if CodeStudio.ServerType == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end


function GetPlayer(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        return Player
    end
end

function GetIdentifier(Player)
    if CodeStudio.ServerType == 'QB' then
        local ident = Player.PlayerData.citizenid
        return ident
    elseif CodeStudio.ServerType == 'ESX' then
        local ident = Player.identifier
        return ident
    end
end

function SetPlayerJob(source, data)
    if CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        Player.setJob(data.job, tonumber(data.rank))
    elseif CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.SetJob(data.job, data.rank)
    end
end

function GetPlayerJob(Player)
    local Job = Player.job.name
    local Grade = Player.job.grade
    local GradeName = Player.job.grade_label
    local JobName = Player.job.label
    return Job, Grade, GradeName, JobName
end

function GetPlayerGroup(source, role)
    local xPlayer = ESX.GetPlayerFromId(source)
    return role == xPlayer.getGroup()
end

RegisterNetEvent('ESX:ToggleDuty:multijob', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentJob = xPlayer.getJob()
    xPlayer.setJob(currentJob.name, currentJob.grade, not xPlayer.getJob().onDuty)
end)


--- Discord Logs for Admin Commands---

function SendDiscordLog(data, eventType)
    if not CodeStudio.AdminCommands.DiscordLogs then return end
    local webHook = 'https://ptb.discord.com/api/webhooks/1219384386038792273/8SOnIaFYt3nR_zt1jBRx6_tnxVyuXWOZX1HUPtjLpNZSBPIuclU9l5EQ_rr-lbTmqq9y'        --You can put webhook here directly for better security
    local embedData = {
        {
            color = 65280,
            footer = {
                text = os.date('%c'),
            },
        }
    }

    if eventType == 'update' then
        embedData[1].title = "Grade Update"
    elseif eventType == 'add' then
        embedData[1].title = "Job Added"
    elseif eventType == 'remove' then
        embedData[1].title = "Job Removed"
    end

    embedData[1].description = 
    '**Admin: **' .. data.admin ..
    '\n**Target ID: **' .. data.targetID ..
    '\n**Target Identifier: **' .. data.identifier ..
    '\n**Job: **' .. data.assignJob ..
    '\n**Rank: **' .. data.assignRank
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Multijob', embeds = embedData }), { ['Content-Type'] = 'application/json' })
end


if CodeStudio.AdminCommands.EnableAdminCommands then
    local function IsAdmin(player)
        local identifiers = GetPlayerIdentifiers(player)
    
        for _, identifier in ipairs(identifiers) do
            for _, adminIdentifier in ipairs(CodeStudio.AdminCommands.AdminRoles) do
                if identifier == adminIdentifier then
                    return true
                end
            end
        end
        
        for _, role in ipairs(CodeStudio.AdminCommands.AdminRoles) do
            local adminCheck = GetPlayerGroup(player, role)
            if adminCheck then
                return true
            end
        end
    
        return false
    end

    lib.addCommand(CodeStudio.AdminCommands.AdminAddJobCommand, {
        help = 'Add Job to a Player',
        params = {
            {
                name = 'id',
                type = 'number',
                help = 'Player ID',
            },
            {
                name = 'job',
                type = 'text',
                help = 'Job',
            },
            {
                name = 'rank',
                type = 'text',
                help = 'Rank/Grade',
            },
        },
    }, function(source, args, raw)
        if IsAdmin(source) then
            addJob_Command(source, args.id, args.job, args.rank, true)
        else
            TriggerClientEvent('cs:multijob:notify', source, CodeStudio.Language.noAdmin, "error")
        end
    end)

    lib.addCommand(CodeStudio.AdminCommands.AdminRemoveJobCommand, {
        help = 'Remove Job from Player',
        params = {
            {
                name = 'id',
                type = 'number',
                help = 'Player ID',
            },
            {
                name = 'job',
                type = 'text',
                help = 'Job',
            },
        },
    }, function(source, args, raw)
        if IsAdmin(source) then
            addJob_Command(source, args.id, args.job, false, false)
        else
            TriggerClientEvent('cs:multijob:notify', source, CodeStudio.Language.noAdmin, "error")
        end
    end)
end
