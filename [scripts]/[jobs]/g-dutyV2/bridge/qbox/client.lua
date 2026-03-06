---@diagnostic disable: duplicate-set-field, undefined-field, missing-fields
if GetResourceState("qbx_core") ~= "started" then
	return
end

QBox = exports.qbx_core

G = {}
G.playerLoaded = false
G.playerData = {}


RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	G.playerData = QBox.GetPlayerData()
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

function G.getCore()
	return QBox
end

function G.GetPlayerData()
	local pdata = QBox:GetPlayerData()
	return pdata
end

function G.isPlayerDead()
	return G.playerData.metadata and G.playerData.metadata.isdead or G.playerData.metadata.inlaststand
end

function G.GetPlayerJob()
	local playerData = G.GetPlayerData()
	if not playerData or not playerData.job then
		return nil
	end

	return {
		name = playerData.job.name or "",
		label = playerData.job.label or "",
		grade_name = playerData.job.grade.name or "",
		grade_label = playerData.job.grade.label or "",
		grade_salary = playerData.job.grade.payment or 0,
		grade = playerData.job.grade.level or 0,
		isboss = playerData.job.isboss or false,
		onduty = playerData.job.onduty or false,
	}
end
