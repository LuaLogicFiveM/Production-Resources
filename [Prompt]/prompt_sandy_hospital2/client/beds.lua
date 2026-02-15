-- ============================================================
-- Hospital Bed Lie Down – Client-side
-- Lets players lie down on hospital beds.
-- Pure client-side – no server needed, beds are not exclusive.
-- ============================================================

local hasOxTarget = GetResourceState('ox_target') == 'started'
local hasOxLib    = GetResourceState('ox_lib')    == 'started'

if not hasOxLib then
    print('[prompt_sandy_hospital2] ^1Bed system disabled – ox_lib not found.^7')
    return
end

-- ────────────────────────────────────────────────────────────
-- State
-- ────────────────────────────────────────────────────────────
local isOnBed      = false
local currentBed   = nil   -- entity handle of the bed we're on

-- Build a lookup: modelHash → bed config entry (for per-bed offsets)
local bedByHash = {}
local bedModelHashes = {}
for _, bed in ipairs(BedConfig.beds) do
    local hash = joaat(bed.model)
    bedByHash[hash] = bed
    bedModelHashes[#bedModelHashes + 1] = hash
end

-- ────────────────────────────────────────────────────────────
-- Helpers
-- ────────────────────────────────────────────────────────────

--- Find the closest bed entity near the player (any of the configured models).
--- Uses a tight radius (1.5m) and line-of-sight check to avoid
--- detecting beds behind walls.
--- @return number|nil entity, table|nil bedCfg
local function findNearestBed()
    local ped    = cache.ped or PlayerPedId()
    local coords = GetEntityCoords(ped)
    local closest, closestDist, closestCfg = nil, 1.5, nil

    for _, hash in ipairs(bedModelHashes) do
        local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, closestDist, hash, false, false, false)
        if obj and obj ~= 0 and DoesEntityExist(obj) then
            local objCoords = GetEntityCoords(obj)
            local dist = #(coords - objCoords)
            if dist < closestDist then
                -- Line-of-sight check: make sure there's no wall between player and bed
                local hasLOS = HasEntityClearLosToEntity(ped, obj, 17) -- flag 17 = default collision check
                if hasLOS then
                    closest     = obj
                    closestDist = dist
                    closestCfg  = bedByHash[hash]
                end
            end
        end
    end

    return closest, closestCfg
end

--- Get the per-bed config for an entity by its model hash.
local function getBedCfgForEntity(entity)
    if not entity or not DoesEntityExist(entity) then return nil end
    return bedByHash[GetEntityModel(entity)]
end

--- Attach player to bed prop (same pattern as the MRI system).
--- Uses AttachEntityToEntity with fixedRot = true so the rotation
--- stays locked even while the animation plays. This keeps camera,
--- collision, and server-side sync working correctly.
local function attachToBed(bed, bedCfg)
    if isOnBed then return false end

    local anim     = BedConfig.lieAnim
    local offset   = bedCfg.lieOffset
    local rotation = bedCfg.lieRotation

    local ped = cache.ped or PlayerPedId()

    -- Load animation
    lib.requestAnimDict(anim.dict)

    -- Move ped close to bed first so the attachment doesn't jerk the camera
    local bedCoords = GetEntityCoords(bed)
    SetEntityCoords(ped, bedCoords.x, bedCoords.y, bedCoords.z + 0.5, false, false, false, false)
    Wait(100)

    -- Attach ped to the bed prop — fixedRot = true (last param) keeps
    -- rotation locked even during TaskPlayAnim
    AttachEntityToEntity(
        ped, bed, 0,
        offset.x, offset.y, offset.z,
        rotation.x, rotation.y, rotation.z,
        false, false, false, true, 0, true
    )

    -- Play anim on top (flag 1 = loop)
    TaskPlayAnim(ped, anim.dict, anim.name,
        8.0, -8.0, -1, 1, 0, false, false, false)

    isOnBed    = true
    currentBed = bed

    return true
end

