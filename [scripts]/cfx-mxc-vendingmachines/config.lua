Config = {}
Config.Debug = false

Config.RenderDistance = 30.0
Config.DefaultInteractionDistance = 2.0 -- If a vending does not provide a distance this will be used as the default

-- Help us translate!
--  You can contribute by improving existing translations or adding translations for new languages
--  https://localazy.com/p/mxc
Config.Language = "en"

Config.NoFramework = false -- if set to true, ignore framework dependencies; use this parameter if no framework is used (obviously the items and actual usability are not implemented without any framework)
Config.UseOxLibMenuIfFound = true -- set to false if you don't want to use OxLib if found
Config.Blips = true -- set to false if you don't want to see blips on the minimap
Config.Sounds = true -- by default require xSound, you can edit it in config_functions.lua

Config.Target = false -- set to true if you want to use ox-target or qb-target as interaction
Config.CustomTargetResource = "" -- if you have a custom target resource name set it here
Config.AzertyKeyboard = false -- set to true if you use azerty keyboard (default qwerty)

-- Uncomment only if you want to ovverride the default translations provided by localazy
Config.Translations = {
    --                                                             %s will be replaced with selected_product_price if a product is selected
    --["vending_menu_helper"]    = "Please enter the code of a product.\n%s\n~INPUT_SELECT_WEAPON~ Switch camera\n~INPUT_CELLPHONE_SELECT~ Confirm selection\n~INPUT_CELLPHONE_CANCEL~ Exit",
    --["selected_product_price"] = "%s - ~g~%s$~w~ \n",
    --["invalid_product"]        = "~r~Invalid product.~w~",

    --["selection_not_valid"]    = "~r~The code that you entered is not valid, please enter a valid stand code.",
    --["not_enough_money"]       = "~r~You don't have enough money to buy this product.",

    --["already_used"]           = "~r~The vending machine is being used by another player.",

    --["ox_menu_header"]         = "Vending Machine",
    --["ox_menu_description"]    = "Select product",
    --["ox_menu_currency"]         = "$"

    --["normal_int_vanilla"]     = "Press {E} to buy something from the vending machine",
    --["coffee_int_vanilla"]     = "Press {E} to get a coffee from the vending machine",
    --["water_int_vanilla"]      = "Press {E} to get a water cup",
    --["cigs_int_vanilla"]       = "Press {E} to buy a pack of cigarettes",

    --["normal_int_target"]      = "Buy something",
    --["coffee_int_target"]      = "Get a coffee",
    --["water_int_target"]       = "Refresh your mouth"
}

-- These "objects" are used by vending machines for providing human-readable names in menus, models for items, and handling payment.

-- item_name = {
--  price = number (price of the item for payment)
--  label = string (name displayed in menus, e.g., in the ox lib menu)
--  model = string (model used to populate vending machines capable of displaying items; see snack or soda for details)
-- }

-- !! "item_name" Should match the item in your inventory exactly !!

