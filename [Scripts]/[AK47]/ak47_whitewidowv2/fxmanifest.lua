shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version "2.9"

ui_page('html/ui.html')

files({
    'html/**/*',
})

shared_script '@es_extended/imports.lua' --Remove this line if you are using old ESX

client_scripts {
    "@ox_lib/init.lua",
    'config.lua',
    'config-shop.lua',
    'config-farming.lua',

    'client/utils.lua',
    'client/job.lua',
    'client/shop.lua',
    'client/farming.lua',
    'client/target.lua',

    'locales/locale.lua',
    'locales/en.lua',
}

server_scripts {
    "@ox_lib/init.lua",
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'config-shop.lua',
    'config-farming.lua',

    'server/utils.lua',
    'server/farming.lua',
    'server/shop.lua',
    'server/job.lua',

    'locales/locale.lua',
    'locales/en.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config*.lua',
    'server/utils.lua',
    'client/utils.lua',
}

lua54 'yes'

dependencies {
    'es_extended',
    'ox_lib',
}

dependency '/assetpacks'
