---@param company string
---@param amount number
---@param invoice table
---@param forced boolean
function RemoveCompanyMoney(company, amount, invoice, forced)
	assert(type(company) == "string", "Company name must be a string")
	assert(type(amount) == "number" and amount > 0, "Amount must be a positive number")

	return exports['cs_bossmenu']:RemoveMoney(company, amount)
end

---@param company string
---@param amount number
---@param invoice table
function AddCompanyMoney(company, amount, invoice)
	assert(type(company) == "string", "Company name must be a string")
	assert(type(amount) == "number" and amount > 0, "Amount must be a positive number")

	return exports['cs_bossmenu']:AddMoney(company, amount)
end

---@param company string
function GetCompanyMoney(company)
	assert(type(company) == "string", "Company name must be a string")

	return exports['cs_bossmenu']:GetAccount(company) or 0
end
