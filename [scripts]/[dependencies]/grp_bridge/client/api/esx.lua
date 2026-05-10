if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports["es_extended"]:getSharedObject()
local GRP = {}

function GRP.IsPlayerLoaded()
    return ESX.IsPlayerLoaded()
end

function GRP.GetPlayerData()
    return ESX.GetPlayerData()
end

function GRP.SetPlayerData(key, value)
    ESX.SetPlayerData(key, value)
end

function GRP.OpenInventory()
    ESX.ShowInventory()
end

function GRP.ShowNotification(text)
    ESX.ShowNotification(text)
end

function GRP.CloseMenu()
    ESX.UI.Menu.CloseAll()
end

function GRP.GetJob()
    local playerData = GRP.GetPlayerData()
    return playerData.job.name or "unemployed"
end

function GRP.GetJobGrade()
    local playerData = GRP.GetPlayerData()
    return playerData.job.grade
end

function GRP.GetJobInfo()
    local playerData = GRP.GetPlayerData()
    local job = playerData.job
    local isBoss = (job.grade_name == "boss")
    return {
        jobName = job.name,
        jobLabel = job.label,
        gradeName = job.grade_name,
        gradeLabel = job.grade_label,
        gradeRank = job.grade,
        boss = isBoss,
        onDuty = job.onduty
    }
end

function GRP.HasItem(item_name)
    local count = 0
    for _, v in pairs(GRP.GetPlayerData().inventory or {}) do
        if v.name == item_name then
            count = v.count or 0
            return count > 0, count
        end
    end
    return false, 0
end

function GRP.GetInventory()
    local playerData = GRP.GetPlayerData()
    return playerData.inventory
end

function GRP.GetPlayerMetaData(metadata)
    return GRP.GetPlayerData().metadata[metadata]
end

function GRP.GetIsPlayerDead()
    local playerData = GRP.GetPlayerData()
    return playerData.dead
end

function GRP.GetPlayerName()
    local data = ESX.GetPlayerData()
    local firstName, lastName = "", ""
    
    if data then
        if data.firstName or data.lastName then
            firstName = data.firstName or ""
            lastName = data.lastName or ""
        elseif data.name then
            local fn, ln = data.name:match("^(%S+)%s*(.*)$")
            firstName = fn or data.name
            lastName = ln or ""
        end
    end
    
    return tostring(firstName), tostring(lastName)
end

function GRP.Dispatch(code, title, message, blip, jobs, important)
    if config.Dispatch:lower() == "cd_dispatch" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = jobs or { "police" },
            coords = data.coords,
            title = ("%s - %s"):format(code or "10-00", title or "Missing Title"),
            message = message or "Sample Message",
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = blip,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = title,
                time = 5,
                radius = 0,
            }
        })
    elseif config.Dispatch:lower() == "linden" then
        local data = {
            displayCode = code,
            description = title,
            isImportant = important and 1 or 0,
            recipientList = jobs,
            length = '10000',
            infoM = 'fa-info-circle',
            info = message
        }
        local dispatchData = { dispatchData = data, caller = 'Alarm', coords = GetEntityCoords(PlayerPedId()) }
        TriggerServerEvent('wf-alerts:svNotify', dispatchData)
    elseif config.Dispatch:lower() == "custom" then
    end
end


return GRP