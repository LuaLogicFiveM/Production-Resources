Config = {}
Config.Locale = "en" -- Supported: EN / SK / CS / DE

-- Czech and Slovak languages by: iceyy4400 (discord id: 1057394957897441380)
-- German Language by: nameitsphil (discord id: 457672439510335498)

Config.Debug = false

-- 15% OFF WITH CODE "NEWCUSTOMER" at https://otherplanet.dev
-- Best Gangs Script for FiveM -> https://otherplanet.dev/product/gangs

Config.AdditionalScripts = {
    op_Gangs = false, -- https://otherplanet.dev/product/gangs
}

Config.LevelCommand = "drugslevel" -- Check current player level and boost. Set it to false to disable.

Config.dispatchScript = "cd_dispatch" 
-- Supported:
-- none
-- cd_dispatch 
-- codem_dispatch 
-- lb-tablet 
-- ps-dispatch 
-- rcore_dispatch

Config.CurrencySettings = {
    -- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/NumberFormat
    currency = "USD",
    style = "currency",
    format = "en-US"
}

Config.Misc = {
    AccessMethod = "ox-target", -- Supported: ox-target / qb-target
    Notify = "ox_lib", 
    -- Supported:
    -- op_hud 
    -- okokNotify 
    -- vms_notify 
    -- brutal_notify 
    -- ox_lib 
    -- ESX 
    -- QBCORE 
    -- QBOX
}

Config.DirtyMoney = {
    -- This is Dirty Money item name.
    -- It works only for QB/QBOX
    -- ESX Handles dirty money using balance black_money
    itemName = "black_money"
}

Config.DrugSelling = {
    availableDrugs = {
        -- Create items in your inventory - https://docs.otherplanet.dev
        ["packaged_weed"] = {
            itemName = "packaged_weed",
            label = "Packaged Weed",
            minimumPrice = 250,
            optimalPrice = 350,
            maximumPrice = 500,
            maxAmountPedTransaction = 5,
            handPropName = "prop_weed_bottle",
            icon = "nui://ox_inventory/web/images/packaged_weed.png",
        },
        ["packaged_high_quality_weed"] = {
            itemName = "packaged_high_quality_weed",
            label = "Packaged Weed (High Quality)",
            minimumPrice = 350,
            optimalPrice = 500,
            maximumPrice = 650,
            maxAmountPedTransaction = 5,
            handPropName = "prop_weed_bottle",
            icon = "nui://ox_inventory/web/images/packaged_high_quality_weed.png",
        },
        ["packaged_dried_weed"] = {
            itemName = "packaged_dried_weed",
            label = "Packaged Dried Weed",
            minimumPrice = 400,
            optimalPrice = 600,
            maximumPrice = 750,
            maxAmountPedTransaction = 5,
            handPropName = "prop_weed_bottle",
            icon = "nui://ox_inventory/web/images/packaged_dried_weed.png",
        },
        ["packaged_dried_high_quality_weed"] = {
            itemName = "packaged_dried_high_quality_weed",
            label = "Packaged Dried Weed (High Quality)",
            minimumPrice = 500,
            optimalPrice = 700,
            maximumPrice = 850,
            maxAmountPedTransaction = 5,
            handPropName = "prop_weed_bottle",
            icon = "nui://ox_inventory/web/images/packaged_dried_high_quality_weed.png",
        },
        ["packaged_energizing_dried_weed"] = {
            itemName = "packaged_energizing_dried_weed",
            label = "Packaged Dried Energizing Weed",
            minimumPrice = 600,
            optimalPrice = 800,
            maximumPrice = 950,
            maxAmountPedTransaction = 5,
            handPropName = "prop_weed_bottle",
            icon = "nui://ox_inventory/web/images/packaged_energizing_dried_weed.png",
        },
        ["packaged_gingeritis_weed"] = {
            itemName = "packaged_gingeritis_weed",
            label = "Packaged Gingeritis Weed",
            minimumPrice = 700,
            optimalPrice = 900,
            maximumPrice = 1050,
            maxAmountPedTransaction = 5,
            handPropName = "prop_weed_bottle",
            icon = "nui://ox_inventory/web/images/packaged_gingeritis_weed.png",
        },
        ["packaged_default_meth"] = {
            itemName = "packaged_default_meth",
            label = "Packaged Meth",
            minimumPrice = 1000,
            optimalPrice = 1250,
            maximumPrice = 1500,
            maxAmountPedTransaction = 5,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_default_meth.png",
        },
        ["packaged_coke"] = {
            itemName = "packaged_coke",
            label = "Packaged Coke",
            minimumPrice = 1000,
            optimalPrice = 1100,
            maximumPrice = 1500,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_coke.png",
        },
        ["packaged_high_quality_coke"] = {
            itemName = "packaged_high_quality_coke",
            label = "Packaged Coke (High Quality)",
            minimumPrice = 1200,
            optimalPrice = 1300,
            maximumPrice = 1500,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_high_quality_coke.png",
        },
        ["packaged_dried_coke"] = {
            itemName = "packaged_dried_coke",
            label = "Packaged Dried Coke",
            minimumPrice = 1300,
            optimalPrice = 1400,
            maximumPrice = 1600,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_dried_coke.png",
        },
        ["packaged_dried_high_quality_coke"] = {
            itemName = "packaged_dried_high_quality_coke",
            label = "Packaged Dried Coke (High Quality)",
            minimumPrice = 1400,
            optimalPrice = 1500,
            maximumPrice = 1700,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_dried_high_quality_coke.png",
        },
        ["packaged_cooked_coke"] = {
            itemName = "packaged_cooked_coke",
            label = "Packaged Cooked Coke",
            minimumPrice = 1500,
            optimalPrice = 1750,
            maximumPrice = 2000,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_cooked_coke.png",
        },
        ["packaged_cooked_high_quality_coke"] = {
            itemName = "packaged_cooked_high_quality_coke",
            label = "Packaged Cooked Coke (High Quality)",
            minimumPrice = 1750,
            optimalPrice = 2000,
            maximumPrice = 2250,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_cooked_high_quality_coke.png",
        },
        ["packaged_cooked_dried_coke"] = {
            itemName = "packaged_cooked_dried_coke",
            label = "Packaged Cooked Dried Coke",
            minimumPrice = 1850,
            optimalPrice = 2100,
            maximumPrice = 2350,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_cooked_dried_coke.png",
        },
        ["packaged_cooked_dried_high_quality_coke"] = {
            itemName = "packaged_cooked_dried_high_quality_coke",
            label = "Packaged Cooked Dried Coke (High Quality)",
            minimumPrice = 2000,
            optimalPrice = 2250,
            maximumPrice = 2500,
            maxAmountPedTransaction = 3,
            handPropName = "p_meth_bag_01_s",
            icon = "nui://ox_inventory/web/images/packaged_cooked_dried_high_quality_coke.png",
        }
    },
    dispatchCallChance = 20, -- 15% Chance that after transaction dispatch will be called.
    blipData = {
        -- Dispatch Blips Data
        sprite = 51, -- Blip sprite
        color = 1, -- Blip color
    }
}

