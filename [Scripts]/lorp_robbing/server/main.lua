local StealablePlayers = {}
local ActiveRobberies = {}
local Cooldowns = {}

local function GetClosestTarget(playerId)
	local result = {}
    local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
    local playerTarget = lib.getClosestPlayer(playerCoords, Config.Settings["MaxDistance"], playerId)
    local playerBucket = GetPlayerRoutingBucket(playerId)
    local busy = false

    for _,v in pairs(ActiveRobberies) do
        if v == playerTarget then
            busy = true
        end
    end

    if not busy then
        if Framework.Functions.CanPlayerBeStolen(playerTarget) and StealablePlayers[tostring(playerTarget)] then
            if GetPlayerRoutingBucket(playerTarget) == playerBucket then
                local targetEntity = GetPlayerPed(playerTarget)
                local targetCoords = GetEntityCoords(targetEntity)
                result = {id = playerTarget, ped = NetworkGetNetworkIdFromEntity(targetEntity), coords = targetCoords, dist = #(playerCoords - targetCoords)}
            end
        end
    end

	return result
end

function IsItemBlacklisted(itemName, itemCount)
    local itemLimited = Config.Blacklisted["Inventory"][itemName] or itemCount
    local isBlacklisted = itemLimited == 0
    local count = 0

    if itemLimited <= itemCount then
        count = itemLimited
    elseif itemLimited > itemCount then
        count = itemCount
    end

    return isBlacklisted, count
end

RegisterServerEvent('lorp_robbing:server:state')
AddEventHandler('lorp_robbing:server:state', function(hasHandsUp)
    local playerId = tostring(source)

    if not StealablePlayers[playerId] and hasHandsUp then
        StealablePlayers[playerId] = true
    elseif StealablePlayers[playerId] and not hasHandsUp then
        StealablePlayers[playerId] = nil
    end

    TriggerClientEvent('lorp_robbing:client:confirmState', playerId, hasHandsUp)
end)

RegisterServerEvent('lorp_robbing:server:steal')
AddEventHandler('lorp_robbing:server:steal', function(itemName, itemAmount, itemData)
    local playerId = source

    if not ActiveRobberies[playerId] then Framework.Functions.BanPlayer(playerId) return end

    if Framework.Functions.StealItem(playerId, ActiveRobberies[playerId], itemName, itemAmount, itemData) then
        local targetPed = GetPlayerPed(ActiveRobberies[playerId])
        TaskPlayAnim(targetPed, 'anim@mugging@victim@toss_ped@', 'throw_object_right_pocket_female', 1.0, 2.0, 4000, 50, 0, false, false, false)
        Wait(4000)
        TriggerClientEvent('lorp_robbing:client:updateStatus', ActiveRobberies[playerId])
        if Config.Notifications["Steal"] then
            Framework.Functions.ShowNotification(playerId, Config["Messages"]["you_stole"].. " "..itemAmount.."x "..itemName.."")
            Framework.Functions.ShowNotification(ActiveRobberies[playerId], Config["Messages"]["thief_stole"].. " "..itemAmount.."x "..itemName.." " ..Config["Messages"]["from_you"])
        end
    else
        Framework.Functions.ShowNotification(playerId, Config["Messages"]["something_went_wrong"])
    end

    TriggerClientEvent('lorp_robbing:client:setupMenu', playerId, NetworkGetNetworkIdFromEntity(GetPlayerPed(ActiveRobberies[playerId])), Framework.Functions.GetTargetItems(ActiveRobberies[playerId]))
end)

RegisterServerEvent('lorp_robbing:server:request')
AddEventHandler('lorp_robbing:server:request', function()
    local playerId = source
    local ped = GetPlayerPed(playerId)

    if Cooldowns[Framework.Functions.GetIdentifier(playerId)] then Framework.Functions.ShowNotification(playerId, Config.Messages["cooldown"]) return end

    local isAreaWhitelisted = false
    local entityCoords = GetEntityCoords(ped)

	for k,v in pairs(Config.Whitelisted["Areas"]) do
		if #(entityCoords - v.coords) < v.range then
			isAreaWhitelisted = true
			break
		end
	end

	if not isAreaWhitelisted then return Framework.Functions.ShowNotification(playerId, Config.Messages["wrong_area"]) end

    local closestTarget = GetClosestTarget(playerId)

    if not DoesEntityExist(ped) then return end

    if not closestTarget.id then
        if Config.Notifications["NoPlayersNearby"] then
            Framework.Functions.ShowNotification(playerId, Config.Messages["no_players_nearby"])
        end
        return
    end

    if not DoesEntityExist(NetworkGetEntityFromNetworkId(closestTarget.ped)) then
        if Config.Notifications["NoPlayersNearby"] then
            Framework.Functions.ShowNotification(playerId, Config.Messages["no_players_nearby"])
        end
        return
    end

    ActiveRobberies[playerId] = closestTarget.id

    if Config.Settings["Cooldown"]["Enabled"] then
        Cooldowns[Framework.Functions.GetIdentifier(playerId)] = Config.Settings["Cooldown"]["Duration"]
    end

    TriggerClientEvent('lorp_robbing:client:updateState', ActiveRobberies[playerId], true, NetworkGetNetworkIdFromEntity(GetPlayerPed(playerId)))
    TriggerClientEvent('lorp_robbing:client:setupMenu', playerId, closestTarget.ped, Framework.Functions.GetTargetItems(ActiveRobberies[playerId]))
end)

RegisterServerEvent('lorp_robbing:server:stopRobbery')
AddEventHandler('lorp_robbing:server:stopRobbery', function()
    local playerId = source

    if ActiveRobberies[playerId] then
        TriggerClientEvent('lorp_robbing:client:reset', playerId)
        TriggerClientEvent('lorp_robbing:client:updateState', ActiveRobberies[playerId], false)
        ActiveRobberies[playerId] = nil
    end
end)

RegisterServerEvent('lorp_robbing:server:cancelRobbery')
AddEventHandler('lorp_robbing:server:cancelRobbery', function()
    local playerId = source

    for thief,target in pairs(ActiveRobberies) do
        if playerId == thief or playerId == target then
            TriggerClientEvent('lorp_robbing:client:reset', thief)
            TriggerClientEvent('lorp_robbing:client:updateState', target, false)
            ActiveRobberies[thief] = nil
            break
        end
    end
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    if ActiveRobberies[playerId] then
        TriggerClientEvent('lorp_robbing:client:updateState', ActiveRobberies[playerId], false)
        ActiveRobberies[playerId] = nil
    end
end)

if Config.Settings["Cooldown"]["Enabled"] then
    CreateThread(function()
        while true do
            Citizen.Wait(60000)
            for k,v in pairs(Cooldowns) do
                Cooldowns[k] = v - 1
                if Cooldowns[k] < 1 then
                    Cooldowns[k] = nil
                end
            end
        end
    end)
end