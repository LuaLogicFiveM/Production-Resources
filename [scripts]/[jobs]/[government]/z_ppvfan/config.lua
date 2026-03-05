--@param: Please refer to our resource documentation for assistance with configuring this resource: docs.zeadevelopment.com.

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@class cfg : Configuration
cfg = cfg or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field commands table
---@comment: This table facilitates the customization of commands utilized by the resource.
cfg.commands = {
    --@comment: % Spawn Fan %
    ['spawnFan'] = {
        command = 'spawnFan',
        description = 'Spawn a PPV Fan.',
        cooldown = 3000 --@comment: In Miliseconds
    },
    --@comment: % Delete Fan %
    ['deleteFan'] = {
        command = 'deleteFan',
        description = 'Delete a PPV Fan.',
        cooldown = 3000 --@comment: In Miliseconds
    },
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field integrations table
---@comment: Facilitated the integration of additional resources to enhance functionality with z_ppvfan.
cfg.integrations = {
    ['z_fire'] = {true, resourceName = 'z_fire'},
} 

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field models table
---@comment: This table facilitates the customization of models utilized by the resource.
cfg.models = {
    ['ppv_fan'] = `zea_ppvfan`
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field particles table
---@comment: Facilitates the use of particles on the entity.
---@comment: https://vespura.com/fivem/particle-list/
cfg.particles = {
    allow = true,
    data = {
        dict = 'core',
        name = 'ent_amb_steam_vent_round',
        scale = 1.2
    }
} 

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field indicators table
---@comment: Enables interaction indicators on the entity.
cfg.indicators = {
    ['indicator'] = {
        allow = true,
        img = 'indicator.png'
    }
} 

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field keybinds table
---@comment: Allow for the customization of keybinds utilized by the resource.
---@comment: https://docs.fivem.net/docs/game-references/controls/
cfg.keybinds = {
    toggle_power = 'E',
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field usePermissions table
---@description: __________________________
cfg.usePermissions = {
    ---@type: QBCore
    ['QBCore'] = {
        enabled = false,
        item = {
            use = false,
            name = 'PPV Fan'
        },

        usePermissions = {
            jobCheck = false,
            jobs = {'fire'},

            permissionCheck = false,
            permissions = {'admin'}
        }
    },
    ---@type: ESX
    ['ESX'] = {
        enabled = true,
        item = {
            use = true,
            name = 'PPV Fan'
        },

        usePermissions = {
            jobCheck = true,
            jobs = {'safd'}
        }
    },
    ---@type: QBX
    ['QBX'] = {
        enabled = false,
        
        usePermissions = {
            jobCheck = false,
            jobs = {'fire'},
        }
    },
    ---@type: TMC
    ['TMC'] = {
        enabled = false,

        usePermissions = {
            jobCheck = false,
            jobs = {'fire'},
        }
    },
    ---@type: Ace Permisions
    ['Ace'] = {
        enabled = false,
        usePermission = 'fire'
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@field languages table
---@comment: Allow for different languages to be utilized for displayed text.
cfg.languages = {
    ['en'] = {
        -- % Success Messages % -- 
        placed = 'Fan has been placed.',
        picked_up = 'Fan has been picked up.',
        powered_on = 'Fan has been powered on.',
        powered_off = 'Fan has been powered off.',
        -- % Error Messages % -- 
        not_found = 'No fan has been found.',
        already_placed = 'You already have a fan placed.',
        none_suitable = 'Player is not in a suitable state to use the object.',
        lack_permission = 'You lack the permission for this action.',
        -- % Error Types % -- 
        error = 'Errror!',
        success = 'Success!'
    }
}