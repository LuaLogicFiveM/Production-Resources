---@enum
local stages = {
    get_to_depot = 1,
    fix_box = 2,
    return_vehicle = 3,
}

local stageLabels = {
    [stages.get_to_depot] = locale("GET_VEH_FROM_DEPOT"),
    [stages.fix_box] = locale("FIX_ELECTRIC_BOX_LABEL"),
    [stages.return_vehicle] = locale("RETURN_VEH_TO_DEPOT")
}

function GetJobPayoutBonus(source)
    return 0
end

function GetJobSpeedBonus(source)
    return 0
end

local getRandomBox = function(nearCoords, hasBoxes, maxRange)
    local boxes = {}
    for k, v in pairs(ElectricalBoxes) do
        if not v.active and (not hasBoxes or not hasBoxes[k]) then
            if nearCoords then
                if #(nearCoords - v.coords) < (maxRange or 200) then
                    boxes[#boxes+1] = k
                end
            else
                boxes[#boxes+1] = k
            end
        end
    end
    if #boxes == 0 then return end
    if #boxes == 1 then
        return boxes[1]
    end
    return boxes[math.random(1, #boxes)]
end

function GetMaxBoxes(job)
    return 3
end

function generateBoxes(job)
    if job.syncData.boxes then
        for k, v in pairs(job.syncData.boxes) do
            ElectricalBoxes[k].active = nil
        end
    end
    job.syncData.boxes = {}
    local boxes = {}
    local hasBoxes = {}
    for i = 1, job.syncData.boxCount do
        local boxId = getRandomBox(i ~= 1 and ElectricalBoxes[boxes[1]].coords, hasBoxes)
        if not boxId then break end
        hasBoxes[boxId] = true
        boxes[i] = boxId
    end
    if #boxes ~= job.syncData.boxCount then
        Citizen.Wait(0)
        return generateBoxes(job)
    end
    for k, v in pairs(boxes) do
        job.syncData.boxes[v] = { coords = ElectricalBoxes[v].coords, model = ElectricalBoxes[v].model }
        ElectricalBoxes[v].active = job.id
    end
end

---@param job Job
---@param stageId number
local setStage = function(job, stageId)
    job.syncData.stage = stageId
    if stageId == stages.get_to_depot then
        job.syncData.depot = math.random(#Config.Job.Electrical.depots)
        job:Notification("inform", stageLabels[stageId])
    elseif stageId == stages.fix_box then
        job.doingBox = {}
        job:Notification("inform", stageLabels[stageId])
    elseif stageId == stages.return_vehicle then
        job:Notification("inform", stageLabels[stageId])
    end
    job:SyncData()
end

RegisterNetEvent("prp-electrical:skipBox", function(boxId)
    local source = source
    local job = Job:GetByMember(source)
    if job and job.syncData.stage == stages.fix_box then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        if not boxId then
            return
        end
        local box = job.syncData.boxes[boxId]
        if not box then
            return
        end
        if #(playerCoords - box.coords) > 15 then
            return
        end
        if not job.doingBox then
            job.doingBox = {}
        end
        if job.doingBox[boxId] then
            return
        end
        ElectricalBoxes[boxId].active = nil
        job.syncData.boxes[boxId] = nil
        local hasBoxes = {}
        for k, v in pairs(job.syncData.boxes) do
            hasBoxes[k] = true
        end
        if not job.blacklistedBoxes then
            job.blacklistedBoxes = {}
        end
        job.blacklistedBoxes[boxId] = true
        for k, v in pairs(job.blacklistedBoxes) do
            hasBoxes[k] = true
        end
        local newBox = getRandomBox(playerCoords, hasBoxes, 300)
        if not newBox then
            if job:UpdateTaskProgress(1) then
                job.syncData.boxCount = GetMaxBoxes(job)
                generateBoxes(job)
                local totalSalary = Config.Job.Electrical.salaryPerBox
                for k, v in pairs(job.members) do
                    local playerSalary = math.floor(totalSalary + totalSalary * GetJobPayoutBonus(v.source))
                    TriggerEvent("prp-electricaljob:task:electrical", v.source, 1)
                    bridge.fw.notify(v.source, "success", (box ~= nil and locale("FINISHED_BOX_NEXT") or locale("FINISHED_BOX_NO_NEXT")), nil, 10000)
                    bridge.fw.addMoney(v.source, "bank", playerSalary, "electrical_job_payment")
                end
                if not next(job.syncData.boxes) then
                    return setStage(job, stages.return_vehicle)
                end
                setStage(job, stages.fix_box)
            else
                job:SyncData()
            end
            return
        end
        job.syncData.boxes[newBox] = { coords = ElectricalBoxes[newBox].coords, model = ElectricalBoxes[newBox].model }
        ElectricalBoxes[newBox].active = job.id
        bridge.fw.notify(source, "success", locale("SKIPPED_BOX"), nil, 10000)
        job:SyncData()
    end
end)

RegisterNetEvent("prp-electrical:fixBox", function(boxId)
    local source = source
    local job = Job:GetByMember(source)
    if job and job.syncData.stage == stages.fix_box then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        if not boxId then
            return
        end
        if not job.vehicle or not DoesEntityExist(job.vehicle) then
            return
        end
        if #(playerCoords - GetEntityCoords(job.vehicle)) > 150 then
            bridge.fw.notify(source, "error", locale("DUTY_VEHICLE_NOT_CLOSE"), nil, 10000)
            return
        end
        local box = job.syncData.boxes[boxId]
        if not box then
            return
        end
        if #(playerCoords - box.coords) > 15 then
            return
        end
        if not job.doingBox then
            job.doingBox = {}
        end
        if job.doingBox[boxId] then
            return
        end
        job.doingBox[boxId] = true
        local progTime, showTime, timesToDo = Config.Minigame.progTime, Config.Minigame.showTime, Config.Minigame.timesToDo
        local success = lib.callback.await("prp-electrical:fixBox", source, box.coords, box.model, progTime, showTime, timesToDo)
        job.doingBox[boxId] = nil
        if not success then
            return
        end
        ElectricalBoxes[boxId].active = nil
        job.syncData.boxes[boxId] = nil
        if job:UpdateTaskProgress(1) then
            job.syncData.boxCount = GetMaxBoxes(job)
            generateBoxes(job)
            local totalSalary = Config.Job.Electrical.salaryPerBox
            for k, v in pairs(job.members) do
                local playerSalary = math.floor(totalSalary + totalSalary * GetJobPayoutBonus(v.source))
                TriggerEvent("prp-electricaljob:task:electrical", v.source, 1)
                bridge.fw.notify(v.source, "success", (box ~= nil and locale("FINISHED_BOX_NEXT") or locale("FINISHED_BOX_NO_NEXT")), nil, 10000)
                bridge.fw.addMoney(v.source, "bank", playerSalary, "electrical_job_payment")
                local charId = bridge.fw.getIdentifier(v.source)
                bridge.log.send(
                    Config.Webhook,
                    "Electrical Job",
                    ("%s has fixed an electrical box and earned $%s"):format(bridge.fw.getCharacterName(charId), playerSalary)
                )
            end
            if not next(job.syncData.boxes) then
                return setStage(job, stages.return_vehicle)
            end
            setStage(job, stages.fix_box)
        else
            job:SyncData()
        end
    end
end)

function SquaredLength(v)
    return v.x*v.x + v.y*v.y + v.z*v.z;
end

local onStart = function(job)
    if job:GetMemberCount() > Config.Job.Electrical.maxMembers then
        job:Finish(false, false)
        job:Notification("error", locale("TOO_MANY_MEMBERS", Config.Job.Electrical.maxMembers), 8000)
        return
    end
    job.syncData.boxCount = GetMaxBoxes(job)
    generateBoxes(job)
    if not next(job.syncData.boxes) then
        job:Finish(false, false)
        job:Notification("error", locale("NO_BOXES_AVAILABLE"), 8000)
        return
    end
    setStage(job, stages.get_to_depot)
end

local onDestroy = function(job)
    if job.vehicle and DoesEntityExist(job.vehicle) then
        RemoveVehicle(job.vehicle)
    end
    if job.syncData.boxes then
        for k, v in pairs(job.syncData.boxes) do
            ElectricalBoxes[k].active = nil
        end
    end
    job.syncData = nil
    job:SyncData()
end

local onPlayerAdd = function(job, source, characterId)
    job:SyncData(source)
end

local onPlayerRemove = function(job, source, characterId)
    if DoesEntityExist(GetPlayerPed(source)) then
        TriggerClientEvent(("prp-electrical:syncData"), source, nil)
    end
end

Job:RegisterType(Config.Job.Electrical, onStart, onDestroy, onPlayerAdd, onPlayerRemove)

RegisterNetEvent(("prp-electrical:getVan"), function()
    local source = source
    ---@type Job|nil
    local job = Job:GetByMember(source)
    if not job then return end
    local charId = bridge.fw.getIdentifier(source)
    if job.owner ~= tostring(charId) then
        bridge.fw.notify(source, "error", locale("NEED_TO_BE_GROUP_OWNER"))
        return
    end
    if job.vehicle then
        bridge.fw.notify(source, "error", locale("ALREADY_HAVE_VAN"))
        return
    end
    local spotId = lib.callback.await(("prp-electrical:getFreeSpot"), source, job.syncData.depot)
    if not spotId then
        bridge.fw.notify(source, "error", locale("NO_FREE_SPOT"))
        return
    end
    local vehTries = 0
    local function spawnVehicle()
        if vehTries > 3 then return end
        local coords = Config.Job.Electrical.depots[job.syncData.depot].vehSpawns[spotId]
        local vehObj = SpawnVehicle(`burrito`, coords)
        if not vehObj then
            bridge.fw.notify(source, "error", locale("COULDNT_SPAWN_VEHICLE"))
            return
        end
        local timeout = 0
        while NetworkGetEntityOwner(vehObj.veh) == -1 and timeout < 15 do
            timeout += 1
            Citizen.Wait(100)
        end
        if timeout >= 15 or not vehObj.veh or not DoesEntityExist(vehObj.veh) then
            if vehObj.veh then
                RemoveVehicle(vehObj.veh)
            end
            vehTries += 1
            Citizen.Wait(100)
            return spawnVehicle()
        end
        return vehObj.veh, vehObj.vin
    end
    local veh = spawnVehicle()
    if not veh then
        bridge.fw.notify(source, "error", locale("COULDNT_SPAWN_VEHICLE"))
        return
    end
    bridge.vkeys.give(source, veh)
    job.vehicle = veh
    job.syncData.vehNetId = NetworkGetNetworkIdFromEntity(veh)

    local vehState = Entity(veh).state
    vehState.NoCriminalActivities = true

    TriggerClientEvent(("prp-electrical:setVehMod"), NetworkGetEntityOwner(job.vehicle), job.syncData.vehNetId, "livery", 3)
    setStage(job, stages.fix_box)
end)

RegisterNetEvent(("prp-electrical:returnVan"), function()
    local source = source
    ---@type Job|nil
    local job = Job:GetByMember(source)
    if not job then return end
    if job.syncData.stage ~= stages.return_vehicle then return end
    local charId = bridge.fw.getIdentifier(source)
    if job.owner ~= tostring(charId) then
        bridge.fw.notify(source, "error", locale("NEED_TO_BE_GROUP_OWNER"))
        return
    end
    if not job.vehicle then
        bridge.fw.notify(source, "error", locale("YOU_DONT_HAVE_THE_VEHICLE"))
        return
    end
    if not DoesEntityExist(job.vehicle) or #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(job.vehicle)) > 50 then
        bridge.fw.notify(source, "error", locale("TOO_FAR_FROM_VEH"))
        return
    end

    RemoveVehicle(job.vehicle)
    job:Finish(true, false)
end)