---@script core/client/classes/Export.lua

---@class Export
Export = Export or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Notification Export

---@param set_type string
---@param set_title string
---@param set_description string
---@param set_timeout integer
local function send_notification(set_type, set_title, set_description, set_timeout)
    Interface.createNotification(set_timeout or 1000, {
        set_title = set_title,
        set_description = set_description,
        set_type = set_type or 'info',
    })
end

Export.sendNotification = send_notification
exports("sendNotification", send_notification)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Export Functions

---@param entity_handle integer
---@return boolean
---@usage local is_on_fire = exports['z_fire']:isEntityOnFire(entity_handle: integer)
local function is_entity_on_fire(entity_handle)
    if entity_handle == nil or not DoesEntityExist(entity_handle) then return false end

    local network_identifier = NetworkGetNetworkIdFromEntity(entity_handle)
    if network_identifier == nil or network_identifier == 0 then return false end

    for _, data in pairs(Init.fireTable) do
        if data.networkEntity == network_identifier then return true end
    end

    return false
end

Export.isEntityOnFire = is_entity_on_fire
exports("isEntityOnFire", is_entity_on_fire)

---@param fire_table table
---@return boolean
---@usage local success = exports['z_fire']:deleteFires(fire_table: table)
local function delete_fires_within_table(fire_table)
    if fire_table == nil or type(fire_table) ~= 'table' then return false end

    local fire_ids = {}
    local table_insert = table.insert

    if next(fire_table) then for _, fire in pairs(fire_table) do table_insert(fire_ids, fire.id) end end
    TriggerServerEvent('z_fire:server:deleteFire', fire_ids)

    return true
end

Export.deleteFires = delete_fires_within_table
exports("deleteFire", delete_fires_within_table)

---@param fire_identifier string
---@return boolean
---@usage local success = exports['z_fire']:deleteFireById(fire_identifier: string)
local function deleteFireById(fire_identifier)
    if fire_identifier == nil or type(fire_identifier) ~= 'string' or not Init.fireTable[fire_identifier] then return false end

    TriggerServerEvent('z_fire:server:deleteFire', { fire_identifier })

    return true
end

Export.deleteFireById = deleteFireById
exports("deleteFireById", deleteFireById)

---@param value table | integer
---@return boolean
---@usage local is_success = exports['z_fire']:deleteSmokeById(value: table|integer)
local function deleteSmokeById(value)
    if value == nil then return false end

    if type(value) ~= 'table' then
        if not Init.smokeTable[value] then return false end
        TriggerServerEvent('z_fire:server:deleteSmoke', { value })
    else
        TriggerServerEvent('z_fire:server:deleteSmoke', value)
    end

    return true
end

Export.deleteSmokeById = deleteSmokeById
exports("deleteSmokeById", deleteSmokeById)

