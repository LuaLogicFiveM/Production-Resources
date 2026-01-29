local function ForwardToServer(data)
    if type(data) ~= 'table' then return end
    TriggerServerEvent('ps-dispatch:server:notify', data)
end

RegisterLegacyExport('ps-dispatch', 'CustomAlert', function(data)
    ForwardToServer(data)
end)

RegisterNetEvent('ps-dispatch:client:officerdown', function(data) ForwardToServer(data) end)
RegisterNetEvent('ps-dispatch:client:officerbackup', function(data) ForwardToServer(data) end)
RegisterNetEvent('ps-dispatch:client:emsdown', function(data) ForwardToServer(data) end)

local passthroughExports = {
    'VehicleTheft',
    'Shooting',
    'Hunting',
    'VehicleShooting',
    'SpeedingVehicle',
    'Fight',
    'PrisonBreak',
    'StoreRobbery',
    'FleecaBankRobbery',
    'PaletoBankRobbery',
    'PacificBankRobbery',
    'VangelicoRobbery',
    'HouseRobbery',
    'YachtHeist',
    'DrugSale',
    'SuspiciousActivity',
    'CarJacking',
    'InjuriedPerson',
    'DeceasedPerson',
    'OfficerDown',
    'OfficerBackup',
    'OfficerInDistress',
    'EmsDown',
    'Explosion',
    'ArtGalleryRobbery',
    'HumaneRobbery',
    'TrainRobbery',
    'VanRobbery',
    'UndergroundRobbery',
    'DrugBoatRobbery',
    'UnionRobbery',
    'CarBoosting',
    'SignRobbery',
    'BobcatSecurityHeist',
}

for cd = 1, #passthroughExports do
    local exportName = passthroughExports[cd]

    RegisterLegacyExport('ps-dispatch', exportName, function(data)
        if type(data) == 'table' then
            ForwardToServer(data)
        end
    end)
end