Config.Items = {
    --#region coffee
    coffee = { -- Used only for payment and to give the item
        price = 100
    },
    --#endregion

    --#region water
    water = { -- Used only for payment and to give the item
        price = 0,
        ignoreGive = true
    },
    --#endregion

    --#region snack
    chips_cheese = {
        label = "Chips: Big Cheese",
        model = "mxc_vend_prop_item_chips1",
        price = 100
    },
    chips_paprika = {
        label = "Chips: Paprika",
        model = "mxc_vend_prop_item_chips2",
        price = 100
    },
    chips_ribs = {
        label = "Chips: Sticky Ribs",
        model = "mxc_vend_prop_item_chips3",
        price = 100
    },
    chips_salt = {
        label = "Chips: Salt & Sauce",
        model = "mxc_vend_prop_item_chips4",
        price = 100
    },
    chips_supersalt = {
        label = "Chips: Super Salt",
        model = "mxc_vend_prop_item_chips5",
        price = 100
    },
    chips_habanero = {
        label = "Chips: Habanero",
        model = "mxc_vend_prop_item_chips6",
        price = 100
    },
    chocolate_meteorite = {
        label = "Chocolate: Meteorite",
        model = "mxc_vend_prop_item_chocolate1",
        price = 100
    },
    chocolate_captain = {
        label = "Chocolate: Captain's Log",
        model = "mxc_vend_prop_item_chocolate2",
        price = 100
    },
    condom = {
        label = "Condom: Soth Lags",
        model = "mxc_vend_prop_item_preservatives",
        price = 100,
        zoffset = -0.02
    },
    candy_zebra = {
        label = "Candy: Zebrabar",
        model = "mxc_vend_prop_item_candybar1",
        price = 100
    },
    candy_psqs = {
        label = "Candy: P's & Q's",
        model = "mxc_vend_prop_item_candybar2",
        price = 100
    },
    medicine_laxmax = {
        label = "Medicine: Lax to the Max",
        model = "mxc_vend_prop_item_medical1",
        price = 100
    },
    medicine_alcopatch = {
        label = "Medicine: AlcoPatch",
        model = "mxc_vend_prop_item_medical2",
        price = 100
    },
    medicine_mollis = {
        label = "Medicine: Mollis",
        model = "mxc_vend_prop_item_medical3",
        price = 100
    },
    medicine_betta = {
        label = "Medicine: Betta",
        model = "mxc_vend_prop_item_medical4",
        price = 100
    },
    gum_peppermint = {
        label = "Gum: Peppermint",
        model = "mxc_vend_prop_item_gum1",
        price = 100
    },
    gum_cinnamon = {
        label = "Gum: Cinnamon",
        model = "mxc_vend_prop_item_gum2",
        price = 100
    },
    gum_spearmint = {
        label = "Gum: Spearmint",
        model = "mxc_vend_prop_item_gum3",
        price = 100
    },
    --#endregion
    --#region soda
    bottle_cola = {
        label = "Cola",
        model = "mxc_vend_prop_item_bottle1",
        price = 100
    },
    bottle_junk = {
        label = "Junk",
        model = "mxc_vend_prop_item_bottle2",
        price = 100
    },
    bottle_orang = {
        label = "Orang Tang",
        model = "mxc_vend_prop_item_bottle3",
        price = 100
    },
    bottle_tonic = {
        label = "Tonic",
        model = "mxc_vend_prop_item_bottle4",
        price = 100
    },
    bottle_water = {
        label = "Water",
        model = "mxc_vend_prop_item_bottle5",
        price = 100
    },
    bottle_sprunk = {
        label = "Sprunk",
        model = "mxc_vend_prop_item_bottle6",
        price = 100
    },
    can_cola = {
        label = "Cola Can",
        model = "mxc_vend_prop_item_cansoda1",
        price = 100
    },
    can_orang = {
        label = "Orang Tang Can",
        model = "mxc_vend_prop_item_cansoda2",
        price = 100
    },
    can_junk = {
        label = "Junk Can",
        model = "mxc_vend_prop_item_cansoda3",
        price = 100
    },
    can_sprunk = {
        label = "Sprunk Can",
        model = "mxc_vend_prop_item_cansoda4",
        price = 100
    },
    can_logger = {
        label = "Logger Can",
        model = "mxc_vend_prop_item_canbeer1",
        price = 100
    },
    can_blarneys = {
        label = "Blarneys Can",
        model = "mxc_vend_prop_item_canbeer2",
        price = 100
    },
    can_hoplivion = {
        label = "Hoplivion Can",
        model = "mxc_vend_prop_item_canbeer3",
        price = 100
    },
    can_cerbeza = {
        label = "Cerbeza Can",
        model = "mxc_vend_prop_item_canbeer4",
        price = 100
    },
    --#endregion
    --#region svapo
    sand_evapebox = {
        label = "E-Vape Box",
        model = "mxc_smoking_prop_evape_2a",
        price = 100
    },
    grey_evapebox = {
        label = "E-Vape 2 Box",
        model = "mxc_smoking_prop_evape_2f",
        price = 100
    },
    pink_smokebox = {
        label = "Smoke Box",
        model = "mxc_smoking_prop_smoke_1d",
        price = 100
    },
    red_smokebox = {
        label = "Vaporglow Box",
        model = "mxc_smoking_prop_smoke_1b",
        price = 100
    },
    black_notankatomizer = {
        label = "Black NO-Tank Atomizer",
        model = "mxc_smoking_prop_atom_3c",
        price = 100
    },
    grey_shortatomizer = {
        label = "Short Grey Atomizer",
        model = "mxc_smoking_prop_atom_2f",
        price = 100
    },
    pink_shortatomizer = {
        label = "Short Pink Atomizer",
        model = "mxc_smoking_prop_atom_2e",
        price = 100
    },
    red_shortatomizer = {
        label = "Short Red Atomizer",
        model = "mxc_smoking_prop_atom_2b",
        price = 100
    },
    orange_stickevape = {
        label = "Orange Stick E-Vape",
        model = "mxc_smoking_prop_evape_1c",
        price = 100
    },
    yellow_stickevape = {
        label = "Yellow Stick E-Vape",
        model = "mxc_smoking_prop_evape_1c",
        price = 100
    },
    blue_stickevape = {
        label = "Blue Stick E-Vape",
        model = "mxc_smoking_prop_evape_1c",
        price = 100
    },
    green_stickevape = {
        label = "Green Stick E-Vape",
        model = "mxc_smoking_prop_evape_1c",
        price = 100
    },
    black_vaporglowvape = {
        label = "Black VaporGlow",
        model = "mxc_smoking_prop_vaporglow_1f",
        price = 100
    },
    lightgrey_vaporglowvape = {
        label = "Light Grey VaporGlow",
        model = "mxc_smoking_prop_vaporglow_1e",
        price = 100
    },
    red_vaporglowvape = {
        label = "Red VaporGlow",
        model = "mxc_smoking_prop_vaporglow_1b",
        price = 100
    },
    pink_vaporglowvape = {
        label = "Pink VaporGlow",
        model = "mxc_smoking_prop_vaporglow_1d",
        price = 100
    },
    orange_sumovape = {
        label = "Orange Sumo",
        model = "mxc_smoking_prop_sumo_1g",
        price = 100
    },
    green_sumovape = {
        label = "Green Sumo",
        model = "mxc_smoking_prop_sumo_1c",
        price = 100
    },
    lightgrey_sumovape = {
        label = "Light Grey Sumo",
        model = "mxc_smoking_prop_sumo_1e",
        price = 100
    },
    blue_sumovape = {
        label = "Blue Sumo",
        model = "mxc_smoking_prop_sumo_1a",
        price = 100
    },
    --#endregion

    cigs_redwood = {
        label = "Cigarettes: Redwood",
        model = "v_ret_ml_cigs",
        price = 100
    },
    cigs_redwood2 = {
        label = "Cigarettes: Redwood2",
        model = "v_ret_ml_cigs2",
        price = 100
    },
    cigs_debonaireb = {
        label = "Cigarettes: Debonaire Blue",
        model = "v_ret_ml_cigs3",
        price = 100
    },
    cigs_debonaireg = {
        label = "Cigarettes: Debonaire Green",
        model = "v_ret_ml_cigs4",
        price = 100
    },
    cigs_cardiaque = {
        label = "Cigarettes: Cardiaque",
        model = "v_ret_ml_cigs5",
        price = 100
    },
    cigs_69brand = {
        label = "Cigarettes: 69Brand",
        model = "v_ret_ml_cigs6",
        price = 100
    },
    cigs_cok = {
        label = "Cigarettes: CoK",
        model = "mxc_vend_prop_item_cigs1",
        price = 100
    },
    cigs_estancia = {
        label = "Cigars: Estancia",
        model = "prop_cigar_pack_01",
        price = 100
    }
}


