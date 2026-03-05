function GetPlayerPermissionsControl(playersource)
	local playerallowed = false
	if Config.GratfitiPermissionsSettings.acepermissionsforspraygraffiti.enable == true then
		if IsPlayerAceAllowed(playersource, Config.GratfitiPermissionsSettings.acepermissionsforspraygraffiti.permission) then 
			playerallowed = true
		end
	end
	if Config.GratfitiPermissionsSettings.jobpermissionsforspraygraffiti.enable == true then
		if Config.Framework == "esx" then
			local xPlayer = ESX.GetPlayerFromId(playersource)
			if xPlayer then
				if xPlayer.job.name == Config.GratfitiPermissionsSettings.jobpermissionsforspraygraffiti.jobname then
					playerallowed = true
				end
			end
		elseif Config.Framework == "qbcore" then
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then	
				if xPlayer.PlayerData.job.name == Config.GratfitiPermissionsSettings.jobpermissionsforspraygraffiti.jobname then
					playerallowed = true
				end
			end
		elseif Config.Framework == "standalone" then
			-- add here your job check function
		end
	end	
	if Config.GratfitiPermissionsSettings.identifierspermissionsforgraffitiuse == true then
		local licensedata = "unknown"
		local steamdata = "unknown"
		local xboxdata = "unknown"
		local livedata = "unknown"
		local discorddata = "unknown"
		local ipdata = "unknown"
		for i, licensehandler in ipairs(GetPlayerIdentifiers(playersource)) do
			if string.sub(licensehandler, 1,string.len("steam:")) == "steam:" then
				steamdata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("license:")) == "license:" then
				licensedata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("live:")) == "live:" then
				livedata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("xbl:")) == "xbl:" then
				xboxdata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("discord:")) == "discord:" then
				discorddata = tostring(licensehandler)
			elseif string.sub(licensehandler, 1,string.len("ip:")) == "ip:" then
				ipdata = tostring(licensehandler)
			end
		end			
		for i, permissionhandler in ipairs(Config.GratfitiPermissionsSettings.permissionsviaidentifiers) do
			if permissionhandler.permissiontype == "license" then
				if permissionhandler.permisisondata == licensedata then
					playerallowed = true
					break
				end
			end
			if permissionhandler.permissiontype == "steam" then
				if permissionhandler.permisisondata == steamdata then
					playerallowed = true
					break
				end
			end	
			if permissionhandler.permissiontype == "xbox" then
				if permissionhandler.permisisondata == xboxdata then
					playerallowed = true
					break
				end
			end	
			if permissionhandler.permissiontype == "live" then
				if permissionhandler.permisisondata == livedata then
					playerallowed = true
					break
				end
			end	
			if permissionhandler.permissiontype == "discord" then
				if permissionhandler.permisisondata == discorddata then
					playerallowed = true
					break
				end
			end		
			if permissionhandler.permissiontype == "ip" then
				if permissionhandler.permisisondata == ipdata then
					playerallowed = true
					break
				end
			end							
		end
	end		
	return playerallowed
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


function RemoveGraffitiItem(playersource, itemname)
	local removed = false
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			local itemdata = xPlayer.getInventoryItem(itemname)
			if itemdata.count >= 1 then				
				xPlayer.removeInventoryItem(itemname, 1)	
				removed = true
			end
		end		
	end
	if Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			if Config.QBCoreNewInventoryVersion == true then
				local hasItem = exports['qb-inventory']:HasItem(playersource, itemname, 1)
				if hasItem then			
					exports['qb-inventory']:RemoveItem(playersource, itemname, 1, false, 'qb-inventory:testRemove')
					removed = true
				end				
			else
				if xPlayer.Functions.GetItemByName(itemname).amount >= 1 then
					xPlayer.Functions.RemoveItem(itemname, 1, false, {})
					removed = true
				end
			end
		end		
	end		
	if Config.Framework == "standalone" then
		removed = true
	end
	return removed
end


function CheckItemRequirment(playersource, itemname)
	local itemhave = false
	if Config.Framework == "esx" then
		local xPlayer = ESX.GetPlayerFromId(playersource)
		if xPlayer then
			local itemdata = xPlayer.getInventoryItem(itemname)
			if itemdata.count >= 1 then				
				itemhave = true
			end
		end		
	end
	if Config.Framework == "qbcore" then
		local xPlayer = QBCore.Functions.GetPlayer(playersource)
		if xPlayer then	
			if Config.QBCoreNewInventoryVersion == true then
				local hasItem = exports['qb-inventory']:HasItem(playersource, itemname, 1)
				if hasItem then			
					itemhave = true
				end				
			else
				if xPlayer.Functions.GetItemByName(itemname).amount >= 1 then
					itemhave = true
				end
			end
		end	
	end
	if Config.Framework == "standalone" then	
		itemhave = true
	end		
	return itemhave
end


function SprayRequirment(playersource)
	local sprayrequirment = false
	if Config.GraffitiItemEnable == true then
		sprayrequirment = CheckItemRequirment(playersource, Config.GraffitiItemSpray)
	else
		sprayrequirment = true
	end
	if Config.GraffitiOnlyForPeopleWithPermission == true then
		sprayrequirment = GetPlayerPermissionsControl(playersource)
	end
	return sprayrequirment
end

