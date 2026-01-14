shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '2.02'

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
