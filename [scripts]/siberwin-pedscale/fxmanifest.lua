shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
name "SiberWin - Ped Scale"
version "1.0.3"
description "store.siberwin.com"
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
ui_page 'build/index.html'
files {
    'build/index.html',
    'build/assets/*.js',
    'build/assets/*.css',
}
client_scripts {
    'locales/*.lua',
    'client/*.lua'
}
server_scripts {
    'server/*.lua',
}
escrow_ignore {
    'config.lua',
	'server/sv_database.lua',
	'server/sv_permissions.lua',
    'client/client.lua',
    'client/framework.lua',
    'client/weapon.lua',
    'locales/*.lua'
}
dependencies {
    'oxmysql',
    'ox_lib'
}
lua54 'yes'
use_experimental_fxv2_oal 'yes'
dependency '/assetpacks'
