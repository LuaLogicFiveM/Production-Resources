local system = Config.target.system
local targetEnabled = (Config.target.enabled and Config.target.system)


------------------------------------------------------------------------------------
--- VEHICLES
------------------------------------------------------------------------------------
function IsRaisedInAnyWay(vehicle)
    return (Entity(vehicle).state.isRaised or Entity(vehicle).state.onKqCarLift)
end

function InitializeTargetVehicles()
    local targetData = {
        options = {
            {
                type = 'client',
                event = 'kq_drifttires:target:lowerVehicle',
                label = L('Lower the vehicle'),
                icon = 'fas fa-eye',
                canInteract = function(vehicle)
                    return IsRaisedInAnyWay(vehicle) and (not inMinigame and not nextToBalancer and CanChangeTires())
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:putOnWheel',
                label = L('Put on the wheel'),
                icon = 'fas fa-eye',
                canInteract = function(vehicle)
                    return IsRaisedInAnyWay(vehicle) and (CanVehicleUseDriftTires(vehicle) and wheelInHands and CanChangeTires())
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:startTireSwapping',
                label = L('Start tire swapping'),
                icon = 'fas fa-eye',
                canInteract = function(vehicle)
                    return not IsVehicleOnAllWheels(vehicle) and IsEntityTouchingModel(vehicle, GetHashKey('imp_prop_kq_lift_arms')) and GetPedInVehicleSeat(vehicle, -1) == 0 and CanVehicleUseDriftTires(vehicle) and CanChangeTires()
                end,
            },
        },
        distance = 2.0
    }
    
    if Config.target.system == 'qb-target' then
        exports[system]:AddGlobalVehicle(targetData)
    elseif Config.target.system == 'ox_target' then
        exports[system]:addGlobalVehicle(targetData.options)
    else
        exports[system]:Vehicle(targetData)
    end
    
    for k, wheel in pairs(wheelBones) do
        targetData = {
            options = {
                {
                    type = 'client',
                    event = 'kq_drifttires:target:takeOffWheel',
                    label = L('Take off the drift wheel'),
                    icon = 'fas fa-eye',
                    bone = wheel,
                    bones = {wheel},
                    canInteract = function(vehicle)
                        local tireTypes = Entity(vehicle).state.tireTypes
                        return IsRaisedInAnyWay(vehicle) and CanVehicleUseDriftTires(vehicle) and not IsWheelRemoved(vehicle, wheel) and not wheelInHands and not IsVehicleWheelBroken(vehicle, wheel) and (tireTypes and tireTypes[wheel] and tireTypes[wheel] == 1)
                    end,
                },
                {
                    type = 'client',
                    event = 'kq_drifttires:target:takeOffWheel',
                    label = L('Take off the regular wheel'),
                    icon = 'fas fa-eye',
                    bone = wheel,
                    bones = {wheel},
                    canInteract = function(vehicle)
                        local tireTypes = Entity(vehicle).state.tireTypes
                        return IsRaisedInAnyWay(vehicle) and CanVehicleUseDriftTires(vehicle) and not IsWheelRemoved(vehicle, wheel) and not wheelInHands and not IsVehicleWheelBroken(vehicle, wheel) and (not tireTypes or not tireTypes[wheel] or tireTypes[wheel] == 0)
                    end,
                },
                {
                    type = 'client',
                    event = 'kq_drifttires:target:addAir',
                    label = L('Add 10% of pressure to the tire'),
                    icon = 'fas fa-eye',
                    bones = {wheel},
                    canInteract = function(vehicle)
                        return isUsingCompressor and Entity(vehicle).state.hasDriftTires
                    end,
                },
                {
                    type = 'client',
                    event = 'kq_drifttires:target:removeAir',
                    label = L('Remove 10% of pressure to the tire'),
                    icon = 'fas fa-eye',
                    bones = {wheel},
                    canInteract = function(vehicle)
                        return isUsingCompressor and Entity(vehicle).state.hasDriftTires
                    end,
                },
            },
            distance = 2.0
        }
        
        if Config.target.system == 'ox_target' then
            exports[system]:addGlobalVehicle(targetData.options)
        else
            exports[system]:AddTargetBone({wheel}, targetData)
        end
    end
