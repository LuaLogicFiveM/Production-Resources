function checkYachtExistence(yachtId, callback)
    local query = "SELECT COUNT(*) as count FROM yachts WHERE yachtid = @yachtid"
    
    local params = { ['@yachtid'] = yachtId }
    
    MySQL.Async.execute(query, params, function(result)
        if result and result[1] and result[1].count then
            local count = result[1].count
            
            if count > 0 then
                callback(true) 
            else
                callback(false) 
            end
        else
            callback(false)
        end
    end)
end

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

function GetPlayerIdentifierRTX(playersource)
	local playeridentifierdata = ""
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			playeridentifierdata = xPlayer.identifier
		else
			playeridentifierdata = GetPlayerIdentifiers(playersource)[1]	
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

function GetPlayerNameRTX(playersource)
	return GetPlayerName(playersource)
end

function CheckYachtGivePermission(playersource)
	local permission = false
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		local playergroup = xPlayer.getGroup()
		if playergroup == "admin" or playergroup == "superadmin" then
			permission = true
		end
	elseif Config.Framework == "qbcore" then
		if QBCore.Functions.HasPermission(playersource, 'admin') or QBCore.Functions.HasPermission(playersource, 'god') then
			permission = true
		end
	elseif Config.Framework == "standalone" then
		-- configure your permissions here
	end	
	return permission
end


function RegisterStorages(yachtiddata)
	if Config.InventorySystem == "oxinventory" then
		if Config.OxInventory == true then
			for i, yachstoragehandler in pairs(Config.YachtStorageLocations) do	
				local stash = {
					id = 'yacht-'..yachtiddata..'-storage-'..i..'',
					label = 'Yacht Storage - '..i..'',
					slots = 50,
					weight = 100000,
					owner = false,
				}	
				exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
			end	
		end
	elseif Config.InventorySystem == "qbcoreinventory" then		
		RegisterServerEvent("rtx_yacht:Global:OpenStorageQB", function(storagenamedata)
			local playersource = source
			local data = { label = storagenamedata, maxweight = 400000, slots = 500 }
			exports['qb-inventory']:OpenInventory(playersource, storagenamedata, data)
		end)	
	end	
end

