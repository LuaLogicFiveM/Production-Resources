if not config.inventory.ox then return end

local tableName = config.framework == "qb" and "players" or "users"

local function startCollector()
    ResetItemList()

    local playerInv = MySQL.query.await('SELECT inventory FROM ' .. tableName)
    if playerInv then
        for i = 1, #playerInv do
            local playerInventory = playerInv[i]
            if playerInventory.inventory then
                playerInventory.inventory = json.decode(playerInventory.inventory)
                for _, data in pairs(playerInventory.inventory) do
                    AddItemToList(data.name, data.count)
                end
            end
        end
    end

    local result = MySQL.query.await('SELECT data FROM ox_inventory')
    if result then
        for x = 1, #result do
            local resultData = result[x]
            if resultData.data then
                resultData.data = json.decode(resultData.data)
                for _, data in pairs(resultData.data) do
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
