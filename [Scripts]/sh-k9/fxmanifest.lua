shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '7.2'

shared_scripts {
    '@ox_lib/init.lua',

    -- '@qbx_core/modules/lib.lua', -- enable this line if you using QBOX Framework 
    -- '@qbx_core/modules/playerdata.lua', -- enable this line if you using QBOX Framework 

    'shared/shared.lua',
}

server_scripts { 
    '@oxmysql/lib/MySQL.lua', -- remove this line if you not using oxmysql

    'bridge/server/framework/**.lua',
    'bridge/server/inventory/**.lua',
    'bridge/server/utils.lua',

    'server/server.lua',
}

client_scripts {
    'client/utility.lua',

    'bridge/client/framework/**.lua',
    'bridge/client/utils.lua',

    'client/scaleforms.lua',
    'client/client.lua',
    'client/shop.lua',
    'client/target.lua',
    'client/camera.lua',
    
    'client/menu.lua',
}

ui_page 'html/index.html'

files { 
    'database.json',
    'locales/*.lua',
    
    'html/index.html', 
    'html/config.js',
    'html/script.js',
    'html/styles.css',

    'config/**.lua',
}

escrow_ignore {
    'config/**.lua',
    'bridge/**.lua',
    'locales/**.lua'
}

dependency '/assetpacks'
