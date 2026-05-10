shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.1.0'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
ox_lib 'locale'
shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
    'init.lua',
}
server_scripts { 
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}
client_scripts { 
    'client/*.lua'
}
ui_page 'web/dist/index.html'
files {
    'config/*.lua',
    'locales/*.json',
    'modules/**/**.lua',
    'web/dist/index.html',
	'web/dist/**/*',
}
