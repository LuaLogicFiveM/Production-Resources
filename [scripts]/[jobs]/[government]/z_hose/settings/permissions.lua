---@docus: Please refer to our resource documentation for assistance with configuring this resource: docs.zeadevelopment.com.

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section framework
---@description: Allows for the usage of framework integration.
---@usage: 'None' | 'QBCore' | 'ESX' | 'QBX' | 'TMC'
cfg.framework = 'ESX'

---@section permissions
---@description: This table provides support for integration with a variety of frameworks.
cfg.permissions = {

    ---## Hose Actions ##--

    ['retreive&return_hose'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },

    ---## Supply Actions ##--

    ['retreive&return_supply'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },

    ---## Relay Actions ##--

    ['retreive&return_relay'] = {
        ---@section QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },

    ---## View Pump Panel ##--

    ['view_pump_panel'] = {
        ---@section QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'zeadev.fire'
        }
    },

    ---## Pickup Hose ##--

    ['pickup_hose'] = {
        ---@section QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },

    ---## LPP Actions ##--

    ['spawn&delete_lpp'] = {
        ---@section QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },

    ---## Standpipe Actions ##--
    ['spawn&delete_standpipe'] = {
        ---@section QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },

    ---## Developer Actions ##--
    ['developer_actions'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},

                permissionCheck = false,
                permissions = {'admin'}
            }
        },
        ---@section ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = {'safd'}
            }
        },
        ---@section QBX
        ['QBX'] = {
            enabled = false,
            
            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = {'fire'},
            }
        },
        ---@section Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        }
    },
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------