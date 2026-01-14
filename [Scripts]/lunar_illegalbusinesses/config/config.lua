Config = {}

Config.overlayPosition = 'bottom: 2.5rem; right: 2.5rem;' -- CSS properties
Config.maxBusinessesPerPlayer = 5 -- Set to a number to limit it
Config.currency = { symbol = '$', icon = 'dollar-sign' } -- Fontawesome icon

-- The ped that sells the businesses
Config.ped = {
    model = `g_m_m_armboss_01`,
    -- The label should be in locales
    accounts = { 
        { name = 'money', icon = 'sack-dollar' },
        { name = 'bank', icon = 'building-columns' }
    },
    sell = {
        divisor = 2, -- You'll sell the business only for 50% of the original price
        account = 'money'
    },
    locations = {
        vector4(967.1998, -1858.5847, 31.1969, 88.2020)
    },
    prohibitedJobs = {
        ['sheriff'] = true,
        ['sahp'] = true,
        ['safd'] = true,
        ['ems'] = true,
    }
}

---@class BlipData
---@field name string
---@field sprite integer
---@field size number
---@field color integer

---@class LocationData
---@field price integer
---@field type string
---@field image string?
---@field coords vector4
---@field target vector3
---@field vehicleSpawn vector4 Vehicles for mission will be spawned here
---@field camera vector4
---@field spawnCamera boolean?

