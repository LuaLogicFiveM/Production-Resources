lib.locale()

Config = Config or {}

Config.RebreatherDuration = 900 -- Duration in seconds (default: 900 = 15 minutes)

Config.DivingPed = {
    coords = vec4(3367.0, 5184.5, 0.5, 238.3),
    model = `a_m_y_salton_01`,
}

Config.Seashark = {
    price = 500,
    model = `seashark`,
    coords = vec4(3372.2, 5185.6, -1.1, 263.5)
}

Config.DivingLocations = {
    {
        flareCoords = vector3(-429.8, 7212.6, -0.2),
        objects = {
            {
                coords = vec4(-524.6,7200.8,-19.5,70.4),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vec4(-498.8,7197.7,-16.8,316.2),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vec4(-476.0,7208.7,-32.7,124.6),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(-385.5, 7243.8, 0.2),
        objects = {
            {
                coords = vec4(-427.6,7200.5,-45.1,323.4),
                model = `prop_rub_t34`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vec4(-427.6,7216.1,-44.7,358.1),
                model = `prop_rub_railwreck_3`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vec4(-427.0,7235.2,-43.7,178.9),
                model = `prop_rub_railwreck_2`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(-2761.2, 4250.0, -2.4),
        objects = {
            {
                coords = vec4(-2775.5,4217.0,-31.0,9.4),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vec4(-2776.9,4209.4,-30.8,33.6),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vec4(-2768.2,4221.2,-30.2,54.6),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(2851.227, -2130.675, -0.578),
        objects = {
            {
                coords = vector4(2836.196, -2122.389, -47.583, 59.721),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(2870.514, -2193.323, -41.001, 179.166),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(2885.380, -2138.695, -49.126, 320.682),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(2259.116, -2793.700, -0.513),
        objects = {
            {
                coords = vector4(2231.049, -2804.402, -49.434, 173.566),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(2209.612, -2815.730, -52.272, 76.224),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(2196.559, -2799.662, -48.628, 74.939),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(3403.828, -505.317, -0.548),
        objects = {
            {
                coords = vector4(3382.073, -496.461, -37.218, 72.890),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(3371.653, -530.012, -25.247, 65.952),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(3367.223, -462.644, -44.647, 80.822),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(3272.032, 962.905, -0.530),
        objects = {
            {
                coords = vector4(3242.550, 992.992, -42.596, 29.507),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(3254.128, 969.413, -42.938, 151.763),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(3213.693, 971.483, -41.442, 347.339),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(3703.873, 2089.796, -0.503),
        objects = {
            {
                coords = vector4(3708.161, 2121.535, -38.142, 286.434),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(3684.874, 2100.529, -34.989, 29.914),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(3717.850, 2119.699, -41.531, 295.725),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
    {
        flareCoords = vector3(-3371.935, 2230.797, -0.525),
        objects = {
            {
                coords = vector4(-3339.673, 2264.701, -55.467, 262.444),
                model = `prop_rub_carwreck_17`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(-3351.687, 2247.673, -50.115, 245.180),
                model = `prop_rub_carwreck_10`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
            {
                coords = vector4(-3378.264, 2244.615, -55.166, 70.375),
                model = `prop_rub_carwreck_8`,
                dropTable = "car_medium",
                search = true,
                searchTime = 5000,
            },
        },
    },
}

Config.BlipRadius = 500.0
Config.FlareDistance = 2000.0
Config.ObjectDistance = 100.0