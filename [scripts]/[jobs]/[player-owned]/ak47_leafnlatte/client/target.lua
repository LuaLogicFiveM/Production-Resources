local targets = {}
local targetting = false

Citizen.CreateThread(function()
    for i, v in pairs(Config.StockItems) do
        local target = exports[Config.TargetScript]:AddCircleZone("FarmingMultiItemsLeafnlatte"..i, v.pos, v.size, {
            name = "FarmingMultiItemsLeafnlatte"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-cookie-bite',
                    label = _U('stock_farm_multi_target'),
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'leafnlatte'
                    end,
                    action = function()
                        openFarmGetMultiItem(i)
                    end,
                },
            },
            distance = 2.0
        })
        table.insert(targets, target)
    end

    for i, v in pairs(Config.Shop.edibles) do
        local target = exports[Config.TargetScript]:AddBoxZone("LeafnlatteEdibles"..i, v.pos, v.boxSize.x, v.boxSize.y, {
            name = "LeafnlatteEdibles"..i,
            heading = v.boxHeading,
            debugPoly = Config.DebugPoly,
            minZ = v.pos.z,
            maxZ = v.pos.z + 0.6,
            }, {
            options = {
                {
                    icon = 'fa-solid fa-plate-wheat',
                    label = _U('eat_edible'),
                    canInteract = function()
                        CreateThread(function()
                            local timer = GetGameTimer()
                            while GetGameTimer() - timer < 2000 do
                                Wait(0)
                                DrawTxt3D(vector3(v.pos.x, v.pos.y, v.pos.z + 0.8), v.item.label)
                            end
                        end)
                        return true
                    end,
                    action = function()
                        local data = lib.callback.await('ak47_leafnlatte:getedableinfo', nil, v.item.name)
                        if data.stock > 0 then
                            TriggerServerEvent('ak47_leafnlatte:tryeat', i)
                        else
                            TriggerEvent('ak47_leafnlatte:notify', _U('nostock'), 'error')
                        end
                    end,
                },
                {
                    icon = 'fa-solid fa-basket-shopping',
                    label = _U('buy_edible'),
                    action = function()
                        local data = lib.callback.await('ak47_leafnlatte:getedableinfo', nil, v.item.name)
                        if data.stock > 0 then
                            local input = lib.inputDialog(_U('buyinput', v.item.label, data.price), {
                                {type = 'number', label = _U('amount', data.stock), min = 1, max = data.stock, default = 1},
                                {type = 'select', label = _U('paymenttype'), options = {
                                    {label = _U('cash'), value = 'money'},
                                    {label = _U('card'), value = 'bank'},
                                }, default = 'money'},
                            })
                            TriggerServerEvent('ak47_leafnlatte:buyedible', v.item.name, input[1], input[2])
                        else
                            TriggerEvent('ak47_leafnlatte:notify', _U('nostock'), 'error')
                        end
                    end,
                },
            },
            distance = 3.5
        })
        table.insert(targets, target)
    end

    for i, v in pairs(Config.Shop.sell_coords) do
        local target = exports[Config.TargetScript]:AddCircleZone("LeafnlatteSell"..i, v.pos, v.radius, {
            name = "LeafnlatteSell"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-cookie-bite',
                    label = _U('press_to_open_target'),
                    action = function()
                        TriggerServerEvent('ak47_leafnlatte:openMarket', i)
                    end,
                },
            },
            distance = 1.5
        })
        table.insert(targets, target)
    end

    local target = exports[Config.TargetScript]:AddCircleZone("LeafnlatteSellManagement", Config.Shop.management, 1.1, {
        name = "LeafnlatteSellManagement",
        debugPoly = Config.DebugPoly,
        useZ = true
        }, {
        options = {
            {
                type = 'server',
                event = 'ak47_leafnlatte:openmanagement',
                icon = 'fa-solid cash-register',
                label = _U('open_management'),
                canInteract = function(entity)
                    return PlayerData and PlayerData.job and PlayerData.job.name == 'leafnlatte' and PlayerData.job.grade >= Config.ManagementRank.stock
                end,
            },
        },
        distance = 2.0
    })
    table.insert(targets, target)

    for i, v in pairs(Config.ProcessLocations) do
        local target = exports[Config.TargetScript]:AddCircleZone("LeafnlatteProcess"..i, vector3(v.x, v.y, v.z), 1.0, {
            name = "LeafnlatteProcess"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-cookie-bite',
                    label = _U('open_process_target'),
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'leafnlatte'
                    end,
                    action = function()
                        TriggerServerEvent('ak47_leafnlatte:openMarketProcess', i)
                    end,
                },
            },
            distance = 2.0
        })
        table.insert(targets, target)
    end

    for i, v in pairs(Config.FarmingItems) do
        local target = exports[Config.TargetScript]:AddCircleZone("LeafnlatteFarmingItems"..i, v.pos, 1.5, {
            name = "LeafnlatteFarmingItems"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-box',
                    label = v.msgtarget,
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'leafnlatte'
                    end,
                    action = function()
                        openFarmGetItem(i, FarmingItems[i])
                    end,
                },
            },
            distance = 2.0
        })
        table.insert(targets, target)
    end

    local targetting = false
    for i, v in pairs(Config.Hookah) do
        local target = exports[Config.TargetScript]:AddCircleZone("LeafnlatteHookah"..i, v.pos, v.size, {
            name = "LeafnlatteHookah"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-bong',
                    label = _U('session', v.price),
                    canInteract = function(entity)
                        CreateThread(function()
                            local timer = GetGameTimer()
                            while GetGameTimer() - timer < 2000 do
                                Wait(0)
                                DrawTxt3D(vector3(v.pos.x, v.pos.y, v.pos.z + 0.8), _U('available', Config.Hookah[i].availablePuff, Config.Hookah[i].maxPuff))
                            end
                        end)
                        return true
                    end,
                    action = function()
                        TriggerServerEvent('ak47_leafnlatte:canstartpuff', i)
                    end,
                },
                {
                    icon = 'fa-solid fa-recycle',
                    label = _U('refill'),
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'leafnlatte'
                    end,
                    action = function()
                        TriggerServerEvent('ak47_leafnlatte:refillHookah', i)
                    end,
                },
            },
            distance = 2.5
        })
        table.insert(targets, target)
    end

    for i, v in pairs(Config.Bar) do
        for j, k in pairs(v.items) do
            local target = exports[Config.TargetScript]:AddBoxZone("LeafnlatteDrink"..i..j, k.pos, k.zone.size.x, k.zone.size.y, {
                name = "LeafnlatteDrink"..i..j,
                heading = k.zone.heading,
                debugPoly = Config.DebugPoly,
                minZ = k.pos.z,
                maxZ = k.pos.z + k.zone.size.z,
                }, {
                options = {
                    {
                        icon = 'fa-solid fa-wine-glass',
                        label = v.label,
                        action = function()
                            OpenDrinkMenu(i, v, j, k)
                        end,
                    },
                    {
                        icon = 'fa-solid fa-fill',
                        label = _U('refill'),
                        canInteract = function()
                            return PlayerData.job and PlayerData.job.name == 'leafnlatte'
                        end,
                        action = function()
                            OpenRefillMenu(i, v, j, k)
                        end,
                    },
                },
                distance = 3.5
            })
            table.insert(targets, target)
        end       
    end

    exports[Config.TargetScript]:AddCircleZone("leafnlatteboss", Config.BossActions, 1.5, {
        name = "leafnlatteboss",
        debugPoly = Config.DebugPoly,
        useZ = true
    }, {
        options = {
            {
                type = 'client',
                event = 'ak47_leafnlatte:openbossaction',
                icon = 'fa-solid fa-user-tie',
                label = _U('open_boss_target'),
                canInteract = function(entity)
                    return PlayerData and PlayerData.job and PlayerData.job.name == 'leafnlatte' and PlayerData.job.grade_name == 'boss'
                end,
            },
        },
        distance = 2.0
    })
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for i, v in pairs(targets) do
            if GetResourceState('ox_target') == 'started' then
                exports[Config.TargetScript]:RemoveZone(v)
            else
                exports[Config.TargetScript]:RemoveZone(v.name)
            end
        end
    end
end)
