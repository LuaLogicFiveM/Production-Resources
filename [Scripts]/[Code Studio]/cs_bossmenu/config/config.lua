Config = {}

Config.Debug = false

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework

Config.ServerType = 'ESX'  --'QB'|'ESX'

--SYNC SETTINGS--
Config.useInbuilt = false                --This will use inbuilt society money accounts 
Config.useQB_Banking = false            --Put true if you want to sync qb-banking
Config.useRenewed_Banking = false       --Put true if you want to sync Renewed-Banking
Config.useESX_Society = true           --Put true if you want to sync esx_society
Config.useokokBanking = false           --Put true if you want to sync okokbanking

Config.LocationSettings = {
    Enable = true,          --Enable/Disable Boss Menu Locations
    useTarget = {
        Enable = false,              --toggle target system
        Target = 'ox_target'        --qb-target/ox_target
    },
    useTextUI = {
        Enable = true,              --toggle textUi system requires(ox_lib)
        openKey = 38                --Key to open menu
    },
}

Config.DicordLogs = {
    Enable = true,
    WebHook = ''   --Enter Webhook to log boss menu actions on discord
}

Config.MenuSections = {
    BossInventory = true,       -- Hide/Show Boss Inventory Option
    BossOutfit = false,          -- Hide/Show Outfit Option
    ApplicationSystem = true    -- If you are using Job Application System Script https://Config.tebex.io/package/5756147
}

Config.HireNearbyPlayers = true            -- Toggle Between Recruit List Nearby Player or All Players

Config.No_Job = {           -- Default Job (Job to be given after FIRE)
    Job = 'unemployed',
    Grade = '0'  -- If you are on ESX put 0 not '0'
}

