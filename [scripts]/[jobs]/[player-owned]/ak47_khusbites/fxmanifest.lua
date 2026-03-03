shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version "1.5"

ui_page('html/ui.html')

files({
    'html/**/*',
    'stream/*.ydr',
})

data_file 'DLC_ITYP_REQUEST' 'stream/khusbites_props.ytyp'

shared_scripts {
    "@es_extended/imports.lua",
    "@ox_lib/init.lua",
    'config.lua',
    'config-shop.lua',
    'config-farming.lua',

    'locales/locale.lua',
    'locales/en.lua',
} 

client_scripts {
    'client/utils.lua',
    'client/shop.lua',
    'client/farming.lua',
    'client/hookah.lua',
    'client/target.lua',
    'client/edibles.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',

    'server/utils.lua',
    'server/farming.lua',
    'server/shop.lua',
    'server/job.lua',
    'server/hookah.lua',
    'server/edibles.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config*.lua',
    'server/utils.lua',
    'client/utils.lua',
    'client/target.lua',
    'stream/bzzz_camp_food_kebab.ydr',
    'INSTALL ME FIRST/**/*',
}

lua54 'yes'

dependencies {
    'ox_lib',
    'es_extended'
}
dependency '/assetpacks'
