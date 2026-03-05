---@script core/server/classes/Exports.lua

---@class export
Export = Export or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param source_user integer
---@param set_type string
---@param set_title string
---@param set_description string
---@param set_timeout integer
local function send_notification(source_user, set_type, set_title, set_description, set_timeout)
    if source_user == nil then
        return
    end

    local user_identifier = tonumber(source_user)
    if not Utils.isIdValid(user_identifier) then
        return false
    end

    TriggerClientEvent("z_fire:return:sendNotification", source_user, {
        type = set_type or 'info',
        title = set_title or 'Notification',
        description = set_description or '',
        timeout = set_timeout or 5000
    })
end

Export.sendNotification = send_notification
exports("sendNotification", send_notification)

---@param source_user integer
---@return boolean
---@usage local is_on_duty = exports['z_fire']:isPlayerOnDuty(source_user: integer)
local function is_user_on_duty(source_user)
    local user_identifier = tonumber(source_user)
    if not Utils.isIdValid(user_identifier) then
        return false
    end

    for _, deptData in pairs(Init.dutyTable) do
        if deptData.members[user_identifier] then
            return true
        end
    end

    return false
end

Export.isPlayerOnDuty = is_user_on_duty
exports("isPlayerOnDuty", is_user_on_duty)

---@param source_id string
---@param department_abbr string
---@param set_status boolean
---@return boolean|nil, integer
local function set_user_duty_status(source_id, department_abbr, set_status)
    if source_id == nil or (set_status == true and (department_abbr == nil or type(department_abbr) ~= 'string')) or set_status == nil then
        return nil, 0
    end

    if not Utils.isIdValid(source_id) then
        return nil, 0
    end

    if not set_status then
        local isBooked = false

        for _, deptData in pairs(Init.dutyTable) do
            if deptData.members[source_id] then
                isBooked = true
                break
            end
        end

        if not isBooked then
            return nil, 2
        end

        for _, deptData in pairs(Init.dutyTable) do
            deptData.members[source_id] = nil
        end

        if not Init.hasUpdatedDuty then
            Init.functions.forceUpdate()
        end

        return true, 0
    else
        if Init.departments[department_abbr] == nil then
            return nil, 1
        end

        local dutyTable = Init.dutyTable[department_abbr].members
        for _, deptData in pairs(Init.dutyTable) do
            if deptData.members[source_id] then
                return nil, 3
            end
        end

        dutyTable[source_id] = true

        if not Init.hasUpdatedDuty then
            Init.functions.forceUpdate()
        end

        return true, 0
    end
end

Export.setPlayerDuty = set_user_duty_status
exports("setPlayerDuty", set_user_duty_status)

---@usage
--[[
    ## Structure Fire ##
    exports['z_fire']:createFire({
        ptfxData = {type = 'normal2', pos = vector3(1988.8700, 3048.0024, 47.2151), scale = 1.0},
        behaviourType = 'interior',
        canSpread = true,
        spreadSize = 100,
        roomHash = -576181983,
        burnoutTime = 999,
        origin = {is = true, id = nil}
    }, source)

    ## Grass Fire ##
    exports['z_fire']:createFire({
        ptfxData = {type = 'normal2', pos = vector3(1988.8700, 3048.0024, 47.2151), scale = 1.0},
        behaviourType = 'grass',
        canSpread = true,
        spreadSize = 100,
        burnoutTime = 999,
        origin = {is = true, id = nil}
    }, source)

    ## Prop Fire ##
    ---@note: The field 'pos' indicates the offset where the fire should be Initiated on the entity.
    ---@note: This export requires the fallbackPos parameter, This should just be the world coordinates of the object
    exports['z_fire']:createFire({
        ptfxData = {type = 'normal2', pos = vector3(0.1, 1.0, 0.1), scale = 1.0, fallbackPos = vector3(0.0, 0.0, 0.0)},
        behaviourType = 'prop',
        canSpread = true,
        spreadSize = 100,
        networkEntity = 123,
        burnoutTime = 999,
        origin = {is = true, id = nil}
    }, source)

    ## Vehicle Fire ##
    ---@note: The field 'pos' indicates the offset where the fire should be Initiated on the entity.
    ---@note: This export requires the fallbackPos parameter, This should just be the world coordinates of the vehicle
    exports['z_fire']:createFire({
        ptfxData = {type = 'normal2', pos = vector3(0.1, 1.0, 0.1), scale = 1.0, fallbackPos = vector3(0.0, 0.0, 0.0)},
        behaviourType = 'vehicle',
        canSpread = true,
        spreadSize = 100,
        networkEntity = 123,
        burnoutTime = 999,
        origin = {is = true, id = nil}
    }, source)
--]]

