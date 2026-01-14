local config = require 'config'

if config.modules.menu.enabled then
    lib.callback.register('lualogic_trust:client:requestTargetDialogSecond', function(sourceVehicle, type)
        if type == 'owner' then
            local input = lib.inputDialog('Trade Ownership', {
                {type = 'number', label = 'Player ID', description = 'The player you want to transfer with', icon = 'hashtag'},
                {type = 'input', label = 'Vehicle Spawn Code', description = 'Spawn code of the vehicle you want to transfer', required = true, min = 1, max = 30},
                {type = 'checkbox', label = 'Do you want to transfer ownership for '..sourceVehicle..'?'},
            })

            if not input then
                return OwnedVehiclesMenu()
            end

            return input
        elseif type == 'trust' then
            local input = lib.inputDialog('Trade Trust', {
                {type = 'number', label = 'Player ID', description = 'The player you want to trade with', icon = 'hashtag'},
                {type = 'input', label = 'Vehicle Spawn Code', description = 'Spawn code of the vehicle you want to transfer', required = true, min = 1, max = 30},
                {type = 'checkbox', label = 'Do you want to transfer trust for '..sourceVehicle..'?'},
            })

            if not input then
                return TrustedVehiclesMenu()
            end

            return input
        end
    end)

    local function OwnedVehicleOptions(vehicle)
        local menu = {
            id = 'owned_vehicles_options',
            title = 'Vehicle Options',
            menu = 'owned_vehicles',
            options = {}
        }

        if config.modules.owner.spawn.enabled then
            menu.options[#menu.options+1] = {
                title = 'Spawn',
                icon = 'wand-magic-sparkles',
                iconColor = 'FF5EFF00',
                disabled = not IsModelInCdimage(vehicle),
                onSelect = function()
                    SpawnVehicle(vehicle, GetEntityCoords(cache.ped), GetEntityHeading(cache.ped), true)
                end
            }
        end

        if config.modules.owner.trade.enabled then
            menu.options[#menu.options + 1] = {
                title = 'Trade',
                icon = 'right-left',
                iconColor = '#00ffae',
                disabled = not GlobalState.owner_trade,
                onSelect = function()
                    local input = lib.inputDialog('Ownership Trade', {
                        {type = 'number', label = 'Player ID', description = 'The ID of the player you want to trade ownership with', icon = 'hashtag'}
                    })

                    if not input then
                        return OwnedVehiclesMenu()
                    end

                    if input[1] == cache.serverId then
                        return OwnedVehiclesMenu(), Notify('You are unable to trade with yourself', 'error')
                    end

                    TriggerServerEvent('lualogic_trust:server:requestDialog', input[1], vehicle, 'owner')
                end
            }
        end

        if config.modules.owner.transfer.enabled then
            menu.options[#menu.options+1] = {
                title = 'Transfer',
                icon = 'hand-holding-hand',
                iconColor = '#7c00ad',
                disabled = not GlobalState.owner_transfer,
                onSelect = function()
                    local input = lib.inputDialog('Transfer Ownership', {
                        {type = 'number', label = 'Player ID', description = 'The game id of the player you want to transfer ownership to', icon = 'hashtag'},
                    })

                    if not input then
                        return lib.showContext('owned_vehicles_options')
                    end

                    if input[1] == cache.serverId then
                        return OwnedVehiclesMenu(), Notify('You are unable to transfer to yourself', 'error')
                    end

                    ExecuteCommand(config.modules.owner.transfer.command..' '..input[1]..' '..vehicle)
                end
            }
        end

        if config.modules.trust.give.enabled then
            menu.options[#menu.options+1] = {
                title = 'Give',
                icon = 'hand-holding-dollar',
                iconColor = '#ffe100',
                disabled = not GlobalState.trust_give,
                onSelect = function()
                    local input = lib.inputDialog('Give Trust', {
                        {type = 'number', label = 'Player ID', description = 'The game id of the player you want to give trust to', icon = 'hashtag'},
                    })

                    if not input then
                        return lib.showContext('owned_vehicles_options')
                    end

                    ExecuteCommand(config.modules.trust.give.command..' '..input[1]..' '..vehicle)
                end
            }
        end

        if config.modules.owner.remove.enabled then
            menu.options[#menu.options+1] = {
                title = 'Remove',
                icon = 'ban',
                iconColor = 'red',
                disabled = not GlobalState.owner_remove,
                args = {
                    vehicle = vehicle,
                },
                onSelect = function(data)
                    local alert = lib.alertDialog({
                        header = 'Trust System',
                        content = 'Are you sure you want to remove '..data.vehicle..' from your owned personals?',
                        centered = true,
                        cancel = true
                    })

                    if alert == 'confirm' then
                        ExecuteCommand(config.modules.owner.remove.command..' '..data.vehicle)
                    end

                    OwnedVehiclesMenu()
                end
            }
        end

        lib.registerContext(menu)
        lib.showContext(menu.id)
    end

    function OwnedVehiclesMenu() -- don't config out
        local data, limit = lib.callback.await('lualogic_trust:server:requestOwned', false)
        local menu = {
            id = 'owned_vehicles',
            title = 'Owned Vehicles ('..#data..'/'..limit..')',
            menu = 'trust_system_menu',
            options = {},
        }

        if not data then
            menu.options[#menu.options + 1] = {
                title = 'No Owned Vehicles',
                icon = 'xmark',
                iconColor = 'red',
                readOnly = true,
            }
            lib.registerContext(menu)
            lib.showContext('owned_vehicles')
            return
        end

        for _, vehicle in ipairs(data) do
            menu.options[#menu.options + 1] = {
                title = vehicle,
                arrow = true,
                icon = 'car',
                iconColor = 'green',
                onSelect = function()
                    OwnedVehicleOptions(vehicle)
                end
            }
        end

        lib.registerContext(menu)
        lib.showContext('owned_vehicles')
    end

    CreateThread(function()
        local menu = {
            id = 'trust_system_menu',
            title = 'Vehicle System',
            options = {}
        }

        if config.modules.owner.enabled then
            menu.options[#menu.options+1] = {
                title = 'Owned Vehicles',
                icon = 'warehouse',
                iconColor = 'green',
                arrow = true,
                onSelect = function()
                    OwnedVehiclesMenu()
                end
            }
        end

        if config.modules.trust.enabled then
            menu.options[#menu.options+1] = {
                title = 'Trusted Vehicles',
                icon = 'key',
                iconColor = 'gold',
                arrow = true,
                onSelect = function()
                    TrustedVehiclesMenu()
                end
            }
        end

        if config.modules.system.enabled then
            menu.options[#menu.options+1] = {
                title = 'System Options',
                icon = 'gear',
                iconColor = 'lightblue',
                menu = 'vehicle_options',
                arrow = true
            }
        end

        lib.registerContext(menu)
    end)

    local function OpenVehiclesMenu()
        lib.showContext('trust_system_menu')
    end exports('OpenVehiclesMenu', OpenVehiclesMenu)

    RegisterCommand(config.modules.menu.command, function()
        OpenVehiclesMenu()
    end, false)
