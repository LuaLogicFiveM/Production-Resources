shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'vivum-billing'
version '2.0.2'

server_script '@oxmysql/lib/MySQL.lua'
server_scripts {
	'config.lua',
	'lib/shared/main.lua',
	'lib/shared/framework.lua',
	'server/callbacks.lua',
	'server/functions.lua',
	'server/queries.lua',
	'server/databaseChecker.lua',
	'server/frameworks/**.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/functions.lua',
	'client/callbacks.lua',
	'client/main.lua'
}

files {
	'locales/**/*',
	'dist/index.html',
	'dist/**/*.js',
	'dist/**/*.css',
	'dist/**/*.png',
}

escrow_ignore {
	'config.lua',
	'client/functions.lua',
	'server/functions.lua',
	'server/databaseChecker.lua',
	'server/queries.lua',
	'server/frameworks/*.lua',
	'server/frameworks/company-money/*.lua'
}

ui_page 'dist/index.html'
dependency '/assetpacks'
