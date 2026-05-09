shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
ui_page "ui/index.html"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "config/balance_config.lua",
    "config/sh_config.lua",
}
client_scripts {
    "client/**/*.lua",
}
server_scripts {
    "config/sv_config.lua",
    "server/**/*.lua",
}
files {
    "dui/*",
    "config/adminRings.json",
    "locales/*.json",
    "sounds/*.ogg",
    "ui/**/*",
}
escrow_ignore {
    "server/**/*.lua",
    "config/**/*.lua"
}
dependency '/assetpacks'
