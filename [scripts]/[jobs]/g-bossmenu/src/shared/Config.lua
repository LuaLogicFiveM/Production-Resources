Config = {}
--- RECOMENDED TO LEAVE AS TRUE ---
Config.CheckForUpdates = true -- Check for updates on server start
Config.AutoImportSQL = true   -- Automatically import on server start

Config.SystemSettings = {
    Language = "en", -- en - english | de - german | es - spanish | fr - french | pt - portuguese | ru - russian | tr - turkish
    Debug = true,
    theme = "gblue",           -- gblue | theme2 | theme3 | theme4 | theme5 | themeWhite - default themes
    OpenMenuVia = "textui",    -- target | textui | custom
    Notify = "esx" -- okok | esx | qbcore | ox_lib | 17mov | g-notifications | standalone
}

-- TextUI settings
Config.Key = 38          -- 38 = [E] https://docs.fivem.net/docs/game-references/controls/#controls
Config.KeyName = "[E] "
Config.TextUI = "ox_lib" -- supported Notifications TextUi's -  "ox_lib" | "okok" | "esx" | "qbcore"

-- Recommended resources for bossmenu
-- Advanced Duty V2 Link - https://groot-development.tebex.io/package/7007496
-- Advanced Paycheck Link - https://groot-development.tebex.io/package/7007494
Config.RecommendedResources = {
    gDutyV2 = 'g-dutyV2',
    advPaycheck = 'g-adv-paycheck'
}


