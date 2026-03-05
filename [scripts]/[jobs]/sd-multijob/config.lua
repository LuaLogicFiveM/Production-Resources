Config = {}

Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

Config.Debug = true -- true/false the debug for polyzones (in regards to the duty zones)

-- How long (in seconds) bonus and message notifications persist before expiring.
Config.NotificationDuration = 259200 -- 72h (in seconds)

-- You can disable the multijob system and only have a boss menu if you wish. It's heavily recommended to keep this as true.
-- If false, messages and bonuses will be disabled.
Config.Multijob = {
    enable = true, -- true/false
    jobsLimit = { enable = true, amount = 5, notify = true } -- if enabled, limits the amount of jobs that player can have in their multijob. If disabled, infinite. notify true = send player notification if they get a new job but they've already reached max.
}

-- Enable or disable the messages menu (if false, you can't send messages to bosses and bosses can't send messages to you)
Config.EnableMessages = {
    enable = true, -- true/false the messaing system as a whole
    enableMessagesToBoss = true, -- true/false the ability for employees to send the bosses messages.
    enableMessagesToEmployees = true, -- true/false the ability for bosses to send messages to employees.
}

-- Enable or disable the bonus system (bosses can give in-game currency bonuses to employees)
Config.EnableBonuses = true -- true/false the ability for bosses to send bonuses to employees

