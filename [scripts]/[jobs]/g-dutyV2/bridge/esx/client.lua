---@diagnostic disable: duplicate-set-field, missing-fields
if GetResourceState("es_extended") ~= "started" then
	return
end

ESX = exports.es_extended:getSharedObject()

G = {}
G.playerLoaded = false
G.playerData = {}
local isDead

local function LoadPlayerData()
	local attempts = 0
	while attempts < 10 do
		local xPlayer = ESX.GetPlayerData()
		if xPlayer and xPlayer.job then
			G.playerData = xPlayer
			G.playerLoaded = true
			break
		end
		attempts = attempts + 1
		Wait(1000)
	end
end

-- Event handlers

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer, isNew, skin)
	G.playerData = ESX.GetPlayerData()
	G.playerLoaded = true
	TriggerServerEvent("justgroot:g-dutyv2:playerloaded")
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	G.playerData.job = job
	Changed(job)
end)

AddEventHandler("esx:onPlayerDeath", function(data)
	isDead = true
end)

AddEventHandler("esx:onPlayerSpawn", function(noAnim)
	isDead = nil
end)

RegisterNetEvent("esx:onPlayerLogout")
AddEventHandler("esx:onPlayerLogout", function()
	G.playerLoaded = false
	---@diagnostic disable-next-line: missing-fields
	G.playerData = {}
end)

 
function G.GetCore()
	return ESX
end

function G.GetPlayerData()
	local pdata = ESX.GetPlayerData()
	return pdata
end

function G.isPlayerDead()
	return isDead
end

function G.GetPlayerJob()
	local playerData = ESX.GetPlayerData()
	if not playerData or not playerData.job then
		return nil
	end
	return {
		name = playerData.job.name,
		label = playerData.job.label,
		grade_name = playerData.job.grade_name,
		grade_label = playerData.job.grade_label,
		grade_salary = playerData.job.grade_salary,
		grade = playerData.job.grade,
		isboss = playerData.job.grade_name == "boss" or false,
		onduty = playerData.job.onDuty,
	}
end

CreateThread(function()
	LoadPlayerData()
end)
