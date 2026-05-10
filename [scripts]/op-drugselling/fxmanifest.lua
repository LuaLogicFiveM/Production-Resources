shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"

version '1.0.4'
lua54 'yes'
game 'gta5'

ui_page 'web/build/index.html'

shared_scripts {
	'@ox_lib/init.lua',
	'framework/shared.lua',
	'config/MainConfig.lua',
	'locales/*.lua',
}

client_scripts {
	'config/MainConfig.lua',
	'framework/client/shared.lua',
	'framework/client/esx.lua',
	'framework/client/qb.lua',
	'framework/client/qbox.lua',
	'integrations/client/**',
	'client/**',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/ServerConfig.lua',
	'framework/server/esx.lua',
	'framework/server/qb.lua',
	'framework/server/qbox.lua',
	'server/**',
}

files {
	'web/build/**/*',
}

escrow_ignore {
	'client/**',
	'config/**',
	'locales/**',
	'framework/**',
	'server/**',
	'integrations/**'
}
