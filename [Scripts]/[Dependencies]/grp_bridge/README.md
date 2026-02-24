## Using GRP Bridge in Your Resource

To use GRP bridge functions (GRP.ShowNotification, GRP.GetPlayer, GRP.AddItem, etc.) in any resource:

1. Add `grp_bridge` to your dependencies in `fxmanifest.lua`:
```lua
dependencies {
    'grp_bridge',
    -- your other deps
}
```

2. Add `@grp_bridge/shared/init.lua` to your `shared_scripts` (must load before scripts that use GRP):
```lua
shared_scripts {
    '@grp_bridge/shared/init.lua',
    -- your other shared scripts
}
```

3. Use the GRP table directly (no exports): `GRP.ShowNotification('Hello')`, `GRP.GetPlayer(id)`, etc.


---

## Available Exports

### Client Exports

#### GetPlayerData
`exports.grp_bridge:GetPlayerData()`
Returns the current player's data including character info, job, inventory, etc.

#### IsPlayerLoaded
`exports.grp_bridge:IsPlayerLoaded()`
Returns true if the player has chosen their character and is loaded.

#### SetPlayerData
`exports.grp_bridge:SetPlayerData(key, value)`
Modifies the current player's data with the specified key and value.

#### OpenInventory
`exports.grp_bridge:OpenInventory()`
Opens the player's inventory through the framework.

#### ShowNotification
`exports.grp_bridge:ShowNotification(text)`
Shows a notification to the player through the framework.

#### Dispatch
`exports.grp_bridge:Dispatch(code, title, message, blip, jobs, important)`
Sends a police dispatch notification.

#### GetJob
`exports.grp_bridge:GetJob()`
Returns the current player's job name.

#### GetJobGrade
`exports.grp_bridge:GetJobGrade()`
Returns the current player's job grade number.

#### GetJobInfo
`exports.grp_bridge:GetJobInfo()`
Returns comprehensive job information including job name, label, grade details, boss status, and duty status.

**Returns:**
```lua
{
    jobName = "police",
    jobLabel = "Police",
    gradeName = "officer",
    gradeLabel = "Officer",
    gradeRank = 1,
    boss = false,
    onDuty = true
}
```

#### HasItem
`exports.grp_bridge:HasItem(item_name)`
Returns boolean and item count - checks if player has the given item in inventory.

#### GetInventory
`exports.grp_bridge:GetInventory()`
Returns the player's inventory contents.

#### CloseMenu
`exports.grp_bridge:CloseMenu()`
Closes any open menu (like esx_menu_default).

#### GetPlayerMetaData
`exports.grp_bridge:GetPlayerMetaData(metadata)`
Returns the player's metadata for the specified metadata key.

#### GetIsPlayerDead
`exports.grp_bridge:GetIsPlayerDead()`
Returns true if the player is dead or in last stand.

#### GetPlayerName
`exports.grp_bridge:GetPlayerName()`
Returns the player's first and last name.

#### GetInventoryResourceName
`exports.grp_bridge:GetInventoryResourceName()`
Returns the name of the currently active inventory system.

#### GetItemInfo
`exports.grp_bridge:GetItemInfo(item)`
Returns item information including name, label, weight, stack, and description.

#### GetAllItems
`exports.grp_bridge:GetAllItems()`
Returns a table of all available items in the framework.

#### GetItemCount
`exports.grp_bridge:GetItemCount(item)`
Returns the count of the specified item in player's inventory.

#### GetPlayerInventory
`exports.grp_bridge:GetPlayerInventory()`
Returns the player's complete inventory contents.

#### GetImagePath
`exports.grp_bridge:GetImagePath(item)`
Returns the image path for the specified item.

#### CanCarryItem
`exports.grp_bridge:CanCarryItem(item, count)`
Returns boolean - checks if player can carry the specified item and count.

#### GetInventoryWeight
`exports.grp_bridge:GetInventoryWeight()`
Returns the current inventory weight.

#### GetInventoryMaxWeight
`exports.grp_bridge:GetInventoryMaxWeight()`
Returns the maximum inventory weight.

---

## Inventory System

**Supported Systems:** `qb-inventory`, `ox_inventory`, `codem-inventory`, `origen_inventory`, `qs-inventory`, `tgiann-inventory`, `jpr-inventory`, `ps-inventory`, `core_inventory`

