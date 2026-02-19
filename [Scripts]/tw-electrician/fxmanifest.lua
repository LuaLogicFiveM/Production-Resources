fx_version 'cerulean'
game 'gta5'
version '2.04'
name 'tw-electrician-remake'

shared_scripts {
	'locales/*.lua',
	'config/*.lua',
}

-- shared_script '@vrp/lib/utils.lua'

client_scripts {
	'locales/*.lua',
	'client/*.lua',
}
server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'mysql-async'.:warning:
	'@oxmysql/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'oxmysql'.:warning:
	'server/aSQLInsert.lua',
	'server/*.lua',
	'locales/*.lua',
}

ui_page "html/index.html"
files {
	'html/js/*.js',
	"html/**/*.**",
	"html/*.**",
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'client/utility.lua',
	'client/editable.lua',
	'server/utility.lua',
	'server/editable.lua',
	'server/aSQLInsert.lua',
}

lua54 'yes'

dependency '/assetpacks'