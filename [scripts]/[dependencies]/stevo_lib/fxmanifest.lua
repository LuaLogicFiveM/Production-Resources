shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
version '1.7.6'
shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'modules/init/client.lua',
    'modules/functions/client.lua',
    'customize.lua'
}
server_scripts {
    'modules/init/server.lua',
    'modules/functions/server.lua',
    '@oxmysql/lib/MySQL.lua'
}
files {
    'bridge/**/**/*.lua'
}
