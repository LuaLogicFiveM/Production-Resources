-- Check general for descriptions
Config.CookingItems = {
    ["Pizza"] = {
        duration = 42000
    }
}

Config.Interactions = {
    expansions = {
        pizza = {
            containers = {
                dough = {
                    take = {
                        label = Translate("pizza_take_dough") or "Take dough",
                        icon = "fas fa-hands-holding",
                        distance = 2.0,
                    },
                    store = {
                        label = Translate("pizza_store_dough") or "Store dough",
                        icon = "fas fa-hand-holding",
                        distance = 2.0
                    },

                    allowed_items = {"dough"}
                },
                little_fries_drop = {
                    label = Translate("pizza_drop_fries") or "Drop fries",
                    icon = "fas fa-bowl-food",
                    distance = 2.0
                }
            },
            pizza_station = {
                place = {
                    label = Translate("pizza_place_pizza") or "Place pizza",
                    icon = "fas fa-pizza-slice",
                    distance = 2.0
                },
                modify = {
                    label = Translate("pizza_place_toppings") or "Place toppings",
                    icon = "fas fa-shapes",
                    distance = 2.0
                }
            },
            dough_station = {
                place = {
                    label = Translate("pizza_place_dough") or "Place dough",
                    icon = "fas fa-hand-holding",
                    distance = 2.0
                },
                roll_out = {
                    label = Translate("pizza_roll_out_dough") or "Roll out dough",
                    icon = "fas fa-hand-back-fist",
                    distance = 2.0
                },
                default_toppings = {
                    label = Translate("pizza_place_default_toppings") or "Place default toppings",
                    icon = "fas fa-certificate",
                    distance = 2.0
                }
            },
            oven = {
                door_open = {
                    label = Translate("pizza_open_oven") or "Open",
                    icon = "fas fa-door-open",
                    distance = 2.0,
                },
                door_close = {
                    label = Translate("pizza_close_oven") or "Close",
                    icon = "fas fa-door-closed",
                    distance = 2.0,
                },
                place = {
                    label = Translate("pizza_place_in_oven") or "Place",
                    icon = "fas fa-fire",
                    distance = 2.0
                }
            },
            box = {
                open = {
                    label = Translate("pizza_open_box") or "Open",
                    icon = "fas fa-box-open",
                    distance = 2.0
                },
                close = {
                    label = Translate("pizza_close_box") or "Close",
                    icon = "fas fa-box",
                    distance = 2.0
                },
                complete = {
                    label = Translate("pizza_finish_pizza") or "Finish Pizza",
                    icon = "fas fa-face-kiss-wink-heart",
                    distance = 2.0
                }
            },
            littlecontainers = {
                sausages = {
                    allowed_items = {"sausage"}
                },
                artichokes = {
                    allowed_items = {"artichoke"}
                },
                chips = {
                    allowed_items = {"fries_pizza"}
                },
                hams = {
                    allowed_items = {"ham"}
                },
                mushrooms = {
                    allowed_items = {"mushroom"}
                },
                olives = {
                    allowed_items = {"olive"}
                },
                onions = {
                    allowed_items = {"onion"}
                },
                peppers = {
                    allowed_items = {"pepper"}
                },
                rawhams = {
                    allowed_items = {"rawham"}
                },
                spicysalami = {
                    allowed_items = {"pepperoni"}
                },
                tomatoes = {
                    allowed_items = {"tomato"}
                },
                wurstels = {
                    allowed_items = {"wurstel"}
                },
                basil = {
                    allowed_items = {"basil"}
                },
                rucola = {
                    allowed_items = {"rucola"}
                },
                tuna = {
                    allowed_items = {"tuna"}
                },
            }
        }
    }
}

