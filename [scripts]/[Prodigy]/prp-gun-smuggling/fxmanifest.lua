shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
lua54 "yes"
author "Prodigy Studios"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "init.lua"
}
client_scripts {
    "client/**/*"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config.lua",
    "server/**/*",
}
escrow_ignore {
    "server/**/*",
    "init.lua",
    "config.lua"
}
files {
    "locales/*.json",
}
dependency '/assetpacks'
