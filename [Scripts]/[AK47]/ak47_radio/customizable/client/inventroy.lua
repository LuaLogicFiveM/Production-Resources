--[[RegisterNetEvent('ak47_inventory:onRemoveItem', function(item, amount, slot, has)
    if item == 'radio' and has <= 0 then
        RemovePlayerFromRadio()
    end
end)

RegisterNetEvent('esx:removeInventoryItem', function(item, count)
    Wait(1000)
    if item == 'radio' and count <= 0 then
        RemovePlayerFromRadio()
    end
end)]]

exports('removePlayerFromRadio', function()
    RemovePlayerFromRadio()
end)