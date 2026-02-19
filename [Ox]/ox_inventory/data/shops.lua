---@class OxShop
---@field name string
---@field label? string
---@field blip? { id: number, colour: number, scale: number }
---@field inventory { name: string, price: number, count?: number, currency?: string }
---@field locations? vector3[]
---@field targets? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }[]
---@field groups? string | string[] | { [string]: number }
---@field model? number[]

return {
	General = {
		name = 'Corner Store',
		blip = {
			id = 59, colour = 69, scale = 0.65
		}, inventory = {
			{ name = 'gps', price = 5000 },
			{ name = 'diamond_dice', price = 250 },
			{ name = 'wooden_dice', price = 250 },
			{ name = 'god_dice', price = 250 },
			{ name = 'death_dice', price = 250 },
			{ name = 'outfitbag', price = 500 },
			{ name = 'phone', price = 2500 },
			{ name = 'tablet', price = 5000 },
			{ name = 'radio', price = 2500 },
			{ name = 'cups', price = 1000 },
			{ name = 'kq_tow_rope', price = 250 },
			{ name = 'kq_winch', price = 250 },
			{ name = 'banana', price = 1000 },
			{ name = 'bed1', price = 1000 },
			{ name = 'circle', price = 1000 },
			{ name = 'inflatable', price = 1000 },
			{ name = 'parasailing', price = 1000 },
			{ name = 'ski', price = 1000 },
			{ name = 'binoculars', price = 1000 },
			{ name = 'backpack', price = 5000 },
			{ name = 'tirekit', price = 500 },
			{ name = 'repairkit', price = 750 },
			{ name = 'advancedrepairkit', price = 1000 },
			{ name = 'cleaningkit', price = 100 },
			{ name = 'parachute', price = 1000 },
		}, locations = {
			vec3(42.7479, -1490.0276, 29.7974), -- Addon Forum
			vec3(2004.0485, 3783.9221, 32.2032), -- Addon Sandy
			vec3(1961.3939, 3740.9080, 32.3435), -- Sandy
			vec3(-710.3340, -912.0389, 19.2162), -- Little Seoul (726)
			vec3(-48.9269, -1754.0023, 29.4234), -- Grove
			vec3(25.9079, -1347.2769, 29.4968), -- Forum (850)
			vec3(-3039.5491, 585.8921, 7.9087), -- Route 1 (437)
			vec3(-3242.2739, 1001.5110, 12.8304), -- Route 1 (433)
			vec3(1729.2518, 6414.6011, 35.0369), -- Route 1 (070)
			vec3(1701.8629, 4925.4019, 42.0667), -- Grapeseed (116)
			vec3(547.6533, 2671.0789, 42.1562), -- Route 68 (242)
			vec3(2678.8252, 3280.7148, 55.2409), -- Youtool (308)
			vec3(2556.8984, 358.1658, 108.7782), -- Route 15 (557)
			vec3(373.9681, 326.1499, 103.5661), -- Vinewood (594)
			vec3(1160.2906, -321.8399, 69.2077), -- Mirror Park North (581)
			vec3(1054.9681, 3570.8691, 34.3499), -- Sandy BP
		}
	},

	Liquor = {
		name = 'Liquor Store',
		inventory = {
			{ name = 'bacardi', price = 100 },
			{ name = 'barefoot', price = 100 },
            { name = 'casadelsol', price = 100 },
            { name = 'casamigos_a', price = 100 },
			{ name = 'casamigos_b', price = 100 },
			{ name = 'casamigos_c', price = 100 },
			{ name = 'casamigos_d', price = 100 },
			{ name = 'ciroc_passion', price = 100 },
			{ name = 'ciroc_pomeranate', price = 100 },
			{ name = 'ciroc_summer', price = 100 },
			{ name = 'crown', price = 100 },
			{ name = 'donjulio', price = 100 },
			{ name = 'dusse', price = 100 },
			{ name = 'everclear', price = 100 },
			{ name = 'hennessy_black', price = 100 },
			{ name = 'hennessy_gold', price = 100 },
			{ name = 'hennessy_nba', price = 100 },
			{ name = 'hennessy_vsop', price = 100 },
            { name = 'jack_daniel_og', price = 100 },
			{ name = 'jack_daniel_berry', price = 100 },
			{ name = 'jack_daniel_cola', price = 100 },
			{ name = 'jack_daniel_downhome', price = 100 },
			{ name = 'jack_daniel_lemonade', price = 100 },
			{ name = 'jack_daniel_peach', price = 100 },
			{ name = 'remy_martin', price = 100 },
			{ name = 'skyy_orange', price = 100 },
			{ name = 'skyy_citrus', price = 100 },
			{ name = 'skyy_strawberry', price = 100 },
			{ name = 'skyy_peach', price = 100 },
			{ name = 'skyy_pineapple', price = 100 },
			{ name = 'skyy_vanilla', price = 100 },
			{ name = 'smirnoff_lemonade', price = 100 },
			{ name = 'smirnoff_rasberry', price = 100 },
			{ name = 'stella_berry', price = 100 },
			{ name = 'stella_black', price = 100 },
			{ name = 'stella_rose', price = 100 },
			{ name = 'tanqueray', price = 100 },
			{ name = 'taylor_port', price = 100 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415), -- Mirror Park South (771)
			vec3(-1222.915, -906.983, 12.326), -- Vespucci (700)
			vec3(-2968.243, 390.910, 15.043), -- Route 1 Liquor (438)
			vec3(-1487.553, -379.107, 40.163), -- Vinewood West (671)
			vec3(1985.1747, 3048.9854, 47.2157), --273
            vec3(1165.9974, 2709.3225, 38.1577), --260
			vec3(-1570.9305, -220.1287, 55.0430), --672
			vec3(-2845.4465, 1417.7711, 101.1663), --425 
			vec3(-2863.1038, 1400.5110, 85.7913), --425
			vec3(-1144.4880, -1562.2920, 4.4390), --693 BMF
            vec3(-2020.5563, 446.4810, 103.0212), --221
			vec3(1441.8060, -1487.9138, 63.7032), --428
			vec3(-1139.2839, -1604.2300, 4.410), --693
			vec3(-57.1871, -1448.9584, 29.6612), --853
			vec3(988.5748, -94.1765, 74.8451), --582
			vec3(1236.1381, -402.4240, 68.8614), --573
			vec3(-431.6221, 285.0650, 83.0086), --636
			vec3(164.5120, -1692.0590, 23.5837), --838
			vec3(-1186.7477, -1169.8160, 7.0544), --698
			vec3(1030.0303, -2520.0012, 28.2796),--804
			vec3(-775.1206, 5861.6514, 16.8444), --013
			vec3(941.0328, -1550.4102, 34.4187), --796
			vec3(-561.7194, 288.0380, 82.1765), --473
			vec3(1152.2715, -792.5700, 61.0177), --574
			vec3(149.1791, -3013.0608, 7.0409), --927
			vec3(-1123.0125, -2106.7883, 13.3718), --887
			vec3(2006.0791, 4591.4312, 45.0097), --111
			vec3(1457.1683, 1688.1732, 110.9059), --542
			vec3(-734.8427, -2480.4521, 14.4384), --905	
			vec3(692.1220, 173.0534, 89.7781), --592
			vec3(97.1469, -2575.6077, 6.1819), --920
			vec3(131.3262, -664.7147, 29.7102), --747
			vec3(-304.8568, 683.3286, 209.0377), -- 486
			vec3(157.0093, 663.2510, 208.9282), -- 506
			vec3(-762.1150, 804.0409, 215.1885), -- 481
			vec3(-1899.1115, 648.0126, 129.9977), -- 444
			vec3(-1525.2559, 1901.0488, 61.7356), -- 411
		}
	},

	Ammunation = {
		name = 'Ammu-Nation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'WEAPON_HELLCAT', price = math.random(5000, 7500), metadata = { registered = true }, license = 'weapons_license' },
			{ name = 'WEAPON_G41', price = math.random(5000, 7500), metadata = { registered = true }, license = 'weapons_license' },
			{ name = 'WEAPON_TANFNX45', price = math.random(5000, 7500), metadata = { registered = true }, license = 'weapons_license' },
			{ name = 'WEAPON_DRACO', price = math.random(50000, 75000), metadata = { registered = true }, license = 'weapons_license' },
			{ name = 'WEAPON_KNUCKLE', price = math.random(50000, 75000), metadata = { registered = true }, license = 'weapons_license' },
			{ name = 'ammo-9', price = math.random(5, 10) },
			{ name = 'ammo-45', price = math.random(8, 14) },
			{ name = 'ammo-762', price = math.random(15, 22) },
		}, locations = {
			vec3(-662.2047, -934.9218, 21.8292), -- Little Seoul (726)
			--vec3(818.0451, -2154.9829, 28.9313), -- Docks Gun (807)
			vec3(-330.4912, 6084.1929, 31.4548), -- Paleto Gun (046)
			vec3(252.4721, -50.2927, 69.9410), -- Vinewood Gun (605)
			--vec3(13.5620, -1106.4865, 29.1091), -- Main Gun (745)
			vec3(2567.6804, 293.9577, 108.7348), -- Route 15 Gun (557)
			vec3(-1117.9272, 2698.8850, 18.554), -- Route 68 Gun (403)
			vec3(842.2874, -1033.9380, 28.1948), -- Popular St. Gun (769) 
        	vec3(1693.3412, 3759.9043, 34.7053), -- Sandy Gun (285)
		}
	},

	--[[IDShop = {
		name = 'License Shop',
		inventory = {
			{ name = 'id_card', price = 500 },
			{ name = 'driver_license', price = 150 },
			{ name = 'weapons_license', price = 150 },
			{ name = 'medical_license', price = 150 },
			{ name = 'boating_license', price = 150 },
			{ name = 'hunting_license', price = 150 },
			{ name = 'fishing_license', price = 150 },
			{ name = 'commercial_license', price = 150 },
		}, locations = {
			vec3(1753.8656, 3806.2524, 35.4485),
		}
	},]]

	Paintball = {
		name = 'Paintball Store',
		inventory = {
			{ name = 'WEAPON_PAINTBALL', price = 1000 },
			{ name = 'ammo-paintballs', price = 5 },
		}, locations = {
			vec3(588.3597, 2752.5881, 42.1425),
		}
	},

	Pawn_Shop = {
		name = 'Pawn Shop',
		blip = {
			id = 52, colour = 46, scale = 0.8
		}, inventory = {
			{ name = 'hydrogen_peroxide', price = math.random(2500, 3000), currency = 'black_money' },
			{ name = 'gruppesechstablet', price = math.random(5000, 10000), currency = 'black_money' },
			{ name = 'graffiti_spray', price = math.random(1500, 2000), currency = 'black_money' },
			{ name = 'graffiti_remover', price = math.random(1500, 2000), currency = 'black_money' },
			{ name = 'glass_cutter', price = math.random(5000, 10000), currency = 'black_money' },
			{ name = 'cable_cutter', price = math.random(5000, 10000), currency = 'black_money' },
			{ name = 'screwdriver_bank', price = math.random(5000, 10000), currency = 'black_money' },
			{ name = 'screwdriver_jewelry', price = math.random(5000, 10000), currency = 'black_money' },
			{ name = 'drill', price = math.random(500, 1000), currency = 'black_money' },
			{ name = 'hacking_device', price = math.random(500, 1000), currency = 'black_money' },
			--{ name = 'rope', price = math.random(35000, 50000), currency = 'black_money' },
			--{ name = 'knife', price = math.random(20000, 25000), currency = 'black_money' },
			--{ name = 'grinder', price = math.random(25000, 30000), currency = 'black_money' },
            { name = 'lockpick', price = math.random(2500, 5000), currency = 'black_money' },
            { name = 'lockpick_door', price = math.random(2500, 5000), currency = 'black_money' },
            { name = 'lockpick_house', price = math.random(2500, 5000), currency = 'black_money' },
            { name = 'bobby_pin', price = math.random(10000, 15000), currency = 'black_money' },
		}, locations = {
			vec3(412.0476, 315.0938, 103.1327),
		},
	},

	Sheriff = {
		name = 'Sheriff Armory',
		groups = {['sheriff'] = 0},
		inventory = {
			{ name = 'armour', price = 0 },
			{ name = 'bodycam', price = 0 },
			{ name = 'dashcam', price = 0 },
			{ name = 'alcohol_tester', price = 0 },
			{ name = 'tablet', price = 0 },
			{ name = 'tracking_bracelet', price = 0 },
			{ name = 'tintmeter', price = 0 },
			{ name = 'spikestrip', price = 0 },
			{ name = 'evidence_laptop', price = 0 },
			{ name = 'evidence_box', price = 0 },
			{ name = 'hydrogen_peroxide', price = 0 },
			{ name = 'fingerprint_scanner', price = 0 },
			{ name = 'spy_microphone', price = 0, grade = 6 },
			{ name = 'forensic_kit', price = 0, grade = 6 },
			{ name = 'WEAPON_PROLASER4', price = 0 },
			{ name = 'WEAPON_BOLAWRAP', price = 0 },
			{ name = 'WEAPON_PEPPERSPRAY', price = 0 },
			{ name = 'WEAPON_ANTIDOTE', price = 0 },
			{ name = 'WEAPON_FLASHBANG', price = 0, grade = 11 },
			{ name = 'WEAPON_AIRSOFTR870', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_AIRSOFTM4', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_AIRSOFTGLOCK20', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_SIG_SAUCER', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_GLOCK19GEN4', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_GLOCK20', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 5 },
			{ name = 'WEAPON_FBIARB', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_FM1_BENELLIM4', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 1 },
			{ name = 'WEAPON_M870', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 2 },
			{ name = 'WEAPON_HK417', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 3 },
			{ name = 'WEAPON_LWRC', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 4 },
			{ name = 'WEAPON_KS1', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 5 },
			{ name = 'WEAPON_LBRS', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 6 },
			{ name = 'WEAPON_SIG516', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 7 },
			{ name = 'WEAPON_P90', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 9 },
			{ name = 'WEAPON_HEAVYSNIPER', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 11 },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'WEAPON_FLASHLIGHT', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'WEAPON_BEANBAG', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'taser_cartridge', price = 3, },
			{ name = 'ammo-beanbag', price = 3, },
			{ name = 'ammo-9', price = 3, },
			{ name = 'ammo-10', price = 25, },
			{ name = 'ammo-556', price = 50, },
			{ name = 'ammo-762', price = 50, },
			{ name = 'ammo-12', price = 80, grade = 1 },
			{ name = 'ammo-50', price = 1000, grade = 11 },
		}, locations = {
			vec3(2808.6812, 4722.2500, 48.6273)
		}
	},

	SAHP = {
		name = 'State Patrol Armory',
		groups = {['sahp'] = 0},
		inventory = {
			{ name = 'armour', price = 0 },
			{ name = 'bodycam', price = 0 },
			{ name = 'dashcam', price = 0 },
			{ name = 'alcohol_tester', price = 0 },
			{ name = 'tablet', price = 0 },
			{ name = 'tracking_bracelet', price = 0 },
			{ name = 'tintmeter', price = 0 },
			{ name = 'spikestrip', price = 0 },
			{ name = 'evidence_laptop', price = 0 },
			{ name = 'evidence_box', price = 0 },
			{ name = 'hydrogen_peroxide', price = 0 },
			{ name = 'fingerprint_scanner', price = 0 },
			{ name = 'spy_microphone', price = 0, grade = 6 },
			{ name = 'forensic_kit', price = 0, grade = 6 },
			{ name = 'WEAPON_PROLASER4', price = 0 },
			{ name = 'WEAPON_BOLAWRAP', price = 0 },
			{ name = 'WEAPON_PEPPERSPRAY', price = 0 },
			{ name = 'WEAPON_ANTIDOTE', price = 0 },
			{ name = 'WEAPON_FLASHBANG', price = 0, grade = 9 },
			{ name = 'WEAPON_AIRSOFTR870', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_AIRSOFTM4', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_AIRSOFTGLOCK20', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_SIG_SAUCER', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_GLOCK19GEN4', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_GLOCK20', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 3 },
			{ name = 'WEAPON_FBIARB', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_FM1_BENELLIM4', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 1 },
			{ name = 'WEAPON_M870', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 2 },
			{ name = 'WEAPON_HK417', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 3 },
			{ name = 'WEAPON_LWRC', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 4 },
			{ name = 'WEAPON_KS1', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 5 },
			{ name = 'WEAPON_LBRS', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 6 },
			{ name = 'WEAPON_SIG516', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 7 },
			{ name = 'WEAPON_P90', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 9 },
			{ name = 'WEAPON_HEAVYSNIPER', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 8 },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'WEAPON_FLASHLIGHT', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'WEAPON_BEANBAG', price = 0, metadata = { registered = true, serial = 'POL'} },
			{ name = 'taser_cartridge', price = 5 },
			{ name = 'ammo-beanbag', price = 5 },
			{ name = 'ammo-9', price = 3 },
			{ name = 'ammo-10', price = 25, },
			{ name = 'ammo-556', price = 50, },
			{ name = 'ammo-762', price = 50, },
			{ name = 'ammo-12', price = 80, grade = 1 },
			{ name = 'ammo-50', price = 1000, grade = 11 },
		}, locations = {
			vec3(838.6940, -1282.7787, 21.2467)
		}
	},

	mechanics = {
		name = 'Mechanic Store',
		groups = {['stanceandreas'] = 0},
		inventory = {
			-- drift tire system (has own store system)
			--{ name = 'kq_carjack', price = 0 },
			--{ name = 'kq_drifttire', price = 0 },
			--{ name = 'kq_regulartire', price = 0 },

			-- spacer system
			{ name = 'ls_spacer_red', price = 0 },
			{ name = 'ls_spacer_black', price = 0 },
			{ name = 'ls_spacer_silver', price = 0 },
			{ name = 'ls_spacer_hardened', price = 0 },
			{ name = 'ls_spacer_gold', price = 0 },
			{ name = 'ls_jackstand', price = 0 },

			-- plate flipper system
			{ name = 'pd_screwdriver', price = 0 },
			{ name = 'pd_licence_plate_flipper', price = 0 },
		}, locations = {
			vec3(1146.8923, -788.5696, 57.6025), -- Public Parts Store
			vec3(732.9742, -781.1617, 26.3664), -- Rusty's Garage (Codeine/Random)
			vec3(753.6370, 1285.2328, 360.2946), -- Stance Andreas - 526 - (Codeine/Random)
		}
	},
}