-- Here you can enter model and coordinates to spawn new vending machines around the map, the last value of the vector is the heading
Config.PlaceVendings = {
    prop_vend_snak_01 = {
        vec4(459.8792, -992.0368, 23.9149, 93.7301),
    },
    mxc_vend_prop_svapo_01 = {
        vec4(-497.4405, 277.5, 82.3123, 353.80)
    },
}

-- Here you can customize the exhibition of vending machines near certain coordinates based on the name of vending
Config.OverrideExhibition = {
    {
        name = "snack", -- name of vending (based on Config.Vendings)
        coords = vec3(459.8792, -992.0368, 23.9149),

        exhibition = {
            a1 = "chips_ribs",
            a2 = "chips_paprika",
            a3 = "chips_paprika",
            a4 = "chips_paprika",
            b1 = "chips_paprika",
            b2 = "chips_paprika",
            b3 = "chips_paprika",
            b4 = "chips_ribs",
            c1 = "chips_paprika",
            c2 = "chips_paprika",
            c3 = "chips_paprika",
            c4 = "chips_paprika",
            d1 = "chips_paprika",
            d2 = "chips_paprika",
            d3 = "chips_paprika",
            d4 = "chips_paprika",
            e1 = "chips_paprika",
            e2 = "chips_paprika",
            e3 = "chips_paprika",
            e4 = "chips_paprika",
        },
    },
}

