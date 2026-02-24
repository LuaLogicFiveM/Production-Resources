---wip types

---@class OxStash
---@field name string
---@field label string
---@field owner? boolean | string | number
---@field slots number
---@field weight number
---@field groups? string | string[] | { [string]: number }
---@field blip? { id: number, colour: number, scale: number }
---@field coords? vector3
---@field target? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }

return {-- make a new line here and paste after copying ->

	{ --098
		coords = vec3(2806.3313, 4708.5767, 48.6274),
		name = 'evidencewcso3',
		groups = 'sheriff',
		label = 'Lockers Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --098
		coords = vec3(2805.4739, 4712.4116, 48.6273),
		name = 'evidencewcso2',
		groups = 'sheriff',
		label = 'Evidence Safe',
		owner = false,
		slots = 100,
		weight = 500000
	},

	{ --596
		coords = vec3(343.7516, 193.0693, 98.6465),
		name = 'chbcinema',
		label = 'Cinema Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --yellobelly
		coords = vec3(-2996.9468, 4307.4302, 24.8736),
		name = 'belly',
		label = 'Drag Strip Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --war in woods
		coords = vec3(3872.0669, 5244.5532, 17.6564),
		name = 'war',
		label = 'Drag Strip Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --Greasy joes 866
		coords = vec3(-303.1689, -1466.1479, 30.6098),
		name = 'greasy_joes',
		label = 'Greasy Joes Storage',
		groups = 'greasy',
		owner = false,
		slots = 100,
		weight = 500000
	},

	{ --yellowbelly
		coords = vec3(-2995.5320, 4294.0972, 24.8779),
		name = 'yellobelly',
		groups = {["yellobelly"] = 0},
		label = 'Yello Belly Safe',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--ems9
		coords = vec3(1108.0513, 2731.1108, 38.7120),
		name = 'ems_lockers',
		label = 'EMS Lockers',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--sheriff
		coords = vec3(2801.1035, 4706.7314, 48.6275),
		name = 'bcso_lockers',
		label = 'Sheriff Lockers',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--sheriff
		coords = vec3(849.3484, -1288.5409, 26.7212),
		name = 'sahp_lockers',
		label = 'SAHP Lockers',
		groups = 'sahp',
		owner = true,
		slots = 100,
		weight = 500000
	},

	----------------------------- Business -----------------------------

	{ --473
		coords = vec3(-571.3948, 290.0007, 79.1767),
		name = 'tequila',
		label = 'Property Safe',
		owner = true,
		slots = 100,
		weight = 400000
	},

	--------------------------- Gun Store ---------------------------

	{-- 745
		coords = vec3(11.9419, -1097.6007, 28.4077),
		name = 'gunstore1',
		label = 'Gun Storage',
		owner = true,
		slots = 100,
		weight = 400000
	},

	{ --745
		coords = vec3(26.1713, -1096.5328, 28.4047),
		name = '07tyymanison',
		label = 'Mansion Safe 3',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --745
		coords = vec3(3.6739, -1108.2510, 29.1093),
		name = '428mansion2',
		label = 'Mansion Safe 2',
		groups = {["Gunstore_SFF"] = 0},
		owner = false,
		slots = 100,
		weight = 500000
	},

	{ --778
		coords = vec3(1745.6855, -1579.5701, 113.2465),
		name = 'gunstore778',
		label = 'Gun Store 778 Safe',
		groups = {["gunstore_778"] = 0},
		owner = false,
		slots = 100,
		weight = 500000
	},

	{ --778
		coords = vec3(1738.2019, -1585.6476, 113.2465),
		name = 'gunstore7782',
		label = 'Gun Store 778 Safe 2',
		owner = true,
		slots = 100,
		weight = 1200000
	},

	{ --807
		coords = vec3(813.0416, -2189.9316, 27.5452),
		name = 'ruffblock',
		label = 'Gun Store 807 Safe',
		owner = true,
		slots = 100,
		weight = 1000000
	},

	{ --807
		coords = vec3(823.6882, -2163.1990, 28.2298),
		name = 'gunstore8072',
		label = 'Gun Store 807 Safe 2',
		groups = {["gunstore_807"] = 0},
		owner = false,
		slots = 100,
		weight = 500000
	},

	--------------------------- Weed Shops ---------------------------

	{ --616
		coords = vec3(181.6258, -264.8807, 53.9662),
		name = 'leafnlatte',
		label = 'LeafnLatte Safe',
		owner = true,
		slots = 100,
		weight = 1600000
	},

	{ --616
		coords = vec3(160.6078, -247.4000, 44.6279),
		name = 'leafnlattegrow',
		groups = {["leafnlatte"] = 0},
		label = 'LeafnLatte Grow Safe',
		owner = false,
		slots = 100,
		weight = 500000
	},

	{ --635
		coords = vec3(-494.8457, 39.4574, 38.6666),
		name = 'khusbites1',
		label = 'KhusBites Storage',
		owner = true,
		slots = 100,
		weight = 700000
	},

	{--635
		coords = vec3(-519.5195, 51.5062, 44.5919),
		name = 'khusbites',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	----------------------------- Motorcycle Clubs -----------------------------

	{ --920
		coords = vec3(74.6523, -2576.7202, 6.0621),
		name = '920gang',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --698
		coords = vec3(-1184.6678, -1195.8805, 11.6122),
		name = 'rebelsmc',
		label = 'Safe',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --698
		coords = vec3(-1194.7321, -1159.0924, 7.7744),
		name = 'hellsangels',
		label = 'Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{--905
		coords = vec3(-713.4005, -2478.5703, 14.4384),
		name = 'mayans',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --905
		coords = vec3(-739.2383, -2492.7627, 14.4384),
		name = 'mayansextra',
		label = 'MC Safe 1',
		owner = true,
		slots = 100,
		weight = 200000
	},

	{ --905
		coords = vec3(-697.8346, -2486.2358, 14.4384),
		name = 'mayansmc',
		label = 'MC Safe 2',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --636
		coords = vec3(-447.0043, 267.8794, 83.0018),
		name = 'soablock1',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --636
		coords = vec3(-444.9695, 266.3794, 86.1996),
		name = 'soablock2',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --636
		coords = vec3(-444.5677, 271.8705, 83.0087),
		name = 'soablock3',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --804
		coords = vec3(1007.0112, -2546.5293, 28.3052),
		name = '804gang',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --804
		coords = vec3(1000.6808, -2536.5303, 33.4931),
		name = 'soa804',
		label = 'Gang Safe',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --504
		coords = vec3(-61.6199, 367.9772, 112.4081),
		name = '504storage',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	----------------------------- Gang Blocks -----------------------------

	{ -- 573
		coords = vec3(1233.9845, -404.1974, 68.8613),
		name = 'mayanssafe',
		label = 'House Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --693
		coords = vec3(-1128.4812, -1601.4275, 4.4069),
		name = 'i84storage3',
		label = 'Bama Boss Safe 1',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --693
		coords = vec3(-1138.1722, -1600.4321, 4.4069),
		name = 'i84storage2',
		label = 'Bama Customs Safe 2',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --693
		coords = vec3(-1137.4819, -1601.4432, 4.4069),
		name = 'i84storage1',
		label = 'Bama Customs Safe 1',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --693
		coords = vec3(-1120.5908, -1627.7467, 4.4070),
		name = 'i84storage4',
		label = 'Mechanic Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--693
		coords = vec3(-1144.0334, -1559.3363, 7.6170),
		name = 'bmf',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 1000000
	},

	{ --827
		coords = vec3(496.2433, -1490.6432, 29.2972),
		name = '827lafamilia',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --838
		coords = vec3(157.2854, -1706.1122, 29.2929),
		name = 'vato',
		label = 'Gang Block Safe',
		owner = true,
		slots = 100,
		weight = 1000000
	},

	{ --838
		coords = vec3(153.7816, -1710.7223, 29.2929),
		name = 'vice2',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --672
		coords = vec3(-1579.6012, -241.1632, 55.0430),
		name = '672gang',
		label = 'Gang Safe',
		owner = true,
		slots = 100,
		weight = 1000000
	},

	{ --853
		coords = vec3(-51.5656, -1448.8092, 29.6518),
		name = 'fdb2',
		label = 'Gang Safe',
		owner = true,
		slots = 100,
		weight = 1500000
	},

	{ --853
		coords = vec3(-18.7686, -1473.0811, 29.7442),
		name = 'spllc',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 1200000
	},

	----------------------------- Shops -----------------------------


	{ --260
		coords = vec3(1188.7135, 2641.8433, 38.4018),
		name = 'shop',
		label = 'Shop Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{--045
		coords = vec3(-257.1680, 6148.2446, 35.7104),
		name = 'hayes1',
		label = 'Garage Storage',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --099
		coords = vec3(2734.1990, 4928.6895, 33.6912),
		name = 'moosecustoms',
		label = 'Shop Safe',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --887
		coords = vec3(-1080.2115, -2082.9504, 21.2854),
		name = 'royals',
		label = 'Royals Safe',
		owner = true,
		slots = 100,
		weight = 2500000
	},

	{ --685
		coords = vec3(-2036.0557, -509.4467, 12.2130),
		name = 'westcoastcustoms',
		groups = {["highstreet"] = 0},
		label = 'Shop Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --685
		coords = vec3(-2035.7081, -509.7525, 12.2130),
		name = 'bunkermlo',
		label = 'Shop Storage',
		owner = true,
		slots = 100,
		weight = 600000
	},

	{ --334
		coords = vec3(2519.3691, 2628.6062, 37.9454),
		name = 'rexsdiner',
		label = 'Mechanic Storage',
		groups = {["elevatedcustoms"] = 0},
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --013
		coords = vec3(-769.6448, 5855.0068, 23.4530),
		name = 'kenny',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 200000
	},
		{ --013
		coords = vec3(-767.9029, 5875.9800, 16.8582),
		name = '013mansion',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 200000
	},

	{--228
		coords = vec3(178.7447, 2754.7583, 43.5230),
		name = 'barnshop1',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 200000
	},

	{ --542
		coords = vec3(1449.9147, 1698.7473, 114.3504),
		name = 'johnny1',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 200000
	},

	{ --111
		coords = vec3(1999.2277, 4594.2119, 45.0097),
		name = 'randoms',
		label = 'Shop Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--262
		coords = vec3(1329.9625, 2631.6960, 39.2983),
		name = 'shop262',
		label = '262 Shop Storage',
		owner = true,
		slots = 100,
		weight = 200000
	},

	{ --592
		coords = vec3(697.6691, 171.1083, 89.7783),
		name = 'westcoastdesigns',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 1500000
	},

	{ --592
		coords = vec3(695.3850, 152.9634, 80.7715),
		name = 'autoexotics',
		label = 'Garage Storage',
		owner = false,
		slots = 100,
		weight = 250000
	},

	{ --592
		coords = vec3(685.4990, 120.4448, 80.7716),
		name = 'autoexotics2',
		label = 'Garage Storage',
		owner = false,
		slots = 100,
		weight = 250000
	},

	{ --745
		coords = vec3(-28.9122, -1103.4205, 26.4223),
		name = '745garage',
		label = 'Shop Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	----------------------------- Houses/Mansions -----------------------------

	--[[{--481
		coords = vec3(-750.6185, 812.8331, 216.9893),
		name = 'vinewoodmansion',
		label = 'Mansion',
		owner = true,
		slots = 100,
		weight = 500000
	},]]

	{--481 new
		coords = vec3(-750.6185, 812.8331, 216.9893),
		name = 'mansion_481',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--444
		coords = vec3(-1886.2395, 649.6562, 129.9979),
		name = 'random1',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 5000000
	},

	{--444
		coords = vec3(-1893.3413, 654.2553, 129.9978),
		name = 'random2',
		label = 'Mansion Storage',
		owner = false,
		slots = 100,
		weight = 10000000
	},

	{--506
		coords = vec3(166.2338, 662.5651, 208.9282),
		name = 'house_506',
		label = '506 House Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{--johnny new house 486
		coords = vec3(-298.5906, 706.5076, 209.0398),
		name = 'house_486',
		label = '486 House Storage',
		owner = true,
		slots = 100,
		weight = 1000000
	},

	{ --453
		coords = vec3(-1533.0267, 151.1834, 56.1052),
		name = 'playboymansion',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --688 island
		coords = vec3(-2448.9473, -1182.6455, 16.7683),
		name = 'rebels',
		label = 'House Safe',
		owner = true,
		slots = 100,
		weight = 800000
	},

	{ --774
		coords = vec3(1406.3729, -1499.5750, 55.8946),
		name = '428mansion3',
		label = 'Mansion Safe 1',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --774
		coords = vec3(1445.2839, -1488.5142, 66.6192),
		name = 'empiremansion2',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 400000,
	},

	{--425
		coords = vec3(-2821.1675, 1426.4192, 100.9920),
		name = 'ghost1',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --425
		coords = vec3(-2821.2583, 1432.6946, 100.9921),
		name = '425mansion',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 200000
	},

	{ --425
		coords = vec3(-2827.4817, 1441.9807, 101.1106),
		name = 'crimsonangels',
		label = 'La Familia MC Safe',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --425
		coords = vec3(-2829.8037, 1442.0310, 101.1106),
		name = '827lafamilia1',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --425
		coords = vec3(-2837.6096, 1442.4304, 101.3559),
		name = '827lafamilia2',
		label = 'Gang Storage',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --073
		coords = vec3(2555.4775, 6184.5068, 168.3996),
		name = 'isalndsafe',
		label = 'Island Safe',
		owner = true,
		slots = 100,
		weight = 1500000
	},

	{ --588
		coords = vec3(854.3438, -171.9444, 75.3603),
		name = 'bmf_mansion',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --588
		coords = vec3(846.9677, -180.7743, 78.4648),
		name = 'bmf_mansion2',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 1300000
	},

	{ --699
		coords = vec3(-1121.4109, -1086.2214, 6.6936),
		name = 'creeker',
		label = 'House Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

-------------------------------------------------------------------------------------------------------

	--[[{ --346
		coords = vec3(2416.1223, 1546.2640, 40.9683),
		name = 'shop1',
		label = 'Shop Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},]]--

	--[[{ --141
		coords = vec3(712.2542, 4184.2583, 40.9043),
		name = '141shop',
		label = 'Garage Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},]]--

	{ --221
		coords = vec3(-2022.0997, 445.1540, 105.8772),
		name = 'mansion555',
		label = 'Garage Storage 2',
		owner = true,
		slots = 100,
		weight = 300000
	},

	{ --221
		coords = vec3(-2014.8967, 447.3160, 105.8771),
		name = 'mansion',
		label = 'Garage Storage',
		owner = true,
		slots = 100,
		weight = 150000
	},

	{--647
		coords = vec3(-804.8604, 177.3513, 72.8346),
		name = 'michael1',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--502
		coords = vec3(9.5795, 528.8137, 170.6173),
		name = 'franklin1',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{--747
		coords = vec3(-660.3583, -863.5031, 24.5110),
		name = 'malibuclub',
		label = 'Storage',
		owner = true,
		slots = 100,
		weight = 200000
	},

	--[[{--640
		coords = vec3(-545.1324, -203.8966, 38.2152),
		name = 'lost_box',
		label = 'Lost Box',
		owner = true,
		slots = 100,
		weight = 1000000
	},

	{--640
		coords = vec3(1749.9674, 3804.8789, 43.1966),
		name = 'lost_box2',
		label = 'Lost Box',
		owner = true,
		slots = 100,
		weight = 1000000
	},]]

	{ --180
		coords = vec3(91.8945, 3754.5447, 40.7748),
		name = 'obs', -- obs
		label = 'OBS Storage',
		owner = false,
		slots = 100,
		weight = 100000
	},

	{ --876
		coords = vec3(-1069.2197, -2102.3411, 13.2617),
		name = 'srtmotors',
		label = 'Mechanic Safe',
		owner = false,
		slots = 100,
		weight = 100000
	},

	{ --054
		coords = vec3(-500.7234, 5509.2827, 85.5141),
		name = '054storage',
		label = 'Property Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --574
		coords = vec3(1138.7134, -791.7203, 57.6025),
		name = 'elevatedcustoms',
		label = 'Elevated Customs Storage',
		groups = {["elevatedcustoms"] = 0},
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --635
		coords = vec3(-432.5601, 30.7139, 46.2948),
		name = 'weedland',
		label = 'Business Safe',
		groups = {["hookahloungev2"] = 0},
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --677
		coords = vec3(-1376.1740, -600.8563, 36.5085),
		name = 'bahamammas',
		groups = {["bahama"] = 0},
		label = 'Bahama Mamams Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --944
		coords = vec3(769.3392, -3184.6484, 6.0195),
		name = 'webbysscustoms',
		groups = {["southern"] = 0},
		label = 'Mechanic Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --932
		coords = vec3(-1516.7887, 1944.6616, 61.7356),
		name = 'donbennetpaid4',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --932
		coords = vec3(-1513.8994, 1938.7140, 61.7356),
		name = 'donbennetpaid3',
		label = 'Mansion Safe 3',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --932
		coords = vec3(-1512.1528, 1936.9639, 61.7356),
		name = 'donbennetpaid2',
		label = 'Mansion Safe 2',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --932
		coords = vec3(-1531.5219, 1892.6000, 67.1794),
		name = 'donbennetpaid1',
		label = 'Mansion Safe 1',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --526
		coords = vec3(-70.9867, -436.2767, 37.2673),
		name = '526mansion',
		label = 'Garage Storage',
		owner = true,
		slots = 100,
		weight = 500000
	},

	{ --846
		coords = vec3(90.9266, -1929.1229, 16.5821),
		name = 'vicelordsgang3',
		label = 'Gang Storage 2',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --846
		coords = vec3(102.4676, -1931.6040, 16.550),
		name = 'vicelordsgang2',
		label = 'Gang Storage 1',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --932
		coords = vec3(505.1847, -2757.3499, 3.0706),
		name = 'donbennetsstoragemlo',
		label = 'Mansion Storage',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{ --582
		coords = vec3(977.1728, -104.1468, 74.8452),
		name = 'soagangsafe',
		label = 'Gang Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},

	{  --538
		coords = vec3(1410.0706, 1062.4667, 114.3972),
		name = 'empirecustoms',
		label = 'Mansion Safe',
		owner = true,
		slots = 100,
		weight = 100000
	},
}