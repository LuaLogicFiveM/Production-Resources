shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '2.0.2'

client_scripts {
    'client/cl_utils.lua',
    'client/main.lua',
}

server_scripts {
    'server/logs.lua',
    'server/main.lua'
}

shared_scripts {
    '@grp_bridge/shared/init.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

files {
    'locales/*.json',
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/img/tick.png',
    'ui/img/cross.png'
}

ui_page 'ui/index.html'

escrow_ignore {
    'config.lua',
    'client/cl_utils.lua',
    'server/logs.lua',
}

dependencies {
    'grp_bridge',
    'ox_lib'
}

dependency '/assetpacks'
