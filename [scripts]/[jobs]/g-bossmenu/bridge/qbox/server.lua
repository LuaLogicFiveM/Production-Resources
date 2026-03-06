---@diagnostic disable: duplicate-set-field, undefined-field, missing-fields
if GetResourceState("qbx_core") ~= "started" then
    return
end

QBox = exports.qbx_core
G.Server = {};

local QBoxJobs = exports.qbx_core:GetJobs()
local QBoxGangs = exports.qbx_core:GetGangs()

local playerVehiclesHasTypeColumn

local function PlayerVehiclesSupportsTypeColumn()
    if playerVehiclesHasTypeColumn == nil then
        local ok, result = pcall(function()
            return MySQL.query.await("SHOW COLUMNS FROM player_vehicles LIKE 'type'")
        end)

        if ok and result and type(result) == "table" and #result > 0 then
            playerVehiclesHasTypeColumn = true
        else
            playerVehiclesHasTypeColumn = false
        end
    end

    return playerVehiclesHasTypeColumn
end

function G.Server.GetCore()
    return QBox
end

function G.Server.GetPlayer(source)
    return QBox:GetPlayer(source)
end

function G.Server.GetPlayers()
    return QBox:GetQBPlayers()
end

function G.Server.GetPlayerSources()
    local sources = {};
    for _, player in ipairs(G.Server.GetPlayers()) do
        table.insert(sources, player.PlayerData.source);
    end
    return sources;
end

function G.Server.GetPlayerName(_source)
    local src = _source or source
    local playerData = G.Server.GetPlayer(src).PlayerData
    if not playerData then
        return
    end
    return playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname
end

function G.Server.GetIdentifier(src)
    local xPlayer = G.Server.GetPlayer(src)
    if xPlayer then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

function G.Server.PlayerJobinfo(src)
    local xPlayer = G.Server.GetPlayer(src)
    xPlayer = xPlayer or QBox:GetPlayer(src)
    if not xPlayer then
        return nil
    end

    local playerJob = xPlayer.PlayerData.job
    local jobGradeData = (playerJob and playerJob.grade) or {}

    local jobInfo = {
        name = playerJob and playerJob.name or nil,
        label = playerJob and playerJob.label or nil,
        grade = jobGradeData.level or 0,
        gradeLabel = jobGradeData.name,
        isboss = playerJob and (playerJob.isboss or false) or false,
        onduty = playerJob and (playerJob.onduty or false) or false
    }

    local playerGang = xPlayer.PlayerData.gang
    local gangIsValid = playerGang and playerGang.name and playerGang.name ~= "none"
    if gangIsValid then
        local gangGradeData = playerGang.grade or {}
        jobInfo.gang = {
            name = playerGang.name,
            label = playerGang.label,
            grade = gangGradeData.level or 0,
            gradeLabel = gangGradeData.name,
            isboss = playerGang.isboss or false
        }
        jobInfo.isGang = true
    else
        jobInfo.gang = nil
        jobInfo.isGang = false
    end

    if not jobInfo.name and jobInfo.gang then
        jobInfo.name = jobInfo.gang.name
        jobInfo.label = jobInfo.gang.label
        jobInfo.grade = jobInfo.gang.grade
        jobInfo.gradeLabel = jobInfo.gang.gradeLabel
    end

    return jobInfo
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
    local Player = QBox:GetPlayer(src)

    if not Player then
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

    local success = QBox:AddMoney(src, account, amount)

    if not success then
        if cb then
            cb(false)
        end
        return
    end

    if cb then
        cb(true)
    end
end

function G.Server.isOnDuty(src)
    local Player = G.Server.GetPlayer(src)
    if not Player then
        return false
    end
    return Player.PlayerData.job.onduty or false
end

function G.Server.HasMoneyAndRemove(src, type, count)
    local Player = QBox:GetPlayer(src)
    local accountTypes = {
        cash = "cash",
        bank = "bank"
    }
    local account = accountTypes[string.lower(type)]

    count = tonumber(count)
    if not Player or not account or not count or count <= 0 then
        return false
    end

    local playerMoney = Player.Functions.GetMoney(account)
    if playerMoney and playerMoney >= count then
        QBox:RemoveMoney(src, account, count)
        return true
    end

    return false
