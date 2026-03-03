if Config.framework ~= 'esx' then

    QBCore = exports['qb-core']:GetCoreObject()

    if QBCore.Functions.GetPlayerData() and QBCore.Functions.GetPlayerData().job then
        playerJob = QBCore.Functions.GetPlayerData().job.name
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        playerJob = QBCore.Functions.GetPlayerData().job.name
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        playerJob = JobInfo.name
    end)
end
