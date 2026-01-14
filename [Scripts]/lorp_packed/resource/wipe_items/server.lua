--local ox_inventory = exports.ox_inventory
local items = {
    ['black_money'] = true,
    ['money'] = true,
    ['casino_chips'] = true,
}

--[[RegisterNetEvent('esx:playerLoaded', function(player, xPlayer, isNew)
    local identifier = xPlayer.identifier
    local response = MySQL.rawExecute.await('SELECT `wiped` FROM `users` WHERE `identifier` = ?', { identifier })

    if response[1].wiped == 'true' then
        return print('[Wipe System] - '..GetPlayerName(player)..'\'s ('..identifier..') is already wiped.')
    end

    local money = ox_inventory:GetItemCount(player, 'money')

    if money > 0 then
        ox_inventory:RemoveItem(player, 'money', money)
    end

    local black_money = ox_inventory:GetItemCount(player, 'money')

    if black_money > 0 then
        ox_inventory:RemoveItem(player, 'black_money', black_money)
    end

    xPlayer.setAccountMoney('bank', 25000)

    MySQL.update('UPDATE users SET wiped = ? WHERE identifier = ?', {
        'true', identifier
    }, function(affectedRows)
        print('[Wipe System] - '..GetPlayerName(player)..'\'s ('..identifier..') bank has been wiped.')
    end)
end)]]

local function ClearStorages()
    local result = MySQL.Sync.fetchAll("SELECT owner, name, data FROM ox_inventory", {})

    for _, user in ipairs(result) do
        local identifier = user.owner
        if identifier then
            local name = user.name
            local inventory = json.decode(user.data) or {}
            local inventoryChanged = false

            for _, item in pairs(inventory) do
                if items[item.name] then
                    print(_, item.name)
                    table.remove(inventory, _)
                    inventoryChanged = true
                end
            end

            if inventoryChanged then
                MySQL.update('UPDATE ox_inventory SET data = ? WHERE owner = ? AND name = ?', {json.encode(inventory), identifier, name}, function(affectedRows)
                    --print(affectedRows)
                end)
            end
        end
    end

    print('[Wipe System] - [SUCCESS] - Removed item(s) from all storages.')
end

RegisterCommand('clearstorages', function(source)
    if source ~= 0 then return end
    ClearStorages()
end, true)