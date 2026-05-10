if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local GRP = {}

local GetPlayer = QBCore.Functions.GetPlayer
local GetPlayers = QBCore.Functions.GetPlayers

function GRP.GetPlayer(id)
    return GetPlayer(id)
end

function GRP.GetAllPlayers()
    return GetPlayers()
end

function GRP.GetPlayerJob(id)
    local p = GetPlayer(id); if not p then return nil,nil,nil,nil end
    local j = p.PlayerData.job
    return j.name, j.label, j.grade and j.grade.name, j.grade and j.grade.level
end

function GRP.GetPlayerJobGrade(id)
    local p = GetPlayer(id); if not p then return 0 end
    return p.PlayerData.job.grade.level
end

function GRP.GetPlayerJobInfo(id)
    local p = GetPlayer(id)
    if not p then return {} end
    local playerData = p.PlayerData
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

function GRP.HasPermission(id)
    for group, _ in pairs(config.AdminGroups) do
        if QBCore.Functions.HasPermission(id, group) then
            return true
        end
    end
    return false
end

function GRP.AddMoney(id, amt)
    local p = GetPlayer(id); if not p then return false end
    p.Functions.AddMoney('cash', amt, 'grp_bridge'); return true
end

function GRP.RemoveMoney(id, amt)
    local p = GetPlayer(id); if not p then return false end
    p.Functions.RemoveMoney('cash', amt, 'grp_bridge'); return true
end

function GRP.RemoveBankMoney(id, amt)
    local p = GetPlayer(id); if not p then return false end
    p.Functions.RemoveMoney('bank', amt, 'grp_bridge'); return true
end

function GRP.GetMoney(id)
    local p = GetPlayer(id)
    return p and p.Functions.GetMoney('cash') or 0
end

function GRP.GetBankMoney(id)
    local p = GetPlayer(id)
    return p and p.Functions.GetMoney('bank') or 0
end

function GRP.TransferMoney(from, to, amount)
    local s = GetPlayer(from)
    local r = GetPlayer(to)
    if not s or not r then return false, "Player not found" end
    local bal = s.Functions.GetMoney('bank')
    if bal >= amount then
        s.Functions.RemoveMoney('bank', amount, 'grp_bridge_transfer')
        r.Functions.AddMoney('bank', amount, 'grp_bridge_transfer')
        return true, "Success"
    else
        return false, "Not enough money in sender's account"
    end
end

function GRP.SetJob(id, job, grade)
    local p = GetPlayer(id); if not p then return false end
    p.Functions.SetJob(job, grade); return true
end

function GRP.GetIdentifier(id)
    local p = GetPlayer(id)
    return p and p.PlayerData and p.PlayerData.citizenid or nil
end

function GRP.GetPlayerByCitizenId(cid)
    local Player = QBCore.Functions.GetPlayerByCitizenId(cid)
    return Player and Player.PlayerData or nil
end

function GRP.GetPlayerName(id)
    local p = GetPlayer(id)
    local c = p and p.PlayerData and p.PlayerData.charinfo
    local firstName = c and (c.firstname or "") or ""
    local lastName  = c and (c.lastname  or "") or ""
    return tostring(firstName), tostring(lastName)
end

function GRP.GetPlayerCoords(id)
    local ped = GetPlayerPed(id)
    if not ped or ped == 0 then
        return vector3(0.0, 0.0, 0.0)
    end
    return GetEntityCoords(ped)
end

function GRP.GetPlayerMetadata(id, metadata)
    local p = GetPlayer(id)
    if not p then return false end
    local playerData = p.PlayerData
    return playerData.metadata[metadata] or false
end

function GRP.SetPlayerMetadata(id, metadata, value)
    local p = GetPlayer(id)
    if not p then return false end
    p.Functions.SetMetaData(metadata, value)
    return true
end

function GRP.GetPlayerDuty(id)
    local p = GetPlayer(id)
    if not p then return false end
    local playerData = p.PlayerData
    if not playerData.job.onduty then return false end
    return true
end

function GRP.GetIsPlayerDead(id)
    local p = GetPlayer(id)
    if not p then return false end
    local playerData = p.PlayerData
    return playerData.metadata.isdead or playerData.metadata.inlaststand or false
end

function GRP.RevivePlayer(id)
    TriggerClientEvent('hospital:client:Revive', id)
    return true
end

function GRP.RegisterUsableItem(itemName, cb)
    local func = function(src, item, itemData)
        itemData = itemData or item
        itemData.metadata = itemData.metadata or itemData.info or {}
        itemData.slot = itemData.id or itemData.slot
        cb(src, itemData)
    end
    QBCore.Functions.CreateUseableItem(itemName, func)
    return true
end

return GRP