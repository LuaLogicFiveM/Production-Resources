function TargetShopItems(object, objectInfo)
    if (Config.target.enabled and Config.target.system) then

        local system = Config.target.system
        local player = PlayerPedId()
        local objectData = objectInfo
        local coords = GetEntityCoords(object)

        local options = {
            {
                type = "client",
                event = 'ls_wheelspacers:Target:TargetBuyItem',
                icon = "fa-solid fa-wrench",
                label = L("Buy ") .. objectInfo.label .. L(" for ") .. objectInfo.price .. L("$"),
                objectData = objectData
            },
        }

        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addLocalEntity({object}, options)
        else
            exports[system]:AddBoxZone(object, coords, 0.8, 0.8, {
                name = object,
                heading = 0.0,
                minZ = coords.z - 0.5,
                maxZ = coords.z + 1.0,
            },
                {
                    options = options,
                    distance = 1.5
                }
            )
        end
    end
end

function IsLiftLocked()
    if not GetNearestCarLift() then
        return false
    end
    
    return Entity(GetNearestCarLift()).state.liftLocked
end

local boxZoneNames = {}

function TargetAction(coords, wheelIndex, vehicle, onCarLift)
    if Config.debug then
        print('targeting vehicle')
    end

    if (Config.target.enabled and Config.target.system) and vehicle then
        local system = Config.target.system
        local player = PlayerPedId()
        local wheelName = ReturnWheelIndexName(wheelIndex)
        local name = wheelName .. tostring(vehicle)
        local vehicleHeading = GetEntityHeading(vehicle)

        wheelIndex = wheelIndex - 1        
        local options = {
            {
                type = "client",
                event = 'ls_wheelspacers:Target:UnmountWheel',
                icon = "fa-solid fa-wrench",
                label = L("Unmount ") .. wheelName .. L(" wheel"),
                vehicle = vehicle,
                coords = coords,
                wheelIndex = wheelIndex,
                onCarLift = onCarLift,
                canInteract = function() return not isHoldingTire and IsWheelMounted(vehicle, wheelIndex) and not Entity(vehicle).state['isWheelWorkedOn' .. wheelIndex + 1] and (IsLiftLocked() or not onCarLift) end
            },
            {
                type = "client",
                event = 'ls_wheelspacers:Target:MountWheel',
                icon = "fa-solid fa-wrench",
                label = L("Mount ") .. wheelName .. L(" wheel"),
                vehicle = vehicle,
                coords = coords,
                wheelIndex = wheelIndex,
                onCarLift = onCarLift,
                canInteract = function() return isHoldingTire and not IsWheelMounted(vehicle, wheelIndex) and not spacer and not Entity(vehicle).state['isWheelWorkedOn' .. wheelIndex + 1] and Entity(vehicle).state['boneCoords' .. wheelIndex + 1] and (IsLiftLocked() or not onCarLift)  end
            },
            {
                type = "client",
                event = 'ls_wheelspacers:Target:MountSpacer',
                icon = "fa-solid fa-wrench",
                label = L("Mount ") .. wheelName .. L(" spacer"),
                vehicle = vehicle,
                coords = coords,
                wheelIndex = wheelIndex,
                canInteract = function() return not isHoldingTire and not IsWheelMounted(vehicle, wheelIndex) and spacer and not Entity(vehicle).state['isWheelWorkedOn' .. wheelIndex + 1] and Entity(vehicle).state['boneCoords' .. wheelIndex + 1] and (IsLiftLocked() or not onCarLift)  end
            },
            {
                type = "client",
                event = 'ls_wheelspacers:Target:UnMountSpacer',
                icon = "fa-solid fa-wrench",
                label = L("Unmount ") .. wheelName .. L(" spacer"),
                vehicle = vehicle,
                coords = coords,
                wheelIndex = wheelIndex,
                canInteract = function() return not isHoldingTire and not IsWheelMounted(vehicle, wheelIndex) and not spacer and not Entity(vehicle).state['isWheelWorkedOn' .. wheelIndex + 1] and Entity(vehicle).state['boneCoords' .. wheelIndex + 1] and Entity(vehicle).state['spacerPropID' .. wheelIndex + 1] and Entity(vehicle).state['wheel' .. wheelIndex + 1] and (IsLiftLocked() or not onCarLift) end
            },
            {
                type = "client",
                event = 'ls_wheelspacers:Target:LowerCar',
                icon = "fa-solid fa-wrench",
                label = L("Lower vehicle"),
                vehicle = vehicle,
                coords = GetJackTargetCoords(vehicle),
                canInteract = function() return IsCarReadyForLowering(vehicle) and not onCarLift  end
            },
            {
                type = "client",
                event = 'ls_wheelspacers:Target:UnlockCar',
                icon = "fa-solid fa-wrench",
                label = L("Finish Working"),
                vehicle = vehicle,
                coords = GetJackTargetCoords(vehicle),
                canInteract = function() return IsLiftLocked() and onCarLift and IsCarReadyForLowering(vehicle)
                end
            }
        }

        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addBoxZone({
                name = name,
                coords = coords,
                size = vector3(0.8, 0.8, 0.8),
                rotation = vehicleHeading,
                debug = Config.debug,
                options = options,
            })
            table.insert(boxZoneNames, name)
        else
            exports[system]:AddCircleZone(name, coords, 0.5, {
                num = 1,
                name = name,
                debugPoly = Config.debug,
            },
                {
                    options = options,
                    distance = 2.0
                }
            )
            table.insert(boxZoneNames, name)
        end
    end
