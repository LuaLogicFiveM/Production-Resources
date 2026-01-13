if Cfg.Framework ~= 'qbcore' then return end

QBCore = nil
local SharedVehicles = {}
local SharedJobs = {}
local CharacterNames = {}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            INITIALIZE                            │
-- └──────────────────────────────────────────────────────────────────┘

-- Initialize the framework object
pcall(function()
    QBCore = exports['qb-core']:GetCoreObject()
end)

if not QBCore then
    TriggerEvent('QBCore:GetObject', function(obj)
        QBCore = obj
    end)
end

function HasFrameworkLoaded()
    return QBCore ~= nil
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              PLAYER                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the player object
function GetPlayer(source)
    if not source then return end

    return QBCore.Functions.GetPlayer(source)
end

-- Get the unique identifier of a player
function GetIdentifier(source)
    local Player = GetPlayer(source)
    if not Player then return end

    return Player.PlayerData.citizenid
end

-- Get the license identifier of a player
function GetLicenseIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license')
end

-- Get the source from a unique identifier
function GetSourceFromIdentifier(identifier)
    local players = QBCore.Functions.GetPlayers()
    for _, src in pairs(players) do
        local Player = GetPlayer(src)
        if Player and Player.PlayerData.citizenid == identifier then
            return src
        end
    end
end

-- Get a players character name
function GetCharacterName(source)
    if CharacterNames[source] then
        return CharacterNames[source]
    end

    local Player = GetPlayer(source)
    if not Player then return end

    local char_name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname or Locale('unknown')
    CharacterNames[source] = char_name
    return char_name
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               PERMS                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the admin permissions/group of a player
function GetAdminPerms(source)
    local Player = GetPlayer(source)
    if not Player then return end

    return QBCore.Functions.GetPermission(source)
end

-- Check if a player has admin permissions
function HasAdminPerms(source, perms)
    if not perms then return false end

    local playerPerm = GetAdminPerms(source)
    if not playerPerm then return false end

    local tPerms = type(perms)

    local function norm(v)
        return tostring(v):lower()
    end

    local function listHasPerm(list, target)
        local lt = type(list)
        target = norm(target)

        if lt == 'string' or lt == 'number' then
            return norm(list) == target
        elseif lt == 'table' then
            for k, v in pairs(list) do
                if type(k) == 'string' and norm(k) == target then
                    return true
                end
                if type(v) == 'string' or type(v) == 'number' then
                    if norm(v) == target then
                        return true
                    end
                end
            end
        end

        return false
    end

    if tPerms == 'string' or tPerms == 'number' then
        return listHasPerm(playerPerm, perms)
    end

    if tPerms == 'table' then
        for k, v in pairs(perms) do
            if type(k) == 'string' and listHasPerm(playerPerm, k) then
                return true
            end
            if type(v) == 'string' or type(v) == 'number' then
                if listHasPerm(playerPerm, v) then
                    return true
                end
            end
        end
    end

    return false
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                JOB                               │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the job name of a player
function GetJobName(source)
    local Player = GetPlayer(source)
    if not Player then return false end

    return Player.PlayerData.job.name
end

-- Get the job label of a player
function GetJobLabel(source)
    local Player = GetPlayer(source)
    if not Player then return false end

    return Player.PlayerData.job.label
end

-- Get the job grade of a player
function GetJobGrade(source)
    local Player = GetPlayer(source)
    if not Player then return false end

    return Player.PlayerData.job.grade.level
end

-- Get the job label of a player
function GetJobGradeLabel(source)
    local Player = GetPlayer(source)
    if not Player then return false end

    return Player.PlayerData.job.grade.name
end

-- Check if a player is on duty
function GetJobDuty(source)
    if Cfg.DisableDuty then
        return true
    end

    local customDuty = GetCustomJobDuty()
    if customDuty ~= nil then
        return customDuty
    end

    local Player = GetPlayer(source)
    if not Player then return false end

    return Player.PlayerData.job.onduty
end

