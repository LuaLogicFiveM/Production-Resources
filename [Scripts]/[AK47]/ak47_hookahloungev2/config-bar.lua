Config.ForceSyncAnimationPosition = true -- --reposition must be set

Config.TipZones = {
    [1] = {
        coords = vector3(-413.63, 30.55, 46.29),
        size = vec3(8.0, 7.0, 4.0),
        rotation = -5.0,
        minRank = 1,
        maxRank = 1,
        minTip = 20,
    },
    [2] = {
        coords = vector3(-424.27, 24.9, 52.87),
        size = vec3(7.0, 5.0, 4.0),
        rotation = -5.0,
        minRank = 1,
        maxRank = 1,
        minTip = 20,
    }
}

Config.Bar = {
    cocktail = {
        label = "Cocktail",
        price = 250,
        animation = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a',
            flag = 49,
            duration = 6500,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_cocktail',
            bone = 58866,
            pos = vector3(0.01, -0.14, -0.21),
            rot = vector3(-19.0, 29.0, 5.0),
            propAddDelay = 100,
            propRemoveDelay = 6500,
        },
        items = {
            {
                pos = vector3(-416.7236, 31.11433, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-415.88, 31.02, 46.29, 82.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_vodka', label = "Vodka", amount = 1, remove = true},
                        {item = 'cafe_bluecuracao', label = "Blue Curacao", amount = 1, remove = true},
                        {item = 'cafe_lemonade', label = "Lemonade", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-416.8848, 29.4578, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-416.06, 29.46, 46.29, 88.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_vodka', label = "Vodka", amount = 1, remove = true},
                        {item = 'cafe_bluecuracao', label = "Blue Curacao", amount = 1, remove = true},
                        {item = 'cafe_lemonade', label = "Lemonade", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            }, 
            {
                pos = vector3(-412.0387, 27.88172, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-412.51, 28.55, 46.29, 213.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_vodka', label = "Vodka", amount = 1, remove = true},
                        {item = 'cafe_bluecuracao', label = "Blue Curacao", amount = 1, remove = true},
                        {item = 'cafe_lemonade', label = "Lemonade", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            }, 
            {
                pos = vector3(-409.7294, 30.58559, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-410.55, 30.8, 46.29, 252.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_vodka', label = "Vodka", amount = 1, remove = true},
                        {item = 'cafe_bluecuracao', label = "Blue Curacao", amount = 1, remove = true},
                        {item = 'cafe_lemonade', label = "Lemonade", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-424.0692, 27.10576, 52.88327),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-424.15, 26.28, 52.87, 354.58), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_vodka', label = "Vodka", amount = 1, remove = true},
                        {item = 'cafe_bluecuracao', label = "Blue Curacao", amount = 1, remove = true},
                        {item = 'cafe_lemonade', label = "Lemonade", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-422.6429, 26.9588, 52.88275),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-422.76, 26.1, 52.87, 350.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_vodka', label = "Vodka", amount = 1, remove = true},
                        {item = 'cafe_bluecuracao', label = "Blue Curacao", amount = 1, remove = true},
                        {item = 'cafe_lemonade', label = "Lemonade", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            },       
        },
    },
    champagne = {
        label = "Champagne",
        price = 200,
        animation = {
            dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal',
            clip = 'drink',
            flag = 49,
            duration = 2500,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_drink_champ',
            bone = 58866,
            pos = vector3(-0.01, -0.2, -0.18),
            rot = vector3(-35.0, 28.0, 1.0),
            propAddDelay = 300,
            propRemoveDelay = 2100,
        },
        items = {
            {
                pos = vector3(-417.1217, 29.63198, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.3),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 2600,
                        startFrom = 0.28,
                        reposition = vector4(-416.13, 29.51, 46.29, 115.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'xs_prop_arena_champ_open',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 100,
                        propRemoveDelay = 2500,
                    },
                    required = {
                        {item = 'cafe_champagne', label = "Champagne", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-409.4272, 30.48405, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.3),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 2600,
                        startFrom = 0.28,
                        reposition = vector4(-410.32, 30.84, 46.29, 278.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'xs_prop_arena_champ_open',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 100,
                        propRemoveDelay = 2500,
                    },
                    required = {
                        {item = 'cafe_champagne', label = "Champagne", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-423.8991, 27.29668, 52.88327),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.3),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 2600,
                        startFrom = 0.28,
                        reposition = vector4(-423.98, 26.57, 52.87, 30.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'xs_prop_arena_champ_open',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 100,
                        propRemoveDelay = 2500,
                    },
                    required = {
                        {item = 'cafe_champagne', label = "Champagne", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-415.337, 26.79945, 46.34373),
                max = 3,
                zone = {
                    size = vector3(0.5, 0.8, 0.3),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@casino@mini@drinking@champagne_drinking@heels@base',
                        clip = 'bartender_intro',
                        flag = 1,
                        duration = 6000,
                        startFrom = 0.35,
                        reposition = vector4(-415.18, 27.7, 46.29, 185.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_champ_01b',
                        bone = 58866,
                        pos = vector3(0.03, -0.22, -0.24),
                        rot = vector3(-33.0, 11.0, 0.0),
                        propAddDelay = 500,
                        propRemoveDelay = 3800,
                    },
                    required = {
                        {item = 'cafe_champagne', label = "Champagne", amount = 1, remove = true}
                    },
                    fillAmount = 3
                },
            },
            {
                pos = vector3(-420.8685, 26.06887, 52.88627),
                max = 3,
                zone = {
                    size = vector3(0.8, 0.5, 0.3),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@casino@mini@drinking@champagne_drinking@heels@base',
                        clip = 'bartender_intro',
                        flag = 1,
                        duration = 6000,
                        startFrom = 0.35,
                        reposition = vector4(-421.8, 26.26, 52.87, 270.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_champ_01b',
                        bone = 58866,
                        pos = vector3(0.03, -0.22, -0.24),
                        rot = vector3(-33.0, 11.0, 0.0),
                        propAddDelay = 500,
                        propRemoveDelay = 3800,
                    },
                    required = {
                        {item = 'cafe_champagne', label = "Champagne", amount = 1, remove = true}
                    },
                    fillAmount = 3
                },
            },      
        },
    },
    daiquiri = {
        label = "Daiquiri",
        price = 50,
        animation = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a',
            flag = 49,
            duration = 6500,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_daiquiri',
            bone = 58866,
            pos = vector3(0.05, -0.12, -0.15),
            rot = vector3(-19.0, 32.0, 5.0),
            propAddDelay = 100,
            propRemoveDelay = 6500,
        },
        items = {
            {
                pos = vector3(-416.9297, 30.80582, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-416.03, 30.68, 46.29, 75.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "White Rum", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-416.8166, 29.86806, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-416.1, 29.86, 46.29, 87.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "White Rum", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            }, 
            {
                pos = vector3(-411.6461, 27.80673, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-412.17, 28.55, 46.29, 210.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "White Rum", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            }, 
            {
                pos = vector3(-409.7303, 30.18925, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-410.47, 30.53, 46.29, 242.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "White Rum", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-423.6584, 27.04375, 52.88327),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-423.7, 26.22, 52.87, -5.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "White Rum", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-422.9554, 27.12089, 52.88275),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-423.0, 26.29, 52.87, 354.04), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "White Rum", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },    
        },
    },
    redwine = {
        label = "Red Wine",
        price = 50,
        animation = {
            dict = 'mp_safehousewine@',
            clip = 'drinking_wine',
            flag = 49,
            duration = 8200,
            startFrom = 0.48,
        },
        prop = {
            model = 'prop_drink_redwine',
            bone = 26610,
            pos = vector3(0.03, -0.06, 0.11),
            rot = vector3(0.0, 146.0, 28.0),
            propAddDelay = 100,
            propRemoveDelay = 8000,
        },
        items = {
            {
                pos = vector3(-416.7395, 32.84779, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-415.84, 32.79, 46.29, 48.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_wine_rose',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_redwine', label = "Redwine", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-410.7581, 28.61484, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-411.38, 29.23, 46.29, 185.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_wine_rose',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_redwine', label = "Redwine", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-421.895, 27.00712, 52.881),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-422.01, 26.09, 52.87, 310.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_wine_rose',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_redwine', label = "Redwine", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },  
        },
    },
    whitewine = {
        label = "White Wine",
        price = 50,
        animation = {
            dict = 'mp_safehousewine@',
            clip = 'drinking_wine',
            flag = 49,
            duration = 8200,
            startFrom = 0.48,
        },
        prop = {
            model = 'prop_drink_whtwine',
            bone = 26610,
            pos = vector3(0.03, -0.06, 0.11),
            rot = vector3(0.0, 146.0, 28.0),
            propAddDelay = 100,
            propRemoveDelay = 8000,
        },
        items = {
            {
                pos = vector3(-416.5799, 32.96656, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(vector4(-415.69, 32.81, 46.29, 40.0)), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_wine_white',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whitewine', label = "Whitewine", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-411.0743, 28.50483, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-411.75, 29.03, 46.29, 193.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_wine_white',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whitewine', label = "Whitewine", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-422.0138, 27.16673, 52.881),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-422.19, 26.26, 52.87, 310.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_wine_white',
                        bone = 58866,
                        pos = vector3(0.01, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whitewine', label = "Whitewine", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
        },
    },
    whisky = {
        label = "Whisky",
        price = 50,
        animation = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a',
            flag = 49,
            duration = 6500,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_drink_whisky',
            bone = 58866,
            pos = vector3(0.09, -0.06, -0.06),
            rot = vector3(-10.0, 19.0, -9.0),
            propAddDelay = 100,
            propRemoveDelay = 6500,
        },
        items = {
            {
                pos = vector3(-416.9097, 31.32513, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-415.98, 31.27, 46.29, 52.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_cs_whiskey_bottle',
                        bone = 58866,
                        pos = vector3(0.1, -0.07, 0.03),
                        rot = vector3(-36.0, 57.0, 13.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whisky', label = "Whisky", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-417.4213, 28.2644, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-416.24, 28.27, 46.29, 52.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_cs_whiskey_bottle',
                        bone = 58866,
                        pos = vector3(0.1, -0.07, 0.03),
                        rot = vector3(-36.0, 57.0, 13.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whisky', label = "Whisky", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-412.1692, 27.61784, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-412.8, 28.34, 46.29, 186.69), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_cs_whiskey_bottle',
                        bone = 58866,
                        pos = vector3(0.1, -0.07, 0.03),
                        rot = vector3(-36.0, 57.0, 13.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whisky', label = "Whisky", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-425.2331, 27.56189, 52.88919),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-425.15, 26.63, 52.87, 332.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_cs_whiskey_bottle',
                        bone = 58866,
                        pos = vector3(0.1, -0.07, 0.03),
                        rot = vector3(-36.0, 57.0, 13.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whisky', label = "Whisky", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-422.4479, 27.10201, 52.88275),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-422.44, 26.24, 52.87, 325.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_cs_whiskey_bottle',
                        bone = 58866,
                        pos = vector3(0.1, -0.07, 0.03),
                        rot = vector3(-36.0, 57.0, 13.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_whisky', label = "Whisky", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
        },
    },
    tequilashots = {
        label = "Tequila Shots",
        price = 100,
        animation = {
            dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@',
            clip = 'drink',
            flag = 49,
            duration = 5000,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_shots_glass_cs',
            bone = 58866,
            pos = vector3(0.08, -0.07, -0.01),
            rot = vector3(-36.0, 25.0, 1.0),
            propAddDelay = 100,
            propRemoveDelay = 4000,
        },
        items = {
            {
                pos = vector3(-416.9533, 28.03155, 46.34373),
                max = 5,
                zone = {
                    size = vector3(0.9, 0.3, 0.4),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@heeled@',
                        clip = 'pour_multi',
                        flag = 1,
                        duration = 5000,
                        startFrom = 0.0,
                        reposition = vector4(-416.28, 27.82, 46.29, 86.85), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.08, -0.09, -0.15),
                        rot = vector3(-9.0, 9.0, 0.0),
                        propAddDelay = 800,
                        propRemoveDelay = 4000,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 5
                },
            }, 
            {
                pos = vector3(-413.7452, 27.09201, 46.34373),
                max = 5,
                zone = {
                    size = vector3(0.5, 0.9, 0.4),
                    heading = 15.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@heeled@',
                        clip = 'pour_multi',
                        flag = 49,
                        duration = 5000,
                        startFrom = 0.0,
                        reposition = vector4(-413.91, 27.77, 46.29, 209.93),
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.08, -0.09, -0.15),
                        rot = vector3(-9.0, 9.0, 0.0),
                        propAddDelay = 500,
                        propRemoveDelay = 4000,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 5
                },
            },
            {
                pos = vector3(-425.5471, 27.18255, 52.88271),
                max = 5,
                zone = {
                    size = vector3(0.5, 0.9, 0.4),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@heeled@',
                        clip = 'pour_multi',
                        flag = 49,
                        duration = 5000,
                        startFrom = 0.0,
                        reposition = vector4(-425.6, 26.64, 52.87, 3.17),
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.08, -0.09, -0.15),
                        rot = vector3(-9.0, 9.0, 0.0),
                        propAddDelay = 500,
                        propRemoveDelay = 4000,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 5
                },
            },
            {
                pos = vector3(-421.0514, 24.7475, 52.88627),
                max = 5,
                zone = {
                    size = vector3(0.9, 0.5, 0.4),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@heeled@',
                        clip = 'pour_multi',
                        flag = 49,
                        duration = 5000,
                        startFrom = 0.0,
                        reposition = vector4(-421.57, 24.81, 52.87, 275.0),
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.08, -0.09, -0.15),
                        rot = vector3(-9.0, 9.0, 0.0),
                        propAddDelay = 500,
                        propRemoveDelay = 4000,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 5
                },
            },
        },
    },
    tequila = {
        label = "Tequila",
        price = 200,
        animation = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a',
            flag = 49,
            duration = 6500,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_tequila',
            bone = 58866,
            pos = vector3(0.05, -0.12, -0.15),
            rot = vector3(-19.0, 32.0, 5.0),
            propAddDelay = 100,
            propRemoveDelay = 6500,
        },
        items = {
            {
                pos = vector3(-416.5518, 32.50622, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-415.74, 32.48, 46.29, 53.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.02, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-410.9433, 28.80341, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-411.54, 29.33, 46.29, 190.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.02, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-421.5534, 27.19486, 52.881),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(-421.65, 26.4, 52.87, 315.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_tequila_bottle',
                        bone = 58866,
                        pos = vector3(0.02, -0.18, -0.07),
                        rot = vector3(-46.0, 29.0, -17.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_tequila', label = "Tequila", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
        },
    },
    mojito = {
        label = "Mojito",
        price = 400,
        animation = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a',
            flag = 49,
            duration = 6500,
            startFrom = 0.0,
        },
        prop = {
            model = 'prop_mojito',
            bone = 58866,
            pos = vector3(0.01, -0.06, -0.16),
            rot = vector3(-12.0, 21.0, -69.0),
            propAddDelay = 100,
            propRemoveDelay = 6500,
        },
        items = {
            {
                pos = vector3(-416.7548, 32.67395, 46.34373),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.25),
                    heading = -5.0
                },
                zoneid = 1,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-415.86, 32.64, 46.29, 81.92), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "Whiterum", amount = 1, remove = true},
                        {item = 'cafe_limejuice', label = "Lime Juice", amount = 1, remove = true},
                        {item = 'cafe_mintleaves', label = "Mint Leaves", amount = 3, remove = true},
                        {item = 'cafe_sodawater', label = "Soda Water", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(-421.7212, 26.99185, 52.881),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.25),
                    heading = -5.0
                },
                zoneid = 2,
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(-421.73, 26.13, 52.87, 353.24), -- set nil if you don't need
                    },
                    prop = {
                        model = 'prop_bar_cockshaker',
                        bone = 26610,
                        pos = vector3(0.03, -0.15, 0.09),
                        rot = vector3(-114.0, -9.0, -15.0),
                        propAddDelay = 0,
                        propRemoveDelay = 2000,
                    },
                    animation2 = {
                        dict = 'mini@drinking',
                        clip = 'shots_barman_b',
                        flag = 1,
                        duration = 1800,
                        startFrom = 0.25,
                    },
                    prop2 = {
                        model = 'prop_bar_cockshaker',
                        bone = 58866,
                        pos = vector3(-0.04, -0.12, -0.07),
                        rot = vector3(-35.0, 72.0, 0.0),
                        propAddDelay = 0,
                        propRemoveDelay = 1800,
                    },
                    required = {
                        {item = 'cafe_whiterum', label = "Whiterum", amount = 1, remove = true},
                        {item = 'cafe_limejuice', label = "Lime Juice", amount = 1, remove = true},
                        {item = 'cafe_mintleaves', label = "Mint Leaves", amount = 3, remove = true},
                        {item = 'cafe_sodawater', label = "Soda Water", amount = 1, remove = true},
                        {item = 'cafe_icecube', label = "Ice Cube", amount = 3, remove = true},
                        {item = 'cafe_shaker', label = "Shaker", amount = 1, remove = false},
                    },
                    fillAmount = 1
                },
            }, 
        },
    },
}