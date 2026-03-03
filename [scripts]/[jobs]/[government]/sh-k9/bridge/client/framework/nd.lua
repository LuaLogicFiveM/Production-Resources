if GetResourceState('ND_Core') ~= 'started' then return end

-- for script restart -- 
local PlayerData = exports.ND_Core:getPlayer()

if PlayerData then
    Citizen.SetTimeout(500, function()
        exports['sh-k9']:CheckThreads()
    end)
end

-- events
RegisterNetEvent('ND:characterLoaded', function(character)
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('ND:characterUnloaded', function()
    exports['sh-k9']:CompleteCleanUp()
    exports['sh-k9']:CheckThreads()
end)

RegisterNetEvent('ND:updateCharacter', function(character)
    exports['sh-k9']:CheckThreads()
end)

-- functions --
function IsDead()
    return LocalPlayer.state.dead
end