Config.Menu = {
    
    ['bossmenu'] = {

        ----------------------------- Business -----------------------------

        ['sahp'] = {
            bossRank = 12,
            locations = {
                vector4(843.3099, -1301.1409, 31.7695, 296.9183),
            }
        },
        ['sheriff'] = {
            bossRank = 15,
            locations = {
                vector4(2782.6377, 4745.5947, 48.6278, 285.4211),
            }
        },
        ['ems'] = {
            bossRank = 8,
            locations = {
                vector4(1115.0254, 2719.6116, 38.7096, 356.3860),
            }
        },
        ['realestate'] = {
            bossRank = 3,
            locations = {
                vector4(-709.7026, 267.8573, 83.1080, 296.4009),
            }
        },
        ['greasy'] = {
            bossRank = 5,
            locations = {
                vector4(-305.1025, -1479.4985, 30.5932, 278.3701),
            }
        },
        ['gunstore_807'] = {
            bossRank = 2,
            locations = {
                vector4(823.9765, -2165.6055, 33.0741, 181.3913),--807
            }
        },
        ['gunstore_778'] = {
            bossRank = 2,
            locations = {
                vector4(1743.3495, -1584.2817, 113.2464, 189.2587),--778
            }
        },
        ['tequilala'] = {
            bossRank = 4,
            locations = {
                vector4(-561.3740, 281.9122, 85.6765, 263.1111),--473
            }
        },

        --------------------------- Weed Shops ---------------------------

        ['khusbites'] = {
            bossRank = 3,
            locations = {
                vector4(-517.0371, 51.1718, 44.5919, 120), --635
            }
        },
        ['cookies'] = {
            bossRank = 3,
            locations = {
                vector4(-1721.0811, -1110.1544, 17.3299, 120),--688
            }
        },
        ['hookahloungev2'] = {
            bossRank = 4,
            locations = {
                vector4(-430.0804, 49.5283, 46.3109, 120),--635
            }
        },
        ['leafnlatte'] = {
            bossRank = 4,
            locations = {
                vector4(185.9613, -266.1883, 54.0400, 330.7705),
            }
        },

        ----------------------------- Motorcycle Clubs -----------------------------

        ['redrum'] = {
            bossRank = 8,
            locations = {
                vector4(-1180.8380, -1191.5292, 11.6269, 134.8031),--698
            }
        },
        ['afmc'] = {
            bossRank = 5,
            locations = {
                vector4(1045.8152, -2531.6611, 28.9622, 84.3458),--804
            }
        },
        ['outlaw'] = {
            bossRank = 4,
            locations = {
                vector4(1187.2943, 2637.2227, 38.4019, 33.0674),--260
            }
        },
        ['devos'] = {
            bossRank = 4,
            locations = {
                vector4(-442.1889, 264.1572, 86.1950, 29.6220),--636
            }
        },
        ['lost'] = {
            bossRank = 7,
            locations = {
                vector4(-1130.9895, -1602.6873, 4.4069, 20.1201),--693
            }
        },

        ----------------------------- Gang Blocks -----------------------------

        ['osm'] = {
            bossRank = 5,
            locations = {
                vector4(-1146.8999, -1553.9967, 7.6327, 6.3776),--693BMF
                vector4(-71.5939, 369.0418, 112.4225, 71.7914),--504
            }
        },
        ['section6'] = {
            bossRank = 5,
            locations = {
                vector4(172.9143, -1709.8993, 23.5837, 67.3764),--838
            }
        },
        ['fourzerofour'] = {
            bossRank = 6,
            locations = {
                vector4(-1580.9668, -234.5325, 55.0430, 52.4877),--672
            }
        },
        ['fdk'] = {
            bossRank = 4,
            locations = {
                vector4(-19.3949, -1491.2119, 30.4869, 354.2206),--853
            }
        },
        ['blackstone'] = {
            bossRank = 5,
            locations = {
                vector4(-1517.7252, 1939.7896, 61.7355, 103.4730),--411
            }
        },
        ['santos'] = {
            bossRank = 3,
            locations = {
                vector4(1443.5477, -1483.3562, 66.6192, 168.2353),--409
                vector4(1224.2643, -410.2469, 68.8613, 343.9229),--573
            }
        },
        
        ----------------------------- Shops -----------------------------

        ['night'] = {
            bossRank = 4,
            locations = {
                vector4(-68.5766, -442.7573, 37.2673, 56.7724),--618
            }
        },
        ['stance'] = {
            bossRank = 4,
            locations = {
                vector4(-662.1617, -883.8232, 24.5127, 100.9375),--726
                vector4(-1077.9386, -2092.8303, 13.2617, 119.4005),--887
            }
        },
        ['sittin'] = {
            bossRank = 4,
            locations = {
                vector4(2001.3472, 4598.9531, 45.0304, 120),--111
            }
        },
        ['bhcustoms'] = {
            bossRank = 4,
            locations = {
                vector4(2736.5876, 4915.3530, 33.6873, 121.6586),--099
            }
        },
        ['chopshop'] = {
            bossRank = 4,
            locations = {
                vector4(698.1581, 162.1712, 89.7781, 58.4352),--592
                vector4(-2028.7356, -505.9716, 12.2131, 45.8117),--685
            }
        },
        ['wperf'] = {
            bossRank = 7,
            locations = {
                vector4(960.6086, -1570.2334, 30.7377, 183.8687),--796 
            }
        },
        ['gator'] = {
            bossRank = 4,
            locations = {
                vector4(1420.9315, 1051.1913, 114.3971, 209.4149),--539
            }
        },
        ['pcustoms'] = {
            bossRank = 4,
            locations = {
                vector4(1420.9315, 1051.1913, 114.3971, 209.4149),--539
                vector4(-1077.9386, -2092.8303, 13.2617, 119.4005),--887
            }
        },
        ['smoove'] = {
            bossRank = 4,
            locations = {
                vector4(-32.0112, -1114.2546, 26.9118, 54.2356),--745
                vector4(1465.5175, 1686.8851, 117.5146, 80.1898),--542
            }
        },
        ['hayes'] = {
            bossRank = 4,
            locations = {
                vector4(-254.2135, 6153.2642, 35.7104, 160.8475),--045
            }
        },
        ['elevatedcustoms'] = {
            bossRank = 4,
            locations = {
                vector4(1152.7604, -792.7800, 57.6024, 172.5813),--574
                vector4(2532.7617, 2640.2070, 38.7977, 172.5813),--334
                vector4(197.3879, 2756.4355, 43.5389, 172.5813),--228
            }
        },
        ['santosmech'] = {
            bossRank = 4,
            locations = {
                vector4(-699.6348, -2483.9277, 18.7401, 69.7591),--905
            }
        },
        ['$hamo'] = {
            bossRank = 4,
            locations = {
                vector4(-771.3943, 5853.6641, 23.4530, 36.6833),--013
            }
        },
        ['dirt'] = {
            bossRank = 4,
            locations = {
                vector4(1420.9536, 1051.1399, 114.3971, 248.9169),--538/539
            }
        },
        ['coast'] = {
            bossRank = 4,
            locations = {
                vector4(1309.7688, 2629.3838, 39.2945, 213.1328),--262
            }
        },
        ['landrys'] = {
            bossRank = 4,
            locations = {
                vector4(-1641.6398, -782.0059, 10.1747, 257.8826),--686
            }
        },
        ['southtc'] = {
            bossRank = 4,
            locations = {
               vector4(810.2009, -2336.5996, 18.6847, 351.7378),--806
            }
        },
    },

    -- Only Edit Below If you are using QB --
    ['gangmenu'] = {
        --[[['lostmc'] = {
            bossRank = 3,
            locations = {
                vector4(85.69, -1959.65, 21.12, 223.76),
            }
        },
        ['ballas'] = {
            bossRank = 3,
            locations = {
                vector4(83.83, -1955.18, 20.75, 145),
            }
        }]]
    }
}

Config.QuickAction = {
    ['deposit'] = {
        [1] = 10000,
        [2] = 100000
    },
    ['withdraw'] = {
        [1] = 10000,
        [2] = 100000
    },
}
