local config = lib.load('configs.client')

--local globalState = GlobalState
local SetParkedVehicleDensityMultiplierThisFrame = SetParkedVehicleDensityMultiplierThisFrame
local SetVehicleDensityMultiplierThisFrame = SetVehicleDensityMultiplierThisFrame
local SetRandomVehicleDensityMultiplierThisFrame = SetRandomVehicleDensityMultiplierThisFrame
local SetPedDensityMultiplierThisFrame = SetPedDensityMultiplierThisFrame
local SetScenarioPedDensityMultiplierThisFrame = SetScenarioPedDensityMultiplierThisFrame
local SetScenarioTypeEnabled = SetScenarioTypeEnabled
local SetVehicleModelIsSuppressed = SetVehicleModelIsSuppressed
local SetScenarioGroupEnabled = SetScenarioGroupEnabled

function debugTxt(text)
    if not config.debug then return end

    lib.print.info('^5[DENSITY]^0 '..text)
end

local function disableDispatch()
    if not config.disableDispatchServices then return end

    debugTxt('Disabling dispatch services...')

    CreateThread(function()
        for i = 1, 15 do
            EnableDispatchService(i, false)
        end
        SetCreateRandomCops(false)
        SetCreateRandomCopsOnScenarios(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetDispatchCopsForPlayer(cache.playerId, false)
        SetGarbageTrucks(false)
        DistantCopCarSirens(false)
    end)
end

local function removeVehicles()
    if not config.removeVehiclesFromGeneratorsInArea or not next(config.removeVehiclesFromGeneratorsInArea) then return end

    debugTxt('Removing vehicles from generators in areas...')

    CreateThread(function()
        for x = 1, #config.removeVehiclesFromGeneratorsInArea do
            local coords = config.removeVehiclesFromGeneratorsInArea[x].coords
            local distance = config.removeVehiclesFromGeneratorsInArea[x].distance

            RemoveVehiclesFromGeneratorsInArea((coords.x - distance), (coords.y - distance), (coords.z - distance), (coords.x + distance), (coords.y + distance), (coords.z + distance))
        end
    end)
end

local function setPopulationBudgets()
    debugTxt('Setting population budgets...')

    SetPedPopulationBudget(config.pedPopulationBudget)
    SetVehiclePopulationBudget(config.vehiclePopulationBudget)
end

CreateThread(function()
    disableDispatch()
    removeVehicles()
    setPopulationBudgets()
    --OverrideReactionToVehicleSiren(false, 2)
    SetReactionToVehicleWithSirenDisabled(true)

    debugTxt('Applying density values...')
end)

CreateThread(function()
    while true do
        SetParkedVehicleDensityMultiplierThisFrame(0.7)
        SetVehicleDensityMultiplierThisFrame(0.5)
        SetRandomVehicleDensityMultiplierThisFrame(0.5)
        SetPedDensityMultiplierThisFrame(0.5)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)

        Wait(0)
    end
end)

if config.blacklisted.enableBlacklist then
    CreateThread(function()
        while true do
            if config.blacklisted.scenarioTypes and next(config.blacklisted.scenarioTypes) then
                for x = 1, #config.blacklisted.scenarioTypes do
                    SetScenarioTypeEnabled(config.blacklisted.scenarioTypes[x], false)
                end
            end

            if config.blacklisted.suppressedModels and next(config.blacklisted.suppressedModels) then
                for x = 1, #config.blacklisted.suppressedModels do
                    SetVehicleModelIsSuppressed(config.blacklisted.suppressedModels[x], true)
                end
            end

            if config.blacklisted.scenarioGroups and next(config.blacklisted.scenarioGroups) then
                for x = 1, #config.blacklisted.scenarioGroups do
                    SetScenarioGroupEnabled(config.blacklisted.scenarioGroups[x], false)
                end
            end

            Wait(10000)
        end
    end)
end

AddEventHandler('CEventShockingGunshotFired', function(entity)
    local handle = entity[1]
    TaskSetBlockingOfNonTemporaryEvents(handle, true)
end)

--[[AddEventHandler('populationPedCreating', function(x, y, z, model, setters)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedConfigFlag(ped, 118, true)
    SetPedCombatAttributes(ped, 46, true)
    Citizen.Trace(('making cop at %s %s %s plus a bit (was %s)\n'):format(tostring(x), tostring(y), tostring(z), tostring(model)))

    -- you can also CancelEvent() to skip creating the ped
end)]]