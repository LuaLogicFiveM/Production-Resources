shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version '1.2'

ui_page 'web/index.html'

shared_scripts { 
    'shared/config.lua',
    'shared/functions.lua',
    'shared/locales/*.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    'web/index.html',
    'web/main.js',
    'web/vue/*.js',
    'web/style.css',
    'web/fonts/*.*',
    'web/sounds/*.*',
    'web/images/*.*',
}

escrow_ignore {
    'shared/locales/*.lua',
    'shared/config.lua',
    'shared/functions.lua',
    'web/index.html',
    'web/main.js',
    'web/vue/*.js',
    'web/style.css',
    'web/sounds/*.*',
    'web/fonts/*.*',
    'web/images/*.*',
}

lua54 'yes'
dependency '/assetpacks'
