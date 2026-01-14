Citizen.CreateThread(function()
	if Config.Framework ~= "esx" then
		return
	end

	Queries = {}
	Queries.Users = {}

	Queries.Users.Table = "users"
	Queries.Users.Select = {
		identifier = "user.identifier",
		name = "CONCAT(user.firstname, ' ', user.lastname)",
		dob = "user.dateofbirth",
		isMale = "user.sex = 'm'",
	}

	local export, ESX = pcall(function()
		return exports.es_extended:getSharedObject()
	end)

	if not export then
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)
	end

	function GetIdentifier(source)
		local player = ESX.GetPlayerFromId(source)

		return player and player.identifier
	end

	function GetName(id)
		local player = ESX.GetPlayerFromIdentifier(id)

		return player and player.name or id
	end

	function GetCommissionRate(id)
		local player = ESX.GetPlayerFromIdentifier(id)
		local job = player and player.getJob()
		local table = job and Config.Commission[job.name]
		local specific = table and table[job.grade_name]
		local all = table and table["all"]
		local rate = specific or all

		return rate or 0
	end

	function GetSenders(source)
		local player = ESX.GetPlayerFromId(source)
		local job = player and player.getJob()
		local senders = {}
		local index = 1
		local grade = Config.Grades[job.name] or { "boss" }
		local grades = type(grade) == "table" and grade or { grade }
		local found = false
		local canManage = true

		if job then
			for i = 1, #grades do
				local entry = type(grades[i]) == "table" and grades[i][1] or grades[i]

				if entry == "all" or job.grade_name == entry then
					found = true

					if type(grades[i]) == "table" then
						canManage = grades[i][2]
					end

					break
				end
			end
		end

		if job and job.name ~= "unemployed" and found then
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

	function QueryJobs(query)
		local res = {}
		local BlacklistedTable = Config.Blacklisted or {}

		for _, job in pairs(ESX.GetJobs()) do
			local isAllowed = not BlacklistedTable[job.name] or BlacklistedTable[job.name].receive

			if job.name ~= "unemployed" and isAllowed and SearchQuery({ job }, query) then
				res[#res + 1] = { id = job.name, label = job.label }
			end
		end

		return res
	end

	function IsSociety(id)
		for _, job in pairs(ESX.GetJobs()) do
			if job.name == id then
				return true
			end
		end

		return false
	end

	function AddPlayerMoney(id, amount, invoice)
		assert(amount > 0, "Amount must be over 0.")

		local player = ESX.GetPlayerFromIdentifier(id)

		if player then
			player.addAccountMoney("bank", amount)
		else
			MySQL.update.await(
				"UPDATE users SET accounts = JSON_SET(accounts, '$.bank', JSON_EXTRACT(accounts, '$.bank') + @amount) WHERE identifier = @identifier",
				{ ["@amount"] = amount, ["@identifier"] = id }
			)
		end
	end

	function RemovePlayerMoney(id, amount, invoice, forced)
		if amount < 0 then
			return false
		end

		local player = ESX.GetPlayerFromIdentifier(id)

		if player then
			local account = player.getAccount("bank")
			local balance = account and account.money or 0

			if balance < amount and not forced then
				return false, balance
			end

			player.removeAccountMoney("bank", amount)

			return true, amount
		else
			local serialized =
				MySQL.query.await("SELECT accounts FROM users WHERE identifier = @identifier", { ["@identifier"] = id })

			if serialized and #serialized > 0 then
				local accounts = json.decode(serialized[1].accounts)
				local bank = accounts.bank or 0

				if bank < amount and not forced then
					return false, bank
				end

				MySQL.update.await(
					"UPDATE users SET accounts = JSON_SET(accounts, '$.bank', JSON_EXTRACT(accounts, '$.bank') - @amount) WHERE identifier = @identifier",
					{ ["@amount"] = amount, ["@identifier"] = id }
				)

				return true, amount
			end

			return false
		end
	end
end)
