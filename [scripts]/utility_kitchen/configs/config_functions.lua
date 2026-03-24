Config.Functions = {
    StartFramework = function()
        if GetResourceState("es_extended") ~= "missing" then
            ESX = exports["es_extended"]:getSharedObject()
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore = exports["qb-core"]:GetCoreObject()
        end
    end,

    -- Inventory management, AddItem and RemoveItem will be called only if the action is performed on the player inventory
    --[[
    AddItem = function(source, item, amount, metadata)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/AddItem/
        AddItem(source, item, amount, metadata)
    end,

    RemoveItem = function(source, item, amount, metadata, slot)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/RemoveItem/
        RemoveItem(source, item, amount)
    end
    ]]

    --- Registers a usable item
    --- @param item string The name of the item that can be used
    --- @param func fun(source:number, item:table) Function that is called when the item is used, item is a table with the following keys: name, label, count, slot and metadata
    
    --RegisterUsableItem = function(item, func)
    --    
    --end

    --- Register custom inventory 
    --- You can also share your code in our compatibility channel, thank you!
    --- (you need to know how to code properly before modifying this, we will not assist you in a ticket)
    --- @param resource string The name of the resource 
    --- @return table The inventory functions
    LoadInventoryForResource = function(resource)
        if resource == "my_example_inventory_resource" then
            return {
                --- Registers a stash inventory
                --- @param id string The id of the stash inventory
                --- @param label string The label of the stash inventory
                --- @param slots number The number of slots the stash inventory has
                --- @param maxWeight number The weight limit of the stash inventory
                --- @param owner boolean|number The owner of the stash inventory
                registerInventory = function(self, id, label, slots, maxWeight, owner)
                    id = Inventory.Identifier.ToString({id = id, owner = owner})
        
                    exports.ox_inventory:RegisterStash(
                        id, label, slots, maxWeight, 
                        owner == true -- Handled directly using the id (to avoid conflicts with other inventories, just keep true being handled by ox_inventory)
                    )
                end,
                --- Retrieves the inventory for a given identifier
                --- @param id number|string The identifier of the inventory (can be a number or string, number = player, string = stash)
                --- @return table The inventory items associated with the identifier
                getInventory = function(self, id)
                    if type(id) == "number" then
                        return exports.ox_inventory:GetInventoryItems(id)
                    else
                        id = Inventory.Identifier.ToString(id)
                        
                        return exports.ox_inventory:GetInventory(id)
                    end
                end,
                --- Adds an item to an inventory
                --- @param id number|string The identifier of the inventory (can be a number or string, number = player, string = stash)
                --- @param item string The name of the item
                --- @param count number The number of items to add
                --- @param metadata table The metadata of the item
                --- @param slot number The slot to add the item in
                addItem = function(self, id, item, count, metadata, slot)
                    if type(id) == "number" then
                        return exports.ox_inventory:AddItem(id, item, count, metadata, slot)
                    else
                        id = Inventory.Identifier.ToString(id)
            
                        exports.ox_inventory:AddItem(id, item, count, metadata, slot)
                    end
                end,
                --- Removes an item from an inventory
                --- @param id number|string The identifier of the inventory (can be a number or string, number = player, string = stash)
                --- @param item string The name of the item to remove
                --- @param count number The number of items to remove
                --- @param metadata table The metadata of the item
                --- @param slot number The slot from which to remove the item
                removeItem = function(self, id, item, count, metadata, slot)
                    if type(id) == "number" then
                        exports.ox_inventory:RemoveItem(id, item, count, metadata, slot)
                    else
                        id = Inventory.Identifier.ToString(id)
            
                        exports.ox_inventory:RemoveItem(id, item, count, metadata, slot)
                    end
                end,
                --- Retrieves the count of a specific item in the inventory
                --- @param id number|string The identifier of the inventory (can be a number or string, number = player, string = stash)
                --- @param item string The name of the item to count
                --- @return number The count of the specified item in the inventory
                getItemCount = function(self, id, item)
                    if type(id) == "number" then
                        return exports.ox_inventory:Search(id, "count", item) or 0
                    else
                        id = Inventory.Identifier.ToString(id)

                        return exports.ox_inventory:Search(id, "count", item) or 0
                    end
                end,
                --- Checks if an item can be added to an inventory
                --- @param id number|string The identifier of the inventory (can be a number or string, number = player, string = stash)
                --- @param item string The name of the item to check
                --- @param count number The number of items to check
                --- @return boolean If the item can be added to the inventory
                canCarryItem = function(self, id, item, count)
                    return exports.ox_inventory:CanCarryItem(id, item, count)
                end,
                --- Registers a usable item
                --- @param item string The name of the item that can be used
                --- @param func fun(source:number, item:table) Function that is called when the item is used, item is a table with the following keys: name, label, count, slot and metadata
                registerUsableItem = function(self, item, func)
                    RegisterUsableItem({
                        qb = true,
                        esx = true
                    }, "ox_inventory", item, function(source, itemData)
                        exports['lorp_packed']:SendLog('Restaurants', ('# Food Creation Log  \n ## Item Data  \n %s  \n ## Player ID  \n %i'):format(json.encode(itemData), source), 'https://discord.com/api/webhooks/1483254474477801622/cJ4i-nveS6_AcmrvsCG-DVShl5jPAZPeJIQ3GBzjLD5WMBg9qzGyKhyTLjcPerLCvfYp')

                        if func then
                            func(source, itemData)
                        end
                    end)
                end,
                --- Registers a hook for swapping items between inventories
                --- 
                --- The callback must implement payload formatting (without fromType and toType) and 
                --- also ensure that if false is returned the swap is canceled 
                --- or the inventory must restore the state before the swap.
                --- @param cb fun(payload:table) The callback function to be executed on item swap, fromType and toType are not implemented! (https://overextended.dev/ox_inventory/Functions/Server/Hooks#swapitems)
                --- @param _filter table Optional filter for inventory swaps (https://overextended.dev/ox_inventory/Functions/Server/Hooks, currently only inventoryFilter is used)
                onSwapItems = function(self, cb, _filter)
                    exports.ox_inventory:registerHook("swapItems", cb, _filter)
                end
            }
        end
    end,

    -- Client side!
    -- This function will be called when the player is opening a inventory (you can call the custom inventory function)
    --- @param stashId string The id of the inventory
    --OpenLoadedInventory = function(stashId)
    --        
    --end,

    --[[
    -- Client side!
    --- @param filter table
    --- @return boolean
    CustomJobCheck = function(filter)
            
    end,
    ]]

    --[[
    TargetAddModel = function(models, options)

    end,
    TargetAddLocalEntity = function(entity, options)

    end,
    TargetRemoveLocalEntity = function(entity)

    end,
    ]]

    --------------------------- Pizza Expansion ---------------------------
    
    --- Starts the dough call to action
    --- @param self table The dough station class instance
    --- @param index number The index of the call to action to start
    --- @return boolean If the player reacted and clicked the key
    StartDoughCallToAction = function(self, index)
        return self:CallToAction(index)
    end
}