Config.Kitchens = {
    ["mxc-drivein-lapuerta"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            --"drivein_lapuerta"
        },
        required = {
            resource = "cfx-mxc-drivein"
        },

        exec = function()
            CreateBurgerTable(vec3(-305.693542, -1469.27686, 29.941721), vec3(0.0, 0.0, 180.0), {
                tableHidden = false,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(-305.691833, -1468.27991, 29.941721), vec3(0.0, 0.0, 180.0), {
                tableHidden = false,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateFryer(vec3(-304.2826, -1471.25049, 30.3790169), vec3(0.0, 0.0, 180.0))
            CreateFryer(vec3(-304.2833, -1470.4043, 30.3790169), vec3(0.0, 0.0, 180.0))

            CreateChipsTable(vec3(-303.806335, -1469.58374, 29.9410744), vec3(0.0, 0.0, -90.0))
            
            CreateGriddle(vec3(-303.214, -1470.875, 30.1634445), vec3(0.0, 0.0, 180.0))
            
            local spatulas = {
                vec4(-302.9245, -1471.6050, 31.9716473, 90.0),
                vec4(-304.7163, -1468.75659, 31.9695473, -90.0),
            }

            -- TODO: rename everything good
            for k,v in pairs(spatulas) do
                CreateSpatula(v.xyz, vec3(90.0, 0.0, v.w))
            end


            CreateBin(vec3(-301.8792, -1474.73633, 29.5946846), vec3(0.0, 0.0, -90.0))

            local containers = {
                vec4(-305.521576, -1465.53821, 30.38302, -180),
                vec4(-304.5891, -1465.58179, 30.38302, -90),
            }

            for k,v in pairs(containers) do
                CreateMeatContainer(v.xyz, vec3(0.0, 0.0, v.w))
            end

            CreatePattyWarmer(vec3(-303.373, -1471.994, 30.613), vec3(0.0, 0.0, -180.0))
        end
    },
    ["mxc-drivein-paleto"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            --"drivein_paleto"
        },
        required = {
            resource = "cfx-mxc-drivein"
        },

        exec = function()
            CreateBurgerTable(vec3(50.3341064, 6507.795, 30.6827545), vec3(0.0, 0.0, 45.0), {
                tableHidden = false,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(51.04191, 6507.0874, 30.6827545), vec3(0.0, 0.0, 45.0), {
                tableHidden = false,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateFryer(vec3(48.54058, 6507.593, 31.1214237), vec3(0.0, 0.0, 45.0))
            CreateFryer(vec3(47.9404221, 6508.193, 31.1214237), vec3(0.0, 0.0, 45.0))

            CreateChipsTable(vec3(48.78108, 6506.678, 30.6827545), vec3(0.0, 0.0, 135.0))
            
            CreateGriddle(vec3(47.451088, 6507.16943, 30.9055519), vec3(0.0, 0.0, 45.0))
            
            local spatulas = {
                vec4(46.73877, 6507.492, 32.71023563, 90.0),
                vec4(50.03763, 6506.69336, 32.7102356, -90.0),
            }

            -- TODO: rename everything good
            for k,v in pairs(spatulas) do
                CreateSpatula(v.xyz, vec3(90.0, 0.0, v.w))
            end


            CreateBin(vec3(46.96379, 6511.34375, 30.3311234), vec3(0.0, 0.0, -90.0))

            local containers = {
                vec4(52.8165779, 6505.03662, 30.7606773, -150),
                vec4(52.2614021, 6504.474, 31.1258984, 40),
            }

            for k,v in pairs(containers) do
                CreateMeatContainer(v.xyz, vec3(0.0, 0.0, v.w))
            end

            CreatePattyWarmer(vec3(46.785, 6508.092, 31.351), vec3(0.0, 0.0, 45.0))
        end
    },
    ["mxc-spacerestaurant"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "cfx-mxc-spacerestaurant"
        },

        exec = function()
            CreateBurgerTable(vec3(-912.145752, -2511.62183, 13.9568882), vec3(0.0, 0.0, -50.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(-914.163757, -2513.27051, 13.9568882), vec3(0.0, 0.0, -50.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateFryer(vec3(-912.628967, -2507.08447, 14.4146967), vec3(0.0, 0.0, 250.0))
            CreateFryer(vec3(-915.526733, -2506.173, 14.4146719), vec3(0.0, 0.0, 250.0))


            CreateChipsTable(vec3(-914.344055, -2508.235, 13.9555607), vec3(0.0, 0.0, 265.0), {
                tableHidden = true,
            })
            
            CreateGriddle(vec3(-914.8365, -2509.525, 14.15251), vec3(0.0, 0.0, 10.0), {
                tableHidden = true,
            })

            local spatulas = {
                vec4(-914.888245, -2509.999, 15.989975, 83.0),
                vec4(-914.997, -2508.998, 15.984, 90.0),
            }

            for k,v in pairs(spatulas) do
                CreateSpatula(v.xyz, vec3(90.0, 0.0, v.w))
            end


            CreateBin(vec3(-916.3346, -2506.51636, 13.6361456), vec3(0.0, 0.0, -90.0))

            local containers = {
                vec4(-915.515564, -2513.06128, 14.6019592, 130.0),
                vec4(-916.1327, -2512.35083, 15.0877342, 130.0),
            }

            for k,v in pairs(containers) do
                CreateMeatContainer(v.xyz, vec3(0.0, 0.0, v.w))
            end

            CreatePattyWarmer(vec3(-913.968, -2510.658, 14.623), vec3(0.017, 0.023, 109.0))
        end
    },
    ["mxc-spacerestaurant-vinewood"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "cfx-mxc-spacerestaurant"
        },

        exec = function()
            CreateBurgerTable(vec3(49.719, 204.214, 108.747), vec3(0.001, 0.0, -42.034), {tableHidden = true})
            CreateChipsTable(vec3(46.997, 207.198, 108.748), vec3(0.001, 0.0, -85.0), {tableHidden = true})
            CreateFryer(vec3(45.504, 209.112, 109.2), vec3(0.001, 0.0, -100.0), {tableHidden = false})
            CreatePattyWarmer(vec3(47.443, 204.707, 109.417), vec3(0.0, 0.0, 120.0), {tableHidden = false})
            CreateFryer(vec3(48.518, 208.617, 109.218), vec3(-0.001, 0.0, -99.277), {tableHidden = false})
            CreateBurgerTable(vec3(47.999, 202.287, 108.746), vec3(0.0, 0.0, -42.046), {tableHidden = true})
            CreateGriddle(vec3(46.716, 205.879, 108.945), vec3(0.0, 0.0, 15.976), {tableHidden = true})
            CreateMeatContainer(vec3(45.897, 202.864, 109.881), vec3(0.0, 0.0, -43.347), {tableHidden = false})
            CreateMeatContainer(vec3(46.573, 202.284, 109.385), vec3(0.0, -0.001, -41.522), {tableHidden = false})
            CreateSpatula(vec3(46.935, 205.164, 110.768), vec3(89.699, 0.232, -18.911), {tableHidden = false})
            CreateSpatula(vec3(46.566, 206.229, 110.757), vec3(90.519, -0.423, -104.755), {tableHidden = false})

            CreateEntityHider(vec3(44.775, 208.627, 108.42), vec3(0,0,0), {model = "prop_bin_11a"})
        end
    },
    ["map4all-rexdiner"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            --
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "map4all-rexs-diner"
        },
        exec = function()
            CreateBurgerTable(vec3(2538.357, 2586.34058, 37.89484), vec3(0.0, 0.0, 20.0), { tableHidden = true })
            CreatePattyWarmer(vec3(2538.795, 2585.309, 38.564), vec3(0.0, 0.0, 20.195), { tableHidden = false })
            CreateChipsTable(vec3(2535.16528, 2587.71655, 37.89384), vec3(0.0, 0.0, 200.0), { tableHidden = true, })
            CreateFryer(vec3(2535.58325, 2586.66382, 38.3216476), vec3(0.0, 0.0, 20.0))
            CreateFryer(vec3(2535.88062, 2585.85181, 38.3216476), vec3(0.0, 0.0, 20.0))
            CreateBin(vec3(2536.6530, 2583.128, 37.55), vec3(0.0, 0.0, 25.0))
            CreateGriddle(vec3(2536.48584, 2584.58, 38.10742), vec3(0.0, 0.0, 200.0))
            CreateMeatContainer(vec3(2538.06226, 2587.057, 38.5211563), vec3(0.0, 0.0, 180.0))
            CreateSpatula(vec3(2536.50879, 2583.54443, 39.350), vec3(90.0, 0.0, 80.0))
        end
    },
    ["gabz-hornys"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "cfx-gabz-hornys"
        },
        exec = function()
            CreateBurgerTable(vec3(1250.5426, -355.948, 68.40), vec3(0.0, 0.0, -105.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(1249.47607, -355.6622, 68.40), vec3(0.0, 0.0, -105.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateChipsTable(vec3(1251.89429, -356.2667, 68.392), vec3(0.0, 0.0, -105.0), {
                tableHidden = true,
            })

            CreateFryer(vec3(1246.99036, -354.858978, 68.8840942), vec3(0.0, 0.0, -15.0))

            CreateGriddle(vec3(1253.33142, -355.404877, 68.64), vec3(0.0, 0.0, -15.0), {
                tableHidden = true,
            })

            CreateMeatContainer(vec3(1249.310, -351.8914, 69.358), vec3(0.0, 0.0, 70.0))
            CreateMeatContainer(vec3(1248.4861, -351.7348, 69.695), vec3(0.0, 0.0, 140.0))

            CreateSpatula(vec3(1253.70776, -355.543518, 70.20), vec3(90.0, 0.0, -70.0))

            CreateBin(vec3(1248.72046, -355.452118, 68.08), vec3(0.0, 0.0, -105.0))
        end
    },
    ["gabz-burgershot"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "cfx-gabz-burgershot"
        },
        exec = function()
            CreateBurgerTable(vec3(-1189.199, -904.8527, 13.1093311), vec3(0.0, 0.0, -55.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(-1187.76392, -903.8479, 13.1093311), vec3(0.0, 0.0, -55.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateChipsTable(vec3(-1186.10364, -899.5079, 13.120888), vec3(0.0, 0.0, -145.0), {
                tableHidden = true,
            })

            CreateFryer(vec3(-1184.84827, -897.090942, 13.5903292), vec3(0.0, 0.0, 215.0))
            CreateFryer(vec3(-1184.3573, -897.7921, 13.5903292), vec3(0.0, 0.0, 215.0))

            CreateGriddle(vec3(-1186.80627, -900.753357, 13.371), vec3(0.0, 0.0, 124.0), {
                tableHidden = true,
            })

            CreateMeatContainer(vec3(-1188.24976, -900.8084, 13.7320385), vec3(0.0, 0.0, 140.0))
            CreateMeatContainer(vec3(-1188.34839, -904.2641, 13.736), vec3(0.0, 0.0, 140.0))
            CreateSpatula(vec3(-1187.6876, -901.0304, 13.6899), vec3(0.0, 0.0, 40.0))
            CreateSpatula(vec3(-1185.7413, -902.7070, 14.44), vec3(90.0, 0.0, 160.0))

            CreateBin(vec3(-1190.1466, -904.4678, 12.7984), vec3(0.0, 0.0, 125.0))
        end
    },
    ["kiiya-wigwam"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "kiiya_wigwam"
        },
        exec = function()
            CreateBurgerTable(vec3(-854.466064, -1123.30115, 6.36887646), vec3(0.0, 0.0, 30.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(-853.6418, -1124.72888, 6.36887646), vec3(0.0, 0.0, 30.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            
            CreateChipsTable(vec3(-853.7911, -1122.84753, 6.36826944), vec3(0.0, 0.0, -150.0), {
                tableHidden = true,
            })

            CreateFryer(vec3(-851.554565, -1122.2533, 6.79210758), vec3(0.0, 0.0, -150.0))
            CreateFryer(vec3(-851.1449, -1122.966, 6.79210758), vec3(0.0, 0.0, -150.0))
            CreateBin(vec3(-856.238159, -1120.97107, 6.00522137), vec3(0.0, 0.0, 30.0))
            CreateGriddle(vec3(-852.33606, -1121.12866, 6.57584), vec3(0.0, 0.0, 30))
            CreateMeatContainer(vec3(-854.7463, -1121.87085, 6.956026), vec3(0.0, 0.0, 125.0))
            CreateMeatContainer(vec3(-855.099548, -1122.07312, 6.956026), vec3(0.0, 0.0, 115.0))
            CreateSpatula(vec3(-852.097656, -1121.13123, 8.417391), vec3(90.0, 0.0, 80.0))
        end
    },
    ["kiiya_r68_diner_p"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "kiiya_r68_diner_p"
        },

        exec = function()
            CreateBurgerTable(vec3(1037.3210449219, 2658.7556152344, 39.261562347412), vec3(0.0, 0.0, 90.0), {
                tableHidden = false,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateFryer(vec3(1036.5587158203, 2655.3210449219, 39.702373504639), vec3(0.000, 0.000, 90.000))

            CreateChipsTable(vec3(1035.4459228516, 2655.2143554688, 39.265110015869), vec3(0.0, 0.0, -90.0))
            
            CreateGriddle(vec3(1037.9119873047, 2655.4299316406, 39.48165512085), vec3(0.000, 0.000, -90.0))
            
            local spatulas = {
                vec4(1039.3056640625, 2658.7097167969, 40.651912689209, -90.0),
            }

            for k,v in pairs(spatulas) do
                CreateSpatula(v.xyz, vec3(90.0, 0.0, v.w))
            end

            CreateBin(vec3(1033.0164794922, 2656.9963378906, 38.910327911377), vec3(0.0, 0.0, -90.0))

            local containers = {
                vec4(1035.3565673828, 2656.9392089844, 39.331398010254, -150),
            }

            for k,v in pairs(containers) do
                CreateMeatContainer(v.xyz, vec3(0.0, 0.0, v.w))
            end
        end
    },
    ["uniqx-burgershot"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            -- "mechanic2"
        },
        required = {
            resource = "uniqx_burgershot"
        },
        exec = function()
            CreateBurgerTable(vec3(-1201.57470703125, -895.4285278320312, 13.23871208190918), vec3(0.0, 0.0, 35.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })
            CreateBurgerTable(vec3(-1200.880126953125, -894.9649658203125, 13.22871208190918), vec3(0.0, 0.0, -145.0), {
                tableHidden = true,
                containers = {
                    [1] = "mxc_kitchen_prop_burger_littlecontainer_salad",
                    [2] = "mxc_kitchen_prop_burger_littlecontainer_bacon",
                    [3] = "mxc_kitchen_prop_burger_littlecontainer_tomatoes",
                    [4] = "mxc_kitchen_prop_burger_littlecontainer_cheddar",
                    [5] = "mxc_kitchen_prop_burger_littlecontainer_pickles",
                    [6] = "mxc_kitchen_prop_burger_littlecontainer_onions",
                    [7] = "prop_food_ketchup",
                    [8] = "prop_food_mustard",
                }
            })

            CreateChipsTable(vec3(-1194.0804443359375, -900.557373046875, 13.22863674163818), vec3(0.0, 0.0, 254.5), {
                tableHidden = true,
            })

            CreateChipsTable(vec3(-1198.15234375, -899.4197387695312, 13.22863674163818), vec3(0.0, 0.0, 254.5), {
                tableHidden = true,
            })

            CreateFryer(vec3(-1196.9373779296875, -899.7277221679688, 13.67258739471435), vec3(0.0, 0.0, 74.5))
            CreateFryer(vec3(-1196.1234130859375, -899.9540405273438, 13.67258739471435), vec3(0.0, 0.0, 74.5))
            CreateFryer(vec3(-1195.3165283203125, -900.1756591796875, 13.67258739471435), vec3(0.0, 0.0, 74.5))

            CreateGriddle(vec3(-1195.5633544921875, -897.7489013671875, 13.46395015716552), vec3(0.0, 0.0, 74.5), {
                tableHidden = false,
            })

            CreateMeatContainer(vec3(-1196.4820556640625, -897.1190185546875, 13.86016654968261), vec3(0.0, 0.0, 74.0))
            CreateMeatContainer(vec3(-1196.7906494140625, -897.0311279296875, 13.86016654968261), vec3(0.0, 0.0, 74.0))
            CreateMeatContainer(vec3(-1194.3455810546875, -897.7068481445312, 13.86016654968261), vec3(0.0, 0.0, 74.0))
            CreateMeatContainer(vec3(-1194.0255126953125, -897.7911376953125, 13.86016654968261), vec3(0.0, 0.0, 74.0))
            CreateSpatula(vec3(-1196.3421630859375, -897.4614868164062, 13.8104190826416), vec3(0.0, 0.0, 168.0))
            CreateSpatula(vec3(-1194.463134765625, -898.0081787109375, 13.8104190826416), vec3(0.0, 0.0, 81.0))

            CreateBin(vec3(-1192.43505859375, -900.4688110351562, 12.8838243484497), vec3(0.0, 0.0, -146.6))
            CreateBin(vec3(-1202.7403564453125, -894.8709106445312, 12.8838243484497), vec3(0.0, 0.0, 34.0))
            CreateBin(vec3(-1200.9364013671875, -893.66845703125, 12.8838243484497), vec3(0.0, 0.0, 34.0))
        end
    },
    ["wx-burgershot"] = {
        jobs = {},
        required = {
            resource = "wxmaps_burgershot"
        },

        exec = function()
            --LOCATION(Vespucci)
            CreateEntityHider(vec3(-1203.987, -895.848, 13.545), vec3(0, 0, 0), { model = "wx_burgershot_r02_oil" })
            CreateEntityHider(vec3(-1203.437, -897.75, 14.399), vec3(0, 0, 0), { model = "prop_utensil" })
            CreateFryer(vec3(-1203.543, -896.526, 13.539), vec3(0.0, 0.0, 34.0), { tableHidden = true })
            CreateFryer(vec3(-1203.987, -895.848, 13.545), vec3(0.0, 0.0, 34.0), { tableHidden = true })
            CreateChipsTable(vec3(-1204.776, -894.894, 13.13), vec3(0.0, 0.0, -146.0), { tableHidden = true })
            CreateGriddle(vec3(-1202.699, -897.638, 13.333), vec3(0.0, 0.0, -146.0), { tableHidden = true })
            CreateBin(vec3(-1198.977, -899.362, 12.799), vec3(0.0, 0.0, 31.56), { tableHidden = false })
            CreateBurgerTable(vec3(-1200.382, -896.604, 13.129), vec3(0.0, 0.0, 35.0), { tableHidden = true })
            CreateBurgerTable(vec3(-1200.964, -895.753, 13.13), vec3(0.0, 0.0, 35.0), { tableHidden = true })
            CreatePattyWarmer(vec3(-1201.533, -894.977, 13.793), vec3(0.0, 0.0, 123.455), { tableHidden = false })
            CreateMeatContainer(vec3(-1195.965, -899.143, 13.903), vec3(0.0, 0.0, 128.867), { tableHidden = false })
            CreateMeatContainer(vec3(-1195.714, -899.532, 13.902), vec3(0.0, 0.0, 23.952), { tableHidden = false })
            CreateSpatula(vec3(-1203.071, -898.154, 14.362), vec3(90.0, 0.0, 130.0), { tableHidden = false })
            --LOCATION(mirror)
            CreateEntityHider(vec3(1109.071, -879.866, 53.208), vec3(0, 0, 0), { model = "wx_burgershot_r02_oil" })
            CreateBurgerTable(vec3(1111.795, -882.392, 51.669), vec3(0.0, 0.0, -0.03), { tableHidden = true })
            CreateBurgerTable(vec3(1111.792, -881.382, 51.67), vec3(0.0, 0.0, 0.694), { tableHidden = true })
            CreatePattyWarmer(vec3(1111.801, -880.377, 52.34), vec3(0.0, 0.0, -90.5), { tableHidden = false })
            CreateGriddle(vec3(1109.263, -881.931, 51.871), vec3(0.0, 0.0, -179.619), { tableHidden = true })
            CreateSpatula(vec3(1108.586, -882.217, 52.823), vec3(90.0, 0.0, 90.5), { tableHidden = false })
            CreateBin(vec3(1111.25, -885.447, 51.32), vec3(0.0, 0.0, -177.971), { tableHidden = false })
            CreateChipsTable(vec3(1109.116, -878.507, 51.668), vec3(0.0, 0.0, -179.816), { tableHidden = true })
            CreateFryer(vec3(1109.217, -879.732, 52.076), vec3(0.0, 0.0, -0.022), { tableHidden = true })
            CreateFryer(vec3(1109.218, -880.536, 52.081), vec3(0.0, 0.0, 0.162), { tableHidden = true })
            CreateMeatContainer(vec3(1114.114, -886.943, 52.44), vec3(0.0, 0.0, 99.011), { tableHidden = false })
            CreateMeatContainer(vec3(1114.082, -887.44, 52.434), vec3(0.0, 0.0, -21.53), { tableHidden = false })
            --LOCATION(zancudo)
            CreateEntityHider(vec3(-2465.76, 2350.257, 33.198), vec3(0, 0, 0), { model = "wx_burgershot_r02_oil" })
            CreateBurgerTable(vec3(-2467.729, 2352.414, 32.529), vec3(0.0, 0.0, -179.87), { tableHidden = true })
            CreateBurgerTable(vec3(-2467.746, 2351.344, 32.526), vec3(0.0, 0.0, -179.934), { tableHidden = true })
            CreatePattyWarmer(vec3(-2467.731, 2350.385, 33.199), vec3(0.0, 0.0, 179.709), { tableHidden = false })
            CreateChipsTable(vec3(-2465.095, 2348.436, 32.533), vec3(0.0, 0.0, 0.351), { tableHidden = true })
            CreateFryer(vec3(-2465.218, 2350.556, 32.934), vec3(0.0, 0.0, 179.492), { tableHidden = true })
            CreateFryer(vec3(-2465.223, 2349.761, 32.934), vec3(0.0, 0.0, 179.895), { tableHidden = true })
            CreateGriddle(vec3(-2465.307, 2351.965, 32.731), vec3(0.0, 0.0, -0.439), { tableHidden = true })
            CreateSpatula(vec3(-2464.615, 2351.709, 33.688), vec3(89.371, -0.261, -89.997), { tableHidden = false })
            CreateBin(vec3(-2467.263, 2355.421, 32.195), vec3(0.0, 0.0, -18.582), { tableHidden = false })
            CreateMeatContainer(vec3(-2470.013, 2357.181, 33.298), vec3(0.0, 0.0, -116.502), { tableHidden = false })
            --LOCATION(paleto)
            CreateEntityHider(vec3(-303.546, 6123.152, 31.540), vec3(0, 0, 0), { model = "wx_burgershot_r02_oil" })
            CreateBurgerTable(vec3(-304.056, 6120.014, 30.869), vec3(0.318, 0.124, -43.481), { tableHidden = true })
            CreateBurgerTable(vec3(-303.328, 6120.738, 30.87), vec3(0.318, 0.124, -44.842), { tableHidden = true })
            CreatePattyWarmer(vec3(-302.615, 6121.378, 31.548), vec3(0.318, 0.124, -44.842), { tableHidden = false })
            CreateChipsTable(vec3(-303.136, 6124.66, 30.872), vec3(0.318, -0.014, 134.646), { tableHidden = true })
            CreateFryer(vec3(-304.523, 6123.081, 31.276), vec3(-0.316, -0.032, -44.929), { tableHidden = true })
            CreateFryer(vec3(-303.961, 6123.65, 31.272), vec3(-0.308, 0.08, -44.89), { tableHidden = true })
            CreateGriddle(vec3(-305.51, 6122.109, 31.076), vec3(0.317, 0.02, 135.035), { tableHidden = true })
            CreateSpatula(vec3(-305.768, 6122.7, 32.032), vec3(89.744, 0.253, 43.636), { tableHidden = false })
            CreateBin(vec3(-306.452, 6118.184, 30.529), vec3(0.0, 0.0, -72.109), { tableHidden = false })
            CreateMeatContainer(vec3(-305.58, 6115.166, 31.641), vec3(0.0, 0.0, 3.906), { tableHidden = false })
            CreateMeatContainer(vec3(-305.937, 6114.813, 31.649), vec3(0.0, 0.0, -69.289), { tableHidden = false })
        end
    },
    ["gn_burgershot_sandy"] = {
        jobs = {},
        required = {
            resource = "cfx_gn_burgershot_sandy"
        },

        exec = function()
            CreateEntityHider(vec3(1595.632, 3751.285, 34.434), vec3(0, 0, 0), { model = "gn_bs_mp_kitchen_efc" })
            CreateEntityHider(vec3(1595.632, 3751.285, 34.434), vec3(0, 0, 0), { model = "gn_bs_mp_kitchen_foodporn" })
            CreateEntityHider(vec3(1595.632, 3751.285, 34.434), vec3(0, 0, 0), { model = "gn_bs_mp_kitchen_skirt" })
            CreateEntityHider(vec3(1596.245, 3749.24, 34.351), vec3(0, 0, 0), { model = "prop_griddle_02" })
            CreateEntityHider(vec3(1592.729, 3752.491, 33.888), vec3(0, 0, 0), { model = "v_serv_waste_bin1" })
            CreateEntityHider(vec3(1590.99, 3754.902, 33.766), vec3(0, 0, 0), { model = "v_serv_waste_bin1" })
            CreateEntityHider(vec3(1599.887, 3751.723, 34.66), vec3(0, 0, 0), { model = "prop_crate_11b" })
            CreateGriddle(vec3(1594.9, 3748.575, 33.969), vec3(0.0, 0.0, -54.056), { tableHidden = true })
            CreateChipsTable(vec3(1596.273, 3749.236, 33.787), vec3(0.0, 0.0, -53.806), { tableHidden = true })
            CreateBurgerTable(vec3(1593.286, 3753.052, 33.777), vec3(0.0, 0.0, 125.489), { tableHidden = true })
            CreateFryer(vec3(1597.120, 3749.982, 34.220), vec3(0.0, 0.0, 125.600), {tableHidden = false})
            CreateFryer(vec3(1597.785, 3750.457, 34.220), vec3(0.0, 0.0, 125.600), {tableHidden = false})
            CreateBurgerTable(vec3(1592.753, 3754.14, 33.777), vec3(0.0, 0.0, -54.056), { tableHidden = true })
            CreatePattyWarmer(vec3(1594.285, 3754.16, 34.450), vec3(0.0, 0.0, 125.493), { tableHidden = false })
            CreatePattyWarmer(vec3(1593.98, 3754.599, 34.450), vec3(0.0, 0.0, -54.544), { tableHidden = false })
            CreateBin(vec3(1590.979, 3754.93, 33.422), vec3(0.0, 0.0, -95.572), { tableHidden = false })
            CreateBin(vec3(1592.743, 3752.458, 33.567), vec3(0.0, 0.0, 168.538), { tableHidden = false })
            CreateSpatula(vec3(1596.717, 3749.134, 35.081), vec3(90.119, -0.017, -145.822), { tableHidden = true })
            CreateMeatContainer(vec3(1600.228, 3751.979, 34.716), vec3(0.0, 0.0, 159.782), { tableHidden = false })
            CreateMeatContainer(vec3(1599.775, 3751.668, 34.708), vec3(0.0, 0.0, 42.446), { tableHidden = false })
        end
    },
    ["mirror"] = {
        jobs = {},
        required = {
            resource = "cfx-mxc-mirror"
        },

        exec = function()
            CreateEntityHider(vec3(-1352.08, -1079.925, 7.078), vec3(0, 0, 0), { model = "prop_bin_11a" })
            CreateBurgerTable(vec3(-1353.115, -1081.944, 7.402), vec3(0.0, 0.0, -150.05), { tableHidden = true })
            CreateMeatContainer(vec3(-1352.632, -1082.494, 8.021), vec3(0.0, 0.0, -138.048), { tableHidden = false })
            CreateChipsTable(vec3(-1350.676, -1084.903, 7.436), vec3(0.0, 0.0, -60.11), { tableHidden = true })
            CreateBurgerTable(vec3(-1352.397, -1083.218, 7.402), vec3(0.0, 0.0, -149.618), { tableHidden = true })
            CreateFryer(vec3(-1350.46, -1083.002, 7.864), vec3(0.0, 0.0, -149.789), { tableHidden = true })
            CreateFryer(vec3(-1350.869, -1082.294, 7.867), vec3(0.0, 0.0, -150.013), { tableHidden = true })
            CreateGriddle(vec3(-1351.799, -1080.929, 7.65), vec3(0.0, 0.0, 29.666), { tableHidden = true })
            CreateBin(vec3(-1352.08, -1079.925, 7.078), vec3(0.0, 0.0, -150.0), { tableHidden = false })
            CreateSpatula(vec3(-1352.747, -1083.474, 8.531), vec3(90.907, 0.0, 123.124), {tableHidden = false})
        end
    },
}