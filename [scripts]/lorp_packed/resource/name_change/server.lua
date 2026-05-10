local function updatePlayerData(src, submittedfirstname, submittedlastname)
	local xPlayer = ESX.GetPlayerFromId(src)
	if not xPlayer then return end
	xPlayer.setName(('%s %s'):format(submittedfirstname, submittedlastname))
	xPlayer.set('firstName', submittedfirstname)
	xPlayer.set('lastName', submittedlastname)
	MySQL.query.await("UPDATE users SET firstname = ?, lastname = ? WHERE identifier = ?", { submittedfirstname, submittedlastname, xPlayer.identifier })
	DropPlayer(src, 'You have initialized a name change \nThis kick will not count toward your record')
end

local words = { "fart", "bitch", "fuck", "retard", "nig", "fag" }

local function isABadWord(name)
	if not name:match("^[%a]+$") then return true end
	for _, badWord in ipairs(words) do
		if name:lower():find(badWord) then return true end
	end
	return false
end

local function ChangeName(src, submittedfirstname, submittedlastname)
	if isABadWord(submittedfirstname) or isABadWord(submittedlastname) then
		return lib.notify(src, {title = 'City Hall', description = 'You are unable to use that name', type = 'error'})
	end
	updatePlayerData(src, submittedfirstname, submittedlastname)
	lib.notify(src, {title = 'City Hall', description = 'Successfully Changed Name To '..submittedfirstname..' '..submittedlastname, type = 'success'})
end

lib.callback.register('lorp_name_change:callback:change', function(source, data)
	return ChangeName(source, data.first, data.last)
end)