end

function TargetWheelPickup(object)
    if (Config.target.enabled and Config.target.system) then
        local system = Config.target.system
        local player = PlayerPedId()
        local coords = GetEntityCoords(object)

        local options = {
            {
                type = "client",
                event = 'ls_wheelspacers:Target:PickUpWheel',
                icon = "fa-solid fa-wrench",
                label = L("Pick up wheel"),
                object = object
            },
        }

        if system == 'ox-target' or system == 'ox_target' then
            exports[system]:addLocalEntity({object}, options)
        else
            exports[system]:AddTargetEntity(object, {                    
                options = options,
                distance = 1.4
                }
            )
        end
    end
end

function StopWorking()
    TriggerServerEvent('ls_wheelspacers:SetPlayerWorking', true)
    working = false
end

function DeleteBoxZones()
    local system = Config.target.system
    if system == 'ox_target' or system == 'ox-target' then
        for k, name in pairs(boxZoneNames) do
            exports[system]:removeZone(k)
        end
    else
        for k, name in pairs(boxZoneNames) do
            exports[system]:RemoveZone(name)
        end
    end
    boxZoneNames = {}
end

function IsCarReadyForLowering(vehicle)
    for k = 1, 4, 1 do
        if Entity(vehicle).state['isWheelWorkedOn' .. k + 1] or not IsWheelMounted(vehicle, k - 1) then
            return false
        end
    end

    return true
end

function ReturnWheelIndexName(wheelIndex)
    local wheelIndexNames = {L('front driver'), L('front passenger'), L('rear driver'), L('rear passenger')}

    return wheelIndexNames[wheelIndex]
end

function AddEntityToTargeting(entity)
    local system = Config.target.system

    local options = {
        {
            type = "client",
            event = 'ls_wheelspacers:Target:LockCar',
            icon = "fas fa-user-injured",
            vehicle = entity,
            label = L('Lock Vehicle'),
            canInteract = function()
                return not IsEntityPositionFrozen(entity) and working and IsEntityTouchingEntity(entity, GetNearestCarLift()) and not IsVehicleOnAllWheels(vehicle)
            end,
        },
    }

    if system == 'ox-target' or system == 'ox_target' then
        exports[system]:addLocalEntity({entity}, options)
    else
        exports[system]:AddTargetEntity(entity, {
            options = options,
            distance = 2.5
        })
    end
