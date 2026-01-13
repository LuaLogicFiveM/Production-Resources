Config = {}
 
-- @type number (default: 45.0)
-- @description Distance from player to spawn herbs
Config.HerbsSpawnDistance = 45.0

Config.EnableGlowEffect = true -- Enable glow effect on herbs when job is started

-- IF YOU WANT TO CHANGE CHANGING CLOTHES SYSTEM, OPEN dh_lib/frameworks/c.clothing.lua
Config.Clothing = { -- max 3 per gender
    ["mp_m_freemode_01"] = { 
        {
            img = "https://cfx-nui-devhub_herbalAlchemist/html/host/alchemist_m1.png",
            clothes = {
                torso = {95, 1},
                tshirt = { 15, 0 },
                pants = { 90, 0 },
                boots = { 63, 4 },
                gloves = { 26, 0 },
            }
        },
        {
            img = "https://cfx-nui-devhub_herbalAlchemist/html/host/alchemist_m2.png",
            clothes = {
                torso = {95, 0},
                tshirt = { 15, 0 },
                pants = { 90, 5 },
                boots = { 63, 1 },
                gloves = { 26, 0 },
            }
        },
        {
            img = "https://cfx-nui-devhub_herbalAlchemist/html/host/alchemist_m3.png",
            clothes = {
                torso = {95, 2},
                tshirt = { 15, 0 },
                pants = { 90, 8 },
                boots = { 63, 4 },
                gloves = { 26, 0 },
            }
        },
    },
    ["mp_f_freemode_01"] = {
        {
            img = "https://cfx-nui-devhub_herbalAlchemist/html/host/alchemist_f1.png",
            clothes = {
                torso = { 49, 1 },
                tshirt = { 15, 0 },
                pants = { 93, 2 },
                boots = { 66, 4 },
                gloves = { 20, 0 },
            }
        },
        {
            img = "https://cfx-nui-devhub_herbalAlchemist/html/host/alchemist_f2.png",
            clothes = {
                torso = { 49, 2 },
                tshirt = { 15, 0 },
                pants = { 93, 2 },
                boots = { 66, 4 },
                gloves = { 20, 0 },
            }
        },
        {
            img = "https://cfx-nui-devhub_herbalAlchemist/html/host/alchemist_f3.png",
            clothes = {
                torso = { 49, 1 },
                tshirt = { 15, 0 },
                pants = { 93, 5 },
                boots = { 66, 7 },
                gloves = { 20, 0 },
            }
        },
    },
}


Config.Vehicles = { --max 2 vehicles
    -- { -- use it if you want to disable vehicle
    --     model = "none",
    --     price = 0,
    --     img = "https://cfx-nui-devhub_herbalAlchemist/html/host/none.png",
    -- },
    {
        model = "mesa",
        price = 0,
        img = "https://cfx-nui-devhub_herbalAlchemist/html/host/mesa.png",
    },
    {
        model = "freecrawler",
        price = 300,
        img = "https://cfx-nui-devhub_herbalAlchemist/html/host/freecrawler.png",
    },
}
Config.VehiclesSpawnPoints = {
    vec4(1537.0837, 2177.8159, 78.4643, 175.1745),
    vec4(1552.5822, 2193.8521, 78.4341, 357.4615),
    vec4(1558.9625, 2203.4861, 78.4950, 90.5871),
}
 
Config.NotificationsTypes = {
    ["info"] = "https://cfx-nui-devhub_herbalAlchemist/html/host/info.png",
    ["success"] = "https://cfx-nui-devhub_herbalAlchemist/html/host/success.png",
    ["error"] = "https://cfx-nui-devhub_herbalAlchemist/html/host/error.png",
}
 
-- HudPlacement can be a string ("bottom-right", "bottom-left", "top-right", "top-left") or a table for custom position:
-- Example: { left = 10, top = 20, snapTo = "left" } (percentages, snapTo: "left", "right", or "center")
-- You can also use right and/or bottom instead of left/top:
-- { right = 5, bottom = 10, snapTo = "center" }
-- If both left and right (or top and bottom) are set, left/top takes precedence.
Config.HudPlacement = "bottom-right" -- or set to { right = 5, bottom = 10, snapTo = "center" }

Config.MainPed = {
    model = "s_m_m_cntrybar_01",
    coords = vec4(1546.0927, 2166.5562, 78.7278, 89.7710),
    sprite = 140, -- set to false if you don't want blip
    color = 5,
    scale = 0.8,
    name = "Herbal Alchemist Job",
}

Config.Tables = {
    coords = {
        vec4(252.2556, 3096.8608, 42.4300, 7.1345),
        vec4(-313.0403, 6310.4414, 32.4401, 220.8948),
        vec4(150.1079, 1673.3293, 228.7064, 163.2111),
        vec4(2647.0967, 4247.5479, 44.7815, 129.1367),
    },
    sprite = 499, -- set to false if you don't want blip
    color = 5,
    scale = 0.8,
    name = "# Alchemist Table",
}
 

Config.Delivery = {
    vec3(2704.192383, 4330.427734, 45.852066),
    vec3(2728.882080, 4280.732910, 48.961315),
    vec3(2506.640381, 4097.150391, 38.709763),
    vec3(1898.972656, 3781.702393, 32.876133),
    vec3(1705.943237, 3779.885254, 34.747673),
    vec3(1733.340942, 3808.927979, 34.907776),
    vec3(1728.690552, 3851.139160, 34.780903),
    vec3(996.196350, 3575.678223, 34.609524),
    vec3(915.275513, 3567.223633, 33.793461),
    vec3(464.464142, 3564.459473, 33.406940),
    vec3(438.436615, 3570.941650, 33.687546),
    vec3(387.432343, 3585.090576, 33.257294),
    vec3(-324.613647, 2818.339355, 59.447334),
    vec3(-658.356506, 886.946655, 229.247711),
    vec3(-536.682983, 818.659119, 197.510147),
    vec3(-494.247437, 796.014160, 184.342606),
    vec3(128.272888, 341.673798, 111.868561),
    vec3(311.679230, -203.621689, 54.218529),
    vec3(313.412537, -198.548721, 54.221760),
    vec3(315.526031, -195.251862, 54.225384),
    vec3(319.000122, -196.385406, 54.226444),
    vec3(340.297577, -214.799408, 54.216911),
    vec3(339.138947, -219.126984, 54.221764),
    vec3(288.493073, -1095.075806, 29.419228),
    vec3(222.396454, -595.826111, 43.872116),
    vec3(292.448792, -223.184738, 53.880108),
    vec3(252.031418, 358.453217, 105.744194),
    vec3(241.913681, 360.623444, 105.621407),
    vec3(-160.087006, -1432.081177, 31.277819),
    vec3(561.630981, 93.032616, 96.094238)
}

Config.DisableFinishPopup = false -- disable finish popup, if set to true, finish popup will not be shown, it will be replaced with a notification