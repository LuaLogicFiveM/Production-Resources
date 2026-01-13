config = {}

config.Debug = false


config.Framework = "auto"
config.Dispatch = "cd_dispatch"
config.Target = "ox_target"       -- auto | ox_target | qb-target
config.TextUI = "ox_lib"       -- auto | ox_lib | jg-textui | okokTextUI | cd_drawtextui | lation_ui
config.ProgressBar = "ox_lib"    -- auto | ox_lib | lation_ui | progressbar
config.Banking = "auto"      -- auto | qb-banking | okokBanking | fd_banking | renewed-banking | tgg-banking | kartik-banking | tgiann-bank | wasabi_banking | qb-management | qbx_management | esx_society | qs-banking
config.Inventory = "ox_inventory"     -- auto | qb-inventory | ox_inventory | codem-inventory | origen_inventory | qs-inventory | tgiann-inventory | jpr-inventory | ps-inventory | core_inventory
config.Fuel = "lc_fuel"          -- auto | ox_fuel | qb-fuel | ps-fuel | qs-fuelstations | legacyfuel | renewed-fuel | ti_fuel | lc_fuel | x-fuel | cdn-fuel | esx-sna-fuel | bigdaddy-fuel | okokgasstation
config.VehicleKeys = "wasabi_carlock"   -- auto | qb-vehiclekeys | qbx_vehiclekeys | qs-vehiclekeys | Renewed-Vehiclekeys | wasabi_carlock | okokGarage | cd_garage | mk_vehiclekeys | mono_carkeys | MrNewbVehicleKeys | mVehicle | t1ger_keys | F_RealCarKeysSystem | jacksam

config.AdminGroups = {
    ["owner"] = true,
    ["manager"] = true,
}