---@param world_position vector3
---@param range number
---@return table[index]: {id: integer, data: table}
---@usage local found_fires = exports['z_fire']:getFiresInRange(world_position: vector3, range: number)
local function getFiresInRange(world_position, range)
    local distance = range or 5.0
    local detected = {}

    for fireId, fireData in pairs(Init.fireTable) do
        local firePos = vector3(fireData.ptfxData.pos.x, fireData.ptfxData.pos.y, fireData.ptfxData.pos.z)
        if fireData.networkEntity then
            if fireData.ptfxData.fallbackPos then
                firePos = fireData.ptfxData.fallbackPos
            else
                firePos = GetOffsetFromEntityInWorldCoords(NetworkGetEntityFromNetworkId(fireData.networkEntity),
                    firePos.x, firePos.y, firePos.z)
            end
        end

        if #(vector3(world_position.x, world_position.y, world_position.z) - firePos) < distance then
            detected[#detected + 1] = { id = fireId, data = fireData }
        end
    end

    return detected
end

Export.getFiresInRange = getFiresInRange
exports("getFiresInRange", getFiresInRange)

---@param world_position vector3
---@param range number
---@return table[index]: {id: integer, data: table}
---@usage local found_smokes = exports['z_fire']:getSmokeInRange(world_position: vector3, range: number)
local function getSmokeInRange(world_position, range)
    local distance = range or 5.0
    local detected = {}
    local distanceSq = distance * distance

    for smokeId, smokeData in pairs(Init.smokeTable) do
        local smokePos = smokeData.ptfxData.pos

        if smokeData.networkEntity then
            if NetworkDoesNetworkIdExist(smokeData.networkEntity) then
                local entity = NetworkGetEntityFromNetworkId(smokeData.networkEntity)
                if DoesEntityExist(entity) then
                    smokePos = GetOffsetFromEntityInWorldCoords(
                        entity,
                        smokeData.ptfxData.pos.x,
                        smokeData.ptfxData.pos.y,
                        smokeData.ptfxData.pos.z
                    )
                elseif smokeData.ptfxData.zone and smokeData.ptfxData.zone.pos then
                    smokePos = smokeData.ptfxData.zone.pos
                end
            elseif smokeData.ptfxData.zone and smokeData.ptfxData.zone.pos then
                smokePos = smokeData.ptfxData.zone.pos
            end
        end

        local worldVec = vector3(world_position.x, world_position.y, world_position.z)
        local distSq = #(worldVec - smokePos) ^ 2

        if distSq <= distanceSq then
            detected[#detected + 1] = {
                id = smokeId,
                data = smokeData,
                distance = math.sqrt(distSq),
                position = smokePos
            }
        end
    end

    table.sort(detected, function(a, b)
        return a.distance < b.distance
    end)

    return detected
end

Export.getSmokeInRange = getSmokeInRange
exports("getSmokeInRange", getSmokeInRange)

---@param world_position vector3
---@return integer | nil, table, number
---@usage local closestFire, closestFireData, closestDistance = exports['z_fire']:getClosestFire(world_position: vector3)
local function getClosestFire(world_position)
    local closestFire = nil
    local closestDistance = math.huge
    local closestFireData

    for fireId, fireData in pairs(Init.fireTable) do
        local firePos = fireData.ptfxData.pos

        if fireData.networkEntity then
            firePos = fireData.ptfxData.fallbackPos
        end

        local distance = #(vector3(world_position.x, world_position.y, world_position.z) - firePos)

        if distance < closestDistance then
            closestFire = fireId
            closestFireData = fireData
            closestDistance = distance
        end
    end

    return closestFire, closestFireData, closestDistance
end

Export.getClosestFire = getClosestFire
exports("getClosestFire", getClosestFire)

---@param world_position vector3
---@return integer | nil, table, number
---@usage local closestSmoke, closestSmokeData, closestDistance = exports['z_fire']:getClosestSmoke(world_position: vector3)
local function getClosestSmoke(world_position)
    local closestSmoke = nil
    local closestDistance = math.huge
    local closestSmokeData

    for smokeId, smokeData in pairs(Init.smokeTable) do
        local distance = #(vector3(world_position.x, world_position.y, world_position.z) - smokeData.ptfxData.pos)

        if distance < closestDistance then
            closestSmoke = smokeId
            closestSmokeData = smokeData
            closestDistance = distance
        end
    end

    return closestSmoke, closestSmokeData, closestDistance
end

Export.getClosestSmoke = getClosestSmoke
exports("getClosestSmoke", getClosestSmoke)

---@param duty_status boolean
---@param department_abbr string
---@return boolean
---@usage local success = exports['z_fire']:setPlayerDuty(duty_status: boolean, department_abbr: string)
local function setPlayerDuty(duty_status, department_abbr)
    if duty_status == nil or type(duty_status) ~= 'boolean' or department_abbr == nil or type(department_abbr) ~= 'string' then return false end

    local departments = Init.functions.loadConfig('departments')
    if departments == nil then return false end

    if not departments[department_abbr] then
        Init.debug(('Department: %s not found!'):format(department_abbr))
        return false
    end
    TriggerServerEvent('z_fire:server:setDuty', duty_status, department_abbr)

    return true
end

Export.setPlayerDuty = setPlayerDuty
exports("setPlayerDuty", setPlayerDuty)

---@usage: Examples of calling the exports functions
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
    })

    ## Grass Fire ##
    exports['z_fire']:createFire({
        ptfxData = {type = 'normal2', pos = vector3(1988.8700, 3048.0024, 47.2151), scale = 1.0},
        behaviourType = 'grass',
        canSpread = true,
        spreadSize = 100,
        burnoutTime = 999,
        origin = {is = true, id = nil}
    })

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
    })

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
    })
