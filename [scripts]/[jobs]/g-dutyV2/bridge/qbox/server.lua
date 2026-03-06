if GetResourceState("qbx_core") ~= "started" then
	return
end
---@diagnostic disable: duplicate-set-field
QBox = exports.qbx_core

G = {}
function G.GetCore()
	return QBox
end

function G.GetPlayer(source)
	return QBox:GetPlayer(source)
end

function G.GetPlayers()
	return QBox:GetQBPlayers()
end

function G.GetPlayerName(_source)
	local src = _source or source
	local playerData = G.GetPlayer(src).PlayerData
	if not playerData then
		return
	end
	return playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname
end

function G.GetIdentifier(src)
	local xPlayer = G.GetPlayer(src)
	if xPlayer then
		return xPlayer.PlayerData.citizenid
	end
	return nil
end

function G.AddItem(src, name, count, metadata)
	local _source = tonumber(src)
	local xPlayer = G.GetPlayer(_source)
	if xPlayer then
		xPlayer.Functions.AddItem(name, count, metadata)
	end
end

function G.RemoveItem(src, name, count)
	local _source = tonumber(src)
	local xPlayer = QBox:GetPlayer(_source)
	if xPlayer then
		xPlayer.Functions.RemoveItem(name, count)
	end
end

function G.PlayerJobinfo(src)
	local xPlayer = G.GetPlayer(src)
	xPlayer = xPlayer or QBox:GetPlayer(src)
	if not xPlayer then
		return nil
	end
	local j = xPlayer.PlayerData.job
	if not j then
		return nil
	end
	local jb = {
		name = j.name,
		label = j.label,
		grade = j.grade,
		gradeLabel = j.grade.name,
	}
	return jb
end

function G.AddMoney(src, type, count)
	local Player = G.GetPlayer(src)
	local accountTypes = { cash = "cash", bank = "bank", blackmoney = "crypto" }
	local account = accountTypes[type]

	if not Player then
		return false
	end

	if not account then
		return false
	end

	count = tonumber(count) or 0

	if count <= 0 then
		return false
	end

	QBox:AddMoney(src, account, count)
	return true
end



function G.GetInventoryItem(src, itemName)
	local count = G.Inventory.InventoryItem(src, itemName)
	if count and count > 0 then
		return {
			name = itemName,
			amount = count,
		}
	end
	return nil 
end

function G.NormalizeItem(item)
	return {
		name = item.name or item.item,
		amount = item.amount or item.count or 1,
	}
end

function G.GetInformationByIdentifier(identifier)
	local user = MySQL.Sync.fetchAll("SELECT * FROM players WHERE citizenid = ? LIMIT 1", { identifier })[1]
	if not user then
		return nil
	end

	user.charinfo = json.decode(user.charinfo or "{}")
	local jobInfo = json.decode(user.job or "{}")
	local jobGradeInfo = jobInfo.grade or {}

	local jobName = jobInfo.job or "unemployed"
	local jobGrade = tonumber(jobGradeInfo.level or 0)

	local jobs = exports.qbx_core:GetJobs()
	local jobData = jobs[jobName] or {}

	return {
		firstName = user.charinfo.firstname or "N/A",
		lastName = user.charinfo.lastname or " ",
		identifier = user.citizenid,
		job = {
			name = jobName,
			grade = jobGrade,
		},
		job_label = jobGradeInfo.name or "Unknown",
		job_name_label = jobData.label or "Unknown",
		sex = user.charinfo.gender == 0 and "male" or "female",
		ph = user.charinfo.phone or "N/A",
		dob = user.charinfo.birthdate or "N/A",
	}
end

function G.isPlayerOnlineAndOnduty(identifier)
	local players = G.GetPlayers()
	for _, xPlayer in pairs(players) do
		if xPlayer.PlayerData.citizenid == identifier and xPlayer.PlayerData.job.onduty then
			return true
		end
	end
	return false
end

function G.SetJob(src, onDuty)
	local Player = G.GetPlayer(src)
	if not Player then
		return
	end

	local job = Player.PlayerData.job
	local jobName, grade = job.name, job.grade

	QBox:SetJobDuty(src, onDuty)
	Wait(100)

	Player = G.GetPlayer(src)
	local newJob = Player.PlayerData.job
	DebugLog(
		("[g-dutyV2] %s is now %s duty as %s (Grade %s)"):format(
			GetPlayerName(src),
			newJob.onduty and "ON" or "OFF",
			newJob.label or newJob.name,
			newJob.grade.name or tostring(newJob.grade.level or newJob.grade)
		)
	)
end

function G.isOnDuty(src)
	local Player = G.GetPlayer(src)
	if not Player then
		return false
	end
	return Player.PlayerData.job.onduty or false
end

function G.isAllowed(src)
	local Player = G.GetPlayer(src)
	if not Player then
		return false
	end

	local job = Player.PlayerData.job
	local jobName = job.name
	local myGrade = job.grade.level

	if not Config.DutySystem[jobName] then
		return false
	end

	local stationConfig = Config.DutySystem[jobName].Station
	if not stationConfig or not stationConfig.boss then
		return false
	end

	local allowedGrades = stationConfig.boss.allowedGrades or {}
	for _, grade in ipairs(allowedGrades) do
		if grade == myGrade then
			return true
		end
	end
	return false
end

function G.SetPlayerJobServer(src, identifier, jobName, jobGrade)
	if not identifier or not jobName or type(jobGrade) ~= "number" then
		return
	end

	local Player = G.GetPlayer(src)
	if not Player then
		return
	end

	QBox:SetJob(src, jobName, jobGrade)

	MySQL.update("UPDATE players SET job = ?, job_grade = ? WHERE citizenid = ?", {
		jobName,
		jobGrade,
		identifier,
	})
end
