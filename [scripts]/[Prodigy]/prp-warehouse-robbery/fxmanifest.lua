shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
client_scripts {
    "client/**/*"
}
server_scripts {
    "configs/**/*",
    "server/**/*"
}
files {
    "locales/*.json"
}
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "configs/main.lua",
    "utils/**/*",
    "init.lua"
}
escrow_ignore {
    "configs/**/*",
    "server/**/*"
}
dependency '/assetpacks'
