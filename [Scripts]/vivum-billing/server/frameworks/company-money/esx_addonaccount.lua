if Config.CompanyMoneySystem ~= "esx_addonaccount" then
	return
end

local function GetSocietyAccount(company)
	local p = promise.new()

	TriggerEvent("esx_addonaccount:getSharedAccount", "society_" .. company, function(account)
		p:resolve(account)
	end)

	return Citizen.Await(p)
end

---@param company string
---@param amount number
---@param invoice table
---@param forced boolean
function RemoveCompanyMoney(company, amount, invoice, forced)
	assert(type(company) == "string", "Company name must be a string")
	assert(type(amount) == "number" and amount > 0, "Amount must be a positive number")

	local account = GetSocietyAccount(company)

	if not account then
		dbg("RemoveCompanyMoney: No account found for company:", company)

		return false
	end

	if account.money < amount and not forced then
		dbg(
			"RemoveCompanyMoney: Insufficient funds in company:",
			company,
			"tried to remove:",
			amount,
			"balance:",
			account.money
		)

		return false, account.money
	end

	account.removeMoney(amount)

	return true, amount
end

---@param company string
---@param amount number
---@param invoice table
function AddCompanyMoney(company, amount, invoice)
	assert(type(company) == "string", "Company name must be a string")
	assert(type(amount) == "number" and amount > 0, "Amount must be a positive number")

	local account = GetSocietyAccount(company)

	if not account then
		dbg("AddCompanyMoney: No account found for company:", company)

		return false
	end

	account.addMoney(amount)

	return true
end

---@param company string
---@param invoice table
function GetCompanyMoney(company, invoice)
	assert(type(company) == "string", "Company name must be a string")

	local account = GetSocietyAccount(company)

	if not account then
		dbg("GetCompanyMoney: No account found for company:", company)

		return 0
	end

	return account.money or 0
end