end

function G.Server.GetPlayerFromIdentifier(identifier)
    local Player = QBox:GetPlayerByCitizenId(identifier)
    if Player then
        return Player.PlayerData.source
    end
    return nil
end

function G.Server.isPlayerOnlineAndOnduty(identifier)
    local players = QBox:GetQBPlayers()
    for _, xPlayer in pairs(players) do
        if xPlayer.PlayerData.citizenid == identifier and xPlayer.PlayerData.job.onduty then
            return true
        end
    end
    return false
end

--

function GetSharedGroupData(name)
    if not name or name == "" then
        return nil, nil
    end

    local job = QBoxJobs and QBoxJobs[name]
    if job then
        return job, "job"
    end

    local gang = QBoxGangs and QBoxGangs[name]
    if gang then
        return gang, "gang"
    end

    return nil, nil
end

function ResolveGradeLevel(gradeLevel)
    if type(gradeLevel) == "number" then
        return gradeLevel
    end
    local num = tonumber(gradeLevel)
    return num or 0
end

local function GetJobGradeLabel(name, grade)
    local groupData = select(1, GetSharedGroupData(name))

    if not groupData or not groupData.grades then
        return "Unknown"
    end

    local gradeLevel = ResolveGradeLevel(grade)
    local gradeData = groupData.grades[gradeLevel]

    if gradeData then
        return gradeData.name or "Unknown"
    end

    return "Unknown"
end

