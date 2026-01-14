if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']

RegisterNetEvent('nm_boxing_reviveServer', function(id)
    TriggerClientEvent('nm_boxing_reviveClient', id)
end)

exports['nproblem-boxing']:geriCagri(framework, 'nm_boxing_checkDoping', function(source, cb, playerCID)
    local src = source
    local cid = playerCID
    if playerCID == nil then
        cid = exports['nproblem-boxing']:bvmjKE4qRM8GKE6hAPfSIBEsa8xy4xfq(framework, src)
    end
    local sqlModule

    if NMConfig['SQL'].oxmysql then
        sqlModule = exports.oxmysql
    elseif NMConfig['SQL'].ghmattimysql then
        sqlModule = exports.ghmattimysql
    end

    if sqlModule then
        local result = sqlModule:executeSync('SELECT * FROM nm_boxing_dopings WHERE playerID = ?', {cid})
        
        if result and result[1] then
            local currentTime = os.time()
            if currentTime > tonumber(result[1].time) then
                sqlModule:executeSync('DELETE FROM nm_boxing_dopings WHERE playerID = ?', {cid})
                cb(false)
            else
                cb(true)
            end
        else
            cb(false)
        end
    else
        print('[ERROR] SQL module not found! Please ensure oxmysql or ghmattimysql is properly configured.')
        cb(nil)
    end
end)

exports['nproblem-boxing']:geriCagri(framework, 'nm_boxing_checkDopingFromID', function(source, cb, id)
    local src = id
    local playerCID = exports['nproblem-boxing']:bvmjKE4qRM8GKE6hAPfSIBEsa8xy4xfq(framework, src)
    local sqlModule

    if NMConfig['SQL'].oxmysql then
        sqlModule = exports.oxmysql
    elseif NMConfig['SQL'].ghmattimysql then
        sqlModule = exports.ghmattimysql
    end

    if sqlModule then
        local result = sqlModule:executeSync('SELECT * FROM nm_boxing_dopings WHERE playerID = ?', {playerCID})
        
        if result and result[1] then
            cb(true)
        else
            cb(false)
        end
    else
        print('[ERROR] SQL module not found! Please ensure oxmysql or ghmattimysql is properly configured.')
        cb(nil)
    end
end)

RegisterNetEvent('nm_boxing_insertDoping', function(time)
    local src = source
    local cid = exports['nproblem-boxing']:bvmjKE4qRM8GKE6hAPfSIBEsa8xy4xfq(framework, src)
    local currentTime = os.time()
    local sqlModule

    if NMConfig['SQL'].oxmysql then
        sqlModule = exports.oxmysql
    elseif NMConfig['SQL'].ghmattimysql then
        sqlModule = exports.ghmattimysql
    end
    if sqlModule then
        sqlModule:execute('INSERT INTO nm_boxing_dopings (playerID, time) VALUES (?, ?)', {
            cid, 
            currentTime + time
        })
        exports['nproblem-boxing']:OlcXmr28XKr9oN50QED6g9k2ClaCaNTI(framework, source, NMConfig['General']['dopingItemName'], 1)
    else
        print('[ERROR] SQL module not found! Please ensure oxmysql or ghmattimysql is properly configured.')
    end
end)

exports['nproblem-boxing']:IShCS6h5LtleNDTT6cSQ0XN3O8tfbkeu(framework, NMConfig['General']['dopingItemName'], function(source)
    TriggerClientEvent('nm_boxing_useDoping', source)
end)
exports['nproblem-boxing']:IShCS6h5LtleNDTT6cSQ0XN3O8tfbkeu(framework, NMConfig['General']['dopingCheckItem'], function(source)
    TriggerClientEvent('nm_boxing_checkPlayer', source)
end)

RegisterNetEvent('nm_boxing_sendLog', function(title, description, color)
    if NMConfig['General']['logWebhook'] then
        local embed = {
            {
                ["title"] = title or "Log",
                ["description"] = description or "",
                ["color"] = color or 16777215,
                ["footer"] = {
                    ["text"] = os.date("%Y-%m-%d %H:%M:%S") .. '\nBoxing by NProbleM'
                }
            }
        }

        PerformHttpRequest(NMConfig['General']['logWebhook'], function(err, text, headers) end, 'POST', json.encode({
            username = "Logger",
            embeds = embed,
            avatar_url = "https://i.imgur.com/5cLkB2G.png"
        }), { ['Content-Type'] = 'application/json' })
    else
        print("^1[WARNING] You forgot to set a webhook. Without it, you won't be notified about players' actions.^0")
    end
end)