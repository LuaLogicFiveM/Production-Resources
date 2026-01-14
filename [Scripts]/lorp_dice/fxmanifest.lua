shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'
ui_page 'web/dice-ui.html'
files {
    'stream/*.ytyp',
    'web/dice-ui.html',
    'web/dice-ui.css',
    'web/dice-ui.js'
}
data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}
client_script 'client/client.lua'
server_script 'server/server.lua'
