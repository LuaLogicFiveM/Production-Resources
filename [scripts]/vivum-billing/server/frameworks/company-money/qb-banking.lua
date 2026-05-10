if Config.CompanyMoneySystem ~= "qb-banking" then
	return
end

---@param company string
---@param amount number
---@param invoice table
---@param forced boolean
function RemoveCompanyMoney(company, amount, invoice, forced)
	assert(type(company) == "string", "Company name must be a string")
	assert(type(amount) == "number" and amount > 0, "Amount must be a positive number")

	local balance = GetCompanyMoney(company)

	dbg("Company balance", company, balance, amount, forced)

	if balance < amount and not forced then
		dbg(
			"RemoveCompanyMoney: Insufficient funds in company:",
			company,
			"tried to remove:",
			amount,
			"balance:",
			balance
		)

		return false, balance
	end

	return exports["qb-banking"]:RemoveMoney(company, amount), amount
end

---@param company string
---@param amount number
---@param invoice table
function AddCompanyMoney(company, amount, invoice)
	assert(type(company) == "string", "Company name must be a string")
	assert(type(amount) == "number" and amount > 0, "Amount must be a positive number")

	return exports["qb-banking"]:AddMoney(company, amount)
end

---@param company string
function GetCompanyMoney(company)
	assert(type(company) == "string", "Company name must be a string")

	return exports["qb-banking"]:GetAccountBalance(company) or 0
end