-- The businesses
-- Images can be found in web/build/images 
-- The prices are based on the distance to the sandy and grapeseed airports because all sell missions require you to go there
-- =============================================================
-- sandy/grapeseed = most expensive
-- paleto = less expensive but still not cheap
-- los santos = the cheapest option but far from the airports mentioned above
-- ============================================================= 
---@type table<string, LocationData>
Config.locations = { -- make a new line here and paste after 
    ['aiden1'] = {--634
        price = 1385,
        type = 'counterfeit_factory', -- player: voxzk
        image = './images/businesses/30.png',
        coords = vector4(-500.6726, -18.8656, 45.1275, 186.4689+180.0), -- dont delete the +180.0
        target = vector3(-500.6726, -18.8656, 45.1275),
        vehicleSpawn = vector4(-500.3089, -5.6105, 44.9299, 59.4623),
        camera = vector4(-515.6034, -12.1847, 49.9350, 248.0397),
        spawnCamera = false
    },
    ['drewski1'] = {--850
        price = 1872,
        type = 'weed', -- player: drewski1234566._11602
        image = './images/businesses/29.png',
        coords = vector4(-502.6172, 32.6049, 44.7177, 346.8235+180.0), -- dont delete the +180.0
        target = vector3(-502.6172, 32.6049, 44.7177),
        vehicleSpawn = vector4(-486.8703, 18.8925, 45.0875, 86.8251),
        camera = vector4(-500.2617, 23.6885, 50.4425, 31.6728),
        spawnCamera = false
    },
    ['boogie1'] = {--850
        price = 9667,
        type = 'meth', -- player: imjustboogie
        image = './images/businesses/28.png',
        coords = vector4(-43.4032, -1231.5653, 29.3350, 92.3430+180.0), -- dont delete the +180.0
        target = vector3(-43.4032, -1231.5653, 29.3350),
        vehicleSpawn = vector4(-38.9239, -1218.3311, 29.3348, 178.8583),
        camera = vector4(-19.9976, -1235.0757, 31.7918, 71.9486),
        spawnCamera = false
    },
    ['leechan1'] = {--573
        price = 9999,
        type = 'coke', -- player: recruitgod
        image = './images/businesses/27.png',
        coords = vector4(1199.6064, -501.6016, 65.1777, 296.2765+180.0), -- dont delete the +180.0
        target = vector3(1199.6064, -501.6016, 65.1777),
        vehicleSpawn = vector4(1191.0175, -490.9723, 65.5544, 344.4029),
        camera = vector4(1215.0270, -515.1179, 70.7888, 54.2597),
        spawnCamera = false
    },
    ['rylan2'] = {--778
        price = 9999,
        type = 'meth', -- player: rylan_IS__SICk093
        image = './images/businesses/35.png',
        coords = vector4(1705.0463, -1637.6635, 112.4943, 102.8059+180.0), -- dont delete the +180.0
        target = vector3(1705.0463, -1637.6635, 112.4943),
        vehicleSpawn = vector4(1719.9717, -1655.5321, 112.4975, 200.8399),
        camera = vector4(1729.2395, -1648.2386, 118.0411, 93.5447),
        spawnCamera = false
    },
    ['rylan1'] = {--928
        price = 9999,
        type = 'coke', -- player: rylan_IS__SICk093
        image = './images/businesses/34.png',
        coords = vector4(269.3394, -3248.3572, 5.7903, 97.7891+180.0), -- dont delete the +180.0
        target = vector3(269.3394, -3248.3572, 5.7903),
        vehicleSpawn = vector4(289.2775, -3256.0830, 5.6346, 342.4877),
        camera = vector4(282.0652, -3258.2969, 12.7454, 27.3178),
        spawnCamera = false
    },
    ['grapeseed5'] = {--115
        price = 2133,
        type = 'coke',
        image = './images/businesses/26.png',
        coords = vector4(1700.3221, 4816.4277, 41.9382, 35.5802),
        target = vector3(1700.3221, 4816.4277, 41.9382),
        vehicleSpawn = vector4(1677.3284, 4818.5698, 42.0126, 10.4523),
        camera = vector4(1709.8424, 4816.2783, 44.9635, 93.3354),
        spawnCamera = false
    },
    ['pancake1'] = {--591
        price = 1000,
        type = 'weed',
        image = './images/businesses/31.png',
        coords = vector4(814.1260, -109.4221, 80.6046, 251.9425+180.0),
        target = vector3(814.1260, -109.4221, 80.6046),
        vehicleSpawn = vector4(829.5580, -89.3533, 80.5407, 264.5245),
        camera = vector4(804.7025, -115.4366, 83.3982, 293.1461),
        spawnCamera = false
    },
    --[[['rzizzs1'] = {--591
        price = 25000,
        type = 'coke', -- player: rzizzs
        image = './images/businesses/33.png',
        coords = vector4(814.9410, -109.4809, 80.6025, 240.9051+180.0), -- dont delete the +180.0
        target = vector3(814.9410, -109.4809, 80.6025),
        vehicleSpawn = vector4(827.7505, -88.5806, 80.5239, 237.9184),
        camera = vector4(803.7852, -116.1438, 84.9256, 300.2721),
        spawnCamera = false
    },]]
    ['johnnymoonshine1'] = {--588
        price = 1000,
        type = 'weed',
        image = './images/businesses/33.png',
        coords = vector4(880.0206, -205.2006, 71.9764, 295.5441+180.0),
        target = vector3(880.0206, -205.2006, 71.9764),
        vehicleSpawn = vector4(872.0200, -215.2095, 70.0613, 242.0746),
        camera = vector4(864.5244, -205.2921, 78.0238, 256.0201),
        spawnCamera = false
    },
    ['Pjoe1'] = {--798
        price = 1000,
        type = 'meth',
        image = './images/businesses/50.png',
        coords = vector4(967.7389, -1867.1587, 31.4452, 358.9318+180.0),
        target = vector3(967.7389, -1867.1587, 31.4452),
        vehicleSpawn = vector4(967.9517, -1874.7338, 31.1593, 217.6080),
        camera = vector4(937.5585, -1890.2771, 34.1611, 296.4705),
        spawnCamera = false
    },
    ['hatez2'] = {--356
        price = 25000,
        type = 'weed', -- player: hatez.
        image = './images/businesses/28.png',
        coords = vector4(101.3512, 3652.6804, 40.4154, 91.4772+180.0), -- dont delete the +180.0
        target = vector3(101.3512, 3652.6804, 40.4154),
        vehicleSpawn = vector4(100.0307, 3621.1174, 39.7406, 92.0147),
        camera = vector4(132.8044, 3640.6584, 42.6869, 75.8524),
        spawnCamera = false
    },
    ['hatez1'] = {--356
        price = 25000,
        type = 'document_forgery', -- player: hatez.
        image = './images/businesses/27.png',
        coords = vector4(13.3768, 3732.3486, 39.6782, 144.2826+180.0), -- dont delete the +180.0
        target = vector3(13.3768, 3732.3486, 39.6782),
        vehicleSpawn = vector4(30.6643, 3720.4717, 39.7180, 180.2850),
        camera = vector4(22.9049, 3742.8030, 42.1225, 126.4437),
        spawnCamera = false
    },
    ['threefivesix'] = {--356
        price = 25000,
        type = 'coke', -- Player: Jerf
        image = './images/businesses/4.png',
        coords = vector4(2355.9924, 2564.4678, 47.0976, 210.2672+180.0),
        target = vector3(2355.9924, 2564.4678, 47.0976),
        vehicleSpawn = vector4(2356.7996, 2574.5715, 46.6605, 262.9734),
        camera = vector4(2361.1616, 2581.2424, 54.6394, 226.4258),
        spawnCamera = false
    },
    ['pauly1'] = {--303
        price = 1111,
        type = 'weed', -- discord: paulyg803
        image = './images/businesses/24.png',
        coords = vector4(2179.0032, 3496.4883, 46.0015, 205.5482+180.0), -- dont delete the +180.0
        target = vector3(2179.0032, 3496.4883, 46.0015),
        vehicleSpawn = vector4(2168.9321, 3509.9412, 45.4521, 64.1925),
        camera = vector4(2182.0713, 3503.7659, 48.0357, 131.5967),
        spawnCamera = false
    },
    ['mason1'] = {--317
        price = 1481,
        type = 'coke', -- discord: mason220727
        image = './images/businesses/23.png',
        coords = vector4(2455.8013, 4058.1619, 38.0647, 66.2617+180.0), -- dont delete the +180.0
        target = vector3(2455.8013, 4058.1619, 38.0647),
        vehicleSpawn = vector4(2466.3694, 4055.2869, 37.5620, 159.3052),
        camera = vector4(2470.0447, 4067.7429, 42.6020, 118.8599),
        spawnCamera = false
    },
    --[[ ['kashhkhalil1'] = {--635
        price = 1284,
        type = 'weed', -- discord: kashhkhalil_42347
        image = './images/businesses/22.png',
        coords = vector4(-423.5766, 22.7602, 46.2700, 352.3651+180.0), -- dont delete the +180.0
        target = vector3(-423.5766, 22.7602, 46.2700),
        vehicleSpawn = vector4(-428.2789, 12.0837, 46.1623, 85.8133),
        camera = vector4(-438.2438, -13.6391, 52.3276, 337.3752),
        spawnCamera = false
    },]]--
    ['mikee1'] = {--403
        price = 1487,
        type = 'coke', -- discord: mikee8617
        image = './images/businesses/21.png',
        coords = vector4(-1122.9838, 2682.3899, 18.7219, 35.6203+180.0), -- dont delete the +180.0
        target = vector3(-1122.9838, 2682.3899, 18.7219),
        vehicleSpawn = vector4(-1148.5131, 2643.8252, 16.4187, 130.7809),
        camera = vector4(-1116.6495, 2684.3301, 22.2980, 134.5085),
        spawnCamera = false
    },
    ['chxstin1'] = {--227
        price = 1348,
        type = 'meth', -- discord: _vur
        image = './images/businesses/20.png',
        coords = vector4(256.1331, 2585.7144, 44.9193, 288.3677+180.0), -- dont delete the +180.0
        target = vector3(256.1331, 2585.7144, 44.9193),
        vehicleSpawn = vector4(235.7713, 2591.7869, 45.1907, 18.8973),
        camera = vector4(241.4077, 2588.9919, 51.8685, 257.9935),
        spawnCamera = false
    },
    ['perc1'] = {--090
        price = 1258,
        type = 'coke', -- discord: nvxt
        image = './images/businesses/19.png',
        coords = vector4(2515.9390, 4203.2944, 39.9973, 53.7723+180.0), -- dont delete the +180.0
        target = vector3(2515.9390, 4203.2944, 39.9973),
        vehicleSpawn = vector4(2513.7407, 4189.5176, 39.9000, 232.8720),
        camera = vector4(2546.8042, 4176.7603, 44.4903, 56.5773),
        spawnCamera = false
    },
    ['s1ck2'] = {--235
        price = 1284,
        type = 'weed', -- discord: S1cK M1nDs
        image = './images/businesses/25.png',
        coords = vector4(464.3649, 3565.0574, 33.2386, 166.2952+180.0), -- dont delete the +180.0
        target = vector3(464.3649, 3565.0574, 33.2386),
        vehicleSpawn = vector4(470.1375, 3571.5132, 33.2386, 301.1889),
        camera = vector4(491.8925, 3593.1963, 45.1093, 137.6922),
        spawnCamera = false
    },
    ['s1ck1'] = {--235
        price = 1284,
        type = 'coke', -- discord: S1cK M1nDs
        image = './images/businesses/18.png',
        coords = vector4(470.7968, 3552.4954, 33.2385, 339.1331+180.0), -- dont delete the +180.0
        target = vector3(470.7968, 3552.4954, 33.2385),
        vehicleSpawn = vector4(474.8401, 3571.8452, 33.2386, 33.1517),
        camera = vector4(478.9414, 3542.2207, 41.5272, 43.8941),
        spawnCamera = false
    },
    ['mac2'] = {--251
        price = 1284,
        type = 'coke', -- discord: chandler.mac
        image = './images/businesses/15.png',
        coords = vector4(909.6240, 3554.8650, 33.8172, 13.6906+180.0), -- dont delete the +180.0
        target = vector3(909.6240, 3554.8650, 33.8172),
        vehicleSpawn = vector4(925.0610, 3550.9041, 34.0004, 195.9205),
        camera = vector4(936.6091, 3550.5244, 43.7067, 56.5391),
        spawnCamera = false
    },
    ['mac1'] = {--251
        price = 1284,
        type = 'counterfeit_factory', -- discord: chandler.mac
        image = './images/businesses/14.png',
        coords = vector4(916.4128, 3576.9165, 33.5574, 88.5357+180.0), -- dont delete the +180.0
        target = vector3(916.4128, 3576.9165, 33.5574),
        vehicleSpawn = vector4(925.3199, 3585.8516, 33.3804, 186.5187),
        camera = vector4(937.1685, 3550.5771, 41.7729, 43.0288),
        spawnCamera = false
    },
    ['trent2'] = {--244
        price = 1552,
        type = 'weed', -- discord: EBK|Trent Storm
        image = './images/businesses/17.png',
        coords = vector4(569.3591, 2796.6536, 42.0182, 97.8307+180.0), -- dont delete the +180.0
        target = vector3(569.3591, 2796.6536, 42.0182),
        vehicleSpawn = vector4(566.1022, 2808.8457, 42.1436, 278.6181),
        camera = vector4(578.8405, 2790.5601, 48.8216, 53.0492),
        spawnCamera = false
    },
    ['trent1'] = {--244
        price = 1552,
        type = 'coke', -- discord: EBK|Trent Storm
        image = './images/businesses/13.png',
        coords = vector4(591.9299, 2782.7888, 43.4805, 182.6316+180.0), -- dont delete the +180.0
        target = vector3(591.9299, 2782.7888, 43.4805),
        vehicleSpawn = vector4(584.9175, 2792.3594, 42.1306, 30.7062),
        camera = vector4(580.1812, 2790.3403, 48.3625, 239.1903),
        spawnCamera = false
    },
    ['bstock2'] = {--242
        price = 1284,
        type = 'meth', -- discord: Bstock32
        image = './images/businesses/16.png',
        coords = vector4(564.2842, 2598.6985, 43.7709, 280.1168+180.0), -- dont delete the +180.0
        target = vector3(564.2842, 2598.6985, 43.7709),
        vehicleSpawn = vector4(545.6614, 2599.7378, 42.7774, 82.6984),
        camera = vector4(548.8065, 2613.1025, 51.4863, 225.7990),
        spawnCamera = false
    },
    ['bstock1'] = {--242
        price = 1284,
        type = 'weed', -- discord: Bstock32
        image = './images/businesses/12.png',
        coords = vector4(550.5372, 2656.0254, 42.2221, 8.1261+180.0), -- dont delete the +180.0
        target = vector3(550.5372, 2656.0254, 42.2221),
        vehicleSpawn = vector4(524.3002, 2657.5857, 42.4555, 6.8688),
        camera = vector4(542.1031, 2647.6831, 50.3944, 324.6874),
        spawnCamera = false
    },
    ['devine1'] = {--666
        price = 1245,
        type = 'coke', -- discord: DevinePlayerTTV
        image = './images/businesses/50.png',
        coords = vector4(-1492.8135, -149.7849, 52.5093, 213.4877+180.0), -- dont delete the +180.0
        target = vector3(-1492.8135, -149.7849, 52.5093),
        vehicleSpawn = vector4(-1493.3436, -138.4260, 52.0300, 313.4103),
        camera = vector4(-1534.1299, -138.2942, 61.2785, 244.3719),
        spawnCamera = false
    },
    ['colby2'] = {--371
        price = 1566,
        type = 'counterfeit_factory', -- discord: | EBK | Colby M.
        image = './images/businesses/11.png',
        coords = vector4(823.2893, 2365.3501, 52.4682, 253.2747+180.0), -- dont delete the +180.0
        target = vector3(823.2893, 2365.3501, 52.4682),
        vehicleSpawn = vector4(808.2467, 2352.0332, 49.9436, 156.4808),
        camera = vector4(814.3646, 2349.0732, 56.4573, 346.1579),
        spawnCamera = false
    },
    ['colby1'] = {--371
        price = 1566,
        type = 'coke', -- discord: | EBK | Colby M.
        image = './images/businesses/49.png',
        coords = vector4(849.6403, 2383.3684, 54.1626, 41.3769+180.0), -- dont delete the +180.0
        target = vector3(849.6403, 2383.3684, 54.1626),
        vehicleSpawn = vector4(849.2122, 2404.0479, 52.8398, 75.3716),
        camera = vector4(882.2467, 2366.0764, 62.0709, 71.5833),
        spawnCamera = false
    },
    --[[['lyric2'] = {--230
        price = 1582,
        type = 'coke', -- discord: $lyric$
        image = './images/businesses/48.png',
        coords = vector4(163.1537, 3119.4902, 43.4260, 13.5978+180.0), -- dont delete the +180.0
        target = vector3(163.1537, 3119.4902, 43.4260),
        vehicleSpawn = vector4(173.2233, 3107.9692, 42.2136, 277.1328),
        camera = vector4(152.1779, 3077.0012, 53.2294, 337.3684),
        spawnCamera = false
    },
    ['lyric1'] = {--239
        price = 1582,
        type = 'weed', -- discord: $lyric$
        image = './images/businesses/47.png',
        coords = vector4(412.3849, 2965.2747, 41.8880, 229.5978+180.0), -- dont delete the +180.0
        target = vector3(412.3849, 2965.2747, 41.8880),
        vehicleSpawn = vector4(394.6637, 2966.0471, 40.9200, 128.7773),
        camera = vector4(401.2860, 2982.0525, 47.4715, 197.5788),
        spawnCamera = false
    },]]
    ['lucas2'] = {--722
        price = 1789,
        type = 'meth', -- discord: oooggaaaadog69420
        image = './images/businesses/46.png',
        coords = vector4(-703.2158, -1179.4048, 10.6094, 300.3756+180.0), -- dont delete the +180.0
        target = vector3(-703.2158, -1179.4048, 10.6094),
        vehicleSpawn = vector4(-715.7423, -1178.1847, 10.6062, 40.8050),
        camera = vector4(-726.8048, -1180.2883, 16.7801, 274.8061),
        spawnCamera = false
    },
    ['lucas1'] = {--723
        price = 1789,
        type = 'coke', -- discord: oooggaaaadog69420
        image = './images/businesses/46.png',
        coords = vector4(-684.4923, -1198.6235, 10.7111, 312.1858+180.0), -- dont delete the +180.0
        target = vector3(-684.4923, -1198.6235, 10.7111),
        vehicleSpawn = vector4(-674.6268, -1209.4734, 10.6095, 138.7894),
        camera = vector4(-698.8499, -1213.1617, 16.0905, 324.5305),
        spawnCamera = false
    },
    --[[['crazy1'] = {--770
        price = 1323,
        type = 'weed', -- player: crazyreward275
        image = './images/businesses/45.png',
        coords = vector4(872.6320, -1075.2849, 29.1049, 347.8904+180.0), -- dont delete the +180.0
        target = vector3(872.6320, -1075.2849, 29.1049),
        vehicleSpawn = vector4(863.9766, -1080.4570, 28.5556, 85.6609),
        camera = vector4(895.3688, -1080.2482, 40.2472, 104.8019),
        spawnCamera = false
    },]]
    ['wide1'] = {--857
        price = 1568,
        type = 'coke', -- player: that_wide_obs
        image = './images/businesses/44.png',
        coords = vector4(-10.0310, -1827.8699, 25.3809, 321.1669+180.0), -- dont delete the +180.0
        target = vector3(-10.0310, -1827.8699, 25.3809),
        vehicleSpawn = vector4(-19.3723, -1831.0779, 25.5242, 54.6916),
        camera = vector4(-12.8159, -1849.8656, 31.1921, 359.2151),
        spawnCamera = false
    },
    ['kfc2'] = {--623
        price = 1222,
        type = 'counterfeit_factory', -- player: KFC (dora.2679)
        image = './images/businesses/43.png',
        coords = vector4(-59.5445, 185.3235, 87.4008, 218.1019+180.0), -- dont delete the +180.0
        target = vector3(-59.5445, 185.3235, 87.4008),
        vehicleSpawn = vector4(-79.5790, 181.7011, 87.5501, 108.7230),
        camera = vector4(-85.6668, 195.5247, 92.9675, 223.7381),
        spawnCamera = false
    },
    ['kfc1'] = {--623
        price = 1111,
        type = 'coke', -- player: KFC (dora.2679)
        image = './images/businesses/42.png',
        coords = vector4(-80.8927, 214.7884, 96.5573, 10.1297+180.0), -- dont delete the +180.0
        target = vector3(-80.8927, 214.7884, 96.5573),
        vehicleSpawn = vector4(-91.0851, 207.6586, 95.3158, 73.6692),
        camera = vector4(-79.2393, 202.6250, 100.1800, 11.2282),
        spawnCamera = false
    },
    --[[['tyrone1'] = {--664
        price = 1234,
        type = 'coke', -- player: tyrone
        image = './images/businesses/26.png',
        coords = vector4(-1325.9280, -240.9005, 42.6286, 125.2168+180.0), -- dont delete the +180.0
        target = vector3(-1325.9280, -240.9005, 42.6286),
        vehicleSpawn = vector4(-1314.0712, -238.4703, 42.3585, 224.6953),
        camera = vector4(-1306.9572, -230.0928, 48.9613, 125.1915),
        spawnCamera = false
    },]]--
    ['rolling60'] = {--827
        price = 1234,
        type = 'coke', -- player: yameson
        image = './images/businesses/41.png',
        coords = vector4(-1560.8809, -285.3390, 48.2772, 315.9085+180.0), -- dont delete the +180.0
        target = vector3(-1560.8809, -285.3390, 48.2772),
        vehicleSpawn = vector4(-1557.3274, -296.9036, 48.2126, 218.4273),
        camera = vector4(-1565.5332, -295.5278, 53.7880, 324.6836),
        spawnCamera = false
    },
    ['ethan1'] = {--575
        price = 1234,
        type = 'weed', -- player: {AO} Ethan
        image = './images/businesses/40.png',
        coords = vector4(1164.5247, -455.6732, 66.9737, 340.7815+180.0), -- dont delete the +180.0
        target = vector3(1164.5247, -455.6732, 66.9737),
        vehicleSpawn = vector4(1159.4534, -466.9063, 66.6302, 161.0935),
        camera = vector4(1161.1617, -486.4556, 73.1965, 355.7817),
        spawnCamera = false
    },
    ['nox1'] = {--087
        price = 1234,
        type = 'weed', -- player: Nox
        image = './images/businesses/39.png',
        coords = vector4(2891.1272, 4503.8472, 48.0902, 77.7982+180.0), -- dont delete the +180.0
        target = vector3(2891.1272, 4503.8472, 48.0902),
        vehicleSpawn = vector4(2877.4143, 4477.9917, 48.1114, 241.3945),
        camera = vector4(2881.3088, 4482.1284, 58.9398, 312.4038),
        spawnCamera = false
    },
    ['Ckashhh2'] = {--234
        price = 1234,
        type = 'counterfeit_factory', -- player: Ckashhh
        image = './images/businesses/38.png',
        coords = vector4(387.4584, 3584.7251, 33.2922, 165.5380+180.0), -- dont delete the +180.0
        target = vector3(387.4584, 3584.7251, 33.2922),
        vehicleSpawn = vector4(391.9646, 3599.6462, 33.2926, 261.4607),
        camera = vector4(404.6743, 3614.6743, 40.5653, 153.8357),
        spawnCamera = false
    },
    ['Ckashhh1'] = {--233
        price = 1234,
        type = 'coke', -- player: Ckashhh
        image = './images/businesses/37.png',
        coords = vector4(346.7392, 3405.6150, 36.8513, 197.2742+180.0), -- dont delete the +180.0
        target = vector3(346.7392, 3405.6150, 36.8513),
        vehicleSpawn = vector4(345.0689, 3416.9832, 36.4641, 359.0497),
        camera = vector4(300.7793, 3407.5825, 47.9662, 275.8327),
        spawnCamera = false
    },
    --[[['stank1'] = {--614
        price = 1234,
        type = 'coke', -- player: lil stank
        image = './images/businesses/36.png',
        coords = vector4(255.4785, -257.3724, 54.0365, 156.3993+180.0), -- dont delete the +180.0
        target = vector3(255.4785, -257.3724, 54.0365),
        vehicleSpawn = vector4(259.6121, -243.2987, 53.9694, 249.6094),
        camera = vector4(248.6430, -243.9300, 63.6217, 228.2612),
        spawnCamera = false
    },]]
    --[[['z1'] = {--905
        price = 25000,
        type = 'coke', -- player: Z
        image = './images/businesses/32.png',
        coords = vector4(-751.7318, -2550.2239, 13.9412, 140.0985+180.0), -- dont delete the +180.0
        target = vector3(-751.7318, -2550.2239, 13.9412),
        vehicleSpawn = vector4(-755.0778, -2539.7046, 13.8882, 60.1825),
        camera = vector4(-748.2075, -2531.2471, 19.2403, 148.5170),
        spawnCamera = false
    },
    ['cuddi1'] = {--500
        price = 25000,
        type = 'meth', -- player: C U D D I
        image = './images/businesses/30.png',
        coords = vector4(-100.5040, 821.3962, 235.7252, 280.3777+180.0), -- dont delete the +180.0
        target = vector3(-100.5040, 821.3962, 235.7252),
        vehicleSpawn = vector4(-100.8280, 854.9905, 235.7343, 44.0076),
        camera = vector4(-127.0380, 834.1406, 237.5502, 265.6538),
        spawnCamera = false
    },
    ['joshd1'] = {--905
        price = 25000,
        type = 'coke', -- player: josh demonco
        image = './images/businesses/31.png',
        coords = vector4(858.9211, -144.6143, 78.9759, 238.9931+180.0), -- dont delete the +180.0
        target = vector3(858.9211, -144.6143, 78.9759),
        vehicleSpawn = vector4(860.6204, -127.7962, 79.2114, 332.6449),
        camera = vector4(852.8239, -120.0710, 85.6316, 200.8752),
        spawnCamera = false
    },]]
    --[[['raze2'] = {--115
        price = 25000,
        type = 'document_forgery', -- player: razetastic
        image = './images/businesses/29.png',
        coords = vector4(1682.6621, 4840.7349, 42.0390, 275.8077+180.0), -- dont delete the +180.0
        target = vector3(1682.6621, 4840.7349, 42.0390),
        vehicleSpawn = vector4(1675.0917, 4842.6040, 42.0283, 6.4907),
        camera = vector4(1662.1504, 4818.6211, 47.1944, 316.5206),
        spawnCamera = false
    },
    ['raze1'] = {--228
        price = 25000,
        type = 'weed', -- player: razetastic
        image = './images/businesses/26.png',
        coords = vector4(287.4803, 2843.5991, 44.7041, 302.0913+180.0), -- dont delete the +180.0
        target = vector3(287.4803, 2843.5991, 44.7041),
        vehicleSpawn = vector4(257.4665, 2848.4285, 43.5918, 97.1072),
        camera = vector4(266.3080, 2858.2197, 53.2193, 225.8213),
        spawnCamera = false
    },
    ['twisted1'] = {--541
        price = 25000,
        type = 'meth', -- Player: twisted
        image = './images/businesses/1.png',
        coords = vector4(1218.8440, 1848.5891, 78.9527, 36.5246+180.0), -- dont delete the +180.0
        target = vector3(1218.8440, 1848.5891, 78.9527),
        vehicleSpawn = vector4(1220.1154, 1837.7810, 79.3757, 118.3029),
        camera = vector4(1221.2257, 1848.8345, 86.1851, 157.0932),
        spawnCamera = false
    },]]
    --[[['Codeine'] = {--796
        price = 25000,
        type = 'document_forgery', -- Player: bobo
        image = './images/businesses/1.png',
        coords = vector4(960.3939, -1586.0676, 30.3895, 91.5272+180.0), -- dont delete the +180.0
        target = vector3(960.3939, -1586.0676, 30.3895),
        vehicleSpawn = vector4(969.7469, -1585.6941, 30.5878, 356.8002),
        camera = vector4(982.5796, -1589.2842, 37.0, 102.7064),
        spawnCamera = false
    },]]
    ['evan2'] = {--698
        price = 25000,
        type = 'meth', -- Player: evankapler
        image = './images/businesses/1.png',
        coords = vector4(-1196.8126, -1175.9823, 7.7028, 279.0807+180.0),
        target = vector3(-1196.8126, -1175.9823, 7.7028),
        vehicleSpawn = vector4(-1206.8208, -1179.9409, 7.7674, 28.7755),
        camera = vector4(-1196.6578, -1175.2133, 11.9669, 97.3552),
        spawnCamera = false
    },
    ['evan1'] = {--698
        price = 25000,
        type = 'document_forgery', -- Player: evankapler
        image = './images/businesses/1.png',
        coords = vector4(-1204.6354, -1146.3123, 7.6997, 293.8200+180.0), -- dont delete the +180.0
        target = vector3(-1204.6354, -1146.3123, 7.6997),
        vehicleSpawn = vector4(-1214.5369, -1143.4045, 7.6905, 15.6830),
        camera = vector4(-1205.8750, -1141.9441, 13.0828, 65.4884),
        spawnCamera = false
    },
    ['honduran1'] = {--284
        price = 25000,
        type = 'coke', -- Player: honduran
        image = './images/businesses/4.png',
        coords = vector4(1743.3616, 3702.1384, 34.2082, 340.2312+180.0), -- dont delete the +180.0
        target = vector3(1743.3616, 3702.1384, 34.2082),
        vehicleSpawn = vector4(1769.0999, 3708.0525, 34.2667, 209.4604),
        camera = vector4(1759.4545, 3711.4043, 39.2943, 254.3035),
        spawnCamera = false
    },
    ['onezeroeight'] = {--871
        price = 25000,
        type = 'weed',
        image = './images/businesses/4.png',
        coords = vector4(-421.8266, -2171.3020, 11.3356, 186.1292+180.0), -- dont delete the +180.0
        target = vector3(-421.8266, -2171.3020, 11.3356),
        vehicleSpawn = vector4(-411.6557, -2158.8787, 10.2515, 281.2840),
        camera = vector4(-410.5925, -2164.5386, 13.9326, 107.5152),
        spawnCamera = false
    },
    --[[['Demon1'] = {--096
        price = 25000,
        type = 'weed',
        image = './images/businesses/26.png',
        coords = vector4(2570.4922, 4667.7637, 34.0768, 312.2708+180.0), -- dont delete the +180.0
        target = vector3(2570.4922, 4667.7637, 34.0768),
        vehicleSpawn = vector4(2560.2747, 4693.5195, 33.8917, 131.1468),
        camera = vector4(2569.5427, 4684.9585, 42.4594, 50.6798),
        spawnCamera = false
    },
    ['Demon2'] = {--096
        price = 25000,
        type = 'counterfeit_factory',
        image = './images/businesses/9.png',
        coords = vector4(2555.4026, 4651.6514, 34.0768, 293.2371+180.0),
        target = vector3(2555.4026, 4651.6514, 34.0768),
        vehicleSpawn = vector4(2544.1277, 4661.0474, 34.0768, 5.9131),
        camera = vector4(2551.2761, 4668.1421, 41.3896, 65.3768),
        spawnCamera = false
    },]]
    ['sandy1'] = {--271
        price = 375000,
        type = 'meth',
        image = './images/businesses/1.png',
        coords = vector4(1406.7788, 3604.0256, 35.0098, 197.5982),
        target = vector3(1406.5887, 3604.3064, 35.2928),
        vehicleSpawn = vector4(1405.5842, 3598.4509, 34.8736, 289.2202),
        camera = vector4(1405.5699, 3603.7927, 36.8842, 197.5982),
        spawnCamera = false
    },
    ['sandy2'] = {--090
        price = 375000,
        type = 'meth',
        image = './images/businesses/2.png',
        coords = vector4(2566.6580, 4283.2500, 41.9737, 325.0891),
        target = vector3(2566.4688, 4282.9121, 42.1892),
        vehicleSpawn = vector4(2580.5234, 4277.6450, 42.0310, 236.8790),
        camera = vector4(2570.08, 4280.5508, 43.0436, 325.0891),
        spawnCamera = false
    },
    ['sandy3'] = {--317
        price = 375000,
        type = 'meth',
        image = './images/businesses/3.png',
        coords = vector4(2440.4216, 4068.1387, 38.0646, 67.7840),
        target = vector3(2441.0078, 4067.8789, 38.0909),
        vehicleSpawn = vector4(2436.4829, 4068.5938, 38.1832, 158.5744),
        camera = vector4(2441.6412, 4070.0374, 40.0015, 67.1323),
        spawnCamera = false
    },
    ['sandy4'] = {--247
        price = 450000,
        type = 'coke',
        image = './images/businesses/4.png',
        coords = vector4(983.9380, 2719.0254, 39.5034, 180.2520),
        target = vector3(983.9777, 2719.3301, 39.6300),
        vehicleSpawn = vector4(968.1750, 2711.4932, 39.6082, 176.9819),
        camera = vector4(982.7112, 2719.3306, 40.8236, 180.2176),
        spawnCamera = false
    },
    ['sandy5'] = {--234
        price = 325000,
        type = 'weed',
        image = './images/businesses/5.png',
        coords = vector4(387.4630, 3584.6250, 33.2922, 352.3442),
        target = vector3(387.3968, 3584.0212, 33.4958),
        vehicleSpawn = vector4(386.5290, 3591.1851, 33.3979, 81.0021),
        camera = vector4(390.2834, 3583.7847, 35.4598, 350.2238),
        spawnCamera = false
    },
    ['grapeseed1'] = {--087
        price = 450000,
        type = 'coke',
        image = './images/businesses/6.png',
        coords = vector4(2910.6643, 4492.8569, 48.1109, 241.8741),
        target = vector3(2910.3154, 4493.1104, 48.1853),
        vehicleSpawn = vector4(2893.5417, 4468.1748, 48.2881, 235.2832),
        camera = vector4(2908.0513, 4489.6626, 50.1964, 237.0),
        spawnCamera = false
    },
    ['grapeseed2'] = {--114
        price = 325000,
        type = 'weed',
        image = './images/businesses/7.png',
        coords = vector4(1710.4806, 4728.4551, 42.1447, 107.5304),
        target = vector3(1711.1708, 4728.6846, 42.3612),
        vehicleSpawn = vector4(1699.7042, 4729.9644, 42.2457, 16.6955),
        camera = vector4(1710.1759, 4730.9531, 44.8178, 106),
        spawnCamera = false
    },
    ['grapeseed3'] = {--111
        price = 450000,
        type = 'coke',
        image = './images/businesses/8.png',
        coords = vector4(1929.9766, 4634.8584, 40.4712, 358.5978),
        target = vector3(1929.9728, 4634.3207, 40.8334),
        vehicleSpawn = vector4(1927.8646, 4641.2065, 40.4101, 70.7316),
        camera = vector4(1932.1797, 4634.370, 43.5587, 361.0),
        spawnCamera = false
    },
    ['paleto1'] = {--041
        price = 175000,
        type = 'counterfeit_factory',
        image = './images/businesses/9.png',
        coords = vector4(7.8981, 6469.3813, 31.4253, 49.2481),
        target = vector3(8.3723, 6468.9185, 31.7139),
        vehicleSpawn = vector4(-1.2903, 6475.2524, 31.4977, 135.6160),
        camera = vector4(10.7865, 6471.9536, 34.0503, 45.2),
        spawnCamera = false
    },
    ['paleto2'] = {--065
        price = 350000,
        type = 'coke',
        image = './images/businesses/10.png',
        coords = vector4(416.1261, 6520.8228, 27.7388, 266.7884),
        target = vector3(415.8709, 6520.8530, 28.0),
        vehicleSpawn = vector4(420.8759, 6522.1475, 27.8303, 355.1833),
        camera = vector4(415.48, 6517.4092, 30.0640, 265.0),
        spawnCamera = false
    },
    ['paleto3'] = {--043
        price = 175000,
        type = 'document_forgery',
        image = './images/businesses/11.png',
        coords = vector4(-167.3230, 6312.2202, 31.4844, 137.9986),
        target = vector3(-166.9001, 6312.6548, 31.8384),
        vehicleSpawn = vector4(-169.6348, 6309.4434, 31.4529, 226.7961),
        camera = vector4(-169.2092, 6314.7354, 33.6585, 133.9205),
        spawnCamera = false
    },
    ['cypress1'] = {--804
        price = 200000,
        type = 'weed',
        image = './images/businesses/12.png',
        coords = vector4(765.0964, -1225.3175, 25.2000, 183.1358),
        target = vector3(765.0964, -1225.3175, 25.2000),
        vehicleSpawn = vector4(789.5817, -1225.2410, 26.2144, 179.0023),
        camera = vector4(756.4763, -1211.9753, 33.1921, 222.9752),
        spawnCamera = false
    },
    ['cypress2'] = {--803
        price = 225000,
        type = 'meth',
        image = './images/businesses/13.png',
        coords = vector4(975.5656, -2357.8062, 31.8238, 178.4920),
        target = vector3(975.60, -2357.2791, 32.1002),
        vehicleSpawn = vector4(978.6903, -2372.3845, 30.7756, 266.4625),
        camera = vector4(973.585, -2361.6860, 33.9175, 266.3387),
        spawnCamera = false
    },
    ['docks1'] = {--915
        price = 125000,
        type = 'document_forgery',
        image = './images/businesses/14.png',
        coords = vector4(-252.6719, -2591.1978, 6.0006, 89.0923),
        target = vector3(-252.2408, -2591.1956, 6.1745),
        vehicleSpawn = vector4(-257.7222, -2581.5176, 6.2322, 359.9601),
        camera = vector4(-252.39, -2586.1895, 8.9996, 90.0),
        spawnCamera = false
    },
    ['docks2'] = {--935
        price = 225000,
        type = 'meth',
        image = './images/businesses/15.png',
        coords = vector4(-315.5966, -2697.6550, 7.5502, 223.5475),
        target = vector3(-315.7809, -2697.4966, 7.7522),
        vehicleSpawn = vector4(-304.9973, -2702.3196, 6.2318, 223.9389),
        camera = vector4(-311.7933, -2703.0793, 10.6080, 315.0),
        spawnCamera = false
    },
    ['docks3'] = {
        price = 200000,
        type = 'counterfeit_factory',
        image = './images/businesses/16.png',
        coords = vector4(671.8234, -2667.5344, 6.0812, 90.0),
        target = vector3(672.5561, -2667.5383, 6.4577),
        vehicleSpawn = vector4(663.6398, -2672.9990, 6.3140, 90.5724),
        camera = vector4(672.2450, -2664.3159, 8.6597, 90.0),
        spawnCamera = false
    },
    ['vespucci1'] = {--689
        price = 125000,
        type = 'document_forgery',
        image = './images/businesses/17.png',
        coords = vector4(-1320.1765, -1169.4877, 4.8497, 90.0),
        target = vector3(-1319.6476, -1169.4592, 5.2060),
        vehicleSpawn = vector4(-1323.2697, -1166.5033, 4.8649, 359.8101),
        camera = vector4(-1319.9188, -1167.4281, 7.7098, 90.1803),
        spawnCamera = false
    },
    ['vespucci2'] = {--687
        price = 275000,
        type = 'coke',
        image = './images/businesses/18.png',
        coords = vector4(-1471.8260, -920.1209, 10.0249, 233.8087),
        target = vector3(-1472.2491, -919.8125, 10.3351),
        vehicleSpawn = vector4(-1461.2311, -924.1044, 10.1727, 229.4936),
        camera = vector4(-1473.0105, -921.1329, 11.0131, 230.3719),
        spawnCamera = false
    },
    ['vespucci3'] = {--702
        price = 225000,
        type = 'meth',
        image = './images/businesses/19.png',
        coords = vector4(-1320.6843, -757.0616, 20.3843, 128.3880),
        target = vector3(-1320.2527, -756.7042, 20.6936),
        vehicleSpawn = vector4(-1324.2765, -762.4982, 20.5012, 218.2692),
        camera = vector4(-1321.6441, -755.4149, 22.3585, 128.3484),
        spawnCamera = false
    },
    ['bluffs1'] = {--682
        price = 275000,
        type = 'coke',
        image = './images/businesses/20.png',
        coords = vector4(-2022.3195, -255.4200, 23.4210, 55.2879),
        target = vector3(-2021.6665, -255.9335, 23.7969),
        vehicleSpawn = vector4(-2033.0206, -264.0719, 23.4917, 145.6359),
        camera = vector4(-2020.7306, -253.9135, 25.3781, 55.5150),
        spawnCamera = false
    },
    ['vinewood1'] = {--597
        price = 275000,
        type = 'coke',
        image = './images/businesses/21.png',
        coords = vector4(189.8956, 309.2420, 105.3895, 183.0883),
        target = vector3(189.8804, 309.6163, 105.7041),
        vehicleSpawn = vector4(185.0796, 304.2277, 105.4647, 94.9263),
        camera = vector4(187.0928, 309.3682, 107.0412, 183.6412),
        spawnCamera = false
    },
    ['vinewood2'] = {--605
        price = 125000,
        type = 'document_forgery',
        image = './images/businesses/22.png',
        coords = vector4(254.2915, 24.6001, 83.9496, 339.0316),
        target = vector3(254.1955, 24.2324, 84.1712),
        vehicleSpawn = vector4(259.0028, 30.5433, 84.1893, 69.8234),
        camera = vector4(256.4800, 23.5030, 85.5375, 339.8386),
        spawnCamera = false
    },
    ['murrieta1'] = {--766
        price = 275000,
        type = 'coke',
        image = './images/businesses/23.png',
        coords = vector4(716.7491, -654.5608, 27.7856, 273.1887),
        target = vector3(716.3299, -654.5975, 27.9256),
        vehicleSpawn = vector4(721.7962, -659.1468, 27.9096, 179.8876),
        camera = vector4(716.4721, -660.7780, 30.4769, 272.9428),
        spawnCamera = false
    },
    ['murrieta2'] = {--768
        price = 200000,
        type = 'weed',
        image = './images/businesses/24.png',
        coords = vector4(844.8999, -902.8033, 25.2515, 271.7178),
        target = vector3(844.1164, -902.8592, 25.5178),
        vehicleSpawn = vector4(852.1138, -903.2523, 25.5148, 181.1226),
        camera = vector4(844.9272, -906.1412, 29.055, 271.8468),
        spawnCamera = false
    },
    ['highway1'] = {--194
        price = 250000,
        type = 'meth',
        image = './images/businesses/25.png',
        coords = vector4(-2173.7837, 4282.1895, 49.1201, 237.0967),
        target = vector3(-2174.3281, 4282.4897, 49.4073),
        vehicleSpawn = vector4(-2168.5735, 4278.9077, 49.1635, 150.5157),
        camera = vector4(-2172.5364, 4283.2808, 51.9518, 237.0),
        spawnCamera = false
    },
    --[[['ghost1'] = {--625
        price = 1000,
        type = 'meth',
        image = './images/businesses/26.png',
        coords = vector4(-363.9955, 279.0614, 86.4219, 215.0-180.0),
        target = vector3(-363.6684, 278.7274, 86.4171),
        vehicleSpawn = vector4(-364.6494, 290.1254, 84.7804, 213.0837),
        camera = vector4(-385.7666015625, 266.67733764648, 87.881271362305, 128.0),
        spawnCamera = false
    },
    ['ghost2'] = {--625
        price = 1000,
        type = 'coke',
        image = './images/businesses/26.png',
        coords = vector4(-371.2979, 277.4106, 86.4220, 130.0012+180.0),
        target = vector3(-371.5934, 277.1561, 86.4220),
        vehicleSpawn = vector4(-364.6494, 290.1254, 84.7804, 213.0837),
        camera = vector4(-385.7666015625, 266.67733764648, 87.881271362305, 128.0),
        spawnCamera = false
    },
    ['ghost3'] = {--625
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/26.png',
        coords = vector4(-362.1892, 277.6459, 86.4219, 124.2736+180.0),
        target = vector3(-362.3143, 277.6568, 86.4219),
        vehicleSpawn = vector4(-364.6494, 290.1254, 84.7804, 213.0837),
        camera = vector4(-385.7666015625, 266.67733764648, 87.881271362305, 128.0),
        spawnCamera = false
    },
    ['ghost4'] = {--542
        price = 1000,
        type = 'document_forgery',
        image = './images/businesses/29.png',
        coords = vector4(1532.0250, 1728.1759, 109.9184, 277.1527+180.0),
        target = vector3(1532.0250, 1728.1759, 109.9184),
        vehicleSpawn = vector4(1522.0513, 1728.3766, 110.0259, 85.5996),
        camera = vector4(1531.7168, 1730.8691, 111.9176, 98.4142),
        spawnCamera = false
    },
    ['ghost5'] = {--518
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/30.png',
        coords = vector4(-46.6709, 1947.1597, 190.5559, 31.3424+180.0),
        target = vector3(-46.6709, 1947.1597, 190.5559),
        vehicleSpawn = vector4(-58.7940, 1957.9192, 190.1862, 88.8287),
        camera = vector4(-52.3834, 1955.4098, 192.1862, 53.6697),
        spawnCamera = false
    },]]
    ['johnny1'] = {--239
        price = 1000,
        type = 'weed',
        image = './images/businesses/27.png',
        coords = vector4(412.4990, 2965.1482, 41.8881, 228.1266+180.0),
        target = vector3(412.4990, 2965.1482, 41.8881),
        vehicleSpawn = vector4(405.1010, 2972.9297, 40.9054, 140.8246),
        camera = vector4(418.0362, 2972.0916, 44.6393, 107.4672),
        spawnCamera = false
    },
    ['keanu1'] = {--375
        price = 1000,
        type = 'coke',
        image = './images/businesses/28.png',
        coords = vector4(201.0360, 2442.1860, 60.4483, 84.4787+180.0),
        target = vector3(201.0360, 2442.1860, 60.4483),
        vehicleSpawn = vector4(213.7757, 2439.7261, 58.5903, 352.0479),
        camera = vector4(208.2163, 2464.5249, 62.7497, 214.9109),
        spawnCamera = false
    },
    ['pancake2'] = {--roxwood woods
        price = 1000,
        type = 'document_forgery',
        image = './images/businesses/32.png',
        coords = vector4(-570.5999, 311.0251, 84.4953, 178.0326+180.0),
        target = vector3(-570.5999, 311.0251, 84.4953),
        vehicleSpawn = vector4(-566.3292, 320.5444, 84.4057, 339.8134),
        camera = vector4(-579.5002, 338.0296, 89.5410, 198.3785),
        spawnCamera = false
    },
    ['slam1'] = {--356
        price = 1000,
        type = 'meth',
        image = './images/businesses/35.png',
        coords = vector4(2338.1702, 2570.7361, 47.7242, 63.6390+180.0),
        target = vector3(2338.1702, 2570.7361, 47.7242),
        vehicleSpawn = vector4(2351.4309, 2574.5908, 46.6677, 359.4720),
        camera = vector4(2333.9705, 2561.7502, 48.6677, 307.4381),
        spawnCamera = false
    },
    --[[['sears1'] = {--575
        price = 1000,
        type = 'document_forgery',
        image = './images/businesses/34.png',
        coords = vector4(1164.4875, -455.2650, 66.9845, 342.1792+180.0),
        target = vector3(1164.4875, -455.2650, 66.9845),
        vehicleSpawn = vector4(1162.4020, -463.2917, 66.6521, 168.2866),
        camera = vector4(1169.1971, -460.1715, 68.4830, 199.8217),
        spawnCamera = false
    },
    ['reckage1'] = {--605
        price = 1000,
        type = 'weed',
        image = './images/businesses/36.png',
        coords = vector4(210.6284, -17.8205, 69.8964, 20.6729+180.0),
        target = vector3(210.6284, -17.8205, 69.8964),
        vehicleSpawn = vector4(215.0743, -25.9779, 69.6891, 165.1383),
        camera = vector4(242.8004, -51.8840, 75.9871, 49.5758),
        spawnCamera = false
    },
    ['reckage2'] = {--605
        price = 1000,
        type = 'meth',
        image = './images/businesses/37.png',
        coords = vector4(201.9382, -26.2600, 69.9095, 71.4680+180.0),
        target = vector3(201.9382, -26.2600, 69.9095),
        vehicleSpawn = vector4(215.0743, -25.9779, 69.6891, 165.1383),
        camera = vector4(242.8004, -51.8840, 75.9871, 49.5758),
        spawnCamera = false
    },
    ['lovedlogic1'] = {--605
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/38.png',
        coords = vector4(217.9445, -19.6238, 69.8964, 340.8133+180.0),
        target = vector3(217.9445, -19.6238, 69.8964),
        vehicleSpawn = vector4(215.0743, -25.9779, 69.6891, 165.1383),
        camera = vector4(242.8004, -51.8840, 75.9871, 49.5758),
        spawnCamera = false
    },]]
    ['metz1'] = {--702
        price = 1000,
        type = 'weed',
        image = './images/businesses/39.png',
        coords = vector4(-1393.4937, -919.4772, 11.2444, 270.2341+180.0),
        target = vector3(-1393.4937, -919.4772, 11.2444),
        vehicleSpawn = vector4(-1402.3842, -919.9664, 10.9667, 11.3019),
        camera = vector4(-1388.6184, -909.7507, 16.3843, 180.2287),
        spawnCamera = false
    },
    --[[['Shiesty1'] = {--840
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/40.png',
        coords = vector4(236.7640, -1869.2789, 26.7245, 52.5288+180.0),
        target = vector3(236.7640, -1869.2789, 26.7245),
        vehicleSpawn = vector4(235.3695, -1875.1350, 26.4608, 230.9596),
        camera = vector4(266.6400, -1825.6567, 28.3795, 134.1219),
        spawnCamera = false
    },
    ['Shiesty2'] = {--767
        price = 1000,
        type = 'weed',
        image = './images/businesses/41.png',
        coords = vector4(796.9603, -725.0281, 27.9906, 183.3049+180.0),
        target = vector3(796.9603, -725.0281, 27.9906),
        vehicleSpawn = vector4(784.5544, -723.8632, 27.9774, 138.8771),
        camera = vector4(759.6744, -675.7761, 37.1240, 215.3432),
        spawnCamera = false
    },
    ['WolfBrax1'] = {--226
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/42.png',
        coords = vector4(46.7958, 2789.6096, 58.1004, 327.0497+180.0),
        target = vector3(46.7958, 2789.6096, 58.1004),
        vehicleSpawn = vector4(39.7212, 2798.1611, 57.8782, 146.4115),
        camera = vector4(42.2772, 2791.9121, 59.8781, 193.8193),
        spawnCamera = false
    },]]
    --[[['Rzizzs1'] = {--305
        price = 1000,
        type = 'meth',
        image = './images/businesses/43.png',
        coords = vector4(2403.5315, 3127.9080, 48.1529, 70.3300+180.0),
        target = vector3(2403.5315, 3127.9080, 48.1529),
        vehicleSpawn = vector4(2396.5427, 3117.0020, 48.1937, 68.2548),
        camera = vector4(2360.9028, 3118.0918, 50.2089, 288.1415),
        spawnCamera = false
    },]]
    --[[['Rocco1'] = {--244
        price = 1000,
        type = 'coke',
        image = './images/businesses/44.png',
        coords = vector4(636.5739, 2785.7896, 42.0090, 7.1252+180.0),
        target = vector3(636.5739, 2785.7896, 42.0090),
        vehicleSpawn = vector4(638.7801, 2775.5999, 41.9724, 1.9691),
        camera = vector4(634.0595, 2785.5588, 47.0, 243.3680),
        spawnCamera = false
    },
    ['WolfBrax2'] = {--226
        price = 1000,
        type = 'document_forgery',
        image = './images/businesses/42.png',
        coords = vector4(58.9597, 2794.9331, 57.8783, 145.5367+180.0),
        target = vector3(58.9597, 2794.9331, 57.8783),
        vehicleSpawn = vector4(66.8238, 2784.6865, 57.8783, 144.8366),
        camera = vector4(49.3412, 2787.5996, 59.8782, 225.1522),
        spawnCamera = false
    },]]
    ['JayAdams1'] = {--868
        price = 1000,
        type = 'coke',
        image = './images/businesses/45.png',
        coords = vector4(-583.0142, -1767.3896, 23.1804, 325.9619+180.0),
        target = vector3(-583.0142, -1767.3896, 23.1804),
        vehicleSpawn = vector4(-586.2761, -1773.9645, 22.6554, 188.8590),
        camera = vector4(-590.6325, -1763.1113, 26.6380, 183.8065),
        spawnCamera = false
    },
    --[[['Brandon1'] = {--849
        price = 1000,
        type = 'weed',
        image = './images/businesses/46.png',
        coords = vector4(56.7423, -1435.5613, 29.3117, 237.2126+180.0),
        target = vector3(56.7423, -1435.5613, 29.3117),
        vehicleSpawn = vector4(53.6204, -1430.3625, 29.3117, 143.2839),
        camera = vector4(43.6277, -1451.4440, 32.3114, 345.0333),
        spawnCamera = false
    },
    ['Brandon2'] = {--849
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/46.png',
        coords = vector4(52.9518, -1440.0602, 29.3117, 244.5509+180.0),
        target = vector3(52.9518, -1440.0602, 29.3117),
        vehicleSpawn = vector4(45.8203, -1438.8861, 29.3117, 137.8920),
        camera = vector4(43.6277, -1451.4440, 32.3114, 345.0333),
        spawnCamera = false
    },
    ['Harry1'] = {--672
        price = 1000,
        type = 'coke',
        image = './images/businesses/47.png',
        coords = vector4(-1583.6538, -265.7247, 48.2772, 87.9647+180.0),
        target = vector3(-1583.6538, -265.7247, 48.2772),
        vehicleSpawn = vector4(-1578.8052, -268.3344, 48.2772, 195.8669),
        camera = vector4(-1560.0361, -236.4287, 54.4234, 168.0141),
        spawnCamera = false
    },
    ['Mar1'] = {--693
        price = 1000,
        type = 'coke',
        image = './images/businesses/48.png',
        coords = vector4(-1155.6239, -1574.3596, 8.3450, 309.8678+180.0),
        target = vector3(-1155.6239, -1574.3596, 8.3450),
        vehicleSpawn = vector4(-1150.5017, -1584.8363, 4.3605, 303.7234),
        camera = vector4(-1152.0891, -1603.4487, 6.3824, 34.0016),
        spawnCamera = false
    },
    ['EliHopkins1'] = {--538
        price = 1000,
        type = 'weed',
        image = './images/businesses/49.png',
        coords = vector4(1443.9880, 1131.9230, 114.3357, 4.5360+180.0),
        target = vector3(1443.9880, 1131.9230, 114.3357),
        vehicleSpawn = vector4(1448.6215, 1128.8795, 114.3358, 268.0630),
        camera = vector4(1483.4050, 1105.0848, 117.3405, 74.7701),
        spawnCamera = false
    },
    ['EliHopkins2'] = {--538
        price = 1000,
        type = 'coke',
        image = './images/businesses/49.png',
        coords = vector4(1440.8422, 1137.8921, 114.3266, 272.0209+180.0),
        target = vector3(1440.8422, 1137.8921, 114.3266),
        vehicleSpawn = vector4(1432.1871, 1139.7981, 114.2774, 358.6530),
        camera = vector4(1483.4050, 1105.0848, 117.3405, 74.7701),
        spawnCamera = false
    },
    ['AndrewTate1'] = {--852
        price = 1000,
        type = 'counterfeit_factory',
        image = './images/businesses/51.png',
        coords = vector4(-159.3259, -1432.0334, 31.2713, 269.4814+180.0),
        target = vector3(-159.3259, -1432.0334, 31.2713),
        vehicleSpawn = vector4(-172.3071, -1431.8153, 31.2487, 138.9845),
        camera = vector4(-175.0060, -1454.0482, 32.7334, 23.2539),
        spawnCamera = false
    },
    ['AndrewTate2'] = {--855
        price = 1000,
        type = 'document_forgery',
        image = './images/businesses/54.png',
        coords = vector4(-186.2921, -1701.7474, 32.8242, 129.7229+180.0),
        target = vector3(-186.2921, -1701.7474, 32.8242),
        vehicleSpawn = vector4(-192.5324, -1691.7224, 33.3992, 304.6171),
        camera = vector4(-180.1500, -1706.3096, 36.2999, 16.7643),
        spawnCamera = false
    },
    ['ShadyGrady1'] = {--225
        price = 1000,
        type = 'weed',
        image = './images/businesses/52.png',
        coords = vector4(-35.4511, 2871.5742, 59.6102, 341.8555+180.0),
        target = vector3(-35.4511, 2871.5742, 59.6102),
        vehicleSpawn = vector4(-45.1309, 2855.4939, 58.3836, 160.5424),
        camera = vector4(-43.1472, 2874.4658, 60.5923, 206.5182),
        spawnCamera = false
    },
    ['Porter1'] = {--759
        price = 1000,
        type = 'coke',
        image = './images/businesses/53.png',
        coords = vector4(375.5455, -688.2237, 29.2629, 173.0894+180.0),
        target = vector3(375.5455, -688.2237, 29.2629),
        vehicleSpawn = vector4(378.1234, -679.1063, 29.2057, 263.7658),
        camera = vector4(434.7693, -660.3326, 31.8119, 116.6789),
        spawnCamera = false
    },
    ['EvanKapler1'] = {--636
        price = 1000,
        type = 'coke',
        image = './images/businesses/26.png',
        coords = vector4(-385.2654, 270.2159, 86.3675, 216.0481+180.0),
        target = vector3(-385.2654, 270.2159, 86.3675),
        vehicleSpawn = vector4(-391.4482, 274.1060, 84.6289, 179.5394),
        camera = vector4(-385.7666015625, 266.67733764648, 87.881271362305, 128.0),
        spawnCamera = false
    },
    ['EvanKapler2'] = {--636
        price = 1000,
        type = 'weed',
        image = './images/businesses/26.png',
        coords = vector4(-385.2085, 261.4981, 86.3673, 307.2819+180.0),
        target = vector3(-385.2085, 261.4981, 86.3673),
        vehicleSpawn = vector4(-390.7996, 269.6958, 84.6210, 174.8577),
        camera = vector4(-385.3542, 270.0813, 87.3675, 1.2532),
        spawnCamera = false
    },]]
}

