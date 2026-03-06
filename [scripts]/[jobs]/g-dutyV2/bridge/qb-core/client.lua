---@diagnostic disable: duplicate-set-field, undefined-field
if GetResourceState("qb-core") ~= "started" then
	return
end

QBCore = exports["qb-core"]:GetCoreObject()
G = {}
G.playerLoaded = false
G.playerData = {}


-- Event handlers
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function(playerData)
	G.playerData = playerData or QBCore.Functions.GetPlayerData()
	G.playerLoaded = true
	TriggerServerEvent("justgroot:g-dutyv2:playerloaded")
end)



RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
	if G.playerData and G.playerData.job then
		G.playerData.job = job
		Changed(job)
	end
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(PlayerData)
	G.playerData = PlayerData
end)

function G.getCore()
	return QBCore
end

function G.GetPlayerData()
	local pdata = QBCore.Functions.GetPlayerData()
	return pdata
end

function G.isPlayerDead()
	
	if not G.playerLoaded then
		return
	end
	G.playerData = QBCore.Functions.GetPlayerData()
	return G.playerData.metadata.isdead or G.playerData.metadata.inlaststand
end

function G.GetPlayerJob()
	local playerData = QBCore.Functions.GetPlayerData()
	if not playerData or not playerData.job then
		return nil
	end
	if playerData.job then
		return {
			name = playerData.job.name,
			label = playerData.job.label,
			grade_name = playerData.job.grade,
			grade_label = playerData.job.grade.name,
			grade_salary = playerData.job.payment,
			grade = playerData.job.grade.level,
			isboss = playerData.job.isboss,
			onduty = playerData.job.onduty,
		}
	else
		return {}
	end
end
