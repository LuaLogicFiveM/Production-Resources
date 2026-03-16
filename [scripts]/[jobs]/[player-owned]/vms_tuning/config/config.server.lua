SV = {}

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
SV.Database = {
    -- ESX:
    ['esx-table:owned_vehicles'] = 'owned_vehicles',
        ['esx-column:vehicle'] = 'vehicle',
        ['esx-column:plate'] = 'plate',
        ['esx-column:tuning_data'] = 'tuning_data',

    -- QB-Core:
    ['qb-table:player_vehicles'] = 'player_vehicles',
        ['qb-column:hash'] = 'hash',
        ['qb-column:mods'] = 'mods',
        ['qb-column:plate'] = 'plate',
        ['qb-column:tuning_data'] = 'tuning_data',
    
}


-- ██╗    ██╗███████╗██████╗ ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║    ██║██╔════╝██╔══██╗██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ██║ █╗ ██║█████╗  ██████╔╝███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██║███╗██║██╔══╝  ██╔══██╗██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ╚███╔███╔╝███████╗██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
--  ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝
SV.Webhooks = {
    ['BILL'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['TUNING'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    
    ['GENERATED_DISCOUNT_CODE_BY_ADMIN'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['REMOVED_DISCOUNT_CODE_BY_ADMIN'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['GENERATED_DISCOUNT_CODE'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['REMOVED_DISCOUNT_CODE'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",

    ['EMPLOYEE_BONUS'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['EMPLOYEE_CHANGE_GRADE'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['EMPLOYEE_FIRE'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['EMPLOYEE_HIRE'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['WITHDRAW'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['DEPOSIT'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",
    ['ANNOUNCEMENT'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU",

    -- Individual webhooks:
    -- ['BennyS'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
    -- ['BennyS-Paintshop'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
    -- ['LSCustoms1'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
    -- ['LSCustoms2'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
    -- ['LSCustoms3'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
    -- ['AutoRepairs'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
    -- ['BeekersGarage'] = "https://discord.com/api/webhooks/1483232115301814402/zc7Q27GI-azpYxwFusOYHVY0XWyBNgL8cP7GlLNAXSAKT75mpTlepdfPvnUjppl6r8fU"
}

SV.WebhookText = {
    ['TITLE.TUNING_BOUGHT'] = "🔧 Tuning Bought",
    ['DESCRIPTION.TUNING_BOUGHT'] = [[
        Player **%s** **[%s]** paid **$%s** for tuning to vehicle **%s** **(%s)**.
        
        ## Tuning List: 
        %s
        
        **Discount Code:** %s
        **Job**: %s
        **Grade**: %s
    ]],
    
    ['TITLE.TUNING_ACCEPTED_REQUEST'] = "🔧 Tuning Request Accepted",
    ['DESCRIPTION.TUNING_ACCEPTED_REQUEST'] = [[
        Player **%s** **[%s]** paid **$%s** for tuning to vehicle **%s** **(%s)**.
        
        ## Tuning List: 
        %s
        
        **Discount Code:** %s
        **Mechanic**: %s [%s]
        **Job**: %s
        **Grade**: %s
    ]],

    ['TITLE.BILL_PAID'] = "🧾 Tuning Bill",
    ['DESCRIPTION.BILL_PAID'] = [[
        Player **%s** **[%s]** paid bill **$%s** for tuning to vehicle **%s** **(%s)**.
        Mechanic **%s** **[%s]**
        
        ## Tuning List: 
        %s
        
        **Discount Code:** %s
    ]],

    ['TITLE.GENERATED_DISCOUNT_CODE_BY_ADMIN'] = "🎟️ Generated Discount Code",
    ['DESCRIPTION.GENERATED_DISCOUNT_CODE_BY_ADMIN'] = [[
        Admin **%s** **[%s]** generated discount code **%s** **-%s** to tuning shop **%s** for **%s** uses.
    ]],
    
    ['TITLE.REMOVED_DISCOUNT_CODE_BY_ADMIN'] = "❌ Removed Discount Code",
    ['DESCRIPTION.REMOVED_DISCOUNT_CODE_BY_ADMIN'] = [[
        Admin **%s** **[%s]** removed discount code **%s**.
    ]],

    ['TITLE.GENERATED_DISCOUNT_CODE'] = "🎟️ Generated Disount Code",
    ['DESCRIPTION.GENERATED_DISCOUNT_CODE'] = [[
        Player **%s** **[%s]** generated discount code **%s** **-%s** to tuning shop **%s** for **%s** uses.
    ]],

    ['TITLE.REMOVED_DISCOUNT_CODE'] = "❌ Removed Discount Code",
    ['DESCRIPTION.REMOVED_DISCOUNT_CODE'] = [[
        Player **%s** **[%s]** removed discount code **%s**.
    ]],

    ['TITLE.EMPLOYEE_BONUS'] = "💸 Employee Bonus",
    ['DESCRIPTION.EMPLOYEE_BONUS'] = [[
        Player %s [%s] gave a bonus to employee %s of %s$ in tuning %s
    ]],

    ['TITLE.EMPLOYEE_CHANGE_GRADE'] = "👨‍💼 Employee Change Grade",
    ['DESCRIPTION.EMPLOYEE_CHANGE_GRADE'] = [[
        Player %s [%s] changed the job grade of player %s to %s in tuning %s
    ]],

    ['TITLE.EMPLOYEE_FIRE'] = "❌ Employee Fire",
    ['DESCRIPTION.EMPLOYEE_FIRE'] = [[
        Player %s [%s] fired an employee %s to tuning %s
    ]],

    ['TITLE.EMPLOYEE_HIRE'] = "✅ Employee Hire",
    ['DESCRIPTION.EMPLOYEE_HIRE'] = [[
        Player %s [%s] hired an employee %s (%s) to tuning %s
    ]],

    ['TITLE.WITHDRAW'] = "💲 Withdraw",
    ['DESCRIPTION.WITHDRAW'] = [[
        Player %s [%s] withdrew $%s from tuning %s
    ]],

    ['TITLE.DEPOSIT'] = "💲 Deposit",
    ['DESCRIPTION.DEPOSIT'] = [[
        Player %s [%s] deposit $%s to tuning %s
    ]],
    
    ['TITLE.ANNOUNCEMENT'] = "📰 New Announcement",
    ['DESCRIPTION.ANNOUNCEMENT'] = [[
        Player %s [%s] wrote an announcement in tuning %s with the content:
        ```%s```
    ]],
    
}

SV.Webhook = function(webhook_id, title, description, color, footer)
    local DiscordWebHook = SV.Webhooks[webhook_id]
    local embeds = {{
        ["title"] = title,
        ["type"] = "rich",
        ["description"] = description,
        ["color"] = color,
        ["footer"] = {
            ["text"] = footer..' - '..os.date(),
        },
    }}
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
end


-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
SV.getPlayer = function(src)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromId(src)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayer(src)
    end
end

SV.getIdentifier = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.identifier
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

SV.getPlayerByIdentifier = function(identifier)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromIdentifier(identifier)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayerByCitizenId(identifier)
    end
end

SV.getCharacterName = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.getName()
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
    end
end

SV.getPlayerJob = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.job.name
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name
    end
end

SV.setPlayerJob = function(src, xPlayer, jobName, grade, isOffline)
    if jobName then
        if Config.Core == "ESX" then
            xPlayer.setJob(jobName, grade)
        elseif Config.Core == "QB-Core" then
            xPlayer.Functions.SetJob(jobName, grade)
        end
    else
        if not isOffline then
            if Config.Core == "ESX" then
                xPlayer.setJob('unemployed', 0)
            elseif Config.Core == "QB-Core" then
                xPlayer.Functions.SetJob('unemployed')
            end
        else
            if Config.Core == "ESX" then
                MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
                    ['@job'] = 'unemployed',
                    ['@job_grade'] = '0',
                    ['@identifier'] = xPlayer
                })
            elseif Config.Core == "QB-Core" then
                -- TriggerClientEvent("vms_tuning:notification", src, TRANSLATE('notify.employees:player_is_offline'), 4500, 'error')
            end
        end
    end
end

SV.isPlayerEmployee = function(xPlayer, jobName)
    if Config.Core == "ESX" then
        return xPlayer.job.name == jobName
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name == jobName
    end
end

SV.isPlayerManager = function(xPlayer, jobName, storeId)
    local managerGrades = Config.TuningPoints[storeId].manager_grades
    if Config.Core == "ESX" then
        if xPlayer.job.name ~= jobName then
            return false
        end
        
        if type(managerGrades) == 'table' then
            for _, job in pairs(managerGrades) do
                if xPlayer.job.grade_name == job.grade then
                    return true
                end
            end
        else
            return xPlayer.job.grade_name == managerGrades
        end
    elseif Config.Core == "QB-Core" then
        if xPlayer.PlayerData.job.name ~= jobName then
            return false
        end

        if type(managerGrades) == 'table' then
            for _, job in pairs(managerGrades) do
                if xPlayer.PlayerData.job.grade.name == job.grade then
                    return true
                end
            end
        else
            return xPlayer.PlayerData.job.grade.name == managerGrades
        end
        
    end
end

SV.isPlayerBoss = function(xPlayer, jobName, storeId)
    local bossGrades = Config.TuningPoints[storeId].boss_grades
    if Config.Core == "ESX" then
        if xPlayer.job.name ~= jobName then
            return false
        end

        if type(bossGrades) == 'table' then
            for _, job in pairs(bossGrades) do
                if xPlayer.job.grade_name == job.grade then
                    return true
                end
            end
        else
            return xPlayer.job.grade_name == bossGrades
        end
        
    elseif Config.Core == "QB-Core" then
        if xPlayer.PlayerData.job.name ~= jobName then
            return false
        end

        if type(bossGrades) == 'table' then
            for _, job in pairs(bossGrades) do
                if xPlayer.PlayerData.job.grade.name == job.grade then
                    return true
                end
            end
        else
            return xPlayer.PlayerData.job.grade.name == bossGrades
        end

    end
end

SV.isPlayerOnDuty = function(xPlayer)
    if Config.Core == "ESX" then
        return true
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.onduty
    end
end

SV.getMoney = function(xPlayer, moneyType)
    if Config.Core == "ESX" then
        local type = moneyType == "cash" and 'money' or 'bank'
        return xPlayer.getAccount(type).money
    elseif Config.Core == "QB-Core" then
        return xPlayer.Functions.GetMoney(moneyType)
    end
    return nil
end

SV.addMoney = function(xPlayer, moneyType, amount)
    -- This funtion is only used for Config.BillMoneyToTunerPercent and Config.RequestMoneyToTunerPercent
    if Config.Core == "ESX" then
        local type = moneyType == "cash" and 'money' or 'bank'
        xPlayer.addAccountMoney(type, amount)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.AddMoney(moneyType, amount)
    end
end

SV.removeMoney = function(xPlayer, moneyType, amount)
    if Config.Core == "ESX" then
        local type = moneyType == "cash" and 'money' or 'bank'
        xPlayer.removeAccountMoney(type, amount)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.RemoveMoney(moneyType, amount)
    end
    return nil
end

SV.updateVehicle = function(xPlayer, cache)
    if Config.Core == "ESX" then
        MySQL.Async.fetchSingle(('SELECT %s FROM %s WHERE %s = @plate'):format(
            SV.Database['esx-column:vehicle'], 
            SV.Database['esx-table:owned_vehicles'], 
            SV.Database['esx-column:plate']
        ), {
            ['@plate'] = cache.lastProperties['plate']
        }, function(result)
            if result then
                local vehiclePropsDB = json.decode(result[SV.Database['esx-column:vehicle']])

                if vehiclePropsDB.model == cache.currentProperties['model'] then
                    MySQL.Async.execute(('UPDATE %s SET %s = @vehicle, %s = @newPlate WHERE %s = @lastPlate'):format(
                        SV.Database['esx-table:owned_vehicles'],
                        SV.Database['esx-column:vehicle'],
                        SV.Database['esx-column:plate'],
                        SV.Database['esx-column:plate']
                    ), {
                        ['@vehicle'] = json.encode(cache.currentProperties), 
                        ['@newPlate'] = cache.currentProperties.plate, 
                        ['@lastPlate'] = cache.lastProperties.plate
                    })

                    TriggerClientEvent('vms_tuning:updatedVehicle', xPlayer.source, cache)

                    if GetResourceState('qs-advancedgarages') ~= 'missing' then
                        if cache.lastProperties.plate ~= cache.currentProperties.plate then
                            exports['qs-advancedgarages']:updateVehiclePlate(cache.lastProperties.plate, cache.currentProperties.plate)
                        end
                    end
                end
            end
        end)
    elseif Config.Core == "QB-Core" then
        MySQL.Async.fetchSingle(('SELECT %s, %s FROM %s WHERE %s = @plate'):format(
            SV.Database['qb-column:hash'],
            SV.Database['qb-column:mods'],
            SV.Database['qb-table:player_vehicles'],
            SV.Database['qb-column:plate']
        ), {
            ['@plate'] = cache.lastProperties['plate']
        }, function(result)
            if result then
                local vehiclePropsDB = json.decode(result[SV.Database['qb-column:mods']])
                if vehiclePropsDB.model == cache.currentProperties['model'] then
                    MySQL.Async.execute(('UPDATE %s SET %s = @mods, %s = @newPlate WHERE %s = @lastPlate'):format(
                        SV.Database['qb-table:player_vehicles'],
                        SV.Database['qb-column:mods'],
                        SV.Database['qb-column:plate'],
                        SV.Database['qb-column:plate']
                    ), {
                        ['@mods'] = json.encode(cache.currentProperties), 
                        ['@newPlate'] = cache.currentProperties.plate, 
                        ['@lastPlate'] = cache.lastProperties.plate
                    })

                    TriggerClientEvent('vms_tuning:updatedVehicle', xPlayer.PlayerData.source, cache)

                    if GetResourceState('qs-advancedgarages') ~= 'missing' then
                        if cache.lastProperties.plate ~= cache.currentProperties.plate then
                            exports['qs-advancedgarages']:updateVehiclePlate(cache.lastProperties.plate, cache.currentProperties.plate)
                        end
                    end
                end
            else
                
            end
        end)
    end
end

SV.verifyPlateNotExist = function(xPlayer, cache, cb)
    if cache.lastProperties['plate'] == cache.currentProperties['plate'] then
        cb(false)
        return
    end
    if Config.Core == "ESX" then
        MySQL.Async.fetchSingle(('SELECT %s FROM %s WHERE %s = @plate'):format(
            SV.Database['esx-column:vehicle'],
            SV.Database['esx-table:owned_vehicles'],
            SV.Database['esx-column:plate']
        ), {
            ['@plate'] = cache.currentProperties['plate']
        }, function(result)
            if result then
                cb(true)
            else
                cb(false)
            end
        end)
    elseif Config.Core == "QB-Core" then
        MySQL.Async.fetchSingle(('SELECT %s FROM %s WHERE %s = @plate'):format(
            SV.Database['qb-column:mods'],
            SV.Database['qb-table:player_vehicles'],
            SV.Database['qb-column:plate']
        ), {
            ['@plate'] = cache.currentProperties['plate']
        }, function(result)
            if result then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end

SV.getPricesFromDatabase = function()
    local prices = {}
    
    local db = MySQL.query.await('SELECT model, price FROM vehicles')
    for k, v in pairs(db) do
        prices[v.model] = v.price
    end

    return prices
end

SV.checkIsAdmin = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.group == "admin"
    elseif Config.Core == "QB-Core" then
        return Core.Functions.HasPermission(xPlayer.PlayerData.source, 'admin')
    end
end

-- ▄▀▀ █ █ ▄▀▀ ▀█▀ ▄▀▄ █▄ ▄█   ██▄ ▄▀▄ █   ▄▀▄ █▄ █ ▄▀▀ ██▀
-- ▀▄▄ ▀▄█ ▄██  █  ▀▄▀ █ ▀ █   █▄█ █▀█ █▄▄ █▀█ █ ▀█ ▀▄▄ █▄▄
-- @getSocietyMoney: custom function, it is used when you don't use Config.UseBuildInCompanyBalance, you should customize your company money storage system, cb is supposed to return a number
SV.getSocietyMoney = function(societyName, cb)
    if GetResourceState('cs_bossmenu') == "started" then
        local society = exports['cs_bossmenu']:GetAccount(societyName)
        cb(society)
        
    elseif GetResourceState('okokBanking') == "started" then
        local society = exports['okokBanking']:GetAccount(societyName)
        cb(society)

    elseif GetResourceState('qb-banking') == "started" then
        local society = exports['qb-banking']:GetAccountBalance(societyName)
        cb(society)

    elseif GetResourceState('qb-management') == "started" then
        local society = exports['qb-management']:GetAccount(societyName)
        cb(society)

    elseif GetResourceState('esx_society') == "started" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            cb(account.money)
        end)

    else
        print('^5[INFO] ^7No society found for your server, go to vms_tuning/config/config.server.lua and adjust ^2SV.getSocietyMoney^7!')
        
    end
end

-- @addSocietyMoney: custom function, it is used when you don't use Config.UseBuildInCompanyBalance, you should customize your company money storage system
SV.addSocietyMoney = function(societyName, amount)
    if GetResourceState('cs_bossmenu') == "started" then
        exports['cs_bossmenu']:AddMoney(societyName, amount)
        
    elseif GetResourceState('okokBanking') == "started" then
        exports['okokBanking']:AddMoney(societyName, amount)

    elseif GetResourceState('qb-banking') == "started" then
        exports['qb-banking']:AddMoney(societyName, amount)

    elseif GetResourceState('qb-management') == "started" then
        exports['qb-management']:AddMoney(societyName, amount)

    elseif GetResourceState('esx_society') == "started" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            account.addMoney(amount)
        end)
        
    else
        print('^5[INFO] ^7No society found for your server, go to vms_tuning/config/config.server.lua and adjust ^2SV.addSocietyMoney^7!')
        
    end
end

-- @removeSocietyMoney: custom function, it is used when you don't use Config.UseBuildInCompanyBalance, you should customize your company money storage system
SV.removeSocietyMoney = function(societyName, amount)
    if GetResourceState('cs_bossmenu') == "started" then
        exports['cs_bossmenu']:RemoveMoney(societyName, amount)
        
    elseif GetResourceState('okokBanking') == "started" then
        exports['okokBanking']:RemoveMoney(societyName, amount)

    elseif GetResourceState('qb-banking') == "started" then
        exports['qb-banking']:RemoveMoney(societyName, amount)

    elseif GetResourceState('qb-management') == "started" then
        exports['qb-management']:RemoveMoney(societyName, amount)

    elseif GetResourceState('esx_society') == "started" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            account.removeMoney(amount)
        end)
        
    else
        print('^5[INFO] ^7No society found for your server, go to vms_tuning/config/config.server.lua and adjust ^2SV.removeSocietyMoney^7!')
        
    end
end

-- @banPlayer: is executed when a player tries to upgrade a vehicle using cheats, you can set for example your ban event or DropPlayer function
SV.banPlayer = function(playerId)
    print('^1[WARNING] ^7Player with id '..playerId..' tries to upgrade vehicle using cheats.')
end

-- ██▀ ▄▀▀ ▀▄▀   ▄▀▀ ▄▀▄ ▄▀▀ █ ██▀ ▀█▀ ▀▄▀   █▀▄ ██▀ ▄▀  █ ▄▀▀ ▀█▀ ██▀ █▀▄
-- █▄▄ ▄██ █ █   ▄██ ▀▄▀ ▀▄▄ █ █▄▄  █   █    █▀▄ █▄▄ ▀▄█ █ ▄██  █  █▄▄ █▀▄
Citizen.CreateThread(function() -- Registration esx_society
    Citizen.Wait(1000)
    if not Config.UseBuildInCompanyBalance and not Config.RemoveBalanceFromMenu then
        for k, v in pairs(Config.TuningPoints) do
            if v.job and v.society_name then
                TriggerEvent('esx_society:registerSociety', v.job, v.job, v.society_name, v.society_name, v.society_name, {type = 'public'})
            end
        end
    end
end)