---@class BusinessTypeData
---@field icon string
---@field blip BlipData
---@field interior InteriorData
---@field product { price: { min: integer, max: integer }, prop: ProductPropData | { normal: ProductPropData, upgraded: ProductPropData } }

---@alias ProductPropData { model: string|number, bone: integer, offset: vector3, rot: vector3, dict: string, clip: string }

---@class InteriorData
---@field exit { coords: vector4, target: vector3 }
---@field laptop vector3
---@field cctv vector3
---@field stash vector3 | { coords: vector3, model: number | string }
---@field guards vector4[]
---@field confiscate vector3

---@type table<string, BusinessTypeData>
Config.businessTypes = {
    ['meth'] = {
        icon = 'flask-vial',
        blip = {
            name = locale('ui_type_meth'),
            sprite = 499,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(997.1076, -3200.6719, -36.3937, 275.0),
                target = vector3(996.5623, -3200.6897, -36.1465),
            },
            laptop = vector3(1001.9495, -3194.1707, -39.1434),
            cctv = vector3(1003.0371, -3194.3442, -39.0958),
            stash = vector3(1004.3560, -3194.3435, -38.8263),
            guards = {
                vector4(999.3573, -3200.0852, -36.3935, 95.6750),
                vector4(1017.1261, -3199.2986, -38.9933, 86.8590)
            },
            confiscate = vector3(1017.5480, -3199.3284, -38.7046)
        },
        product = {
            -- Price per 1%
            price = { min = 50, max = 100 }, -- Price per 1%
            prop = {
                model = `bkr_prop_meth_bigbag_04a`,
                bone = 28422,
                offset = vector3(0.0, -0.03, -0.08),
                rot = vector3(35.0, -5.0, 0.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            }
        }
    },
    ['coke'] = {
        icon = 'flask-vial',
        blip = {
            name = locale('ui_type_coke'),
            sprite = 497,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1088.7158, -3187.5149, -38.9935, 182.6907),
                target = vector3(1088.6937, -3187.2053, -38.7934),
            },
            laptop = vector3(1086.5826, -3194.2812, -39.1694),
            cctv = vector3(1086.6700, -3198.2395, -39.0915),
            stash = vector3(1096.9198, -3192.5608, -38.8285),
            guards = {
                vector4(1090.7985, -3189.5066, -38.9935, 93.9775),
                vector4(1093.5660, -3199.1763, -38.9935, 3.4853)
            },
            confiscate = vector3(1103.0474, -3196.2319, -39.0686)
        },
        product = {
            price = { min = 50, max = 100 }, -- Price per 1%
            prop = {
                normal = {
                    model = `prop_drug_package`,
                    bone = 28422,
                    offset = vector3(0.0, -0.075, 0.0),
                    rot = vector3(30.0, 0.0, 0.0),
                    dict = 'anim@heists@box_carry@',
                    clip = 'idle'
                },
                upgraded = {
                    model = `bkr_prop_coke_doll_bigbox`,
                    bone = 28422,
                    offset = vector3(0.0, -0.1, -0.15),
                    rot = vector3(40.0, 0.0, 0.0),
                    dict = 'anim@heists@box_carry@',
                    clip = 'idle'
                }
            }
        }
    },
    ['weed'] = {
        icon = 'cannabis',
        blip = {
            name = locale('ui_type_weed'),
            sprite = 496,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1066.4044, -3183.5330, -39.1638, 93.9428),
                target = vector3(1066.6565, -3183.4431, -38.9503),
            },
            laptop = vector3(1045.1567, -3194.8413, -38.3342),
            cctv = vector3(1045.0583, -3196.6064, -38.2542),
            stash = { coords = vector3(1045.4093, -3198.6733, -38.6549), model = `prop_cabinet_01b` },
            guards = {
                vector4(1060.0353, -3183.9941, -39.1650, 270.0),
                vector4(1038.6803, -3200.9468, -38.1691, 270.0)
            },
            confiscate = vector3(1042.2615, -3193.4773, -38.4454)
        },
        product = {
            price = { min = 50, max = 100 }, -- Price per 1%
            prop = {
                model = `bkr_prop_weed_bigbag_03a`,
                bone = 28422,
                offset = vector3(0.0, -0.05, -0.15),
                rot = vector3(0.0, -30.0, 90.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            }
        },
    },
    ['counterfeit_factory'] = {
        icon = 'money-bill-wave',
        blip = {
            name = locale('ui_type_counterfeit_factory'),
            sprite = 500,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1138.1237, -3199.1963, -39.6658, 4.5842),
                target = vector3(1138.1060, -3199.4482, -39.4796),
            },
            laptop = vector3(1129.5422, -3193.5024, -40.5682),
            cctv = vector3(1135.2314, -3193.5107, -40.4661),
            stash = vector3(1138.4855, -3193.2441, -40.4541),
            guards = {
                vector4(1136.9071, -3193.2664, -40.3912, 180.0),
                vector4(1127.5344, -3194.2104, -40.3969, 186.5505)
            },
            confiscate = vector3(1118.5190, -3193.7800, -40.7601)
        },
        product = {
            price = { min = 50, max = 100 }, -- Price per 1%
            prop = {
                model = `bkr_prop_moneypack_03a`,
                bone = 28422,
                offset = vector3(0.0, -0.05, -0.15),
                rot = vector3(0.0, -30.0, 90.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            }
        }
    },
    ['document_forgery'] = {
        icon = 'id-card',
        blip = {
            name = locale('ui_type_document_forgery'),
            sprite = 498,
            color = 57,
            size = 0.75,
        },
        interior = {
            exit = {
                coords = vector4(1173.6333, -3196.6851, -39.0080, 90.0),
                target = vector3(1174.0386, -3196.6855, -38.8448),
            },
            laptop = vector3(1160.2932, -3192.8718, -39.1878),
            cctv = vector3(1156.0712, -3194.5017, -39.0003),
            stash = vector3(1171.7858, -3199.3518, -39.0277),
            guards = {
                vector4(1172.2919, -3194.4753, -39.0080, 180.0)
            },
            confiscate = vector3(1161.3427, -3190.3586, -39.0618)
        },
        product = {
            price = { min = 50, max = 100 }, -- Price per 1%
            prop = {
                model = `bkr_prop_fakeid_boxdriverl_01a`,
                bone = 28422,
                offset = vector3(0.0, -0.05, -0.15),
                rot = vector3(30.0, 0.0, 0.0),
                dict = 'anim@heists@box_carry@',
                clip = 'idle'
            }
        }
    }
}

