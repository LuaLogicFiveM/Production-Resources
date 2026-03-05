# Template for Integrating a Custom Gang System with WSB Gang Wars

> *This template guides you through integrating a custom gang system into the wasabi_gangwars. The goal is to synchronize gang data (gangs, members, and owners) from your custom system into the WSB tables (wsb_gangwars_gangs and wsb_gangwars_members) to support gang war features. The template includes placeholders for your database schema, events, and framework specifics.*

## Step 1: Configure the Script
1. Open `config.lua`.
2. Set `Config.GangSystem` to a unique identifier for your system, e.g., `'customgangs'`.
   ```lua
   Config.GangSystem = 'customgangs'  -- Replace with your unique identifier
   ```
3. Create a directory for your integration, e.g., `server/sync/customgangs/`.


## Step 2: Create Server-Side Logic (`server.lua`)
Create a `server.lua` file in your integration directory to handle gang synchronization and updates. This file should:
- Define a `SyncGangs()` function to sync gangs and members.
- Handle real-time gang update events (e.g., join, leave, promote).

### Template for `server.lua`
```lua
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if Config.GangSystem ~= 'customgangs' then return end  -- Replace with your Config.GangSystem value

-- Replace with your database schema, e.g.:
-- custom_gangs: id (int), name (string), leader_identifier (string)
-- custom_players: identifier (string), full_name (string), gang_id (int), is_leader (boolean)

function SyncGangs()
    -- Fetch gangs from your custom table
    local customGangs = {}
    local gangRows = MySQL.query.await("SELECT id, name, leader_identifier FROM custom_gangs")  -- Replace with your query
    for _, gang in ipairs(gangRows) do
        customGangs[gang.name] = { id = gang.id, leader = gang.leader_identifier }  -- Adapt to your column names
    end

    -- Fetch existing WSB gangs
    local wsbGangs = {}
    local wsbGangRows = MySQL.query.await("SELECT id, name, owner FROM wsb_gangwars_gangs")
    for _, v in ipairs(wsbGangRows) do
        wsbGangs[v.name] = { id = v.id, owner = v.owner }
    end

    -- Insert missing gangs into WSB
    local newGangs = {}
    local newGangNames = {}
    for gangName, data in pairs(customGangs) do
        if not wsbGangs[gangName] and gangName ~= "" and gangName ~= "none" then  -- Skip invalid gangs
            newGangs[#newGangs + 1] = { gangName }
            newGangNames[#newGangNames + 1] = gangName
        end
    end

    if #newGangs > 0 then
        MySQL.insert.await("INSERT INTO wsb_gangwars_gangs (name) VALUES ?", { newGangs })
        -- Refresh WSB gang cache
        local updatedGangs = MySQL.query.await("SELECT id, name, owner FROM wsb_gangwars_gangs WHERE name IN (?)", { newGangNames })
        for _, v in ipairs(updatedGangs) do
            wsbGangs[v.name] = { id = v.id, owner = v.owner }
        end
    end

    -- Fetch players/members from your custom table
    local players = MySQL.query.await("SELECT identifier, full_name, gang_id, is_leader FROM custom_players WHERE gang_id IS NOT NULL")  -- Replace with your query

    -- Cache existing WSB members
    local existingMembers = {}
    local memberRows = MySQL.query.await("SELECT identifier, gangId FROM wsb_gangwars_members")
    for _, row in ipairs(memberRows) do
        existingMembers[row.identifier] = row.gangId
    end

    -- Prepare new members and owner updates
    local newMembers = {}
    local ownerUpdates = {}
    for _, player in ipairs(players) do
        local identifier = player.identifier
        local gangId = player.gang_id
        if not identifier or not gangId then goto continue end

        -- Find gang name from custom cache
        local gangName
        for name, data in pairs(customGangs) do
            if data.id == gangId then
                gangName = name
                break
            end
        end
        if not gangName then goto continue end

        local wsbGangData = wsbGangs[gangName]
        if not wsbGangData or not wsbGangData.id then goto continue end

        -- Update owner if player is leader and no owner set
        if player.is_leader and not wsbGangData.owner then
            ownerUpdates[#ownerUpdates + 1] = { identifier, wsbGangData.id }
        end

        -- Add new member if not already in WSB
        if not existingMembers[identifier] then
            newMembers[#newMembers + 1] = { identifier, wsbGangData.id, player.full_name }
            existingMembers[identifier] = wsbGangData.id
        end
        ::continue::
    end

    -- Apply owner updates
    if #ownerUpdates > 0 then
        for _, update in ipairs(ownerUpdates) do
            local identifier, gangId = update[1], update[2]
            if identifier and gangId then
                MySQL.update.await("UPDATE wsb_gangwars_gangs SET owner = ? WHERE id = ?", { identifier, gangId })
            end
        end
    end

    -- Insert new members
    if #newMembers > 0 then
        MySQL.insert.await("INSERT INTO wsb_gangwars_members (identifier, gangId, name) VALUES ?", { newMembers })
    end
end

-- Event handler for real-time gang updates
local timeout = {}  -- Prevent event spam
RegisterNetEvent('customgangs:server:onGangUpdate', function(source, gangData)  -- Replace with your event name
    if timeout[source] then return end
    timeout[source] = true
    SetTimeout(1000, function() timeout[source] = nil end)

    local identifier = wsb.getIdentifier(source)
    if not identifier then return end

    local playerGang = GetPlayerGang(identifier)  -- WSB function to get current gang
    if not gangData or not gangData.name or gangData.name == 'none' then
        if playerGang then
            if playerGang.owner == identifier then
                playerGang:update({ owner = 'null' }, true)
            end
            playerGang:kickMember(identifier)
        end
        return
    end

    local gangId, gangObj = GetGangId(gangData.name)  -- WSB functions
    if not gangId or not gangObj then
        print('^0[^3WARNING^0] Gang ' .. tostring(gangData.name) .. ' not found in ' .. GetCurrentResourceName())
        return
    end

    local isLeader = gangData.is_leader  -- Replace with your leader check (e.g., gangData.is_leader, gangData.rank >= someValue)

    if not playerGang then
        if isLeader and (not gangObj.owner or gangObj.owner == 'null') then
            gangObj:update({ owner = identifier }, true)
        end
        gangObj:addMember(identifier, isLeader)
        return
    end

    if playerGang.name ~= gangData.name then
        if playerGang.owner == identifier then
            playerGang:update({ owner = 'null' }, true)
        end
        if playerGang:kickMember(identifier) then
            gangObj:addMember(identifier, isLeader)
        end
    else
        if isLeader and (not playerGang.owner or playerGang.owner == 'null') then
            playerGang:update({ owner = identifier }, true)
        end
        -- Update permissions for leaders
        playerGang:getMember(identifier):update({
            canInvite = isLeader,
            canManagePermissions = isLeader,
            canKick = isLeader,
            canDeposit = isLeader,
            canWithdraw = isLeader,
            canSendWar = isLeader,
            canAcceptWar = isLeader,
            canDeclineWar = isLeader,
            canRevokeWar = isLeader
        }, true)
    end
end)
```

