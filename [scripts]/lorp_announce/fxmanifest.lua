shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
client_script 'client/*.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Server/*.lua'
}
shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}
ui_page 'web/index.html'
files {
    'web/*.*',
    'web/sound.mp3'
}
escrow_ignore {
    'config.lua',
}
