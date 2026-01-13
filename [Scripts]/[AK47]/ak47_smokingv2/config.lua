Config = {}
Config.Locale = 'en'

Config.SharedObjectName = 'esx:getSharedObject'

Config.CheckCanCarryItem = true
Config.UseProgressBar = false

Config.Keys = {
    smoke = 38,
    pass = 47,
    stop = 74
}

Config.VapeProp = {
    ba_prop_battle_vape_01 = {
        bone = 18905,
        position = vector3(0.125, 0.0, 0.03),
        rotation = vector3(-160.0, 60.0, -30.0),
    },
    xm3_prop_xm3_vape_01a = {
        bone = 18905,
        position = vector3(0.125, 0.0, 0.03),
        rotation = vector3(0.0, 0.0, -30.0),
    },
    
}

Config.VapeVolume = 0.3
Config.VapeLiquid = {
    ['blueberry_jam_cookie'] = {
        prop = 'xm3_prop_xm3_vape_01a',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['butter_cookie'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['cookie_craze'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['get_figgy'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['key_lime_cookie'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['marshmallow_crisp'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['no_99'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['paris_fog'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['pogo'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['pumpkin_cookie'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['shamrock_cookie'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    ['strawberry_jam_cookie'] = {
        prop = 'ba_prop_battle_vape_01',
        required_one_of_this = {
            ['vape'] = 1,
        },
        time = 300                          -- in second
    },
    
}

Config.Crafting = {
    ['cake_mix'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['cake_mix_joint'] = 5,
        },
    },
    ['cereal_milk'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['cereal_milk_joint'] = 5,
        },
    },
    ['cheetah_piss'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['cheetah_piss_joint'] = 5,
        },
    },
    ['gary_payton'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['gary_payton_joint'] = 5,
        },
    },
    ['gelatti'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['gelatti_joint'] = 5,
        },
    },
    ['georgia_pie'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['georgia_pie_joint'] = 5,
        },
    },
    ['jefe'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['jefe_joint'] = 5,
        },
    },
    ['white_runtz'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['white_runtz_joint'] = 5,
        },
    },
    ['snow_man'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['snow_man_joint'] = 5,
        },
    },
    ['whitecherry_gelato'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['whitecherry_gelato_joint'] = 5,
        },
    },
    ['blueberry_cruffin'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['blueberry_cruffin_joint'] = 5,
        },
    },
    ['fine_china'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['fine_china_joint'] = 5,
        },
    },
    ['pink_sandy'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['pink_sandy_joint'] = 5,
        },
    },
    ['zushi'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['zushi_joint'] = 5,
        },
    },
    ['apple_gelato'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['apple_gelato_joint'] = 5,
        },
    },
    ['biscotti'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['biscotti_joint'] = 5,
        },
    },
    ['collins_ave'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['collins_ave_joint'] = 5,
        },
    },
    ['marathon'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['marathon_joint'] = 5,
        },
    },
    ['oreoz'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['oreoz_joint'] = 5,
        },
    },
    ['pirckly_pear'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['pirckly_pear_joint'] = 5,
        },
    },
    ['runtz_og'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['runtz_og_joint'] = 5,
        },
    },
    ['blue_tomyz'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['blue_tomyz_joint'] = 5,
        },
    },
    ['ether'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['ether_joint'] = 5,
        },
    },
    ['froties'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['froties_joint'] = 5,
        },
    },
    ['gmo_cookies'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['gmo_cookies_joint'] = 5,
        },
    },
    ['ice_cream_cake_pack'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['ice_cream_cake_pack_joint'] = 5,
        },
    },
    ['khalifa_kush'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['khalifa_kush_joint'] = 5,
        },
    },
    ['la_confidential'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['la_confidential_joint'] = 5,
        },
    },
    ['marshmallow_og'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['marshmallow_og_joint'] = 5,
        },
    },
    ['moon_rock'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['moon_rock_joint'] = 5,
        },
    },
    ['sour_diesel'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['sour_diesel_joint'] = 5,
        },
    },
    ['tahoe_og'] = {
        required_one_of_this = {
            ['backwoods_grape'] = 1,
            ['backwoods_honey'] = 1,
            ['backwoods_russian_cream'] = 1,
            ['grabba_leaf'] = 1,
            ['paxton_pearl_cigars'] = 1,
            ['banana_backwoods'] = 1,
            ['raw_cone_king'] = 1,
        },
        delay = 5,                         --in second
        rewards = {
            ['tahoe_og_joint'] = 5,
        },
    },
    
}

Config.BluntProp = {
    prop_cigar_01 = {
        lighting = {
            bone = 47419,
            position = vector3(0.0, 0.02, 0.01),
            rotation = vector3(0.0, 270.0, -90.0),
        },
        holdtype1 = {
            bone = 57005,
            position = vector3(0.15, 0.015, 0.00),
            rotation = vector3(0.0, -80.0, 0.0),
        },
        holdtype2 = {
            bone = 57005,
            position = vector3(0.13, 0.04, -0.05),
            rotation = vector3(90.0, -90.0, -100.0),
        }
    },
    prop_cigar_03 = {
        lighting = {
            bone = 47419,
            position = vector3(0.0, 0.02, 0.01),
            rotation = vector3(0.0, 270.0, -90.0),
        },
        holdtype1 = {
            bone = 57005,
            position = vector3(0.15, 0.015, 0.00),
            rotation = vector3(0.0, -80.0, 0.0),
        },
        holdtype2 = {
            bone = 57005,
            position = vector3(0.13, 0.04, -0.05),
            rotation = vector3(90.0, -90.0, -100.0),
        }
    },
    
}

Config.Usable = {
    ['gelatti_joint'] = {
        prop = 'prop_cigar_03',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['gary_payton_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['cereal_milk_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['cheetah_piss_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['snow_man_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['georgia_pie_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['jefe_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['cake_mix_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
        	['lighter'] = 1,
        	['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['white_runtz_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
        	['lighter'] = 1,
        	['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['blueberry_cruffin_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
        	['lighter'] = 1,
        	['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['whitecherry_gelato_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
        	['lighter'] = 1,
        	['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['fine_china_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['pink_sandy_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['zushi_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['apple_gelato_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['biscotti_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['collins_ave_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['marathon_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['oreoz_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['pirckly_pear_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['runtz_og_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['blue_tomyz_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['ether_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['froties_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['gmo_cookies_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['ice_cream_cake_pack_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['khalifa_kush_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['la_confidential_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['marshmallow_og_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['moon_rock_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['sour_diesel_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    ['tahoe_og_joint'] = {
        prop = 'prop_cigar_01',
        required_one_of_this = {
            ['lighter'] = 1,
            ['cheap_lighter'] = 1,
        },
        time = 120,                         --in second
    },
    
}

