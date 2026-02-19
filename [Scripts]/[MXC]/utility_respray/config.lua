Config = {}
Config.Debug = false

Config.RenderDistance = 40.0

Config.UseOxLibMenuIfFound = false -- set to false if you don't want to use OxLib if found
Config.Target = true -- set to true if you want to use ox-target or qb-target as interaction
Config.CustomTargetResource = "" -- if you have a custom target resource name set it here

Config.Translations = {
    -- OxLib Menus
    ["menu_title"]           = "Respray",
    ["menu_choose_color"]    = {text = "Choose a color", icon = ""},
    ["menu_choose_material"] = {text = "Choose a material", icon = ""},
    ["menu_choose_zone"]     = {text = "Choose a painting zone", icon = ""},

    ["menu_customcolor_title"]  = "Custom color",
    ["menu_customcolor_choose"] = "Choose a Color",

    ["menu_notify_goback"] = "~INPUT_FRONTEND_PAUSE_ALTERNATE~ Back",
    ["menu_notify_confirm"] = "~INPUT_FRONTEND_ACCEPT~ Confirm selection",
    ["menu_notify_chameleon_page"] = "Page ~y~%d/%d~w~",
    
    -- Interactions
    ["interaction_clean"] = {
        native = {
            notify = "Press {E} to pickup the cleaning kit",
        },
        target = {
            label = "Clean",
            icon = "fa-solid fa-hand-sparkles",
        }
    },
    ["interaction_clean_holded"] = {
        native = {
            notify = "Press {E} to drop the cleaning kit",
        },
        target = {
            label = "Drop the cleaning kit",
            icon = "fa-solid fa-xmark",
        }
    },
    ["interaction_spraygun"] = {
        native = {
            notify = "Press {E} to start spraying",
        },
        target = {
            label = "Spray gun",
            icon = "fa-solid fa-spray-can",
        }
    },
    ["interaction_spraygun_holded"] = {
        native = {
            notify = "Press {E} to drop the spraygun",
        },
        target = {
            label = "Drop the spraygun",
            icon = "fa-solid fa-xmark",
        }
    },

    ["paint_progress"] = {
        label = "PROGRESS",
        color = {66, 135, 245},
        offset = -0.01
    },

    ["cleanness"] = {
        label = "CLEANNESS",
        color = {66, 135, 245},
        offset = -0.01
    },

    -- Colors
    ["custom_color"] = "Custom color",
    ["white"]        = "White",
    ["gray"]         = "Gray",
    ["black"]        = "Black",
    ["yellow"]       = "Yellow",
    ["orange"]       = "Orange",
    ["red"]          = "Red",
    ["brown"]        = "Brown",
    ["light_green"]  = "Light Green",
    ["green"]        = "Green",
    ["dark_green"]   = "Dark Green",
    ["dark_blue"]    = "Dark Blue",
    ["sky_blue"]     = "Sky Blue",
    ["pink"]         = "Pink",
    ["violet"]       = "Violet",

    -- Chameleon colors
    ["anodized_red"] = "Anodized Red",
    ["anodized_wine"] = "Anodized Wine",    
    ["anodized_purple"] = "Anodized Purple",
    ["anodized_green"] = "Anodized Green",
    ["anodized_copper"] = "Anodized Copper",
    ["anodized_champagne"] = "Anodized Champagne",
    ["green_blue_flip"] = "Green Blue Flip",
    ["green_brown_flip"] = "Green Brown Flip",
    ["green_turqoise_flip"] = "Green Turqoise Flip",
    ["turqoise_purple_flip"] = "Turqoise Purple Flip",
    ["cyan_purple_flip"] = "Cyan Purple Flip",

    ["blue_green_flip"] = "Blue Green Flip",
    ["purple_green_flip"] = "Purple Green Flip",
    ["burgundy_green_flip"] = "Burgundy Green Flip",
    ["magenta_cyan_flip"] = "Magenta Cyan Flip",
    ["red_orange_flip"] = "Red Orange Flip",
    ["orange_purple_flip"] = "Orange Purple Flip",
    ["orange_blue_flip"] = "Orange Blue Flip",
    ["white_purple_flip"] = "White Purple Flip",
    ["red_rainbow_flip"] = "Red Rainbow Flip",
    ["dark_teal_pearl"] = "Dark Teal Pearl",
    ["light_blue_pearl"] = "Light Blue Pearl",
    ["pink_pearl"] = "Pink Pearl",
    ["yellow_pearl"] = "Yellow Pearl",
    ["white_prismatic"] = "White Prismatic",
    ["hot_pink_prismatic"] = "Hot Pink Prismatic",
    ["dark_red_prismatic"] = "Dark Red Prismatic",
    ["black_prismatic"] = "Black Prismatic",
    ["black_rainbow"] = "Black Rainbow",
    ["white_holographic"] = "White Holographic",

    -- Painting zones
    ["painting_zone_primary"] = "Primary",
    ["painting_zone_secondary"] = "Secondary",

    -- Materials
    ["metallic"]     = "Metallic",
    ["matte"]        = "Matte",
    ["pearlescent"]  = "Pearlescent",
    ["chrome"]       = "Chrome",
    ["chameleon"]    = "Chameleon"
}