--- Release player from bed and clean up.
local function detachFromBed()
    if not isOnBed then return end

    local ped = cache.ped or PlayerPedId()

    -- Detach ped from bed prop
    DetachEntity(ped, true, false)
    ClearPedTasks(ped)
    RemoveAnimDict(BedConfig.lieAnim.dict)

    isOnBed    = false
    currentBed = nil
end

-- ────────────────────────────────────────────────────────────
-- Interaction: lie on bed then input loop
-- ────────────────────────────────────────────────────────────

--- Main interaction flow – attach, show UI, block until get-up.
local function useBed(targetEntity)
    if isOnBed then return end

    local bed, bedCfg

    if targetEntity and DoesEntityExist(targetEntity) then
        bed    = targetEntity
        bedCfg = getBedCfgForEntity(targetEntity)
    end

    if not bed or not bedCfg then
        bed, bedCfg = findNearestBed()
    end

    if not bed or not bedCfg then
        lib.notify({ title = 'Hospital Bed', description = 'No bed nearby.', type = 'error' })
        return
    end

    if not attachToBed(bed, bedCfg) then return end

    -- Show persistent get-up hint
    lib.showTextUI(BedConfig.messages.getUpHint)

    -- Input loop – disable movement, wait for get-up key
    while isOnBed do
        DisableControlAction(0, 32, true)  -- W
        DisableControlAction(0, 33, true)  -- S
        DisableControlAction(0, 34, true)  -- A
        DisableControlAction(0, 35, true)  -- D
        DisableControlAction(0, 22, true)  -- Space
        DisableControlAction(0, 36, true)  -- Ctrl

        if IsControlJustPressed(0, 194) or IsControlJustPressed(0, 177) then -- Backspace / ESC
            detachFromBed()
            break
        end

        Wait(0)
    end

    lib.hideTextUI()
end

-- ────────────────────────────────────────────────────────────
-- Setup interactions
-- ────────────────────────────────────────────────────────────

local function shouldUseOxTarget()
    if BedConfig.interaction == 'ox_target' then return true end
    if BedConfig.interaction == 'textui'    then return false end
    return hasOxTarget -- 'auto'
end

local function setupBedInteractions()
    if shouldUseOxTarget() then
        -- Register ox_target for each bed model
        for _, bed in ipairs(BedConfig.beds) do
            exports.ox_target:addModel(joaat(bed.model), {
                {
                    name     = 'bed_lie_' .. bed.model,
                    icon     = 'fas fa-bed',
                    label    = BedConfig.messages.lieDown,
                    canInteract = function()
                        return not isOnBed
                    end,
                    onSelect = function(data)
                        useBed(data.entity)
                    end,
                },
                {
                    name     = 'bed_getup_' .. bed.model,
                    icon     = 'fas fa-person-walking',
                    label    = BedConfig.messages.getUp,
                    canInteract = function(entity)
                        return isOnBed and currentBed == entity
                    end,
                    onSelect = function()
                        detachFromBed()
                    end,
                },
            })
        end
    else
        -- Fallback: proximity thread + [E] key for nearest bed
        CreateThread(function()
            local uiShown = false

            while true do
                local sleep = 500

                if not isOnBed then
                    local bed = findNearestBed()
                    if bed then
                        sleep = 0
                        if not uiShown then
                            lib.showTextUI('[E] ' .. BedConfig.messages.lieDown)
                            uiShown = true
                        end

                        -- E = lie down
                        if IsControlJustPressed(0, 38) then
                            lib.hideTextUI()
                            uiShown = false
                            useBed()
                        end
                    else
                        if uiShown then
                            lib.hideTextUI()
                            uiShown = false
                        end
                    end
                else
                    sleep = 0
                end

                Wait(sleep)
            end
        end)
    end
end

setupBedInteractions()

-- ============================================================
-- COUCH / CHAIR SEATING  (scenario-based, server-synced)
-- ============================================================
-- Uses TaskStartScenarioAtPosition for natural sit-down / stand-up.
-- Each seat is an ox_target sphere zone at absolute world coords.
-- Server tracks occupancy — handles crashes, disconnects, conflicts.
-- ============================================================

