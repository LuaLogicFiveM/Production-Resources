shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "g-bridge"
author 'G3DEV - justgroot'
description 'Groot Development Fivem scripts Bridge'
version '1.0.0'

shared_scripts {
    'logger.lua',
    'shared.lua',
    'init.lua'
}

client_scripts {
    'src/client/*.lua',
    'src/callback/client.lua',
    'src/frameworks/**/client.lua',
    'src/inventories/**/client.lua',
    'src/target/init.lua',
    'src/target/ox_target.lua',
    'src/target/qb-target.lua',
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    'src/callback/server.lua',
    'src/frameworks/**/server.lua',
    'src/inventories/**/server.lua',
    'src/server/*.lua',
}


escrow_ignore {
    "shared.lua",
    "src/client/*.lua",
    "src/frameworks/**/*.lua",
    "src/inventories/**/*.lua",
    "src/target/ox_target.lua",
    "src/target/qb-target.lua",
}
dependency '/assetpacks'
