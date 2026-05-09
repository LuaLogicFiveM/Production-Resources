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
        ----------------------------------- Business -----------------------------------
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
                enabled = true,
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
                enable = true,
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
        ["gsp"] = {
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
        ["realestate"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 3 },
            coords = {
                vec4(-709.7026, 267.8573, 83.1080, 296.4009)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 3 },
                ['GIVE_BONUS'] = { 3 },
                ['WITHDRAW_MONEY'] = { 3 },
                ['DEPOSIT_MONEY'] = { 3 },
                ['HIRE_EMPLOYEE'] = { 3 },
                ['FIRE_EMPLOYEE'] = { 3 },
                ['PROMOTE_EMPLOYEE'] = { 3 },
                ['MANAGE_SALARIES'] = { 3 },
                ['VIEW_TRANSACTIONS'] = { 3 },
                ['MANAGE_REPORTS'] = { 3 },
                ['MANAGE_VEHICLES'] = { 3 },
                ['MANAGE_ANNOUNCEMENT'] = { 3 },
                ['MANAGE_SETTINGS'] = { 3 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-709.7026, 267.8573, 83.1080, 296.4009),
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
                        vec4(-709.7026, 267.8573, 83.1080, 296.4009)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["greasy"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 5 },
            coords = {
                vec4(-305.1025, -1479.4985, 30.5932, 278.3701)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 5 },
                ['GIVE_BONUS'] = { 5 },
                ['WITHDRAW_MONEY'] = { 5 },
                ['DEPOSIT_MONEY'] = { 5 },
                ['HIRE_EMPLOYEE'] = { 5 },
                ['FIRE_EMPLOYEE'] = { 5 },
                ['PROMOTE_EMPLOYEE'] = { 5 },
                ['MANAGE_SALARIES'] = { 5 },
                ['VIEW_TRANSACTIONS'] = { 5 },
                ['MANAGE_REPORTS'] = { 5 },
                ['MANAGE_VEHICLES'] = { 5 },
                ['MANAGE_ANNOUNCEMENT'] = { 5 },
                ['MANAGE_SETTINGS'] = { 5 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-305.1025, -1479.4985, 30.5932, 278.3701),
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
                        vec4(-305.1025, -1479.4985, 30.5932, 278.3701)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["gunstore_807"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 2 },
            coords = {
                vec4(823.9765, -2165.6055, 33.0741, 181.3913)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 2 },
                ['GIVE_BONUS'] = { 2 },
                ['WITHDRAW_MONEY'] = { 2 },
                ['DEPOSIT_MONEY'] = { 2 },
                ['HIRE_EMPLOYEE'] = { 2 },
                ['FIRE_EMPLOYEE'] = { 2 },
                ['PROMOTE_EMPLOYEE'] = { 2 },
                ['MANAGE_SALARIES'] = { 2 },
                ['VIEW_TRANSACTIONS'] = { 2 },
                ['MANAGE_REPORTS'] = { 2 },
                ['MANAGE_VEHICLES'] = { 2 },
                ['MANAGE_ANNOUNCEMENT'] = { 2 },
                ['MANAGE_SETTINGS'] = { 2 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(823.9765, -2165.6055, 33.0741, 181.3913),
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
                        vec4(823.9765, -2165.6055, 33.0741, 181.3913)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["gunstore_778"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 2 },
            coords = {
                vec4(1743.3495, -1584.2817, 113.2464, 189.2587)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 2 },
                ['GIVE_BONUS'] = { 2 },
                ['WITHDRAW_MONEY'] = { 2 },
                ['DEPOSIT_MONEY'] = { 2 },
                ['HIRE_EMPLOYEE'] = { 2 },
                ['FIRE_EMPLOYEE'] = { 2 },
                ['PROMOTE_EMPLOYEE'] = { 2 },
                ['MANAGE_SALARIES'] = { 2 },
                ['VIEW_TRANSACTIONS'] = { 2 },
                ['MANAGE_REPORTS'] = { 2 },
                ['MANAGE_VEHICLES'] = { 2 },
                ['MANAGE_ANNOUNCEMENT'] = { 2 },
                ['MANAGE_SETTINGS'] = { 2 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1743.3495, -1584.2817, 113.2464, 189.2587),
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
                        vec4(1743.3495, -1584.2817, 113.2464, 189.2587)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["tequilala"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-561.3740, 281.9122, 85.6765, 263.1111)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-561.3740, 281.9122, 85.6765, 263.1111),
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
                        vec4(-561.3740, 281.9122, 85.6765, 263.1111)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["pizza_pier"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 3, 4 },
            coords = {
                vec4(-1513.3668, -905.6477, 10.1822, 68.6515)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 3, 4 },
                ['GIVE_BONUS'] = { 3, 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 3, 4 },
                ['HIRE_EMPLOYEE'] = { 3, 4 },
                ['FIRE_EMPLOYEE'] = { 3, 4 },
                ['PROMOTE_EMPLOYEE'] = { 3, 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 3, 4 },
                ['MANAGE_REPORTS'] = { 3, 4 },
                ['MANAGE_VEHICLES'] = { 3, 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 3, 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1513.3668, -905.6477, 10.1822, 68.6515),
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
                        vec4(-1513.3668, -905.6477, 10.1822, 68.6515)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },


        ----------------------------------- Shops -----------------------------------

        ["camel"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-2023.0251, -498.8725, 12.2131, 74.2528)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-2028.7356, -505.9716, 12.2131, 45.8117),
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
                        vec4(-2028.7356, -505.9716, 12.2131, 45.8117)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["stance"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-662.1617, -883.8232, 24.5127, 100.9375),
                vec4(-1077.9386, -2092.8303, 13.2617, 119.4005)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-662.1617, -883.8232, 24.5127, 100.9375),
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
                        vec4(-662.1617, -883.8232, 24.5127, 100.9375)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["sittin"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(2001.3472, 4598.9531, 45.0304, 120.0)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(2001.3472, 4598.9531, 45.0304, 120.0),
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
                        vec4(2001.3472, 4598.9531, 45.0304, 120.0)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["ndca"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(698.1581, 162.1712, 89.7781, 58.4352)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(698.1581, 162.1712, 89.7781, 58.4352),
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
                        vec4(698.1581, 162.1712, 89.7781, 58.4352)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["wilsons"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(1420.9315, 1051.1913, 114.3971, 209.4149)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1420.9315, 1051.1913, 114.3971, 209.4149),
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
                        vec4(1420.9315, 1051.1913, 114.3971, 209.4149)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["pcustoms"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-1077.9386, -2092.8303, 13.2617, 119.4005)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1077.9386, -2092.8303, 13.2617, 119.4005),
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
                        vec4(-1077.9386, -2092.8303, 13.2617, 119.4005)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["smoove"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-32.0112, -1114.2546, 26.9118, 54.2356),
                vec4(1465.5175, 1686.8851, 117.5146, 80.1898)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-32.0112, -1114.2546, 26.9118, 54.2356),
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
                        vec4(-32.0112, -1114.2546, 26.9118, 54.2356)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["hayes"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-254.2135, 6153.2642, 35.7104, 160.8475)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-254.2135, 6153.2642, 35.7104, 160.8475),
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
                        vec4(-254.2135, 6153.2642, 35.7104, 160.8475)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["elevatedcustoms"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(1152.7604, -792.7800, 57.6024, 172.5813),
                vec4(2532.7617, 2640.2070, 38.7977, 172.5813),
                vec4(197.3879, 2756.4355, 43.5389, 172.5813)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1152.7604, -792.7800, 57.6024, 172.5813),
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
                        vec4(1152.7604, -792.7800, 57.6024, 172.5813)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["santosmech"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-699.6348, -2483.9277, 18.7401, 69.7591)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-699.6348, -2483.9277, 18.7401, 69.7591),
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
                        vec4(-699.6348, -2483.9277, 18.7401, 69.7591)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["$hamo"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-771.3943, 5853.6641, 23.4530, 36.6833),
                vec4(2736.5876, 4915.3530, 33.6873, 121.6586)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-771.3943, 5853.6641, 23.4530, 36.6833),
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
                        vec4(-771.3943, 5853.6641, 23.4530, 36.6833)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["dirt"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(1420.9536, 1051.1399, 114.3971, 248.9169)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1420.9536, 1051.1399, 114.3971, 248.9169),
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
                        vec4(1420.9536, 1051.1399, 114.3971, 248.9169)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["coast"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(1309.7688, 2629.3838, 39.2945, 213.1328)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1309.7688, 2629.3838, 39.2945, 213.1328),
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
                        vec4(1309.7688, 2629.3838, 39.2945, 213.1328)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ----------------------------------- Weed Shops -----------------------------------

        ["khusbites"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 3 },
            coords = {
                vec4(-517.0371, 51.1718, 44.5919, 120.0)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 3 },
                ['GIVE_BONUS'] = { 3 },
                ['WITHDRAW_MONEY'] = { 3 },
                ['DEPOSIT_MONEY'] = { 3 },
                ['HIRE_EMPLOYEE'] = { 3 },
                ['FIRE_EMPLOYEE'] = { 3 },
                ['PROMOTE_EMPLOYEE'] = { 3 },
                ['MANAGE_SALARIES'] = { 3 },
                ['VIEW_TRANSACTIONS'] = { 3 },
                ['MANAGE_REPORTS'] = { 3 },
                ['MANAGE_VEHICLES'] = { 3 },
                ['MANAGE_ANNOUNCEMENT'] = { 3 },
                ['MANAGE_SETTINGS'] = { 3 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-517.0371, 51.1718, 44.5919, 120.0),
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
                        vec4(-517.0371, 51.1718, 44.5919, 120.0)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["cookies"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 3 },
            coords = {
                vec4(-1721.0811, -1110.1544, 17.3299, 120.0)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 3 },
                ['GIVE_BONUS'] = { 3 },
                ['WITHDRAW_MONEY'] = { 3 },
                ['DEPOSIT_MONEY'] = { 3 },
                ['HIRE_EMPLOYEE'] = { 3 },
                ['FIRE_EMPLOYEE'] = { 3 },
                ['PROMOTE_EMPLOYEE'] = { 3 },
                ['MANAGE_SALARIES'] = { 3 },
                ['VIEW_TRANSACTIONS'] = { 3 },
                ['MANAGE_REPORTS'] = { 3 },
                ['MANAGE_VEHICLES'] = { 3 },
                ['MANAGE_ANNOUNCEMENT'] = { 3 },
                ['MANAGE_SETTINGS'] = { 3 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1721.0811, -1110.1544, 17.3299, 120.0),
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
                        vec4(-1721.0811, -1110.1544, 17.3299, 120.0)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["hookahloungev2"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-430.0804, 49.5283, 46.3109, 120.0)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-430.0804, 49.5283, 46.3109, 120.0),
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
                        vec4(-430.0804, 49.5283, 46.3109, 120.0)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["leafnlatte"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(185.9613, -266.1883, 54.0400, 330.7705)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(185.9613, -266.1883, 54.0400, 330.7705),
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
                        vec4(185.9613, -266.1883, 54.0400, 330.7705)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ----------------------------------- Motorcycle Clubs -----------------------------------

        ["redrum"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 8 },
            coords = {
                vec4(-1180.8380, -1191.5292, 11.6269, 134.8031)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 8 },
                ['GIVE_BONUS'] = { 8 },
                ['WITHDRAW_MONEY'] = { 8 },
                ['DEPOSIT_MONEY'] = { 8 },
                ['HIRE_EMPLOYEE'] = { 8 },
                ['FIRE_EMPLOYEE'] = { 8 },
                ['PROMOTE_EMPLOYEE'] = { 8 },
                ['MANAGE_SALARIES'] = { 8 },
                ['VIEW_TRANSACTIONS'] = { 8 },
                ['MANAGE_REPORTS'] = { 8 },
                ['MANAGE_VEHICLES'] = { 8 },
                ['MANAGE_ANNOUNCEMENT'] = { 8 },
                ['MANAGE_SETTINGS'] = { 8 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1180.8380, -1191.5292, 11.6269, 134.8031),
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
                        vec4(-1180.8380, -1191.5292, 11.6269, 134.8031)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["afmc"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 5 },
            coords = {
                vec4(1045.8152, -2531.6611, 28.9622, 84.3458)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 5 },
                ['GIVE_BONUS'] = { 5 },
                ['WITHDRAW_MONEY'] = { 5 },
                ['DEPOSIT_MONEY'] = { 5 },
                ['HIRE_EMPLOYEE'] = { 5 },
                ['FIRE_EMPLOYEE'] = { 5 },
                ['PROMOTE_EMPLOYEE'] = { 5 },
                ['MANAGE_SALARIES'] = { 5 },
                ['VIEW_TRANSACTIONS'] = { 5 },
                ['MANAGE_REPORTS'] = { 5 },
                ['MANAGE_VEHICLES'] = { 5 },
                ['MANAGE_ANNOUNCEMENT'] = { 5 },
                ['MANAGE_SETTINGS'] = { 5 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1045.8152, -2531.6611, 28.9622, 84.3458),
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
                        vec4(1045.8152, -2531.6611, 28.9622, 84.3458)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["outlaw"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(1187.2943, 2637.2227, 38.4019, 33.0674)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1187.2943, 2637.2227, 38.4019, 33.0674),
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
                        vec4(1187.2943, 2637.2227, 38.4019, 33.0674)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["deadly"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-442.1889, 264.1572, 86.1950, 29.6220)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-442.1889, 264.1572, 86.1950, 29.6220),
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
                        vec4(-442.1889, 264.1572, 86.1950, 29.6220)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["lost"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 7 },
            coords = {
                vec4(-1130.9895, -1602.6873, 4.4069, 20.1201)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 7 },
                ['GIVE_BONUS'] = { 7 },
                ['WITHDRAW_MONEY'] = { 7 },
                ['DEPOSIT_MONEY'] = { 7 },
                ['HIRE_EMPLOYEE'] = { 7 },
                ['FIRE_EMPLOYEE'] = { 7 },
                ['PROMOTE_EMPLOYEE'] = { 7 },
                ['MANAGE_SALARIES'] = { 7 },
                ['VIEW_TRANSACTIONS'] = { 7 },
                ['MANAGE_REPORTS'] = { 7 },
                ['MANAGE_VEHICLES'] = { 7 },
                ['MANAGE_ANNOUNCEMENT'] = { 7 },
                ['MANAGE_SETTINGS'] = { 7 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1130.9895, -1602.6873, 4.4069, 20.1201),
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
                        vec4(-1130.9895, -1602.6873, 4.4069, 20.1201)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ----------------------------------- Gangs -----------------------------------

        ["osm"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 5 },
            coords = {
                vec4(-1146.8999, -1553.9967, 7.6327, 6.3776),
                vec4(-71.5939, 369.0418, 112.4225, 71.7914)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 5 },
                ['GIVE_BONUS'] = { 5 },
                ['WITHDRAW_MONEY'] = { 5 },
                ['DEPOSIT_MONEY'] = { 5 },
                ['HIRE_EMPLOYEE'] = { 5 },
                ['FIRE_EMPLOYEE'] = { 5 },
                ['PROMOTE_EMPLOYEE'] = { 5 },
                ['MANAGE_SALARIES'] = { 5 },
                ['VIEW_TRANSACTIONS'] = { 5 },
                ['MANAGE_REPORTS'] = { 5 },
                ['MANAGE_VEHICLES'] = { 5 },
                ['MANAGE_ANNOUNCEMENT'] = { 5 },
                ['MANAGE_SETTINGS'] = { 5 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1146.8999, -1553.9967, 7.6327, 6.3776),
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
                        vec4(-1146.8999, -1553.9967, 7.6327, 6.3776)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["youngslime"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 5 },
            coords = {
                vec4(-8.7714, -1480.2526, 29.7442, 156.3349)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 5 },
                ['GIVE_BONUS'] = { 5 },
                ['WITHDRAW_MONEY'] = { 5 },
                ['DEPOSIT_MONEY'] = { 5 },
                ['HIRE_EMPLOYEE'] = { 5 },
                ['FIRE_EMPLOYEE'] = { 5 },
                ['PROMOTE_EMPLOYEE'] = { 5 },
                ['MANAGE_SALARIES'] = { 5 },
                ['VIEW_TRANSACTIONS'] = { 5 },
                ['MANAGE_REPORTS'] = { 5 },
                ['MANAGE_VEHICLES'] = { 5 },
                ['MANAGE_ANNOUNCEMENT'] = { 5 },
                ['MANAGE_SETTINGS'] = { 5 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-8.7714, -1480.2526, 29.7442, 156.3349),
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
                        vec4(-8.7714, -1480.2526, 29.7442, 156.3349)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["section6"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 5 },
            coords = {
                vec4(172.9143, -1709.8993, 23.5837, 67.3764)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 5 },
                ['GIVE_BONUS'] = { 5 },
                ['WITHDRAW_MONEY'] = { 5 },
                ['DEPOSIT_MONEY'] = { 5 },
                ['HIRE_EMPLOYEE'] = { 5 },
                ['FIRE_EMPLOYEE'] = { 5 },
                ['PROMOTE_EMPLOYEE'] = { 5 },
                ['MANAGE_SALARIES'] = { 5 },
                ['VIEW_TRANSACTIONS'] = { 5 },
                ['MANAGE_REPORTS'] = { 5 },
                ['MANAGE_VEHICLES'] = { 5 },
                ['MANAGE_ANNOUNCEMENT'] = { 5 },
                ['MANAGE_SETTINGS'] = { 5 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(172.9143, -1709.8993, 23.5837, 67.3764),
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
                        vec4(172.9143, -1709.8993, 23.5837, 67.3764)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["fourzerofour"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 6 },
            coords = {
                vec4(-1580.9668, -234.5325, 55.0430, 52.4877)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 6 },
                ['GIVE_BONUS'] = { 6 },
                ['WITHDRAW_MONEY'] = { 6 },
                ['DEPOSIT_MONEY'] = { 6 },
                ['HIRE_EMPLOYEE'] = { 6 },
                ['FIRE_EMPLOYEE'] = { 6 },
                ['PROMOTE_EMPLOYEE'] = { 6 },
                ['MANAGE_SALARIES'] = { 6 },
                ['VIEW_TRANSACTIONS'] = { 6 },
                ['MANAGE_REPORTS'] = { 6 },
                ['MANAGE_VEHICLES'] = { 6 },
                ['MANAGE_ANNOUNCEMENT'] = { 6 },
                ['MANAGE_SETTINGS'] = { 6 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-1580.9668, -234.5325, 55.0430, 52.4877),
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
                        vec4(-1580.9668, -234.5325, 55.0430, 52.4877)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["fdk"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 4 },
            coords = {
                vec4(-19.3949, -1491.2119, 30.4869, 354.2206)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 4 },
                ['GIVE_BONUS'] = { 4 },
                ['WITHDRAW_MONEY'] = { 4 },
                ['DEPOSIT_MONEY'] = { 4 },
                ['HIRE_EMPLOYEE'] = { 4 },
                ['FIRE_EMPLOYEE'] = { 4 },
                ['PROMOTE_EMPLOYEE'] = { 4 },
                ['MANAGE_SALARIES'] = { 4 },
                ['VIEW_TRANSACTIONS'] = { 4 },
                ['MANAGE_REPORTS'] = { 4 },
                ['MANAGE_VEHICLES'] = { 4 },
                ['MANAGE_ANNOUNCEMENT'] = { 4 },
                ['MANAGE_SETTINGS'] = { 4 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(-19.3949, -1491.2119, 30.4869, 354.2206),
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
                        vec4(-19.3949, -1491.2119, 30.4869, 354.2206)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
            }
        },

        ["santos"] = {
            isGang = false,
            secondaryJobsAllowManage = false,
            secondaryJobs = {},
            EnableUserMenu = true,
            allowedGrades = { 3 },
            coords = {
                vec4(1443.5477, -1483.3562, 66.6192, 168.2353),
                vec4(1224.2643, -410.2469, 68.8613, 343.9229)
            },
            pages = {
                enable_job_application = true,
                enable_reports = true,
                enable_leave_management = true,
                enable_vehicle_management = true,
            },
            permissions = {
                ['ACCOUNT_BALANCE'] = { 3 },
                ['GIVE_BONUS'] = { 3 },
                ['WITHDRAW_MONEY'] = { 3 },
                ['DEPOSIT_MONEY'] = { 3 },
                ['HIRE_EMPLOYEE'] = { 3 },
                ['FIRE_EMPLOYEE'] = { 3 },
                ['PROMOTE_EMPLOYEE'] = { 3 },
                ['MANAGE_SALARIES'] = { 3 },
                ['VIEW_TRANSACTIONS'] = { 3 },
                ['MANAGE_REPORTS'] = { 3 },
                ['MANAGE_VEHICLES'] = { 3 },
                ['MANAGE_ANNOUNCEMENT'] = { 3 },
                ['MANAGE_SETTINGS'] = { 3 }
            },
            JobApplication = {
                enabled = false,
                ped = {
                    enable = true,
                    model = "s_m_y_cop_01",
                    scenario = "WORLD_HUMAN_CLIPBOARD",
                },
                coords = {
                    vec4(1443.5477, -1483.3562, 66.6192, 168.2353),
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
                        vec4(1443.5477, -1483.3562, 66.6192, 168.2353)
                    },
                },
                ShowcaseLocation = vec4(797.25, -3000.18, -69.63, 242.65),
                VehicleCam = vec3(803.05, -3004.78, -67.7)
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
