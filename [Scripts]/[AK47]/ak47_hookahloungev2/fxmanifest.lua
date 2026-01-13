shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version "2.3"

ui_page('html/index.html')

files({
    'html/**/*'
})

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
    'config-bar.lua',
    'locales/locale.lua',
    'locales/en.lua',
}

client_scripts {
    'client/utils.lua',
    'client/job.lua',
    'client/heater.lua',
    'client/main.lua',
    'client/bar.lua',
    'client/target.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/utils.lua',
    'server/job.lua',
    'server/heater.lua',
    'server/main.lua',
    'server/bar.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config*.lua',
    'server/utils.lua',
    'client/utils.lua',
}

lua54 'yes'

dependencies {
    '/server:5181', -- requires at least server build 5181
}

dependency '/assetpacks'