--]]

---@param fire_data table
---@return string | nil
local function createFire(fire_data)
    if fire_data == nil then return nil end

    if fire_data.ptfxData.fallbackPos == nil then
        Init.warnUser('The createFire export requires a fallbackPos parameter when handling entities')
        return nil
    end

    local generated_uuid = Init.functions.generateId()
    TriggerServerEvent('z_fire:server:createFire', generated_uuid, fire_data)

    return generated_uuid
end

Export.createFire = createFire
exports("createFire", createFire)

---@usage: Example of calling the export function
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
local function createSmoke(smoke_data)
    if smoke_data == nil then return nil end

    local generated_uuid = Init.functions.generateId()
    TriggerServerEvent('z_fire:server:createSmoke', generated_uuid, smoke_data)

    return generated_uuid
end

Export.createSmoke = createSmoke
exports("createSmoke", createSmoke)

---@return boolean success
---@usage local success = exports['z_fire']:refreshUserPermissions()
local function refreshUserPermissions()
    Init.functions.refreshUserPermissions()
    Bridge.refreshFrameworkData()
    return true
end

Export.refreshUserPermissions = refreshUserPermissions
exports("refreshUserPermissions", refreshUserPermissions)

---@return boolean success
---@usage local success = exports["z_fire"]:forceIncident("ic_index_1")
local function forceIncident(incident_id)
    if not Bridge.hasPermission(Init.cache['serverId'], 'incident_manager') then
        Bridge.notification("error", {
            set_timeout = 3000,
            set_title = cfg.languages[Init.cache.locale]['error'] or "Error",
            set_description = cfg.languages[Init.cache.locale]['no_permission'] or
                "You do not have permission to force incidents."
        })
        return false
    end
    if not incident_id or type(incident_id) ~= 'string' then
        Init.debug("Invalid incident ID provided for forceIncident Export.")
        return false
    end

    Init.functions.waitForConfig('incidents', function()
        if not Init.incidents or not Init.incidents[incident_id] then
            Init.debug(("Incident ID '%s' not found in the incidents configuration."):format(incident_id))
            Bridge.notification("error", {
                set_timeout = 3000,
                set_title = cfg.languages[Init.cache.locale]['error'] or "Error",
                set_description = ('Incident "%s" not found'):format(incident_id)
            })
            return false
        end

        local incidentData = Init.incidents[incident_id]

        if not incidentData.enabled then
            Init.debug(("Incident ID '%s' is not enabled."):format(incident_id))
            Bridge.notification("error", {
                set_timeout = 3000,
                set_title = cfg.languages[Init.cache.locale]['error'] or "Error",
                set_description = ('Incident "%s" is not enabled'):format(incident_id)
            })
            return false
        end

        local district = incidentData.district
        if not district then
            Init.debug(("Incident ID '%s' does not have a district specified."):format(incident_id))
            return false
        end

        TriggerServerEvent("z_fire:triggerIncident", district, incident_id, incidentData)

        Init.debug(('Forcing incident "%s" in district "%s"'):format(incident_id, district))

        Bridge.notification("success", {
            set_timeout = 3000,
            set_title = cfg.languages[Init.cache.locale]['success'] or 'Success',
            set_description = ('Incident "%s" has been triggered'):format(incidentData.title or incident_id)
        })

        return true
    end)

    return true
end

Export.forceIncident = forceIncident
exports("forceIncident", forceIncident)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
