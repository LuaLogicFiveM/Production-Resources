ESX = exports['es_extended']:getSharedObject()

Configuration = {
    Settings = {
        ---@type "target" | "textui" # Target will use ox_target, textui will use Ox Lib Text UI
        OxType = "target",
        Security = true, --- Security is a new system that prevents exploits and cheaters from exploiting scammer job

        --- Wallpaper that is displayed in the UI, Want to make your own? -> height: 972 px width: 1536 px
        Wallpaper = "https://r2.fivemanage.com/CWDuI3yLS4av0OWnTLNNl/image/spoodyFraudV3_default_wallpaper.png",

        Sales = {
            Alert = true, -- Enable police alerts?
            Chances = 0.50, -- 50% chance police get alerted
        },

        NUI = {
            CloningTime = 5000, --- How long (in ms) will it take to clone a card?
            PrintingTime = 6500, --- How long (in ms) will it take to print a check?
            SimCalling = 10000, --- How long (in ms) will it take to do the SIM swap call?
            SimCloning = 7500, --- How long (in ms) will it take to clone the new SIM?

            --- NEW: Randomized rewards system, you can now give players multiple amounts of rewards after interacting.
            Rewards = {
                Clones = { min = 1, max = 3 }, --- Randomize 1-5 cards to be given after swiping?
                Checks = { min = 1, max = 2 }, --- Randomize 1-3 checks to be given after printing?
                Sim = { min = 1, max = 1 }, --- Ramdp,oze 1-2 SIM cards to be given after calling?
            },
        },

        Police = {
            PoliceJob = "sahp",
            DrawBlip = false, -- Draw a blip on their map when an alert happens?

            Online = {
                Enabled = true, -- Do cops need to be online in order to sell?
                Count = 1, -- How many cops need to be online in order to sell?
            }
        },

        Failure = {
            Enabled = true, -- Enable failure chances for sales?
            Chances = {
                Cards = 0.08, -- 8% chance of failure. [In real life, cloned cards are extremely difficult to detect and usually go through without issues.]
                Checks = 0.12, -- 12% chance of failure. [In real life, fraudulent checks can sometimes be easily flagged by a bank teller.]
                Sims = 0.15, -- 15% chance of failure. [In real life, SIM swaps are often reported to the phone carrier within an hour, and if not sold quickly, they may be reversed.]
            }
        }
    },

    Job = {
        Enabled = false, --- Enable jobs? (if enabled, the specified job will only be allowed to use the laptop, print checks, cards etc)
        DistributionSystem = true, --- Allow default players (without jobs) to sell illegal items? (i.e unemployed can sell cloned cards, sims, checks)
        JobName = "scammer", --- Job name
    },

    DiscordRole = {
        Enabled = false, --- Would you like to enable Discord roles to also allow roles?
        Resource = '', --- Your Badger Discord API resource name
        RoleID = '' --- The Discord Role ID
    },

    Selling = {
        Clones = {
            Rewards = {
                Reward = {min = 500, max = 1500}, -- Randomized between values of $350 & $3500
                Account = "dirty", -- cash, bank or dirty money?
            },

            Models = { 'prop_atm_01', 'prop_fleeca_atm', 'prop_atm_02', 'prop_atm_03' }, --- Add models that you would like to use (Ox Target Only)
            Locations = false,

            --[[Locations = {
                ["Pacific Bank"] = {
                    Location = vec3(237.8048, 216.9053, 106.2868),
                    Heading = 301.8932,
                },
            }]]
        },

        Checks = {
            Rewards = {
                Reward = {min = 500, max = 1500}, -- Randomized between values of $350 & $3500
                Account = "dirty", -- cash, bank or dirty money?
            },

            Locations = {
                ["Pacific Bank"] = {
                    Heading = 337.0690,
                    Location = vec3(248.3301, 222.9014, 106.2868),

                    Ped = {
                        Enabled = true,
                        Coords = vec4(249.0421, 224.6193, 105.3, 155.6678),
                        Hash = "u_m_m_bankman",
                    },
                },
            }
        },

        Sims = {
            Rewards = {
                Reward = {min = 1350, max = 2000}, -- Randomized between values of $350 & $3500
                Account = "dirty", -- cash, bank or dirty money?
            },

            Locations = {
                ["Legion Square"] = {
                    Heading = 248.6716,
                    Location = vec3(72.9557, -1027.2975, 29.4757), --- Notice: the coords MUST be in front of the ped (if enabled)

                    Ped = {
                        Enabled = true,
                        Coords = vec4(72.9557, -1027.2975, 28.4757, 248.6716),
                        Hash = "hc_hacker"
                    }
                },
            }
        }
    },

    Blackmarket = {
        Locations = {

            ["Blackmarket"] = {
                Enabled = true,
                Location = vec3(-735.5536, -292.3194, 37.0451),

                Ped = {
                    Enabled = true,
                    Location = vec4(-735.5536, -292.3194, 36.0451, 336.8912),
                    Hash = "ig_joeminuteman",
                },

                Items = {
                    { Item = "msr", Image = "nui://ox_inventory/web/images/msr.png", Label = "MSR Swiper", Count = 1, Price = 5000 },
                    { Item = "blank", Image = "nui://ox_inventory/web/images/blank.png", Label = "Blank Cards", Count = 5, Price = 500 },
                    { Item = "checkpaper", Image = "nui://ox_inventory/web/images/checkpaper.png", Label = "Checkpaper", Count = 5, Price = 500 },
                    { Item = "simcard", Image = "nui://ox_inventory/web/images/simcard.png", Label = "Sim Card", Count = 5, Price = 500 },
                }
            },

            ["Electronic Shop"] = {
                Enabled = true,
                Location = vec3(-1461.7798, -686.8304, 26.4668),

                Ped = {
                    Enabled = true,
                    Location = vec4(-1461.7798, -686.8304, 25.4668, 318.1529),
                    Hash = "ig_jay_norris",
                },

                Items = {
                    { Item = "laptop", Image = "nui://ox_inventory/web/images/laptop.png", Label = "Laptop", Count = 1, Price = 1000},
                    { Item = "printer", Image = "nui://ox_inventory/web/images/printer.png", Label = "Printer", Count = 1, Price = 500},
                    { Item = "burnerphone", Image = "nui://ox_inventory/web/images/burnerphone.png", Label = "Burner Phone", Count = 1, Price = 1500 },
                }
            }

        }
    },

    ---@param message string
    ---@param type? 'inform' | 'error' | 'success' | 'warning'
    Notify = function(message, type)
        lib.notify({
            title = "Fraud System",
            description = message,
            type = type or 'inform',
            position = 'top',
            duration = 5000,
        })
    end,

    ---@alias dispatchOptions 'none' | 'rcore_dispatch' | 'qs-dispatch' | 'cd-dispatch' | 'lb-tablet'
    ---@type dispatchOptions --- ^ These are your available options for dispatch
    DispatchSystem = 'cd-dispatch', --- Leave empty if you don't have any dispatch systems and want to use the built in one.

    --- If the DispatchSystem is set to 'none', this function will be executed everytime someone successfully sells a check, clone, or SIM. 
    ---@param index string | "check" | "atm"
    ---@param location string
    PoliceNotify = function(location, index)
        if Configuration.DispatchSystem ~= 'none' then return end

        if index == "check" then
            Configuration.Notify("The bank at: " ..location.. " has reported someone selling a fraudulent check!", 'warning')
            --PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", true)
        elseif index == "atm" then
            Configuration.Notify("The ATM at: " ..location.. " has reported someone using a fradulent card!", 'warning')
            --PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", true)
        end
    end,

    Models = {
        Printer = "v_res_printer",
        Laptop = "spoody_leansy_laptop",
        MSR = "leansy_reader_card"
    },

    --- Only change the value if you have a different item name. Do NOT change the [code]
    --- [code] = item name
    Items = {
        ['Laptop'] = "laptop",
        ['Printer'] = "printer",
        ['MSR'] = "msr",
        ['Burner Phone'] = "burnerphone",
        ['Blank Card'] = "blank",
        ['Cloned Card'] = "ccard",
        ['Check Paper'] = "checkpaper",
        ['Forged Check'] = "fcheck",
        ['Swapped Sim Card'] = "sim",
        ['Empty Sim Card'] = "simcard"
    },
}