Config.Kitchens = {
    ["mxc-pizzathis"] = {
        jobs = {
            -- ["mechanic"] = 1, -- [job_name] = job_grade
            -- ["mechanic2"] = 1
            --
            -- OR
            -- 
            -- "mechanic", -- job_name
            --"pizza_pier"
        },
        required = {
            resource = "cfx-mxc-pizzathis",
            expansion = "pizza"
        },
        exec = function()
        --LOCATION(VINEWOOD)
            CreatePizzaOven(vec3(545.0524, 106.9776, 96.47327), vec3(0.0, 0.0, -20.00))
            CreatePizzaStation(vec3(546.5109, 106.533066, 96.49608), vec3(0.0, 0.0, -20.00))
            CreateDoughContainer(vec3(545.779663, 106.851028, 96.51), vec3(0.0, 0.0, -20.00))

            CreateDoughStation(vec3(546.916748, 105.619026, 96.4825439), vec3(0.0, 0.0, -110.00))
            CreateRollingPin(vec3(546.885864, 105.281944, 96.51501), vec3(0.00, 0.00, 165.00))
            CreatePizzaPaddle(vec3(545.7971, 106.290451, 95.8719254), vec3(-75.00, 0.00, 165.00))

            CreatePizzaBox(vec3(546.745544, 104.945633, 96.4948349), vec3(0.0, 0.0, -110.00))

            CreateBin(vec3(546.0544, 104.686729, 95.55307), vec3(0.0, 0.0, -20.0))
        --LOCATION(ATLEE)
            CreatePizzaOven(vec3(289.72818, -971.16, 29.3534985), vec3(0.0, 0.0, -180.00))
            CreatePizzaStation(vec3(288.205566, -971.240967, 29.37631), vec3(0.0, 0.0, -180.00))
            CreateDoughContainer(vec3(289.0016, -971.2895, 29.390234), vec3(0.0, 0.0, -180.00))

            CreateDoughStation(vec3(287.5117, -970.5208, 29.3627758), vec3(0.0, 0.0, 90.00))
            CreateRollingPin(vec3(287.413879, -970.1986, 29.3952389), vec3(0.00, 0.00, -5.00))
            CreatePizzaPaddle(vec3(288.793365, -970.7686, 28.7521572), vec3(-75.00, 0.00, -5.00))

            CreatePizzaBox(vec3(287.4214, -969.8239, 29.3743382), vec3(0.0, 0.0, 90.00))

            CreateBin(vec3(287.977875, -969.335938, 28.43648), vec3(0.0, 0.0, 0.0))
        --LOCATION(DELPERRO)
            CreatePizzaOven(vec3(-1519.98657, -907.1055, 10.1024714), vec3(0.0, 0.0, -40.0))
            CreatePizzaStation(vec3(-1518.78613, -908.0137, 10.1246681), vec3(0.0, 0.0, -40.0))
            CreateDoughContainer(vec3(-1519.341, -907.483154, 10.1383533), vec3(0.0, 0.0, -40.0))

            CreateDoughStation(vec3(-1518.63013, -908.9486, 10.1066), vec3(0.0, 0.0, 230.0))
            CreateRollingPin(vec3(-1518.87036, -909.3033, 10.1434155), vec3(0.00, 0.00, 145.00))
            CreatePizzaPaddle(vec3(-1519.54858, -907.9833, 9.500334), vec3(-75.00, 0.00, 145.00))

            CreatePizzaBox(vec3(-1519.054, -909.6031, 10.12196), vec3(0.0, 0.0, 230.0))

            CreateBin(vec3(-1519.84009, -909.5644, 9.179554), vec3(0.0, 0.0, 140.0))

            -- Fryer can be used to make fries for pizza station little containers!
            --CreateFryer(vec3(-1521.9929, -910.0786, 10.1822), vec3(0.0, 0.0, 30.0))
        end
    },
    ["fm-aldente"] = {
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
            resource = "cfx-fm-aldente",
            expansion = "pizza"
        },
        exec = function()
            CreatePizzaOven(vec3(82.248764, 6.27150965, 68.5460739), vec3(0.0, 0.0, 160.0))
            CreatePizzaStation(vec3(81.6481, 7.568662, 68.5643845), vec3(0.0, 0.0, 70.0))
            CreateDoughContainer(vec3(84.19216, 7.31581736, 68.57482), vec3(0.0, 0.0, -30.0))

            CreateDoughStation(vec3(83.53167, 7.61189556, 68.5501556), vec3(0.0, 0.0, -110.0))
            CreateRollingPin(vec3(83.86661, 7.431823, 68.58174), vec3(0.00, 0.00, -115.00))
            --CreatePizzaPaddle(vec3(85.2576447, 6.164889, 67.91641), vec3(-75.00, 0.00, 75.00))
            CreatePizzaPaddle(vec3(83.3488, 6.30282068, 67.91641), vec3(-75.00, 0.00, -15.00))

            CreatePizzaBox(vec3(86.670105, 8.439488, 68.5460739), vec3(0.0, 0.0, -110.0))
            CreatePizzaBox(vec3(86.88865, 9.039928, 68.5460739), vec3(0.0, 0.0, -110.0))

            CreateBin(vec3(86.90472, 11.9911289, 67.59328), vec3(0.0, 0.0, 160.0))
        end
    },
    ["gabz-pizzeria"] = {
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
            resource = "cfx-gabz-pizzeria",
            expansion = "pizza"
        },
        exec = function()
            --KITCHEN COOKING
            CreateDoughContainer(vec3(808.1968, -756.8675, 26.54971), vec3(0.0, 0.0, -85.0))
            CreateDoughStation(vec3(807.2292, -756.929443, 26.5180648), vec3(0.0, 0.0, -20.0))
            CreateRollingPin(vec3(807.657043, -756.8715, 26.55371), vec3(0.00, 0.00, -75.00))
            CreatePizzaPaddle(vec3(808.3794, -757.3486, 26.0990839), vec3(-75.00, 0.00, -180.00))
            --MAIN AREA COOKING
            CreateDoughStation(vec3(811.4153, -754.556, 26.7426321), vec3(0.0, 0.0, 90.0))
            CreateDoughContainer(vec3(811.427, -755.3599, 26.7740669), vec3(0.0, 0.0, 90.0))
            CreateRollingPin(vec3(811.439636, -754.1353, 26.7777119), vec3(0.00, 0.00, -175.00))
            CreatePizzaStation(vec3(811.5257, -753.4324, 26.7615452), vec3(0.0, 0.0, 90.0))
            CreatePizzaOven(vec3(812.2412, -755.392334, 26.7372952), vec3(0.0, 0.0, -180.0))
            
            CreatePizzaPaddle(vec3(813.0728, -755.061, 26.0990839), vec3(-75.00, 0.00, 5.00))
            CreatePizzaBox(vec3(810.878357, -751.9907, 27.0529938), vec3(0.0, 0.0, 90.0))
            CreatePizzaBox(vec3(810.881, -750.761841, 27.0533943), vec3(0.0, 0.0, 90.0))
            
            CreateBin(vec3(813.554138, -754.729736, 25.82029722), vec3(0.0, 0.0, 90.0))
        end
    }
}

