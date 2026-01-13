shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'

shared_scripts {'@ox_lib/init.lua', 'config.lua'}
client_scripts {'client/main.lua'}
server_scripts {'server/main.lua'}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/ui.js',
    'html/ui.css',
    'locales/*.json'
}

dependencies {
    'ox_lib'
}

escrow_ignore {
    'config.lua',
    'locales/*.json'
}
dependency '/assetpacks'
