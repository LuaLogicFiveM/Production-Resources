local itemList = {}
local sortedList = {}

function AddItemToList(itemName, amount)
    if lib.table.contains(config.ignoreItems, itemName) then return end
    if type(amount) ~= "number" then amount = tonumber(amount) end
    if amount < 0 then return end
    if not itemList[itemName] then itemList[itemName] = 0 end
    itemList[itemName] = itemList[itemName] + amount
end

function ResetItemList()
    itemList = {}
end

function SortItemList()
    sortedList = {}
    for itemName, amount in pairs(itemList) do
        table.insert(sortedList, { name = itemName, amount = amount })
    end
    table.sort(sortedList, function(a, b)
        return a.amount > b.amount
    end)
end

function GetItemList()
    return sortedList
end