RegisterCommand(Config.GiveYachtCommand, function(source, args, rawCommand)
	local playersource = source
	if playersource == 0 then
		if args[1] ~= nil then
			local reformatedplayerid = tonumber(args[1]) 
			if args[2] ~= nil and args[3] ~= nil and args[4] ~= nil and args[5] ~= nil and args[6] ~= nil and args[7] ~= nil and args[8] ~= nil and args[9] ~= nil then
				local allowedyacht = true
				local flagiddata = tonumber(args[2])
				if flagiddata >= 1 or flagiddata <= 46 then
				else
					allowedyacht = false
				end
				local lightingcategorydata = tonumber(args[3])
				if lightingcategorydata == 1 or lightingcategorydata == 2 then
				else
					allowedyacht = false
				end		
				local lightingiddata = tonumber(args[4])
				if lightingiddata >= 1 or lightingiddata <= 8 then
				else
					allowedyacht = false
				end	
				local uppertextdata = tostring(args[5])
				if uppertextdata ~= nil then
				else
					allowedyacht = false
				end		
				local bottomtextdata = tostring(args[6])
				if bottomtextdata ~= nil then
				else
					allowedyacht = false
				end	
				local railingiddata = tonumber(args[7])
				if railingiddata == 1 or railingiddata == 2 then
				else
					allowedyacht = false
				end		
				local coloriddata = tonumber(args[8])
				if coloriddata >= 1 or coloriddata <= 16 then
				else
					allowedyacht = false
				end		
				local equipmentiddata = tonumber(args[9])
				if equipmentiddata == 1 or equipmentiddata == 2 then
				else
					allowedyacht = false
				end			
				if allowedyacht then
					local yachtfound, freeCoords, freeRotation = findFreeYachtSpawn(yachts)
					if yachtfound == true then					
						CreateYachtCommand(reformatedplayerid, freeCoords, freeRotation, flagiddata, {category = lightingcategorydata, id = lightingiddata}, {uppertext = uppertextdata, bottomtext = bottomtextdata}, railingiddata, coloriddata, equipmentiddata)
						print(LanguageFile("yachtgive", GetPlayerNameRTX(reformatedplayerid)))
					end	
				else
					print(Language[Config.Language]["definedata"])
				end
			end
		else
			print(Language[Config.Language]["idplayer"])
		end
	else
		local checkpermission = CheckYachtGivePermission(playersource)
		if checkpermission == true then
			if args[1] ~= nil then
				local reformatedplayerid = tonumber(args[1]) 
				if args[2] ~= nil and args[3] ~= nil and args[4] ~= nil and args[5] ~= nil and args[6] ~= nil and args[7] ~= nil and args[8] ~= nil and args[9] ~= nil then
					local allowedyacht = true
					local flagiddata = tonumber(args[2])
					if flagiddata >= 1 or flagiddata <= 46 then
					else
						allowedyacht = false
					end
					local lightingcategorydata = tonumber(args[3])
					if lightingcategorydata == 1 or lightingcategorydata == 2 then
					else
						allowedyacht = false
					end		
					local lightingiddata = tonumber(args[4])
					if lightingiddata >= 1 or lightingiddata <= 8 then
					else
						allowedyacht = false
					end	
					local uppertextdata = tostring(args[5])
					if uppertextdata ~= nil then
					else
						allowedyacht = false
					end		
					local bottomtextdata = tostring(args[6])
					if bottomtextdata ~= nil then
					else
						allowedyacht = false
					end	
					local railingiddata = tonumber(args[7])
					if railingiddata == 1 or railingiddata == 2 then
					else
						allowedyacht = false
					end		
					local coloriddata = tonumber(args[8])
					if coloriddata >= 1 or coloriddata <= 16 then
					else
						allowedyacht = false
					end		
					local equipmentiddata = tonumber(args[9])
					if equipmentiddata == 1 or equipmentiddata == 2 then
					else
						allowedyacht = false
					end			
					if allowedyacht then
						local yachtfound, freeCoords, freeRotation = findFreeYachtSpawn(yachts)
						if yachtfound == true then	
							CreateYachtCommand(reformatedplayerid, freeCoords, freeRotation, flagiddata, {category = lightingcategorydata, id = lightingiddata}, {uppertext = uppertextdata, bottomtext = bottomtextdata}, railingiddata, coloriddata, equipmentiddata)
							TriggerClientEvent("rtx_yacht:Notify", playersource, LanguageFile("yachtgive", GetPlayerNameRTX(reformatedplayerid)))
						end	
					else
						TriggerClientEvent("rtx_yacht:Notify", playersource, Language[Config.Language]["definedata"])
					end
				end
			else
				TriggerClientEvent("rtx_yacht:Notify", playersource, Language[Config.Language]["idplayer"])
			end		
		end
	end
end)

