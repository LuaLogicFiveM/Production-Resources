if Cfg.Framework ~= 'other' then return end

FRAMEWORK = nil
local CharacterNames = {}
local SharedVehicles = {}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            INITIALIZE                            │
-- └──────────────────────────────────────────────────────────────────┘

-- Initialize the framework object here if needed.

--- Check if the framework is loaded
--- @return boolean         --True if the framework is loaded, false otherwise.
function HasFrameworkLoaded()
    return true
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              PLAYER                              │
-- └──────────────────────────────────────────────────────────────────┘

--- Get the player object
--- @param source number    The player's server ID.
--- @return table           --The player object.
function GetPlayer(source)
    return {}
end

--- Get the unique identifier of a player
--- @param source number    The player's server ID.
--- @return string          --The player's unique identifier.
function GetIdentifier(source)
    return 'ACBD1234'
end

-- Get the license identifier of a player
--- @param source number    The player's server ID.
--- @return string          --The player's license identifier.
function GetLicenseIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license')
end

-- Get the source from a unique identifier
--- @param identifier string    The unique identifier to search for.
--- @return number              --The player's server ID.
function GetSourceFromIdentifier(identifier)
    return 0
end

--- Get a players character name
--- @param source number        The player's server ID.
--- @return string              --The player's character name.
function GetCharacterName(source)
    if CharacterNames[source] then
        return CharacterNames[source]
    end

    CharacterNames[source] = 'John_Doe'
    return 'John_Doe'
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               PERMS                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the admin permissions/group of a player
--- @param source number        The player's server ID.
--- @return string|table        The player's permission group(s). Can return:
---                             * string - e.g. "admin"
---                             * table  - e.g. { "admin", "god" } or { admin = true }
function GetAdminPerms(source)
    return 'admin'
end

-- Check if a player has admin permissions
--- @param source number        The player's server ID.
--- @param perms string|table   The permission(s) to check for. Can be:
--- @                             * string - e.g. "admin"
--- @                             * table  - e.g. { "admin", "god" } or
--- @                             * table  - e.g. { admin = true }
--- @return boolean             --True if the player has the specified permission(s), false otherwise.
function HasAdminPerms(source, perms)
    if not perms then return false end

    local playerPerm = GetAdminPerms(source)
    if not playerPerm then return false end

    local p = tostring(playerPerm):lower()
    local t = type(perms)

    if t == 'string' then
        return p == perms:lower()
    end

    if t == 'table' then
        for key, value in pairs(perms) do

            if type(key) == 'string' and key:lower() == p then
                return true
            end

            if type(value) == 'string' and value:lower() == p then
                return true
            end
        end
    end

    return false
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                JOB                               │
-- └──────────────────────────────────────────────────────────────────┘

--- Get the job name of a player
--- @param source number    The player's server ID.
--- @return string          --The player's job name.
function GetJobName(source)
    return 'police'
end

--- Get the job label of a player
--- @param source number     The player's server ID.
--- @return string           --The player's job label.
function GetJobLabel(source)
    return 'LSPD'
end

--- Get the job grade of a player
--- @param source number        The player's server ID.
--- @return number              --The player's job grade.
function GetJobGrade(source)
    return 0
end

--- Get the job label of a player
--- @param source number      The player's server ID.
--- @return string            --The player's job grade label.
function GetJobGradeLabel(source)
    return 'Recruit'
end

--- Check if a player is on duty
--- @param source number    The player's server ID.
--- @return boolean         --True if the player is on duty, false otherwise.
function GetJobDuty(source)
    if Cfg.DisableDuty then
        return true
    end

    local customDuty = GetCustomJobDuty()
    if customDuty ~= nil then
        return customDuty
    end

    return true
end

-- Check if the player has the job
--- @param source number    The player's server ID.
--- @param job string|table The job name or a table of job names to check against.
--- @return boolean         --True if the player has the specified job, false otherwise.
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


--- Get the gang name of the player
--- @param source number      The player's server ID.
--- @return string            --The player's gang name.
function GetGangName(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.name
    end
    return 'none'
end

--- Get the gang label of the player
--- @param source number      The player's server ID.
--- @return string            --The player's gang label.
function GetGangLabel(source)
    local customGang = GetCustomGang(source)
    if customGang ~= nil then
        return customGang.label
    end
    return 'No Gang'
end

-- Get the gang grade of the player
--- @param source number      The player's server ID.
--- @return number            --The player's gang grade.
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

--- Get the amount of money a player has
--- @param source number        The player's server ID.
--- @param money_type string    The type of money ('cash' or 'bank').
--- @return number              --The amount of money the player has.
function GetPlayerMoney(source, money_type)
    if money_type == 'bank' then
        return 0

    elseif money_type == 'cash' then
        return 0
    end
    return 0
end

--- Add money to a player
--- @param source number        The player's server ID.
--- @param amount number        The amount of money to add.
--- @param money_type  string   The type of money ('cash' or 'bank').
function AddPlayerMoney(source, amount, money_type)
    if money_type == 'bank' then
        -- add money here.
    elseif money_type == 'cash' then
        -- add money here.
    end
end

--- Remove money from a player
--- @param source number        The player's server ID.
--- @param amount number        The amount of money to remove.
--- @param money_type string    The type of money ('cash' or 'bank').
--- @param reason string        The reason for removing the money.
--- @return boolean             --True if the money was removed, false otherwise.
function RemovePlayerMoney(source, amount, money_type, reason)
    if amount <= 0 then return false end
    reason = reason or ''

    local balance = GetPlayerMoney(source, money_type)
    if balance < amount then
        return false
    end

    if money_type == 'bank' then
        -- remove money here.
        return true

    elseif money_type == 'cash' then
        -- remove money here.
        return true
    end
    return false
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               ITEMS                              │
-- └──────────────────────────────────────────────────────────────────┘

--- Register a usable item
--- @param item_name string        The name of the usable item.
--- @param onUse function          The function to call when the item is used.
function RegisterUsableItem(item_name, onUse)
    -- Register usable item here.
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           GET SHARED DATA                        │
-- └──────────────────────────────────────────────────────────────────┘

-- Get a formatted table of all shared vehicles
--- @return table         --A table of all shared vehicles.
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

-- Get a formatted table of all shared jobs
--- @return table         --A table of all shared jobs.
function GetSharedJobs()
    return {}
end