function G.Server.GetJobPlayers(job, search, page, limit)
    limit = limit or 10
    page = page or 1
    local offset = (page - 1) * limit
    local employees = {}
    local configEntry = Config and Config.Menu and Config.Menu.BossMenu and Config.Menu.BossMenu[job] or nil
    local _, sharedType = GetSharedGroupData(job)
    local isGangContext = (configEntry and configEntry.isGang == true) or sharedType == "gang"

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

    local function nameMatches(fullName)
        if not search or search == "" then
            return true
        end
        return fullName:lower():find(search:lower(), 1, true) ~= nil
    end

    local function extractGradeInfo(gradeData)
        if type(gradeData) == "table" then
            local level = gradeData.level or gradeData.grade or gradeData.rank or 0
            local name = gradeData.name or gradeData.label or "N/A"
            return level, name
        end

        local level = tonumber(gradeData) or 0
        return level, "N/A"
    end

    local function IsEmployeeOnLeave(identifier)
        if not Config or not Config.BossMenuSettings or not Config.BossMenuSettings.EnableLeaveManagementSystem then
            return false
        end

        local currentDate = os.date("%Y-%m-%d")
        local query = [[
         SELECT COUNT(*) as count
         FROM g_bossmenu_employee_leave
         WHERE identifier = ?
         AND status = 'approved'
         AND start_date <= ?
         AND end_date >= ?
      ]]
        local result = MySQL.query.await(query, {identifier, currentDate, currentDate})

        if result and result[1] and result[1].count and result[1].count > 0 then
            return true
        end

        return false
    end

    local function appendEmployee(entry)
        for _, existing in ipairs(employees) do
            if existing.identifier == entry.identifier then
                return
            end
        end
        table.insert(employees, entry)
    end

    for _, player in pairs(QBox:GetQBPlayers()) do
        local playerJob = player.PlayerData.job
        local playerGang = player.PlayerData.gang
        local charinfo = player.PlayerData.charinfo or {}
        local fullName = ("%s %s"):format(charinfo.firstname or "Unknown", charinfo.lastname or "")

        if not isGangContext and playerJob and playerJob.name == job and nameMatches(fullName) then
            local gradeLevel = playerJob.grade and playerJob.grade.level or 0
            appendEmployee({
                identifier = player.PlayerData.citizenid,
                name = fullName,
                grade_name = playerJob.grade and playerJob.grade.name or "N/A",
                job = job,
                grade = gradeLevel,
                grade_label = GetJobGradeLabel(job, gradeLevel),
                sex = charinfo.gender == 0 and "male" or "female",
                isOnDuty = playerJob.onduty or false,
                dailyDutyData = {},
                total_time = 0,
                last_clock_in = 0,
                jobPlayerVehicles = {},
                isOnLeave = IsEmployeeOnLeave(player.PlayerData.citizenid)
            })
        elseif isGangContext and playerGang and playerGang.name == job and nameMatches(fullName) then
            local gradeLevel, gradeName = extractGradeInfo(playerGang.grade)
            appendEmployee({
                identifier = player.PlayerData.citizenid,
                name = fullName,
                grade_name = gradeName,
                job = job,
                grade = gradeLevel,
                grade_label = GetJobGradeLabel(job, gradeLevel),
                sex = charinfo.gender == 0 and "male" or "female",
                isOnDuty = playerGang.onduty or true,
                dailyDutyData = {},
                total_time = 0,
                last_clock_in = 0,
                jobPlayerVehicles = {},
                isOnLeave = IsEmployeeOnLeave(player.PlayerData.citizenid)
            })
        end
    end

    local searchQuery, params = "", {job}
    if search and search ~= "" then
        searchQuery = "AND (charinfo LIKE ?)"
        table.insert(params, "%" .. search .. "%")
    end

    local groupField = isGangContext and "gang" or "job"

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
            multijobCondition = "OR citizenid IN (" .. table.concat(placeholders, ",") .. ")"
        end
    end

    local sql
    if multijobCondition ~= "" then
        sql = string.format([[
          SELECT citizenid, charinfo, %s
          FROM players
          WHERE (JSON_EXTRACT(%s, '$.name') = ? %s) %s
          LIMIT ? OFFSET ?
      ]], groupField, groupField, searchQuery, multijobCondition)
    else
        sql = string.format([[
          SELECT citizenid, charinfo, %s
          FROM players
          WHERE JSON_EXTRACT(%s, '$.name') = ? %s
          LIMIT ? OFFSET ?
      ]], groupField, groupField, searchQuery)
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

    local seen = {}
    for _, data in ipairs(result) do
        if not seen[data.citizenid] then
            seen[data.citizenid] = true

            local charinfo = json.decode(data.charinfo or "{}")
            local storedGroup = data[groupField]
            local jobData = json.decode(storedGroup or "{}")
            local fullName = ("%s %s"):format(charinfo.firstname or "Unknown", charinfo.lastname or "")
            local alreadyAdded = false

            for _, v in ipairs(employees) do
                if v.identifier == data.citizenid then
                    alreadyAdded = true
                    break
                end
            end

            if not alreadyAdded then
                local gradeLevel, gradeName = extractGradeInfo(
                    jobData.grade or jobData.grade_level or jobData.gradeLevel)
                if multijobJobGrades[data.citizenid] then
                    gradeLevel = multijobJobGrades[data.citizenid]
                    local jobGrades = G.Server.GetJobGrades(job) or {}
                    for _, gradeData in ipairs(jobGrades) do
                        if gradeData.grade == gradeLevel then
                            gradeName = gradeData.name or gradeData.label or tostring(gradeLevel)
                            break
                        end
                    end
                end

                table.insert(employees, {
                    identifier = data.citizenid,
                    name = fullName,
                    grade_name = gradeName or jobData.grade_name or "N/A",
                    job = jobData.name or job,
                    grade = gradeLevel,
                    grade_label = GetJobGradeLabel(job, gradeLevel),
                    sex = charinfo.gender == 0 and "male" or "female",
                    isOnDuty = false,
                    dailyDutyData = {},
                    total_time = 0,
                    last_clock_in = 0,
                    jobPlayerVehicles = {},
                    isOnLeave = IsEmployeeOnLeave(data.citizenid)
                })
            end
        end
    end

    local countSql
    if multijobCondition ~= "" then
        countSql = string.format([[
          SELECT COUNT(DISTINCT citizenid) as total
          FROM players
          WHERE (JSON_EXTRACT(%s, '$.name') = ? %s) %s
      ]], groupField, searchQuery, multijobCondition)
    else
        countSql = string.format([[
          SELECT COUNT(*) as total
          FROM players
          WHERE JSON_EXTRACT(%s, '$.name') = ? %s
      ]], groupField, searchQuery)
    end

    local countParams = {job}
    if search and search ~= "" then
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