end

function RemoveEntityFromTargeting(entity)
    local system = Config.target.system

    local options = {
        {
            type = "client",
            event = 'ls_wheelspacers:Target:LockCar',
            icon = "fas fa-user-injured",
            vehicle = entity,
            label = L('Lock Vehicle'),
            canInteract = function()
                return not IsEntityPositionFrozen(entity) and working and IsEntityTouchingEntity(entity, GetNearestCarLift()) and not IsVehicleOnAllWheels(vehicle)
            end,
        },
    }

    if system == 'ox-target' or system == 'ox_target' then
        exports[system]:removeLocalEntity({entity})
    else
        exports[system]:RemoveTargetEntity(entity)
    end
end

RegisterNetEvent('ls_wheelspacers:Target:PickUpWheel')
AddEventHandler('ls_wheelspacers:Target:PickUpWheel', function(data)
    DeleteEntity(data.object)
    droppedWheels[data.object] = nil
    local newWheelObject = PutWheelInHands()

    _G['wheelObject'] = newWheelObject
    _G['isHoldingTire'] = true
end)

RegisterNetEvent('ls_wheelspacers:Target:LowerCar')
AddEventHandler('ls_wheelspacers:Target:LowerCar', function()
    LowerVehicle(false)
    DeleteBoxZones()
end)

RegisterNetEvent('ls_wheelspacers:Target:UnlockCar')
AddEventHandler('ls_wheelspacers:Target:UnlockCar', function(data)
    ToggleVehicleFrozen(data.vehicle, false)
    DeleteBoxZones()
    RemoveEntityFromTargeting(data.vehicle)
    lastWorkSessionActive = true
end)

RegisterNetEvent('ls_wheelspacers:Target:LockCar')
AddEventHandler('ls_wheelspacers:Target:LockCar', function(data)
    ToggleVehicleFrozen(data.vehicle, true)
end)

RegisterNetEvent('ls_wheelspacers:Target:TargetBuyItem')
AddEventHandler('ls_wheelspacers:Target:TargetBuyItem', function(data)
    BuyItem(data.objectData)
end)

RegisterNetEvent('ls_wheelspacers:Target:UnmountWheel')
AddEventHandler('ls_wheelspacers:Target:UnmountWheel', function(data)
    local wheelObject = UnmountWheel(data.vehicle, data.coords, data.wheelIndex, data.onCarLift)

    if wheelObject then
        _G['isHoldingTire'] = true
    end

    _G['wheelObject'] = wheelObject
end)

RegisterNetEvent('ls_wheelspacers:Target:UnMountSpacer')
AddEventHandler('ls_wheelspacers:Target:UnMountSpacer', function(data)
    UnMountSpacer(data.vehicle, data.coords, data.wheelIndex)
end)

RegisterNetEvent('ls_wheelspacers:Target:MountSpacer')
AddEventHandler('ls_wheelspacers:Target:MountSpacer', function(data)
    MountSpacer(data.vehicle, data.coords, data.wheelIndex, _G['spacer'])
    _G['spacer'] = nil
    TriggerServerEvent('ls_wheelspacers:ResetSpacerValue', nil) -- || with this, only one player is able to hold spacer || Robbie
    spacer = nil
end)

RegisterNetEvent('ls_wheelspacers:Target:MountWheel')
AddEventHandler('ls_wheelspacers:Target:MountWheel', function(data)
    local wheelObject = MountWheel(data.vehicle, data.coords, data.wheelIndex, wheelObject, data.onCarLift)

    if wheelObject then
        _G['isHoldingTire'] = true
    end

    _G['wheelObject'] = wheelObject
end)

function TargetDroppedWheels(droppedWheels)
    return UseCache('targetDroppedWheels', function()
        for k, wheel in pairs(droppedWheels) do
            if wheel ~= 'targeted' then
                TargetWheelPickup(wheel)
                droppedWheels[wheel] = 'targeted'
            end
        end
    end, 1000)
end