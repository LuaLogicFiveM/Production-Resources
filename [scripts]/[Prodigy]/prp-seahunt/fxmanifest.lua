shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
}
client_scripts {
    "config/sh_config.lua",
    "client/*.lua",
}
server_scripts {
    "config/sh_config.lua",
    "config/sv_config.lua",
    "server/*.lua",
}
files {
    "locales/*.json",
}
escrow_ignore {
    "server/**/*.lua",
    "config/**/*.lua"
}
dependency '/assetpacks'
