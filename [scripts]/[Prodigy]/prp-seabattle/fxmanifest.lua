shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
files {
    "locales/*.json",
}
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "config.lua",
}
server_scripts {
    "server/class.lua",
    "server/server.lua",
}
client_scripts {
    "client/*.lua"
}
escrow_ignore {
    "server/**/*.lua",
    "config.lua",
}
dependency '/assetpacks'
