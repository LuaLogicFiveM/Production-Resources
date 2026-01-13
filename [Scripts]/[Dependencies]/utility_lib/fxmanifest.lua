shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'

repository 'https://github.com/utility-library/utility_lib'
game 'gta5'

lua54 "yes"

client_scripts {
    "config.lua",
    'client/native.lua',
    'client/functions/*.lua',
    'client/main.lua',
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    
    "config.lua",
    "server/native.lua",
    'server/functions/*.lua',
    "server/main.lua",
    "version_checker.lua"
}

files {
    "client/native_min.lua"
}
