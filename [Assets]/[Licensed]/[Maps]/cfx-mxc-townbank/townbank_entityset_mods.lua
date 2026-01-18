local interiors = {
    ["mxc_townbank_grapeseed"] = {
        coords = vec3(1686.8669, 4856.0537, 42.1921),
        sets = {
            ["broken-style"] = true,
            ["new-style"] = false,
            ["messy-style"] = false,
            ["broken-barrier"] = false,
            ["fixed-barrier"] = true,
        }
    },
    ["mxc_townbank_sandy"] = {
        coords = vec3(1702.7161, 3782.8979, 34.854),
        sets = {
            ["broken-style"] = true,
            ["new-style"] = false,
            ["messy-style"] = true,
            ["broken-barrier"] = true,
            ["fixed-barrier"] = false,
        }
    },
    ["mxc_townbank_palomino"] = {
        coords = vec3(2557.1492, 407.7162, 108.57),
        sets = {
            ["broken-style"] = false,
            ["new-style"] = true,
            ["messy-style"] = false,
            ["broken-barrier"] = false,
            ["fixed-barrier"] = true,
        }
    },
    ["mxc_townbank_chumash"] = {
        coords = vec3(-3148.1426, 1132.3232, 20.842),
        sets = {
            ["broken-style"] = false,
            ["new-style"] = true,
            ["messy-style"] = true,
            ["broken-barrier"] = true,
            ["fixed-barrier"] = false,
        }
    },
    ["mxc_townbank_route68"] = {
        coords = vec3(576.7659, 2676.7080, 41.972),
        sets = {
            ["broken-style"] = true,
            ["new-style"] = false,
            ["messy-style"] = true,
            ["broken-barrier"] = true,
            ["fixed-barrier"] = false,
        }
    },
}


for name, v in pairs(interiors) do
    RequestIpl(name)
    local interior = GetInteriorAtCoordsWithType(v.coords, "mxc_ltownbank_col")

    if IsValidInterior(interior) then
        for name, enable in pairs(v.sets) do
            if enable then
                ActivateInteriorEntitySet(interior, name)
            else
                DeactivateInteriorEntitySet(interior, name)
            end
        end

        RefreshInterior(interior)
    end
end