-- Each business will produce 100% product per 200% supplies, encouraging players to do resupply missions
Config.product = {
    updateCron = '*/30 * * * *',
    add = 2.5, -- This % gets added to product every cycle
    remove = 5.0, -- This % get removed from supplies every cycle

    multipliers = {
        applyOnRemove = false, -- The multipliers will also be applied on the remove value
        employeeUpgrade = 1.25, --25% speed multiplier
        equipmentUpgrade = 1.25 --25% price multiplier
    },
}

Config.camera = {
    rotateSpeed = 0.3,
    controls = {
        left = 34,
        right = 35,
        up = 32,
        down = 33
    }
}

Config.stash = {
    shared = true,
    label = 'Business Stash',
    maxWeight = 250000,
    slots = 50
}

-- The buy supplies option
Config.supplies = {
    account = 'bank',
    price = 50000
}

Config.equipment = {
    account = 'bank',
    upgradePrice = 50000,

    -- The setup truck
    ---@type BlipData
    blip = {
        name = locale('equipment_truck'),
        sprite = 477,
        size = 0.75,
        color = 2
    },

    ---@type vector4[]
    locations = {
        vector4(941.4631, 3611.4692, 32.7135, 89.6993),
        vector4(647.3121, 176.3315, 95.6032, 340.4091),
        vector4(-572.1333, -1148.6094, 22.2848, 346.9533),
        vector4(1203.3523, 1864.5294, 78.5083, 139.5705),
        vector4(1062.4658, -1907.5056, 31.1398, 0.3939),
        vector4(-329.8174, -1489.8960, 30.7097, 268.6609)
    }
}

