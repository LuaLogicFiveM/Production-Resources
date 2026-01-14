function ShowTooltip(message, duration)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, duration)
end

function GetVehicleLockState(vehicle)
    local lockState = GetVehicleDoorLockStatus(vehicle)
    return lockState == 0 or lockState == 1
end
