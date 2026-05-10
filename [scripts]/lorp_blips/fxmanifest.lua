shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
ui_page 'ui/index.html'
files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
}
client_scripts {
    'client/cl_main.lua',
}
