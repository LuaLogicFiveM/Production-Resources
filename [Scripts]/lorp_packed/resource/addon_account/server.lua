local AccountsIndex, Accounts, SharedAccounts = {}, {}, {}

local function CreateAddonAccount(name, owner, money)
	local self = {}

	self.name  = name
	self.owner = owner
	self.money = money

	function self.addMoney(amount)
		self.money = self.money + amount
		self.save()
		TriggerEvent('esx_addonaccount:addMoney', self.name, amount)
	end

	function self.removeMoney(amount)
		self.money = self.money - amount
		self.save()
		TriggerEvent('esx_addonaccount:removeMoney', self.name, amount)
	end

	function self.setMoney(amount)
		self.money = amount
		self.save()
		TriggerEvent('esx_addonaccount:setMoney', self.name, amount)
	end

	function self.save()
		if self.owner == nil then
			MySQL.update('UPDATE addon_account_data SET money = ? WHERE account_name = ?', { self.money, self.name })
		else
			MySQL.update('UPDATE addon_account_data SET money = ? WHERE account_name = ? AND owner = ?',
				{ self.money, self.name, self.owner })
		end
		TriggerClientEvent('esx_addonaccount:setMoney', -1, self.name, self.money)
	end

	return self
end

AddEventHandler('onResourceStart', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		local accounts = MySQL.query.await(
			'SELECT * FROM addon_account LEFT JOIN addon_account_data ON addon_account.name = addon_account_data.account_name UNION SELECT * FROM addon_account RIGHT JOIN addon_account_data ON addon_account.name = addon_account_data.account_name')

		local newAccounts = {}
		for i = 1, #accounts do
			local account = accounts[i]
			if account.name then
				if account.shared == 0 then
					if not Accounts[account.name] then
						AccountsIndex[#AccountsIndex + 1] = account.name
						Accounts[account.name] = {}
					end
					Accounts[account.name][#Accounts[account.name] + 1] = CreateAddonAccount(account.name, account.owner,
						account.money)
				else
					if account.money then
						SharedAccounts[account.name] = CreateAddonAccount(account.name, nil, account.money)
					else
						newAccounts[#newAccounts + 1] = { account.name, 0 }
					end
				end
			end
		end
		GlobalState.SharedAccounts = SharedAccounts

		if next(newAccounts) then
			MySQL.prepare('INSERT INTO addon_account_data (account_name, money) VALUES (?, ?)', newAccounts)
			for i = 1, #newAccounts do
				local newAccount = newAccounts[i]
				SharedAccounts[newAccount[1]] = CreateAddonAccount(newAccount[1], nil, 0)
			end
			GlobalState.SharedAccounts = SharedAccounts
		end
	end
end)

local function GetAccount(name, owner)
	for i = 1, #Accounts[name], 1 do
		if Accounts[name][i].owner == owner then
			return Accounts[name][i]
		end
	end
end

local function GetSharedAccount(name)
	return SharedAccounts[name]
end

--[[local function AddSharedAccount(society, amount)
	-- society.name = job_name/society_name
	-- society.label = label for the job/account
	-- amount = if the shared account should start with x amount
	if type(society) ~= 'table' or not society?.name or not society?.label then return end

	-- check if account already exist?
	if SharedAccounts[society.name] ~= nil then return SharedAccounts[society.name] end

	-- addon account:
	local account = MySQL.insert.await('INSERT INTO `addon_account` (name, label, shared) VALUES (?, ?, ?)', {
		society.name, society.label, 1
	})
	if not account then return end

	-- if addon account inserted, insert addon account data:
	local account_data = MySQL.insert.await('INSERT INTO `addon_account_data` (account_name, money) VALUES (?, ?)', {
		society.name, (amount or 0)
	})
	if not account_data then return end

	-- if all data inserted successfully to sql:
	SharedAccounts[society.name] = CreateAddonAccount(society.name, nil, (amount or 0))

	return SharedAccounts[society.name]
end]]

AddEventHandler('esx_addonaccount:getAccount', function(name, owner, cb)
	cb(GetAccount(name, owner))
end)

AddEventHandler('esx_addonaccount:getSharedAccount', function(name, cb)
	cb(GetSharedAccount(name))
end)

--[[AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local addonAccounts = {}

	for i = 1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local account = GetAccount(name, xPlayer.identifier)

		if account == nil then
			MySQL.insert('INSERT INTO addon_account_data (account_name, money, owner) VALUES (?, ?, ?)',
				{ name, 0, xPlayer.identifier })

			account = CreateAddonAccount(name, xPlayer.identifier, 0)
			Accounts[name][#Accounts[name] + 1] = account
		end

		addonAccounts[#addonAccounts + 1] = account
	end

	xPlayer.set('addonAccounts', addonAccounts)
end)]]