ESX = exports['es_extended']:getSharedObject()
PlayerData = {}
PlayerLoaded = false

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local data = ESX.GetPlayerData()
        if data and data.job then
            PlayerData = data
            PlayerLoaded = true
        end
    end
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded', function()
    while not ESX.GetPlayerData().job do Wait(1000) end
    PlayerData = ESX.GetPlayerData()
    PlayerLoaded = true
end)

RegisterNetEvent('esx:setPlayerData', function(key, val)
    PlayerData[key] = val
end)

GetJobName = function()
    return PlayerData.job and PlayerData.job.name
end

GetJobGrade = function()
    return PlayerData.job and PlayerData.job.grade
end

GetGangName = function()
    if GetResourceState('ak47_gangs') ~= 'missing' then
        local gang = exports['ak47_gangs']:GetPlayerGang()
        return gang and gang.tag
    end
    return nil
end

GetGangRank = function()
    if GetResourceState('ak47_gangs') ~= 'missing' then
        local gang = exports['ak47_gangs']:GetPlayerGang()
        return gang and gang.rankid
    end
    return nil
end

HasLicense = function(item, class)
    return lib.callback.await('ak47_idcardv2:haslicense', nil, item, class)
end
exports('HasLicense', HasLicense)

GetLicenseLabel = function(item)
    return Config.Cards[item] and Config.Cards[item].label
end
exports('GetLicenseLabel', GetLicenseLabel)