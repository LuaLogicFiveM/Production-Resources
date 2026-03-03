if 
    GetResourceState('es_extended') == 'started' or 
    GetResourceState('qb-core') == 'started' or
    GetResourceState('qbx_core') == 'started' or
    GetResourceState('ND_Core') == 'started' 
then 
    return 
end

-- threads --
CreateThread(function()
	while true do
		Wait(1000)

		if NetworkIsSessionStarted() then
			return exports['sh-k9']:CheckThreads()
		end
	end
end)

-- functions --
function IsDead()
    return IsEntityDead(cache.ped)
end