### Configuration
```lua
config.Inventory = "auto"  -- auto | qb-inventory | ox_inventory | codem-inventory | origen_inventory | qs-inventory | tgiann-inventory | jpr-inventory | ps-inventory | core_inventory
```

### Usage
```lua
-- Via GRP table (recommended)
GRP.AddItem(playerId, item, amount)
GRP.RemoveItem(playerId, item, amount)
GRP.HasItem(playerId, item, count)
GRP.GetItemCount(playerId, item)

-- Or direct exports
exports.grp_bridge:AddItem(playerId, item, amount)
exports.grp_bridge:RemoveItem(playerId, item, amount)
exports.grp_bridge:HasItem(playerId, item, count)
```

### Server Inventory Functions
- `GRP.AddItem(playerId, item, amount, slot, metadata)` - Add item to player's inventory
- `GRP.RemoveItem(playerId, item, amount, slot, metadata)` - Remove item from player's inventory
- `GRP.HasItem(playerId, item, requiredCount)` - Check if player has item
- `GRP.CanCarryItem(playerId, item, amount)` - Check if player can carry item
- `GRP.GetItemCount(playerId, item, metadata)` - Get item count in inventory
- `GRP.GetPlayerInventory(playerId)` - Get player's full inventory
- `GRP.GetItemBySlot(playerId, slot)` - Get item by slot number
- `GRP.SetItemMetadata(playerId, item, slot, metadata)` - Set item metadata
- `GRP.GetImagePath(item)` - Get item image path
- `GRP.OpenStash(playerId, type, stashId)` - Open stash/storage
- `GRP.RegisterStash(id, label, slots, weight, owner, groups, coords)` - Register new stash
- `GRP.AddStashItems(stashId, items)` - Add items to stash
- `GRP.RemoveStashItems(stashId, items)` - Remove items from stash
- `GRP.ClearStash(stashId, type)` - Clear stash contents
- `GRP.AddTrunkItems(vehiclePlate, items)` - Add items to vehicle trunk
- `GRP.OpenShop(playerId, shopId)` - Open shop
- `GRP.RegisterShop(shopId, inventory, coords, groups)` - Register new shop
- `GRP.UpdateVehiclePlate(oldPlate, newPlate)` - Update vehicle plate
- `GRP.OpenPlayerInventory(src, targetSrc)` - Open another player's inventory
- `GRP.GetInventoryResourceName()` - Get active inventory system name

### Client Inventory Functions
- `GRP.HasItem(item, requiredCount)` - Check if local player has item
- `GRP.GetItemCount(item)` - Get item count for local player
- `GRP.GetPlayerInventory()` - Get local player's inventory
- `GRP.GetInventory()` - Alias for GetPlayerInventory()
- `GRP.GetItemInfo(item)` - Get item information
- `GRP.GetAllItems()` - Get all available items
- `GRP.GetImagePath(item)` - Get item image path
- `GRP.CanCarryItem(item, count)` - Check if can carry item
- `GRP.GetInventoryWeight()` - Get current inventory weight
- `GRP.GetInventoryMaxWeight()` - Get max inventory weight

---

## Target System

**Supported Systems:** `ox_target`, `qb-target`

### Configuration
```lua
config.Target = "auto"  -- auto | ox_target | qb-target
```

### Usage
```lua
-- Via GRP table (recommended)
GRP.AddGlobalPlayer(options)
GRP.AddBoxZone(name, coords, size, heading, options, debug)

-- Or direct exports
exports.grp_bridge:AddGlobalPlayer(options)
exports.grp_bridge:AddBoxZone(name, coords, size, heading, options, debug)
```

### Target Functions
- `GRP.DisableTargeting(disable)` - Toggle targeting on/off
- `GRP.AddGlobalPlayer(options)` - Add options to all players
- `GRP.RemoveGlobalPlayer(optionNames)` - Remove player options
- `GRP.AddGlobalPed(options)` - Add options to all peds
- `GRP.RemoveGlobalPed(optionNames)` - Remove ped options
- `GRP.AddGlobalVehicle(options)` - Add options to all vehicles
- `GRP.RemoveGlobalVehicle(optionNames)` - Remove vehicle options
- `GRP.AddLocalEntity(entities, options)` - Add to local entity
- `GRP.RemoveLocalEntity(entities, labels)` - Remove from local entity
- `GRP.AddNetworkedEntity(netids, options)` - Add to networked entity
- `GRP.RemoveNetworkedEntity(netids, labels)` - Remove from networked entity
- `GRP.AddModel(models, options)` - Add to specific model(s)
- `GRP.RemoveModel(models, labels)` - Remove from model(s)
- `GRP.AddBoxZone(name, coords, size, heading, options, debug)` - Add box zone
- `GRP.AddSphereZone(name, coords, radius, options, debug)` - Add sphere zone
- `GRP.RemoveZone(name)` - Remove zone
- `GRP.GetTargetResourceName()` - Get active target system