-- Settings for individual vending machines, if you want to disable the blip for an individual vending machine simply delete that entire section.
Config.Vendings = {
    ["snack"] = {
        models = {`prop_vend_snak_01`},
        interaction = {
            vanilla = {
                notify = "normal_int_vanilla",
                distance = 0.35
            },
            target = {
                label = "normal_int_target",
                icon = "fa-solid fa-drumstick-bite",
                distance = 3.0
            }
        },

        blip = {
            sprite = 772,
            color = 0,
            size = 0.5
        },

        -- This section is for choosing which items (from the Config.Items list) to show for each individual stand.
        -- You can follow the visual tags on the in-game model to figure out where you are putting things
        exhibition = {
            a1 = "chips_cheese",
            a2 = "chips_paprika",
            a3 = "chips_ribs",
            a4 = "chips_salt",
            b1 = "chips_supersalt",
            b2 = "chips_habanero",
            b3 = "chips_cheese",
            b4 = "chips_paprika",
            c1 = "chocolate_meteorite",
            c2 = "chocolate_captain",
            c3 = "condom",
            c4 = "candy_zebra",
            d1 = "candy_psqs",
            d2 = "gum_peppermint",
            d3 = "gum_cinnamon",
            d4 = "gum_spearmint",
            e1 = "medicine_laxmax",
            e2 = "medicine_alcopatch",
            e3 = "medicine_mollis",
            e4 = "medicine_betta",
        },

        --#region Advanced
        Near = function(self, obj, dbId)
            PopulateSnackVending(self, obj)
        end,
        Far = function(self, obj, dbId)
            ClearSnackVending(self, obj)
        end,
    
        OnInteraction = function(self, obj, dbId)
            local selection = nil

            -- OxLib input dialog
            if lib and Config.UseOxLibMenuIfFound then
                selection = DisplayOxLibMenu(self, obj)
            else
                selection = DisplayInteractiveMenu(self, obj)
            end

            if selection then
                Config.Functions.TryToBuy(self, selection, dbId, function()
                    SelectItemSnackVending(self, obj, selection)
                end)
            else
                Server.SetVendingUsed(dbId, false)
            end
        end
        --#endregion
    },
    ["soda"] = {
        models = {`prop_vend_soda_01`},
        interaction = {
            vanilla = {
                notify = "normal_int_vanilla",
                distance = 1.0
            },
            target = {
                label = "normal_int_target",
                icon = "fa-solid fa-wine-bottle",
                distance = 3.0
            }
        },

        blip = {
            sprite = 827,
            color = 1,
            size = 0.5
        },

        -- This section is for choosing which items (from the Config.Items list) to show for each individual stand.
        -- You can follow the visual tags on the in-game model to figure out where you are putting things
        exhibition = {
            a1 = "bottle_cola",
            a2 = "bottle_cola",
            a3 = "bottle_junk",
            a4 = "bottle_junk",
            a5 = "bottle_tonic",
            a6 = "bottle_tonic",

            b1 = "bottle_orang",
            b2 = "bottle_orang",
            b3 = "bottle_sprunk",
            b4 = "bottle_sprunk",
            b5 = "bottle_water",
            b6 = "bottle_water",

            c1 = "can_cola",
            c2 = "can_cola",
            c3 = "can_orang",
            c4 = "can_orang",
            c5 = "can_sprunk",
            c6 = "can_junk",

            d1 = "can_logger",
            d2 = "can_logger",
            d3 = "can_blarneys",
            d4 = "can_blarneys",
            d5 = "can_hoplivion",
            d6 = "can_cerbeza",
        },

        --#region Advanced
        Near = function(self, obj, dbId)
            PopulateSodaVending(self, obj, "mxc_vend_prop_soda_shelf")
        end,
        Far = function(self, obj, dbId)
            ClearSodaVending(self, obj)
        end,
    
        OnInteraction = function(self, obj, dbId)
            local selection = nil

            -- OxLib input dialog
            if lib and Config.UseOxLibMenuIfFound then
                selection = DisplayOxLibMenu(self, obj)
            else
                selection = DisplayInteractiveMenu(self, obj)
            end

            if selection then
                Config.Functions.TryToBuy(self, selection, dbId, function()
                    SelectItemSodaVending(self, obj, selection)
                end)
            else
                Server.SetVendingUsed(dbId, false)
            end
        end
        --#endregion
    },
    ["coffee"] = {
        item = "coffee", -- Vending machines without exhibition can set an item to be sold here (as always from Config.Items)
        models = {`prop_vend_coffe_01`},
        interaction = {
            vanilla = {
                notify = "coffee_int_vanilla",
                distance = 1.1
            },
            target = {
                label = "coffee_int_target",
                icon = "fa-solid fa-mug-hot",
                distance = 3.0
            }
        },

        blip = {
            sprite = 89,
            color = 31,
            size = 0.5
        },

        Far = function(self, obj, dbId)
            ClearCoffeeVending(self, obj)
        end,

        --#region Advanced
        OnInteraction = function(self, obj, dbId)
            Config.Functions.TryToBuy(self, self.item, dbId, function()
                StartCoffeeVending(self, obj, true)
            end)
        end
        --#endregion
    },
    ["water"] = {
        item = "water", -- Vending machines without exhibition can set an item to be sold here (as always from Config.Items)
        models = {`prop_watercooler`},
        interaction = {
            vanilla = {
                notify = "water_int_vanilla",
                distance = 1.2
            },
            target = {
                label = "water_int_target",
                icon = "fa-solid fa-glass-water",
                distance = 3.0
            }
        },

        blip = {
            sprite = 499,
            color = 3,
            size = 0.5
        },

        Far = function(self, obj, dbId)
            ClearWaterVending(self, obj)
        end,

        --#region Advanced
        OnInteraction = function(self, obj, dbId)
            Config.Functions.TryToBuy(self, self.item, dbId, function()
                StartWaterVending(self, obj)
                Status.UpdatePlayerStatus({["thirst"] = 20})
            end)
        end
        --#endregion
    },
    ["cigarettes"] = {
        models = {`prop_vend_fags_01`},
        interaction = {
            vanilla = {
                notify = "cigs_int_vanilla",
                distance = 0.4
            },
            target = {
                label = "normal_int_target",
                icon = "fa-solid fa-smoking",
                distance = 3.0
            }
        },
        
        -- For this vending, this will only be used for the menu, it will not create any model
        exhibition = {
            a1 = "cigs_redwood",
            a2 = "cigs_redwood2",
            a3 = "cigs_estancia",
            a4 = "cigs_69brand",
            a5 = "cigs_debonaireb",
            a6 = "cigs_debonaireg",
            b1 = "cigs_cardiaque",
            b2 = "cigs_cok",
        },

        blip = {
            sprite = 205,
            color = 22,
            size = 0.5
        },

        --#region Advanced
        OnInteraction = function(self, obj, dbId)
            local selection = nil

            -- OxLib input dialog
            if lib and Config.UseOxLibMenuIfFound then
                selection = DisplayOxLibMenu(self, obj)
            else
                selection = DisplayInteractiveMenu(self, obj)
            end

            if selection then
                Config.Functions.TryToBuy(self, selection, dbId, function()
                    SelectItemCigarettesVending(self, obj, selection)
                end)
            else
                Server.SetVendingUsed(dbId, false)
            end
        end
        --#endregion
    },
    ["soda_2"] = {
        parent = "soda", -- Vending machines can set a parent vending machine, this allows you to inherit all the other vending settings with the ability to override them
        models = {`prop_vend_soda_02`},
        interaction = {
            vanilla = {
                notify = "normal_int_vanilla",
                distance = 1.0
            },
            target = {
                label = "normal_int_target",
                icon = "fa-solid fa-wine-bottle",
                distance = 3.0
            }
        },

        blip = {
            sprite = 827,
            color = 2,
            size = 0.5
        },

        -- This section is for choosing which items (from the Config.Items list) to show for each individual stand.
        -- You can follow the visual tags on the in-game model to figure out where you are putting things
        exhibition = {
            a1 = "bottle_sprunk",
            a2 = "bottle_sprunk",
            a3 = "bottle_junk",
            a4 = "bottle_junk",
            a5 = "bottle_tonic",
            a6 = "bottle_tonic",

            b1 = "bottle_orang",
            b2 = "bottle_orang",
            b3 = "bottle_cola",
            b4 = "bottle_cola",
            b5 = "bottle_water",
            b6 = "bottle_water",

            c1 = "can_cola",
            c2 = "can_cola",
            c3 = "can_orang",
            c4 = "can_orang",
            c5 = "can_sprunk",
            c6 = "can_junk",

            d1 = "can_logger",
            d2 = "can_logger",
            d3 = "can_blarneys",
            d4 = "can_blarneys",
            d5 = "can_hoplivion",
            d6 = "can_cerbeza",
        },

        --#region Advanced
        Near = function(self, obj, dbId)
            PopulateSodaVending(self, obj, "mxc_vend_prop_soda_shelf2")
        end,
        Far = function(self, obj, dbId)
            ClearSodaVending(self, obj)
        end,
    
        OnInteraction = function(self, obj, dbId)
            local selection = nil

            -- OxLib input dialog
            if lib and Config.UseOxLibMenuIfFound then
                selection = DisplayOxLibMenu(self, obj)
            else
                selection = DisplayInteractiveMenu(self, obj)
            end

            if selection then
                Config.Functions.TryToBuy(self, selection, dbId, function()
                    SelectItemSodaVending(self, obj, selection)
                end)
            else
                Server.SetVendingUsed(dbId, false)
            end
        end
        --#endregion
    },

    -- Require cfx-mxc-smoking (https://store.markz3d.com/checkout/packages/add/6245837/single)
    
    ["svapo"] = {
        parent = "snack", -- Vending machines can set a parent vending machine, this allows you to inherit all the other vending settings with the ability to override them
        models = {`mxc_vend_prop_svapo_01`},

        blip = {
            sprite = 772,
            color = 0,
            size = 0.5
        },

        exhibition = {
            a1 = "sand_evapebox",
            a2 = "grey_evapebox",
            a3 = "pink_smokebox",
            a4 = "red_smokebox",
            b1 = "black_notankatomizer",
            b2 = "grey_shortatomizer",
            b3 = "pink_shortatomizer",
            b4 = "red_shortatomizer",
            c1 = "orange_stickevape",
            c2 = "yellow_stickevape",
            c3 = "blue_stickevape",
            c4 = "green_stickevape",
            d1 = "black_vaporglowvape",
            d2 = "lightgrey_vaporglowvape",
            d3 = "red_vaporglowvape",
            d4 = "pink_vaporglowvape",
            e1 = "orange_sumovape",
            e2 = "green_sumovape",
            e3 = "lightgrey_sumovape",
            e4 = "blue_sumovape",
        },
    },
}
