if GetResourceState('qbx_core') ~= 'started' then return end

local GRP = {}
local core = exports.qbx_core


function GRP.GetPlayer(id)
    return core:GetPlayer(id)
end

function GRP.GetAllPlayers()
    local playerSources = {}
    if core.GetQBPlayers then
        local players = core:GetQBPlayers()
        for src, _ in pairs(players) do
            playerSources[#playerSources + 1] = src
        end
    else
        playerSources = GetPlayers()
    end
    return playerSources
end



function GRP.GetPlayerJob(id)
    local p = core:GetPlayer(id); if not p then return nil,nil,nil,nil end
    local j = p.PlayerData.job
    return j.name, j.label, j.grade and j.grade.name, j.grade and j.grade.level
end

function GRP.GetPlayerJobGrade(id)
    local p = core:GetPlayer(id); if not p then return 0 end
    return p.PlayerData.job.grade.level
end

function GRP.GetPlayerJobInfo(id)
    local p = core:GetPlayer(id)
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
        if core:HasGroup(id, group) then
            return true
        end
    end
    return false
end

function GRP.AddMoney(id, amt)
    core:AddMoney(id, 'cash', amt, 'grp_bridge'); return true
end

function GRP.RemoveMoney(id, amt)
    core:RemoveMoney(id, 'cash', amt, 'grp_bridge'); return true
end

function GRP.RemoveBankMoney(id, amt)
    core:RemoveMoney(id, 'bank', amt, 'grp_bridge'); return true
end

function GRP.GetMoney(id)
    return core:GetMoney(id, 'cash')
end

function GRP.GetBankMoney(id)
    return core:GetMoney(id, 'bank')
end

function GRP.TransferMoney(from, to, amount)
    local senderMoney = core:GetMoney(from, 'bank')
    if senderMoney >= amount then
        core:RemoveMoney(from, 'bank', amount, 'grp_bridge_transfer')
        core:AddMoney(to, 'bank', amount, 'grp_bridge_transfer')
        return true, "Success"
    else
        return false, "Not enough money in sender's account"
    end
end

function GRP.SetJob(id, job, grade)
    core:SetJob(id, job, grade); return true
end

function GRP.GetIdentifier(id)
    local player = core:GetPlayer(id)
    if player and player.PlayerData then
        return player.PlayerData.citizenid or player.PlayerData.license or GetPlayerIdentifierByType(id, 'license')
    end
    return GetPlayerIdentifierByType(id, 'license')
end

function GRP.GetPlayerByCitizenId(cid)
    if core.GetPlayerByCitizenId then
        return core:GetPlayerByCitizenId(cid)
    end
    for _, src in ipairs(GetPlayers()) do
        local player = core:GetPlayer(src)
        if player and player.PlayerData.citizenid == cid then
            return player
        end
    end
    return nil
end


function GRP.GetPlayerName(id)
    local p = core:GetPlayer(id)
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
    local p = core:GetPlayer(id)
    if not p then return false end
    local playerData = p.PlayerData
    return playerData.metadata[metadata] or false
end

function GRP.SetPlayerMetadata(id, metadata, value)
    local p = core:GetPlayer(id)
    if not p then return false end
    p.Functions.SetMetaData(metadata, value)
    return true
end

function GRP.GetPlayerDuty(id)
    local p = core:GetPlayer(id)
    if not p then return false end
    local playerData = p.PlayerData
    if not playerData.job.onduty then return false end
    return true
end

function GRP.GetIsPlayerDead(id)
    local p = core:GetPlayer(id)
    if not p then return false end
    local playerData = p.PlayerData
    return playerData.metadata.isdead or false
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
    return core:CreateUseableItem(itemName, func)
end

return GRP