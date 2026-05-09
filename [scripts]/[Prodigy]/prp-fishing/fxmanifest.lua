shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

game "gta5"
fx_version "cerulean"
author "Prodigy Studios"
version "1.0.0"
lua54 "yes"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "locales/locales.lua",
    "shared/**/*",
    "configs/**/*"
}
files {
    "locales/*.json",
}
client_scripts {
    "client/**/*",
    "open/client/**/*"
}
server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/**/*"
}
escrow_ignore {
    "server/**/*.lua",
    "configs/**/*.lua",
    "shared/**/*.lua",
    "open/client/**/*.lua"
}
dependency '/assetpacks'
