if not Config.Shells.IllegalOperationsPack then return end

CreateThread(function()
    local IllegalOperationsPack = {
        ["Coke Lab 2"] = {
            label = "Coke Lab 2",
            hash = `k4_labempty_shell`,
            doorOffset = { x = -6.301544, y = 8.576477, z = -0.958534, h = 182.188461, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labempty_shell.webp',
                },
            }
        },

        ["Weed Lab 2"] = {
            label = "Weed Lab 2",
            hash = `k4_labempty2_shell`,
            doorOffset = { x = 17.654602, y = 11.857483, z = -2.097000, h = 91.606949, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labempty2_shell.webp',
                },
            }
        },

        ["Acid House 1"] = {
            label = "Acid House 1",
            hash = `k4_labempty3_shell`,
            doorOffset = { x = -2.597839, y = 1.201233, z = 0.935951, h = 181.883179, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labempty3_shell.webp',
                }
            }
        },

        ["New Drug 1"] = {
            label = "New Drug 1",
            hash = `k4_labempty4_shell`,
            doorOffset = { x = 10.896744, y = 2.163574, z = -1.873688, h = 102.639023, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labempty4_shell.webp',
                }
            }
        },

        ["Coke Lab 3"] = {
            label = "Coke Lab 3",
            hash = `k4_labcoke_shell`,
            doorOffset = { x = -6.467941, y = 8.506592, z = -0.958466, h = 180.414093, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labcoke_shell.webp',
                }
            }
        },

        ["Coke Lab"] = {
            label = "Coke Lab",
            hash = `k4_labcoke2_shell`,
            doorOffset = { x = -10.841461, y = -2.638794, z = -0.072983, h = 272.195007, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labcoke2_shell.webp',
                }
            }
        },

        ["Meth Lab 1"] = {
            label = "Meth Lab 1",
            hash = `k4_labmeth_shell`,
            doorOffset = { x = -6.366852, y = 8.537903, z = -0.958458, h = 182.644928, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labmeth_shell.webp',
                }
            }
        },

        ["Meth Lab"] = {
            label = "Meth Lab",
            hash = `k4_labmeth2_shell`,
            doorOffset = { x = -10.746155, y = -2.587341, z = -0.072891, h = 268.795959, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labmeth2_shell.webp',
                }
            }
        },

        ["Weed Lab 3"] = {
            label = "Weed Lab 3",
            hash = `k4_labweed_shell`,
            doorOffset = { x = 17.697464, y = 11.791260, z = -2.096931, h = 96.449188, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labweed_shell.webp',
                }
            }
        },

        ["Weed Lab"] = {
            label = "Weed Lab",
            hash = `k4_labweed2_shell`,
            doorOffset = { x = -10.676392, y = -2.596497, z = -0.072960, h = 272.424988, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labweed2_shell.webp',
                }
            }
        },

        ["Laundry Place"] = {
            label = "Laundry Place",
            hash = `k4_laundry_shell`,
            doorOffset = { x = 10.477982, y = -5.670044, z = -2.386147, h = 353.682892, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_laundry_shell.webp',
                }
            }
        },

        ["Gun Warehouse"] = {
            label = "Gun Warehouse",
            hash = `k4_guns_shell`,
            doorOffset = { x = 0.035400, y = 4.658203, z = -0.814468, h = 177.624405, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_guns_shell.webp',
                }
            }
        },

        ["Acid House 2"] = {
            label = "Acid House 2",
            hash = `k4_labacid_shell`,
            doorOffset = { x = -2.765732, y = 1.167908, z = 0.936050, h = 178.011826, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_labacid_shell.webp',
                }
            }
        },

        ["Container 2"] = {
            label = "Container 2",
            hash = `k4_container2_shell`,
            doorOffset = { x = 0.079575, y = -5.524780, z = -0.213661, h = 358.452362, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_container2_shell.webp',
                }
            }
        },

        ["Furnished Stash 1"] = {
            label = "Furnished Stash 1",
            hash = `k4_stashhouse3_shell`,
            doorOffset = { x = 21.312180, y = -0.496887, z = -2.070793, h = 85.222633, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_stashhouse3_shell.webp',
                }
            }
        },

        ["Furnished Stash 2"] = {
            label = "Furnished Stash 2",
            hash = `k4_stashhouse4_shell`,
            doorOffset = { x = -0.122116, y = 5.444519, z = -1.011719, h = 182.489822, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_stashhouse4_shell.webp',
                }
            }
        },

        ['Bunkersilo Shell'] = {
            label = 'Bunkersilo Shell',
            hash = `k4_bunker_shell`,
            doorOffset = { x = -0.169434, y = 0.021484, z = 2.510483, h = 269.095215, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/IllegalOperationsPack/k4_bunker_shell.webp',
                }
            }
        },
    }

    InsertInteriors(IllegalOperationsPack, "K4MB1 Illegal Operations Pack")
end)
