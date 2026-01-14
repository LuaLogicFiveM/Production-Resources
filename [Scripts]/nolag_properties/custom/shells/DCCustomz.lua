if not Config.Shells.DCCustomz then return end

CreateThread(function()
    local DCCustomz = {
        ["DC Apartment 1"] = {
            label = "DC Apartment 1",
            hash = `bk_apartmentone`,
            doorOffset = { x = 1.540771, y = -2.907349, z = -0.363182, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/apt1.png",
                },
            }
        },

        ["DC Apartment 2"] = {
            label = "DC Apartment 2",
            hash = `bk_apartmenttwo`,
            doorOffset = { x = -7.216675, y = -0.770630, z = -0.364571, h = 270.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/apt2.png",
                },
            }
        },

        ["DC Apartment 3"] = {
            label = "DC Apartment 3",
            hash = `dc_apartmentthree`,
            doorOffset = { x = 1.931152, y = -5.933044, z = -0.355030, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/apt3.png",
                },
            }
        },

        ["DC Apartment 4"] = {
            label = "DC Apartment 4",
            hash = `dc_apartmentfour`,
            doorOffset = { x = -1.951172, y = -6.115295, z = -0.439957, h = 4.787943, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/apt41.png",
                },
            }
        },

        ["DC House 1"] = {
            label = "DC House 1",
            hash = `bk_houseone`,
            doorOffset = { x = 3.395996, y = -3.424683, z = -2.146027, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/house1.png",
                },
            }
        },

        ["DC House 2"] = {
            label = "DC House 2",
            hash = `dc_housetwoshell`,
            doorOffset = { x = 0.893555, y = -6.557922, z = -1.797283, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/house2.png",
                },
            }
        },

        ["DC House 3"] = {
            label = "DC House 3",
            hash = `dc_housethree`,
            doorOffset = { x = -8.373047, y = -2.479431, z = -0.497375, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/house3.png",
                },
            }
        },

        ["DC House 4"] = {
            label = "DC House 4",
            hash = `dc_housefour`,
            doorOffset = { x = 8.334991, y = 4.599335, z = -1.882324, h = 90.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/house4.png",
                },
            }
        },

        ["DC House 5"] = {
            label = "DC House 5",
            hash = `dc_housefive`,
            doorOffset = { x = 5.621460, y = -2.730499, z = -0.123283, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/house5.png",
                },
            }
        },

        ["DC House 6"] = {
            label = "DC House 6",
            hash = `dc_housesix`,
            doorOffset = { x = -4.257080, y = 13.136597, z = -1.848206, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/house6.png",
                },
            }
        },

        ["DC House 7"] = {
            label = "DC House 7",
            hash = `dc_houseseven`,
            doorOffset = { x = 0.608521, y = 1.784790, z = -0.451202, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/h71.png",
                },
            }
        },

        ["DC House 8"] = {
            label = "DC House 8",
            hash = `dc_houseeight`,
            doorOffset = { x = -3.575073, y = -11.641693, z = -1.987724, h = 356.258514, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/h81.png",
                },
            }
        },

        ["DC Trap 1"] = {
            label = "DC Trap 1",
            hash = `dc_trapshellone`,
            doorOffset = { x = 0.246094, y = 3.146912, z = -0.238735, h = 90.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/trap1.png",
                },
            }
        },

        ["DC Trap 2"] = {
            label = "DC Trap 2",
            hash = `dc_trapshelltwo`,
            doorOffset = { x = 1.418213, y = 3.788696, z = -0.265732, h = 90.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/trap2.png",
                },
            }
        },

        ["DC Trap 3"] = {
            label = "DC Trap 3",
            hash = `dc_trapshellthree`,
            doorOffset = { x = -0.000122, y = -6.097412, z = -0.837967, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/trap3.png",
                },
            }
        },

        ["DC Hotel Shell"] = {
            label = "DC Hotel Shell",
            hash = `dchotel_shell`,
            doorOffset = { x = 0.040527, y = 4.387962, z = -0.403328, h = 90.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/images/hotel1.png",
                },
            }
        },

        ["DC Townhouse 1"] = {
            label = "DC Townhouse 1",
            hash = `dc_townhouse`,
            doorOffset = { x = 3.735229, y = -5.845581, z = -1.967209, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/th1.png",
                },
            }
        },

        ["DC Townhouse 2"] = {
            label = "DC Townhouse 2",
            hash = `dc_townhousetwo`,
            doorOffset = { x = 3.735229, y = -5.845581, z = -1.967209, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/s9nylBx2i81FdGej13LAs/th21.png",
                },
            }
        },
    }

    InsertInteriors(DCCustomz, "DCCustomz")
end)
