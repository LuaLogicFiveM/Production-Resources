if not config.inventory.tgiann then return end

local function startCollector()
    ResetItemList()

    local playerInv = MySQL.query.await('SELECT inventory FROM tgiann_inventory_player')
    if playerInv then
        for i = 1, #playerInv do
            playerInv[i].inventory = json.decode(playerInv[i].inventory)
            for _, data in pairs(playerInv[i].inventory) do
                AddItemToList(data.name, data.amount)
            end
        end
    end

    local invTableList = lib.array:new("tgiann_inventory_stashitems", "tgiann_inventory_gloveboxitems", "tgiann_inventory_trunkitems")
    for i = 1, #invTableList do
        local invTable = invTableList[i]
        local result = MySQL.query.await('SELECT items FROM ' .. invTable)
        if result then
            for x = 1, #result do
                result[x].items = json.decode(result[x].items)
                for _, data in pairs(result[x].items) do
                    AddItemToList(data.name, data.amount)
                end
            end
        end
    end

    SortItemList()
end

function GetPlayerInventory(citizenid)
    local result = MySQL.single.await('SELECT inventory FROM tgiann_inventory_player WHERE citizenid = ?', { citizenid })
    return result?.inventory and json.decode(result.inventory) or {}
end

startCollector()
lib.cron.new(config.cron.collectItems, startCollector)
