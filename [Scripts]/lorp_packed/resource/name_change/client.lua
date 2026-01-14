local function buildPersonalNameChange()
	local input = lib.inputDialog('Name Change Document', {
		{
			type = 'input',
			label = 'First Name',
			placeholder = 'John',
			required = true,
		},
		{
			type = 'input',
			label = 'Last Name',
			placeholder = 'Doe',
			required = true,
		},
		{
			type = 'checkbox',
			label = 'This will disconnect you from the server to ensure the name change fully updates in all modules.',
			required = true,
		},
	})

	if input and input[1] and input[2] then
		local data = {first = input[1], last = input[2]}
		local changeName = lib.callback.await('lorp_name_change:callback:change', false, data)
		return changeName
	end

	return false, false
end

local function openInput()
	local return1, return2 = buildPersonalNameChange()
	return return1, return2
end exports('nameChange', openInput)