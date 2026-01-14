RegisterServerEvent("lorp_heliforward.spotlight")
AddEventHandler("lorp_heliforward.spotlight", function(state)
	local serverID = source
	TriggerClientEvent("lorp_heliforward.spotlight", -1, serverID, state)
end)

RegisterServerEvent("lorp_helitracking.spotlight")
AddEventHandler("lorp_helitracking.spotlight", function(target_netID, target_plate, targetposx, targetposy, targetposz)
	local serverID = source
	TriggerClientEvent("lorp_heliTspotlight", -1, serverID, target_netID, target_plate, targetposx, targetposy, targetposz)
end)

RegisterServerEvent("lorp_helitracking.spotlight.toggle")
AddEventHandler("lorp_helitracking.spotlight.toggle", function()
	local serverID = source
	TriggerClientEvent("lorp_heliTspotlight.toggle", -1, serverID)
end)

RegisterServerEvent("lorp_helipause.tracking.spotlight")
AddEventHandler("lorp_helipause.tracking.spotlight", function(pause_Tspotlight)
	local serverID = source
	TriggerClientEvent("lorp_helipause.Tspotlight", -1, serverID, pause_Tspotlight)
end)

RegisterServerEvent("lorp_helimanual.spotlight")
AddEventHandler("lorp_helimanual.spotlight", function()
	local serverID = source
	TriggerClientEvent("lorp_heliMspotlight", -1, serverID)
end)

RegisterServerEvent("lorp_helimanual.spotlight.toggle")
AddEventHandler("lorp_helimanual.spotlight.toggle", function()
	local serverID = source
	TriggerClientEvent("lorp_heliMspotlight.toggle", -1, serverID)
end)

RegisterServerEvent("lorp_helilight.up")
AddEventHandler("lorp_helilight.up", function()
	local serverID = source
	TriggerClientEvent("lorp_helilight.up", -1, serverID)
end)

RegisterServerEvent("lorp_helilight.down")
AddEventHandler("lorp_helilight.down", function()
	local serverID = source
	TriggerClientEvent("lorp_helilight.down", -1, serverID)
end)

RegisterServerEvent("lorp_heliradius.up")
AddEventHandler("lorp_heliradius.up", function()
	local serverID = source
	TriggerClientEvent("lorp_heliradius.up", -1, serverID)
end)

RegisterServerEvent("lorp_heliradius.down")
AddEventHandler("lorp_heliradius.down", function()
	local serverID = source
	TriggerClientEvent("lorp_heliradius.down", -1, serverID)
end)

RegisterServerEvent("0r-helicam:Server:SyncMarkerBlips")
AddEventHandler("0r-helicam:Server:SyncMarkerBlips", function(markers)
	TriggerClientEvent("0r-helicam:Client:SyncMarkerBlips", -1, markers)
end)
