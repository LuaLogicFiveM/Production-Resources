if not Config.CheckDatabase then
	dbg("Database checker disabled")

	return
end

local sql = LoadResourceFile(GetCurrentResourceName(), "billing.sql")

---@type string[]
local queries = {}
local delimter = ";"

for part in string.gmatch(sql, "([^" .. delimter .. "]+)") do
	queries[#queries + 1] = part:gsub("\n", ""):gsub("\r", ""):gsub("  ", " ")
end

local success = MySQL.transaction.await(queries)

if not success then
	log("error", "Failed to create tables, please run billing.sql manually using HeidiSQL")
end

DatabaseCheckerFinished = true
