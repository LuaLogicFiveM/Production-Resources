if not Config.Shells.K4mb1StarterShells then return end

CreateThread(function()
    local StarterShells = {
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
                    url = "./images/shells/StarterShells/k4_motel2_furn.webp",
                }
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
                    url = "./images/shells/StarterShells/k4_hotel4_furn.webp",
                }
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
                    url = "./images/shells/StarterShells/k4_house4_furn.webp",
                }
            }
        },

        ["Apartment Unfurnished"] = {
            label = "Apartment Unfurnished",
            hash = `k4_v16mid1_shell`,
            doorOffset = { x = 1.436569, y = -14.037476, z = -0.492447, h = 350.256744, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/StarterShells/k4_v16mid1_shell.webp",
                }
            }
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
                    url = "./images/shells/StarterShells/k4_v16low1_shell.webp",
                }
            }
        },

        ["Garage"] = {
            label = "Garage",
            hash = `k4_garage6_shell`,
            doorOffset = { x = 13.695572, y = 1.629700, z = -0.750023, h = 94.825325, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "./images/shells/StarterShells/k4_garage6_shell.webp",
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
                    url = "./images/shells/StarterShells/k4_office6_shell.webp",
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
                    url = "./images/shells/StarterShells/k4_store1_shell.webp",
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
                    url = "./images/shells/StarterShells/k4_warehouse1_shell.webp",
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
                    url = "./images/shells/StarterShells/k4_container_shell.webp",
                }
            }
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
                    url = "./images/shells/StarterShells/k4_michael_shell.webp",
                }
            }
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
                    url = "./images/shells/StarterShells/k4_shell_medium1.webp",
                }
            }
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
                    url = "./images/shells/StarterShells/k4_ranch1_shell.webp",
                }
            }
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
                    url = "./images/shells/StarterShells/k4_lester1_shell.webp",
                }
            }
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
                    url = "./images/shells/StarterShells/k4_trevor1_shell.webp",
                }
            }
        },

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
                    url = "./images/shells/StarterShells/k4_trailer1_shell.webp",
                }
            }
        },
    }

    InsertInteriors(StarterShells, "K4MB1 Starter")
end)
