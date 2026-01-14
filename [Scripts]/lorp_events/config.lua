Config = {}

Config.AnnounceDuration = 15
Config.JoinCooldown = 30
Config.AllowTeleportInVehicle = false
Config.FadeTeleport = true
Config.EventExpiresMinutes = 120
Config.TeleportZOffset = 0.5
Config.Permissions = {
    ['1333507094988455967'] = true, -- Event Team
    ['1082487500871843860'] = true, -- Developer
}

Config.CustomEvents = {
    {
        name = "City Race",
        type = "Race",
        title = "City Race",
        message = "An event has started: City Race",
        startingCoords = vec4(414.4375, 891.6957, 198.0184, 240.9300),
        finishCoords = vec4(500.0, 800.0, 72.0, 180.0),
        allowInVehicle = true,
        carSpawnLocations = {
            { coords = vec4(415.4183, 894.5992, 199.0478, 233.7710), model = "adder" },
            { coords = vec4(407.0, 890.0, 198.0, 240.0), model = "zentorno" },
            { coords = vec4(413.0832, 890.5109, 199.0243, 246.0364), model = "t20" },
            { coords = vec4(422.5084, 884.2517, 198.6075, 62.3834), model = "panto" },
            { coords = vec4(423.9992, 887.9277, 198.6452, 75.8838), model = "panto" },
            { coords = vec4(422.4867, 894.3904, 198.7533, 135.2447), model = "panto" }
        }
    },
    {
        name = "Bumper Cars",
        type = "Race",
        title = "Bumper Cars",
        message = "An event has started: Bumper Cars",
        allowInVehicle = true,
        carSpawnLocations = {
            { coords = vec4(-76.6237, -827.2985, 325.4558, 352.1409), model = "panto" },
            { coords = vec4(-78.9534, -826.5541, 325.4717, 337.8113), model = "panto" },
            { coords = vec4(-81.1028, -825.0906, 325.4551, 321.5036), model = "panto" },
            { coords = vec4(-82.6849, -822.7151, 325.4589, 306.7463), model = "panto" },
            { coords = vec4(-83.4352, -820.2757, 325.4560, 284.9977), model = "panto" },
            { coords = vec4(-83.0792, -817.8262, 325.4555, 261.3376), model = "panto" },
            { coords = vec4(-82.6674, -815.1902, 325.4707, 242.5731), model = "panto" },
            { coords = vec4(-81.0428, -812.9897, 325.4598, 238.6814), model = "panto" },
            { coords = vec4(-79.0152, -811.5387, 325.4480, 210.0714), model = "panto" },
            { coords = vec4(-76.8236, -810.6239, 325.4748, 195.9778), model = "panto" },
            { coords = vec4(-74.3761, -810.6026, 325.4560, 176.5470), model = "panto" },
            { coords = vec4(-70.8111, -811.9886, 325.4610, 154.2144), model = "panto" },
            { coords = vec4(-68.8022, -813.7114, 325.4600, 134.8377), model = "panto" },
            { coords = vec4(-67.4360, -815.7789, 325.4638, 111.4762), model = "panto" },
            { coords = vec4(-66.8537, -818.0182, 325.4560, 99.1455), model = "panto" },
            { coords = vec4(-67.1121, -821.3698, 325.4558, 72.6259), model = "panto" },
            { coords = vec4(-68.3396, -823.9586, 325.4573, 56.3516), model = "panto" },
            { coords = vec4(-70.0105, -825.8576, 325.4760, 42.6220), model = "panto" },
            { coords = vec4(-72.0588, -827.1730, 325.4922, 22.7735), model = "panto" },
            { coords = vec4(-74.3692, -827.2643, 325.4628, 11.1112), model = "panto" }
        }
    },
    {
        name = "Chiliad Bike Race",
        type = "Race",
        title = "Chiliad Bike Race",
        message = "An event has started: Chiliad Bike Race",
        startingCoords = vec4(-713.5214, 5539.1797, 37.2551, 219.5563),
        finishCoords = vec4(501.2640, 5598.3770, 796.0476, 330.9552),
        allowInVehicle = true,
        carSpawnLocations = {
            { coords = vec4(-721.1680, 5539.1768, 36.4960, 212.8322), model = "sanchez" },
            { coords = vec4(-719.5435, 5540.0776, 36.5471, 212.2487), model = "sanchez" },
            { coords = vec4(-718.4134, 5541.3608, 36.6177, 209.4586), model = "sanchez" },
            { coords = vec4(-717.1396, 5542.0249, 36.6670, 192.3283), model = "sanchez" },
            { coords = vec4(-715.8437, 5542.8047, 36.7143, 209.3898), model = "sanchez" },
            { coords = vec4(-714.4452, 5543.8291, 36.7547, 206.6313), model = "sanchez" },
            { coords = vec4(-713.1564, 5544.9658, 36.8116, 209.1833), model = "sanchez" },
            { coords = vec4(-711.6197, 5545.9937, 36.8953, 206.2972), model = "sanchez" },
            { coords = vec4(-710.3666, 5547.1499, 36.9309, 212.1550), model = "sanchez" },
            { coords = vec4(-709.0970, 5547.8145, 36.9981, 215.4146), model = "sanchez" },
            { coords = vec4(-708.1476, 5548.7954, 37.0180, 206.9376), model = "sanchez" },
            { coords = vec4(-706.6476, 5549.6582, 37.0877, 198.9056), model = "sanchez" },
            { coords = vec4(-705.5934, 5550.9663, 37.0930, 202.6464), model = "sanchez" },
            { coords = vec4(-703.8194, 5551.7588, 37.1766, 209.5110), model = "sanchez" },
            { coords = vec4(-702.4710, 5552.6694, 37.2216, 216.6621), model = "sanchez" }
        }
    },
    {
        name = "Slasher",
        type = "Default",
        title = "Slasher",
        message = "An event has started: Slasher",
        coords = vec4(-2311.5491, 245.6418, 169.6019, 207.7972)
    },
    {
        name = "Red Light Green Light",
        type = "Default",
        title = "Red Light Green Light",
        message = "An event has started: Red Light Green Light",
        coords = vec4(-2034.3173, 2873.9758, 32.8104, 58.6415)
    },
    {
        name = "Hide & Seek",
        type = "Default",
        title = "Hide & Seek",
        message = "An event has started: Hide & Seek",
        coords = vec4(34.3629, -1.5120, 939.7014, 86.3564)
    }
}
