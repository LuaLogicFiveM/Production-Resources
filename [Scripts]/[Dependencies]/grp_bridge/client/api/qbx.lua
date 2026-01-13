if GetResourceState('qbx_core') ~= 'started' then return end

local GRP = {}

function GRP.IsPlayerLoaded()
    return (LocalPlayer and LocalPlayer.state and LocalPlayer.state.isLoggedIn) == true
end

function GRP.GetPlayerData()
    return exports.qbx_core:GetPlayerData()
end

function GRP.SetPlayerData(key, value)
    exports.qbx_core:SetPlayerData(key, value)
end

function GRP.OpenInventory()
    local ox = exports.ox_inventory
    if ox and ox.openInventory then
        ox:openInventory('player')
    else
        TriggerEvent('ox_inventory:openInventory')
    end
end

function GRP.ShowNotification(text)
    exports.qbx_core:Notify(text)
end

function GRP.CloseMenu()
    exports.ox_lib:hideContext()
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
    local item = exports.ox_inventory:GetItem(item_name)
    if item then
        return (item.count or 0) > 0, (item.count or 0)
    end
    return false, 0
end

function GRP.GetInventory()
    return exports.ox_inventory:GetInventory()
end

function GRP.GetPlayerMetaData(metadata)
    return GRP.GetPlayerData().metadata[metadata]
end

function GRP.GetIsPlayerDead()
    local playerData = GRP.GetPlayerData()
    return playerData.metadata["isdead"] or playerData.metadata["inlaststand"]
end

function GRP.GetPlayerName()
    local data = exports.qbx_core:GetPlayerData()
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