---

## TextUI System

**Supported Systems:** `ox_lib`, `jg-textui`, `okokTextUI`, `cd_drawtextui`, `lation_ui`, framework native

### Configuration
```lua
config.TextUI = "auto"  -- auto | ox_lib | jg-textui | okokTextUI | cd_drawtextui | lation_ui
```

### Usage
```lua
-- Via GRP table (recommended)
GRP.ShowHelpText("Press [E] to interact", "left")
GRP.ShowAdvancedText({text = "Vehicle Unlocked", icon = "car"})

-- Or direct exports
exports.grp_bridge:ShowHelpText("Press [E] to interact", "left")
exports.grp_bridge:ShowAdvancedText({text = "Vehicle Unlocked", icon = "car"})
```

### TextUI Functions
- `GRP.ShowHelpText(message, position)` - Show help text
- `GRP.HideHelpText()` - Hide help text
- `GRP.ShowAdvancedText(options)` - Show advanced text with icon
- `GRP.UpdateText(message)` - Update displayed text
- `GRP.IsTextUIShowing()` - Check if TextUI is showing
- `GRP.GetTextUIResourceName()` - Get active TextUI system
- `GRP.ShowKeyHelp(key, message)` - Show key-based help
- `GRP.Draw3DText(coords, text, scale)` - Draw 3D text
---

## Progress Bar System

**Supported Systems:** `ox_lib`, `lation_ui`, `progressbar`

### Configuration
```lua
config.ProgressBar = "auto"  -- auto | ox_lib | lation_ui | progressbar
```

### Usage
```lua
-- Via GRP table (recommended)
GRP.ShowProgress(options, callback, isQBFormat)

-- Or direct exports
exports.grp_bridge:ShowProgress(options, callback, isQBFormat)
```

### Progress Bar Functions
- `GRP.ShowProgress(options, callback, isQBFormat)` - Show progress bar
- `GRP.GetProgressBarResourceName()` - Get active progress bar system

---

## Fuel System

**Supported Systems:** `ox_fuel`, `qb-fuel`, `ps-fuel`, `qs-fuelstations`, `legacyfuel`, `renewed-fuel`, `ti_fuel`, `lc_fuel`, `x-fuel`, `cdn-fuel`, `esx-sna-fuel`, `bigdaddy-fuel`, `okokgasstation`

### Configuration
```lua
config.Fuel = "auto"  -- auto | ox_fuel | qb-fuel | ps-fuel | qs-fuelstations | legacyfuel | renewed-fuel | ti_fuel | lc_fuel | x-fuel | cdn-fuel | esx-sna-fuel | bigdaddy-fuel | okokgasstation
```

### Usage
```lua
-- Via GRP table (recommended)
local fuel = GRP.GetFuel(vehicle)
GRP.SetFuel(vehicle, 75.0)
GRP.Refuel(vehicle)

-- Or direct exports
local fuel = exports.grp_bridge:GetFuel(vehicle)
exports.grp_bridge:SetFuel(vehicle, 75.0)
exports.grp_bridge:Refuel(vehicle)
```

### Fuel Functions
- `GRP.GetFuelResourceName()` - Get active fuel system name
- `GRP.GetFuel(vehicle)` - Get vehicle fuel level (0-100)
- `GRP.SetFuel(vehicle, fuel, fuelType?)` - Set vehicle fuel level
- `GRP.IsFuelSystemAvailable()` - Check if fuel system is available
- `GRP.GetFuelCapacity(vehicle)` - Get vehicle fuel capacity
- `GRP.NeedsFuel(vehicle, threshold?)` - Check if vehicle needs fuel
- `GRP.Refuel(vehicle, fuelType?)` - Refuel vehicle to full capacity

---

## Vehicle Keys System

