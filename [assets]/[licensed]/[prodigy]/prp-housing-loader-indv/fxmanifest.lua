shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
description "Prodigy Studios Housing Loader"
version "1.0.0"
shared_script "@ox_lib/init.lua"
client_scripts {
    "client/main.lua",
    "houses/*.lua",
}
escrow_ignore {
    "houses/*.lua",
    "client/main.lua"
}
dependency '/assetpacks'
