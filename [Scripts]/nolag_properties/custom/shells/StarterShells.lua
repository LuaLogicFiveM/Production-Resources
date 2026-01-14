if not Config.Shells.K4mb1StarterShells then return end

CreateThread(function()
    local StarterShells = {
        ["Standard Motel"] = {
            label = "Standard Motel",
            hash = `standardmotel_shell`,
            doorOffset = { x = -0.333969, y = -2.507812, z = -0.556450, h = 268.611572, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/motel.png",
                    label = "Motel",
                },
            }
        },

        ["Modern Hotel"] = {
            label = "Modern Hotel",
            hash = `modernhotel_shell`,
            doorOffset = { x = 4.983124, y = 4.242126, z = -0.817879, h = 175.733047, width = 2.0 },
            stash = {
                maxweight = 80000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/angle_1.png",
                    label = "Modern Hotel",
                },
            }
        },

        ["Apartment Furnished"] = {
            label = "Apartment Furnished",
            hash = `furnitured_midapart`,
            doorOffset = { x = 1.381714, y = -10.131531, z = -0.521873, h = 2.176380, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/bathroom.webp",
                    label = "Bathroom",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/Bedroom.webp",
                    label = "Bedroom",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/entry.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/Kitchen_and_Dining.webp",
                    label = "Kitchen and Dining",
                },
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/living_room_1.webp",
                    label = "Living Room Angle 1",
                },
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/living_room_2.webp",
                    label = "Living Room Angle 2",
                },
            },
        },

        ["Apartment Unfurnished"] = {
            label = "Apartment Unfurnished",
            hash = `shell_v16mid`,
            doorOffset = { x = 1.436569, y = -14.037476, z = -0.492447, h = 350.256744, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/bedroom2.webp",
                    label = "Bathroom",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/bathroom2.webp",
                    label = "Bedroom",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/entry2.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/kitchen2.webp",
                    label = "Kitchen",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/livingroom2.webp",
                    label = "Living Room",
                },
            },
        },

        ["Apartment 2 Unfurnished"] = {
            label = "Apartment 2 Unfurnished",
            hash = `shell_v16low`,
            doorOffset = { x = -1.398575, y = 0.084961, z = 0.345619, h = 359.888092, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/entry3.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/kitchen3.webp",
                    label = "Kitchen",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/livingroom3.webp",
                    label = "Living Room",
                },
            },
        },

        ["Garage"] = {
            label = "Garage",
            hash = `shell_garagem`,
            doorOffset = { x = 13.695572, y = 1.629700, z = -0.750023, h = 94.825325, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/entry4.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/garage.webp",
                    label = "Garage",
                },
            },
        },

        ["Office"] = {
            label = "Office",
            hash = `shell_office1`,
            doorOffset = { x = 1.190720, y = 5.026306, z = -0.725456, h = 181.861404, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 30,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/entry5.webp",
                    label = "Entance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/office.webp",
                    label = "Office",
                },
            },
        },

        ["Store"] = {
            label = "Store",
            hash = `shell_store1`,
            doorOffset = { x = -2.791595, y = 4.445557, z = -0.619499, h = 181.964401, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/room_1.webp",
                    label = "Room 1",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/room_2.webp",
                    label = "Room 2",
                },
            },
        },

        ["Warehouse"] = {
            label = "Warehouse",
            hash = `shell_warehouse1`,
            doorOffset = { x = -8.839645, y = 0.077393, z = -0.949265, h = 273.723816, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/aangle1.webp",
                    label = "Angle 1",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/aangle2.webp",
                    label = "Angle 2",
                },
            },
        },

        ["Container"] = {
            label = "Container",
            hash = `container_shell`,
            doorOffset = { x = -0.042252, y = -5.402466, z = -0.213661, h = 1.775326, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/container.webp",
                    label = "Container",
                },
            },
        },

        ["2 Floor House"] = {
            label = "2 Floor House",
            hash = `shell_michael`,
            doorOffset = { x = -9.278595, y = 5.582825, z = -4.063576, h = 272.198761, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2bathroom.webp",
                    label = "Bathroom",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2entry.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2floor2.webp",
                    label = "Floor 2",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2kitchen.webp",
                    label = "Kitchen",
                },
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2livingroom.webp",
                    label = "Living Room",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2room1.webp",
                    label = "Room 1",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2room2.webp",
                    label = "Room 2",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/2room3.webp",
                    label = "Room 3",
                },
            },
        },

        ["House 1"] = {
            label = "House 1",
            hash = `shell_frankaunt`,
            doorOffset = { x = -0.336578, y = -5.757568, z = -0.569885, h = 1.891344, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3bathroom.webp",
                    label = "Bathroom",
                },
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3diningroom.webp",
                    label = "Dining Room",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3entry.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3kitchen.webp",
                    label = "Kitchen",
                },
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3livingroom.webp",
                    label = "Living Room",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3room1.webp",
                    label = "Room 1",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/3room2.webp",
                    label = "Room 2",
                },
            },
        },

        ["House 2"] = {
            label = "House 2",
            hash = `shell_ranch`,
            doorOffset = { x = -1.055878, y = -5.372253, z = -1.263123, h = 267.713745, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/4entry.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/4hallway.webp",
                    label = "Hallway",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/4kitchen.webp",
                    label = "Kitchen",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/4mainarea.webp",
                    label = "Main Area",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/4room.webp",
                    label = "Room",
                },
            },
        },

        ["House 3"] = {
            label = "House 3",
            hash = `shell_lester`,
            doorOffset = { x = -1.575439, y = -5.751587, z = -0.369637, h = 353.811432, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/lester3.png",
                    label = "Angle 1",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/lester2.png",
                    label = "Angle 2",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/lester1.png",
                    label = "Entrance",
                },
            },
        },

        ["House 4"] = {
            label = "House 4",
            hash = `shell_trevor`,
            doorOffset = { x = 0.238831, y = -3.535339, z = -0.407990, h = 358.348083, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/6bathroom.webp",
                    label = "Bathroom",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/6entry.webp",
                    label = "Entrance",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/6kitchen.webp",
                    label = "Kitchen",
                },
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/6livingroom.webp",
                    label = "Living Room",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/6room1.webp",
                    label = "Room 1",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/6room2.webp",
                    label = "Room 2",
                },
            },
        },

        ["Trailer"] = {
            label = "Trailer",
            hash = `shell_trailer`,
            doorOffset = { x = -1.302231, y = -1.846741, z = -0.479614, h = 0.268654, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url =
                    "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/7entranceandkitchen.webp",
                    label = "Entrance and Kitchen",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/7main.webp",
                    label = "Main",
                },
                {
                    url = "https://r2.fivemanage.com/R97q1rVBsp92SWyV2UCJi/7room1.webp",
                    label = "Room",
                },
            },
        },
    }

    InsertInteriors(StarterShells, "K4MB1 Starter")
end)