function G.Server.GetJobGrades(name)
    if not name then
        return {}
    end

    local data, groupType = GetSharedGroupData(name)
    local isGang = (groupType == "gang")
    if not isGang then
        local configEntry = Config and Config.Menu and Config.Menu.BossMenu and Config.Menu.BossMenu[name]
        isGang = configEntry and configEntry.isGang == true or false
    end

    local gradesList = {}

    if data and data.grades then
        for gradeLevel, gradeData in pairs(data.grades) do
            local numericGrade = ResolveGradeLevel(gradeLevel)
            -- QBox JobGradeData has: name, isboss, bankAuth, payment (no label field)
            table.insert(gradesList, {
                grade = numericGrade,
                name = gradeData.name or "Unknown",
                label = gradeData.name or "Unknown" -- Use name as label for QBox
            })
        end
    end

    if #gradesList == 0 then
        local column = isGang and "gang" or "job"
        local query = string.format([[
         SELECT
            JSON_UNQUOTE(JSON_EXTRACT(%s, '$.grade.level'))   AS grade_level,
            JSON_UNQUOTE(JSON_EXTRACT(%s, '$.grade.name'))    AS grade_name,
            JSON_UNQUOTE(JSON_EXTRACT(%s, '$.grade.label'))   AS grade_label
         FROM players
         WHERE JSON_EXTRACT(%s, '$.name') = ?
      ]], column, column, column, column)

        local results = MySQL.query.await(query, {name}) or {}
        local seenGrades = {}

        for _, row in ipairs(results) do
            local level = ResolveGradeLevel(row.grade_level)
            if not seenGrades[level] then
                seenGrades[level] = true
                local gradeName = row.grade_name or ("Grade " .. level)
                local gradeLabel = row.grade_label or gradeName
                table.insert(gradesList, {
                    grade = level,
                    name = gradeName,
                    label = gradeLabel
                })
            end
        end
    end

    table.sort(gradesList, function(a, b)
        return a.grade < b.grade
    end)

    return gradesList
end

local function EmploymentSaveData(groupData, groupName, grade)
    local resolvedGrade = ResolveGradeLevel(grade)
    if resolvedGrade == nil then
        resolvedGrade = tonumber(grade) or 0
    end

    local gradeData

    if groupData and groupData.grades then
        gradeData = groupData.grades[resolvedGrade]
        if not gradeData then
            for key, data in pairs(groupData.grades) do
                if ResolveGradeLevel(key) == resolvedGrade then
                    gradeData = data
                    break
                end
            end
        end
    end

    local label = groupData and groupData.label or groupName

    return {
        name = groupName,
        label = label or groupName,
        grade = {
            name = gradeData and gradeData.name or tostring(resolvedGrade),
            label = gradeData and gradeData.name or tostring(resolvedGrade), -- Use name as label for QBox
            level = resolvedGrade
        },
        onduty = false,
        isboss = gradeData and (gradeData.isboss or false) or false
    }
end

function G.Server.SetPlayerJob(src, jobName, grade, oldJob)
    local player = QBox:GetPlayer(src)
    if not player then
        print("^1[ERROR]^0 Invalid player source:", src)
        return false
    end

    local oldJobName
    if type(oldJob) == "string" then
        oldJobName = oldJob
    elseif type(oldJob) == "table" then
        oldJobName = oldJob.name
    end

    local job = QBoxJobs and QBoxJobs[jobName]
    local gang = QBoxGangs and QBoxGangs[jobName]
    local isJob = job ~= nil
    local isGang = gang ~= nil
    local oldGang = oldJobName and QBoxGangs and QBoxGangs[oldJobName] or nil

    if not isJob and not isGang then
        return false
    end

    local success, err = pcall(function()
        if isJob then
            player.Functions.SetJob(jobName, grade)
            if oldGang and oldJobName ~= jobName then
                local defaultGangName = "none"
                local defaultGangGrade = 0
                local hasDefaultGang = QBoxGangs and QBoxGangs[defaultGangName]
                if hasDefaultGang then
                    player.Functions.SetGang(defaultGangName, defaultGangGrade)
                else
                    player.Functions.SetGang(oldJobName, 0)
                end
            end
        else
            player.Functions.SetGang(jobName, grade)
        end
    end)

    if not success then
        return false
    end

    return true
