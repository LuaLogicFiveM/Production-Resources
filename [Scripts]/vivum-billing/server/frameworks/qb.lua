CreateThread(function()
	if Config.Framework ~= "qb" then
		return
	end

	Queries = {}
	Queries.Users = {}

	Queries.Users.Table = "players"
	Queries.Users.Select = {
		identifier = "user.citizenid",
		name = "CONCAT(JSON_VALUE(user.charinfo, '$.firstname'), ' ', JSON_VALUE(user.charinfo, '$.lastname'))",
		dob = "JSON_VALUE(user.charinfo, '$.birthdate')",
		isMale = "JSON_EXTRACT(user.charinfo, '$.gender') = 0",
	}

	local QB = exports["qb-core"]:GetCoreObject()

	function GetIdentifier(source)
		return QB.Functions.GetPlayer(source)?.PlayerData?.citizenid
	end

	function GetName(id)
		local player = QB.Functions.GetPlayerByCitizenId(id)

		return player and player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname or id
	end

	function GetCommissionRate(id)
		local player = QB.Functions.GetPlayerByCitizenId(id)
		local job = player and player.PlayerData.job
		local table = job and Config.Commission[job.name]
		local specific = table and (table[job.grade.name:lower()] or table[job.grade.name])
		local all = table and table["all"]
		local rate = specific or all

		return rate or 0
	end

	function GetSenders(source)
		local player = QB.Functions.GetPlayer(source)
		local job = player and player.PlayerData.job
		local senders = {}
		local index = 1
		local grade = Config.Grades[job.name] or { "boss" }
		local grades = type(grade) == "table" and grade or { grade }
		local found = false
		local canManage = true

		if job then
			for i = 1, #grades do
				local entry = type(grades[i]) == "table" and grades[i][1] or grades[i]

				if entry == "all" or job.grade.name:lower() == (type(entry) == "string" and entry:lower() or entry) then
					found = true

					if type(grades[i]) == "table" then
						canManage = grades[i][2]
					end

					break
				end
			end
		end

		if job and job.name ~= "unemployed" and (found or job.isboss) and job.onduty then
			local BlacklistedTable = Config.Blacklisted or {}
			local isAllowed = not BlacklistedTable[job.name] or BlacklistedTable[job.name].send

			senders[index] = {
				id = job.name,
				label = job.label,
				canSend = isAllowed,
				canManage = canManage,
				avatarUrl = Config.Avatars[job.name] or nil,
			}

			index = index + 1
		end

		return senders
	end

	function QueryRecipients(source, query, cb)
		local res = {}
		local players = QB.Functions.GetQBPlayers()
		local index = 1

		for _, player in pairs(players) do
			if SearchQuery({ player, player.PlayerData, player.PlayerData.charinfo }, query) then
				res[index] = {
					id = player.PlayerData.citizenid,
					label = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname,
				}

				index = index + 1
			end
		end

		local BlacklistedTable = Config.Blacklisted or {}

		for k, v in pairs(QB.Shared.Jobs) do
			local isAllowed = not BlacklistedTable[k] or BlacklistedTable[k].receive

			if k ~= "unemployed" and isAllowed then
				if SearchQuery({ k, v }, query) then
					res[index] = { id = k, label = v.label }
					index = index + 1
				end
			end
		end

		cb(res)
	end

	function QueryJobs(query)
		local res = {}
		local BlacklistedTable = Config.Blacklisted or {}

		for k, v in pairs(QB.Shared.Jobs) do
			local isAllowed = not BlacklistedTable[k] or BlacklistedTable[k].receive

			if k ~= "unemployed" and isAllowed and SearchQuery({ k, v }, query) then
				res[#res + 1] = { id = k, label = v.label }
			end
		end

		return res
	end

	function IsSociety(id)
		return QB.Shared.Jobs[id] ~= nil
	end

	function AddPlayerMoney(id, amount, invoice)
		assert(amount > 0, "Amount must be over 0.")

		local player = QB.Functions.GetPlayerByCitizenId(id)

		if player then
			player.Functions.AddMoney("bank", amount, "vivum-billing")
		else
			MySQL.update.await(
				"UPDATE players SET money = JSON_SET(money, '$.bank', JSON_EXTRACT(money, '$.bank') + @amount) WHERE citizenid = @identifier",
				{ ["@amount"] = amount, ["@identifier"] = id }
			)
		end
	end

	function RemovePlayerMoney(id, amount, invoice, forced)
		if amount < 0 then
			return false
		end

		local player = QB.Functions.GetPlayerByCitizenId(id)

		if player then
			local money = player.PlayerData.money.bank

			if money < amount and not forced then
				return false, money
			end

			return player.Functions.RemoveMoney("bank", amount, "vivum-billing"), amount
		else
			local serialized =
				MySQL.query.await("SELECT money FROM players WHERE citizenid = @identifier", { ["@identifier"] = id })

			if serialized and #serialized > 0 then
				local money = json.decode(serialized[1].money)
				local bank = money.bank or 0

				if bank < amount and not forced then
					return false, bank
				end

				MySQL.update.await(
					"UPDATE players SET money = JSON_SET(money, '$.bank', JSON_EXTRACT(money, '$.bank') - @amount) WHERE citizenid = @identifier",
					{ ["@amount"] = amount, ["@identifier"] = id }
				)

				return true, amount
			end

			return false
		end
	end
end)
