if Cfg.Framework ~= 'other' then return end

FRAMEWORK = nil
local SharedVehicles = {}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            INITIALIZE                            │
-- └──────────────────────────────────────────────────────────────────┘

--- Check if the framework is loaded
--- @return boolean         --True if the framework is loaded, false otherwise.
function HasFrameworkLoaded()
    return true
end

-- Initialize the framework object here (if needed).
local function initateFramework()
    RegisterNetEvent('FRAMEWORK:playerLoaded', function(player)
        -- Cache the job data (if needed).
        TriggerEvent('cd_bridge:TriggerStartEvents', GetCurrentResourceName())
    end)

    RegisterNetEvent('FRAMEWORK:JobChanged', function(job)
        -- Update the cached job data (if needed).
    end)

    RegisterNetEvent('FRAMEWORK:GangChanged', function(gang)
        -- Update the cached gang data (if needed).
    end)

    RegisterNetEvent('FRAMEWORK:DutyChanged', function(duty)
        -- Update the cached job data (if needed).
    end)
end
initateFramework()

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                JOB                               │
-- └──────────────────────────────────────────────────────────────────┘

--- Get the job name of a player
--- @return string          --The player's job name.
function GetJobName()
    return 'police'
end

--- Get the job label of a player
--- @return string           --The player's job label.
function GetJobLabel()
    return 'LSPD'
end

--- Get the job grade of a player
--- @return number              --The player's job grade.
function GetJobGrade()
    return 0
end

--- Get the job label of a player
--- @return string            --The player's job grade label.
function GetJobGradeLabel()
    return 'Recruit'
end

--- Check if a player is on duty
--- @return boolean         --True if the player is on duty, false otherwise.
function GetJobDuty()
    if Cfg.DisableDuty then
        return true
    end

    local customDuty = GetCustomJobDuty()
    if customDuty ~= nil then
        return customDuty
    end

    return true
end

-- Check if a player has the job
--- @param job string|table     The job name or a table of job names.
--- @return boolean             --True if the player has the job, false otherwise.
function HasJob(job)
    local myJob = GetJobName()
    if not myJob or not GetJobDuty() or not GetJobGrade() then return false end

    local myGrade = tonumber(GetJobGrade())
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
--- @return string            --The player's gang name.
function GetGangName()
    local customGang = GetCustomGang()
    if customGang ~= nil then
        return customGang.name
    end
    return 'none'
end

--- Get the gang label of the player
--- @return string            --The player's gang label.
function GetGangLabel()
    local customGang = GetCustomGang()
    if customGang ~= nil then
        return customGang.label
    end
    return 'No Gang'
end

-- Get the gang grade of the player
--- @return number            --The player's gang grade.
function GetGangGrade()
    local customGang = GetCustomGang()
    if customGang ~= nil then
        return customGang.grade
    end
    return 0
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           GET SHARED DATA                        │
-- └──────────────────────────────────────────────────────────────────┘

-- Get a formatted table of all shared vehicles
--- @return table         --A table of all shared vehicles.
function GetSharedVehicles()
    if next(SharedVehicles) ~= nil then
        return SharedVehicles
    else
        SharedVehicles = exports.cd_bridge:Callback('cd_bridge:GetSharedVehicles')
        return SharedVehicles
    end
end