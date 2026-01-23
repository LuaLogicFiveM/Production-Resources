if not Config.Shells.GaragesPack then return end

CreateThread(function()
    local GaragesPack = {
        ["Garage 1"] = {
            label = "Garage 1",
            hash = `k4_garage1_shell`,
            doorOffset = { x = -0.201569, y = 14.128174, z = -0.937195, h = 173.779678, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/GaragesPack/k4_garage1_shell.webp',
                }
            }
        },

        ["Garage 2"] = {
            label = "Garage 2",
            hash = `k4_garage2_shell`,
            ddoorOffset = { x = -3.668610, y = -0.344116, z = -0.684700, h = 268.634735, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/GaragesPack/k4_garage2_shell.webp',
                }
            }
        },

        ["Garage 3"] = {
            label = "Garage 3",
            hash = `k4_garage3_shell`,
            doorOffset = { x = -3.579742, y = -0.179321, z = -0.686516, h = 271.577362, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/GaragesPack/k4_garage3_shell.webp',
                }
            }
        },

        ["Garage 4"] = {
            label = "Garage 4",
            hash = `k4_garage4_shell`,
            doorOffset = { x = 8.817535, y = 1.578125, z = -0.750000, h = 91.919441, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/GaragesPack/k4_garage4_shell.webp',
                }
            }
        },

        ["Garage Low End"] = {
            label = "Garage Low End",
            hash = `k4_garage5_shell`,
            doorOffset = { x = 5.745209, y = 3.649414, z = -0.500000, h = 184.022202, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/GaragesPack/k4_garage5_shell.webp',
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
                    url = './images/shells/GaragesPack/k4_garage6_shell.webp',
                }
            }
        },

        ["Garage High End"] = {
            label = "Garage High End",
            hash = `k4_garage7_shell`,
            doorOffset = { x = 12.249466, y = -14.443787, z = -0.999924, h = 86.852631, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = './images/shells/GaragesPack/k4_garage7_shell.webp',
                }
            }
        },
    }

    InsertInteriors(GaragesPack, "K4MB1 Garages Pack")
end)
