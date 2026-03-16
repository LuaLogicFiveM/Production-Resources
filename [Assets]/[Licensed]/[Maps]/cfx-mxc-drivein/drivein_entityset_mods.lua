local interiors = {

    ["mxc_drivein-lossantos"] = {
        coords = vec3(-344.8136, -1463.35327, 26.8373127),
        sets = {
            ["kitchen_on"] = false,
            ["kitchen_off"] = true,
            ["foodsdecoration"] = true,
        }
    },
    ["mxc_drivein-paletobay"] = {
        coords = vec3(73.43056, 6517.916, 38.2475777),
        sets = {
            ["kitchen_on"] = false,
            ["kitchen_off"] = true,
            ["foodsdecoration"] = true,
        }
    },
}


for name, v in pairs(interiors) do
    RequestIpl(name)
    local interior = GetInteriorAtCoords(v.coords)
 print(name, interior)
    if IsValidInterior(interior) then
        print(name, "valid")
        for name2, enable in pairs(v.sets) do
            print(name, name2, enable)
            if enable then
                ActivateInteriorEntitySet(interior, name2)
            else
                DeactivateInteriorEntitySet(interior, name2)
            end
        end

        RefreshInterior(interior)
    end
end