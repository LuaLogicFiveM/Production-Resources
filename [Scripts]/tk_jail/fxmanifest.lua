shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'TuKeh_'
description 'Prison System'
version '1.4.3'
lua54 'yes'
ui_page 'web/build/index.html'
files {
    'web/build/index.html',
    'web/build/**/*',
}
shared_scripts {
    '@ox_lib/init.lua',
	'config.lua',
    'shared/*.lua',
	'locales/*.lua',
}
client_scripts {
    'client/frameworks/*.lua',
    'client/main_editable.lua',
    'client/main.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/frameworks/*.lua',
    'server/main_editable.lua',
    'server/main.lua',
}
escrow_ignore {
    'locales/*.lua',
    'config.lua',
    'client/frameworks/*.lua',
    'server/frameworks/*.lua',
    'client/main_editable.lua',
    'server/main_editable.lua',
}
dependency '/assetpacks'
