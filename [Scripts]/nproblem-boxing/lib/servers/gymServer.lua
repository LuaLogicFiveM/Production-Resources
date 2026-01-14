if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']

exports('addGymStat', function(id, amount)
    local sqlModule

    if NMConfig['SQL'].oxmysql then
        sqlModule = exports.oxmysql
    elseif NMConfig['SQL'].ghmattimysql then
        sqlModule = exports.ghmattimysql
    end

    if sqlModule then
        local identifier = exports['nproblem-boxing']:bvmjKE4qRM8GKE6hAPfSIBEsa8xy4xfq(framework, tonumber(id))
        local result = sqlModule:executeSync('SELECT * FROM nm_boxing_fighters WHERE playerID = ?', {identifier})

        if result and result[1] then
            local newAmount = tonumber(amount)
            local currentStat = tonumber(result[1].gymStats) or 0

            if newAmount and newAmount > 0 then
                sqlModule:execute('UPDATE nm_boxing_fighters SET gymStats = ? WHERE playerID = ?', {currentStat + newAmount, identifier})
            else
                print('[addGymStat]-[HATA]: Geçersiz amount değeri girildi: ' .. tostring(amount))
            end
        else
            print(('[addGymStat]-[HATA]: ID bulunamadı veya veritabanı sorgusu başarısız oldu. PlayerID: %s'):format(identifier or 'nil'))
        end
    else
        print('[removeGymStat]-[HATA]: SQLModule bulunamadı.')
    end
end)

exports('checkGymStat', function(id)
    local sqlModule

    if NMConfig['SQL'].oxmysql then
        sqlModule = exports.oxmysql
    elseif NMConfig['SQL'].ghmattimysql then
        sqlModule = exports.ghmattimysql
    end

    if sqlModule then
        local identifier = exports['nproblem-boxing']:bvmjKE4qRM8GKE6hAPfSIBEsa8xy4xfq(framework, tonumber(id))
        local result = sqlModule:executeSync('SELECT gymStats FROM nm_boxing_fighters WHERE playerID = ?', {identifier})

        if result and result[1] then
            return tonumber(result[1].gymStats) or 0
        else
            print(('[checkGymStat]-[HATA]: Oyuncu bulunamadı. PlayerID: %s'):format(identifier or 'nil'))
            return nil
        end
    else
        print('[removeGymStat]-[HATA]: SQLModule bulunamadı.')
    end
end)


exports('removeGymStat', function(id, amount)
    local sqlModule

    if NMConfig['SQL'].oxmysql then
        sqlModule = exports.oxmysql
    elseif NMConfig['SQL'].ghmattimysql then
        sqlModule = exports.ghmattimysql
    end

    if sqlModule then
        local identifier = exports['nproblem-boxing']:bvmjKE4qRM8GKE6hAPfSIBEsa8xy4xfq(framework, tonumber(id))
        local result = sqlModule:executeSync('SELECT gymStats FROM nm_boxing_fighters WHERE playerID = ?', {identifier})

        if result and result[1] then
            local currentStat = tonumber(result[1].gymStats) or 0
            local decreaseAmount = tonumber(amount)

            if decreaseAmount and decreaseAmount > 0 then
                local newStat = math.max(currentStat - decreaseAmount, 0)
                sqlModule:execute('UPDATE nm_boxing_fighters SET gymStats = ? WHERE playerID = ?', {newStat, identifier})
            else
                print('[removeGymStat]-[HATA]: Geçersiz amount değeri: ' .. tostring(amount))
            end
        else
            print(('[removeGymStat]-[HATA]: Oyuncu bulunamadı. PlayerID: %s'):format(identifier or 'nil'))
        end
    else
        print('[removeGymStat]-[HATA]: SQLModule bulunamadı.')
    end
end)

