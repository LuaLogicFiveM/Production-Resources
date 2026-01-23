if not Config.Shells.FurnishedHousingPack then return end

CreateThread(function()
    local FurnishedHousingPack = {
        ["Trap House 2"] = {
            label = "Trap House 2",
            hash = `k4_house1_furn`,
            doorOffset = { x = -7.157288, y = -1.459351, z = -0.251839, h = 185.347412, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house1_furn.webp',
                },
            },
        },

        ["New Motel 2"] = {
            label = "New Motel 2",
            hash = `k4_house2_furn`,
            doorOffset = { x = 0.041382, y = -0.148010, z = 0.995010, h = 272.180420, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house2_furn.webp',
                },
            },
        },

        ["Furnished Low Apartment"] = {
            label = "Furnished Low Apartment",
            hash = `k4_house3_furn`,
            doorOffset = { x = 5.059250, y = -1.254639, z = 0.345665, h = 6.360407, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house3_furn.webp',
                },
            },
        },

        ["Apartment Furnished"] = {
            label = "Apartment Furnished",
            hash = `k4_house4_furn`,
            doorOffset = { x = 1.381714, y = -10.131531, z = -0.521873, h = 2.176380, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house4_furn.webp',
                },
            }
        },

        ["Furnished New House"] = {
            label = "Furnished New House",
            hash = `k4_house5_furn`,
            doorOffset = { x = -0.696701, y = -2.431763, z = 1.000008, h = 270.800537, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house5_furn.webp',
                },
            }
        },

        ["Safehouse"] = {
            label = "Safehouse",
            hash = `k4_house6_furn`,
            doorOffset = { x = -5.079559, y = 1.150269, z = -0.832664, h = 263.690155, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house6_furn.webp',
                },
            }
        },

        ["Luxury House 3"] = {
            label = "Luxury House 3",
            hash = `k4_house7_furn`,
            doorOffset = { x = -6.318359, y = -0.981567, z = -0.700150, h = 267.508606, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house7_furn.webp',
                },
            }
        },

        ["Luxury House 4"] = {
            label = "Luxury House 4",
            hash = `k4_house8_furn`,
            doorOffset = { x = -6.309601, y = -1.053955, z = -0.700150, h = 268.541595, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_house8_furn.webp',
                },
            }
        },

        ["Furnished Motel"] = {
            label = "Furnished Motel",
            hash = `k4_motel1_furn`,
            doorOffset = { x = -1.563812, y = -3.752747, z = -0.360153, h = 353.379700, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_motel1_furn.webp',
                },
            }
        },

        ["Standard Motel"] = {
            label = "Standard Motel",
            hash = `k4_motel2_furn`,
            doorOffset = { x = -0.333969, y = -2.507812, z = -0.556450, h = 268.611572, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_motel2_furn.webp',
                },
            }
        },

        ["Furnished Motel Highend"] = {
            label = "Furnished Motel Highend",
            hash = `k4_hotel1_furn`,
            doorOffset = { x = 3.254883, y = 3.366699, z = -0.521271, h = 176.073242, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_hotel1_furn.webp',
                },
            }
        },

        ["Furnished Motel Classic"] = {
            label = "Furnished Motel Classic",
            hash = `k4_hotel2_furn`,
            doorOffset = { x = 0.080017, y = -3.462280, z = -0.337502, h = 0.534584, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_hotel2_furn.webp',
                },
            }
        },

        ["Casino Hotel"] = {
            label = "Casino Hotel",
            hash = `k4_hotel3_furn`,
            doorOffset = { x = -3.179199, y = 0.047974, z = -0.579262, h = 268.617798, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_hotel3_furn.webp',
                },
            }
        },

        ["Modern Hotel"] = {
            label = "Modern Hotel",
            hash = `k4_hotel4_furn`,
            doorOffset = { x = 4.983124, y = 4.242126, z = -0.817879, h = 175.733047, width = 2.0 },
            stash = {
                maxweight = 80000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_hotel4_furn.webp',
                },
            }
        },

        ["Furnished Motel Modern 2"] = {
            label = "Furnished Motel Modern 2",
            hash = `k4_hotel5_furn`,
            doorOffset = { x = 4.852844, y = 4.284302, z = -0.821327, h = 188.779297, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_hotel5_furn.webp',
                },
            }
        },

        ["Furnished Motel Modern 3"] = {
            label = "Furnished Motel Modern 3",
            hash = `k4_hotel6_furn`,
            doorOffset = { x = 4.879166, y = 4.194092, z = -0.821342, h = 181.277557, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/FurnishedHousingPack/k4_hotel6_furn.webp',
                },
            }
        },
    }

    InsertInteriors(FurnishedHousingPack, "K4MB1 Furnished Housing Pack")
end)