-- Auto-assign job on hire; if false, only saves to savedJobs (so the player will have the job they were hired for available in their multijob menu)
-- if true, saves to savedJobs as well as sets the current job of the player directly (e.g. when they do /job they'll be that job immediately)
Config.SetJobOnHire = true -- true/false 

-- Setup a command and optionally a keybind to open the multijob menu. If Config.EnableMultijob is false, then you can ignore this.
Config.Command = {
    -- the chat command to open your jobs menu
    name       = 'jobs',  

    -- whether to also register a key-mapping for it
    keybind    = {
        enabled = true,      -- set false to disable keybind entirely
        key     = 'F5'       -- any valid FiveM key string: 'F2', 'F5', 'INSERT', etc.
    }
}

-- Icons for the target options to toggle duty and open the boss menu.
Config.TargetIcons = {
    duty = 'fa-solid fa-briefcase',
    boss = 'fa-solid fa-users-gear'
}

Config.UseSociety = {
    -- Use built-in society accounting (via this resource’s exports and the boss-menu UI). Doesn't link to anything external, all handled in-resource.
    -- When useCustomLogic = true, bypass built-in handling in favor of your own logic (e.g., Renewed-Banking, fd_banking etc.).
    -- Note: To have external transactions appear in the boss menu’s transaction log, implement the transactionLog export to other resources (see docs).

    -- If you don't want the society to be handled AT ALL through my resource, then simply setting enable to false will suffice.
    -- Do note, that disabling society entirely will result in stuff such as the bonuses and weekly goal bonuses not working.
    enable = true,  -- when true: shows society accounting in boss menu; when false: disables it entirely
    useCustomLogic = false, -- when true: calls your custom deposit/withdraw/getBalance below; when false: uses internal methods

    -- === CUSTOM BALANCE FUNCTIONS BELOW ===
    -- if useCustomLogic is true, you can implement your own deposit/withdraw/getBalance functions here.

    --- Deposit into a society account using Renewed-Banking.
    --- @param source     number  The boss’s server ID performing the deposit.
    --- @param jobName    string  The society/job key (e.g. "police").
    --- @param amount     number  Amount to deposit (must be > 0).
    --- @param moneyType  string  "cash" or "bank".  (not used here, since Renewed-Banking tracks bank accounts)
    --- @return number|false      New balance on success, or false on error.
    deposit = function(source, jobName, amount, moneyType)
        -- Renewed Banking Integration (if you're using Renewed, you can just uncomment the code block below, if you're not, then you can add your own logic here)
        --[[
        if type(amount) ~= "number" or amount <= 0 then
            return false
        end

        -- Add `amount` to the society’s Renewed-Banking account
        local ok = exports['Renewed-Banking']:addAccountMoney(jobName, amount)
        if not ok then
            return false
        end

        -- Fetch and return the updated balance
        local newBalance = exports['Renewed-Banking']:getAccountMoney(jobName)
        return newBalance or false
        ]]
        return false -- Just to clarify, a function can only have one return statement. So if you uncomment renewed-banking above, remove this return.
    end,

    --- Withdraw from a society account using Renewed-Banking.
    --- @param source     number  The boss’s server ID performing the withdrawal.
    --- @param jobName    string  The society/job key (e.g. "police").
    --- @param amount     number  Amount to withdraw (must be > 0).
    --- @param moneyType  string  "cash" or "bank".  (not used here)
    --- @return number|false      New balance on success, or false on error.
    withdraw = function(source, jobName, amount, moneyType)
        -- Renewed Banking Integration (if you're using Renewed, you can just uncomment the code block below, if you're not, then you can add your own logic here)
        --[[
        if type(amount) ~= "number" or amount <= 0 then
            return false
        end

        -- Remove `amount` from the society’s Renewed-Banking account
        local ok = exports['Renewed-Banking']:removeAccountMoney(jobName, amount)
        if not ok then
            return false
        end

        -- Fetch and return the updated balance
        local newBalance = exports['Renewed-Banking']:getAccountMoney(jobName)
        return newBalance or false
        ]] 
        return false -- Just to clarify, a function can only have one return statement. So if you uncomment renewed-banking above, remove this return.
    end,

    --- Get the current society balance via Renewed-Banking.
    --- @param source  number  The boss’s server ID requesting balance.
    --- @param jobName string  The society/job key (e.g. "police").
    --- @return number|false    Current balance, or false if error.
    getBalance = function(source, jobName)
        -- Renewed Banking Integration (if you're using Renewed, you can just uncomment the code block below, if you're not, then you can add your own logic here)
        --[[
        return exports['Renewed-Banking']:getAccountMoney(jobName)
        ]]
        return false -- Just to clarify, a function can only have one return statement. So if you uncomment renewed-banking above, remove this return.
    end,
}

-- Application input settings (for job application forms)
Config.ApplicationInput = {
    minLength = 1,    -- Minimum character length for application answers
    maxLength = 500,  -- Maximum character length for application answers
}

-- Definition of each available job: its map icon, pay scales by grade, and human-readable grade labels.
-- So on qb-core for example, you'd effectively copy/mimic the entries from the shared/jobs.lua file here.
-- You don't have to add all your jobs here, just the ones you want people to be able to have in their multijob.
Config.Jobs = {
    sasp = {
        label = 'San Andreas State Patrol', -- Label that'll appear in the multijob for this job. 
        icon = "shield",  -- FontAwesome icon for menus/maps
        bossGrades  = { 11 }, -- grade 4 (“Chief”) is boss (you can add more)
        salaries = { -- Salary payout per payday, indexed by job grade (THERE IS NO PAYOUT SYSTEM, ITS ONLY FOR DISPLAY IN THE MENU.)
            [0] = 20,
            [1] = 25,
            [2] = 30,
            [3] = 32,
            [4] = 35,
            [5] = 38,
            [6] = 40,
            [7] = 42,
            [8] = 45,
            [9] = 47,
            [10] = 50,
            [11] = 52,
        },
        gradeLabels = { -- Display names for display in the menu.
            [0] = 'Cadet',
            [1] = 'Trooper',
            [2] = 'Sr. Trooper',
            [3] = 'Corporal',
            [4] = 'Sergeant',
            [5] = 'Sr Sergeant',
            [6] = 'Supervisor',
            [7] = 'Sr. Supervisor',
            [8] = 'Lieutenant',
            [9] = 'Captain',
            [10] = 'Major',
            [11] = 'Commissioner',
        },
        -- for ox_inventory users only
        stash = {
            enabled = true, -- Enable/disable stash functionality for this job
            slots = 50,     -- Number of inventory slots
            weight = 100000 -- Maximum weight capacity (in grams)
        }
    },
    bcso = {
        label = 'Blaine County Sheriffs Office', -- Label that'll appear in the multijob for this job. 
        icon = "shield",  -- FontAwesome icon for menus/maps
        bossGrades  = { 11 }, -- grade 4 (“Chief”) is boss (you can add more)
        salaries = { -- Salary payout per payday, indexed by job grade (THERE IS NO PAYOUT SYSTEM, ITS ONLY FOR DISPLAY IN THE MENU.)
            [0] = 20,
            [1] = 25,
            [2] = 30,
            [3] = 32,
            [4] = 35,
            [5] = 38,
            [6] = 40,
            [7] = 42,
            [8] = 45,
            [9] = 47,
            [10] = 50,
            [11] = 52,
        },
        gradeLabels = { -- Display names for display in the menu.
            [0] = 'Recruit',
            [1] = 'Corporal',
            [2] = 'Sergeant',
            [3] = 'Sr. Sergeant',
            [4] = 'Lieutenant',
            [5] = 'Captain',
            [6] = 'Major',
            [7] = 'Supervisor',
            [8] = 'Command',
            [9] = 'Asst. Deputy',
            [10] = 'Deputy Commissioner',
            [11] = 'Commissioner',
        },
        -- for ox_inventory users only
        stash = {
            enabled = true, -- Enable/disable stash functionality for this job
            slots = 50,     -- Number of inventory slots
            weight = 100000 -- Maximum weight capacity (in grams)
        }
    },
    safd = {
        label = 'San Andreas Fire Department',
        icon = "house-medical-circle-exclamation",
        bossGrades  = { 6 },
        salaries = {
            [0] = 20,
            [1] = 23,
            [2] = 25,
            [3] = 27,
            [4] = 29,
            [5] = 32,
            [6] = 35,
        },
        gradeLabels = {
            [0] = 'Training',
            [1] = 'Firefighter',
            [2] = 'EMS',
            [3] = 'Lieutenant',
            [4] = 'Command',
            [5] = 'Bat. Chief',
            [6] = 'Chief',
        },
        -- for ox_inventory users only
        stash = {
            enabled = true, -- Enable/disable stash functionality for this job
            slots = 40,     -- Number of inventory slots
            weight = 80000  -- Maximum weight capacity (in grams)
        }
    },
        camel = {
            label = 'Camel Towing',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Driver',
                [2] = 'Lead Driver',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        stance = {
            label = 'StancedEnuff Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        sittin = {
            label = 'Sittinlooww Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        ndca = {
            label = 'NDC & A Kustomz',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Mechanic',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        wilsons = {
            label = 'Wilsons Auto',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Mechanic',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        pcustoms = {
            label = 'Peyton\'s Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        smoove = {
            label = 'Smooves Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        hayes = {
            label = 'Hayes Auto Body Shop',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        elevatedcustoms = {
            label = 'Elevated Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Body Tech',
                [1] = 'Paint Tech',
                [2] = 'Parts Manager',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        santosmech = {
            label = '26 Santos Mechanic Shop',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Mechanic',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        shamo = {
            label = '$HAMO_x Kustoms',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        dirt = {
            label = 'Dirtbag Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Employee',
                [1] = 'Painter',
                [2] = 'Body Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },

        coast = {
            label = 'East Coast Customs',
            icon = "warehouse",
            bossGrades = { 4 },

            salaries = {
                [0] = 20,
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
            },
            gradeLabels = {
                [0] = 'Trainee',
                [1] = 'Tech',
                [2] = 'Lead Tech',
                [3] = 'Manager',
                [4] = 'Owner',
            },

            stash = {
                enabled = true,
                slots = 40,
                weight = 80000
            }
        },
}

-- Locations and everything else related to every job.
Config.Zones = {
    sasp = {
        duty = {
            enabled = false,
            interactionType = "marker", -- how the player toggles duty: "target", "textui", or "marker"
            locations = { -- Now supports multiple locations
                {
                    coords   = vec3(440.48, -976.02, 29.69),
                    distance = 3.0,
                    marker = { -- if target or textui this table is ignored
                        type    = 1,
                        red     = 0,
                        green   = 155,
                        blue    = 255,
                        opacity = 150,
                    },
                },

            },
        },
        dutyZone = { -- Essentially, if enabled, you HAVE to be in the zone to be on duty. You can't go on-duty outside and if you're on duty and leave you'll be forced off.
            enabled = false,     -- whether to auto–offduty when leaving this zone
            bossImmune  = false, -- if true, bosses stay on duty when they leave
            timeout = {
                enabled = true,  -- if true, delayed offduty; if false, immediate offduty
                seconds = 30,    -- delay in seconds
            },
            zones = {
                {
                    points = {
                        vec3(416.3, -961.91, 25.0),
                        vec3(498.26, -962.05, 25.0),
                        vec3(494.67, -1042.9, 25.0),
                        vec3(403.34, -1046.47, 25.0),
                    },
                    thickness = 100.0,  -- draw thickness / detection width
                },
            }, 
        },
        bossMenu = {
            enabled         = true,
            interactionType = "marker",  -- "marker", "target", or "textui"
            locations = { -- Now supports multiple locations
                {
                    coords   = vec3(448.21, -973.12, 29.69),
                    distance = 2.5,
                    marker = { -- ignored for target/textui
                        type    = 1,
                        red     = 255,
                        green   = 200,
                        blue    = 0,
                        opacity = 150,
                    },
                },
            },
        },
    },
    bcso = {
        duty = {
            enabled = false,
            interactionType = "marker", -- how the player toggles duty: "target", "textui", or "marker"
            locations = { -- Now supports multiple locations
                {
                    coords   = vec3(440.48, -976.02, 29.69),
                    distance = 3.0,
                    marker = { -- if target or textui this table is ignored
                        type    = 1,
                        red     = 0,
                        green   = 155,
                        blue    = 255,
                        opacity = 150,
                    },
                },

            },
        },
        dutyZone = { -- Essentially, if enabled, you HAVE to be in the zone to be on duty. You can't go on-duty outside and if you're on duty and leave you'll be forced off.
            enabled = false,     -- whether to auto–offduty when leaving this zone
            bossImmune  = false, -- if true, bosses stay on duty when they leave
            timeout = {
                enabled = true,  -- if true, delayed offduty; if false, immediate offduty
                seconds = 30,    -- delay in seconds
            },
            zones = {
                {
                    points = {
                        vec3(416.3, -961.91, 25.0),
                        vec3(498.26, -962.05, 25.0),
                        vec3(494.67, -1042.9, 25.0),
                        vec3(403.34, -1046.47, 25.0),
                    },
                    thickness = 100.0,  -- draw thickness / detection width
                },
            }, 
        },
        bossMenu = {
            enabled         = true,
            interactionType = "marker",  -- "marker", "target", or "textui"
            locations = { -- Now supports multiple locations
                {
                    coords   = vec3(2782.6377, 4745.5947, 48.6278),
                    distance = 2.5,
                    marker = { -- ignored for target/textui
                        type    = 1,
                        red     = 255,
                        green   = 200,
                        blue    = 0,
                        opacity = 150,
                    },
                },
            },
        },
    },
    safd = {
        duty = {
            enabled = false,
            interactionType = "marker", -- how the player toggles duty: "target", "textui", or "marker"
            locations = { -- Now supports multiple locations
                {
                    coords   = vec3(440.48, -976.02, 29.69),
                    distance = 3.0,
                    marker = { -- if target or textui this table is ignored
                        type    = 1,
                        red     = 0,
                        green   = 155,
                        blue    = 255,
                        opacity = 150,
                    },
                },

            },
        },
        dutyZone = { -- Essentially, if enabled, you HAVE to be in the zone to be on duty. You can't go on-duty outside and if you're on duty and leave you'll be forced off.
            enabled = false,     -- whether to auto–offduty when leaving this zone
            bossImmune  = false, -- if true, bosses stay on duty when they leave
            timeout = {
                enabled = true,  -- if true, delayed offduty; if false, immediate offduty
                seconds = 30,    -- delay in seconds
            },
            zones = {
                {
                    points = {
                        vec3(416.3, -961.91, 25.0),
                        vec3(498.26, -962.05, 25.0),
                        vec3(494.67, -1042.9, 25.0),
                        vec3(403.34, -1046.47, 25.0),
                    },
                    thickness = 100.0,  -- draw thickness / detection width
                },
            }, 
        },
        bossMenu = {
            enabled         = true,
            interactionType = "marker",  -- "marker", "target", or "textui"
            locations = { -- Now supports multiple locations
                {
                    coords   = vec3(1755.4277, 3624.6421, 39.0330),
                    distance = 2.5,
                    marker = { -- ignored for target/textui
                        type    = 1,
                        red     = 255,
                        green   = 200,
                        blue    = 0,
                        opacity = 150,
                    },
                },
            },
        },
    },
camel = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-2028.7356, -505.9716, 11.2131),--685
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

stance = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-662.1617, -883.8232, 23.5127),--726
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
            {
                coords   = vec3(-1077.9386, -2092.8303, 13.2617),--887
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

sittin = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(2001.3472, 4598.9531, 44.0304),--111
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

ndca = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(698.1581, 162.1712, 88.7781),--592
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

wilsons = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(1420.9315, 1051.1913, 113.3971),--539
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

pcustoms = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-1077.9386, -2092.8303, 12.2617),--887
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

smoove = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-32.0112, -1114.2546, 25.9118),--745
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
            {
                coords   = vec3(1465.5175, 1686.8851, 117.5146),--542
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

hayes = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-254.2135, 6153.2642, 34.7104),--045
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

elevatedcustoms = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(1152.7604, -792.7800, 56.6024),--574
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
            {
                coords   = vec3(2532.7617, 2640.2070, 37.7977),--334
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
            {
                coords   = vec3(197.3879, 2756.4355, 42.5389),--228
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

santosmech = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-699.6348, -2483.9277, 17.7401),--905
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},
shamo = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(-771.3943, 5853.6641, 22.4530),--013
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
            {
                coords   = vec3(2736.5876, 4915.3530, 33.6873),--099
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

dirt = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(1420.9536, 1051.1399, 113.3971),--538/539
                distance = 2.5,
                marker = {
                    type    = 23,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},

coast = {
    duty = {
        enabled = false,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(440.48, -976.02, 29.69),
                distance = 3.0,
                marker = {
                    type    = 1,
                    red     = 0,
                    green   = 155,
                    blue    = 255,
                    opacity = 150,
                },
            },
        },
    },
    dutyZone = {
        enabled = false,
        bossImmune  = false,
        timeout = {
            enabled = true,
            seconds = 30,
        },
        zones = {
            {
                points = {
                    vec3(416.3, -961.91, 25.0),
                    vec3(498.26, -962.05, 25.0),
                    vec3(494.67, -1042.9, 25.0),
                    vec3(403.34, -1046.47, 25.0),
                },
                thickness = 100.0,
            },
        },
    },
    bossMenu = {
        enabled         = true,
        interactionType = "marker",
        locations = {
            {
                coords   = vec3(1309.7688, 2629.3838, 38.2945),--262
                distance = 2.5,
                marker = {
                    type    = 1,
                    red     = 255,
                    green   = 200,
                    blue    = 0,
                    opacity = 150,
                },
            },
        },
    },
},
}

-- Which statistics to display per job in the “View Stats” menu, and how to format each entry.
-- You can increment the stats via the updateStats export. exports['sd-multijob']:updateStats(src, jobName, statKey, increment)
-- So as an example, to increment the police arrests stat by 1 for source 1, you would call: exports['sd-multijob']:updateStats(1, 'police', 'arrests', 1)
Config.Stats = {
    enable = true, -- enable/disable stat functionality
    sasp = { -- job key 
        {
            key         = "minutesWorked",      -- Internal stat name (minutesWorked works for ALL jobs as a stat by default)
            title       = "Time on Duty",       -- Menu title
            icon        = "clock",              -- Icon for this stat
            -- no description here; uses FormatMinutesWorked
        },
        {
            key         = "arrests", -- Internal stat name
            title       = "Arrests Made", -- Menu title
            description = "You made {amount} arrests.",  -- {amount} interpolates the value
            icon        = "handcuffs" -- Icon for this stat
        },
        {
            key         = "ticketsIssued",
            title       = "Tickets Issued",
            description = "You issued {amount} tickets.",
            icon        = "ticket"
        },
        {
            key         = "vehiclesImpounded",
            title       = "Vehicles Impounded",
            description = "You impounded {amount} vehicles.",
            icon        = "car"
        },
        {
            key         = "callsResponded",
            title       = "Calls Responded",
            description = "You responded to {amount} calls.",
            icon        = "phone"
        },
        {
            key         = "bonuses",
            title       = "Bonuses Received",
            description = "You received ${amount} in bonuses.",
            icon        = "gift"
        }
    },
    ambulance = {
        {
            key   = "minutesWorked",
            title = "Time on Duty",
            icon  = "clock"
        },
        {
            key         = "patientsSaved",
            title       = "Patients Saved",
            description = "You saved {amount} lives.",
            icon        = "heart-pulse"
        },
        {
            key         = "revives",
            title       = "Revives Performed",
            description = "You revived {amount} players.",
            icon        = "heart"
        },
        {
            key         = "transportsCompleted",
            title       = "Transports Completed",
            description = "You transported {amount} patients.",
            icon        = "car-side"
        },
        {
            key         = "suppliesUsed",
            title       = "Supplies Used",
            description = "You used {amount} medical supplies.",
            icon        = "box-medical"
        },
        {
            key         = "bonuses",
            title       = "Bonuses Received",
            description = "You received ${amount} in bonuses.",
            icon        = "gift"
        }
    },
    -- You can add more...
}

-- Leaderboard scoring weights: how much each stat contributes to overall rank.
Config.Leaderboard = {
    enable = true, -- enable/disable leaderboard functionality
    sasp = {
        timeWeight  = 1, -- Points per minute on duty
        statWeights = {
            arrests             = 60,  -- Points per arrest
            ticketsIssued       = 10,  -- Points per ticket issued
            vehiclesImpounded   = 30,  -- Points per vehicle impounded
            callsResponded      = 15,  -- Points per call responded
            bonuses             = 1    -- Points per dollar in bonuses
        },
    },

    -- Example detailed stat weights for the ambulance job
    ambulance = {
        timeWeight  = 1, -- Points per minute on duty
        statWeights = {
            patientsSaved         = 45, -- Points per patient saved
            revives               = 20, -- Points per revive performed
            transportsCompleted   = 15, -- Points per transport completed
            suppliesUsed          = 5,  -- Points per supply used
            bonuses               = 1   -- Points per dollar in bonuses
        },
    },
    -- You can add more...
}