shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.2.7'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

ox_libs {
    'math',
    'table',
}

client_scripts {
    'client.lua',
    'client/functions.lua'

}
server_scripts {
    'server.lua'
}

ui_page 'dist/index.html'

files {
    'dist/*',
    'dist/index.html',
    'dist/colors.css',
    'dist/styles.css',
    'dist/menu.css',
    'dist/*.js',
    'dist/img/*.*',
    'dist/weapons_img/*.*',
    'dist/libs/*.js',  
    'dist/libs/*.css',
    'dist/fonts/*.*',
    'dist/libs/webfonts/*.*'

}

dependency 'ox_lib'

escrow_ignore {
    'config.lua',
    'client/functions.lua'
}

dependency '/assetpacks'