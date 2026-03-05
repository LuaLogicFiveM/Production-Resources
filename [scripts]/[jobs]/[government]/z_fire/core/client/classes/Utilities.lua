---@script core/client/classes/Utilities.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@alias AssetTypes
---| "ModelAsset"
---| "AnimDict"
---| "TextureDict"
---| "ParticleEffect"
---| "RopeTexture"
---| "WeaponAsset"

---@class Utils
---@field loadAndCache fun(type: AssetTypes, value: any): boolean
---@field releaseAsset fun(type: AssetTypes, value: any)

---@type Utils
Utils = Utils or {}

local math_rad = math.rad
local math_cos = math.cos
local math_sin = math.sin

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param data table
Utils.notifyOnDutyUsers = function(data, hasSentAlert)
    if hasSentAlert then return end
    local dutyAlerts = cfg.autoIncidents.dutyAlerts
    local sound = dutyAlerts.sound

    if sound.allow then
        local soundId = GetSoundId()
        PlaySoundFrontend(soundId, sound.soundName, sound.soundSet, true)
        ReleaseSoundId(soundId)
    end

    if dutyAlerts.type == 'chat' then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            multiline = true,
            args = { 'Fire Control Room', ('\nIncident: %s \nDetails: %s \nLocation: %s'):format(data.type, data.description, data.location) }
        })
    else
        SendNUIMessage({
            type = 'notif',
            load = {
                incident = ('New Incident: %s'):format(data.type),
                details = data.description,
                address = data.location
            }
        })
    end
end

---@param coords vector3
---@param radius number
Utils.getPedsInArea = function(coords, radius)
    local handle, ped = FindFirstPed()
    local success
    local peds = {}

    repeat
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            local ped_position = GetEntityCoords(ped)
            local dist = #(ped_position - coords)

            if dist <= radius then
                table.insert(peds, ped)
            end
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)
    return peds
end

---@param table table
---@return integer
Utils.tableLen = function(table)
    if not table or table == nil then
        return 0
    end

    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end

    return count
end

---@param rotation vector3
---@return vector3
Utils.rotationToDirection = function(rotation)
    local rotZ = math_rad(rotation.z)
    local rotX = math_rad(rotation.x)
    local cosOfRotX = math_cos(rotX)

    return vector3(
        -math_sin(rotZ) * cosOfRotX,
        math_cos(rotZ) * cosOfRotX,
        math_sin(rotX)
    )
end

---@param Xdivide number
---@param Ydivide number
---@param Zdivide number
---@return number|nil
Utils.toScale = function(Xdivide, Ydivide, Zdivide)
    local scale = math.min(Xdivide, Ydivide, Zdivide)
    return tonumber(string.format("%.1f", scale))
end

---@param class integer
---@return boolean
Utils.getClass = function(class)
    return cfg.behaviourTypes['vehicle'].blacklistedClasses[Enum.eVehicleClasses[class]]
end

---@param string string
---@return integer
Utils.getKey = function(string)
    return Enum.eUserInputs[cfg.keybinds[string]:upper()]
end

---@param dec integer
---@return string
Utils.decTohex = function(dec)
    if dec < 0 then
        return string.format("0x%X", 2 ^ 32 + dec)
    end

    return string.format("0x%X", dec)
end

---@param type AssetTypes
---@param value any
---@return boolean
Utils.loadAndCache = function(type, value)
    local timeout = (1 * 5000)
    local startTime = GetGameTimer()

    local function loadAsset(isAssetLoaded, requestAsset, assetType)
        if assetType ~= "WeaponAsset" then
            requestAsset(value)
        else
            requestAsset(value, 31, 0)
        end

        while not isAssetLoaded(value) do
            if GetGameTimer() - startTime >= timeout then
                Init.warnUser(("%s loading timed out for: %s"):format(assetType, tostring(value)))
                return false
            end
            Wait(0)
        end
        return true
    end

    local functions = {
        ["ModelAsset"] = function()
            if not IsModelValid(value) or not IsModelInCdimage(value) then
                Init.warnUser(("Attempted to load invalid model: %s"):format(tostring(value)))
                return false
            end
            return loadAsset(HasModelLoaded, RequestModel, "Model")
        end,
        ["AnimDict"] = function()
            if not DoesAnimDictExist(value) then
                Init.warnUser(("Attempted to load invalid animDict: %s"):format(tostring(value)))
                return false
            end
            return loadAsset(HasAnimDictLoaded, RequestAnimDict, "AnimDict")
        end,
        ["TextureDict"] = function()
            return loadAsset(HasStreamedTextureDictLoaded, RequestStreamedTextureDict, "TextureDict")
        end,
        ["ParticleEffect"] = function()
            return loadAsset(HasNamedPtfxAssetLoaded, RequestNamedPtfxAsset, "ParticleEffect")
        end,
        ["RopeTexture"] = function()
            return loadAsset(RopeAreTexturesLoaded, RopeLoadTextures, "RopeTexture")
        end,
        ["WeaponAsset"] = function()
            if not IsWeaponValid(value) then
                Init.warnUser(("Attempted to load invalid WeaponAsset: %s"):format(value))
                return false
            end
            return loadAsset(HasWeaponAssetLoaded, RequestWeaponAsset, "WeaponAsset")
        end
    }

    local func = functions[type]
    if not func then
        return false
    end

    return func()
end

---@param type AssetTypes
---@param value any
Utils.releaseAsset = function(type, value)
    local functions = {
        ["ModelAsset"] = function()
            if IsModelInCdimage(value) and IsModelValid(value) then
                SetModelAsNoLongerNeeded(value)
                Init.debug(("Model released: %s"):format(tostring(value)))
            else
                Init.warnUser(("Attempted to release invalid model: %s"):format(tostring(value)))
            end
        end,
        ["AnimDict"] = function()
            RemoveAnimDict(value)
            Init.debug(("AnimDict released: %s"):format(tostring(value)))
        end,
        ["TextureDict"] = function()
            SetStreamedTextureDictAsNoLongerNeeded(value)
            Init.debug(("TextureDict released: %s"):format(tostring(value)))
        end,
        ["ParticleEffect"] = function()
            RemoveNamedPtfxAsset(value)
            Init.debug(("ParticleEffect released: %s"):format(tostring(value)))
        end,
        ["RopeTexture"] = function()
            RopeUnloadTextures()
            Init.debug(("RopeTexture released."))
        end,
        ["WeaponAsset"] = function()
            RemoveWeaponAsset(value)
            Init.debug(("WeaponAsset released: %s"):format(tostring(value)))
        end
    }

    local func = functions[type]
    if not func then
        return
    end

    func()
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

RegisterNetEvent(("%s:utils:integration"):format(Init.cache.resourceName))
---@param type string
---@param data table
AddEventHandler(("%s:utils:integration"):format(Init.cache.resourceName), function(type, data)
    local integrations = {
        nightShifts = function()
            exports['night_shifts']:CreateEmergencyCall(
                data[1], -- Is it an emergency?
                data[2], -- Is police required?
                data[3], -- Is ambulance required?
                data[4], -- Is fire required?
                data[5], -- Is tow required?
                data[6], -- Call description
                data[7], -- Caller name
                data[8], -- Coordinates
                data[9]  -- Contact details
            )
        end,
        codeM = function()
            exports['codem-dispatch']:CustomDispatch({
                coords = data.coords,
                type = data.type,
                header = data.header,
                text = data.description,
                code = '10-53-O-6',
                job = { "fire" },
            })
        end
    }

    local fun = integrations[type]
    if not fun then
        return
    end

    fun()
end)
