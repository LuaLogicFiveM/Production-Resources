---@diagnostic disable: duplicate-set-field
if GetResourceState("es_extended") ~= "started" then
    return;
end
ESX = exports.es_extended:getSharedObject();
G.Server = {};
function G.Server.GetCore()
    return ESX;
end

function G.Server.GetPlayer(src)
    return ESX.GetPlayerFromId(src);
end

function G.Server.GetPlayers()
    return ESX.GetExtendedPlayers();
end

-- AddEventHandler('esx:setJob', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     ESX.PlayerData = xPlayer.getJob();
-- end)

function G.Server.GetPlayerSources()
    local sources = {};
    for _, player in ipairs(G.Server.GetPlayers()) do
        table.insert(sources, player.source);
    end
    return sources;
end

function G.Server.GetPlayerName(src)
    local xPlayer = G.Server.GetPlayer(src);
    if xPlayer then
        return xPlayer.variables.firstName .. " " .. xPlayer.variables.lastName;
    end
    return nil;
end

function G.Server.GetIdentifier(src)
    local xPlayer = G.Server.GetPlayer(src);
    if xPlayer then
        return xPlayer.identifier;
    end
    return nil;
end

function G.Server.PlayerJobinfo(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return nil;
    end
    local j = xPlayer.getJob();
    if not j then
        return nil;
    end
    return {
        name = j.name,
        label = j.label,
        grade = j.grade,
        gradeLabel = j.grade_label,
        isGang = false
    };
end

function G.Server.AddMoney(src, type, amount, cb)
    DebugLog(("[AddMoney] src: %s, type: %s, amount: %s"):format(src, type, amount))
    if not src or not type or not amount then
        if cb then
            cb(false)
        end
        return
    end
    type = string.lower(type)
    local xPlayer = G.Server.GetPlayer(src)

    if not xPlayer then
        if cb then
            cb(false)
        end
        return
    end

    local accountTypes = {
        cash = "cash",
        bank = "bank"
    }

    local account = accountTypes[type]
    if not account then
        if cb then
            cb(false)
        end
        return
    end

    amount = tonumber(amount) or 0
    if amount <= 0 then
        if cb then
            cb(false)
        end
        return
    end

    if account == "cash" then
        xPlayer.addMoney(amount)
    else
        xPlayer.addAccountMoney(account, amount)
    end

    if cb then
        cb(true)
    end
end

function G.Server.isOnDuty(src)
    local xPlayer = G.Server.GetPlayer(src);
    if not xPlayer then
        return false;
    end
    local job = xPlayer.getJob();
    return job and job.onDuty == true;
end

function G.Server.HasMoneyAndRemove(src, type, count)
    local xPlayer = G.Server.GetPlayer(src)
    local accountTypes = {
        cash = "money",
        bank = "bank"
    }
    local account = accountTypes[type]

    count = tonumber(count)
    if not xPlayer or not account or not count or count <= 0 then
        return false
    end

    if account == "money" then
        if xPlayer.getMoney() >= count then
            xPlayer.removeMoney(count)
            return true
        end
    else
        local acc = xPlayer.getAccount(account)
        local playerMoney = acc and acc.money or 0
        if playerMoney >= count then
            xPlayer.removeAccountMoney(account, count)
            return true
        end
    end

    return false
end

function G.Server.GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier).playerId;
end

function G.Server.isPlayerOnlineAndOnduty(identifier)
    local xPlayers = ESX.GetExtendedPlayers()
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.identifier == identifier then
            local job = xPlayer.getJob()
            return job.onDuty == true
        end
    end
    return false
end

local function GetJobGradeLabel(job, grade)
    local result = MySQL.query.await("SELECT label FROM job_grades WHERE job_name = ? AND grade = ? LIMIT 1",
        {job, grade})

    if result and result[1] then
        return result[1].label
    end

    return "Unknown"
end