end

function G.Server.SavePlayer(citizenid, jobName, grade, oldJob)
    local oldJobName
    if type(oldJob) == "string" then
        oldJobName = oldJob
    elseif type(oldJob) == "table" then
        oldJobName = oldJob.name
    end

    local job = QBoxJobs and QBoxJobs[jobName]
    local gang = QBoxGangs and QBoxGangs[jobName]
    local isJob = job ~= nil
    local isGang = gang ~= nil

    if not isJob and not isGang then
        return false
    end

    local data = isJob and job or gang
    local saveData = EmploymentSaveData(data, jobName, grade)

    local column = isJob and "job" or "gang"

    local result = MySQL.update.await(("UPDATE players SET " .. column .. " = ? WHERE citizenid = ?"),
        {json.encode(saveData), citizenid})

    if result == nil or result == false then
        return false
    end

    if oldJobName and QBoxGangs and QBoxGangs[oldJobName] and not isGang then
        local defaultGangName = "none"
        local defaultGang = QBoxGangs[defaultGangName]
        if defaultGang then
            local defaultSave = EmploymentSaveData(defaultGang, defaultGangName, 0)
            MySQL.update.await("UPDATE players SET gang = ? WHERE citizenid = ?", {json.encode(defaultSave), citizenid})
        end
    end

    if type(result) == "number" and result < 0 then
        return false
    end

    return true
end

function G.Server.GetAverageSalary(jobName)
    local jobData = QBoxJobs and QBoxJobs[jobName]

    if not jobData or not jobData.grades then
        return 0
    end

    local total = 0
    local count = 0

    for _, grade in pairs(jobData.grades) do
        if grade.payment and grade.payment > 0 then
            total = total + grade.payment
            count = count + 1
        end
    end

    if count == 0 then
        return 0
    end

    local avg = total / count
    return math.floor(avg + 0.5)
end

function G.Server.GetTotalJobGrades(jobName)
    local jobData = QBoxJobs and QBoxJobs[jobName]

    if not jobData or not jobData.grades then
        return 0
    end

    local count = 0
    for _ in pairs(jobData.grades) do
        count = count + 1
    end

    return count
end

function G.Server.GetTotalEmployees(jobName, isGang)
    local column = isGang and "gang" or "job"

    local identifierList = {}

    if GetResourceState("g-multijob") == "started" then
        local multijobPlayers = exports["g-multijob"]:GetPlayersByJob(jobName)
        if type(multijobPlayers) == "table" then
            for _, identifier in ipairs(multijobPlayers) do
                if type(identifier) == "string" and identifier ~= "" then
                    table.insert(identifierList, identifier)
                end
            end
        end
    end

    local query
    local params = {jobName}

    if #identifierList > 0 then
        local placeholders = {}
        for _ = 1, #identifierList do
            table.insert(placeholders, "?")
        end
        for _, identifier in ipairs(identifierList) do
            table.insert(params, identifier)
        end
        query = string.format([[
         SELECT COUNT(DISTINCT citizenid) as total
         FROM players
         WHERE (JSON_EXTRACT(%s, '$.name') = ? OR citizenid IN (%s))
      ]], column, table.concat(placeholders, ","))
    else
        query = ([[SELECT COUNT(*) as total FROM players WHERE JSON_EXTRACT(%s, '$.name') = ?]]):format(column)
    end

    local result = MySQL.query.await(query, params)
    if result and result[1] and result[1].total then
        return result[1].total
    end
    return 0
end

function G.Server.IsPlateTaken(plate)
    local res = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if res and res[1] then
        return true
    end

    local bossRes = MySQL.query.await('SELECT * FROM g_bossmenu_job_ownable_vehicles WHERE vehPlate = ?', {plate})
    return bossRes and bossRes[1] ~= nil
end

local function RandomInt(length)
    local min = 10 ^ (length - 1)
    local max = (10 ^ length) - 1
    return tostring(math.random(min, max))
end

