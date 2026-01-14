shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '2.0.0'
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/framework.lua'
}
client_scripts {
    'client/main.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
ui_page 'web/index.html'
files {
    'web/index.html',
    'web/style.css',
    'web/script.js',
    'web/assets/**/*'
}
