shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

---@diagnostic disable: undefined-global
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'r_blackmarket'
author 'r_scripts'
version '2.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'core/shared/*.lua',
    'locales/*.lua',
    'config.lua',
}

server_scripts {
    'core/server/*.lua',
}

client_scripts {
    'core/client/*.lua',
}

ui_page 'web/dist/index.html'
files {
    'web/dist/index.html',
    'web/dist/**/*',
}

escrow_ignore {
    'core/client/dispatch.lua',
    'core/server/logging.lua',
    'install/**/*.*',
    'locales/*.*',
    'config.lua'    
}
dependency '/assetpacks'
