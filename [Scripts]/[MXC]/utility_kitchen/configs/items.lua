Config.IgnoreItemsDurability = false -- If true, durability will always be nil, ignoring the cooking ratio of the item

Config.Items = {
    ["fries"] = {
        usable = true,
        server = function(source, item)
            Inventory.RemoveItem(source, item.name, 1, nil, item.slot)
        end,
        client = function(item)
            TaskEasyPlayAnim("mp_player_inteat@burger", "mp_player_int_eat_burger_fp")
            local netId = CreateFoodObject("mxc_kitchen_prop_fries_boxed_", item.metadata.cookingRatio, 0x49D9, vec3(0.14, 0.03, 0.04), vec3(-85.0, 137.0, -0.07))
            
            Citizen.Wait(5000)

            UtilityNet.DeleteEntity(netId)
            ClearPedTasks(PlayerPedId())

            Status.UpdatePlayerStatus({
                ["hunger"] = math.lerp(5, 30, (item.metadata.durability or 0) / 100) -- Hunger from 5 to 30 (5 = 0%, 30 = 100%) based on durability
            })
        end
    },
    ["hamburger"] = {
        usable = true,
        server = function(source, item)
            Inventory.RemoveItem(source, item.name, 1, nil, item.slot)
        end,
        client = function(item)
            TaskEasyPlayAnim("mp_player_inteat@burger", "mp_player_int_eat_burger_fp")

            -- Default burger when the burger used does not have "layers" metadata, such as when the item has been given by an admin
            if not item.metadata or not item.metadata.layers then
                item.metadata = {
                    layers = {
                        {model = "meat_", cookingRatio = 0.7},
                        {model = "tomatoes"},
                        {model = "salad"},
                        {model = "cheddar"},
                        {model = "pickles"},
                        {model = "bacon"},
                        {model = "ketchup"},
                        {model = "mayonnaise"},
                    }
                }
            end

            local hamburger = CreateHamburgerFromLayers(item.metadata.layers, true)
            local player = PlayerPedId()
            AttachEntityToEntity(hamburger, player, GetPedBoneIndex(player, 0x49D9), vec3(0.10, 0.03, 0.04), vec3(-85.0, 137.0, -0.07), false, false, false, false, 2, true)

            Citizen.Wait(5000)

            DeleteHamburger(hamburger)
            ClearPedTasks(player)

            Status.UpdatePlayerStatus({
                ["hunger"] = math.lerp(30, 60, (item.metadata.durability or 0) / 100) -- Calculate hunger based on durability (30 = 0%, 60 = 100%)
            })
        end
    }
}