end

--#! Admin Menu

if config.modules.system.admin.enabled then
    CreateThread(function()
        local menu = {
            id = 'trust_admin_menu_actions',
            title = 'Global Actions',
            menu = 'trust_admin_menu',
            options = {}
        }

        if config.modules.owner.enabled then
            local function AdminMenuStatesOwner()
                local menu_owner = {
                    id = 'trust_admin_menu_actions_owner',
                    title = 'Owner Actions',
                    menu = 'trust_admin_menu_actions',
                    options = {}
                }

                if config.modules.system.states.permission and not lib.callback.await('lualogic_trust:server:requestPermission', false, config.modules.system.states.permission) then
                    menu_owner.options[#menu_owner.options + 1] = {
                        title = 'Menu Disabled',
                        description = 'You do not have access to this menu.',
                        icon = 'eye-slash',
                        iconColor = 'red',
                        iconAnimatino = 'beat',
                        readOnly = true
                    }
                    lib.registerContext(menu_owner)
                    lib.showContext(menu_owner.id)
                    return
                end

                if config.modules.owner.set.enabled then
                    local icon, color = GetStatus('owner_set')
                    menu_owner.options[#menu_owner.options+1] = {
                        title = 'Owner Set',
                        icon = icon,
                        iconColor = color,
                        args = {
                            state = not GlobalState.owner_set,
                        },
                        onSelect = function(data)
                            local args = {action = 'owner_set', status = data.state}
                            TriggerServerEvent('lualogic_trust:server:requestAction', args)
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.owner.trade.enabled then
                    local icon, color = GetStatus('owner_trade')
                    menu_owner.options[#menu_owner.options+1] = {
                        title = 'Owner Trade',
                        icon = icon,
                        iconColor = color,
                        args = {
                            state = not GlobalState.owner_trade,
                        },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'owner_trade', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.owner.remove.enabled then
                    local icon, color = GetStatus('owner_remove')
                    menu_owner.options[#menu_owner.options+1] = {
                        title = 'Owner Remove',
                        icon = icon,
                        iconColor = color,
                        args = {
                            state = not GlobalState.owner_remove,
                        },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'owner_remove', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.owner.clear.enabled then
                    local icon, color = GetStatus('owner_clear')
                    menu_owner.options[#menu_owner.options+1] = {
                        title = 'Owner Clear',
                        icon = icon,
                        iconColor = color,
                        args = {
                            state = not GlobalState.owner_clear,
                        },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'owner_clear', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                lib.registerContext(menu_owner)
                lib.showContext(menu_owner.id)
            end

            menu.options[#menu.options+1] = {
                title = 'Ownership States',
                icon = 'toggle-on',
                iconColor = 'green',
                arrow = true,
                onSelect = function()
                    AdminMenuStatesOwner()
                end
            }
        end

        if config.modules.trust.enabled then
            local function AdminMenuStatesTrust()
                local menu_trust = {
                    id = 'trust_admin_menu_actions_trust',
                    title = 'Trust Actions',
                    menu = 'trust_admin_menu_actions',
                    options = {}
                }

                if config.modules.system.states.permission and not lib.callback.await('lualogic_trust:server:requestPermission', false, config.modules.system.states.permission) then
                    menu_trust.options[#menu_trust.options + 1] = {
                        title = 'Menu Disabled',
                        description = 'You do not have access to this menu.',
                        icon = 'eye-slash',
                        iconColor = 'red',
                        iconAnimatino = 'beat',
                        readOnly = true
                    }
                    lib.registerContext(menu_trust)
                    lib.showContext(menu_trust.id)
                    return
                end

                if config.modules.trust.give.enabled then
                    local icon, color = GetStatus('trust_give')
                    menu_trust.options[#menu_trust.options+1] = {
                        title = 'Trust Give',
                        icon = icon,
                        iconColor = color,
                        args = { state = not GlobalState.trust_give },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'trust_give', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.trust.trade.enabled then
                    local icon, color = GetStatus('trust_trade')
                    menu_trust.options[#menu_trust.options+1] = {
                        title = 'Trust Trade',
                        icon = icon,
                        iconColor = color,
                        args = { state = not GlobalState.trust_trade },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'trust_trade', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.trust.remove.enabled then
                    local icon, color = GetStatus('trust_remove')
                    menu_trust.options[#menu_trust.options+1] = {
                        title = 'Trust Remove',
                        icon = icon,
                        iconColor = color,
                        args = { state = not GlobalState.trust_remove },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'trust_remove', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.trust.clear.enabled then
                    local icon, color = GetStatus('trust_clear')
                    menu_trust.options[#menu_trust.options+1] = {
                        title = 'Trust Clear',
                        icon = icon,
                        iconColor = color,
                        args = { state = not GlobalState.trust_clear },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'trust_clear', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                lib.registerContext(menu_trust)
                lib.showContext(menu_trust.id)
            end

            menu.options[#menu.options+1] = {
                title = 'Trust States',
                icon = 'toggle-on',
                iconColor = 'gold',
                arrow = true,
                onSelect = function()
                    AdminMenuStatesTrust()
                end
            }
        end

        if config.modules.system.search.enabled then
            local function AdminMenuStatesSearch()
                local menu_search = {
                    id = 'trust_admin_menu_actions_search',
                    title = 'Search Actions',
                    menu = 'trust_admin_menu_actions',
                    options = {}
                }

                if config.modules.system.states.permission and not lib.callback.await('lualogic_trust:server:requestPermission', false, config.modules.system.states.permission) then
                    menu_search.options[#menu_search.options + 1] = {
                        title = 'Menu Disabled',
                        description = 'You do not have access to this menu.',
                        icon = 'eye-slash',
                        iconColor = 'red',
                        iconAnimatino = 'beat',
                        readOnly = true
                    }
                    lib.registerContext(menu_search)
                    lib.showContext(menu_search.id)
                    return
                end

                if config.modules.system.search.name.enabled then
                    local search_name_icon, search_name_color = GetStatus('search_name')
                    menu_search.options[#menu_search.options+1] = {
                        title = 'Name Search',
                        icon = search_name_icon,
                        iconColor = search_name_color,
                        args = { state = not GlobalState.search_name },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'search_name', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.system.search.vehicle.enabled then
                    local search_vehicle_icon, search_vehicle_color = GetStatus('search_vehicle')
                    menu_search.options[#menu_search.options+1] = {
                        title = 'Vehicle Search',
                        icon = search_vehicle_icon,
                        iconColor = search_vehicle_color,
                        args = { state = not GlobalState.search_vehicle },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'search_vehicle', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                if config.modules.system.search.identifier.enabled then
                    local search_identifier_icon, search_identifier_color = GetStatus('search_identifier')
                    menu_search.options[#menu_search.options+1] = {
                        title = 'Identifier Search',
                        icon = search_identifier_icon,
                        iconColor = search_identifier_color,
                        args = { state = not GlobalState.search_identifier },
                        onSelect = function(data)
                            TriggerServerEvent('lualogic_trust:server:requestAction', {action = 'search_identifier', status = data.state})
                            Wait(100)
                            lib.showContext('trust_admin_menu_actions')
                        end
                    }
                end

                lib.registerContext(menu_search)
                lib.showContext(menu_search.id)
            end

            menu.options[#menu.options+1] = {
                title = 'Search States',
                icon = 'toggle-on',
                iconColor = 'lightblue',
                arrow = true,
                onSelect = function()
                    AdminMenuStatesSearch()
                end
            }
        end

        lib.registerContext(menu)
    end)

    CreateThread(function()
        local menu_owner = {
            id = 'trust_admin_menu_options_owner',
            title = 'Ownership Actions',
            menu = 'trust_admin_menu_admin_options',
            options = { }
        }

        if config.modules.owner.set.enabled then
            local function SetOwnership()
                local input = lib.inputDialog('Set Ownership', {
                    {type = 'number', label = 'Player ID', description = 'The id of the player you want to set ownership to', required = true, icon = 'hashtag'},
                    {type = 'input', label = 'Spawn Code', description = 'The vehicle spawn code you want to set ownership to', required = true},
                    {type = 'checkbox', label = 'I understand this action is used for admin use only and not for personal gain.', required = true}
                })

                if not input then
                    return lib.showContext('trust_admin_menu_options_owner')
                end

                local target = input[1]
                local vehicle = input[2]

                ExecuteCommand(config.modules.owner.set.command ..' '..target..' '..vehicle)
                lib.showContext('trust_admin_menu_options_owner')
            end

            local icon, color = GetStatus('owner_set')
            menu_owner.options[#menu_owner.options + 1] = {
                title = 'Set Ownership',
                icon = icon,
                iconColor = color,
                disabled = not GlobalState.owner_set,
                onSelect = function()
                    SetOwnership()
                end
            }
        end

        if config.modules.owner.clear.enabled then
            local function ClearOwnership()
                local input = lib.inputDialog('Clear Ownership', {
                    {type = 'input', label = 'Spawn Code', description = 'The vehicle spawn code you want to clear ownership of', required = true},
                    {type = 'checkbox', label = 'I understand this action is used for admin use only and not for personal gain.', required = true}
                })

                if not input then
                    return lib.showContext('trust_admin_menu_options_owner')
                end

                local vehicle = input[1]

                ExecuteCommand(config.modules.owner.clear.command ..' '..vehicle)
                lib.showContext('trust_admin_menu_options_owner')
            end

            local icon, color = GetStatus('owner_clear')
            menu_owner.options[#menu_owner.options + 1] = {
                title = 'Clear Ownership',
                icon = icon,
                iconColor = color,
                disabled = not GlobalState.owner_clear,
                onSelect = function()
                    ClearOwnership()
                end
            }
        end

        if config.modules.owner.remove.enabled then
            local function RemoveOwnership()
                local input = lib.inputDialog('Remove Ownership', {
                    {type = 'number', label = 'Player ID', description = 'The id of the player you want to remove ownership from', required = true, icon = 'hashtag'},
                    {type = 'input', label = 'Spawn Code', description = 'The vehicle spawn code you want to remove ownership of', required = true},
                    {type = 'checkbox', label = 'I understand this action is used for admin use only and not for personal gain.', required = true}
                })

                if not input then
                    return lib.showContext('trust_admin_menu_options_owner')
                end

                local target = input[1]
                local vehicle = input[2]

                ExecuteCommand(config.modules.owner.remove.admin.command ..' '..target..' '..vehicle)
                lib.showContext('trust_admin_menu_options_owner')
            end

            local icon, color = GetStatus('owner_remove')
            menu_owner.options[#menu_owner.options + 1] = {
                title = 'Remove Ownership',
                icon = icon,
                iconColor = color,
                disabled = not GlobalState.owner_remove,
                onSelect = function()
                    RemoveOwnership()
                end
            }
        end

        lib.registerContext(menu_owner)

        local menu_trust = {
            id = 'trust_admin_menu_options_trust',
            title = 'Trust Actions',
            menu = 'trust_admin_menu_admin_options',
            options = { }
        }

        if config.modules.trust.set.enabled then
            local function SetTrust()
                local input = lib.inputDialog('Set Trust', {
                    {type = 'number', label = 'Player ID', description = 'The id of the player you want to set trust to', required = true, icon = 'hashtag'},
                    {type = 'input', label = 'Spawn Code', description = 'The vehicle spawn code you want to set trust to', required = true},
                    {type = 'checkbox', label = 'I understand this action is used for admin use only and not for personal gain.', required = true}
                })

                if not input then
                    return lib.showContext('trust_admin_menu_options_trust')
                end

                local target = input[1]
                local vehicle = input[2]

                ExecuteCommand(config.modules.trust.set.command ..' '..target..' '..vehicle)
                lib.showContext('trust_admin_menu_options_trust')
            end

            local icon, color = GetStatus('trust_set')
            menu_trust.options[#menu_trust.options + 1] = {
                title = 'Set Trust',
                icon = icon,
                iconColor = color,
                disabled = not GlobalState.trust_set,
                onSelect = function()
                    SetTrust()
                end
            }
        end

        if config.modules.trust.clear.enabled then
            local function ClearTrust()
                local input = lib.inputDialog('Clear Trust', {
                    {type = 'input', label = 'Spawn Code', description = 'The vehicle spawn code you want to clear trust of', required = true},
                    {type = 'checkbox', label = 'I understand this action is used for admin use only and not for personal gain.', required = true}
                })

                if not input then
                    return lib.showContext('trust_admin_menu_options_trust')
                end

                local vehicle = input[1]

                ExecuteCommand(config.modules.trust.clear.command ..' '..vehicle)
                lib.showContext('trust_admin_menu_options_trust')
            end

            local icon, color = GetStatus('trust_clear')
            menu_trust.options[#menu_trust.options + 1] = {
                title = 'Clear Trust',
                icon = icon,
                iconColor = color,
                disabled = not GlobalState.trust_clear,
                onSelect = function()
                    ClearTrust()
                end
            }
        end

        if config.modules.trust.remove.enabled then
            local function RemoveTrust()
                local input = lib.inputDialog('Remove Trust', {
                    {type = 'number', label = 'Player ID', description = 'The id of the player you want to remove trust from', required = true, icon = 'hashtag'},
                    {type = 'input', label = 'Spawn Code', description = 'The vehicle spawn code you want to remove trust of', required = true},
                    {type = 'checkbox', label = 'I understand this action is used for admin use only and not for personal gain.', required = true}
                })

                if not input then
                    return lib.showContext('trust_admin_menu_options_trust')
                end

                local target = input[1]
                local vehicle = input[2]

                ExecuteCommand(config.modules.trust.remove.admin.command ..' '..target..' '..vehicle)
                lib.showContext('trust_admin_menu_options_trust')
            end

            local icon, color = GetStatus('trust_remove')
            menu_trust.options[#menu_trust.options + 1] = {
                title = 'Remove Trust',
                icon = icon,
                iconColor = color,
                disabled = not GlobalState.trust_remove,
                onSelect = function()
                    RemoveTrust()
                end
            }
        end

        lib.registerContext(menu_trust)

        local menu = {
            id = 'trust_admin_menu_admin_options',
            title = 'Admin Options',
            menu = 'trust_admin_menu',
            options = {
                {
                    title = 'Ownership Actions',
                    icon = 'warehouse',
                    iconColor = 'green',
                    menu = 'trust_admin_menu_options_owner'
                },
                {
                    title = 'Trust Actions',
                    icon = 'key',
                    iconColor = 'gold',
                    menu = 'trust_admin_menu_options_trust'
                }
            }
        }

        lib.registerContext(menu)
    end)

    function AdminMenu()
        local menu = {
            id = 'trust_admin_menu',
            title = 'Vehicle System Admin',
            menu = 'vehicle_options',
            options = {}
        }

        if config.modules.system.admin.menu.permission and not lib.callback.await('lualogic_trust:server:requestPermission', false, config.modules.system.admin.menu.permission) then
            menu.options[#menu.options + 1] = {
                title = 'Menu Disabled',
                description = 'You do not have access to this menu.',
                icon = 'eye-slash',
                iconColor = 'red',
                iconAnimatino = 'beat',
                readOnly = true
            }
            lib.registerContext(menu)
            lib.showContext(menu.id)
            return
        end

        if config.modules.system.enabled then
            menu.options[#menu.options + 1] = {
                title = 'Global States',
                icon = 'gears',
                iconColor = 'pink',
                arrow = true,
                onSelect = function()
                    lib.showContext('trust_admin_menu_actions')
                end
            }
        end

        if config.modules.system.admin.enabled then
            menu.options[#menu.options + 1] = {
                title = 'Admin Actions',
                icon = 'user-tie',
                iconColor = 'pink',
                arrow = true,
                onSelect = function()
                    lib.showContext('trust_admin_menu_admin_options')
                end
            }
        end

        lib.registerContext(menu)
        lib.showContext(menu.id)
    end
end

--!# Trust Options

if config.modules.trust.give.enabled then
    local function TrustedVehicleOptions(vehicle)
        local menu = {
            id = 'trusted_vehicles_options',
            title = 'Vehicle System',
            menu = 'trusted_vehicles',
            options = {}
        }

        if config.modules.trust.spawn.enabled then
            menu.options[#menu.options+1] = {
                title = 'Spawn',
                icon = 'wand-magic-sparkles',
                iconColor = 'FF5EFF00',
                disabled = not IsModelInCdimage(vehicle),
                onSelect = function()
                    SpawnVehicle(vehicle, GetEntityCoords(cache.ped), GetEntityHeading(cache.ped), true)
                end
            }
        end

        if config.modules.trust.trade.enabled then
            menu.options[#menu.options + 1] = {
                title = 'Trade',
                icon = 'right-left',
                iconColor = '#00ffae',
                disabled = not GlobalState.trust_trade,
                onSelect = function()
                    local input = lib.inputDialog('Trust Trade', {
                        {type = 'number', label = 'Player ID', description = 'The ID of the player you want to trade trust with', icon = 'hashtag'}
                    })

                    if not input then
                        return TrustedVehiclesMenu()
                    end

                    if input[1] == cache.serverId then
                        return TrustedVehiclesMenu(), Notify('You are unable to trade with yourself', 'error')
                    end

                    TriggerServerEvent('lualogic_trust:server:requestDialog', input[1], vehicle, 'trust')
                end
            }
        end

        if config.modules.trust.remove.enabled then
            menu.options[#menu.options+1] = {
                title = 'Remove',
                icon = 'ban',
                iconColor = 'red',
                disabled = not GlobalState.trust_remove,
                onSelect = function()
                    local alert = lib.alertDialog({
                        header = 'Trust System',
                        content = 'Are you sure you want to remove '..vehicle..' from your trusted vehicles?',
                        centered = true,
                        cancel = true
                    })

                    if alert == 'confirm' then
                        ExecuteCommand(config.modules.trust.remove.command..' '..vehicle)
                    end

                    TrustedVehiclesMenu()
                end
            }
        end

        lib.registerContext(menu)
        lib.showContext(menu.id)
    end

    function TrustedVehiclesMenu()
        local data = lib.callback.await('lualogic_trust:server:requestTrusted', false)
        local menu = {
            id = 'trusted_vehicles',
            title = 'Trusted Vehicles',
            menu = 'trust_system_menu',
            options = {},
        }

        if not data then
            menu.options[#menu.options + 1] = {
                title = 'No Trusted Vehicles',
                icon = 'xmark',
                iconColor = 'red',
                readOnly = true
            }
            lib.registerContext(menu)
            lib.showContext('trusted_vehicles')
            return
        end

        for _, vehicle in ipairs(data) do
            menu.options[#menu.options + 1] = {
                title = vehicle,
                arrow = true,
                icon = 'car',
                iconColor = 'gold',
                args = { vehicle = vehicle },
                onSelect = function(args)
                    TrustedVehicleOptions(args.vehicle)
                end
            }
        end

        lib.registerContext(menu)
        lib.showContext(menu.id)
    end
end

if config.modules.system.enabled then
    CreateThread(function()
        local menu = {
            id = 'vehicle_options',
            title = 'System Options',
            menu = 'trust_system_menu',
            options = {}
        }

        if config.modules.system.missing.enabled then
            local function CopyMissingVehicles()
                local player_vehicles = lib.callback.await('lualogic_trust:server:requestOwned', false)
                local missing = {}

                for _, vehicle in pairs(player_vehicles) do
                    if not IsModelInCdimage(vehicle) then
                        missing[#missing+1] = vehicle
                    end
                end

                lib.setClipboard(tostring(json.encode(missing)))
                Notify('You have copied your missing spawn codes, make a vehicle related ticket and send them in your ticket to get them added back.', 'success')
            end

            menu.options[#menu.options+1] = {
                title = 'Copy Missing Vehicles',
                description = 'This will copy the missing vehicles that you own.',
                icon = 'car',
                iconColor = 'teal',
                onSelect = function()
                    CopyMissingVehicles()
                end
            }
        end

        if config.modules.system.search.enabled then
            menu.options[#menu.options+1] = {
                title = 'Search Engine',
                description = 'Search options to view ownership, trust, & player profiles.',
                icon = 'magnifying-glass',
                iconColor = 'lightblue',
                arrow = true,
                onSelect = function()
                    VehicleSearchOptions()
                end
            }
        end

        if config.modules.system.admin.enabled then
            menu.options[#menu.options+1] = {
                title = 'Admin Options',
                description = 'Admin action to manage the states of the trust system modules.',
                icon = 'shield-halved',
                iconColor = 'pink',
                disabled = not GlobalState.admin_menu,
                arrow = true,
                onSelect = function()
                    AdminMenu()
                end
            }
        end

        lib.registerContext(menu)
    end)

    if config.modules.system.search.enabled then
        local function FindProfile(type, data)
            if type == 'name' then
                ExecuteCommand(config.modules.system.search.name.command..' '..data)
            elseif type == 'vehicle' then
                ExecuteCommand(config.modules.system.search.vehicle.command..' '..data)
            elseif type == 'identifier' then
                ExecuteCommand(config.modules.system.search.identifier.command..' '..data)
            end
        end

        function VehicleSearchOptions()
            local menu = {
                id = 'vehicle_options_search',
                title = 'Search Options',
                menu = 'vehicle_options',
                options = {}
            }

            if config.modules.system.search.name.enabled then
                menu.options[#menu.options+1] = {
                    title = 'Search Player',
                    description = 'Searches database for player name to view their vehicles',
                    icon = 'person',
                    iconColor = 'lightblue',
                    disabled = not GlobalState.search_name,
                    onSelect = function()
                        local input = lib.inputDialog('Database Search', { {type = 'input', label = 'Player Name', description = 'The player name you wish to search for.', required = true, icon = 'hashtag'} })
                        if not input then lib.showContext('vehicle_options_search') return end
                        FindProfile('name', input[1])
                    end
                }
            end

            if config.modules.system.search.vehicle.enabled then
                menu.options[#menu.options+1] = {
                    title = 'Search Vehicle',
                    description = 'Searches database for vehicle model to view the ownership & trust',
                    icon = 'car-side',
                    iconColor = 'lightblue',
                    disabled = not GlobalState.search_vehicle,
                    onSelect = function()
                        local input = lib.inputDialog('Database Search', { {type = 'input', label = 'Vehicle Model', description = 'The spawn code of the vehicle you wish to search for.', required = true, icon = 'hashtag'} })
                        if not input then lib.showContext('vehicle_options_search') return end
                        FindProfile('vehicle', input[1])
                    end
                }
            end

            if config.modules.system.search.identifier.enabled then
                menu.options[#menu.options+1] = {
                    title = 'Search Identifier',
                    description = 'Searches database for an identifier to view a players vehicles',
                    icon = 'id-badge',
                    iconColor = 'lightblue',
                    disabled = not GlobalState.search_identifier,
                    onSelect = function()
                        local input = lib.inputDialog('Database Search', { {type = 'input', label = 'Player ID', description = 'The identifier or id of the player you want to view.', required = true, icon = 'hashtag'} })
                        if not input then lib.showContext('vehicle_options_search') return end
                        FindProfile('identifier', input[1])
                    end
                }
            end

            lib.registerContext(menu)
            lib.showContext(menu.id)
        end

        RegisterNetEvent('lualogic_trust:client:returnSearch', function(type, result)
            if type == 'vehicle' then
                local menu = {
                    id = 'vehicle_options_search_vehicle',
                    title = 'Vehicle Search Result',
                    menu = 'vehicle_options_search',
                    options = {}
                }

                if GetTableSize(result) == 0 then
                    menu.options[#menu.options + 1] = {
                        title = 'Search Result Failed',
                        description = 'There was no search found',
                        icon = 'xmark',
                        iconColor = 'red',
                        readOnly = true
                    }
                    lib.registerContext(menu)
                    lib.showContext(menu.id)
                    return
                end

                for identifier, data in pairs(result) do
                    menu.options[#menu.options + 1] = {
                        title = data.name,
                        description = 'Click to copy identifier',
                        icon = 'car',
                        iconColor = data.owner and 'green' or 'gold',
                        args = { identifier = identifier },
                        onSelect = function(args)
                            lib.setClipboard(tostring(args.identifier))
                            lib.showContext('vehicle_options_search_vehicle')
                            Notify('You copied the players identifier', 'success')
                        end
                    }
                end

                lib.registerContext(menu)
                lib.showContext(menu.id)
            elseif type == 'name' then
                local menu = {
                    id = 'vehicle_options_search_player',
                    title = 'Player Search Result',
                    menu = 'vehicle_options_search',
                    options = {}
                }

                if not result then
                    menu.options[#menu.options + 1] = {
                        title = 'Search Result Failed',
                        description = 'There was no search found',
                        icon = 'xmark',
                        iconColor = 'red',
                        readOnly = true
                    }
                    lib.registerContext(menu)
                    lib.showContext(menu.id)
                    return
                end

                for _, data in pairs(result) do
                    menu.options[#menu.options + 1] = {
                        title = data.vehicle,
                        description = 'Click to copy spawn code',
                        icon = 'car',
                        iconColor = data.owner and 'green' or 'gold',
                        args = {vehicle = data.vehicle},
                        onSelect = function(args)
                            lib.setClipboard(tostring(args.vehicle))
                            lib.showContext('vehicle_options_search_player')
                            Notify('You copied the spawn code', 'success')
                        end
                    }
                end

                lib.registerContext(menu)
                lib.showContext(menu.id)
            elseif type == 'identifier' then
                local data = result.data
                local menu = {
                    id = 'vehicle_options_search_identifier',
                    title = 'Identifier Search Result',
                    menu = 'vehicle_options_search',
                    options = {}
                }

                if GetTableSize(data) == 0 then
                    menu.options[#menu.options + 1] = {
                        title = 'Search Result Failed',
                        description = 'There was no search found',
                        icon = 'xmark',
                        iconColor = 'red',
                        readOnly = true
                    }
                    lib.registerContext(menu)
                    lib.showContext(menu.id)
                    return
                end

                for _, profile in pairs(data) do
                    menu.options[#menu.options + 1] = {
                        title = profile.vehicle,
                        description = 'Click to copy spawn code',
                        icon = 'car',
                        iconColor = profile.owner and 'green' or 'gold',
                        args = {vehicle = profile.vehicle},
                        onSelect = function(args)
                            lib.setClipboard(tostring(args.vehicle))
                            lib.showContext('vehicle_options_search_identifier')
                            Notify('You copied the spawn code', 'success')
                        end
                    }
                end

                lib.registerContext(menu)
                lib.showContext(menu.id)
            end
        end)
    end
end