Config.BossMenuSettings = {
    -- Recommended to use 'inbuilt'
    -- inbuilt  - System will use the internal society logic handled by this resource.
    -- external - System will use external society/banking systems:
    --            esx_society | qb-banking | okokBanking | renewedbanking | tgg-banking | crm-banking | fd-banking
    --            If you're using a different system, modify server/sv_edit.lua to add support.
    society_management = 'inbuilt', -- inbuilt | external


    -- Even if you set this to true, it will only work if those two packages are installed.
    enable_duty_system = true,  -- true | false (required package g-dutyV2 https://groot-development.tebex.io/package/7007496)
    enable_bonus_system = true, -- true | false (required package g-adv-paycheck https://groot-development.tebex.io/package/7007494)

    nearbyDist = 10.0,          -- distance radius to detect nearby players (Hire Employee)

    -- true  → Allows promotions/demotions of offline employees (updates database directly).
    -- false → Restricts promotions/demotions to only online employees (Player must be online/onDuty).
    -- (Recommended) Keep it false
    AllowOfflinePromotions = true, -- true | false - Whether a boss can promote or demote an employee who is currently offline.
    BonusPayType = "society",       -- 'default' = removes bonus from bank, 'society' = removes from job/society funds
    BonusAmountLimit = 100000,       -- bonus amount limit
    CanGiveBonusWhenOffDuty = true, -- true | false - Whether a boss can give a bonus to an employee who is not on duty
    PlayerMoneySource = "cash",     -- 'bank' | 'cash' — determines if player money comes from bank or cash during boss menu transactions

    -- These will override the all settings in the bossmenu settings
    EnableJobApplicationSystem = true,
    EnableLeaveManagementSystem = true,
    EnableVehicleSystem = true,
    EnableReportsSystem = true,

    -- when creating logic make sure to check if the user has the permission to access the announcement and sos alert
    EnableAnnouncement = true,
    CurrencySymbol = "$",
    -- QBCore | QBox - pillboxgarage | ESX - SanAndreasAvenue - you can change it
    defaultParking = "pillbox", -- defaultParking
}

Config.Icons = {
    bossTargetIcon = "fas fa-building",
    vehicleShopTargetIcon = "fas fa-car",
    jobApplicationTargetIcon = "fas fa-user-plus",
}


Config.UserMenu = {
    enable = true,
    cmdName = "bossmenu",       -- Command to open boss menu
    help = "Open the boss menu", -- Command help text

    -- This for user menu each section force disable
    UserMenuForce = {
        DisabledJobApplication = false,
        DisabledMyVehicles = false,
        DisabledReports = false,
        DisabledLeaveManagement = false,
    }
}

Config.Menu = {
    -- The default job assigned to a player when they get fired.
    UnemployedJob = {
        name = "unemployed",
        grade = 0
    },
    BossMenu = {
        ["bcso"] = {
            isGang = false, -- (if ESX Framework leave this as false) enable this if the job is a gang
            secondaryJobsAllowManage = false,
            -- use this for your multiple jobs
            secondaryJobs = {
                -- this can be empty {}
                -- its for multiple jobs support ['job_name'] = {grade1, grade2, grade3, ...},
                -- ['mechanic'] = { 3, 4 },
            },
            EnableUserMenu = true,       -- if you want to disable the user menu just set it to false
            -- Example: allowedGrades = { 3 } means that only players with grade 3
            allowedGrades = { 10, 11 }, -- rank required to access the bossmenu
            -- bossmenu coords
            coords = {
                vec4(2782.6379, 4745.6113, 48.6274, 289.7135)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 10, 11 },
                ['GIVE_BONUS'] = { 9, 10, 11 },
                ['WITHDRAW_MONEY'] = { 10, 11 },
                ['DEPOSIT_MONEY'] = { 8, 9, 10, 11 },
                ['HIRE_EMPLOYEE'] = { 8, 9, 10, 11 },
                ['FIRE_EMPLOYEE'] = { 10, 11 },
                ['PROMOTE_EMPLOYEE'] = { 10, 11 },
                ['MANAGE_SALARIES'] = { 11 },
                ['VIEW_TRANSACTIONS'] = { 10, 11 },
                ['MANAGE_REPORTS'] = { 7, 8, 9, 10, 11 },
                ['MANAGE_VEHICLES'] = { 10, 11 },
                ['MANAGE_ANNOUNCEMENT'] = { 9, 10, 11 },
                ['MANAGE_SETTINGS'] = { 10, 11 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,                      -- if you want to disable the ped just set it to false
                    model = "s_m_y_cop_01",             -- https://docs.fivem.net/docs/game-references/ped-models/
                    scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
                },
                coords = {
                    vec4(2786.9348, 4739.6260, 48.6274, 8.9383),
                }
            },
            vehicleShop = {
                enable = false,
                vehicleMenu = {
                    ped = {
                        spawn = true,
                        model = "ig_car3guy1",
                    },
                    coords = {
                        vec4(2811.4021, 4833.9595, 47.2223, 277.3796)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7) -- player position
            }
        },
        ["sasp"] = {
            isGang = false, -- (if ESX Framework leave this as false) enable this if the job is a gang
            secondaryJobsAllowManage = false,
            -- use this for your multiple jobs
            secondaryJobs = {
                -- this can be empty {}
                -- its for multiple jobs support ['job_name'] = {grade1, grade2, grade3, ...},
                -- ['mechanic'] = { 3, 4 },
            },
            EnableUserMenu = true,       -- if you want to disable the user menu just set it to false
            -- Example: allowedGrades = { 3 } means that only players with grade 3
            allowedGrades = { 10, 11 }, -- rank required to access the bossmenu
            -- bossmenu coords
            coords = {
                vec4(843.3214, -1301.2767, 31.7641, 306.9295)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 10, 11 },
                ['GIVE_BONUS'] = { 9, 10, 11 },
                ['WITHDRAW_MONEY'] = { 10, 11 },
                ['DEPOSIT_MONEY'] = { 8, 9, 10, 11 },
                ['HIRE_EMPLOYEE'] = { 8, 9, 10, 11 },
                ['FIRE_EMPLOYEE'] = { 10, 11 },
                ['PROMOTE_EMPLOYEE'] = { 10, 11 },
                ['MANAGE_SALARIES'] = { 11 },
                ['VIEW_TRANSACTIONS'] = { 10, 11 },
                ['MANAGE_REPORTS'] = { 7, 8, 9, 10, 11 },
                ['MANAGE_VEHICLES'] = { 10, 11 },
                ['MANAGE_ANNOUNCEMENT'] = { 9, 10, 11 },
                ['MANAGE_SETTINGS'] = { 10, 11 }
            },
            JobApplication = {
                enabled = true,
                ped = {
                    enable = true,                      -- if you want to disable the ped just set it to false
                    model = "s_m_y_cop_01",             -- https://docs.fivem.net/docs/game-references/ped-models/
                    scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
                },
                coords = {
                    vec4(832.7867, -1295.3660, 26.8965, 359.1221),
                }
            },
            vehicleShop = {
                enable = true,
                vehicleMenu = {
                    ped = {
                        spawn = true,
                        model = "ig_car3guy1",
                    },
                    coords = {
                        vec4(871.7104, -1330.6006, 26.3395, 178.0441)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7) -- player position
            }
        },
        ["safd"] = {
            isGang = false, -- (if ESX Framework leave this as false) enable this if the job is a gang
            secondaryJobsAllowManage = false,
            -- use this for your multiple jobs
            secondaryJobs = {
                -- this can be empty {}
                -- its for multiple jobs support ['job_name'] = {grade1, grade2, grade3, ...},
                -- ['mechanic'] = { 3, 4 },
            },
            EnableUserMenu = true,       -- if you want to disable the user menu just set it to false
            -- Example: allowedGrades = { 3 } means that only players with grade 3
            allowedGrades = { 5, 6 }, -- rank required to access the bossmenu
            -- bossmenu coords
            coords = {
                vec4(1662.9036, 3585.5918, 35.7300, 317.5958)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 10, 11 },
                ['GIVE_BONUS'] = { 9, 10, 11 },
                ['WITHDRAW_MONEY'] = { 10, 11 },
                ['DEPOSIT_MONEY'] = { 8, 9, 10, 11 },
                ['HIRE_EMPLOYEE'] = { 8, 9, 10, 11 },
                ['FIRE_EMPLOYEE'] = { 10, 11 },
                ['PROMOTE_EMPLOYEE'] = { 10, 11 },
                ['MANAGE_SALARIES'] = { 11 },
                ['VIEW_TRANSACTIONS'] = { 10, 11 },
                ['MANAGE_REPORTS'] = { 7, 8, 9, 10, 11 },
                ['MANAGE_VEHICLES'] = { 10, 11 },
                ['MANAGE_ANNOUNCEMENT'] = { 9, 10, 11 },
                ['MANAGE_SETTINGS'] = { 10, 11 }
            },
            JobApplication = {
                enabled = true,
                ped = {
                    enable = true,                      -- if you want to disable the ped just set it to false
                    model = "s_m_y_cop_01",             -- https://docs.fivem.net/docs/game-references/ped-models/
                    scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
                },
                coords = {
                    vec4(1683.1877, 3581.5171, 35.7299, 203.2391),
                }
            },
            vehicleShop = {
                enable = true,
                vehicleMenu = {
                    ped = {
                        spawn = true,
                        model = "ig_car3guy1",
                    },
                    coords = {
                        vec4(1690.8173, 3599.5869, 35.3894, 303.1224)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7) -- player position
            }
        },
    }
}


-- Faction cooldowns
Config.FactionCooldowns = {
    EnableFactionCooldowns = false,

    -- if here not listed then it will be legal
    FactionLegalTypes = {
        gang = "illegal",
        cartel = "illegal"
    },
    CoolDowns = {
        ["legal"] = 48 * 60 * 60,   -- 48 hours
        ["illegal"] = 72 * 60 * 60, -- 72 hours
    }
}
