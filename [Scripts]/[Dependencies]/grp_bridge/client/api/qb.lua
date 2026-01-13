if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local GRP = {}

function GRP.IsPlayerLoaded()
    return (LocalPlayer and LocalPlayer.state and LocalPlayer.state.isLoggedIn) == true
end

function GRP.GetPlayerData()
    return QBCore.Functions.GetPlayerData()
end

function GRP.SetPlayerData(key, value)
    return error("QB Core doesn't support SetPlayerData!")
end

function GRP.OpenInventory()
    TriggerEvent("inventory:client:OpenInventory")
end

function GRP.ShowNotification(text)
    QBCore.Functions.Notify(text)
end

function GRP.CloseMenu()
    TriggerEvent("qb-menu:client:closeMenu")
end

function GRP.GetJob()
    local playerData = GRP.GetPlayerData()
    return playerData.job.name or "unemployed"
end

function GRP.GetJobGrade()
    local playerData = GRP.GetPlayerData()
    return playerData.job.grade.level
end

function GRP.GetJobInfo()
    local playerData = GRP.GetPlayerData()
    local job = playerData.job
    local isBoss = (job.grade.name == "boss")
    return {
        jobName = job.name,
        jobLabel = job.label,
        gradeName = job.grade.name,
        gradeLabel = job.grade.label,
        gradeRank = job.grade.level,
        boss = isBoss,
        onDuty = job.onduty
    }
end

function GRP.HasItem(item_name)
    local pd = QBCore.Functions.GetPlayerData()
    local total = 0
    if pd and pd.items then
        for _, it in pairs(pd.items) do
            if it and it.name == item_name then
                total = total + (it.amount or 0)
            end
        end
    end
    return total > 0, total
end

function GRP.GetInventory()
    return QBCore.Functions.GetPlayerData().items
end

function GRP.GetPlayerMetaData(metadata)
    return GRP.GetPlayerData().metadata[metadata]
end

function GRP.GetIsPlayerDead()
    local playerData = GRP.GetPlayerData()
    return playerData.metadata["isdead"] or playerData.metadata["inlaststand"]
end

function GRP.GetPlayerName()
    local data = QBCore.Functions.GetPlayerData()
    local firstName, lastName = "", ""
    
    if data and data.charinfo then
        firstName = data.charinfo.firstname or ""
        lastName = data.charinfo.lastname or ""
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