local isOnSeat      = false
local currentSeatId = nil   -- index of the seat we're on

--- Stand up from the current seat and tell the server.
local function getUpFromSeat()
    if not isOnSeat then return end

    local ped = cache.ped or PlayerPedId()
    ClearPedTasks(ped)

    -- Tell server to free the seat (fire-and-forget)
    lib.callback.await('seats:release', false)

    isOnSeat      = false
    currentSeatId = nil
end

--- Sit down on a specific seat using its scenario animation.
--- Asks server for permission first (checks occupancy + conflicts).
local function sitOnSeat(seatIdx)
    if isOnBed or isOnSeat then return end

    local seat = CouchConfig.seats[seatIdx]
    if not seat then return end

    -- Ask server if seat is available (occupancy + conflict check)
    local granted, reason = lib.callback.await('seats:request', false, seatIdx)

    if not granted then
        local msg = CouchConfig.messages.occupied
        if reason == 'blocked' then
            msg = CouchConfig.messages.blocked
        end
        lib.notify({ title = 'Seat', description = msg, type = 'error' })
        return
    end

    local ped = cache.ped or PlayerPedId()

    ClearPedTasks(ped)
    Wait(50)

    TaskStartScenarioAtPosition(ped, seat.scenario,
        seat.coords.x, seat.coords.y, seat.coords.z,
        seat.heading, 0, true, true)

    isOnSeat      = true
    currentSeatId = seatIdx

    -- Show persistent get-up hint
    lib.showTextUI(CouchConfig.messages.getUpHint)

    -- Input loop – disable movement, wait for get-up key
    while isOnSeat do
        DisableControlAction(0, 32, true)  -- W
        DisableControlAction(0, 33, true)  -- S
        DisableControlAction(0, 34, true)  -- A
        DisableControlAction(0, 35, true)  -- D
        DisableControlAction(0, 22, true)  -- Space
        DisableControlAction(0, 36, true)  -- Ctrl

        if IsControlJustPressed(0, 194) or IsControlJustPressed(0, 177) then -- Backspace / ESC
            getUpFromSeat()
            break
        end

        Wait(0)
    end

    lib.hideTextUI()
end

--- Set up ox_target sphere zones for each configured seat.
local function setupCouchInteractions()
    if not CouchConfig or not CouchConfig.seats then return end

    for i, seat in ipairs(CouchConfig.seats) do
        -- Skip placeholder seats (coords at origin)
        if seat.coords.x == 0.0 and seat.coords.y == 0.0 and seat.coords.z == 0.0 then
            goto continue
        end

        local seatIdx = i
        exports.ox_target:addSphereZone({
            coords = seat.coords,
            radius = CouchConfig.interactRadius or 0.6,
            options = {
                {
                    name     = 'couch_sit_' .. seatIdx,
                    icon     = 'fas fa-couch',
                    label    = seat.label or CouchConfig.messages.sit,
                    canInteract = function()
                        return not isOnBed and not isOnSeat
                    end,
                    onSelect = function()
                        sitOnSeat(seatIdx)
                    end,
                },
                {
                    name     = 'couch_getup_' .. seatIdx,
                    icon     = 'fas fa-person-walking',
                    label    = CouchConfig.messages.getUp,
                    canInteract = function()
                        return isOnSeat and currentSeatId == seatIdx
                    end,
                    onSelect = function()
                        getUpFromSeat()
                    end,
                },
            },
        })

        ::continue::
    end
end

if hasOxTarget then
    setupCouchInteractions()
end

-- ────────────────────────────────────────────────────────────
-- Cleanup on resource stop
-- ────────────────────────────────────────────────────────────
AddEventHandler('onResourceStop', function(resource)
    if resource ~= cache.resource then return end
    detachFromBed()
    if isOnSeat then
        local ped = cache.ped or PlayerPedId()
        ClearPedTasks(ped)
        isOnSeat      = false
        currentSeatId = nil
    end
end)
