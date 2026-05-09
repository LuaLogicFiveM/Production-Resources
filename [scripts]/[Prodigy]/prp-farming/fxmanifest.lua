shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
lua54 "yes"
author "Prodigy Studios"
description "Farming"
version "1.0.2"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "shared/shared.lua",
    "shared/config.lua",
    "shared/config_spots.lua",
    "shared/config_openworld.lua"
}
escrow_ignore {
    "client/editable.lua",
    "server/editable.lua",
    "server/config.lua",
    "server/shop.lua",
    "shared/*.lua"
}
client_scripts {
    "client/editable.lua",
    "client/blips.lua",
    -- "client/activities/orchardActivities.lua",
    "client/activities/animalActivities.lua",
    -- "client/activities/fieldActivities.lua",
    "client/activities/farmActivities.lua",
    "client/main.lua",
    "client/openworld.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/config.lua",
    "server/editable.lua",
    "server/openworld.lua",
    "server/jobClass.lua",
    -- "server/activities/orchardActivities.lua",
    "server/activities/animalActivities.lua",
    -- "server/activities/fieldActivities.lua",
    "server/activities/farmActivities.lua",
    "server/shop.lua",
    "server/main.lua"
}
files {
    "locales/*.json"
}
dependency '/assetpacks'