function G.Server.GetJobPlayers(job, search, page, limit)
    limit = limit or 10
    page = page or 1
    local offset = (page - 1) * limit

    local multijobJobGrades = {}
    local identifierList = {}

    if GetResourceState("g-multijob") == "started" then
        local multijobPlayers = exports["g-multijob"]:GetPlayersByJob(job)
        if type(multijobPlayers) == "table" then
            for _, identifier in ipairs(multijobPlayers) do
                if type(identifier) == "string" and identifier ~= "" then
                    local playerJobs = exports["g-multijob"]:GetPlayerJobs(identifier)
                    if type(playerJobs) == "table" then
                        for _, jobData in ipairs(playerJobs) do
                            if jobData.job == job then
                                multijobJobGrades[identifier] = tonumber(jobData.grade) or 0
                                break
                            end
                        end
                    end
                    table.insert(identifierList, identifier)
                end
            end
        end
    end

    local searchQuery = ""
    local params = {job}

    if search and search ~= "" then
        searchQuery = "AND (firstname LIKE ? OR lastname LIKE ?)"
        table.insert(params, "%" .. search .. "%")
        table.insert(params, "%" .. search .. "%")
    end

    local multijobCondition = ""
    local multijobParams = {}

    if #identifierList > 0 then
        local placeholders = {}
        for _, identifier in ipairs(identifierList) do
            if type(identifier) == "string" then
                table.insert(placeholders, "?")
                table.insert(multijobParams, identifier)
            end
        end
        if #placeholders > 0 then
            multijobCondition = "OR identifier IN (" .. table.concat(placeholders, ",") .. ")"
        end
    end

    local sql
    if multijobCondition ~= "" then
        sql = string.format([[
            SELECT identifier, firstname, lastname, job, job_grade, sex
            FROM users
            WHERE (job = ? %s) %s
            ORDER BY firstname ASC
            LIMIT ? OFFSET ?
        ]], searchQuery, multijobCondition)
    else
        sql = string.format([[
            SELECT identifier, firstname, lastname, job, job_grade, sex
            FROM users
            WHERE job = ? %s
            ORDER BY firstname ASC
            LIMIT ? OFFSET ?
        ]], searchQuery)
    end

    local allParams = {}
    for _, p in ipairs(params) do
        table.insert(allParams, p)
    end
    for _, p in ipairs(multijobParams) do
        table.insert(allParams, p)
    end
    table.insert(allParams, limit)
    table.insert(allParams, offset)

    local result = MySQL.query.await(sql, allParams) or {}
    local employees = {}
    local seen = {}

    for _, data in ipairs(result) do
        if not seen[data.identifier] then
            seen[data.identifier] = true

            local isOnline, isOnDuty = G.Server.isPlayerOnlineAndOnduty(data.identifier)
            local fullName = (data.firstname or "Unknown") .. " " .. (data.lastname or "")

            local grade = multijobJobGrades[data.identifier] or data.job_grade or 0

            table.insert(employees, {
                identifier = data.identifier,
                name = fullName,
                grade_name = grade,
                job = job,
                grade = grade,
                grade_label = GetJobGradeLabel(job, grade),
                sex = data.sex and (data.sex == "m" and "male" or "female") or "unknown",
                isOnDuty = isOnline,
                dailyDutyData = {},
                total_time = 0,
                last_clock_in = 0,
                jobPlayerVehicles = {}
            })
        end
    end

    local countSql
    if multijobCondition ~= "" then
        countSql = string.format([[
            SELECT COUNT(DISTINCT identifier) as total
            FROM users
            WHERE (job = ? %s) %s
        ]], searchQuery, multijobCondition)
    else
        countSql = string.format("SELECT COUNT(*) as total FROM users WHERE job = ? %s", searchQuery)
    end

    local countParams = {job}
    if search and search ~= "" then
        table.insert(countParams, "%" .. search .. "%")
        table.insert(countParams, "%" .. search .. "%")
    end
    for _, identifier in ipairs(multijobParams) do
        table.insert(countParams, identifier)
    end

    local countResult = MySQL.query.await(countSql, countParams)
    local total = countResult and countResult[1] and countResult[1].total or 0

    return {
        total = total,
        page = page,
        limit = limit,
        data = employees
    }
end

function G.Server.GetJobGrades(jobName)
    if not jobName or jobName == "" then
        return {}
    end

    local jobs = ESX.GetJobs()
    if not jobs then
        return {}
    end

    local normalizedJobName = jobName:lower()
    local job = jobs[normalizedJobName]

    if not job or not job.grades then
        return {}
    end

    local gradesList = {}

    for gradeKey, gradeData in pairs(job.grades) do
        if gradeData and type(gradeData) == "table" then
            table.insert(gradesList, {
                name = gradeData.name or "",
                label = gradeData.label or "",
                grade = gradeData.grade or tonumber(gradeKey) or 0
            })
        end
    end

    table.sort(gradesList, function(a, b)
        return a.grade < b.grade
    end)

    return gradesList
end

