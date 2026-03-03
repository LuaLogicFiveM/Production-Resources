if GetResourceState('qb-core') ~= 'started' then return end

local settings = require 'config.config'
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = nil

-- for script restart --
if LocalPlayer.state.isLoggedIn then
    Citizen.SetTimeout(500, function()
        exports['sh-k9']:CheckThreads()
    end)
end

-- events --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    exports['sh-k9']:CompleteCleanUp()
    exports['sh-k9']:CheckThreads()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)   

-- functions --
function IsDead()
    return PlayerData.metadata['isdead'] or PlayerData.metadata['inlaststand']
end