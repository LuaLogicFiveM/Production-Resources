RegisterServerEvent('prp-aerialrun:doorSync:open', function(vNet, door, loose, instant)
    TriggerClientEvent('prp-aerialrun:doorSync:open', -1, vNet, door, loose, instant)
end)

RegisterServerEvent('prp-aerialrun:doorSync:shut', function(vNet, door, instant)
    TriggerClientEvent('prp-aerialrun:doorSync:shut', -1, vNet, door, instant)
end)