function G.Server.SetPlayerJob(src, jobName, grade, oldJob)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end

    local success, err = pcall(function()
        xPlayer.setJob(jobName, grade, true)
    end)

    if success then
        return true
    else
        return false
    end
end

function G.Server.SavePlayer(identifier, jobName, grade)
    local affectedRows = MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?',
        {jobName, grade, identifier})

    if affectedRows and affectedRows > 0 then
        return true
    else
        return false
    end
end

function G.Server.GetAverageSalary(job)
    local jobs = ESX.GetJobs()
    local jobData = jobs[job]

    if not jobData or not jobData.grades then
        return 0
    end

    local total = 0
    local count = 0

    for _, grade in pairs(jobData.grades) do
        if grade.salary and grade.salary > 0 then
            total = total + grade.salary
            count = count + 1
        end
    end

    if count == 0 then
        return 0
    end

    local avg = total / count
    return math.floor(avg + 0.5)
end

function G.Server.GetTotalEmployees(job)
    local identifierList = {}

    if GetResourceState("g-multijob") == "started" then
        local multijobPlayers = exports["g-multijob"]:GetPlayersByJob(job)
        if type(multijobPlayers) == "table" then
            for _, identifier in ipairs(multijobPlayers) do
                if type(identifier) == "string" and identifier ~= "" then
                    table.insert(identifierList, identifier)
                end
            end
        end
    end

    local query
    local params = {job}

    if #identifierList > 0 then
        local placeholders = {}
        for _ = 1, #identifierList do
            table.insert(placeholders, "?")
        end
        for _, identifier in ipairs(identifierList) do
            table.insert(params, identifier)
        end
        query = string.format([[
            SELECT COUNT(DISTINCT identifier) as total
            FROM users
            WHERE (job = ? OR identifier IN (%s))
        ]], table.concat(placeholders, ","))
    else
        query = "SELECT COUNT(*) as total FROM users WHERE job = ?"
    end

    local result = MySQL.query.await(query, params)
    if result and result[1] and result[1].total then
        return result[1].total
    end
    return 0
end

function G.Server.GetTotalJobGrades(job)
    local jobs = ESX.GetJobs()
    local jobData = jobs[job]

    if not jobData or not jobData.grades then
        return 0
    end

    local count = 0
    for _ in pairs(jobData.grades) do
        count = count + 1
    end

    return count
end

-- from esx_vehicleshop script
local Nums = {}
local Chars = {}

for i = 48, 57 do
    table.insert(Nums, string.char(i))
end
for i = 65, 90 do
    table.insert(Chars, string.char(i))
end
for i = 97, 122 do
    table.insert(Chars, string.char(i))
end
function G.Server.IsPalteTaken(plate)
    local res = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    })
    if res[1] then
        return true
    end

    local bossRes = MySQL.Sync.fetchAll('SELECT * FROM g_bossmenu_job_ownable_vehicles WHERE vehPlate = @plate', {
        ['@plate'] = plate
    })
    return bossRes[1] ~= nil
end

function G.Server.GeneratePlate()
    local generatedPlate = ""

    for _ = 1, 3 do
        generatedPlate = generatedPlate .. Chars[math.random(1, #Chars)]
    end
    generatedPlate = generatedPlate .. ' '
    for _ = 1, 3 do
        generatedPlate = generatedPlate .. Nums[math.random(1, #Nums)]
    end
    generatedPlate = string.upper(generatedPlate)

    if G.Server.IsPalteTaken(generatedPlate) then
        return G.Server.GeneratePlate()
    end
    return generatedPlate
end

function G.Server.AddVehicleToFrameworkGarage(src, data)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end

    local identifier = xPlayer.identifier
    local parking = Config.SystemSettings.defaultParking
    local plate = G.Server.GeneratePlate()

    local query = [[
        INSERT INTO owned_vehicles (`owner`, `plate`, `vehicle`, `type`, `stored`, `parking`)
        VALUES (?, ?, ?, ?, ?, ?)
    ]]

    local params = {identifier, plate, json.encode({
        model = GetHashKey(data.model),
        plate = plate
    }), data.type, 1, parking}

    local insertId = MySQL.insert.await(query, params)
    if not insertId then
        print(("[g-bossmenu] Failed to insert owned vehicle for %s"):format(identifier))
        return false
    end

    return plate
end

function G.Server.DeleteVehicleFromFrameworkGarage(plate)
    local affected = MySQL.update.await('DELETE FROM owned_vehicles WHERE plate = ?', {plate})
    return affected and affected > 0
end
