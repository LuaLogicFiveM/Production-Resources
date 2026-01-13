if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()
local GRP = {}

function GRP.GetPlayer(id)
    return ESX.GetPlayerFromId(id)
end

function GRP.GetAllPlayers()
    return ESX.GetPlayers()
end

function GRP.GetPlayerJob(id)
    local x = GRP.GetPlayer(id); if not x then return nil,nil,nil,nil end
    local j = x.getJob()
    return j.name, j.label, j.grade_label, j.grade
end

function GRP.GetPlayerJobGrade(id)
    local x = GRP.GetPlayer(id); if not x then return 0 end
    return x.getJob().grade
end

function GRP.GetPlayerJobInfo(id)
    local x = GRP.GetPlayer(id)
    if not x then return {} end
    local job = x.getJob()
    local isBoss = (job.grade_name == "boss")
    return {
        jobName = job.name,
        jobLabel = job.label,
        gradeName = job.grade_name,
        gradeLabel = job.grade_label,
        gradeRank = job.grade,
        boss = isBoss,
        onDuty = job.onDuty or false
    }
end

function GRP.HasPermission(id)
    local x = GRP.GetPlayer(id)
    return config.AdminGroups[x.getGroup()]
end

function GRP.AddMoney(id, amt)
    local x = GRP.GetPlayer(id); if not x then return false end
    x.addMoney(amt); return true
end

function GRP.RemoveMoney(id, amt)
    local x = GRP.GetPlayer(id); if not x then return false end
    x.removeMoney(amt); return true
end

function GRP.RemoveBankMoney(id, amt)
    local x = GRP.GetPlayer(id); if not x then return false end
    x.removeAccountMoney("bank", amt); return true
end

function GRP.GetMoney(id)
    local x = GRP.GetPlayer(id)
    return x and x.getMoney() or 0
end

function GRP.GetBankMoney(id)
    local x = GRP.GetPlayer(id)
    return x and x.getAccount("bank").money or 0
end

function GRP.TransferMoney(from, to, amount)
    local xFrom = GRP.GetPlayer(from)
    local xTo   = GRP.GetPlayer(to)
    if not xFrom or not xTo then return false, "Player not found" end
    if xFrom.getAccount("bank").money >= amount then
        xFrom.removeAccountMoney("bank", amount)
        xTo.addAccountMoney("bank", amount)
        return true, "Success"
    else
        return false, "Not enough money in sender's account"
    end
end

function GRP.SetJob(id, job, grade)
    local x = GRP.GetPlayer(id); if not x then return false end
    x.setJob(job, grade); return true
end

function GRP.GetIdentifier(id)
    local x = GRP.GetPlayer(id)
    return x and x.getIdentifier() or nil
end

function GRP.GetPlayerByCitizenId(cid)
    for _, playerId in ipairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer and xPlayer.getIdentifier and xPlayer.getIdentifier() == cid then
            return xPlayer
        end
    end
    return nil
end

function GRP.GetPlayerName(id)
    local xPlayer = GRP.GetPlayer(id)
    if not xPlayer then return "", "" end
    local firstName = xPlayer.firstName or xPlayer.firstname or ""
    local lastName  = xPlayer.lastName  or xPlayer.lastname  or ""
    if (firstName == "" and lastName == "") and xPlayer.getName then
        local full = xPlayer.getName() or ""
        local fn, ln = full:match("^(%S+)%s*(.*)$")
        firstName = fn or full
        lastName  = ln or ""
    end
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
    local x = GRP.GetPlayer(id)
    if not x then return false end
    return x.getMeta(metadata) or false
end

function GRP.SetPlayerMetadata(id, metadata, value)
    local x = GRP.GetPlayer(id)
    if not x then return false end
    if x.setMeta then
        x.setMeta(metadata, value)
        return true
    else
        x.set(metadata, value)
        return true
    end
end

function GRP.GetPlayerDuty(id)
    local x = GRP.GetPlayer(id)
    if not x then return false end
    local job = x.getJob()
    if not job.onDuty then return false end
    return true
end

function GRP.GetIsPlayerDead(id)
    local x = GRP.GetPlayer(id)
    if not x then return false end
    return x.get("is_dead") or false
end

function GRP.RevivePlayer(id)
    TriggerEvent('esx_ambulancejob:revive', id)
    return true
end

function GRP.RegisterUsableItem(itemName, cb)
    local func = function(src, item, itemData)
        itemData = itemData or item
        itemData.metadata = itemData.metadata or itemData.info or {}
        itemData.slot = itemData.id or itemData.slot
        cb(src, itemData)
    end
    ESX.RegisterUsableItem(itemName, func)
    return true
end

return GRP