return {
    distance = 50,  -- Distance at which repair benches become visible
    blacklisted = {  -- Weapons that are not eligible for repair, has to be all uppercase
        ['WEAPON_PEPPERSPRAY'] = true,
        ['WEAPON_ANTIDOTE'] = true,
        ['WEAPON_SPRAYGUN'] = true,
        ['WEAPON_SCREWDRIVER'] = true,
        ['WEAPON_BATON'] = true,
        ['WEAPON_FLASHBANG'] = true,
        ['WEAPON_TRIDAGGER'] = true,
        ['WEAPON_RUSTYSHANK'] = true,
        ['WEAPON_KM2000'] = true,
        ['WEAPON_KITCHENKNIFE'] = true,
        ['WEAPON_FURYNAILBAT'] = true,
        ['WEAPON_GAS'] = true,
        ['WEAPON_FLASHLIGHT'] = true,
        ['WEAPON_FIREEXTINGUISHER'] = true,
        ['WEAPON_FISH'] = true,
        ['WEAPON_GLIZZY'] = true,
        ['WEAPON_PETROLCAN'] = true,
    },
    locations = {
        {
            blip = { enabled = true, label = "Weapon Repair Bench", color = 1, scale = 0.7, sprite = 110 },
            bench = { model = "gr_prop_gr_bench_01a", coords = vector4(684.332, -716.611, 25.023, 182.9237) },
            required = {{ count = 25, item = "scrap_metal" }, { count = 10000, item = "money" }}
        },
        {
            blip = { enabled = true, label = "Weapon Repair Bench", color = 1, scale = 0.7, sprite = 110 },
            bench = { model = "gr_prop_gr_bench_02b", coords = vector4(569.129, 2800.021, 41.018, 278.0) },
            required = {{ count = 25, item = "scrap_metal" }, { count = 10000, item = "money" }}
        },
        {
            blip = { enabled = true, label = "Weapon Repair Bench", color = 1, scale = 0.7, sprite = 110 },
            bench = { model = "gr_prop_gr_bench_01b", coords = vector4(93.4820, 6334.9272, 31.3758, 120.0) },
            required = {{ count = 25, item = "scrap_metal" }, { count = 10000, item = "money" }}
        }
    }
}