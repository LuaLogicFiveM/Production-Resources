shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'

version '1.1.1'

lua54 'yes'

client_scripts {
    'config.lua',
    'client/*.lua',
    'shared/sessionmanager.lua',
    'object.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/*.lua',
    'shared/sessionmanager.lua',
    'server/framework/*',
    'server/db/*',
    'object.lua',
}


dependencies {
    '/server:4752',
    '/onesync'
}

ui_page 'assets/index.html'

files {
    'assets/index.html',
    'assets/*.png',
    'assets/*.ogg',
    'assets/assets/img/*.png',
    'assets/assets/js/app.js',
    'assets/assets/js/chunk-vendors.js',
    'assets/assets/css/app.css',
}

escrow_ignore {
    'config.lua',
    'object.lua',

    'server/framework/esx.lua',
    'server/framework/qbcore.lua',
    'server/framework/custom.lua',
    
    'server/db/bridge.lua',
    'server/db/db.lua',

    'server/placeable.lua',
    'server/server.lua',
    'server/admintool.lua',

    'client/blip.lua',
    'client/admintool.lua',
    'client/3point_render.lua',
    'client/client.lua',
    'client/client_free.lua',
    'client/client_play.lua',
    'client/client_registration.lua',
    'client/client_setup.lua',
    'client/control.lua',
    'client/hoop_render.lua',
    'client/instructional.lua',
    'client/placeable.lua',
    'client/qtarget.lua',
    'client/rpg.lua',
    'client/sound.lua',
    'client/ui.lua',
}

dependency '/assetpacks'