Config.Expansions = {
    ["pizza"] = {
        DoughMinigame = {
            active = true,
            keyboard = "wasd", -- "wasd" or "azerty"

            keys = { -- https://docs.fivem.net/docs/game-references/controls/#controls
                wasd = {
                    [1] = {
                        label = "W",
                        control = 32
                    },
                    [2] = {
                        label = "D",
                        control = 30
                    },
                    [3] = {
                        label = "Q",
                        control = 44
                    },
                },
                azerty = {
                    [1] = {
                        label = "Z",
                        control = 32
                    },
                    [2] = {
                        label = "D",
                        control = 30
                    },
                    [3] = {
                        label = "A",
                        control = 44
                    },
                }
            },

            clickDelay = 1500, -- (ms) Time to wait before asking to click the button
            timeToReact = 500, -- (ms) Time to react and press the key
        }
    }
}

Config.Items = {
    ["pizza_box"] = {
        usable = true,
        server = function(source, item)
        end,
        client = function(item)
            local pizza_box, pizza, ingredients = CreateScenePizzaBox(item.metadata.cookingRatio, item.metadata.ingredients)
            PlayEntityAnim(pizza_box, "clip@kitchen_pizza_anim", "pizzaboxopen_anim")

            warn(pizza_box)
            local open = PizzaInteractionLoop(pizza_box, item)

            -- Clean up
            if open then
                PlayEntityAnim(pizza_box, "clip@kitchen_pizza_anim", "pizzaboxclose_anim")
                Citizen.Wait(500)
            end

            DeleteScenePizzaBox(pizza_box, pizza, ingredients)
        end
    },
    ["pizza_slice"] = {
        usable = true,
        server = function(source, item)
            Inventory.RemoveItem(source, item.name, 1, nil, item.slot)
        end,
        client = function(item)
            local slice, ingredients = CreatePizzaSlice(item)
            local netId = NetworkGetNetworkIdFromEntity(PlayerPedId())

            TaskEasyPlayAnim("mp_player_inteat@burger", "mp_player_int_eat_burger")
            UtilityNet.AttachToNetId(slice, netId, GetPedBoneIndex(PlayerPedId(), 0x49D9), vec3(0.15, 0.05, 0.03), vec3(-220.0, -40.0, 7.0), false, false, 1, true)
    
            Citizen.Wait(5000)
    
            DeletePizzaSlice(slice, ingredients)
            ClearPedTasks(PlayerPedId())
    
            Status.UpdatePlayerStatus({
                ["hunger"] = math.lerp(5, 30, (item.metadata.durability or 0) / 100) -- Hunger from 5 to 30 (5 = 0%, 30 = 100%) based on durability
            })
        end
    }
}