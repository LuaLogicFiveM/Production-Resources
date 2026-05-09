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
            points = {
                {
                    offset = {
                        x = -2.0343933105469,
                        y = 3.0952281951904,
                        z = -0.29524230957031,
                    },
                    name = "OpenInventory",
                },
                {
                    offset = {
                        x = 6.4839477539062,
                        y = 3.1779594421387,
                        z = -0.59764099121094,
                    },
                    name = "ClothingMenu",
                },
            }
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
            points = {
                {
                    offset = {
                        x = 3.5406799316406,
                        y = -2.1404724121094,
                        z = 1.1463623046875,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = 6.2044372558594,
                        y = -1.879789352417,
                        z = 0.40742492675781,
                    },
                    name = "OpenInventory",
                },
            }
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
            points = {
                {
                    offset = {
                        x = 1.2140502929688,
                        y = -2.3498497009277,
                        z = 0.19537353515625,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = 6.093017578125,
                        y = -0.044525146484375,
                        z = 0.24176025390625,
                    },
                    name = "OpenInventory",
                },
            }
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
            },
            points = {
                {
                    offset = {
                        x = 5.9764709472656,
                        y = 9.7184944152832,
                        z = -0.37031555175781,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = 7.2821655273438,
                        y = 3.9749526977539,
                        z = -0.95545959472656,
                    },
                    name = "OpenInventory",
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
            },
            points = {
                {
                    offset = {
                        x = -4.0590362548828,
                        y = 3.8150615692139,
                        z = 1.0668334960938,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = -1.5741577148438,
                        y = 1.7126007080078,
                        z = 0.78031921386719,
                    },
                    name = "OpenInventory",
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
            },
            points = {
                {
                    offset = {
                        x = -3.2876892089844,
                        y = -2.6332302093506,
                        z = -0.57968139648438,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = -2.8209228515625,
                        y = 3.3507118225098,
                        z = -0.78504943847656,
                    },
                    name = "OpenInventory",
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
            },
            points = {
                {
                    offset = {
                        x = 5.2235107421875,
                        y = 2.8846302032471,
                        z = -0.38887023925781,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = 1.8789672851562,
                        y = 0.57931137084961,
                        z = -0.86813354492188,
                    },
                    name = "OpenInventory",
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
            },
            points = {
                {
                    offset = {
                        x = 5.2549743652344,
                        y = 2.9703426361084,
                        z = -0.37094116210938,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = 1.7994995117188,
                        y = 0.64514350891113,
                        z = -0.86811828613281,
                    },
                    name = "OpenInventory",
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
            },
            points = {
                {
                    offset = {
                        x = -1.7055969238281,
                        y = 2.5337829589844,
                        z = -0.11224365234375,
                    },
                    name = "ClothingMenu",
                },
                {
                    offset = {
                        x = -1.9993896484375,
                        y = 0.93723487854004,
                        z = -0.57144165039062,
                    },
                    name = "OpenInventory",
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
            },
            points = {
                {
                    offset = {
                        x = 1.5201110839844,
                        y = -3.0175476074219,
                        z = -0.88395690917969,
                    },
                    name = "OpenInventory",
                },
                {
                    offset = {
                        x = 1.3557434082031,
                        y = 2.8942413330078,
                        z = -0.47303771972656,
                    },
                    name = "ClothingMenu",
                },
            }
        },

        ["Furnished Motel Highend"] = {
            label = "Furnished Motel Highend",
            hash = `k4_hotel1_furn`,
            doorOffset = { x = 3.254883, y = 3.366699, z = -0.521271, h = 176.073242, width = 2.0 },
            showersOffset = {
                { x = 0.755249, y = 2.792013, z = -0.503540, h = 270.503845, width = 2.0 },
            },
            sinksOffset = {
                { x = -2.843964, y = 5.066032, z = -0.526230, h = 359.675232, width = 1.0 },
                { x = -4.330246, y = 5.088741, z = -0.526230, h = 356.194153, width = 1.0 }
            },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            points = {
                {
                    name = "ClothingMenu",
                    offset = {
                        y = 1.4425964355469,
                        x = -0.5731086730957,
                        z = -0.20082092285156,
                    },
                },
                {
                    name = "OpenInventory",
                    offset = {
                        y = -1.1630249023438,
                        x = 4.4876937866211,
                        z = -0.67710113525391,
                    },
                },
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
            },
            points = {
                {
                    name = "ClothingMenu",
                    offset = {
                        x = 2.6399841308594,
                        y = 3.5925636291504,
                        z = -0.2850341796875,
                    },
                },
                {
                    name = "OpenInventory",
                    offset = {
                        x = 4.7080993652344,
                        y = 0.046670913696289,
                        z = -0.63027954101562,
                    },
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
            },
            points = {
                {
                    name = "ClothingMenu",
                    offset = {
                        x = -3.4039306640625,
                        y = 3.5283222198486,
                        z = -0.40513610839844,
                    },
                },
                {
                    name = "OpenInventory",
                    offset = {
                        x = 1.6958618164062,
                        y = 3.9865665435791,
                        z = -1.0552215576172,
                    },
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
            },
            points = {
                {
                    name = "ClothingMenu",
                    offset = {
                        x = -2.9115905761719,
                        y = -3.9787979125977,
                        z = -0.64971923828125,
                    },
                },
                {
                    name = "OpenInventory",
                    offset = {
                        x = -4.3324279785156,
                        y = 3.9238128662109,
                        z = -1.1314544677734,
                    },
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
            },
            points = {
                {
                    name = "ClothingMenu",
                    offset = {
                        x = -2.9227905273438,
                        y = -3.9873180389404,
                        z = -0.62123107910156,
                    },
                },
                {
                    name = "OpenInventory",
                    offset = {
                        x = -4.3399200439453,
                        y = 3.9591846466064,
                        z = -1.0679321289062,
                    },
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
            },
            points = {
                {
                    name = "ClothingMenu",
                    offset = {
                        x = -2.9404296875,
                        y = -3.9873199462891,
                        z = -0.68559265136719,
                    },
                },
                {
                    name = "OpenInventory",
                    offset = {
                        x = -4.3523406982422,
                        y = 3.9591846466064,
                        z = -1.0670928955078,
                    },
                },
            }
        },
    }

    InsertInteriors(FurnishedHousingPack, "K4MB1 Furnished Housing Pack")
end)
