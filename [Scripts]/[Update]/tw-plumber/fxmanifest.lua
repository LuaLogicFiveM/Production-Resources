shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.07'
name 'tw-plumber'
author 'tworst-script for plumber job'
contact 'discord.gg/tworst'
website 'tworst.com'

shared_scripts {
	-- '@ox_lib/init.lua',
	'locales/*.lua',
	'config/*.lua',
}

-- shared_script '@vrp/lib/utils.lua'

client_scripts {
	'locales/*.lua',
	'client/*.lua',
	'client/interaction/textures.lua',
	'client/interaction/interacts.lua',
	'client/interaction/raycast.lua',
}
server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'mysql-async'.:warning:
	'@oxmysql/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'oxmysql'.:warning:
	'server/*.lua',
	'locales/*.lua',
}

ui_page "html/index.html"
files {
	'client/interaction/interactions.lua',
	'client/interaction/utils.lua',
	'client/interaction/entities.lua',
	"html/**/*.**",
	"html/*.**",
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'client/utility.lua',
	'client/interaction/*.lua',
	'server/utility.lua',
	'server/editable.lua',
	'server/aSQLInsert.lua',
}

lua54 'yes'
dependency '/assetpacks'