### Customization Notes for `server.lua`
- **Database Queries**: Replace `custom_gangs` and `custom_players` with your actual table names. Adjust column names (e.g., `leader_identifier`, `full_name`, `gang_id`, `is_leader`) to match your schema.
- **Gang Data**: Ensure `gangData` in the event handler contains `name` (string) and a leader indicator (e.g., `is_leader`, `rank`).
- **Identifier**: Confirm `wsb.getIdentifier(source)` matches your system's identifier (e.g., `citizenid`, `license`).
- **Event Name**: Replace `'customgangs:server:onGangUpdate'` with your system's event name for gang changes.
- **JSON Data**: If your system stores data as JSON (e.g., QB-Core's `gang` or `charinfo`), use `json.decode` to parse it.

## Step 3: Create Client-Side Logic (`client.lua`) - Optional
If your custom gang system triggers client-side events for gang changes, create a `client.lua` file to forward these to the server.

### Template for `client.lua`
```lua
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if Config.GangSystem ~= 'customgangs' then return end  -- Replace with your Config.GangSystem value

RegisterNetEvent('customgangs:client:onGangChange', function(gangData)  -- Replace with your client-side event
    TriggerServerEvent('customgangs:server:onGangUpdate', gangData)  -- Forward to server
end)
```

### Customization Notes for `client.lua`
- **Event Name**: Replace `'customgangs:client:onGangChange'` with your system's client-side event for gang updates.
- **Gang Data**: Ensure `gangData` contains at least `name` (gang name) and a leader indicator (e.g., `is_leader`).
- **Optional**: Skip this file if your system handles updates server-side (e.g., via exports or direct DB changes).

## Step 4: Trigger Gang Updates
In your custom gang system, trigger the server event (`'customgangs:server:onGangUpdate'`) whenever a player's gang changes (e.g., join, leave, promote). Example:
```lua
-- In your gang system code
TriggerServerEvent('customgangs:server:onGangUpdate', source, { name = "gang_name", is_leader = true })
```

Alternatively, if your system uses exports, call `SyncGangs()` directly:
```lua
-- Example export usage
if exports['your_gang_system']:GetPlayerGang(source) then
    SyncGangs()
end
```

## Support
For additional help, join the [Wasabi Scripts Discord](https://discord.gg/wasabiscripts).