RegisterCommand(Config.GiveYachtIdentifierCommand, function(source, args, rawCommand)
	local playersource = source
	if playersource == 0 then
		if args[1] ~= nil then
			local reformatedplayeridentifierdata = tostring(args[1]) 
			if args[2] ~= nil and args[3] ~= nil and args[4] ~= nil and args[5] ~= nil and args[6] ~= nil and args[7] ~= nil and args[8] ~= nil and args[9] ~= nil then
				local allowedyacht = true
				local flagiddata = tonumber(args[2])
				if flagiddata >= 1 or flagiddata <= 46 then
				else
					allowedyacht = false
				end
				local lightingcategorydata = tonumber(args[3])
				if lightingcategorydata == 1 or lightingcategorydata == 2 then
				else
					allowedyacht = false
				end		
				local lightingiddata = tonumber(args[4])
				if lightingiddata >= 1 or lightingiddata <= 8 then
				else
					allowedyacht = false
				end	
				local uppertextdata = tostring(args[5])
				if uppertextdata ~= nil then
				else
					allowedyacht = false
				end		
				local bottomtextdata = tostring(args[6])
				if bottomtextdata ~= nil then
				else
					allowedyacht = false
				end	
				local railingiddata = tonumber(args[7])
				if railingiddata == 1 or railingiddata == 2 then
				else
					allowedyacht = false
				end		
				local coloriddata = tonumber(args[8])
				if coloriddata >= 1 or coloriddata <= 16 then
				else
					allowedyacht = false
				end		
				local equipmentiddata = tonumber(args[9])
				if equipmentiddata == 1 or equipmentiddata == 2 then
				else
					allowedyacht = false
				end			
				if allowedyacht then
					local yachtfound, freeCoords, freeRotation = findFreeYachtSpawn(yachts)
					if yachtfound == true then				
						CreateYachtCommand(reformatedplayeridentifierdata, freeCoords, freeRotation, flagiddata, {category = lightingcategorydata, id = lightingiddata}, {uppertext = uppertextdata, bottomtext = bottomtextdata}, railingiddata, coloriddata, equipmentiddata)
						print(LanguageFile("yachtgive", reformatedplayeridentifierdata))
					end	
				else
					print(Language[Config.Language]["definedata"])
				end
			end
		else
			print(Language[Config.Language]["identifierplayer"])
		end
	else
		local checkpermission = CheckYachtGivePermission(playersource)
		if checkpermission == true then
			if args[1] ~= nil then
				local reformatedplayeridentifierdata = tostring(args[1]) 
				if args[2] ~= nil and args[3] ~= nil and args[4] ~= nil and args[5] ~= nil and args[6] ~= nil and args[7] ~= nil and args[8] ~= nil and args[9] ~= nil then
					local allowedyacht = true
					local flagiddata = tonumber(args[2])
					if flagiddata >= 1 or flagiddata <= 46 then
					else
						allowedyacht = false
					end
					local lightingcategorydata = tonumber(args[3])
					if lightingcategorydata == 1 or lightingcategorydata == 2 then
					else
						allowedyacht = false
					end		
					local lightingiddata = tonumber(args[4])
					if lightingiddata >= 1 or lightingiddata <= 8 then
					else
						allowedyacht = false
					end	
					local uppertextdata = tostring(args[5])
					if uppertextdata ~= nil then
					else
						allowedyacht = false
					end		
					local bottomtextdata = tostring(args[6])
					if bottomtextdata ~= nil then
					else
						allowedyacht = false
					end	
					local railingiddata = tonumber(args[7])
					if railingiddata == 1 or railingiddata == 2 then
					else
						allowedyacht = false
					end		
					local coloriddata = tonumber(args[8])
					if coloriddata >= 1 or coloriddata <= 16 then
					else
						allowedyacht = false
					end		
					local equipmentiddata = tonumber(args[9])
					if equipmentiddata == 1 or equipmentiddata == 2 then
					else
						allowedyacht = false
					end			
					if allowedyacht then
						local yachtfound, freeCoords, freeRotation = findFreeYachtSpawn(yachts)
						if yachtfound == true then		
							CreateYachtIdentifier(reformatedplayeridentifierdata, freeCoords, freeRotation, flagiddata, {category = lightingcategorydata, id = lightingiddata}, {uppertext = uppertextdata, bottomtext = bottomtextdata}, railingiddata, coloriddata, equipmentiddata)
							TriggerClientEvent("rtx_yacht:Notify", playersource, LanguageFile("yachtgive", reformatedplayeridentifierdata))
						end	
					else
						TriggerClientEvent("rtx_yacht:Notify", playersource, Language[Config.Language]["definedata"])
					end
				end
			else
				TriggerClientEvent("rtx_yacht:Notify", playersource, Language[Config.Language]["identifierplayer"])
			end		
		end
	end
end)