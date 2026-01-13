-- Check for ox_lib availability
local hasOxLib = GetResourceState('ox_lib') == 'started'
if not hasOxLib then
    print("^1[SAHP Entity Sets]^7 OXLIB Not found. Entity set manager turned off")
end

if GetResourceState("FS-InteriorManager") == "started" or GetResourceState("FS-InteriorManager") == "starting" then return end

-- Initialize entity sets state in GlobalState for each interior
CreateThread(function()
    -- Entity Sets for SAHP location 1 (839.7197, -1291.275, 27.0595)
    if not GlobalState.sahp_entitySets_interior1 then
        GlobalState.sahp_entitySets_interior1 = {
            onlychairs = Config.DefaultEntitySets.onlychairs or false,
            chairsandtables = Config.DefaultEntitySets.chairsandtables or false
        }
    end
    
    -- Entity Sets for SAHP location 2 (1538.29822, 803.9021, 77.9835052)
    if not GlobalState.sahp_entitySets_interior2 then
        GlobalState.sahp_entitySets_interior2 = {
            onlychairs = Config.DefaultEntitySets.onlychairs or false,
            chairsandtables = Config.DefaultEntitySets.chairsandtables or false
        }
    end
end)

-- Event handlers for entity set synchronization
RegisterNetEvent('sahp:sync:toggleEntitySet', function(entitySet, state, interiorIndex)
    -- If no interior index specified, update both (for backward compatibility)
    if not interiorIndex then
        local entitySets1 = GlobalState.sahp_entitySets_interior1
        entitySets1[entitySet] = state
        GlobalState.sahp_entitySets_interior1 = entitySets1
        
        local entitySets2 = GlobalState.sahp_entitySets_interior2
        entitySets2[entitySet] = state
        GlobalState.sahp_entitySets_interior2 = entitySets2
    else
        -- Update specific interior
        local stateKey = "sahp_entitySets_interior" .. interiorIndex
        local entitySets = GlobalState[stateKey]
        entitySets[entitySet] = state
        GlobalState[stateKey] = entitySets
    end
end)

-- New event handler to apply default config settings
RegisterNetEvent('sahp:sync:applyDefaults')
AddEventHandler('sahp:sync:applyDefaults', function()
    -- This event is triggered by the client when ox_lib is not found
    -- Update the GlobalState with the default values from the config for both interiors
    GlobalState.sahp_entitySets_interior1 = {
        onlychairs = Config.DefaultEntitySets.onlychairs or false,
        chairsandtables = Config.DefaultEntitySets.chairsandtables or false
    }
    GlobalState.sahp_entitySets_interior2 = {
        onlychairs = Config.DefaultEntitySets.onlychairs or false,
        chairsandtables = Config.DefaultEntitySets.chairsandtables or false
    }
end)