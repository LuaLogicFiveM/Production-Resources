lib.addCommand('postal', {
    help = 'Set a waypoint to a requested postal',
    params = {{ name = "postal", type = "number", help = 'Postal Code' }},
    restricted = false
}, function(source, args, raw)
    local postal = args.postal
    if postal then
        TriggerClientEvent("lorp_postals:client:requestWaypoint", source, postal)
    end
end)