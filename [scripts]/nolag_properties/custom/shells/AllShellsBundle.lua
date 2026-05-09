if not Config.Shells.AllShellsBundle then return end

CreateThread(function()
    local AllShellsBundle = {
        -- Medium Housing Shells V1 https://www.k4mb1maps.com/package/4672307

        ["Medium 2"] = {
            label = "Medium 2",
            hash = `shell_medium2`,
            doorOffset = { x = 5.961105, y = 0.390869, z = -0.660896, h = 10.209838, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/VvtRX1Z/image.png",
                    label = "Main",
                },
            },
        },

        ["Medium 3"] = {
            label = "Medium 3",
            hash = `shell_medium3`,
            doorOffset = { x = 5.742737, y = -1.643188, z = 1.204926, h = 99.012558, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/WzMHLPB/image.png",
                    label = "Main",
                },
            },
        },

        -- Modern Housing Shells V1 https://www.k4mb1maps.com/package/4673169

        ["Banham"] = {
            label = "Banham",
            hash = `shell_banham`,
            doorOffset = { x = -3.546677, y = -1.502014, z = 1.236855, h = 95.435883, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/fDJ5MHj/image.png",
                    label = "Main",
                },
            },
        },

        ["Westons"] = {
            label = "Westons",
            hash = `shell_westons`,
            doorOffset = { x = 4.246124, y = 10.530273, z = 1.359482, h = 183.3, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/DCgwsvh/image.png",
                    label = "Main",
                },
            },
        },

        ["Westons 2"] = {
            label = "Westons 2",
            hash = `shell_westons2`,
            doorOffset = { x = -1.744003, y = 10.320801, z = 1.349495, h = 179.711990, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/tDQ0jMT/image.png",
                    label = "Main",
                },
            },
        },

        -- Classic Housing Shells V1 https://www.k4mb1maps.com/package/4673140

        ["Classic House"] = {
            label = "Classic House",
            hash = `classichouse_shell`,
            doorOffset = { x = 4.532104, y = -2.107422, z = -3.384560, h = 86.731239, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/JnFdNzt/image.png",
                    label = "Main",
                },
            },
        },

        ["Classic House 2"] = {
            label = "Classic House 2",
            hash = `classichouse2_shell`,
            doorOffset = { x = 4.607971, y = -2.091614, z = -3.384575, h = 88.907639, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/bmYSzK4/yg9zEim.jpg",
                    label = "Main",
                },
            },
        },

        ["Classic House 3"] = {
            label = "Classic House 3",
            hash = `classichouse3_shell`,
            doorOffset = { x = 4.583145, y = -2.006470, z = -3.384590, h = 91.241272, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/sQBBD15/aHciV42.jpg",
                    label = "Main",
                },
            },
        },

        -- Highend Housing Shells V1 https://www.k4mb1maps.com/package/4673131

        ["Highend House 1"] = {
            label = "Highend House 1",
            hash = `shell_apartment1`,
            doorOffset = { x = -2.309570, y = 8.857605, z = 3.202194, h = 187.448746, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/D9VFznJ/WkPGJ64.jpg",
                    label = "Main",
                },
            },
        },

        ["Highend House 2"] = {
            label = "Highend House 2",
            hash = `shell_apartment2`,
            doorOffset = { x = -2.231888, y = 8.923523, z = 3.202103, h = 178.636063, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/z669RSR/whRGjN7.jpg",
                    label = "Main",
                },
            },
        },

        ["Highend House 3"] = {
            label = "Highend House 3",
            hash = `shell_apartment3`,
            doorOffset = { x = 11.590652, y = 4.601074, z = 2.009697, h = 126.361130, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/WnFHxhV/EFDaOf7.jpg",
                    label = "Main",
                },
            },
        },

        -- Deluxe Housing Shells V1 https://www.k4mb1maps.com/package/4673159

        ["Deluxe House 1"] = {
            label = "Deluxe House 1",
            hash = `shell_highend`,
            doorOffset = { x = -22.270844, y = -0.511169, z = 7.207352, h = 272.471375, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/tJywLWD/EnO4wYN.jpg",
                    label = "Main",
                },
            },
        },

        ["Deluxe House 2"] = {
            label = "Deluxe House 2",
            hash = `shell_highendv2`,
            doorOffset = { x = -10.132385, y = 0.823730, z = 1.934959, h = 273.321655, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/mTgtbp8/VdxIIny.jpg",
                    label = "Main",
                },
            },
        },

        -- Stash House Shells https://www.k4mb1maps.com/package/4673273

        ["Stash House 1"] = {
            label = "Stash House 1",
            hash = `stashhouse_shell`,
            doorOffset = { x = 21.444626, y = -0.337341, z = -2.070694, h = 90.185539, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/ygxPSws/2YZHoRo.jpg",
                    label = "Main",
                },
            },
        },

        ["Stash House 2"] = {
            label = "Stash House 2",
            hash = `stashhouse2_shell`,
            doorOffset = { x = -1.796478, y = 2.201355, z = -1.016602, h = 261.602936, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/28RcK2c/fEqGKes.jpg",
                    label = "Main",
                },
            },
        },

        -- Garage Shells https://www.k4mb1maps.com/package/4673177

        ["Garage Low End"] = {
            label = "Garage Low End",
            hash = `shell_garages`,
            doorOffset = { x = 5.745209, y = 3.649414, z = -0.500000, h = 184.022202, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/bdSsv13/877EQ4p.jpg",
                    label = "Main",
                },
            },
        },

        ["Garage High End"] = {
            label = "Garage High End",
            hash = `shell_garagel`,
            doorOffset = { x = 12.249466, y = -14.443787, z = -0.999924, h = 86.852631, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/2yPMsy1/ztJiJnD.jpg",
                    label = "Main",
                },
            },
        },

        -- Office Shells https://www.k4mb1maps.com/package/4673258

        ["Office Big"] = {
            label = "Office Big",
            hash = `shell_officebig`,
            doorOffset = { x = -8.485199, y = -3.419678, z = -0.398430, h = 359.730072, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Hpd2nGJ/0nITGT5.jpg",
                    label = "Main",
                },
            },
        },

        ["Office 2"] = {
            label = "Office 2",
            hash = `shell_office2`,
            doorOffset = { x = 3.596313, y = -1.861633, z = -0.874458, h = 88.170555, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/pJ7xLXT/EkLbng3.jpg",
                    label = "Main",
                },
            },
        },

        -- Store Shells https://www.k4mb1maps.com/package/4673264

        ["Barber"] = { -- Offset Set
            label = "Barber",
            hash = `shell_barber`,
            doorOffset = { x = 1.584122, y = 5.428528, z = -0.557167, h = 180.395828, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/vsm1Bn3/sOWNHqZ.jpg",
                    label = "Main",
                },
            },
        },

        ["Gunstore"] = {
            label = "Gunstore",
            hash = `shell_gunstore`,
            doorOffset = { x = -1.002228, y = -5.324463, z = -0.736542, h = 2.645791, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/0ZJGyyk/05H6rLl.jpg",
                    label = "Main",
                },
            },
        },

        ["Store 1"] = {
            label = "Store 1",
            hash = `shell_store2`,
            doorOffset = { x = -0.629761, y = -5.069031, z = -1.153366, h = 8.992056, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/3Nn7hFH/image.png",
                    label = "Main",
                },
            },
        },

        ["Store 2"] = {
            label = "Store 2",
            hash = `shell_store3`,
            doorOffset = { x = -0.044922, y = -7.713013, z = -0.300995, h = 3.347297, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/zRm2dv7/image.png",
                    label = "Main",
                },
            },
        },

        -- Warehouse Shells https://www.k4mb1maps.com/package/4673185

        ["Warehouse 2"] = {
            label = "Warehouse 2",
            hash = `shell_warehouse2`,
            doorOffset = { x = -12.539124, y = 5.473999, z = -2.058945, h = 274.229858, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/cN95Mm1/UHCyXxx.jpg",
                    label = "Main",
                },
            },
        },

        ["Warehouse 3"] = {
            label = "Warehouse 3",
            hash = `shell_warehouse3`,
            doorOffset = { x = 2.454865, y = -1.578125, z = -0.942886, h = 95.432266, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Z2WPYdk/pCASZHW.jpg",
                    label = "Main",
                },
            },
        },

        -- Highend Lab Shells https://www.k4mb1maps.com/package/4698329

        ["Coke Lab"] = {
            label = "Coke Lab",
            hash = `k4coke_shell`,
            doorOffset = { x = -10.841461, y = -2.638794, z = -0.072983, h = 272.195007, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/8zgLSGH/TSCoUD5.jpg",
                    label = "Main",
                },
            },
        },

        ["Meth Lab"] = {
            label = "Meth Lab",
            hash = `k4meth_shell`,
            doorOffset = { x = -10.746155, y = -2.587341, z = -0.072891, h = 268.795959, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/qWpkyvW/VPrq2Hm.jpg",
                    label = "Main",
                },
            },
        },

        ["Weed Lab"] = {
            label = "Weed Lab",
            hash = `k4weed_shell`,
            doorOffset = { x = -10.676392, y = -2.596497, z = -0.072960, h = 272.424988, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/kQvsw6B/9cjPHDv.jpg",
                    label = "Main",
                },
            },
        },

        -- Furnished Stash House Shells  https://www.k4mb1maps.com/package/4672293

        ["Container 2"] = {
            label = "Container 2",
            hash = `container2_shell`,
            doorOffset = { x = 0.079575, y = -5.524780, z = -0.213661, h = 358.452362, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/s6DhzvY/mR0qefn.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Stash 1"] = {
            label = "Furnished Stash 1",
            hash = `stashhouse1_shell`,
            doorOffset = { x = 21.312180, y = -0.496887, z = -2.070793, h = 85.222633, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/tBnw4gH/wOuMdAd.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Stash 2"] = {
            label = "Furnished Stash 2",
            hash = `stashhouse3_shell`,
            doorOffset = { x = -0.122116, y = 5.444519, z = -1.011719, h = 182.489822, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/G2yq5WS/mNR4dlf.jpg",
                    label = "Main",
                },
            },
        },

        -- Furnished Housing Shells https://www.k4mb1maps.com/package/4672272

        ["Furnished Low Apartment"] = {
            label = "Furnished Low Apartment",
            hash = `furnitured_lowapart`,
            doorOffset = { x = 5.059250, y = -1.254639, z = 0.345665, h = 6.360407, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/XyJZgVJ/eJsrr95.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Motel"] = {
            label = "Furnished Motel",
            hash = `furnitured_motel`,
            doorOffset = { x = -1.563812, y = -3.752747, z = -0.360153, h = 353.379700, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/LpkdDNr/KaM6Do0.jpg",
                    label = "Main",
                },
            },
        },

        -- Furnished Motel Shells  https://www.k4mb1maps.com/package/4672296

        ["Furnished Motel Classic"] = {
            label = "Furnished Motel Classic",
            hash = `classicmotel_shell`,
            doorOffset = { x = 0.080017, y = -3.462280, z = -0.337502, h = 0.534584, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/h8r73mP/yxmr6Ho.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Motel Highend"] = {
            label = "Furnished Motel Highend",
            hash = `highendmotel_shell`,
            doorOffset = { x = 3.254883, y = 3.366699, z = -0.521271, h = 176.073242, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/W5mxpG3/D9x6sZ8.png",
                    label = "Main",
                },
            },
        },

        -- Furnished Modern Hotels https://www.k4mb1maps.com/package/4672290

        ["Furnished Motel Modern 2"] = {
            label = "Furnished Motel Modern 2",
            hash = `modernhotel2_shell`,
            doorOffset = { x = 4.852844, y = 4.284302, z = -0.821327, h = 188.779297, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/G0FzN5Z/A5QE8zu.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Motel Modern 3"] = {
            label = "Furnished Motel Modern 3",
            hash = `modernhotel3_shell`,
            doorOffset = { x = 4.879166, y = 4.194092, z = -0.821342, h = 181.277557, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/17mkTgB/bBGReNa.jpg",
                    label = "Main",
                },
            },
        },

        -- Drug Lab Shells https://www.k4mb1maps.com/package/4672285

        ["Coke Lab 2"] = {
            label = "Coke Lab 2",
            hash = `shell_coke1`,
            doorOffset = { x = -6.301544, y = 8.576477, z = -0.958534, h = 182.188461, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/cX0s6W0/xjY7iex.jpg",
                    label = "Main",
                },
            },
        },

        ["Coke Lab 3"] = {
            label = "Coke Lab 3",
            hash = `shell_coke2`,
            doorOffset = { x = -6.467941, y = 8.506592, z = -0.958466, h = 180.414093, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/QPVW4d3/sIz8HJH.jpg",
                    label = "Main",
                },
            },
        },

        ["Meth Lab 1"] = {
            label = "Meth Lab 1",
            hash = `shell_meth`,
            doorOffset = { x = -6.366852, y = 8.537903, z = -0.958458, h = 182.644928, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/3cfg0g6/Heo7FFd.jpg",
                    label = "Main",
                },
            },
        },

        ["Weed Lab 2"] = {
            label = "Weed Lab 2",
            hash = `shell_weed`,
            doorOffset = { x = 17.654602, y = 11.857483, z = -2.097000, h = 91.606949, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Wv6vq1G/plfcLLq.jpg",
                    label = "Main",
                },
            },
        },

        ["Weed Lab 3"] = {
            label = "Weed Lab 3",
            hash = `shell_weed2`,
            doorOffset = { x = 17.697464, y = 11.791260, z = -2.096931, h = 96.449188, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Bj5nPTb/hgStpvb.jpg",
                    label = "Main",
                },
            },
        },

        -- Mansion Housing Shells https://www.k4mb1maps.com/package/4783251

        ["Mansion"] = {
            label = "Mansion",
            hash = `k4_mansion_shell`,
            doorOffset = { x = -0.132172, y = -0.762329, z = 1.013542, h = 180.587036, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/8xN8VQJ/Bc8zrwe.png",
                    label = "Main",
                },
            },
        },

        ["Mansion 2"] = {
            label = "Mansion 2",
            hash = `k4_mansion2_shell`,
            doorOffset = { x = -0.298981, y = -0.652344, z = 1.013519, h = 185.866684, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/55wH7my/w5W4sht.jpg",
                    label = "Main",
                },
            },
        },

        ["Mansion 3"] = {
            label = "Mansion 3",
            hash = `k4_mansion3_shell`,
            doorOffset = { x = -0.162720, y = -0.749634, z = 1.013535, h = 178.874557, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/HKfwGT0/cjePkXD.png",
                    label = "Main",
                },
            },
        },

        -- Empty Hotel Shells https://www.k4mb1maps.com/package/4811134

        ["Empty Hotel"] = {
            label = "Empty Hotel",
            hash = `k4_hotel1_shell`,
            doorOffset = { x = 4.949799, y = 4.067932, z = -0.814919, h = 179.011612, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/wLcCFdm/Mqbxvpb.jpg",
                    label = "Main",
                },
            },
        },

        ["Empty Hotel 2"] = {
            label = "Empty Hotel 2",
            hash = `k4_hotel2_shell`,
            doorOffset = { x = 5.001709, y = 4.304932, z = -0.814407, h = 176.394073, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/fHwwMCT/s0798cm.jpg",
                    label = "Main",
                },
            },
        },

        ["Empty Hotel 3"] = {
            label = "Empty Hotel 3",
            hash = `k4_hotel3_shell`,
            doorOffset = { x = 4.884277, y = 4.246460, z = -0.814407, h = 183.328796, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/yB18cdM/8bNagxs.jpg",
                    label = "Main",
                },
            },
        },

        -- Empty Motel Shells https://www.k4mb1maps.com/package/4811137

        ["Empty Motel 1"] = {
            label = "Empty Hotel 1",
            hash = `k4_motel1_shell`,
            doorOffset = { x = -0.268784, y = -2.483398, z = -0.556473, h = 273.530029, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/vJhsNnK/XotKvqO.jpg",
                    label = "Main",
                },
            },
        },

        ["Empty Motel 2"] = {
            label = "Empty Hotel 2",
            hash = `k4_motel2_shell`,
            doorOffset = { x = 0.139755, y = -3.466431, z = -0.337502, h = 7.543657, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/cbh6Pkm/7VGpSQ3.jpg",
                    label = "Main",
                },
            },
        },

        ["Empty Motel 3"] = {
            label = "Empty Hotel 3",
            hash = `k4_motel3_shell`,
            doorOffset = { x = 3.129379, y = 3.289185, z = -0.521248, h = 191.096985, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/6v1GW4y/kNYFaoB.jpg",
                    label = "Main",
                },
            },
        },

        -- Default Shells V2 https://www.k4mb1maps.com/package/5015832

        ["Default V2"] = {
            label = "Default V2",
            hash = `default_housing1_k4mb1`,
            doorOffset = { x = -2.072586, y = -5.845215, z = -0.322784, h = 9.363704, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/HGf4tFs/Q3U8LMR.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 2"] = {
            label = "Default V2 2",
            hash = `default_housing2_k4mb1`,
            doorOffset = { x = -4.355194, y = 17.255127, z = -0.599052, h = 273.776398, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/1R9yPnT/sbeeOmF.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 3"] = {
            label = "Default V2 3",
            hash = `default_housing3_k4mb1`,
            doorOffset = { x = -1.288803, y = -2.071960, z = -0.479645, h = 2.793929, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/stS5xT1/dbUnodK.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 4"] = {
            label = "Default V2 4",
            hash = `default_housing4_k4mb1`,
            doorOffset = { x = 0.260452, y = -3.841003, z = -0.408020, h = 3.235212, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/y6BF16L/zLj89Cx.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 5"] = {
            label = "Default V2 5",
            hash = `default_housing5_k4mb1`,
            doorOffset = { x = 1.454422, y = -14.231567, z = -0.492546, h = 2.436233, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/3B1zSvb/vvmck91.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 6"] = {
            label = "Default V2 6",
            hash = `default_housing6_k4mb1`,
            doorOffset = { x = 4.627930, y = -6.521484, z = -1.668488, h = 2.334281, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/0szhWcK/Uj0i8OA.jpg",
                    label = "Main",
                },
            },
        },

        -- Deluxe Shells V2 https://www.k4mb1maps.com/package/5043817

        ["Default V2 Deluxe 1"] = {
            label = "Default V2 Deluxe 1",
            hash = `deluxe_housing1_k4mb1`,
            doorOffset = { x = -22.272980, y = -0.460938, z = 7.207161, h = 272.219666, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/CVLCpPj/eCbzDAO.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 Deluxe 2"] = {
            label = "Default V2 Deluxe 2",
            hash = `deluxe_housing2_k4mb1`,
            doorOffset = { x = -10.133453, y = 0.841614, z = 1.935150, h = 282.262268, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/RvFbvrf/L65txkmx.png",
                    label = "Main",
                },
            },
        },

        ["Default V2 Deluxe 3"] = {
            label = "Default V2 Deluxe 3",
            hash = `deluxe_housing3_k4mb1`,
            doorOffset = { x = -9.437622, y = 5.618103, z = -4.063568, h = 271.979065, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/3YZjVvM/gjQnSZK7.png",
                    label = "Main",
                },
            },
        },

        -- Highend Shells V2 https://www.k4mb1maps.com/package/5043819

        ["Default V2 Highend 1"] = {
            label = "Default V2 Highend 1",
            hash = `highend_housing1_k4mb1`,
            doorOffset = { x = -2.184845, y = 8.885986, z = 3.202034, h = 180.093140, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/cx2drht/Lsx4QP9V.png",
                    label = "Main",
                },
            },
        },

        ["Default V2 Highend 2"] = {
            label = "Default V2 Highend 2",
            hash = `highend_housing2_k4mb1`,
            doorOffset = { x = -2.184875, y = 8.791870, z = 3.201950, h = 181.432114, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/rFN1B3q/Zn6pp1xV.png",
                    label = "Main",
                },
            },
        },

        ["Default V2 Highend 3"] = {
            label = "Default V2 Highend 3",
            hash = `highend_housing3_k4mb1`,
            doorOffset = { x = 11.544250, y = 4.385254, z = 2.009689, h = 126.240143, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/yk6BB5c/AYXgllp.jpg",
                    label = "Main",
                },
            },
        },

        -- Medium Shells V2 https://www.k4mb1maps.com/package/5043821

        ["Default V2 Medium 1"] = {
            label = "Default V2 Medium 1",
            hash = `medium_housing1_k4mb1`,
            doorOffset = { x = -0.308319, y = -5.770386, z = -0.569878, h = 2.050810, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/tP8HFW1/4ZP1Hhj.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 Medium 2"] = {
            label = "Default V2 Medium 2",
            hash = `medium_housing2_k4mb1`,
            doorOffset = { x = 6.020935, y = 0.375488, z = -0.661003, h = 1.199321, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/myxZMct/CNl6Y6U.jpg",
                    label = "Main",
                },
            },
        },

        ["Default V2 Medium 3"] = {
            label = "Default V2 Medium 3",
            hash = `medium_housing2_k4mb1`,
            doorOffset = { x = 6.107880, y = 0.434814, z = -0.651001, h = 358.719177, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/WzMHLPB/image.png",
                    label = "Main",
                },
            },
        },

        ["Default V2 Modern 1"] = {
            label = "Default V2 Modern 1",
            hash = `modern_housing1_k4mb1`,
            doorOffset = { x = 4.312195, y = 10.500366, z = 1.349403, h = 173.133209, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/HGJ22nX/kwamQ3d.png",
                    label = "Main",
                },
            },
        },

        ["Default V2 Modern 2"] = {
            label = "Default V2 Modern 2",
            hash = `modern_housing2_k4mb1`,
            doorOffset = { x = -1.788956, y = 10.504761, z = 1.349586, h = 179.987808, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/V275X5v/GbCc5az.png",
                    label = "Main",
                },
            },
        },

        ["Default V2 Modern 3"] = {
            label = "Default V2 Modern 3",
            hash = `modern_housing3_k4mb1`,
            doorOffset = { x = -3.295303, y = -1.399231, z = 1.236969, h = 94.708847, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Z1h8T1C/rMvwGIk.png",
                    label = "Main",
                },
            },
        },

        -- K4mv1 Vinewood V2 Shells -- https://www.k4mb1maps.com/package/5251329

        ["Vinewood House 1"] = {
            label = "Vinewood House 1",
            hash = `vinewood_housing1_k4mb1`,
            doorOffset = { x = 10.969604, y = -2.833496, z = -2.356705, h = 187.398666, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/xJr8kXY/c0jBmHA.jpg",
                    label = "Main",
                },
            },
        },

        ["Vinewood House 2"] = {
            label = "Vinewood House 2",
            hash = `vinewood_housing2_k4mb1`,
            doorOffset = { x = 1.620239, y = 4.895691, z = 1.710640, h = 181.242065, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/56TzyTT/VTpADnq.png",
                    label = "Main",
                },
            },
        },

        ["Vinewood House 3"] = {
            label = "Vinewood House 3",
            hash = `vinewood_housing3_k4mb1`,
            doorOffset = { x = 3.359436, y = 7.009827, z = -2.324127, h = 177.411850, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/txZXPhV/zIlHyEd.jpg",
                    label = "Main",
                },
            },
        },

        -------- K4MB1 September Update

        ["Gun Warehouse"] = {
            label = "Gun Warehouse",
            hash = `gunworkshop_k4mb1`,
            doorOffset = { x = 0.035400, y = 4.658203, z = -0.814468, h = 177.624405, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/1v0f2G8/WFZIhW6.jpg",
                    label = "Main",
                },
            },
        },

        ["Luxury House 1"] = {
            label = "Luxury House 1",
            hash = `luxury_housing1_k4mb1`,
            doorOffset = { x = -6.263123, y = -1.043945, z = -0.700150, h = 271.594330, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Wnw6SzR/JzGvTIJ.png",
                    label = "Main",
                },
            },
        },

        ["Luxury House 2"] = {
            label = "Luxury House 2",
            hash = `luxury_housing2_k4mb1`,
            doorOffset = { x = -6.248718, y = -1.044800, z = -0.700150, h = 271.634430, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/QCFzMLX/vwo9isq.jpg",
                    label = "Main",
                },
            },
        },

        ["Luxury House 3"] = {
            label = "Luxury House 3",
            hash = `luxury_housing3_k4mb1`,
            doorOffset = { x = -6.318359, y = -0.981567, z = -0.700150, h = 267.508606, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/nDtXMs7/eUSWm9a.png",
                    label = "Main",
                },
            },
        },

        ["Luxury House 4"] = {
            label = "Luxury House 4",
            hash = `luxury_housing4_k4mb1`,
            doorOffset = { x = -6.309601, y = -1.053955, z = -0.700150, h = 268.541595, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/KNryMwF/Vdzidcl.jpg",
                    label = "Main",
                },
            },
        },

        ["Manor House"] = {
            label = "Manor House",
            hash = `manor_housing1_k4mb1`,
            doorOffset = { x = 6.835602, y = -8.946777, z = -4.971199, h = 357.205017, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/pPpXjM9/kl8vbTR.png",
                    label = "Main",
                },
            },
        },

        ["Garage 1"] = {
            label = "Garage 1",
            hash = `new_garages1_k4mb1`,
            doorOffset = { x = -0.201569, y = 14.128174, z = -0.937195, h = 173.779678, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/BVbvLG3/DzKIs7b.jpg",
                    label = "Main",
                },
            },
        },

        ["Garage 2"] = {
            label = "Garage 2",
            hash = `new_garages2_k4mb1`,
            ddoorOffset = { x = -3.668610, y = -0.344116, z = -0.684700, h = 268.634735, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/74wg8B8/taHqvp3.jpg",
                    label = "Main",
                },
            },
        },

        ["Garage 3"] = {
            label = "Garage 3",
            hash = `new_garages3_k4mb1`,
            doorOffset = { x = -3.579742, y = -0.179321, z = -0.686516, h = 271.577362, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/YPCyhq6/GaWxLqK.jpg",
                    label = "Main",
                },
            },
        },

        ["Garage 4"] = {
            label = "Garage 4",
            hash = `new_garages4_k4mb1`,
            doorOffset = { x = 8.817535, y = 1.578125, z = -0.750000, h = 91.919441, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/j3GQXbg/jiUiclG.jpg",
                    label = "Main",
                },
            },
        },

        ["Safehouse"] = {
            label = "Safehouse",
            hash = `safehouse_k4mb1`,
            doorOffset = { x = -5.079559, y = 1.150269, z = -0.832664, h = 263.690155, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/tJGPBdM/6qDRB6o.jpg",
                    label = "Main",
                },
            },
        },

        ["Warehouse New"] = {
            label = "Warehouse New",
            hash = `warehouse_k4mb1`,
            doorOffset = { x = 13.524292, y = -7.290894, z = -2.072266, h = 86.359673, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/LR0JKBC/7Lr6BhT.jpg",
                    label = "Main",
                },
            },
        },

        -- Basement Shells

        ["Basement 1"] = {
            label = "Basement 1",
            hash = `k4mb1_basement1_shell`,
            doorOffset = { x = -4.640793, y = -4.886963, z = 1.602577, h = 91.282089, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/wSBxxRY/lMBhdoh.jpg",
                    label = "Main",
                },
            },
        },

        ["Basement 2"] = {
            label = "Basement 2",
            hash = `k4mb1_basement2_shell`,
            doorOffset = { x = -4.479523, y = -4.918091, z = 1.602501, h = 84.461037, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/PQZ1zVV/fmKqVAh.jpg",
                    label = "Main",
                },
            },
        },

        ["Basement 3"] = {
            label = "Basement 3",
            hash = `k4mb1_basement3_shell`,
            doorOffset = { x = -4.577423, y = -4.858826, z = 1.602478, h = 92.123550, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/LzSTh4r/PNoNF3Z.jpg",
                    label = "Main",
                },
            },
        },

        ["Basement 4"] = {
            label = "Basement 1",
            hash = `k4mb1_basement4_shell`,
            doorOffset = { x = -4.506607, y = -4.919128, z = 1.602570, h = 91.260101, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/RpqJKy9/aUzSmS2.jpg",
                    label = "Main",
                },
            },
        },

        ["Basement 5"] = {
            label = "Basement 5",
            hash = `k4mb1_basement5_shell`,
            doorOffset = { x = -4.422546, y = -4.960510, z = 1.597351, h = 85.357796, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/yRRwFj1/c5Bsw5D.jpg",
                    label = "Main",
                },
            },
        },

        -- Casino Hotel

        ["Casino Hotel"] = {
            label = "Casino Hotel",
            hash = `k4mb1_casinohotel_shell`,
            doorOffset = { x = -3.179199, y = 0.047974, z = -0.579262, h = 268.617798, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/YypGBKh/aofBHPU.jpg",
                    label = "Main",
                },
            },
        },

        -- New Houses

        ["New House 1"] = {
            label = "New House 1",
            hash = `k4mb1_house1_shell`,
            doorOffset = { x = -3.046021, y = -4.709045, z = -0.460999, h = 1.324592, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/PNpQkHC/DBuqjra.jpg",
                    label = "Main",
                },
            },
        },

        ["New House 2"] = {
            label = "New House 2",
            hash = `k4mb1_house2_shell`,
            doorOffset = { x = -8.480972, y = 1.053711, z = -3.176567, h = 282.197510, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Mky8q0g/9mrSVnM.jpg",
                    label = "Main",
                },
            },
        },

        ["New House 3"] = {
            label = "New House 3",
            hash = `k4mb1_house3_shell`,
            doorOffset = { x = 8.946243, y = -7.615601, z = -2.788254, h = 357.425385, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/vLGP4Y4/ldMYXDd.jpg",
                    label = "Main",
                },
            },
        },

        ["New House 4"] = {
            label = "New House 4",
            hash = `k4mb1_house4_shell`,
            doorOffset = { x = -2.264587, y = -2.767578, z = -1.987015, h = 358.395172, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/qgvb9cz/TcUmnhn.jpg",
                    label = "Main",
                },
            },
        },

        -- Furnished Offices

        ["Furnished Office 1"] = {
            label = "Furnished Office 1",
            hash = `k4mb1_furnishedoffice1_shell`,
            doorOffset = { x = 3.425217, y = -1.947266, z = -0.919563, h = 93.299072, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/RBSNcJD/2Bx8ZUG.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Office 2"] = {
            label = "Furnished Office 2",
            hash = `k4mb1_furnishedoffice2_shell`,
            doorOffset = { x = 4.416412, y = 3.573181, z = -0.746124, h = 173.837341, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/nj5W8Gf/Z238UsI.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Office 3"] = {
            label = "Furnished Office 3",
            hash = `k4mb1_furnishedoffice3_shell`,
            doorOffset = { x = -0.484970, y = -0.172302, z = -0.694687, h = 92.602959, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/m06VSGb/WiEkg0W.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Office 4"] = {
            label = "Furnished Office 4",
            hash = `k4mb1_furnishedoffice4_shell`,
            doorOffset = { x = 8.827576, y = -2.255920, z = -1.546211, h = 97.135460, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/Q9D1ChM/WX2p6KT.jpg",
                    label = "Main",
                },
            },
        },

        ["Furnished Office 5"] = {
            label = "Furnished Office 5",
            hash = `k4mb1_furnishedoffice5_shell`,
            doorOffset = { x = 0.085770, y = -13.922485, z = -3.073944, h = 358.938171, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/TqK8RKf/Eh9DZIV.jpg",
                    label = "Main",
                },
            },
        },

        -- Hood House

        ["Hood House"] = {
            label = "Hood House",
            hash = `k4mb1_hoodhouse1_shell`,
            doorOffset = { x = -2.320831, y = -7.276611, z = 0.999977, h = 82.778473, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/JzPPcrM/TOP0UvX.jpg",
                    label = "Main",
                },
            },
        },

        -- Laundry Shell

        ["Laundry Place"] = {
            label = "Laundry Place",
            hash = `k4mb1_laundry_shell`,
            doorOffset = { x = 10.477982, y = -5.670044, z = -2.386147, h = 353.682892, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/RN82KYq/fiQ3jdk.jpg",
                    label = "Main",
                },
            },
        },

        -- Paleto House

        ["Paleto House"] = {
            label = "Paleto House",
            hash = `k4mb1_palhouse1_shell`,
            doorOffset = { x = -0.729965, y = 5.552246, z = -1.663368, h = 97.534866, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/MRzzRYb/qtXDZNv.jpg",
                    label = "Main",
                },
            },
        },

        -- Sandy House

        ["Sandy House"] = {
            label = "Sandy House",
            hash = `k4mb1_sandyhouse1_shell`,
            doorOffset = { x = 1.619858, y = -4.858887, z = 0.085587, h = 2.043587, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/0YJ9zkZ/KBdGAhL.jpg",
                    label = "Main",
                },
            },
        },

        -- Empty House

        ["Empty House"] = {
            label = "Empty House",
            hash = `kambi_emptyhouse1`,
            doorOffset = { x = -0.725784, y = -2.468689, z = 1.000084, h = 271.515930, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/T0vHTCq/paCo4hO.jpg",
                    label = "Main",
                },
            },
        },

        -- Furnished House

        ["Furnished New House"] = {
            label = "Furnished New House",
            hash = `kambi_furnishedhouse1`,
            doorOffset = { x = -0.696701, y = -2.431763, z = 1.000008, h = 270.800537, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/v4wdqwW/kAoRRdp.jpg",
                    label = "Main",
                },
            },
        },

        ["Acid House 1"] = {
            label = "Acid House 1",
            hash = `k4mb1_acid_shell`,
            doorOffset = { x = -2.597839, y = 1.201233, z = 0.935951, h = 181.883179, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/tBpdkfn/quYdC6d.png",
                    label = "Main",
                },
            },
        },

        ["Acid House 2"] = {
            label = "Acid House 2",
            hash = `k4mb1_acid2_shell`,
            doorOffset = { x = -2.765732, y = 1.167908, z = 0.936050, h = 178.011826, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/dW4rghj/FspXiOv.png",
                    label = "Main",
                },
            },
        },


        ["New Apartment 1"] = {
            label = "New Apartment 1",
            hash = `k4mb1_apa1_shell`,
            doorOffset = { x = -19.241943, y = -0.611389, z = 1.794807, h = 179.391418, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/M2xhhNm/eHa0Tug.png",
                    label = "Main",
                },
            },
        },

        ["New Apartment 2"] = {
            label = "New Apartment 2",
            hash = `k4mb1_apa2_shell`,
            doorOffset = { x = -20.760864, y = -2.504883, z = 1.794785, h = 269.228729, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/yXr45NZ/ae8P8A5.png",
                    label = "Main",
                },
            },
        },

        ["New Apartment 3"] = {
            label = "New Apartment 3",
            hash = `k4mb1_apa3_shell`,
            doorOffset = { x = -20.763428, y = -2.354126, z = 1.794823, h = 265.977417, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/QQKh057/XkdN8V1.png",
                    label = "Main",
                },
            },
        },

        ["New Biker 1"] = {
            label = "New Biker 1",
            hash = `k4mb1_biker1_shell`,
            doorOffset = { x = 7.62, y = -11.10, z = 0.25, h = 182.14, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/r0WDFCv/Bjj7OpQ.png",
                    label = "Main",
                },
            },
        },

        ["New Biker 2"] = {
            label = "New Biker 2",
            hash = `k4mb1_biker2_shell`,
            doorOffset = { x = -10.60, y = 3.48, z = 1.00, h = 0.58, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/HY484T0/3uaNp7S.png",
                    label = "Main",
                },
            },
        },

        ["New Biker 3"] = {
            label = "New Biker 3",
            hash = `k4mb1_biker3_shell`,
            doorOffset = { x = -8.44, y = -0.55, z = -1.09, h = 177.14, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/dQfXKJj/AAgcvOk.png",
                    label = "Main",
                },
            },
        },


        ["Classic House 4"] = {
            label = "Classic House 4",
            hash = `k4mb1_classic4_shell`,
            doorOffset = { x = 4.635330, y = -2.131226, z = -3.384415, h = 90.573174, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/TBFTpRq/mnCp0e2.png",
                    label = "Main",
                },
            },
        },

        ["Classic House 5"] = {
            label = "Classic House 5",
            hash = `k4mb1_classic5_shell`,
            doorOffset = { x = 4.609604, y = -2.088257, z = -3.384422, h = 92.922974, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/cx7WXLX/Vhftz2n.png",
                    label = "Main",
                },
            },
        },

        ["Classic House 6"] = {
            label = "Classic House 6",
            hash = `k4mb1_classic6_shell`,
            doorOffset = { x = 4.653198, y = -1.981506, z = -3.384392, h = 90.193138, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/MRhWCZf/bM3GXqk.png",
                    label = "Main",
                },
            },
        },

        ["New Drug 1"] = {
            label = "New Drug 1",
            hash = `k4mb1_drug_shell`,
            doorOffset = { x = 10.896744, y = 2.163574, z = -1.873688, h = 102.639023, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/b3yXGjX/yECYzqi.png",
                    label = "Main",
                },
            },
        },

        ["Loft 1"] = {
            label = "Loft 1",
            hash = `k4mb1_loft1_shell`,
            doorOffset = { x = 6.564682, y = -2.972961, z = 0.995033, h = 82.431160, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/gJp30MX/D0OWEhm.png",
                    label = "Main",
                },
            },
        },

        ["Loft 2"] = {
            label = "Loft 2",
            hash = `k4mb1_loft2_shell`,
            doorOffset = { x = 8.440002, y = 0.981812, z = 0.995087, h = 87.750458, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/sshtKbH/i53V1cG.png",
                    label = "Main",
                },
            },
        },

        ["Loft 3"] = {
            label = "Loft 3",
            hash = `k4mb1_loft3_shell`,
            doorOffset = { x = 5.725525, y = -0.330688, z = 0.995041, h = 89.029221, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/QQKh057/XkdN8V1.png",
                    label = "Main",
                },
            },
        },

        ["New Motel 1"] = {
            label = "New Motel 1",
            hash = `k4mb1_motel1_shell`,
            doorOffset = { x = -0.112152, y = -0.164978, z = 0.994972, h = 269.040253, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/pbTJyd0/AG70HAh.png",
                    label = "Main",
                },
            },
        },

        ["New Motel 2"] = {
            label = "New Motel 2",
            hash = `k4mb1_motel2_shell`,
            doorOffset = { x = 0.041382, y = -0.148010, z = 0.995010, h = 272.180420, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/DCbMq7J/lqxJfJN.png",
                    label = "Main",
                },
            },
        },

        ["Trap House 1"] = {
            label = "Trap House 1",
            hash = `k4mb1_trap_shell`,
            doorOffset = { x = -7.089584, y = -1.431763, z = -0.251877, h = 182.746445, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/rfpWJgy/zFzZ77D.png",
                    label = "Main",
                },
            },
        },

        ["Trap House 2"] = {
            label = "Trap House 2",
            hash = `k4mb1_trap2_shell`,
            doorOffset = { x = -7.157288, y = -1.459351, z = -0.251839, h = 185.347412, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.ibb.co/fFF9rXq/rPeP9fn.png",
                    label = "Main",
                },
            },
        },
    }

    InsertInteriors(AllShellsBundle, "K4MB1 AllShellsBundle")
end)
