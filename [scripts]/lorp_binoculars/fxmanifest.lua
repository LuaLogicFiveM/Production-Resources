shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
lua54 'yes'
game "gta5"

dependencies {
    'ox_lib',
    '/assetpacks',
}

shared_scripts {
    '@ox_lib/init.lua',
    "config.lua",
}

server_scripts {
    "server/events.lua",
    "server/functions.lua",
    "server/main.lua",
    "server/custom/*.lua",
}

client_scripts {
    "client/utils.lua",
    "client/events.lua",
    "client/functions.lua",
    "client/main.lua",
}

files {
    "locales/*.json",
}