Config.employees = {
    account = 'bank',
    upgradePrice = 50000,
}

Config.security = {
    account = 'bank',
    price = 50000,
}

Config.guards = {
    weapon = `WEAPON_COMBATPISTOL`,
    scenario = 'WORLD_HUMAN_GUARD_STAND',
    accuracy = 25, -- from 0 - 100
    combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
}

Config.raiding = {
    enabled = false,
    chance = 10, -- The chance a business will get reported
    minBought = 2, -- The minimum required count of bought business, otherwise the chance would be too high for one business.
    needsProduct = true, -- The business needs to have at least 1% product
    accept = 10 * 60000, -- The time the police have to break inside the business
    duration = 30 * 60000, -- The maximal duration of the raid, the business will close after this elapses and the raid will be marked as unsuccessful
    interval = 60 * 60000,
    dispatchCode = '10-32',
    ---@type 'normal' | 'quasar'
    minigame = 'normal',

    -- The business will become available after seizedIntervals elapses
    -- Example: A business has been seized and will be available after 10 hours because each cycle is 1 hour (Config.raiding.interval)
    seizedIntervals = 6,
}

-- The minimum number of police to start resupplying and selling missions
Config.minPolice = {
    resupplying = 0,
    selling = 0
}

Config.resupplyMissions = {
    ['cartel'] = {
        ---@type { coords: vector4, vehicles: vector4[], guards: vector4[], props: { coords: vector4, model: string | number } }[]
        locations = {
            {
                coords = vector4(1247.2516, -2366.0352, 49.3186, 343.9325),
                vehicles = {
                    vector4(1257.9259, -2361.4883, 49.8645, 354.0425),
                    vector4(1253.9811, -2349.5713, 50.0204, 73.6613),
                    vector4(1241.3398, -2353.8369, 49.8999, 311.8073),
                    vector4(1235.2369, -2367.2939, 49.5255, 165.7329),
                    vector4(1249.1901, -2377.9646, 48.6501, 99.7752)
                },
                guards = {
                    vector4(1237.6757, -2369.4700, 49.2718, 252.4012),
                    vector4(1237.5541, -2369.3740, 49.2833, 248.4485),
                    vector4(1243.3423, -2355.4224, 49.8077, 228.5351),
                    vector4(1246.5724, -2348.6135, 50.0918, 9.9241),
                    vector4(1253.3312, -2351.3853, 50.1745, 161.8774),
                    vector4(1259.8169, -2353.9556, 50.3054, 315.0196),
                    vector4(1257.5078, -2365.2712, 49.6679, 184.3665),
                    vector4(1249.9053, -2376.0015, 48.7793, 23.0057),
                    vector4(1222.4058, -2363.8257, 50.2812, 231.2636),
                    vector4(1227.0367, -2356.5725, 50.2815, 235.3814),
                    vector4(1233.8109, -2347.3430, 50.1630, 233.6782),                    
                },
                props = {
                    {
                        coords = vector4(1250.2173, -2356.6824, 49.8315, 167.1767),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(1254.6758, -2371.3171, 49.2876, 242.2704),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(1241.2037, -2374.1599, 48.8868, 142.4322),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(1240.7836, -2362.3914, 49.5505, 254.7222),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(3260.8445, 5148.9897, 19.6015, 270.8692),
                vehicles = {
                    vector4(3260.0566, 5164.6260, 19.9007, 109.1142),
                    vector4(3243.0723, 5138.8618, 19.7438, 195.8629),
                    vector4(3273.4529, 5142.3936, 19.6453, 299.2679),
                    vector4(3283.3215, 5152.4692, 18.8560, 60.0525),
                    vector4(3251.9722, 5150.0708, 19.7956, 145.0475)
                },
                guards = {
                    vector4(3252.7336, 5148.7124, 19.5327, 238.8389),
                    vector4(3244.8921, 5138.6021, 19.5381, 299.2000),
                    vector4(3244.3145, 5131.8599, 19.6221, 88.9538),
                    vector4(3262.2454, 5147.7852, 19.5764, 205.9565),
                    vector4(3273.9915, 5144.3604, 19.3733, 47.6898),
                    vector4(3282.0476, 5151.5181, 18.7404, 147.9063),
                    vector4(3259.7664, 5162.5635, 19.6854, 207.8613),
                    vector4(3266.5623, 5156.2236, 19.8262, 147.4601),
                    vector4(3253.8633, 5152.9351, 19.6203, 328.4379),
                    vector4(3282.0247, 5145.6025, 18.8684, 74.1059)
                },
                props = {
                    {
                        coords = vector4(3271.1079, 5148.4321, 19.5150, 77.2254),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(3258.7161, 5157.7295, 19.6968, 207.4874),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(3250.0249, 5141.9653, 19.6071, 119.7399),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(1312.2173, 4330.1641, 38.2834, 176.5406),
                vehicles = {
                    vector4(1331.2623, 4333.0234, 38.0336, 355.4502),
                    vector4(1315.2561, 4354.9790, 41.0139, 77.4892),
                    vector4(1316.0438, 4339.0063, 39.0838, 225.6369),
                    vector4(1298.0200, 4330.1392, 38.6954, 160.4447),
                    vector4(1312.2784, 4315.4360, 38.2792, 268.3763)
                },
                guards = {
                    vector4(1332.8058, 4332.9849, 37.7383, 262.0412),
                    vector4(1317.4680, 4339.4346, 38.8252, 315.8046),
                    vector4(1304.6348, 4340.7881, 41.3209, 251.9367),
                    vector4(1314.5707, 4356.7607, 40.7894, 2.9773),
                    vector4(1313.8979, 4353.9341, 40.7230, 159.7679),
                    vector4(1313.3093, 4327.1787, 38.1933, 258.6804),
                    vector4(1313.0273, 4316.8408, 38.1429, 6.1273),
                    vector4(1298.9424, 4328.8877, 38.4436, 259.3924),
                    vector4(1332.1521, 4356.3657, 43.4204, 140.2391),
                    vector4(1329.5575, 4333.8315, 37.7848, 88.7987)
                },
                props = {
                    {
                        coords = vector4(1320.9781, 4329.9849, 38.1376, 53.4940),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(1304.9008, 4321.5825, 38.1312, 313.4237),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(1311.5784, 4346.3687, 39.8810, 276.2325),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(1323.6210, 4341.5645, 38.7482, 166.9133),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(598.0219, 2898.3708, 40.0361, 275.0382),
                vehicles = {
                    vector4(610.4671, 2888.2568, 39.6968, 313.2640),
                    vector4(578.6074, 2891.2913, 39.3005, 21.3415),
                    vector4(574.1249, 2913.0017, 40.2399, 336.1572),
                    vector4(620.4548, 2909.5325, 39.9254, 173.6038),
                    vector4(615.0797, 2926.6238, 40.4453, 59.1348)
                },
                guards = {
                    vector4(613.6083, 2925.8860, 40.2374, 153.5292),
                    vector4(618.9485, 2908.5688, 39.7241, 92.5984),
                    vector4(609.9965, 2889.6621, 39.4848, 49.3198),
                    vector4(579.4346, 2892.8777, 39.3218, 286.9238),
                    vector4(575.7310, 2913.2690, 39.9564, 250.1581),
                    vector4(597.8163, 2922.3762, 40.8367, 218.4974),
                    vector4(592.2086, 2935.8518, 40.9455, 11.7683),
                    vector4(606.9976, 2930.7051, 40.6803, 1.4256),
                    vector4(621.5616, 2920.4587, 39.8964, 319.5483),
                    vector4(598.1590, 2900.2490, 40.0107, 12.8860),
                    vector4(598.1119, 2896.3757, 39.9288, 187.1196),
                    vector4(573.7108, 2901.7791, 39.3940, 105.4415),
                    vector4(572.8996, 2924.1743, 40.6491, 88.1809)
                },
                props = {
                    {
                        coords = vector4(588.5804, 2910.8958, 40.1087, 193.5427),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(587.8481, 2891.1504, 39.5138, 173.2756),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(612.6086, 2916.5422, 39.9932, 149.8237),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(609.5984, 2900.8779, 39.6580, 49.2948),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            },
            {
                coords = vector4(-937.7779, 5575.5825, 3.2983, 309.6037),
                vehicles = {
                    vector4(-920.7260, 5589.5898, 3.0922, 222.9705),
                    vector4(-914.3781, 5571.6836, 3.7175, 161.5622),
                    vector4(-924.3270, 5552.7842, 6.8952, 295.4660),
                    vector4(-939.8539, 5549.0098, 6.6701, 72.3847),
                    vector4(-956.9144, 5561.4326, 4.2267, 36.6238)
                },
                guards = {
                    vector4(-921.0704, 5587.9741, 2.8933, 125.0736),
                    vector4(-915.8311, 5571.1655, 3.4397, 76.9503),
                    vector4(-924.2215, 5554.1558, 6.5372, 32.0661),
                    vector4(-940.2032, 5550.4233, 6.2854, 349.7626),
                    vector4(-956.4331, 5562.8984, 3.8412, 310.4549),
                    vector4(-940.0992, 5575.6465, 3.0749, 48.0636),
                    vector4(-938.2595, 5576.9531, 3.0243, 46.4240),
                    vector4(-915.3680, 5581.0835, 3.1566, 305.2593),
                    vector4(-917.6772, 5561.4639, 5.3167, 248.6042),
                    vector4(-931.5181, 5549.2554, 6.6343, 204.2613),
                    vector4(-948.8240, 5552.4956, 5.6190, 164.1301),
                },
                props = {
                    {
                        coords = vector4(-925.3185, 5578.0229, 3.0639, 300.3147),
                        model = `imp_prop_impexp_boxpile_01`
                    },
                    {
                        coords = vector4(-945.5035, 5566.7266, 3.5951, 162.1616),
                        model = `gr_prop_gr_crates_weapon_mix_01a`
                    },
                    {
                        coords = vector4(-931.8897, 5569.2427, 3.3516, 227.8054),
                        model = `p_secret_weapon_02`
                    },
                    {
                        coords = vector4(-945.5165, 5583.6265, 2.4797, 225.0863),
                        model = `imp_prop_impexp_boxwood_01`
                    }
                }
            }
        },
        
        failOnDeath = false, -- This will fail the mission once the player is dead
        duration = 30 * 60000, -- The player has this much time or the mission will cancel

        ---@type BlipData
        destinationBlip = {
            name = locale('cartel_site'),
            sprite = 456,
            size = 0.75,
            color = 1
        },

        suppliesBlip = {
            name = locale('supplies_vehicle'),
            sprite = 501,
            size = 0.85,
            color = 57
        },

        guard = {
            model = `g_m_m_armlieut_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
            blip = {
                name = locale('cartel_member'),
                sprite = 57,
                size = 0.4,
                color = 1
            },
            weapons = {
                `weapon_assaultrifle`,
                `weapon_compactrifle`
            }
        }
    },
    ['police'] = {
        locations = {
            { coords = vector4(-665.0396, -2380.0674, 13.9266, 240.0), target = vector3(-663.6684, -2380.8398, 14.2104) },
            { coords = vector(-632.5750, -1779.7797, 24.0103, 308.2451), target = vector3(-631.2947, -1778.8330, 24.5177) },
            { coords = vector4(962.5246, -1529.0660, 31.0475, 91.2167), target = vector3(960.9048, -1529.0809, 31.2324) },
            { coords = vector4(1191.9735, -1261.4790, 35.1752, 87.9828), target = vector3(1190.4578, -1261.3351, 35.7448) }
        },

        interior = {
            coords = vector4(970.9266, -2988.4470, -39.6484, 180.0),
            alarmCoords = vector3(982.6199, -3002.4810, -34.4820),
            vehicles = {
                vector4(977.0986, -3002.0845, -39.8487, 270.0),
                vector4(977.0986, -2997.3154, -39.8912, 270.0),
                vector4(977.0986, -3006.6050, -39.8912, 270.0),
                vector4(995.7874, -3021.5, -39.6622, 360.0),
                vector4(999.7745, -3021.5, -39.6626, 360.0),
                vector4(1003.2407, -3021.5, -39.6620, 360.0),
                vector4(997.7669, -3000.4524, -39.6630, 90.0),
                vector4(998.0952, -3005.2930, -39.6628, 90.0),
                vector4(998.2277, -3009.0459, -39.6624, 90.0),
                vector4(997.8085, -2996.7305, -39.6622, 90.0),
                vector4(961.4186, -3018.2314, -39.6622, 270.0),
                vector4(961.6453, -3023.4067, -39.6619, 270.0),
                vector4(961.6016, -3028.6191, -39.6625, 270.0),
                vector4(970.4099, -3029.8618, -39.6470, 0.0)
            },
            coveredVehicles = {
                vector4(984.6641, -3002.3271, -39.6469, 181.1243),
                vector4(984.7107, -3010.0347, -39.6469, 179.1576),
                vector4(988.0569, -2989.8015, -40.2737, 91.0512),
                vector4(993.3201, -2989.7971, -40.2739, 92.0380),
                vector4(998.4955, -2989.6277, -40.2740, 91.6626)
            },
            guards = {
                vector4(965.0439, -3003.5046, -39.6399, 93.8839),
                vector4(959.5746, -3001.1755, -39.6399, 273.4440),
                vector4(961.1934, -2994.5891, -39.6469, 99.8700),
                vector4(959.9212, -3010.6243, -39.6469, 186.2112),
                vector4(968.4106, -3003.5784, -39.6469, 269.9157),
                vector4(985.9042, -3010.2737, -39.6469, 273.7850),
                vector4(993.3632, -2992.7808, -39.6470, 184.7905),
                vector4(962.5853, -3016.9729, -39.6470, 357.5510),
                vector4(1005.7272, -3007.5935, -39.6470, 93.4400),
                vector4(1008.7323, -3021.8772, -39.6470, 95.5488),
                vector4(977.3017, -3031.1699, -39.6470, 92.5251)
            }
        },
        
        failOnDeath = false, -- This will fail the mission once the player is dead
        duration = 30 * 60000, -- The player has this much time or the mission will cancel

        ---@type BlipData
        destinationBlip = {
            name = locale('police_warehouse'),
            sprite = 473,
            size = 0.75,
            color = 1
        },
        
        suppliesBlip = {
            name = locale('supplies_vehicle'),
            sprite = 501,
            size = 0.85,
            color = 57
        },
       
        guard = {
            model = `s_m_y_cop_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
            ignorePolice = true, -- Ignores players with law enforcement jobs, can be configured in lunar_bridge/config/cl_edit.lua
            count = 8, -- The total count of the spawned guards, make sure this doesn't exceed the number of guard locations
            weapons = {
                `weapon_carbinerifle`,
                `weapon_combatpistol`
            }
        },

        -- The police vehicle models
        vehicles = {
            van = `policet`,
            other = {
                `police`,
                `police2`,
                `police3`
            }
        },

        minigame = 'ox_lib' -- Can be further configured in cl_edit.lua
    },
    ['bikers'] = {
        ---@type { coords: vector4, peds: vector4[] }[]
        locations = {
            vector4(105.4674, 3516.1650, 39.7811, 158.7030),
            vector4(2336.9668, 3099.4236, 48.0702, 53.5741),
            vector4(1116.6276, 3344.0469, 34.9756, 171.4902),
            vector4(2625.5308, 5184.0073, 44.7662, 14.4707),
            vector4(2295.0225, 5532.3945, 51.0836, 255.4049),
            vector4(1848.4862, 4580.3652, 36.1875, 98.3344),
            vector4(615.8569, 4240.2886, 54.1649, 93.7509),
            vector4(-1716.7965, 4801.3691, 59.1259, 130.3640),
            vector4(-2855.3928, 2188.2944, 33.4880, 121.2087),
            vector4(-1992.3380, 1909.4169, 186.0895, 247.7335),
            vector4(-430.7834, 2756.6204, 45.7026, 327.6571),
            vector4(928.4147, 2705.7185, 40.4900, 193.2399),
            vector4(1496.7501, 2128.5208, 89.8180, 192.7370),
        },
        
        bikeCount = 5,
        failOnDeath = false, -- This will fail the mission once the player is dead
        duration = 30 * 60000, -- The player has this much time or the mission will cancel

        suppliesBlip = {
            name = locale('supplies_vehicle'),
            sprite = 501,
            size = 0.85,
            color = 57
        },

        guard = {
            model = `g_m_y_lost_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 70, -- from 0 - 100, peds can start to run away if less than 50
            blip = {
                name = locale('mc_gang_member'),
                sprite = 270,
                size = 0.5,
                color = 1
            },
            weapons = {
                `weapon_microsmg`,
                `weapon_pistol`
            }
        }
    },
}

--- You can enable this on individual missions
Config.sellingDispatch = {
    code = '10-38',
    title = locale('contraband_transport'),
    message = locale('dispatch_message'),
    interval = 5000 -- How frequently should the vehicle blip update, I don't recommend lowering this
}

Config.sellingMissions = {
    ['heli'] = {
        spawnLocations = {
            vector4(1737.2762, 3288.9695, 41.1432, 195.1313),
            vector4(2127.0159, 4796.5254, 41.1410, 27.2316),
            vector4(2912.2065, 4385.3887, 50.2049, 23.8109),
            vector4(1696.6659, 4801.6987, 41.8139, 90.2743),
            vector4(309.8636, 2878.0466, 43.5068, 36.8846),
            vector4(833.0612, 2140.5862, 52.1965, 288.8540),
        },

        deliveryLocations = {
            vector4(583.9670, 192.0035, 137.2020, 255.0762),
            vector4(376.6259, -702.9108, 85.6122, 182.3180),
            vector4(-577.0567, 59.3893, 116.5382, 93.2602),
            vector4(-771.1755, 244.5480, 132.2933, 193.4232),
            vector4(-754.8808, 334.6453, 230.6368, 92.0278),
            vector4(751.9625, 1295.9928, 360.2964, 93.3296),
            -- vector4(972.9878, 38.1955, 123.1200, 59.5904),
            vector4(-1103.7469, -1677.4426, 4.4690, 131.2399),
            vector4(-696.5988, -1398.9912, 5.1503, 234.8294),
            vector4(-801.1472, -1341.5168, 5.1503, 354.7481),
            vector4(1213.6854, -1262.7292, 35.2267, 94.5558),
            vector4(1090.1874, -2279.2439, 30.1448, 271.1415),
            vector4(1557.4801, -2123.6709, 77.3325, 104.8235),
            vector4(1735.5421, -1614.1454, 112.4454, 100.9477),
            vector4(770.1660, -1776.7930, 49.3069, 267.0798),
            vector4(-514.9859, -2202.5020, 6.3940, 326.1316),
            vector4(-1560.8677, -569.0653, 114.4484, 40.0019),
            vector4(-1386.9302, -471.2593, 91.2578, 129.6345),
            vector4(-902.6803, -369.7690, 136.2820, 121.5296),
            vector4(232.8006, -1781.4396, 28.9484, 318.6662),
            vector4(536.1611, -1868.1776, 25.3320, 310.9467)
        },

        payoutLocations = {
            vector4(1726.1587, 3290.9607, 41.1870, 206.5707),
            vector4(2137.9722, 4796.8140, 41.1307, 21.8015)
        },

        duration = 30 * 60000,
        van = {
            model = `mule3`,
            offset = vector3(0.0, -3.6, 0.5)
        },
        productsPerLocation = { min = 1, max = 2, },
        stops = 1, -- 1 location per 25% of product
        account = 'money',

        ---@type BlipData
        deliveryBlip = {
            name = locale('heli_dropoff'),
            sprite = 1,
            color = 2,
            size = 0.75
        },

        helicopter = {
            model = `frogger`,
            offset = vector3(0.0, -1.0, 0.2), -- The interaction offset
            ---@type BlipData
            blip = {
                name = locale('heli'),
                sprite = 64,
                color = 2,
                size = 0.75
            }
        },

        payoutPed = {
            model = `s_m_y_armymech_01`,
            ---@type BlipData
            blip = {
                name = locale('payout_ped'),
                sprite = 431,
                color = 2,
                size = 0.9
            }
        },

        dispatch = {
            enabled = true,
            blip = { --The blip attached to the vehicle
                name = locale('contraband_heli'),
                sprite  = 422,
                size   = 1.0,
                color  = 1
            }
        }
    },
    ['plane'] = {
        spawnLocations = {
            vector4(1611.0337, 3302.6570, 41.9104, 282.0781),
            vector4(2127.0159, 4796.5254, 41.1410, 27.2316),
        },

        deliveryLocations = {
            vector3(289.2734, 3464.9768, 35.7487),
            vector3(-289.6734, 3084.8374, 34.4477),
            vector3(-732.1595, 2661.1379, 57.0199),
            vector3(-1366.6406, 2154.0066, 51.7221),
            vector3(-2098.4558, 2308.8042, 37.5695),
            vector3(-2545.7759, 1897.5160, 168.0480),
            vector3(-409.2971, 1183.5721, 325.5504),
            vector3(744.0992, 1293.5536, 360.2964),
            vector3(896.1061, 2179.9189, 49.2168),
            vector3(1029.9441, 2488.2441, 49.3473),
            vector3(1576.1831, 2212.5715, 78.7988),
            vector3(2339.2791, 2538.0339, 46.6672),
            vector3(2682.1182, 2840.0591, 40.0055),
            vector3(2643.0095, 3272.0735, 55.2206),
            vector3(1982.2487, 3775.3289, 32.1810),
            vector3(2173.0125, 3360.6670, 45.4538),
            vector3(1709.3025, 3866.0557, 34.8516),
            vector3(717.9826, 4175.7168, 40.7074),
            vector3(400.5365, 3573.3433, 33.2916),
            vector3(197.9259, 2792.7009, 45.6543),
            vector3(529.1071, 2633.6543, 42.2825),
            vector3(747.6173, 2522.8826, 73.1460),
            vector3(1366.9373, -579.5463, 74.3802),
            vector3(1148.2439, -1329.0793, 34.6567),
            vector3(1629.8605, -2253.0269, 107.1846),
            vector3(-88.0798, -2114.7114, 16.7048),
            vector3(-1181.4564, -1642.2559, 4.3739),
            vector3(-1308.5771, -1092.0389, 6.9965),
            vector3(-1382.0186, -558.0913, 30.2290),
            vector3(-1736.2837, 158.8942, 64.3711),
            vector3(-1171.9829, 89.5488, 58.0573),
            vector3(-772.9894, 153.1267, 67.4745),
            vector3(-1270.2065, 604.2950, 139.2678),
            vector3(-1763.3403, -1142.7482, 13.1078),
            vector3(102.3343, -1939.4664, 20.8037),
            vector3(482.0912, -1979.4932, 24.6279),
            vector3(771.3566, -233.1690, 66.1145)
        },

        payoutLocations = {
            vector4(1726.1587, 3290.9607, 41.1870, 206.5707),
            vector4(2137.9722, 4796.8140, 41.1307, 21.8015)
        },

        duration = 30 * 60000,
        van = {
            model = `mule3`,
            offset = vector3(0.0, -3.6, 0.5)
        },
        stops = 1, -- Locations per 25% of product, will get floored
        maxHeightAboveGround = 150.0,
        account = 'money',

        ---@type BlipData
        deliveryBlip = {
            name = locale('plane_dropoff'),
            sprite = 1,
            color = 60,
            size = 0.75
        },

        plane = {
            model = `cuban800`,
            offset = vector3(0.0, -0.8, -0.2),
            ---@type BlipData
            blip = {
                name = locale('plane'),
                sprite = 578,
                color = 2,
                size = 0.9
            }
        },

        payoutPed = {
            model = `s_m_y_armymech_01`,
            ---@type BlipData
            blip = {
                name = locale('payout_ped'),
                sprite = 431,
                color = 2,
                size = 0.9
            }
        },

        dispatch = {
            enabled = true,
            blip = { --The blip attached to the vehicle
                name = locale('contraband_plane'),
                sprite  = 578,
                size   = 1.0,
                color  = 1
            }
        }
    },
    ['plane2'] = {
        spawnLocations = {
            vector4(1618.3470, 3304.5527, 41.9282, 284.1730),
            vector4(2127.0159, 4796.5254, 41.1410, 27.2316),
        },

        duration = 30 * 60000,
        account = 'money', -- The reward account
        van = {
            model = `mule`,
            offset = vector3(0.0, -3.6, 0.5)
        },
        bags = 1.5, -- Per 25%

        plane = {
            model = `velum`,
            offset = vector3(0.0, -0.8, -0.2),
            ---@type BlipData
            blip = {
                name = locale('plane'),
                sprite = 582,
                color = 2,
                size = 0.9
            }
        },

        delivery = {
            coords = vector4(4497.6743, -4483.4932, 4.2003, 290.0),
            planeCoords = vector4(4489.2456, -4500.1743, 5.1185, 290.6390),
            playerCoords = {
                vector4(4490.6099, -4486.4126, 4.2048, 182.9219),
                vector4(4486.9951, -4487.4307, 4.2053, 198.7189),
                vector4(4482.8887, -4489.3262, 4.2026, 215.7588),
                vector4(4480.3994, -4491.5205, 4.1994, 231.2580)
            },
            ---@type BlipData
            blip = {
                name = locale('buyer'),
                sprite = 431,
                color = 2,
                size = 0.9
            }
        },

        dispatch = {
            enabled = true,
            blip = { --The blip attached to the vehicle
                name = locale('contraband_plane'),
                sprite  = 582,
                size   = 1.0,
                color  = 1
            }
        }
    }
}