-- Check if a player has the job
function HasJob(source, job)
    local myJob = GetJobName(source)
    if not myJob or not GetJobDuty(source) or not GetJobGrade(source) then return false end

    local myGrade = tonumber(GetJobGrade(source))
    local jobType = type(job)

    if jobType == 'string' then
        return myJob == job
    end

    if jobType ~= 'table' then
        return false
    end

    local minOnly = tonumber(job.min or job.minimum)
    if minOnly then
        return myGrade >= minOnly
    end

    local keyed = job[myJob]
    if keyed ~= nil then
        if type(keyed) == 'boolean' then
            return keyed == true
        end

        local required = tonumber(keyed)
        if required then
            return myGrade >= required
        end

        return true
    end

    local isGradesOnly = (#job > 0)
    if isGradesOnly then
        for cd = 1, #job do
            if tonumber(job[cd]) == nil then
                isGradesOnly = false
                break
            end
        end
    end

    if isGradesOnly then
        for cd = 1, #job do
            if myGrade == tonumber(job[cd]) then
                return true
            end
        end
        return false
    end

    for _, value in ipairs(job) do
        if value == myJob then
            return true
        end
    end

    return false
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                GANG                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the gang name of the player
function GetGangName(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.name
    end

    local Player = GetPlayer(source)
    if not Player then return end
    return Player.PlayerData.gang.name
end

-- Get the gang label of the player
function GetGangLabel(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.label
    end

    local Player = GetPlayer(source)
    if not Player then return end
    return Player.PlayerData.gang.label
end

-- Get the gang grade of the player
function GetGangGrade(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.grade
    end

    local Player = GetPlayer(source)
    if not Player then return end
    return Player.PlayerData.gang.grade.level
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               MONEY                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the amount of money a player has
function GetPlayerMoney(source, money_type)
    local Player = GetPlayer(source)
    if not Player then return end

    if money_type == 'bank' then
        return Player.PlayerData.money['bank']

    elseif money_type == 'cash' then
        return Player.PlayerData.money['cash']
    end
end

-- Add money to a player
function AddPlayerMoney(source, amount, money_type, reason)
    local Player = GetPlayer(source)
    if not Player then return end
    reason = reason or ''

    if money_type == 'bank' then
        Player.Functions.AddMoney('bank', amount, reason)

    elseif money_type == 'cash' then
        Player.Functions.AddMoney('cash', amount, reason)
    end
end

-- Remove money from a player
function RemovePlayerMoney(source, amount, money_type, reason)
    local Player = GetPlayer(source)
    if not Player then return end
    if amount <= 0 then return end
    reason = reason or ''

    local balance = GetPlayerMoney(source, money_type)
    if balance < amount then
        return false
    end

    if money_type == 'bank' then
        Player.Functions.RemoveMoney('bank', amount, reason)
        return true

    elseif money_type == 'cash' then
        Player.Functions.RemoveMoney('cash', amount, reason)
        return true
    end
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               ITEMS                              │
-- └──────────────────────────────────────────────────────────────────┘

function RegisterUsableItem(item_name, onUse)
    QBCore.Functions.CreateUseableItem(item_name, function(source)
        if onUse then
            onUse(source)
        end
    end)
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           GET SHARED DATA                        │
-- └──────────────────────────────────────────────────────────────────┘

-- Get a formatted table of all shared vehicles
function GetSharedVehicles()
    if next(SharedVehicles) ~= nil then
        return SharedVehicles
    end

    local customSharedVehicles = GetCustomSharedVehicles()
    if customSharedVehicles then
        SharedVehicles = customSharedVehicles
        return SharedVehicles
    end

    for _, vehicle in pairs(QBCore.Shared.Vehicles) do
        if vehicle.hash ~= nil then
            if type(vehicle.hash) == 'string' then
                vehicle.hash = tonumber(vehicle.hash) or GetHashKey(vehicle.hash)
            end
            SharedVehicles[vehicle.hash] = {
                name = vehicle.name,
                model = vehicle.model,
                hash = vehicle.hash,
                price = vehicle.price,
                category = vehicle.category
            }
        end
    end
    return SharedVehicles
end

-- Get a formatted table of all shared jobs
function GetSharedJobs()
    if next(SharedJobs) ~= nil then
        return SharedJobs
    end

    for name, job in pairs(QBCore.Shared.Jobs) do
        SharedJobs[name] = {
            name = name,
            label = job.label,
            grades = {},
            boss_grade = nil,
        }

        for _, cd in pairs(job.grades) do
            SharedJobs[name].grades[tonumber(cd.grade)] = {
                grade = cd.grade,
                name = cd.name,
                boss = cd.isboss ~= nil and cd.isboss or false
            }

            if cd.isboss then
                SharedJobs[name].boss_grade = cd.grade
            end
        end
    end
    return SharedJobs
end

