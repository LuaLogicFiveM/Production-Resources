if not Config.Shells.MainHousingPack then return end

CreateThread(function()
    local MainHousingPack = {
        ["Trailer"] = {
            label = "Trailer",
            hash = `k4_trailer1_shell`,
            doorOffset = { x = -1.302231, y = -1.846741, z = -0.479614, h = 0.268654, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_trailer1_shell.webp",
                },
            },
        },

        ["Default V2 3"] = {
            label = "Default V2 3",
            hash = `k4_trailer2_shell`,
            doorOffset = { x = -1.288803, y = -2.071960, z = -0.479645, h = 2.793929, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_trailer2_shell.webp",
                },
            },
        },

        ["Apartment 2 Unfurnished"] = {
            label = "Apartment 2 Unfurnished",
            hash = `k4_v16low1_shell`,
            doorOffset = { x = -1.398575, y = 0.084961, z = 0.345619, h = 359.888092, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_v16low1_shell.webp",
                },
            },
        },

        ["Default V2 5"] = {
            label = "Default V2 5",
            hash = `k4_v16low2_shell`,
            doorOffset = { x = 1.454422, y = -14.231567, z = -0.492546, h = 2.436233, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_v16low2_shell.webp",
                },
            },
        },

        ["House 3"] = {
            label = "House 3",
            hash = `k4_lester1_shell`,
            doorOffset = { x = -1.575439, y = -5.751587, z = -0.369637, h = 353.811432, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_lester1_shell.webp",
                },
            },
        },

        ["Default V2"] = {
            label = "Default V2",
            hash = `k4_lester2_shell`,
            doorOffset = { x = -2.072586, y = -5.845215, z = -0.322784, h = 9.363704, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_lester2_shell.webp",
                },
            },
        },

        ["House 4"] = {
            label = "House 4",
            hash = `k4_trevor1_shell`,
            doorOffset = { x = 0.238831, y = -3.535339, z = -0.407990, h = 358.348083, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_trevor1_shell.webp",
                },
            },
        },

        ["Default V2 4"] = {
            label = "Default V2 4",
            hash = `k4_trevor2_shell`,
            doorOffset = { x = 0.260452, y = -3.841003, z = -0.408020, h = 3.235212, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_trevor2_shell.webp",
                },
            },
        },

        ["Apartment Unfurnished"] = {
            label = "Apartment Unfurnished",
            hash = `k4_v16mid1_shell`,
            doorOffset = { x = 1.436569, y = -10.037476, z = -0.492447, h = 350.256744, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_v16mid1_shell.webp",
                },
            },
        },

        ["Default V2 6"] = {
            label = "Default V2 6",
            hash = `k4_v16mid2_shell`,
            doorOffset = { x = 4.627930, y = -6.521484, z = -1.668488, h = 2.334281, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_v16mid2_shell.webp",
                },
            },
        },

        ["House 2"] = {
            label = "House 2",
            hash = `k4_ranch1_shell`,
            doorOffset = { x = -1.055878, y = -5.372253, z = -1.263123, h = 267.713745, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_ranch1_shell.webp",
                },
            },
        },

        ["Default V2 2"] = {
            label = "Default V2 2",
            hash = `k4_ranch2_shell`,
            doorOffset = { x = -4.355194, y = 17.255127, z = -0.599052, h = 273.776398, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_ranch2_shell.webp",
                },
            },
        },

        ["House 1"] = {
            label = "House 1",
            hash = `k4_shell_medium1`,
            doorOffset = { x = -0.336578, y = -5.757568, z = -0.569885, h = 1.891344, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_shell_medium1.webp",
                },
            },
        },

        ["Default V2 Medium 1"] = {
            label = "Default V2 Medium 1",
            hash = `k4_shell_medium2`,
            doorOffset = { x = -0.308319, y = -5.770386, z = -0.569878, h = 2.050810, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_shell_medium2.webp",
                },
            },
        },

        ["Medium 2"] = {
            label = "Medium 2",
            hash = `k4_shell_medium3`,
            doorOffset = { x = 5.961105, y = 0.390869, z = -0.660896, h = 10.209838, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_shell_medium3.webp",
                },
            },
        },

        ["Default V2 Medium 2"] = {
            label = "Default V2 Medium 2",
            hash = `k4_shell_medium4`,
            doorOffset = { x = 6.020935, y = 0.375488, z = -0.661003, h = 1.199321, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_shell_medium4.webp",
                },
            },
        },

        ["Medium 3"] = {
            label = "Medium 3",
            hash = `k4_shell_medium5`,
            doorOffset = { x = 5.742737, y = -1.643188, z = 1.204926, h = 99.012558, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_shell_medium5.webp",
                },
            },
        },

        ["Highend House 1"] = {
            label = "Highend House 1",
            hash = `k4_highend1_shell`,
            doorOffset = { x = -2.309570, y = 8.857605, z = 3.202194, h = 187.448746, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend1_shell.webp",
                },
            },
        },

        ["Default V2 Highend 1"] = {
            label = "Default V2 Highend 1",
            hash = `k4_highend2_shell`,
            doorOffset = { x = -2.184845, y = 8.885986, z = 3.202034, h = 180.093140, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend2_shell.webp",
                },
            },
        },

        ["Highend House 2"] = {
            label = "Highend House 2",
            hash = `k4_highend3_shell`,
            doorOffset = { x = -2.231888, y = 8.923523, z = 3.202103, h = 178.636063, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend3_shell.webp",
                },
            },
        },

        ["Default V2 Highend 2"] = {
            label = "Default V2 Highend 2",
            hash = `k4_highend4_shell`,
            doorOffset = { x = -2.184875, y = 8.791870, z = 3.201950, h = 181.432114, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend4_shell.webp",
                },
            },
        },

        ["Highend House 3"] = {
            label = "Highend House 3",
            hash = `k4_highend5_shell`,
            doorOffset = { x = 11.590652, y = 4.601074, z = 2.009697, h = 126.361130, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend5_shell.webp",
                },
            },
        },

        ["Default V2 Highend 3"] = {
            label = "Default V2 Highend 3",
            hash = `k4_highend6_shell`,
            doorOffset = { x = 11.544250, y = 4.385254, z = 2.009689, h = 126.240143, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend6_shell.webp",
                },
            },
        },

        ["Deluxe House 1"] = {
            label = "Deluxe House 1",
            hash = `k4_highend7_shell`,
            doorOffset = { x = -22.270844, y = -0.511169, z = 7.207352, h = 272.471375, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend7_shell.webp",
                },
            },
        },

        ["Default V2 Deluxe 1"] = {
            label = "Default V2 Deluxe 1",
            hash = `k4_highend8_shell`,
            doorOffset = { x = -22.272980, y = -0.460938, z = 7.207161, h = 272.219666, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend8_shell.webp",
                },
            },
        },

        ["Deluxe House 2"] = {
            label = "Deluxe House 2",
            hash = `k4_highend9_shell`,
            doorOffset = { x = -10.132385, y = 0.823730, z = 1.934959, h = 273.321655, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend9_shell.webp",
                },
            },
        },

        ["Default V2 Deluxe 2"] = {
            label = "Default V2 Deluxe 2",
            hash = `k4_highend10_shell`,
            doorOffset = { x = -10.133453, y = 0.841614, z = 1.935150, h = 282.262268, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_highend10_shell.webp",
                },
            },
        },

        ["2 Floor House"] = {
            label = "2 Floor House",
            hash = `k4_michael_shell`,
            doorOffset = { x = -9.278595, y = 5.582825, z = -4.063576, h = 272.198761, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_michael_shell.webp",
                },
            },
        },

        ["Default V2 Deluxe 3"] = {
            label = "Default V2 Deluxe 3",
            hash = `k4_michael2_shell`,
            doorOffset = { x = -9.437622, y = 5.618103, z = -4.063568, h = 271.979065, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_michael2_shell.webp",
                },
            },
        },

        ["Banham"] = {
            label = "Banham",
            hash = `k4_banham1_shell`,
            doorOffset = { x = -3.546677, y = -1.502014, z = 1.236855, h = 95.435883, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_banham1_shell.webp",
                },
            },
        },

        ["Default V2 Modern 1"] = {
            label = "Default V2 Modern 1",
            hash = `k4_banham2_shell`,
            doorOffset = { x = 4.312195, y = 10.500366, z = 1.349403, h = 173.133209, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_banham2_shell.webp",
                },
            },
        },

        ["Westons"] = {
            label = "Westons",
            hash = `k4_westons1_shell`,
            doorOffset = { x = 4.246124, y = 10.530273, z = 1.359482, h = 183.3, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_westons1_shell.webp",
                },
            },
        },

        ["Default V2 Modern 2"] = {
            label = "Default V2 Modern 2",
            hash = `k4_westons2_shell`,
            doorOffset = { x = -1.788956, y = 10.504761, z = 1.349586, h = 179.987808, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_westons2_shell.webp",
                },
            },
        },

        ["Westons 2"] = {
            label = "Westons 2",
            hash = `k4_westons3_shell`,
            doorOffset = { x = -1.744003, y = 10.320801, z = 1.349495, h = 179.711990, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_westons3_shell.webp",
                },
            },
        },

        ["Default V2 Modern 3"] = {
            label = "Default V2 Modern 3",
            hash = `k4_westons4_shell`,
            doorOffset = { x = -3.295303, y = -1.399231, z = 1.236969, h = 94.708847, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/MainHousingPack/k4_westons4_shell.webp",
                },
            },
        },
    }

    InsertInteriors(MainHousingPack, "K4MB1 Main Housing Pack")
end)
