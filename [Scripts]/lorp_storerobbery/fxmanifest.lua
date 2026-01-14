shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.2'

files {
    'locales/*.json',
    "client/peds.lua",
    "client/tills.lua",
    "client/safe.lua",
    "client/network.lua"
}

shared_scripts {
    '@ox_lib/init.lua',
	"config/config.lua",
    "shared/*.lua",
    "bridge/framework.lua"
}

client_scripts {
    "bridge/client/*.lua",
    "client/main.lua"
}

server_scripts {
    "config/sv-config.lua",
    "bridge/server/*.lua",
    "server/main.lua"
}

use_experimental_fxv2_oal 'yes'
