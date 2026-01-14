Citizen.CreateThread(function()
	if Config.Framework ~= "standalone" then
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

	function GetIdentifier(source)
		for _, v in pairs(GetPlayerIdentifiers(source)) do
			if v:sub(1, #"license:") == "license:" then
				return v
			end
		end
	end

	function GetName(id)
		return GetPlayerName(id)
	end

	function GetCommissionRate(id)
		return 0
	end

	function GetSenders(source)
		return {}
	end

	function QueryJobs(query)
		return {}
	end

	function IsSociety(id)
		return false
	end

	function AddPlayerMoney(id, amount, invoice)
		assert(amount > 0, "Amount must be over 0.")
	end

	function RemovePlayerMoney(id, amount, invoice, forced)
		if amount < 0 then
			return false
		end

		return true
	end
end)
