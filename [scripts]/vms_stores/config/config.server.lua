SV = {}

SV.Webhooks = {
    ['PURCHASE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['PURCHASED_STORE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['SELL_STORE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['CREATE_ORDER'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['DELIVERY_ORDER'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['EMPLOYEE_BONUS'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['EMPLOYEE_CHANGE_GRADE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['EMPLOYEE_FIRE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['EMPLOYEE_HIRE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['ALARM'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['INSURANCE'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['LEVELUP'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['MONEY_ESCORT'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['WITHDRAW'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['DEPOSIT'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['ANNOUNCEMENT'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['DESTROY_CAMERAS'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['START_ROBBERY'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['REWARD_ROBBERY'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
    ['RESELL'] = "https://discord.com/api/webhooks/1478846595544911975/o_t0RGIbbC8oK-CBixRtpTYJGb55P4lU6EXNpHvdMVXNxVkKyxrNCqxh_3_VBvi38fDH",
}

SV.WebhookText = {
    ['TITLE.PURCHASE'] = "🧾 Purchased Products",
    ['DESCRIPTION.PURCHASE'] = [[
        Player %s purchased products in store %s - %s (%s)
        
        ## Products List:
        %s
        
        Total: %s$
    ]],

    ['TITLE.PURCHASED_STORE'] = "🏪 Purchased Store",
    ['DESCRIPTION.PURCHASED_STORE'] = [[
        Player %s purchased store %s - %s (%s) for %s$
    ]],

    ['TITLE.SELL_STORE'] = "🏪 Sell Store",
    ['DESCRIPTION.SELL_STORE'] = [[
        Player %s sell store %s - %s (%s) for $%s
    ]],
    
    ['TITLE.CREATE_ORDER'] = "📦 Create Order",
    ['DESCRIPTION.CREATE_ORDER'] = [[
        Player %s created order from wholesale %s for %s in store %s - %s (%s)
    ]],

    ['TITLE.DELIVERY_ORDER'] = "🏪 Delivery Order",
    ['DESCRIPTION.DELIVERY_ORDER'] = [[
        Player %s delivered order from wholesale %s - %s to store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_BONUS'] = "💸 Employee Bonus",
    ['DESCRIPTION.EMPLOYEE_BONUS'] = [[
        Player %s gave a bonus to employee %s of %s$ in store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_CHANGE_GRADE'] = "👨‍💼 Employee Change Grade",
    ['DESCRIPTION.EMPLOYEE_CHANGE_GRADE'] = [[
        Player %s changed the job grade of player %s to %s in store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_FIRE'] = "❌ Employee Fire",
    ['DESCRIPTION.EMPLOYEE_FIRE'] = [[
        Player %s fired an employee %s to store %s - %s (%s)
    ]],

    ['TITLE.EMPLOYEE_HIRE'] = "✅ Employee Hire",
    ['DESCRIPTION.EMPLOYEE_HIRE'] = [[
        Player %s hired an employee %s (%s) to store %s - %s (%s)
    ]],

    ['TITLE.ALARM'] = "🔐 Bought Alarm",
    ['DESCRIPTION.ALARM'] = [[
        Player %s purchased Alarm & Monitoring for $%s from store %s - %s (%s)
    ]],

    ['TITLE.INSURANCE'] = "🔐 Bought Insurance",
    ['DESCRIPTION.INSURANCE'] = [[
        Player %s purchased insurance in %s days for $%s from store %s - %s (%s)
    ]],

    ['TITLE.LEVELUP'] = "📈 Level UP Store",
    ['DESCRIPTION.LEVELUP'] = [[
        Player %s upgraded store %s - %s (%s) to level %s 
    ]],

    ['TITLE.MONEY_ESCORT'] = "💰 Money Escort",
    ['DESCRIPTION.MONEY_ESCORT'] = [[
        Player %s escorted $%s of money using money escort service from store %s - %s (%s)
    ]],

    ['TITLE.WITHDRAW'] = "💲 Withdraw",
    ['DESCRIPTION.WITHDRAW'] = [[
        Player %s withdrew $%s from store %s - %s (%s)
    ]],

    ['TITLE.DEPOSIT'] = "💲 Deposit",
    ['DESCRIPTION.DEPOSIT'] = [[
        Player %s deposit $%s from store %s - %s (%s)
    ]],
    
    ['TITLE.ANNOUNCEMENT'] = "💲 New Announcement",
    ['DESCRIPTION.ANNOUNCEMENT'] = [[
        Player %s wrote an announcement in store %s - %s (%s) with the content:
        ```%s```
    ]],
    
    ['TITLE.DESTROY_CAMERAS'] = "🎥 Destroy Cameras",
    ['DESCRIPTION.DESTROY_CAMERAS'] = [[
        Player %s destroyed cameras in store %s - %s (%s)
    ]],

    ['TITLE.START_ROBBERY'] = "💰 Started Robbery",
    ['DESCRIPTION.START_ROBBERY'] = [[
        Player %s started robbery in store %s - %s (%s)
    ]],
    
    ['TITLE.REWARD_ROBBERY'] = "💰 Robbery",
    ['DESCRIPTION.REWARD_ROBBERY'] = [[
        Player %s completed a robbery at store %s - %s (%s) stole %s$.
    ]],

    ['TITLE.RESELL'] = "📑 Resell",
    ['DESCRIPTION.RESELL'] = [[
        Player %s resold his shares in store %s - %s (%s) to player %s (%s) for %s$.
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

SV.getIdentifier = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.identifier
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.citizenid
    end
end

SV.getPlayerByIdentifier = function(identifier)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromIdentifier(identifier)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayerByCitizenId(identifier) or Core.Functions.GetOfflinePlayerByCitizenId(identifier)
    end
end

SV.getCharacterName = function(xPlayer)
    if Config.Core == "ESX" then
        return xPlayer.getName()
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
    end
end

SV.getPlayer = function(src)
    if Config.Core == "ESX" then
        return Core.GetPlayerFromId(src)
    elseif Config.Core == "QB-Core" then
        return Core.Functions.GetPlayer(src)
    end
end

SV.isPlayerEmployee = function(xPlayer, jobName)
    if Config.Core == "ESX" then
        return xPlayer.job.name == jobName
    elseif Config.Core == "QB-Core" then
        return xPlayer.PlayerData.job.name == jobName
    end
end

SV.isPlayerManager = function(xPlayer, jobName)
    if Config.Core == "ESX" then
        return (xPlayer.job.name == jobName and xPlayer.job.grade_name == 'manager')
    elseif Config.Core == "QB-Core" then
        return (xPlayer.PlayerData.job.name == jobName and xPlayer.PlayerData.job.grade.level == 1)
    end
end

SV.isPlayerBoss = function(xPlayer, jobName, storeId)
    if Config.Core == "ESX" then
        return (stores[storeId].owner == xPlayer.identifier or xPlayer.job.name == jobName and xPlayer.job.grade_name == 'boss')
    elseif Config.Core == "QB-Core" then
        return (stores[storeId].owner == xPlayer.PlayerData.citizenid or xPlayer.PlayerData.job.name == jobName and xPlayer.PlayerData.job.grade.level == 2)
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
            if GetResourceState('qbx_core') == 'started' then
                if xPlayer.PlayerData.source then
                    xPlayer.Functions.SetJob(jobName, grade)
                else
                    TriggerClientEvent("vms_stores:notification", src, TRANSLATE('notify.employees:player_is_offline'), 4500, 'error')
                    return false
                end
            else
                xPlayer.Functions.SetJob(jobName, grade)
                xPlayer.Functions.Save()
            end
            
        end
    else
        if not isOffline then
            if Config.Core == "ESX" then
                xPlayer.setJob('unemployed', 0)
                
            elseif Config.Core == "QB-Core" then
                if GetResourceState('qbx_core') == 'started' then
                    if xPlayer.PlayerData.source then
                        xPlayer.Functions.SetJob('unemployed')
                    else
                        TriggerClientEvent("vms_stores:notification", src, TRANSLATE('notify.employees:player_is_offline'), 4500, 'error')
                        return false
                    end
                else
                    xPlayer.Functions.SetJob('unemployed')
                    xPlayer.Functions.Save()
                end
                
            end
        else
            if Config.Core == "ESX" then
                MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
                    ['@job'] = 'unemployed',
                    ['@job_grade'] = '0'
                })
                
            elseif Config.Core == "QB-Core" then
                if GetResourceState('qbx_core') == 'started' then
                    if xPlayer.PlayerData.source then
                        xPlayer.Functions.SetJob('unemployed')
                    else
                        TriggerClientEvent("vms_stores:notification", src, TRANSLATE('notify.employees:player_is_offline'), 4500, 'error')
                        return false
                    end
                else
                    xPlayer.Functions.SetJob('unemployed', 0)
                    xPlayer.Functions.Save()
                end

            end
        end
    end
    return true
end

SV.removeAllEmployees = function(src, jobName)
    if Config.Core == "ESX" then
        MySQL.Async.fetchAll('SELECT identifier FROM users WHERE job = @job', {
            ['@job'] = jobName
        }, function(result)
            if result and result[1] then
                for k,v in pairs(result) do
                    local xPlayer = SV.getPlayerByIdentifier(v.identifier)
                    if xPlayer then
                        SV.setPlayerJob(src, xPlayer)
                    end
                end
                MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE job = @oldJob', {
                    ['@oldJob'] = jobName,
                    ['@job'] = 'unemployed',
                    ['@job_grade'] = '0',
                })
            end
        end)

    else
        local unemployedJob = Core.Shared.Jobs['unemployed']
        if not unemployedJob then
            return
        end
        
        local gradeData = unemployedJob.grades['0'] or unemployedJob.grades[0]
        if not gradeData then
            return warn(('^1[WARNING] ^7Unemployed job does not have grade 0, please add it to avoid errors.'):format(jobName))
        end
        
        local playerJob = {}
        playerJob.onduty = unemployedJob.defaultDuty
        playerJob.type = unemployedJob.type or 'none'
        playerJob.label = unemployedJob.label
        playerJob.payment = gradeData.payment
        playerJob.name = 'unemployed'
        playerJob.grade = {
            level = 0,
            name = gradeData.name
        }
        playerJob.isboss = false

        playerJob = json.encode(playerJob)
        
        MySQL.Async.fetchAll("SELECT citizenid FROM players WHERE (job LIKE '%" .. jobName .. "%')", {
            ['@job'] = jobName
        }, function(result)
            if result and result[1] then
                for k,v in pairs(result) do
                    local xPlayer = SV.getPlayerByIdentifier(v.citizenid)
                    if xPlayer then
                        SV.setPlayerJob(src, xPlayer)
                    end
                    MySQL.Async.execute('UPDATE players SET job = @job WHERE citizenid = @citizenid', {
                        ['@citizenid'] = v.citizenid,
                        ['@job'] = playerJob,
                    })
                end
            end
        end)
    end
end

SV.getJobsOnline = function(jobName)
    if Config.Core == "ESX" then
        return #Core.GetExtendedPlayers('job', jobName)

    elseif Config.Core == "QB-Core" then
        local players, count = Core.Functions.GetPlayersOnDuty(jobName)
        return count
        
    end
end

SV.getMoney = function(xPlayer, moneyType)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType
        return xPlayer.getAccount(moneyType).money
    elseif Config.Core == "QB-Core" then
        return xPlayer.Functions.GetMoney(moneyType)
    end
end

SV.addMoney = function(xPlayer, moneyType, count)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType == 'dirty' and 'black_money' or moneyType
        xPlayer.addAccountMoney(moneyType, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.AddMoney(moneyType, count)
    end
end

SV.removeMoney = function(xPlayer, moneyType, count)
    if Config.Core == "ESX" then
        local moneyType = moneyType == 'cash' and 'money' or moneyType
        xPlayer.removeAccountMoney(moneyType, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.RemoveMoney(moneyType, count)
    end
end

SV.checkRequiredItem = function(xPlayer, name, count, removeOnUse)
    if Config.Core == "ESX" then
        if xPlayer.getInventoryItem(name).count >= count then
            if removeOnUse then
                xPlayer.removeInventoryItem(name, count)
            end
            return true
        end
        return false
    elseif Config.Core == "QB-Core" then
        if xPlayer.Functions.GetItemByName(name) and xPlayer.Functions.GetItemByName(name).amount >= count then
            if removeOnUse then
                xPlayer.Functions.RemoveItem(name, count)
            end
            return true
        end
        return false
    end
end

SV.addItem = function(xPlayer, name, count)
    if Config.Core == "ESX" then
        xPlayer.addInventoryItem(name, count)
    elseif Config.Core == "QB-Core" then
        xPlayer.Functions.AddItem(name, count)
    end
end

SV.addAgreementItem = function(xPlayer, playerId, name, metadata)
    if GetResourceState("qs-inventory") ~= "missing" then
        exports['qs-inventory']:AddItem(playerId, name, 1, nil, metadata)
        
    elseif GetResourceState("ox_inventory") ~= "missing" then
        exports['ox_inventory']:AddItem(playerId, name, 1, metadata, nil)
        
    elseif GetResourceState("qb-inventory") ~= "missing" then
        exports['qb-inventory']:AddItem(playerId, name, 1, nil, metadata)
        
    elseif GetResourceState("core_inventory") ~= "missing" then
        exports['core_inventory']:addItem(('primary-%s'):format((Config.Core == "ESX" and xPlayer.identifier or xPlayer.PlayerData.identifier):gsub(':','')), name, 1, metadata, 'content')
        
    end
end

SV.registerAgreementItem = function(cb)
    if GetResourceState("qs-inventory") ~= "missing" then
        exports['qs-inventory']:CreateUsableItem(Config.AgreementItem, function(source, item)
            cb(item.info)
        end)
    elseif GetResourceState("ox_inventory") ~= "missing" then
        
    elseif GetResourceState("qb-inventory") ~= "missing" then
        QBCore.Functions.CreateUseableItem(Config.AgreementItem, function(source, item)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            if Player.Functions.GetItemByName(item.name) then
                cb(item.info)
            end
        end)
    elseif GetResourceState("core_inventory") ~= "missing" then
        
    else
        print("[^1INFORMATION^7] Your inventory is not supported to give agreement item, if you are using inventory with metadata, provide it in SV.addAgreementItem & SV.registerAgreementItem (config.server.lua).")
        print("If you use public paid or free inventory, we will be glad when you let us know so that we can add compatibility.")
    end
end

SV.banPlayer = function(playerId, type, data)
    if type == 'robbery-distance' then
        print(('^1[WARNING] ^7Player %s tries to robbery a store %s with distance %s, thats too much!'):format(playerId, data.storeId, data.distance))
    elseif type == 'trying-earn-on-not-robbered' then
        print(('^1[WARNING] ^7Player %s tries to earn money from robbery in store %s but this store was not robbered!'):format(playerId, data.storeId))
    elseif type == '' then
        
    end
end