---@param fire_data table
---@param source integer
---@return string | nil
local function create_fire(fire_data, source)
    if fire_data == nil then return nil end
    if fire_data.ptfxData.fallbackPos == nil then
        Server.warnServer('The createFire export requires a fallbackPos parameter when handling entities')
        return nil
    end

    if source == nil or source == -1 then
        local players = GetPlayers()
        local validPlayer = false
        local endUser

        while not validPlayer do
            local userIndex = math.random(1, #players)
            endUser = players[userIndex]

            if GetPlayerPing(endUser) > 0 then
                validPlayer = true
            else
                Wait(0)
            end
        end

        fire_data.sourceUser = endUser
    else
        fire_data.sourceUser = source
    end

    local generated_uuid = Init.functions.buildId()
    TriggerEvent('z_fire:server:createFire', generated_uuid, fire_data)

    return generated_uuid
end

exports("createFire", create_fire)

---@usage
--[[
    exports['z_fire']:createSmoke({
        ptfxData = {
            type = 'linger1',
            pos = vector3(1883.3540039062, 2681.7888183594, 45.671802520752),
            scale = 1.0
        },
        networkEntity = nil,
        canDisperse = true
    })
--]]

---@param smoke_data table
---@return string | nil
local function create_smoke(smoke_data)
    if smoke_data == nil then
        return nil
    end

    local generated_uuid = Init.functions.buildId()
    TriggerEvent('z_fire:server:createSmoke', generated_uuid, smoke_data)

    return generated_uuid
end

exports("createSmoke", create_smoke)

---@param fires_to_extinguish table
local function extinguish_fire(fires_to_extinguish)
    if fires_to_extinguish == nil then
        return
    end

    TriggerEvent('z_fire:server:extinguishFire', fires_to_extinguish)
end

exports("extinguishFire", extinguish_fire)

---@return table
local function get_all_fires()
    return Init.fireTable
end

exports("getAllFires", get_all_fires)

---@param world_position vector3
---@param range number
---@return table|nil
local function get_fires_in_range(world_position, range)
    local distance = range or 5.0
    local detected = {}

    for fireId, fireData in pairs(Init.fireTable) do
        local firePos = fireData.ptfxData.pos

        if fireData.networkEntity then
            firePos = fireData.ptfxData.fallbackPos
        end

        if #(vector3(world_position.x, world_position.y, world_position.z) - firePos) < distance then
            detected[#detected + 1] = { id = fireId, data = fireData }
        end
    end

    return detected
end

Export.getFiresInRange = get_fires_in_range
exports("getFiresInRange", get_fires_in_range)

---@param fire_table table
---@return boolean
---@usage local success = exports['z_fire']:deleteFires(fire_table: table)
local function delete_fires_within_table(fire_table)
    if fire_table == nil or type(fire_table) ~= 'table' then
        return false
    end

    local fire_ids = {}
    local table_insert = table.insert

    if next(fire_table) then
        for _, fire in pairs(fire_table) do
            table_insert(fire_ids, fire.id)
        end
    end

    TriggerEvent('z_fire:server:deleteFire', fire_ids)

    return true
end

Export.deleteFires = delete_fires_within_table
exports("deleteFire", delete_fires_within_table)

---@return table
local function get_all_smoke()
    return Init.smokeTable
end

exports("getAllSmoke", get_all_smoke)

---@param world_position vector3
---@param range number
---@return table|nil
local function get_smoke_in_range(world_position, range)
    local distance = range or 5.0
    local detected = {}

    for smokeId, smokeData in pairs(Init.smokeTable) do
        if #(vector3(world_position.x, world_position.y, world_position.z) - smokeData.ptfxData.pos) < distance then
            detected[#detected + 1] = { id = smokeId, data = smokeData }
        end
    end

    return detected
end

exports("getSmokeInRange", get_smoke_in_range)

---@return boolean
local function force_incident(incident_id)
    if incident_id == nil or type(incident_id) ~= 'string' then
        return false
    end

    local incident = Init.incidents[incident_id]
    if incident == nil then
        return false
    end

    local district = incident.district
    TriggerEvent('z_fire:triggerIncident', district, incident_id, incident)

    return true
end

exports("forceIncident", force_incident)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