end

if targetEnabled then
    InitializeTargetVehicles()
end

RegisterNetEvent('kq_drifttires:target:lowerVehicle')
AddEventHandler('kq_drifttires:target:lowerVehicle', function(data)
    local vehicle = data.entity
    if not vehicle then
        return
    end
    
    local min, max = GetModelDimensions(GetEntityModel(vehicle))
    local rearCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, min.y, 0.3)
    LowerVehicle(rearCoords)
end)

RegisterNetEvent('kq_drifttires:target:startTireSwapping')
AddEventHandler('kq_drifttires:target:startTireSwapping', function(data)
    local vehicle = data.entity
    if not vehicle then
        return
    end
    
    StartTireSwapping(vehicle)
end)

RegisterNetEvent('kq_drifttires:target:takeOffWheel')
AddEventHandler('kq_drifttires:target:takeOffWheel', function(data)
    local vehicle = data.entity
    if not vehicle then
        return
    end
    
    TakeOffWheel(vehicle, data.bone)
end)

RegisterNetEvent('kq_drifttires:target:putOnWheel')
AddEventHandler('kq_drifttires:target:putOnWheel', function(data)
    local vehicle = data.entity
    if not vehicle then
        return
    end
    
    local wheel, distance = GetClosestWheelBone(vehicle)
    if IsWheelRemoved(vehicle, wheel) then
        PutOnWheel(vehicle, wheel)
    else
        ShowTooltip(L('~r~There already is a wheel here'))
    end
end)



------------------------------------------------------------------------------------
--- WHEEL BALANCERS
------------------------------------------------------------------------------------

