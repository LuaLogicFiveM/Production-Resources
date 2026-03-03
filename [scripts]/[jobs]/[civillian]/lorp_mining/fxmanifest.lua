shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
lua54 'yes'
game 'gta5'

client_scripts {
    'config/client.lua',
    'bridge/client.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/shared.lua',
    'bridge/server.lua',
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/shared.lua',
    'config/icons.lua'
}

files {
    'locales/*.json',
    'install/images/*.png'
}


ox_libs {
    'locale',
    'math'
}
