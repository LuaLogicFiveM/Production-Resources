shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version "2.4"

ui_page('html/index.html')

files({
    'html/index.html',
    'html/*.js',
    'html/sounds/*.mp3',
})

shared_script '@es_extended/imports.lua'

client_scripts {
    'config.lua',
    'client/utils.lua',
    'client/usable.lua',
    'client/vape.lua',

    'locales/locale.lua',
    'locales/en.lua',
}

server_scripts {
    'config.lua',
    'server/utils.lua',
    'server/usable.lua',

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
    '/server:5181', -- requires at least server build 5181
}

dependency '/assetpacks'
