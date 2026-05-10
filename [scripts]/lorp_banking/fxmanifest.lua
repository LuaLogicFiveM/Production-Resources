shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'client.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
ui_page 'nui/index.html'
files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
    'nui/assets/**/*'
}
dependencies {
    'oxmysql'
}
lua54 'yes'