Config.TablesPositions = {
    { coords = vec4(961.0093, -1557.8968, 29.7377, 0.0), filter = {} }, -- 796
    { coords = vec4(-1096.1788, -2119.2173, 12.2618, 226.5), filter = {} }, -- 887
    { coords = vec4(-1134.1945, -1624.1544, 3.4070, 210.4108), filter = {} }, -- 693
    { coords = vec4(-2078.8162, -518.7609, 11.1137, 51.4248), filter = {} }, -- 685
    { coords = vec4(1152.8954, -778.9376, 56.6026, 270.2139), filter = {} }, -- 574
    { coords = vec4(2525.2537, 2621.1089, 36.9455, 269.0433), filter = {} }, -- 334
    { coords = vec4(2737.8997, 4919.1147, 32.6912, 224.5463), filter = {} }, -- 099
    { coords = vec4(-36.2547, -1084.7091, 25.4223, 340.00), filter = { ["angline"] = 0 } }, -- 745
    { coords = vec4(1184.7472, 2636.8674, 36.7954, 266.8470), filter = {} }, -- 260
    { coords = vec4(1041.5791, -2538.7527, 27.3211, 354.7576), filter = {} }, -- 804
    { coords = vec4(187.3997, 2765.0757, 42.5231, 187.4371), filter = {} }, -- 228
    { coords = vec4(-457.2433, 284.5305, 82.2504, 83.0946), filter = {} }, -- 489
    { coords = vec4(-1656.7290, -770.3990, 9.1925, 229.3626), filter = {} }, -- 752
    { coords = vec4(-1139.0925, -1620.5831, 3.4070, 121.8766), filter = {} }, -- 693
    { coords = vec4(-1174.6620, -1157.2339, 4.6509, 285.2619), filter = {} }, -- 698
    { coords = vec4(90.8642, 3742.9578, 39.7691, 248.9484), filter = {} }, -- obs
    { coords = vec4(-205.7636, 6237.5725, 30.4992, 136.0929), filter = {} }, -- 044
    { coords = vec4(2426.7227, 5001.9150, 45.9615, 304.0), filter = {} }, -- 106
    { coords = vec4(2011.1100, 4602.7446, 40.3754, 25.6498), filter = {} }, -- 111 
    { coords = vec4(1443.6780, 1721.5457, 109.9059, 25.7544), filter = {} }, -- 542
    { coords = vec4(-755.3536, 5891.8491, 15.8444, 329.3372), filter = {} }, -- 013
    { coords = vec4(1418.9443, 1062.6995, 113.3971, 1.0507), filter = {} }, -- 539
    { coords = vec4(-718.2316, -2496.2432, 12.9456, 64.1125), filter = {} }, -- 905
    { coords = vec4(855.4703, -178.6743, 71.7214, 326.0527), filter = {} }, -- 588
    { coords = vec4(675.5851, 152.2864, 79.7715, 158.0381), filter = {} }, -- 592
    { coords = vec4(1330.5192, 2622.2671, 36.2984, 213.1328), filter = {} }, -- 262
    { coords = vec4(-323.1643, 710.2231, 203.6039, 305.3851-180.0), filter = {} }, -- 486
    { coords = vec4(163.5526, 673.3506, 209.9281, 354.6280-180.0), filter = {} }, -- 506
    { coords = vec4(-1877.3912, 638.3139, 128.9979, 315.0934), filter = {} }, -- 444
    { coords = vec4(-265.4777, 6152.1064, 30.5006, 233.9390-180.0), filter = {} }, -- 839
    { coords = vec4(721.9004, 4179.7788, 39.9043, 215.4093), filter = {} }, -- 141
    { coords = vec4(-2015.9548, 450.1020, 101.6761, 199.9311), filter = {} }, -- 221
    { coords = vec4(1330.5277, 2622.0615, 38.2984, 213.7786), filter = {} }, -- 262
    { coords = vec4(-667.0491, -886.5808, 23.5102, 180.0799), filter = {} }, -- 726
}