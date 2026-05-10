UsersCollate = ""

Queries = {}
Queries.Users = {}

---@param text string
function IsStringOnlyNumbers(text)
	return string.match(text:gsub("%s+", ""), "^[0-9]+$") ~= nil
end

---@param input string
---@param variables table<string, string>[]
function FormatString(input, variables)
	assert(type(input) == "string", "input must be a string")
	assert(type(variables) == "table", "variables must be a table")

	for k, v in pairs(variables) do
		local safeValue = tostring(v):gsub("%%", "%%%%")

		input = input:gsub("{" .. k .. "}", safeValue)
	end

	return input
end

---@param search string
---@param profileJoinTable? string
---@param page? number
---@return table[]
function SearchUsers(search, profileJoinTable, page)
	---@type any[]
	local params = {}
	---@type string[]
	local join = {}
	---@type string[]
	local where = {}
	---@type string[]
	local select = {
		Queries.Users.Select.identifier .. " AS id",
		Queries.Users.Select.name .. " AS `name`",
		Queries.Users.Select.dob .. " AS dob",
		Queries.Users.Select.isMale .. " AS isMale",
	}

	if profileJoinTable then
		select[#select + 1] = "profile.avatar_url"
		join[#join + 1] = "LEFT JOIN " .. profileJoinTable .. " profile ON profile.id = {IDENTIFIER} {USERS_COLLATE}"
	end

	if #search > 0 then
		if IsStringOnlyNumbers(search) and IsResourceStartedOrStarting("lb-phone") then
			local phoneConfig = exports["lb-phone"]:GetConfig()

			if phoneConfig?.Item.Unique then
				where[#where + 1] = "phone.phone_number LIKE ?"
				join[#join + 1] = "LEFT JOIN phone_last_phone phone ON {IDENTIFIER} {USERS_COLLATE} = phone.id"
			else
				where[#where + 1] = "phone.phone_number LIKE ?"
				join[#join + 1] = "LEFT JOIN phone_phones phone ON {IDENTIFIER} {USERS_COLLATE} = phone.id"
			end

			params[#params + 1] = "%" .. search .. "%"
		else
			where[#where + 1] = FormatString(
				[[
                (
                    {NAME} LIKE ?
                    OR {DOB} LIKE ?
                    {FINGERPRINT}
                )
            ]],
				{
					NAME = Queries.Users.Select.name,
					DOB = Queries.Users.Select.dob,
					FINGERPRINT = Queries.Users.Select.fingerprint
							and "OR " .. Queries.Users.Select.fingerprint .. " LIKE ?"
						or "",
				}
			)

			if Queries.Users.Select.fingerprint then
				params[#params + 1] = "%" .. search .. "%"
			end

			params[#params + 1] = "%" .. search .. "%"
			params[#params + 1] = "%" .. search .. "%"
		end
	end

	local searchQuery = "SELECT\n    {SELECT}\nFROM {USERS_TABLE} user\n{JOIN}\n{WHERE}\nLIMIT ?, ?"

	searchQuery = searchQuery
		:gsub("{SELECT}", table.concat(select, ",\n    "))
		:gsub("{USERS_TABLE}", Queries.Users.Table)
		:gsub("{JOIN}", table.concat(join, "\n"))
		:gsub("{WHERE}", #where > 0 and "WHERE " .. table.concat(where, " AND ") or "")
		:gsub("{IDENTIFIER}", Queries.Users.Select.identifier)
		:gsub("{USERS_COLLATE}", UsersCollate)

	params[#params + 1] = (page or 0) * 10
	params[#params + 1] = 10

	return MySQL.query.await(searchQuery, params)
end
