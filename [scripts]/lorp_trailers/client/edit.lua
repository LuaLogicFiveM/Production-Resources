
-- msg [string]: Message to display in the notification
-- type [string]: Type of notification to display
-- timeout [int]: Time in milliseconds to display the notification
function Alert(msg, type, timeout)
    lib.notify({
        type = type,
        description = msg,
        icon = "fas fa-truck",
        duration = timeout,
        position = "top",
    })
end

-- Purpose: Function to display a help text notification.
-- text [string]: Text to display in the notification
function HelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Purpose: Function to check if a vehicle can be attached to the trailer.
-- vehicle [int]: Entity of the vehicle to check
-- trailer [int]: Entity of the trailer to check
function CanVehicleBeAttachedToTrailer(vehicle, trailer)
    --This is for the gs-trucking resource. It will check if a player is on an active job so vehicles dont attach to trailers while on a job.
    if IsResourceOnServer("gs-trucking") then 
        if Entity(trailer).state.gs_trucking then
            return false
        end
    end

    return true
end

-- Purpose: Function to check if player can third eye a trailer.
-- trailer [int]: Entity of the trailer to check
function CanUseTrailer(trailer)
    --Prevent trailers specific to gs-trucking from being used with third eye.
    if IsResourceOnServer("gs-trucking") then 
        if Entity(trailer).state.gs_trucking then
            return false
        end
    end

    --QBcore Vehicle Keys
    --local QBCore = exports['qb-core']:GetCoreObject()
    --local Promise = promise.new()
    --QBCore.Functions.TriggerCallback('qb-vehiclekeys:server:checkPlayerOwned', function(playerOwned)
    --    Promise:resolve(playerOwned)
    --end, QBCore.Functions.GetPlate(trailer))
    --local result = Citizen.Await(Promise)
    --return result

    --Quasar Vehicle Keys
    --local result = exports['qs-vehiclekeys']:GetKey(GetVehicleNumberPlateText(trailer))
    --return result

    return true
end

-- Purpose: Function to check if player has ownership of a vehicle on the trailer.
-- trailer_car [int]: Entity of the vehicle on the trailer to check
-- trailer [int]: Entity of the trailer to check
function HasOwnership(trailer_car)

    --QBcore Vehicle Keys
    --local QBCore = exports['qb-core']:GetCoreObject()
    --local Promise = promise.new()
    --QBCore.Functions.TriggerCallback('qb-vehiclekeys:server:checkPlayerOwned', function(playerOwned)
    --    Promise:resolve(playerOwned)
    --end, QBCore.Functions.GetPlate(trailer_car))
    --local result = Citizen.Await(Promise)
    --return result

    --Quasar Vehicle Keys
    --local result = exports['qs-vehiclekeys']:GetKey(GetVehicleNumberPlateText(trailer_car))
    --return result

    return true
end

-- Purpose: Function triggered when a vehicle has been attached to trailer.
-- vehicle [int]: Entity of the vehicle attached to the trailer
function VehicleAttachedOnTrailer(vehicle)
    --QBcore Vehicle Keys
    --TriggerServerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 2)

    --Quasar Vehicle Keys
    --exports["qs-vehiclekeys"]:DoorLogic(vehicle, true, 2, true, true, true)

    SetVehicleEngineOn(vehicle, false, true, true)
    --SetVehicleDoorsLocked(vehicle, 2)
end

-- Purpose: Function triggered when a vehicle has been detached from trailer.
-- vehicle [int]: Entity of the vehicle detached from the trailer
function VehicleDetachedFromTrailer(vehicle)
    SetVehicleEngineOn(vehicle, true, true, true)
end

-- Purpose: Function to get the vehicles name from the model.
-- vehicle [int]: Entity of the vehicle to get the name of
function GetVehicleName(vehicle)
    --QBCore
    --local QBCore = exports['qb-core']:GetCoreObject()
    --local model = GetEntityModel(vehicle)
    --if QBCore.Shared.Vehicles[model] then return QBCore.Shared.Vehicles[model]["name"] end

    local ModelName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    return (GetLabelText(ModelName) ~= "NULL" and GetLabelText(ModelName) or ModelName)
end