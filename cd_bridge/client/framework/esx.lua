if Cfg.Framework ~= 'esx' then return end

ESX = nil
local JobData = {}
local LastJobData = {}
local SharedVehicles = {}
local CharacterName = nil

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            INITIALIZE                            │
-- └──────────────────────────────────────────────────────────────────┘

function HasFrameworkLoaded()
    return ESX ~= nil
end

-- Initialize the framework object
local function initateFramework()
    local function normalizeDuty(duty)
        return (duty ~= nil) and (duty == true or duty == 1 or duty == 'on') or true
    end

    local function cacheJobData(data)
        if not data then return end

        local onDuty = normalizeDuty(data.onDuty)

        local newJob = {
            name = data.name,
            label = data.label,
            grade = data.grade,
            on_duty = onDuty
        }

        JobData.name = data.name
        JobData.label = data.label
        JobData.grade = data.grade
        JobData.on_duty = onDuty

        return newJob
    end

    while ESX == nil do
        pcall(function()
            ESX = exports['es_extended']:getSharedObject()
        end)

        if not ESX then
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
        end

        if not ESX then
            Wait(10)
        end
    end

    local function refreshPlayerData()
        local player = ESX.PlayerData
        if player and player.job then
            LastJobData = cacheJobData(player.job)
        end
    end

    refreshPlayerData()

    RegisterNetEvent('esx:playerLoaded', function(player)
        if player and player.job then
            LastJobData = cacheJobData(player.job)
        else
            refreshPlayerData()
        end

        TriggerEvent('cd_bridge:TriggerStartEvents', GetCurrentResourceName())
    end)

    RegisterNetEvent('esx:setJob', function(job)
        local old = LastJobData or { name=nil, label=nil, grade=0, on_duty=true }

        local new = {
            name = job.name,
            label = job.label,
            grade = job.grade,
            on_duty = normalizeDuty(job.onDuty)
        }

        TriggerEvent('cd_bridge:OnJobChanged', {
            job_changed = old.name ~= new.name,
            grade_changed = old.grade ~= new.grade,
            duty_changed = old.on_duty ~= new.on_duty,
            old = old,
            new = new
        })

        LastJobData = new
        cacheJobData(job)
    end)
end

initateFramework()

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              PLAYER                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get a players character name
function GetCharacterName()
    if CharacterName then
        return CharacterName
    end

    CharacterName = exports.cd_bridge:Callback('cd_bridge:GetCharacterName')
    return CharacterName
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               PERMS                              │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the admin permissions/group of a player
function GetAdminPerms()
    return exports.cd_bridge:Callback('cd_bridge:GetAdminPerms')
end

-- Check if a player has admin permissions
function HasAdminPerms(perms)
    if not perms then
        return false
    end
    return exports.cd_bridge:Callback('cd_bridge:HasAdminPerms', perms)
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                JOB                               │
-- └──────────────────────────────────────────────────────────────────┘

-- Get the job name of the player
function GetJobName()
    return JobData.name
end

-- Get the job label of the player
function GetJobLabel()
    return JobData.label
end

-- Get the job grade of the player
function GetJobGrade()
    return JobData.grade
end

-- Get the job grade label of the player
function GetJobGradeLabel()
    return JobData.name
end

-- Get if the player is on duty
function GetJobDuty()
    local customDuty = GetCustomJobDuty()
    if customDuty ~= nil then
        return customDuty
    end
    return JobData.on_duty
end

-- Check if a player has the job
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

-- Get the gang name of the player
function GetGangName()
    local customGang = GetCustomGang()
    if customGang ~= nil then
        return customGang.name
    end
    return 'none'
end

-- Get the gang label of the player
function GetGangLabel()
    local customGang = GetCustomGang()
    if customGang ~= nil then
        return customGang.label
    end
    return 'No Gang'
end

-- Get the gang grade of the player
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
function GetSharedVehicles()
    if next(SharedVehicles) ~= nil then
        return SharedVehicles
    else
        SharedVehicles = exports.cd_bridge:Callback('cd_bridge:GetSharedVehicles')
        return SharedVehicles
    end
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              VEHICLE                             │
-- └──────────────────────────────────────────────────────────────────┘

function FrameworkCreateVehicle(model, coords)
    local p = promise.new()
    local heading = coords.w or coords.h or 0.0

    ESX.Game.SpawnVehicle(model, vector3(coords.x, coords.y, coords.z), heading, function(veh)
        p:resolve(veh)
    end)

    return Citizen.Await(p)
end