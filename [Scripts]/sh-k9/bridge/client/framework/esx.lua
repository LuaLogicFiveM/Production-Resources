if GetResourceState('es_extended') ~= 'started' then return end

-- for script restart
local ESX = exports['es_extended']:getSharedObject()

if ESX.PlayerLoaded then
    Citizen.SetTimeout(500, function()
        exports['sh-k9']:CheckThreads()
    end)
end

-- events -- 
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    exports['sh-k9']:CompleteCleanUp()
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('esx:setJob', function(job)
    exports['sh-k9']:CheckThreads()
end)

-- functions --
function IsDead()
    return PlayerData.dead
end