**Supported Systems:** `qb-vehiclekeys`, `qbx_vehiclekeys`, `qs-vehiclekeys`, `Renewed-Vehiclekeys`, `wasabi_carlock`, `okokGarage`, `cd_garage`, `mk_vehiclekeys`, `mono_carkeys`, `MrNewbVehicleKeys`, `mVehicle`, `t1ger_keys`, `F_RealCarKeysSystem`, `jacksam`

### Configuration
```lua
config.VehicleKeys = "auto"  -- auto | qb-vehiclekeys | qbx_vehiclekeys | qs-vehiclekeys | Renewed-Vehiclekeys | wasabi_carlock | okokGarage | cd_garage | mk_vehiclekeys | mono_carkeys | MrNewbVehicleKeys | mVehicle | t1ger_keys | F_RealCarKeysSystem | jacksam
```

### Usage
```lua
-- Via GRP table (recommended)
GRP.GiveVehicleKeys(vehicle, plate)
GRP.RemoveVehicleKeys(vehicle, plate)

-- Or direct exports
exports.grp_bridge:GiveVehicleKeys(vehicle, plate)
exports.grp_bridge:RemoveVehicleKeys(vehicle, plate)
```

### Vehicle Keys Functions
- `GRP.GetVehicleKeysResourceName()` - Get active vehicle keys system name
- `GRP.GiveVehicleKeys(vehicle, plate?)` - Give vehicle keys to player
- `GRP.RemoveVehicleKeys(vehicle, plate?)` - Remove vehicle keys from player
- `GRP.IsVehicleKeysSystemAvailable()` - Check if vehicle keys system is available

---

## Banking System

**Supported Systems:** `qb-banking`, `okokBanking`, `fd_banking`, `renewed-banking`, `tgg-banking`, `kartik-banking`, `tgiann-bank`, `wasabi_banking`, `qb-management`, `qbx_management`, `esx_society`

### Configuration
```lua
config.Banking = "auto"  -- auto | qb-banking | okokBanking | fd_banking | renewed-banking | tgg-banking | kartik-banking | tgiann-bank | wasabi_banking | qb-management | qbx_management | esx_society
```

### Usage
```lua
-- Via GRP table (recommended)
GRP.AddAccountMoney(accountName, amount, reason)
GRP.RemoveAccountMoney(accountName, amount, reason)
GRP.GetAccountMoney(accountName)

-- Or direct exports
exports.grp_bridge:AddAccountMoney(accountName, amount, reason)
exports.grp_bridge:RemoveAccountMoney(accountName, amount, reason)
exports.grp_bridge:GetAccountMoney(accountName)
```

### Banking Functions
- `GRP.AddAccountMoney(accountName, amount, reason)` - Add money to a society/bank account
- `GRP.RemoveAccountMoney(accountName, amount, reason)` - Remove money from a society/bank account
- `GRP.GetAccountMoney(accountName)` - Get balance of a society/bank account

---

### Server Exports

#### GetPlayer
`exports.grp_bridge:GetPlayer(id)`
Returns player object (like xPlayer in ESX).

#### GetAllPlayers
`exports.grp_bridge:GetAllPlayers()`
Returns all online players.

#### GetPlayerJob
`exports.grp_bridge:GetPlayerJob(id)`
Returns the player's job name.

#### GetPlayerJobGrade
`exports.grp_bridge:GetPlayerJobGrade(id)`
Returns the player's job grade number.

#### GetPlayerJobInfo
`exports.grp_bridge:GetPlayerJobInfo(id)`
Returns comprehensive job information for a specific player including job name, label, grade details, boss status, and duty status.

**Returns:**
```lua
{
    jobName = "police",
    jobLabel = "Police",
    gradeName = "officer",
    gradeLabel = "Officer",
    gradeRank = 1,
    boss = false,
    onDuty = true
}
```

#### HasPermission
`exports.grp_bridge:HasPermission(playerId)`
Returns boolean - check if player has one of the configured admin groups.

#### AddMoney
`exports.grp_bridge:AddMoney(playerId, amount)`
Adds money to player (with most frameworks to their inventory).

#### RemoveMoney
`exports.grp_bridge:RemoveMoney(playerId, amount)`
Removes money from player (with most frameworks from their inventory).

#### RemoveBankMoney
`exports.grp_bridge:RemoveBankMoney(playerId, amount)`
Removes money from player's bank.