local function RandomStr(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local randIndex = math.random(1, #chars)
        result = result .. chars:sub(randIndex, randIndex)
    end
    return result
end

function G.Server.GeneratePlate()
    local plate = RandomInt(1) .. RandomStr(2) .. RandomInt(3) .. RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return G.Server.GeneratePlate()
    else
        return plate:upper()
    end
end

function G.Server.AddVehicleToFrameworkGarage(src, data)
    local player = QBox:GetPlayer(src)
    if not player then
        return false
    end

    local citizenid = player.PlayerData.citizenid
    local parking = Config.BossMenuSettings.defaultParking or "default"
    local plate = G.Server.GeneratePlate()
    local modelHash = GetHashKey(data.model)

    local defaultVehicleData = {
        wheels = 1,
        neonEnabled = {false, false, false, false},
        pearlescentColor = 7,
        modHorns = -1,
        modBackWheels = -1,
        modNitrous = -1,
        modRoof = -1,
        extras = {},
        modFrame = -1,
        windowTint = -1,
        tyres = {},
        doors = {},
        color2 = 120,
        modSuspension = -1,
        modCustomTiresR = false,
        neonColor = {255, 0, 255},
        modHydraulics = false,
        modSmokeEnabled = false,
        modVanityPlate = -1,
        modSteeringWheel = -1,
        tyreSmokeColor = {255, 255, 255},
        modTrunk = -1,
        engineHealth = 995,
        modTransmission = -1,
        modRoofLivery = -1,
        modCustomTiresF = false,
        modOrnaments = -1,
        tankHealth = 1000,
        modArmor = -1,
        modDial = -1,
        modSpeakers = -1,
        modGrille = -1,
        modLightbar = -1,
        modSideSkirt = -1,
        modFender = -1,
        oilLevel = 5,
        modAerials = -1,
        modPlateHolder = -1,
        modDoorSpeaker = -1,
        modFrontWheels = -1,
        modFrontBumper = -1,
        color1 = 7,
        modEngine = -1,
        fuelLevel = 64,
        livery = -1,
        paintType2 = 7,
        modAirFilter = -1,
        modStruts = -1,
        dirtLevel = 8,
        modEngineBlock = -1,
        modDashboard = -1,
        interiorColor = 2,
        modBrakes = -1,
        modTank = -1,
        modLivery = -1,
        modArchCover = -1,
        modDoorR = -1,
        modRightFender = -1,
        plate = plate,
        bulletProofTyres = true,
        wheelWidth = 0.0,
        modTrimA = -1,
        dashboardColor = 156,
        modSpoilers = -1,
        modRearBumper = -1,
        model = modelHash,
        modWindows = -1,
        modSeats = -1,
        modSubwoofer = -1,
        modHydrolic = -1,
        modShifterLeavers = -1,
        paintType1 = 7,
        windows = {2, 3, 4, 5},
        wheelColor = 0,
        modExhaust = -1,
        modHood = -1,
        wheelSize = 0.0,
        bodyHealth = 1000,
        driftTyres = false,
        modTrimB = -1,
        modXenon = false,
        plateIndex = 0,
        modTurbo = false,
        xenonColor = 255,
        modAPlate = -1
    }

    local vehicleDataJson = json.encode(defaultVehicleData)

    local query
    local params
    if PlayerVehiclesSupportsTypeColumn() then
        query = [[
           INSERT INTO player_vehicles (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`, `garage`, `type`)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
       ]]
        params = {player.PlayerData.license, citizenid, data.model, modelHash, vehicleDataJson, plate, 1, parking,
                  data.type or "car"}
    else
        query = [[
           INSERT INTO player_vehicles (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`, `garage`)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?)
       ]]
        params = {player.PlayerData.license, citizenid, data.model, modelHash, vehicleDataJson, plate, 1, parking}
    end

    local insertId = MySQL.insert.await(query, params)
    if not insertId then
        print(("[g-bossmenu] Failed to insert vehicle for %s (%s)"):format(citizenid, plate))
        return false
    end

    return plate
end

function G.Server.DeleteVehicleFromFrameworkGarage(plate)
    local affected = MySQL.update.await('DELETE FROM player_vehicles WHERE plate = ?', {plate})
    return affected and affected > 0
end
