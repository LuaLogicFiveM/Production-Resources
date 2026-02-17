return {
    progressCircle = false, -- If lib progressCircle should be used instead of progressBar
    openDistance = 1, -- Open distance on foot
    vehicleOpenDistance = 5, -- Open Distance in vehicle
    minimumPlateGrade = 0, -- Minimum grade to change plate
    repairTime = 5, -- Repair Time in seconds
    garages = {
        {
            name = 'Sheriff\'s Garage',
            groupRequired = 'sheriff',
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
                    name = 'DEA',
                    icon = 'star-of-life',
                    iconColor = '#1372ad',
                    gradeRequired = 0,
                    vehicles = {
                        {
                            model = 'gov_charger',
                            label = 'Charger',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 1, extras = {{id = 1, disabled = false}, {id = 2, disabled = true}} }
                        },
                    }
                },
                {
                    name = 'Patrol',
                    icon = 'fire',
                    iconColor = '#c9c304',
                    gradeRequired = 5,
                    vehicles = {
                        {
                            model = 'lib25durangost',
                            label = 'Durango Slicktop',
                            icon = 'circle',
                            iconColor = '#7a5f15',
                            mods = {livery = 1, extras = {{id = 1, disabled = false}, {id = 2, disabled = true}} }
                        }
                    }
                }
            },

            locations = {
                {
                    label = 'Sheriff\'s Office Garage',
                    size = vec3(15, 15, 5),
                    rotation = 0,
                    debug = true,
                    menuCoords = vec3(2809.2329, 4831.6733, 47.1904),
                    spawnCoords = vec4(2813.6406, 4826.3599, 47.1816, 190.1705)
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