#### GetMoney
`exports.grp_bridge:GetMoney(playerId)`
Retrieves player's money (with most frameworks from their inventory).

#### GetBankMoney
`exports.grp_bridge:GetBankMoney(playerId)`
Retrieves player's money from bank.

#### TransferMoney
`exports.grp_bridge:TransferMoney(from, to, amount)`
Transfers bank money from one player to another.

#### GetItem
`exports.grp_bridge:GetItem(playerId, item_name)`
Retrieves info about an item from player's inventory.

#### CanCarryItem
`exports.grp_bridge:CanCarryItem(playerId, item_name, amount)`
Returns boolean - checks if player can carry the given item and count.

#### SetJob
`exports.grp_bridge:SetJob(playerId, job_name, job_grade)`
Set player's job.

#### GetIdentifier
`exports.grp_bridge:GetIdentifier(playerId)`
Returns player's rockstar identifier.

#### GetPlayerByCitizenId
`exports.grp_bridge:GetPlayerByCitizenId(cid)`
Returns player object by citizenid (QB/QBX) or identifier (ESX).

#### GetPlayerCoords
`exports.grp_bridge:GetPlayerCoords(playerId)`
Returns the coordinates of the given player ID.

#### GetPlayerMetadata
`exports.grp_bridge:GetPlayerMetadata(playerId, metadata)`
Gets the specified metadata key from the player's data.

#### SetPlayerMetadata
`exports.grp_bridge:SetPlayerMetadata(playerId, metadata, value)`
Sets the specified metadata key and value to the player's data.

#### GetPlayerDuty
`exports.grp_bridge:GetPlayerDuty(playerId)`
Returns the player's duty status.

#### GetIsPlayerDead
`exports.grp_bridge:GetIsPlayerDead(playerId)`
Returns true if the player is dead or in last stand.

#### GetPlayerName
`exports.grp_bridge:GetPlayerName(playerId)`
Returns the first and last name of the player.

#### RevivePlayer
`exports.grp_bridge:RevivePlayer(playerId)`
Revives a player if they are dead or in last stand.

#### RegisterUsableItem
`exports.grp_bridge:RegisterUsableItem(itemName, callback)`
Registers a usable item with a callback function for all frameworks.

#### GetInventoryResourceName
`exports.grp_bridge:GetInventoryResourceName()`
Returns the name of the currently active inventory system.

#### GetItemInfo
`exports.grp_bridge:GetItemInfo(item)`
Returns item information including name, label, weight, stack, and description.

#### GetAllItems
`exports.grp_bridge:GetAllItems()`
Returns a table of all available items in the framework.

#### GetItemCount
`exports.grp_bridge:GetItemCount(item)`
Returns the count of the specified item in player's inventory.

#### GetPlayerInventory
`exports.grp_bridge:GetPlayerInventory()`
Returns the player's complete inventory contents.

#### GetImagePath
`exports.grp_bridge:GetImagePath(item)`
Returns the image path for the specified item.

#### CanCarryItem
`exports.grp_bridge:CanCarryItem(item, count)`
Returns boolean - checks if player can carry the specified item and count.

#### GetInventoryWeight
`exports.grp_bridge:GetInventoryWeight()`
Returns the current inventory weight.

#### GetInventoryMaxWeight
`exports.grp_bridge:GetInventoryMaxWeight()`
Returns the maximum inventory weight.


### Usage in Other Resources

```lua
RegisterNetEvent('grp_bridge:Client:OnPlayerLoaded', function()
    -- Your code here - player is fully loaded
end)
```



## Complete Function List (GRP.FunctionName)

