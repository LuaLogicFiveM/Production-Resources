local isWeaponDrawn = false
local savedScale = 1.0
local savedWeight = 1.0
local lastWeaponState = nil
local weaponTimer = nil

local function getCurrentScale()
    return exports['siberwin-pedscale']:getCurrentScale()
end

local function getCurrentWeight()
    return exports['siberwin-pedscale']:getCurrentWeight()
end

local function applyScale(scale, weight)
    local success, result = pcall(function()
        return exports['siberwin-pedscale']:changeEntitySize(PlayerPedId(), scale, weight)
    end)
    
    if not success then
        local ped = PlayerPedId()
        if DoesEntityExist(ped) then
            SetEntityMatrix(ped,
                scale, 0, 0,
                0, scale, 0,
                0, 0, scale,
                GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z
            )
        end
    end

    local Database = exports['siberwin-pedscale']:getDatabase()
    if Database then
        Database.savePlayerScale(scale, weight)
    end
end

local function getPlayerWeaponHash()
    local ped = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(ped)
    return weaponHash
end

local function hasWeaponEquipped()
    local ped = PlayerPedId()
    local weaponHash = GetCurrentPedWeapon(ped, true)
    return weaponHash ~= GetHashKey("WEAPON_UNARMED")
end

local function isPlayerDrawingWeapon()
    local ped = PlayerPedId()

    local weaponHash = GetCurrentPedWeapon(ped, true)
    local isUnarmed = weaponHash == GetHashKey("WEAPON_UNARMED")
    local isArmed = IsPedArmed(ped, 7)

    local isDrawingAnim = IsEntityPlayingAnim(ped, "weapons@pistol@", "holster_2_aim", 3) or
                         IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) or
                         IsEntityPlayingAnim(ped, "weapons@pistol@", "aim_2_holster", 3)

    local isHolstering = IsEntityPlayingAnim(ped, "weapons@pistol@", "holster", 3) or
                        IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "outro", 3)

    if isHolstering then
        return false
    end

    return isDrawingAnim or (isArmed and not isUnarmed)
end

local function saveCurrentScale()
    savedScale = getCurrentScale()
    savedWeight = getCurrentWeight()

    pcall(function()
        exports['siberwin-pedscale']:stopScale()
    end)
end

local function applyNormalScale()
    applyScale(1.0, 1.0)
end

local function restoreScale()
    if savedScale ~= 1.0 or savedWeight ~= 1.0 then
        applyScale(savedScale, savedWeight)

        pcall(function()
            exports['siberwin-pedscale']:startScale(savedScale, savedWeight)
        end)
    else
        local Database = exports['siberwin-pedscale']:getDatabase()
        if Database then
            Database.savePlayerScale(1.0, 1.0)
        end
    end
end

local function checkWeaponState()
    local currentWeaponState = isPlayerDrawingWeapon()

    if currentWeaponState ~= lastWeaponState then
        if currentWeaponState and not isWeaponDrawn then
            saveCurrentScale()
            applyNormalScale()
            isWeaponDrawn = true

            if weaponTimer then
                weaponTimer = nil
            end

            weaponTimer = CreateThread(function()
                Wait(3000)
                if isWeaponDrawn then
                    applyScale(savedScale, savedWeight)

                    pcall(function()
                        exports['siberwin-pedscale']:startScale(savedScale, savedWeight)
                    end)
                end
                weaponTimer = nil
            end)

        elseif not currentWeaponState and isWeaponDrawn then
            if weaponTimer then
                weaponTimer = nil
            end

            pcall(function()
                exports['siberwin-pedscale']:stopScale()
            end)

            restoreScale()
            isWeaponDrawn = false
        end
        lastWeaponState = currentWeaponState
    end
end

CreateThread(function()
    while true do
        checkWeaponState()
        Wait(25)
    end
end)
