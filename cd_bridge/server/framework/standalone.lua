if Cfg.Framework ~= 'standalone' then return end

local CharacterNames = {}
local SharedVehicles = {}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            INITIALIZE                            │
-- └──────────────────────────────────────────────────────────────────┘

function HasFrameworkLoaded()
    return true
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              PLAYER                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the player object
function GetPlayer(source)
    return true
end

-- Get a specific identifier of a player
function GetIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license')
end

-- Get the license identifier of a player
function GetLicenseIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license')
end

-- Get the source from a unique identifier
function GetSourceFromIdentifier(identifier)
    local players = GetPlayers()
    for _, src in pairs(players) do
        local id = GetIdentifier(src)
        if id == identifier then
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

    local char_name = GetPlayerName(source) or Locale('unknown')
    CharacterNames[source] = char_name
    return char_name
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               PERMS                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the admin permissions/group of a player
function GetAdminPerms(source)
    return true
end

-- Check if a player has admin permissions
function HasAdminPerms(source, perms)
    return true
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                JOB                               │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the job name of a player
function GetJobName(source)
    return 'unemployed'
end

-- Get the job label of a player
function GetJobLabel(source)
    return 'Unemployed'
end

-- Get the job grade of a player
function GetJobGrade(source)
    return 0
end

-- Get the job label of a player
function GetJobGradeLabel(source)
    return 'Unemployed'
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

    return true
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
    return 'none'
end

-- Get the gang label of the player
function GetGangLabel(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.label
    end
    return 'No Gang'
end

-- Get the gang grade of the player
function GetGangGrade(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.grade
    end
    return 0
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               MONEY                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the amount of money a player has
function GetPlayerMoney(source, money_type)
    local Player = GetPlayer(source)
    if not Player then return end

    return 1000000000
end

-- Remove money from a player
function RemovePlayerMoney(source, amount, money_type, reason)
    return true
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               ITEMS                              │
-- └──────────────────────────────────────────────────────────────────┘

function RegisterUsableItem(item_name, onUse)
    return true
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           GET SHARED DATA                        │
-- └──────────────────────────────────────────────────────────────────┘

-- Get all shared vehicles
function GetSharedVehicles()
    if next(SharedVehicles) ~= nil then
        return SharedVehicles
    end

    local customSharedVehicles = GetCustomSharedVehicles()
    if customSharedVehicles then
        SharedVehicles = customSharedVehicles
        return SharedVehicles
    end

    return SharedVehicles
end

function GetSharedJobs()
    return {}
end