function InitializeTargetWheelBalancers()
    local targetData = {
        options = {
            {
                type = 'client',
                event = 'kq_drifttires:target:putWheelOnBalancer',
                label = L('Put wheel on balancer'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return CanChangeTires() and wheelInHands and not inMinigame and not usingBalancer
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:changeTireType',
                label = L('Change tire type to drift tire'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() <= 0 and GetTypeWheelInBalancer() ~= 1
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:changeTireType',
                label = L('Change tire type to regular tire'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() <= 0 and GetTypeWheelInBalancer() == 1
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:takeWheelOffBalancer',
                label = L('Take the wheel off the balancer'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() <= 0 and GetBalance() == GetCorrectBalance() and GetTested()
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:accelerateBalancer',
                label = L('Accelerate the balancer'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() <= 0
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:deaccelerateBalancer',
                label = L('Deaccelerate the balancer'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() >= Config.wheelBalancers.maxSpinningSpeed
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:addWeights',
                label = L('Add more weights'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() <= 0
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:removeWeights',
                label = L('Remove weights'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return GetWheelInBalancer() ~= nil and GetBalancerSpeed() <= 0
                end,
            },
        },
        distance = 2.0
    }
    
    if system == 'ox_target' then
        exports[system]:addModel({GetHashKey('kq_wheel_balancer')}, targetData.options)
    else
        exports[system]:AddTargetModel({GetHashKey('kq_wheel_balancer')}, targetData)
    end
end

if targetEnabled then
    InitializeTargetWheelBalancers()
end

RegisterNetEvent('kq_drifttires:target:putWheelOnBalancer')
AddEventHandler('kq_drifttires:target:putWheelOnBalancer', function(data)
    local balancer = data.entity
    if not balancer then
        return
    end
    
    UseBalancer(balancer)
end)

RegisterNetEvent('kq_drifttires:target:changeTireType')
AddEventHandler('kq_drifttires:target:changeTireType', function(data)
    local balancer = data.entity
    if not balancer then
        return
    end
    
    ChangeTireTypeCall(GetEntityCoords(balancer))
end)
RegisterNetEvent('kq_drifttires:target:takeWheelOffBalancer')
AddEventHandler('kq_drifttires:target:takeWheelOffBalancer', function(data)
    TakeWheelOffBalancer()
end)

RegisterNetEvent('kq_drifttires:target:accelerateBalancer')
AddEventHandler('kq_drifttires:target:accelerateBalancer', function(data)
    local balancer = data.entity
    if not balancer then
        return
    end
    
    AccelerateWheel(balancer)
end)

RegisterNetEvent('kq_drifttires:target:deaccelerateBalancer')
AddEventHandler('kq_drifttires:target:deaccelerateBalancer', function(data)
    local balancer = data.entity
    if not balancer then
        return
    end
    
    DeaccelerateWheel(balancer)
end)

RegisterNetEvent('kq_drifttires:target:addWeights')
AddEventHandler('kq_drifttires:target:addWeights', function()
    ChangeCurrentBalance(1)
end)

RegisterNetEvent('kq_drifttires:target:removeWeights')
AddEventHandler('kq_drifttires:target:removeWeights', function()
    ChangeCurrentBalance(-1)
end)


------------------------------------------------------------------------------------
--- SHOPS
------------------------------------------------------------------------------------
function AddEntityToTargeting(entity, hash, label, item)
    if targetEnabled then
        local options = {
            {
                type = 'client',
                event = 'kq_drifttires:target:buy',
                label = label,
                icon = 'fas fa-eye',
                shopItem = item,
                canInteract = function()
                    return CanUseTireShops()
                end,
            },
        }
        
        if system == 'ox_target' then
            exports[system]:addEntity(entity, options)
        else
            exports[system]:AddTargetEntity(entity, {
                options = options,
                distance = 2.0
            })
        end
    end
end


RegisterNetEvent('kq_drifttires:target:buy')
AddEventHandler('kq_drifttires:target:buy', function(data)
    TriggerServerEvent('kq_drifttires:server:makePurchase', data.shopItem)
    
    Citizen.CreateThread(function()
        PlayAnim('anim@mp_radio@high_life_apment', 'button_press_living_room')
        
        Citizen.Wait(1000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)

------------------------------------------------------------------------------------
--- AIR COMPRESSORS
------------------------------------------------------------------------------------

function InitializeTargetAirCompressors()
    local targetData = {
        options = {
            {
                type = 'client',
                event = 'kq_drifttires:target:useAirCompressor',
                label = L('Use air compressor'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return not isUsingCompressor
                end,
            },
            {
                type = 'client',
                event = 'kq_drifttires:target:stopUsingAirCompressor',
                label = L('Stop using air compressor'),
                icon = 'fas fa-eye',
                canInteract = function(balancer)
                    return isUsingCompressor
                end,
            },
        },
        distance = 2.0
    }

    if system == 'ox_target' then
        exports[system]:addModel(Config.tirePressure.models, targetData.options)
    else
        exports[system]:AddTargetModel(Config.tirePressure.models, targetData)
    end
end


if targetEnabled then
    InitializeTargetAirCompressors()
end


RegisterNetEvent('kq_drifttires:target:useAirCompressor')
AddEventHandler('kq_drifttires:target:useAirCompressor', function(data)
    UseAirCompressor(data.entity)
end)

RegisterNetEvent('kq_drifttires:target:stopUsingAirCompressor')
AddEventHandler('kq_drifttires:target:stopUsingAirCompressor', function(data)
    StopUsingAirCompressor(data.entity)
end)

RegisterNetEvent('kq_drifttires:target:addAir')
AddEventHandler('kq_drifttires:target:addAir', function(data)
    local newPressure = SubmitPressureChange(data.entity, 10)
    Citizen.CreateThread(function()
        ShowTooltip(L('Tires now have {pressure}% of pressure'):gsub('{pressure}', newPressure))
    end)
end)

RegisterNetEvent('kq_drifttires:target:removeAir')
AddEventHandler('kq_drifttires:target:removeAir', function(data)
    local newPressure = SubmitPressureChange(data.entity, -10)
    Citizen.CreateThread(function()
        ShowTooltip(L('Tires now have {pressure}% of pressure'):gsub('{pressure}', newPressure))
    end)
end)
