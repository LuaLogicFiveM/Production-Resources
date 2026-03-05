--- @script core/client/classes/utils.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@class section: constants

--- @field utils: Stores utility related functions.
utils = utils or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@class section: functions

---@param loadType string
---@param loadValue any
---@return boolean
---@usage utils.performShapeTest('ModelAsset', hashKey, 1000})
local function load_and_cache(loadType, loadValue, customTimeout)
    local timeout = customTimeout or (1 * 5000)
    local startTime = GetGameTimer()

    local function loadAsset(isAssetLoaded, requestAsset, assetType)
        if assetType ~= 'WeaponAsset' then 
            requestAsset(loadValue)
        else
            requestAsset(loadValue, 31, 0)
        end

        while not isAssetLoaded(loadValue) do
            if GetGameTimer() - startTime >= timeout then
                    init.log('error', ('%s loading timed out for: %s'):format(assetType, tostring(loadValue)))
                return false
            end
            Citizen.Wait(0)
        end
        return true
    end

    local loadFunctions = {
        ['ModelAsset'] = function()
            if not IsModelValid(loadValue) or not IsModelInCdimage(loadValue) then
                    init.log('error', ('Attempted to load invalid model: %s'):format(tostring(loadValue)))
                return false
            end
            return loadAsset(HasModelLoaded, RequestModel, "Model")
        end,
        ['AnimDict'] = function()
            if not DoesAnimDictExist(loadValue) then
                    init.log('error', ('Attempted to load invalid animDict: %s'):format(tostring(loadValue)))
                return false
            end
            return loadAsset(HasAnimDictLoaded, RequestAnimDict, "AnimDict")
        end,
        ['TextureDict'] = function()
            return loadAsset(HasStreamedTextureDictLoaded, RequestStreamedTextureDict, "TextureDict")
        end,
        ['ParticleEffect'] = function()
            return loadAsset(HasNamedPtfxAssetLoaded, RequestNamedPtfxAsset, "ParticleEffect")
        end,
        ['RopeTexture'] = function()
            return loadAsset(RopeAreTexturesLoaded, RopeLoadTextures, "RopeTexture")
        end,
        ['WeaponAsset'] = function()
            if not IsWeaponValid(loadValue) then
                    init.log('error', ('Attempted to load invalid WeaponAsset: %s'):format(loadValue))
                return false
            end
            return loadAsset(HasWeaponAssetLoaded, RequestWeaponAsset, "WeaponAsset")
        end
    }

    local loadFunc = loadFunctions[loadType]
    if loadFunc then
        return loadFunc()
    end

    init.log('error', ('Invalid load type: %s'):format(tostring(loadType)))
    return false
end

utils.loadAndCache = load_and_cache

---Returns the numeric key code for a given action name.
---If the action name does not exist in the config or the key is not found,
---the function returns nil.
---@param actionName string  # The name of the action for which we need the key code.
---@return number?           # The key code if found, otherwise nil.
local function getKey(actionName)
    -- Check if the actionName is valid in cfg.keybinds
    local key = cfg.keybinds[actionName]
    if not key then
        return nil
    end

    -- Convert the key to uppercase for consistency in lookup
    local mappedKey = keybinds[key:upper()]
    if not mappedKey then
        return nil
    end

    return mappedKey
end

utils.getKey = getKey

---Requests network control of a given entity and blocks until control is acquired.
---@param objHandle number  # The entity handle for which we want network control.
---@return boolean          # Returns true once control is obtained.
local function requestNetworkControl(objHandle)
    -- Local function to display a loading spinner
    local function showSpinner()
        AddTextEntry("MP_SPINLOADING", "Seeking Network Control")
        BeginTextCommandBusyspinnerOn("MP_SPINLOADING")
        EndTextCommandBusyspinnerOn("BUSY_SPINNER_RIGHT")
    end

    local startTime = GetGameTimer()

    -- Attempt to acquire control of the entity in a loop
    repeat
        showSpinner()
        NetworkRequestControlOfEntity(objHandle)
        Citizen.Wait(0)
        
        if GetGameTimer() - startTime > 5000 then
                BusyspinnerOff()
            return false
        end
    until NetworkHasControlOfEntity(objHandle)

    BusyspinnerOff()
    return true
end

utils.requestNetworkControl = requestNetworkControl

--- Manages airflow around an entity to disperse smoke if certain conditions are met.
--- Continues checking until the entity's data/status is no longer valid.
---@param networkId number  # The entity's network identifier.
local function airFlow(networkId)
    if not networkId then
        return false
    end

    local objHandle = NetToObj(networkId)
    local integrations = cfg.integrations

    local zFireIntegration = integrations["z_fire"]
    local zFireEnabled = zFireIntegration and zFireIntegration[1]
    
    while true do
        local data = init.objectPool[networkId]
        
        if not data or data.status == nil then
            break
        end

        local raycast = init.functions.shapeTest(objHandle)

        if raycast.entityHit == 0 and zFireEnabled then
            local smokeTable = exports[zFireIntegration.resourceName]:getSmokeInRange(raycast.endPos, 10.0)
            
            if next(smokeTable) then
                local smokeIds = {}

                for _, smokeData in pairs(smokeTable) do
                    if smokeData.data.canDisperse then
                        table.insert(smokeIds, smokeData.id)
                    end
                end

                Citizen.Wait(math.random(1, 15) * 1000)
                exports[zFireIntegration.resourceName]:deleteSmokeById(smokeIds)
            end
        end

        Citizen.Wait(1)
    end

    return true
end

utils.airFlow = airFlow

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------