return {
    progressCircle = false, -- If lib progressCircle should be used instead of progressBar
    openDistance = 1, -- Open distance on foot
    vehicleOpenDistance = 5, -- Open Distance in vehicle
    minimumPlateGrade = 0, -- Minimum grade to change plate
    repairTime = 5, -- Repair Time in seconds
    garages = {
        {
            name = 'BCSO Garage',
            groupRequired = 'bcso',
            distance = 5,
            plate = 'LEO '..math.random(000, 999),
            plateCallsign = true,

            marker = {
                type = 36,
                size = 1.5,
                r = 66, 
                g = 0, 
                b = 0,
                alpha = 80
            },

            categories = {
                {
                    name = 'Recruit',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 0,
                    vehicles = {
                        {
                            model = 'lib14charger',
                            label = '2014 Dodge Charger',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib13fpiu',
                            label = '2013 Ford Explorer',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib14tahoe',
                            label = '2014 Chevrolet Tahoe',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'libcvpi',
                            label = '2005 Crown Victoria',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Corporal',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 1,
                    vehicles = {
                        {
                            model = 'lib18fpis',
                            label = '2018 Ford Taurus',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib19fpiu',
                            label = '2016 Ford Explorer',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Sergeant',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 2,
                    vehicles = {
                        {
                            model = 'lib20durango',
                            label = '2020 Dodge Durango',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18tahoe',
                            label = '2018 Chevrolet Tahoe',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Sr. Sergeant',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 3,
                    vehicles = {
                        {
                            model = 'lib13fpiust',
                            label = '2013 Ford Explorer (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib14chargerst',
                            label = '2014 Dodge Charger (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib14tahoest',
                            label = '2014 Chevrolet Tahoe (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib19fpiust',
                            label = '2016 Ford Explorer (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18fpisst',
                            label = '2018 Ford Taurus (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18tahoest',
                            label = '2018 Chevrolet Tahoe (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib20durangost',
                            label = '2020 Dodge Durango (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib23chargerst',
                            label = '2023 Dodge Charger (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib25durangost',
                            label = '2025 Dodge Durango (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'libcvpist',
                            label = '2005 Crown Victoria (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'libramst',
                            label = '2018 Dodge Ram (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Captain',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 5,
                    vehicles = {
                        {
                            model = 'lib18f150',
                            label = '2018 Ford F-150',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18f150st',
                            label = '2018 Ford F-150 (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Major',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 6,
                    vehicles = {
                        {
                            model = 'lib20fpiu',
                            label = '2020 Ford Explorer',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib20fpiust',
                            label = '2020 Ford Explorer (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Supervisor',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 7,
                    vehicles = {
                        {
                            model = 'lib23tahoe',
                            label = '2023 Chevrolet Tahoe',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib23tahoest',
                            label = '2023 Chevorlet Tahoe (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Sr. Supervisor',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 8,
                    vehicles = {
                        {
                            model = 'lib23charger',
                            label = '2023 Dodge Charger',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'SWAT Division',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 8,
                    vehicles = {
                        {
                            model = 'mrap',
                            label = 'MRAP',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 2, extras = {{id = 1, disabled = false}, {id = 2, disabled = false}, {id = 3, disabled = false}, {id = 4, disabled = false}, {id = 5, disabled = false}, {id = 6, disabled = false}, {id = 7, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Motorcycle Division',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 8,
                    vehicles = {
                        {
                            model = 'mbu1flagbb',
                            label = 'MBU 1',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 1, extras = {{id = 1, disabled = false}, {id = 2, disabled = false}, {id = 3, disabled = false}, {id = 4, disabled = false}, {id = 5, disabled = false}, {id = 6, disabled = false}, {id = 7, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}} }
                        },
                        {
                            model = 'mbu2bb',
                            label = 'MBU 2',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 1, extras = {{id = 1, disabled = false}, {id = 2, disabled = false}, {id = 3, disabled = false}, {id = 4, disabled = false}, {id = 5, disabled = false}, {id = 6, disabled = false}, {id = 7, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}} }
                        },
                        {
                            model = 'mbu3bb',
                            label = 'MBU 3',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 1, extras = {{id = 1, disabled = false}, {id = 2, disabled = false}, {id = 3, disabled = false}, {id = 4, disabled = false}, {id = 5, disabled = false}, {id = 6, disabled = false}, {id = 7, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}} }
                        },
                    }
                }
            },

            locations = {
                {
                    label = 'Sheriff\'s Office Garage',
                    size = vec3(15, 15, 5),
                    rotation = 0,
                    debug = false,
                    menuCoords = vec3(2809.2329, 4831.6733, 47.1904),
                    spawnCoords = vec4(2813.6406, 4826.3599, 47.1816, 190.1705)
                }
            }
        },
        {
            name = 'SASP Garage',
            groupRequired = 'sasp',
            distance = 5,
            plate = 'LEO '..math.random(000, 999),
            plateCallsign = true,

            marker = {
                type = 36,
                size = 1.5,
                r = 66, 
                g = 0, 
                b = 0,
                alpha = 80
            },

            categories = {
                {
                    name = 'Recruit',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 0,
                    vehicles = {
                        {
                            model = 'lib14charger',
                            label = '2014 Dodge Charger',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib13fpiu',
                            label = '2013 Ford Explorer',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib14tahoe',
                            label = '2014 Chevrolet Tahoe',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'libcvpi',
                            label = '2005 Crown Victoria',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Corporal',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 1,
                    vehicles = {
                        {
                            model = 'lib18fpis',
                            label = '2018 Ford Taurus',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib19fpiu',
                            label = '2016 Ford Explorer',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Sergeant',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 2,
                    vehicles = {
                        {
                            model = 'lib20durango',
                            label = '2020 Dodge Durango',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18tahoe',
                            label = '2018 Chevrolet Tahoe',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Sr. Sergeant',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 3,
                    vehicles = {
                        {
                            model = 'lib13fpiust',
                            label = '2013 Ford Explorer (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib14chargerst',
                            label = '2014 Dodge Charger (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib14tahoest',
                            label = '2014 Chevrolet Tahoe (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib19fpiust',
                            label = '2016 Ford Explorer (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18fpisst',
                            label = '2018 Ford Taurus (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18tahoest',
                            label = '2018 Chevrolet Tahoe (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib20durangost',
                            label = '2020 Dodge Durango (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib23chargerst',
                            label = '2023 Dodge Charger (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib25durangost',
                            label = '2025 Dodge Durango (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'libcvpist',
                            label = '2005 Crown Victoria (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'libramst',
                            label = '2018 Dodge Ram (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Captain',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 5,
                    vehicles = {
                        {
                            model = 'lib18f150',
                            label = '2018 Ford F-150',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib18f150st',
                            label = '2018 Ford F-150 (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Major',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 6,
                    vehicles = {
                        {
                            model = 'lib20fpiu',
                            label = '2020 Ford Explorer',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib20fpiust',
                            label = '2020 Ford Explorer (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Supervisor',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 7,
                    vehicles = {
                        {
                            model = 'lib23tahoe',
                            label = '2023 Chevrolet Tahoe',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                        {
                            model = 'lib23tahoest',
                            label = '2023 Chevorlet Tahoe (Slicktop)',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                },
                {
                    name = 'Sr. Supervisor',
                    icon = 'fire',
                    iconColor = 'FF058B00',
                    gradeRequired = 8,
                    vehicles = {
                        {
                            model = 'lib23charger',
                            label = '2023 Dodge Charger',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 4, extras = {{id = 1, disabled = true}, {id = 2, disabled = false}, {id = 8, disabled = false}, {id = 9, disabled = false}, {id = 10, disabled = false}, {id = 11, disabled = false}, {id = 12, disabled = false}} }
                        },
                    }
                }
            },

            locations = {
                {
                    label = 'SASP Office Garage',
                    size = vec3(20, 30, 5),
                    rotation = 360.0,
                    debug = false,
                    menuCoords = vec3(874.4320, -1299.7228, 26.5150),
                    spawnCoords = vec4(875.1740, -1298.3398, 26.5154, 176.2496)
                }
            }
        },
    },

    giveVehicleKeys = function(entity, plate)
        exports.wasabi_carlock:GiveKey(plate)
    end,

    removeVehicleKeys = function(entity, plate)
        exports.wasabi_carlock:RemoveKey(plate)
    end,
}
