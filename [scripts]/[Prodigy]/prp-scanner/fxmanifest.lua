shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
shared_script "@ox_lib/init.lua"
author "Prodigy Studios"
version "1.0.0"
files {
    "dui/dist/**/*",
}
client_scripts {
    "client.lua",
}
escrow_ignore {
    "server/**/*.lua",
    "config/**/*.lua",
    "shared/**/*.lua",
}
dependency '/assetpacks'
