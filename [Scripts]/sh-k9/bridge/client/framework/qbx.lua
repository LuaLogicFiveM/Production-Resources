if GetResourceState('qbx_core') ~= 'started' then return end

-- for script restart --  
if LocalPlayer.state.isLoggedIn then
    Citizen.SetTimeout(500, function()
        exports['sh-k9']:CheckThreads()
    end)
end

-- events --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    exports['sh-k9']:CompleteCleanUp()
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    exports['sh-k9']:CheckThreads()
end)

-- functions --
function IsDead()
    return QBX.PlayerData.metadata['isdead'] or QBX.PlayerData.metadata['inlaststand']
end