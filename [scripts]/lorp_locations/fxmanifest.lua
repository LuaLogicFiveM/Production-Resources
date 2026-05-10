shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
shared_script '@ox_lib/init.lua'
client_scripts {
    'config.lua',
    'client.lua'
}
ui_page 'html/index.html'
files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
