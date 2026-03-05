


------------------------------ BUILDING IPL CONFIG ------------------------------


local interiors = {
    {
        ipl = 'apollo_mc_cypressgarage_milo_',
        coords = { x = 1023.42438, y = -2535.189, z = 31.786972 },
        entitySets = {
            { name = 'church_chairs', enable = true },
        }
    },
    
}

---------------------------------------------------------------------------------------

CreateThread(function()
    for _, interior in ipairs(interiors) do
        if not interior.ipl or not interior.coords or not interior.entitySets then
            print('^5[maps]^7 ^1Error while loading interior.^7')
            return
        end
        RequestIpl(interior.ipl)
        local interiorID = GetInteriorAtCoords(interior.coords.x, interior.coords.y, interior.coords.z)
        if IsValidInterior(interiorID) then
            for __, entitySet in ipairs(interior.entitySets) do
                if entitySet.enable then
                    EnableInteriorProp(interiorID, entitySet.name)
                    if entitySet.color then
                        SetInteriorPropColor(interiorID, entitySet.name, entitySet.color)
                    end
                else
                    DisableInteriorProp(interiorID, entitySet.name)
                end
            end
            RefreshInterior(interiorID)
        end
        if interior.exterior_ipl ~= nil then
            for __, ext_ipl in ipairs(interior.exterior_ipl) do
                RequestIpl(ext_ipl)
            end
        end
    end
end)