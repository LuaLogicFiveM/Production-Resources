Config.ForceSyncAnimationPosition = true -- reposition must be set

Config.TipZone = {
    coords = vec3(191.0, -237.0, 54.0),
    size = vec3(7.0, 7.5, 4.0),
    rotation = 335.0,
    minRank = 1,
    maxRank = 1,
    minTip = 20,
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
                pos = vector3(190.8685, -240.5632, 53.97931),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(191.09, -239.78, 53.97, 159.75), -- set nil if you don't need
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
                pos = vector3(193.6248, -239.1819, 53.98141),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(192.84, -238.99, 53.97, 251.71), -- set nil if you don't need
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
                pos = vector3(193.9796, -238.4239, 53.98207),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.4),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(193.17, -238.17, 53.97, 248.0), -- set nil if you don't need
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
                pos = vector3(194.1598, -238.6353, 53.98207),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.3),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 2600,
                        startFrom = 0.28,
                        reposition = vector4(193.43, -238.18, 53.97, 270.52), -- set nil if you don't need
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
                pos = vector3(190.6692, -240.5415, 53.98175),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.3),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_c@drunk',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 2600,
                        startFrom = 0.28,
                        reposition = vector4(191.16, -239.81, 53.97, 178.5), -- set nil if you don't need
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
                pos = vector3(189.5414, -239.8912, 53.98053),
                max = 3,
                zone = {
                    size = vector3(0.8, 0.5, 0.3),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@casino@mini@drinking@champagne_drinking@heels@base',
                        clip = 'bartender_intro',
                        flag = 1,
                        duration = 6000,
                        startFrom = 0.35,
                        reposition = vector4(190.38, -239.19, 53.97, 153.13), -- set nil if you don't need
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
                pos = vector3(193.9095, -238.6811, 53.98207),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(193.06, -238.44, 53.97, 248.46), -- set nil if you don't need
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
                pos = vector3(193.7584, -239.39, 53.98141),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(192.93, -239.17, 53.97, 248.92), -- set nil if you don't need
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
                pos = vector3(193.3658, -240.0509, 53.98343),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = 67.0
                }
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
                pos = vector3(190.511, -240.3819, 53.98175),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(190.68, -239.54, 53.97, 126.74), -- set nil if you don't need
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
                pos = vector3(193.3983, -240.2839, 53.98343),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(192.56, -240.08, 53.97, 215.87), -- set nil if you don't need
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
                pos = vector3(193.1821, -240.2472, 53.98343),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.2),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(192.34, -239.98, 53.97, 212.32), -- set nil if you don't need
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
                pos = vector3(193.8514, -239.1775, 53.98141),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(192.93, -239.09, 53.97, 225.0), -- set nil if you don't need
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
                        {item = 'cafe_whisky', label = "Whisky", amount = 1, remove = true}
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(194.6633, -237.5214, 53.98141),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.12),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(193.79, -237.36, 53.97, 225.48), -- set nil if you don't need
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
                pos = vector3(194.4182, -237.1884, 53.98826),
                max = 5,
                zone = {
                    size = vector3(0.3, 0.9, 0.4),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@heeled@',
                        clip = 'pour_multi',
                        flag = 1,
                        duration = 5000,
                        startFrom = 0.0,
                        reposition = vector4(193.91, -236.82, 53.97, 251.75), -- set nil if you don't need
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
                pos = vector3(191.9169, -240.7499, 53.98298),
                max = 5,
                zone = {
                    size = vector3(0.9, 0.5, 0.4),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal@heeled@',
                        clip = 'pour_multi',
                        flag = 49,
                        duration = 5000,
                        startFrom = 0.0,
                        reposition = vector4(192.21, -240.22, 53.97, 163.86),
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
                pos = vector3(192.1036, -241.191, 53.98175),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.25),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(192.4, -240.34, 53.97, 122.27), -- set nil if you don't need
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
                pos = vector3(190.7153, -240.3297, 53.98175),
                max = 1,
                zone = {
                    size = vector3(0.1, 0.1, 0.25),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'mp_player_int_upperwank',
                        clip = 'mp_player_int_wank_02',
                        flag = 49,
                        duration = 2000,
                        startFrom = 0.0,
                        reposition = vector4(190.89, -239.53, 53.97, 162.0), -- set nil if you don't need
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
    leaflatte = {
        label = "Leaf & Latte",
        price = 50,
        animation = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a',
            flag = 49,
            duration = 6500,
            startFrom = 0.0,
        },
        prop = {
            model = 'v_res_mcofcup',
            bone = 58866,
            pos = vector3(0.1, -0.06, -0.03),
            rot = vector3(13.0, 30.0, -183.0),
            propAddDelay = 100,
            propRemoveDelay = 6500,
        },
        items = {
            {
                pos = vector3(188.5728, -239.6128, 53.98053),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.1),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(188.98, -238.87, 53.97, 122.0), -- set nil if you don't need
                    },
                    prop = {
                        model = 'xm_prop_x17_coffee_jug',
                        bone = 58866,
                        pos = vector3(0.02, -0.18, -0.07),
                        rot = vector3(40.0, 23.0, -226.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_coffeebean', label = "Coffee Bean", amount = 10, remove = true},
                        {item = 'cafe_khusbloom', label = "Dry Khus Bloom", amount = 1, remove = true},
                    },
                    fillAmount = 1
                },
            }, 
            {
                pos = vector3(188.7416, -239.6816, 53.98053),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.1),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(189.18, -238.94, 53.97, 120.58), -- set nil if you don't need
                    },
                    prop = {
                        model = 'xm_prop_x17_coffee_jug',
                        bone = 58866,
                        pos = vector3(0.02, -0.18, -0.07),
                        rot = vector3(40.0, 23.0, -226.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_coffeebean', label = "Coffee Bean", amount = 10, remove = true},
                        {item = 'cafe_khusbloom', label = "Dry Khus Bloom", amount = 1, remove = true},
                    },
                    fillAmount = 1
                },
            },
            {
                pos = vector3(188.7154, -239.4836, 53.98053),
                max = 1,
                zone = {
                    size = vector3(0.15, 0.15, 0.1),
                    heading = 67.0
                },
                refill = {
                    animation = {
                        dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_d@normal',
                        clip = 'pour_one',
                        flag = 1,
                        duration = 5500,
                        startFrom = 0.0,
                        reposition = vector4(189.0, -238.68, 53.97, 132.62), -- set nil if you don't need
                    },
                    prop = {
                        model = 'xm_prop_x17_coffee_jug',
                        bone = 58866,
                        pos = vector3(0.02, -0.18, -0.07),
                        rot = vector3(40.0, 23.0, -226.0),
                        propAddDelay = 2000,
                        propRemoveDelay = 2800,
                    },
                    required = {
                        {item = 'cafe_coffeebean', label = "Coffee Bean", amount = 10, remove = true},
                        {item = 'cafe_khusbloom', label = "Dry Khus Bloom", amount = 1, remove = true},
                    },
                    fillAmount = 1
                },
            },
        },
    }, 
}