function RemoveSprayRequirment(playersource)
	local sprayrequirment = false
	if Config.GraffitiRemoveItemNeeded == false then
		sprayrequirment = true
	else
		sprayrequirment = CheckItemRequirment(playersource, Config.GraffitiItemRemove)
	end
	if Config.GraffitiOnlyForPeopleWithPermission == true then
		sprayrequirment = GetPlayerPermissionsControl(playersource)
	end	
	return sprayrequirment
end

function GetPlayerNameRTX(playersource)
	return GetPlayerName(playersource)
end

function CheckGraffitiRemovePermission(playersource)
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
		permission = false
	end	
	return permission
end

function CheckGraffitiPermission(playersource)
	local permission = false
	if Config.GraffitiOnlyForPeopleWithPermission == true then
		permission = GetPlayerPermissionsControl(playersource)
	else
		permission = true
	end
	return permission
end

if Config.GraffitiItemEnable == true then
	if Config.Framework == "esx" then
		ESX.RegisterUsableItem(Config.GraffitiItemSpray, function(source)
			local playersource = source
			TriggerClientEvent("rtx_graffiti:OpenGraffiti", playersource)
		end)
		ESX.RegisterUsableItem(Config.GraffitiItemRemove, function(source)
			local playersource = source
			TriggerClientEvent("rtx_graffiti:GraffitiClean", playersource)
		end)		
	end

	if Config.Framework == "qbcore" then

		QBCore.Functions.CreateUseableItem(Config.GraffitiItemSpray, function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then		
				TriggerClientEvent("rtx_graffiti:OpenGraffiti", playersource)
			end
		end)
		QBCore.Functions.CreateUseableItem(Config.GraffitiItemRemove, function(source, item)
			local playersource = source
			local xPlayer = QBCore.Functions.GetPlayer(playersource)
			if xPlayer then		
				TriggerClientEvent("rtx_graffiti:GraffitiClean", playersource)
			end
		end)
	end
end


AddEventHandler("rtx_graffiti:Global:GraffitiSprayHandler", function(playersource, graffiticoords)
	
end)

if Config.GraffitiWebhook then
	local webhookurl = "" --write webhookurl here
	local iconurl = "https://i.imgur.com/3snGmGq.png" -- put your icon for webhok here
	local titletext = "Graffiti Log"
	
	function GraffitiWebhook(playersource, graffitiid, graffiticoords, graffiticreatedate, imagedata, imglinktype)
		TriggerEvent("rtx_graffiti:Global:GraffitiSprayHandler", playersource, graffiticoords)
		-- playesource is source of player	
		local identifier = "no info" 
		local license   = "no info"
		local liveid    = "no info"
		local xblid     = "no info"
		local discord   = "no info"
		local playerip = "no info"         
		local sourceplayername = GetPlayerName(playersource)
		for k,v in ipairs(GetPlayerIdentifiers(playersource))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				identifier = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("live:")) == "live:" then
				liveid = v
			elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
				xblid  = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
				discord = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
				playerip = v
			end
		end		
		if imglinktype == false then
			local logtextdata = "**Player:** " ..tostring(sourceplayername).. "\n**Identifier:** " ..tostring(identifier).. "\n**License:** " ..tostring(license).. "\n**LiveID:** " ..tostring(liveid).. "\n**XboxID:** " ..tostring(xblid).. "\n**Discord:** " ..tostring(discord).. "\n**IP:** " ..tostring(playerip).. "\n**Graffiti ID:** " ..tostring(graffitiid).. "\n**Graffiti Coords:** " ..tostring(graffiticoords).. "\n**Create date:** " ..tostring(graffiticreatedate).. ""
			local embed = {
				{
					["title"] = titletext,
					["type"] = "rich",
					["description"] = logtextdata,
					["color"] = 16738047,
					["footer"] = {
						["text"] = "Made by Kanikuly#7253 Provided by RTX Development discord.gg/P6KdaDpgAk | " .. os.date("%x (%X %p)"),
						["icon_url"] = iconurl
					},
				}
			}

			PerformHttpRequest(webhookurl, function(err, text, headers) end, "POST", json.encode({username = name, embeds = embed}), { ["Content-Type"] = "application/json" })		
		else
			local logtextdata = "**Player:** " ..tostring(sourceplayername).. "\n**Identifier:** " ..tostring(identifier).. "\n**License:** " ..tostring(license).. "\n**LiveID:** " ..tostring(liveid).. "\n**XboxID:** " ..tostring(xblid).. "\n**Discord:** " ..tostring(discord).. "\n**IP:** " ..tostring(playerip).. "\n**Graffiti ID:** " ..tostring(graffitiid).. "\n**Graffiti Coords:** " ..tostring(graffiticoords).. "\n**Create date:** " ..tostring(graffiticreatedate).. ""
			local embed = {
				{
					["title"] = titletext,
					["type"] = "rich",
					["description"] = logtextdata,
					["color"] = 16738047,
					["image"] = {
						["url"] = imagedata  -- This adds the image URL to the embed
					},					
					["footer"] = {
						["text"] = "Made by Kanikuly#7253 Provided by RTX Development discord.gg/P6KdaDpgAk | " .. os.date("%x (%X %p)"),
						["icon_url"] = iconurl
					},
				}
			}

			PerformHttpRequest(webhookurl, function(err, text, headers) end, "POST", json.encode({username = name, embeds = embed}), { ["Content-Type"] = "application/json" })		
		end
	end
end