### Client Functions
```lua
-- Framework
GRP.GetFrameworkName()
GRP.IsPlayerLoaded()
GRP.GetPlayerData()
GRP.SetPlayerData(key, value)
GRP.OpenInventory()
GRP.ShowNotification(text)
GRP.Dispatch(code, title, message, blip, jobs, important)
GRP.GetJob()
GRP.GetJobGrade()
GRP.GetJobInfo()
GRP.HasItem(item_name)
GRP.GetInventory()
GRP.CloseMenu()
GRP.GetPlayerMetaData(metadata)
GRP.GetIsPlayerDead()
GRP.GetPlayerName()

-- Inventory System
GRP.GetInventoryResourceName()
GRP.GetItemInfo(item)
GRP.GetAllItems()
GRP.GetItemCount(item)
GRP.GetPlayerInventory()
GRP.GetImagePath(item)
GRP.CanCarryItem(item, count)
GRP.GetInventoryWeight()
GRP.GetInventoryMaxWeight()

-- Target System
GRP.DisableTargeting(disable)
GRP.AddGlobalPlayer(options)
GRP.RemoveGlobalPlayer(optionNames)
GRP.AddGlobalPed(options)
GRP.RemoveGlobalPed(optionNames)
GRP.AddGlobalVehicle(options)
GRP.RemoveGlobalVehicle(optionNames)
GRP.AddLocalEntity(entities, options)
GRP.RemoveLocalEntity(entities, labels)
GRP.AddNetworkedEntity(netids, options)
GRP.RemoveNetworkedEntity(netids, labels)
GRP.AddModel(models, options)
GRP.RemoveModel(models, labels)
GRP.AddBoxZone(name, coords, size, heading, options, debug)
GRP.AddSphereZone(name, coords, radius, options, debug)
GRP.RemoveZone(name)
GRP.GetTargetResourceName()

-- TextUI System
GRP.ShowHelpText(message, position)
GRP.HideHelpText()
GRP.ShowAdvancedText(options)
GRP.UpdateText(message)
GRP.IsTextUIShowing()
GRP.GetTextUIResourceName()
GRP.ShowKeyHelp(key, message)
GRP.Draw3DText(coords, text, scale)

-- Progress Bar System
GRP.ShowProgress(options, callback, isQBFormat)
GRP.GetProgressBarResourceName()

-- Fuel System
GRP.GetFuelResourceName()
GRP.GetFuel(vehicle)
GRP.SetFuel(vehicle, fuel, fuelType)
GRP.IsFuelSystemAvailable()
GRP.GetFuelCapacity(vehicle)
GRP.NeedsFuel(vehicle, threshold)
GRP.Refuel(vehicle, fuelType)

```

### Server Functions
```lua
GRP.GetFrameworkName()
GRP.GetPlayer(id)
GRP.GetAllPlayers()
GRP.GetPlayerJob(id)
GRP.GetPlayerJobGrade(id)
GRP.GetPlayerJobInfo(id)
GRP.HasPermission(playerId)
GRP.AddMoney(playerId, amount)
GRP.RemoveMoney(playerId, amount)
GRP.RemoveBankMoney(playerId, amount)
GRP.GetMoney(playerId)
GRP.GetBankMoney(playerId)
GRP.TransferMoney(from, to, amount)
GRP.AddItem(playerId, item_name, amount)
GRP.RemoveItem(playerId, item_name, amount)
GRP.GetItem(playerId, item_name)
GRP.CanCarryItem(playerId, item_name, amount)
GRP.SetJob(playerId, job_name, job_grade)
GRP.GetIdentifier(playerId)
GRP.GetPlayerByCitizenId(cid)
GRP.GetPlayerName(playerId)
GRP.GetPlayerCoords(playerId)
GRP.GetPlayerMetadata(playerId, metadata)
GRP.SetPlayerMetadata(playerId, metadata, value)
GRP.GetPlayerDuty(playerId)
GRP.GetIsPlayerDead(playerId)
GRP.RevivePlayer(playerId)
GRP.RegisterUsableItem(itemName, callback)
GRP.AddAccountMoney(accountName, amount, reason)
GRP.RemoveAccountMoney(accountName, amount, reason)
GRP.GetAccountMoney(accountName)

-- Inventory System
GRP.GetInventoryResourceName()
GRP.GetItemInfo(item)
GRP.GetAllItems()
GRP.GetItemCount(playerId, item, metadata)
GRP.GetPlayerInventory(playerId)
GRP.GetItemBySlot(playerId, slot)
GRP.SetItemMetadata(playerId, item, slot, metadata)
GRP.GetImagePath(item)
GRP.OpenStash(playerId, type, stashId)
GRP.RegisterStash(id, label, slots, weight, owner, groups, coords)
GRP.AddStashItems(stashId, items)
GRP.RemoveStashItems(stashId, items)
GRP.ClearStash(stashId, type)
GRP.AddTrunkItems(vehiclePlate, items)
GRP.OpenShop(playerId, shopId)
GRP.RegisterShop(shopId, inventory, coords, groups)
GRP.UpdateVehiclePlate(oldPlate, newPlate)
GRP.OpenPlayerInventory(src, targetSrc)
```


