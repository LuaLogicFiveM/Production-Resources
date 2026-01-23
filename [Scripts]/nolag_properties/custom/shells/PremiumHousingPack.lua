if not Config.Shells.PremiumHousingPack then return end

CreateThread(function()
    local PremiumHousingPack = {
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
                    url = "./images/shells/PremiumHousingPack/k4_hotel1_shell.webp",
                },
            }
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
                    url = "./images/shells/PremiumHousingPack/k4_hotel2_shell.webp",
                },
            }
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
                    url = "./images/shells/PremiumHousingPack/k4_hotel3_shell.webp",
                },
            }
        },

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
                    url = "./images/shells/PremiumHousingPack/k4_motel1_shell.webp",
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
                    url = "./images/shells/PremiumHousingPack/k4_motel2_shell.webp",
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
                    url = "./images/shells/PremiumHousingPack/k4_motel3_shell.webp",
                },
            },
        },

        ["Mansion"] = {
            label = "Mansion",
            hash = `k4_richman1_shell`,
            doorOffset = { x = -0.132172, y = -0.762329, z = 1.013542, h = 180.587036, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_richman1_shell.webp",
                },
            },
        },

        ["Mansion 2"] = {
            label = "Mansion 2",
            hash = `k4_richman2_shell`,
            doorOffset = { x = -0.298981, y = -0.652344, z = 1.013519, h = 185.866684, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_richman2_shell.webp",
                },
            },
        },

        ["Mansion 3"] = {
            label = "Mansion 3",
            hash = `k4_richman3_shell`,
            doorOffset = { x = -0.162720, y = -0.749634, z = 1.013535, h = 178.874557, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_richman3_shell.webp",
                },
            },
        },

        ["Vinewood House 1"] = {
            label = "Vinewood House 1",
            hash = `k4_vwmansion1_shell`,
            doorOffset = { x = 10.969604, y = -2.833496, z = -2.356705, h = 187.398666, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_vwmansion1_shell.webp",
                },
            },
        },

        ["Vinewood House 2"] = {
            label = "Vinewood House 2",
            hash = `k4_vwhouse2_shell`,
            doorOffset = { x = 1.620239, y = 4.895691, z = 1.710640, h = 181.242065, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_vwhouse2_shell.webp",
                },
            },
        },

        ["Vinewood House 3"] = {
            label = "Vinewood House 3",
            hash = `k4_vwhouse1_shell`,
            doorOffset = { x = 3.359436, y = 7.009827, z = -2.324127, h = 177.411850, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_vwhouse1_shell.webp",
                },
            },
        },

        ["Classic House"] = {
            label = "Classic House",
            hash = `k4_classic1_shell`,
            doorOffset = { x = 4.532104, y = -2.107422, z = -3.384560, h = 86.731239, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_classic1_shell.webp",
                },
            },
        },

        ["Classic House 2"] = {
            label = "Classic House 2",
            hash = `k4_classic2_shell`,
            doorOffset = { x = 4.607971, y = -2.091614, z = -3.384575, h = 88.907639, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_classic2_shell.webp",
                },
            },
        },

        ["Classic House 3"] = {
            label = "Classic House 3",
            hash = `k4_classic3_shell`,
            doorOffset = { x = 4.583145, y = -2.006470, z = -3.384590, h = 91.241272, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_classic3_shell.webp",
                },
            },
        },

        ["Classic House 4"] = {
            label = "Classic House 4",
            hash = `k4_classic4_shell`,
            doorOffset = { x = 4.635330, y = -2.131226, z = -3.384415, h = 90.573174, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_classic4_shell.webp",
                },
            },
        },

        ["Classic House 5"] = {
            label = "Classic House 5",
            hash = `k4_classic5_shell`,
            doorOffset = { x = 4.609604, y = -2.088257, z = -3.384422, h = 92.922974, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_classic5_shell.webp",
                },
            },
        },

        ["Classic House 6"] = {
            label = "Classic House 6",
            hash = `k4_classic6_shell`,
            doorOffset = { x = 4.653198, y = -1.981506, z = -3.384392, h = 90.193138, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/PremiumHousingPack/k4_classic6_shell.webp",
                },
            },
        },
    }

    InsertInteriors(PremiumHousingPack, "K4MB1 Premium Housing Pack")
end)