Config.CornerDealing = {
    Enable = true,
    SellTimeout = math.random(10, 25), -- Time in second after which next ped will be spawned In Corner Mode.
    Command = "drugsell",
}

Config.Leveling = {
    Enable = true,
    LevelEXP = 500, -- One level == 500 exp.
    LevelsList = {
        [1] = 1, -- 1% Boost for level.
        [2] = 2, -- 2% Boost for level.
        [3] = 3, -- 3% Boost for level.
        [4] = 4, -- 4% Boost for level.
        [5] = 5, -- 5% Boost for level.
        [6] = 6, -- 6% Boost for level.
        [7] = 7, -- 7% Boost for level.
        [8] = 8, -- 8% Boost for level.
        [9] = 9, -- 9% Boost for level.
        [10] = 10, -- 10% Boost for level.
    }
}

Config.PedTypes = {
    ['addicted'] = {
        label = "Addicted",
        saleEXP = 5, -- EXP per Sale.
        stealDrugChance = 30, -- Chance that ped will steal your drugs!
        buyChance = 80, -- Range 0-100
        refuseChance = 0, -- Range 0-100 (This is refuse without even open of drug dealing menu)
        dispatchCall = false, -- Can this type of ped call dispatch
        colors = {
            -- Label Box next to ped Name.
            border = "#8400ff",
            background = "#8400ff8c"
        }
    },
    ['normal'] = {
        label = "Normal",
        saleEXP = 25, -- EXP per Sale.
        stealDrugChance = 10, -- Chance that ped will steal your drugs!
        buyChance = 50, -- Range 0-100
        refuseChance = 15, -- Range 0-100 (This is refuse without even open of drug dealing menu)
        dispatchCall = true, -- Can this type of ped call dispatch
        colors = {
            -- Label Box next to ped Name.
            border = "#00ccffff",
            background = "#00aeff8c"
        }
    },
    ['party'] = {
        label = "Party",
        saleEXP = 15, -- EXP per Sale.
        stealDrugChance = 10, -- Chance that ped will steal your drugs!
        buyChance = 75, -- Range 0-100
        refuseChance = 5, -- Range 0-100 (This is refuse without even open of drug dealing menu)
        dispatchCall = true, -- Can this type of ped call dispatch
        colors = {
            -- Label Box next to ped Name.
            border = "#ffa600ff",
            background = "#ffbb008c"
        }
    },
    ['snitch'] = {
        label = "Snitch",
        saleEXP = 40,
        stealDrugChance = 0, -- nie kradnie
        buyChance = 20, -- bardzo rzadko kupuje
        refuseChance = 50, -- często od razu odmawia
        dispatchCall = true, -- zawsze duże ryzyko wzywania policji
        colors = {
            border = "#ff0000",
            background = "#ff00008c"
        }
    },
    ['dealer'] = {
        label = "Street Dealer",
        saleEXP = 30,
        stealDrugChance = 20, -- może spróbować cię ograć
        buyChance = 60, -- kupi, ale w większych ilościach
        refuseChance = 10,
        dispatchCall = false, -- nie wzywa psów, bo sam kręci biznes
        colors = {
            border = "#00ff00",
            background = "#00ff008c"
        }
    },
    ['rich'] = {
        label = "Rich Guy",
        saleEXP = 10,
        stealDrugChance = 0,
        buyChance = 90, -- prawie zawsze kupuje
        refuseChance = 0,
        dispatchCall = true, -- czasami zadzwoni, jak się przestraszy
        colors = {
            border = "#ffd700",
            background = "#ffd7008c"
        }
    },
    ['junkie'] = {
        label = "Junkie",
        saleEXP = 5,
        stealDrugChance = 50, -- mega ryzyko kradzieży
        buyChance = 70,
        refuseChance = 10,
        dispatchCall = false, -- nie ogarnia policji
        colors = {
            border = "#8b4513",
            background = "#8b45138c"
        }
    },
    ['undercover'] = {
        label = "Undercover Cop",
        saleEXP = 50,
        stealDrugChance = 0,
        buyChance = 30, -- udaje że kupuje
        refuseChance = 0,
        dispatchCall = true, -- 100% szansa że poleci dispatch
        colors = {
            border = "#2121c4ff",
            background = "#0404ff69"
        }
    },
}