Locales = {
    ['FRAUD_INVALID_JOB'] = "You don't have the required job.",
    ['FRAUD_LAPTOP_OUT'] = "You already have a laptop out.",
    ['FRAUD_NO_PRINTER'] = "You don't have a printer connected.",
    ['FRAUD_NO_APP'] = "You must log into the check fraud application in order to print.",
    ['FRAUD_NO_PHONE'] = "You don't have a burner phone connected.",
    ['FRAUD_NO_APP_SIM'] = "You must log into the SIM swap application in order to connect.",
    ['FRAUD_NO_MSR'] = "You don't have an MSR connected.",
    ['FRAUD_NO_APP_CLONE'] = "You must log into the card clone application in order to swipe.",
    ['FRAUD_CHECK_ALREADY_INS'] = "You already inserted a check.",
    ['FRAUD_CHECK_INSERT_SUCCESSFUL'] = "Insert successful, paper ready to print.",
    ['FRAUD_NO_CHECKPAPER'] = "You don't have any check paper",
    ['FRAUD_ALREADY_SWIPED'] = "You already swiped a card.",
    ['FRAUD_SWIPE_SUCCESSFUL'] = "Swipe successful; card ready to clone.",
    ['FRAUD_NO_BLANKS'] = "You don't have any blank cards.",
    ['FRAUD_SIM_ALREADY_INS'] = "You have already inserted a SIM card.",
    ['FRAUD_SIM_INSERT_SUCCESSFUL'] = "Insert successful; SIM Card connected successfully.",
    ['FRAUD_NO_SIMS'] = "You don't have any SIM cards.",
    ['FRAUD_NO_LAPTOP'] = "You must have a laptop out before connecting any device.",
    ['FRAUD_NO_SALE_JOB'] = "You don't have the requried job to sell these items.",
    ['FRAUD_NO_SALE_ITEM'] = "You don't have the required item to sell.",
    ['FRAUD_NO_SHOP_JOB'] = "You don't have the required item to sell.",
    ['FRAUD_CHECK_SELL_FAIL'] = "Your forged check was identified as fraudulent and the bank teller rejected it!",
    ['FRAUD_CHECK_SELL_SUCCESS'] = "You cashed in a check worth $%s",
    ['FRAUD_SIM_SELL_FAIL'] = "Your SIM card was erased by the phone provider and can no longer be sold!",
    ['FRAUD_SIM_SELL_SUCCESS'] = "You cashed in a SIM card worth $%s",
    ['FRAUD_CLONE_SELL_FAIL'] = "Your cloned card has been identified as fraudulent by the ATM and has rejected it!",
    ['FRAUD_CLONE_SELL_SUCCESS'] = "You cashed in a cloned card worth $%s",
    ['FRAUD_SELL_NO_POLICE'] = "There are not enough police officers online to sell this product.",
    ['FRAUD_STORE_PURCHASE_SUCCESSFUL'] = "You purchased %sx %s(s)!",
    ['FRAUD_STORE_PURCHASE_FAIL'] = "You don't have enough money for this purchase",
    ['FRAUD_INTERACTION_SUCCESS'] = "You've received 1x %s!",
    ['FRAUD_PROGRESS_CALLING'] = "Calling Phone Carrier",
    ['FRAUD_PROGRESS_INSERTING_CHECK'] = "Inserting check into printer",
    ['FRAUD_PROGRESS_SWIPING_CARD'] = "Swiping card",
    ['FRAUD_PROGRESS_INSERTING_SIM'] = "Inserting SIM Card into Burner Phone",
    ['FRAUD_PROGRESS_CASHING_CHECK'] = "Cashing Check",
    ['FRAUD_PROGRESS_SELLING_SIM'] = "Selling SIM Card",
    ['FRAUD_PROGRESS_INSERTING_CLONE'] = "Inserting Clone",
    ['FRAUD_PROGRESS_GRABBING_CASH'] = "Grabbing Money",
}