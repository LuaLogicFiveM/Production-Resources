shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
description 'Ak47 Bridge'
author 'MenanAk47'
version '1.0.2'

shared_scripts {
    "config.lua",
    "@ox_lib/init.lua",
}

client_scripts {
    "framework/**/client/*.lua",
    "integration/client/*.lua",

    "client/*.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    
    "framework/**/server/*.lua",
    "integration/server/*.lua",

    "server/*.lua",
}

escrow_ignore {
    "**/*",
}

lua54 'yes'

dependencies {
    'ox_lib',
}
