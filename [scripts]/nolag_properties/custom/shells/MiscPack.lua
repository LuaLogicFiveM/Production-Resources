if not Config.Shells.MiscPack then return end

CreateThread(function()
    local MiscPack = {
        ["Furnished Office 1"] = {
            label = "Furnished Office 1",
            hash = `k4_office1_shell`,
            doorOffset = { x = 3.425217, y = -1.947266, z = -0.919563, h = 93.299072, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office1_shell.webp',
                }
            }
        },

        ["Furnished Office 2"] = {
            label = "Furnished Office 2",
            hash = `k4_office2_shell`,
            doorOffset = { x = 4.416412, y = 3.573181, z = -0.746124, h = 173.837341, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office2_shell.webp',
                }
            }
        },

        ["Furnished Office 3"] = {
            label = "Furnished Office 3",
            hash = `k4_office3_shell`,
            doorOffset = { x = -0.484970, y = -0.172302, z = -0.694687, h = 92.602959, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office3_shell.webp',
                }
            }
        },

        ["Furnished Office 4"] = {
            label = "Furnished Office 4",
            hash = `k4_office4_shell`,
            doorOffset = { x = 8.827576, y = -2.255920, z = -1.546211, h = 97.135460, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office4_shell.webp',
                }
            }
        },

        ["Furnished Office 5"] = {
            label = "Furnished Office 5",
            hash = `k4_office5_shell`,
            doorOffset = { x = 0.085770, y = -13.922485, z = -3.073944, h = 358.938171, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office5_shell.webp',
                }
            }
        },

        ["Office"] = {
            label = "Office",
            hash = `k4_office6_shell`,
            doorOffset = { x = 1.190720, y = 5.026306, z = -0.725456, h = 181.861404, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 30,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office6_shell.webp',
                }
            }
        },

        ["Office 2"] = {
            label = "Office 2",
            hash = `k4_office7_shell`,
            doorOffset = { x = 3.596313, y = -1.861633, z = -0.874458, h = 88.170555, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office7_shell.webp',
                }
            }
        },

        ["Office Big"] = {
            label = "Office Big",
            hash = `k4_office8_shell`,
            doorOffset = { x = -8.485199, y = -3.419678, z = -0.398430, h = 359.730072, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_office8_shell.webp',
                }
            }
        },

        ["Store"] = {
            label = "Store",
            hash = `k4_store1_shell`,
            doorOffset = { x = -2.791595, y = 4.445557, z = -0.619499, h = 181.964401, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_store1_shell.webp',
                }
            }
        },

        ["Store 1"] = {
            label = "Store 1",
            hash = `k4_store2_shell`,
            doorOffset = { x = -0.629761, y = -5.069031, z = -1.153366, h = 8.992056, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_store2_shell.webp',
                }
            }
        },

        ["Store 2"] = {
            label = "Store 2",
            hash = `k4_store3_shell`,
            doorOffset = { x = -0.044922, y = -7.713013, z = -0.300995, h = 3.347297, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_store3_shell.webp',
                }
            }
        },

        ["Gunstore"] = {
            label = "Gunstore",
            hash = `k4_store4_shell`,
            doorOffset = { x = -1.002228, y = -5.324463, z = -0.736542, h = 2.645791, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_store4_shell.webp',
                }
            }
        },

        ["Barber"] = {
            label = "Barber",
            hash = `k4_store5_shell`,
            doorOffset = { x = 1.584122, y = 5.428528, z = -0.557167, h = 180.395828, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_store5_shell.webp',
                }
            }
        },

        ["Container"] = {
            label = "Container",
            hash = `k4_container_shell`,
            doorOffset = { x = -0.042252, y = -5.402466, z = -0.213661, h = 1.775326, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_container_shell.webp',
                }
            }
        },

        ["Stash House 1"] = {
            label = "Stash House 1",
            hash = `k4_stashhouse1_shell`,
            doorOffset = { x = 21.444626, y = -0.337341, z = -2.070694, h = 90.185539, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_stashhouse1_shell.webp',
                }
            }
        },

        ["Stash House 2"] = {
            label = "Stash House 2",
            hash = `k4_stashhouse2_shell`,
            doorOffset = { x = -1.796478, y = 2.201355, z = -1.016602, h = 261.602936, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_stashhouse1_shell.webp',
                }
            }
        },

        ["Warehouse"] = {
            label = "Warehouse",
            hash = `k4_warehouse1_shell`,
            doorOffset = { x = -8.839645, y = 0.077393, z = -0.949265, h = 273.723816, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_warehouse1_shell.webp',
                }
            }
        },

        ["Warehouse 2"] = {
            label = "Warehouse 2",
            hash = `k4_warehouse2_shell`,
            doorOffset = { x = -12.539124, y = 5.473999, z = -2.058945, h = 274.229858, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_warehouse2_shell.webp',
                }
            }
        },

        ["Warehouse 3"] = {
            label = "Warehouse 3",
            hash = `k4_warehouse3_shell`,
            doorOffset = { x = 2.454865, y = -1.578125, z = -0.942886, h = 95.432266, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_warehouse3_shell.webp',
                }
            }
        },

        ['Warehouse Shell'] = {
            label = 'Warehouse Shell',
            hash = `k4_warehouse4_shell`,
            doorOffset = { x = 8.534912, y = -3.219482, z = -1.494400, h = 88.660812, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_warehouse4_shell.webp',
                }
            }
        },

        ["Warehouse New"] = {
            label = "Warehouse New",
            hash = `k4_warehouse5_shell`,
            doorOffset = { x = 13.524292, y = -7.290894, z = -2.072266, h = 86.359673, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_warehouse5_shell.webp',
                }
            }
        },

        ["New Biker 1"] = {
            label = "New Biker 1",
            hash = `k4_biker1_shell`,
            doorOffset = { x = 7.62, y = -11.10, z = 0.25, h = 182.14, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_biker1_shell.webp',
                }
            }
        },

        ["New Biker 2"] = {
            label = "New Biker 2",
            hash = `k4_biker2_shell`,
            doorOffset = { x = -10.60, y = 3.48, z = 1.00, h = 0.58, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_biker2_shell.webp',
                }
            }
        },

        ["New Biker 3"] = {
            label = "New Biker 3",
            hash = `k4_biker3_shell`,
            doorOffset = { x = -8.44, y = -0.55, z = -1.09, h = 177.14, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_biker3_shell.webp',
                }
            }
        },

        ["Basement 1"] = {
            label = "Basement 1",
            hash = `k4_basement1_shell`,
            doorOffset = { x = -4.640793, y = -4.886963, z = 1.602577, h = 91.282089, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_basement1_shell.webp',
                }
            }
        },

        ["Basement 2"] = {
            label = "Basement 2",
            hash = `k4_basement2_shell`,
            doorOffset = { x = -4.479523, y = -4.918091, z = 1.602501, h = 84.461037, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_basement2_shell.webp',
                }
            }
        },

        ["Basement 3"] = {
            label = "Basement 3",
            hash = `k4_basement3_shell`,
            doorOffset = { x = -4.577423, y = -4.858826, z = 1.602478, h = 92.123550, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_basement3_shell.webp',
                }
            }
        },

        ["Basement 4"] = {
            label = "Basement 4",
            hash = `k4_basement4_shell`,
            doorOffset = { x = -4.506607, y = -4.919128, z = 1.602570, h = 91.260101, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_basement4_shell.webp',
                }
            }
        },

        ["Basement 5"] = {
            label = "Basement 5",
            hash = `k4_basement5_shell`,
            doorOffset = { x = -4.422546, y = -4.960510, z = 1.597351, h = 85.357796, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/MiscPack/k4_basement5_shell.webp',
                }
            }
        },
    }

    InsertInteriors(MiscPack, "K4MB1 Misc Pack")
end)
