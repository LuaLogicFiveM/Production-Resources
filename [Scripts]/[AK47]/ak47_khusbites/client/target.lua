local targets = {}
local targetting = false

Citizen.CreateThread(function()
    for i, v in pairs(Config.StockItems) do
        local target = exports[Config.TargetScript]:AddCircleZone("FarmingMultiItemsKhusbites"..i, v.pos, v.size, {
            name = "FarmingMultiItemsKhusbites"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-cookie-bite',
                    label = _U('stock_farm_multi_target'),
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'khusbites'
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
        local target = exports[Config.TargetScript]:AddBoxZone("KhusBitesEdibles"..i, v.pos, v.boxSize.x, v.boxSize.y, {
            name = "KhusBitesEdibles"..i,
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
                        local data = lib.callback.await('ak47_khusbites:getedableinfo', nil, v.item.name)
                        if data.stock > 0 then
                            TriggerServerEvent('ak47_khusbites:tryeat', i)
                        else
                            TriggerEvent('ak47_khusbites:notify', _U('nostock'), 'error')
                        end
                    end,
                },
                {
                    icon = 'fa-solid fa-basket-shopping',
                    label = _U('buy_edible'),
                    action = function()
                        local data = lib.callback.await('ak47_khusbites:getedableinfo', nil, v.item.name)
                        if data.stock > 0 then
                            local input = lib.inputDialog(_U('buyinput', v.item.label, data.price), {
                                {type = 'number', label = _U('amount', data.stock), min = 1, max = data.stock, default = 1},
                                {type = 'select', label = _U('paymenttype'), options = {
                                    {label = "Cash", value = 'money'},
                                    {label = "Bank", value = 'bank'},
                                }, default = 'money'},
                            })
                            TriggerServerEvent('ak47_khusbites:buyedible', v.item.name, input[1], input[2])
                        else
                            TriggerEvent('ak47_khusbites:notify', _U('nostock'), 'error')
                        end
                    end,
                },
            },
            distance = 3.5
        })
        table.insert(targets, target)
    end

    for i, v in pairs(Config.Shop.sell_coords) do
        local target = exports[Config.TargetScript]:AddCircleZone("KhusBitesSell"..i, v.pos, 2.5, {
            name = "KhusBitesSell"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-cookie-bite',
                    label = _U('press_to_open_target'),
                    action = function()
                        TriggerServerEvent('ak47_khusbites:openMarket', i)
                    end,
                },
            },
            distance = 1.5
        })
        table.insert(targets, target)
    end

    local target = exports[Config.TargetScript]:AddCircleZone("KhusBitesManagement", Config.Shop.management, 1.5, {
        name = "KhusBitesManagement",
        debugPoly = Config.DebugPoly,
        useZ = true
        }, {
        options = {
            {
                type = 'server',
                event = 'ak47_khusbites:openmanagement',
                icon = 'fa-solid cash-register',
                label = _U('open_management'),
                canInteract = function(entity)
                    return PlayerData and PlayerData.job and PlayerData.job.name == 'khusbites' and PlayerData.job.grade >= Config.ManagementRank.stock
                end,
            },
        },
        distance = 2.0
    })
    table.insert(targets, target)

    for i, v in pairs(Config.ProcessLocations) do
        local target = exports[Config.TargetScript]:AddCircleZone("KhusBitesProcess"..i, vector3(v.x, v.y, v.z), 1.0, {
            name = "KhusBitesProcess"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-cookie-bite',
                    label = _U('open_process_target'),
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'khusbites'
                    end,
                    action = function()
                        TriggerServerEvent('ak47_khusbites:openMarketProcess', i)
                    end,
                },
            },
            distance = 2.0
        })
        table.insert(targets, target)
    end

    for i, v in pairs(Config.FarmingItems) do
        local target = exports[Config.TargetScript]:AddCircleZone("KhusBitesFarmingItems"..i, v.pos, 1.5, {
            name = "KhusBitesFarmingItems"..i,
            debugPoly = Config.DebugPoly,
            useZ = true
            }, {
            options = {
                {
                    icon = 'fa-solid fa-box',
                    label = v.msgtarget,
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'khusbites'
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
        local target = exports[Config.TargetScript]:AddCircleZone("khusbitesHookah"..i, v.pos, v.size, {
            name = "khusbitesHookah"..i,
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
                        TriggerServerEvent('ak47_khusbites:canstartpuff', i)
                    end,
                },
                {
                    icon = 'fa-solid fa-recycle',
                    label = _U('refill'),
                    canInteract = function(entity)
                        return PlayerData and PlayerData.job and PlayerData.job.name == 'khusbites'
                    end,
                    action = function()
                        TriggerServerEvent('ak47_khusbites:refillHookah', i)
                    end,
                },
            },
            distance = 2.5
        })
        table.insert(targets, target)
    end

    exports[Config.TargetScript]:AddCircleZone("khusbitesboss", Config.BossActions, 1.5, {
        name = "khusbitesboss",
        debugPoly = Config.DebugPoly,
        useZ = true
    }, {
        options = {
            {
                type = 'client',
                event = 'ak47_khusbites:openbossaction',
                icon = 'fa-solid fa-user-tie',
                label = _U('open_boss_target'),
                canInteract = function(entity)
                    return PlayerData and PlayerData.job and PlayerData.job.name == 'khusbites' and PlayerData.job.grade_name == 'boss'
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
