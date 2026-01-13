function AddMoneyRTX(playersource, moneydata)
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			xPlayer.addMoney(moneydata)
		end
	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			xPlayer.Functions.AddMoney('cash', moneydata)
		end
	elseif Config.Framework == "standalone" then
		-- add here money add funciton	
	end
end	

function RemoveMoneyRTX(playersource, moneydata)
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			xPlayer.removeMoney(moneydata)
		end
	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			xPlayer.Functions.RemoveMoney('cash', moneydata)	
		end
	elseif Config.Framework == "standalone" then
		-- add here money remove funciton	
	end
end	

function GetMoneyRTX(playersource)
	local moneydata = 0
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			moneydata = xPlayer.getMoney()
		end
	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			moneydata = xPlayer.Functions.GetMoney('cash')
		end
	elseif Config.Framework == "standalone" then
		moneydata = 99999999999
		-- add here money get funciton	
	end
	return moneydata
end	

function GiveShootingRangeRewardToPlayer(playersource, prizeiddata)
	local prizegamehandler = Config.ShootingRangePrizes[prizeiddata]
	if prizegamehandler.prizetype == "money" then
		AddMoneyRTX(playersource, prizegamehandler.prizedata)
		TriggerClientEvent("rtx_spawnableattractions:Notify", playersource, LanguageFile("prizerewardmoney", prizegamehandler.prizedata))
	end
end

function GetPlayerIdentifierRTX(playersource)
	local playeridentifierdata = ""
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			playeridentifierdata = xPlayer.identifier
		end
	elseif Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			playeridentifierdata = xPlayer.PlayerData.citizenid
		end
	elseif Config.Framework == "standalone" then
		playeridentifierdata = GetPlayerIdentifiers(playersource)[1]	
	end
	return playeridentifierdata
end