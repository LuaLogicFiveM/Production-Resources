if not config.inventory.ox then return end

local tableName = config.framework == "qb" and "players" or "users"

local function startCollector()
    ResetItemList()

    local playerInv = MySQL.query.await('SELECT inventory FROM ' .. tableName)
    if playerInv then
        for i = 1, #playerInv do
            local inv = playerInv[i]
            if inv.inventory then
                inv.inventory = json.decode(inv.inventory)
                for _, data in pairs(inv.inventory) do
                    AddItemToList(data.name, data.count)
                end
            end
        end
    end

    local result = MySQL.query.await('SELECT data FROM ox_inventory')
    if result then
        for x = 1, #result do
            local inv = result[x]
            if inv.data then
                inv.data = json.decode(inv.data)
                for _, data in pairs(inv.data) do
                    AddItemToList(data.name, data.count)
                end
            end
        end
    end
    SortItemList()
end

function GetPlayerInventory(citizenid)
    local columnName = config.framework == "qb" and "citizenid" or "identifier"
    local result = MySQL.single.await('SELECT inventory FROM ' .. tableName .. ' WHERE ' .. columnName .. ' = ?', { citizenid })
    return result?.inventory and json.decode(result.inventory) or {}
end

startCollector()
lib.cron.new(config.cron.collectItems, startCollector)