Config.PedsList = {
    -- Other Peds Not Listed Here will be handled like Normal Ped Type.
    -- [Addicted Peds]
    [`a_f_m_skidrow_01`] = 'addicted',
    [`g_m_y_ballasout_01`] = 'addicted',
    [`g_m_y_ballaeast_01`] = 'addicted',
    [`g_m_y_famca_01`] = 'addicted',
    [`g_m_y_famdnf_01`] = 'addicted',
    [`g_m_y_mexgoon_03`] = 'addicted',
    [`g_m_y_pologoon_01`] = 'addicted',
    [`g_m_y_pologoon_02`] = 'addicted',
    [`g_m_y_salvagoon_01`] = 'addicted',
    [`g_m_y_salvagoon_03`] = 'addicted',
    [`g_m_y_strpunk_01`] = 'addicted',

    -- [Party Peds]
    [`a_m_y_hipster_01`] = 'party',
    [`a_f_y_clubcust_01`] = 'party',
    [`a_m_y_clubcust_01`] = 'party',
    [`a_f_y_clubcust_02`] = 'party',
    [`a_m_y_clubcust_02`] = 'party',
    [`a_m_y_clubcust_03`] = 'party',
    [`csb_ramp_hipster`] = 'party',
    [`csb_ramp_mex`] = 'party',

    -- [Snitch Peds]
    [`a_m_m_business_01`] = 'snitch',
    [`a_m_m_eastsa_02`] = 'snitch',
    [`a_f_y_business_01`] = 'snitch',
    [`a_f_y_business_02`] = 'snitch',
    [`csb_reporter`] = 'snitch',

    -- [Dealer Peds]
    [`g_m_y_ballaorig_01`] = 'dealer',
    [`g_m_y_mexgang_01`] = 'dealer',
    [`g_m_y_mexgoon_01`] = 'dealer',
    [`g_m_y_famfor_01`] = 'dealer',
    [`g_m_y_strpunk_02`] = 'dealer',

    -- [Rich Peds]
    [`a_m_m_soucent_01`] = 'rich',
    [`a_m_y_bevhills_01`] = 'rich',
    [`a_f_y_bevhills_01`] = 'rich',
    [`a_f_y_bevhills_02`] = 'rich',
    [`u_m_y_imporage`] = 'rich',
    [`u_m_y_party_01`] = 'rich',

    -- [Junkie Peds]
    [`a_m_y_skater_01`] = 'junkie',
    [`a_m_y_skater_02`] = 'junkie',
    [`a_m_m_tramp_01`] = 'junkie',
    [`a_f_m_tramp_01`] = 'junkie',
    [`a_m_m_trampbeac_01`] = 'junkie',
    [`a_m_m_trampbeac_02`] = 'junkie',
    [`u_m_y_staggrm_01`] = 'junkie',

    -- [Undercover Cop Peds]
    [`s_m_m_ciasec_01`] = 'undercover',
    [`s_m_m_highsec_01`] = 'undercover',
    [`s_m_m_highsec_02`] = 'undercover',
    [`s_m_y_cop_01`] = 'undercover',
    [`csb_undercover`] = 'undercover'
}


-- Black list peds
Config.BlackListPeds = {
    [`a_m_m_skidrow_01`] = true,
}