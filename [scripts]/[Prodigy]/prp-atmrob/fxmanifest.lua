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
    '@ox_lib/init.lua',
    '@prp-bridge/import.lua',
    'config/sh_*.lua',
    'init.lua'
}
client_scripts {
    'client/*.lua',
    'config/cl_*.lua',
}
server_scripts {
    'server/*.lua',
    'config/sv_*.lua',
}
escrow_ignore {
    "server/**/*.lua",
    "config/**/*.lua",
    "init.lua"
}
files {
    "locales/*.json"
}
dependency '/assetpacks'
