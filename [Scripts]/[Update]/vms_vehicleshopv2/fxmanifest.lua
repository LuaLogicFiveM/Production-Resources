shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'vames™'
description 'vms_vehicleshopv2'
version '1.0.8'
shared_scripts {
	'config/config.lua',
	'config/config.management.lua',
	'config/config.showroom.lua',
	'config/config.translation.lua',
}
client_scripts {
	'client/lib.lua',
	'client/client.lua',
	'client/order.lua',
	'client/showroom.lua',
	'client/photos_tool.lua',
	'client/nui.lua',
	'config/config.client.lua',
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/config.server.lua',
	'server/*.lua',
}
ui_page 'html/ui.html'
files {
	'html/*.*',
	'html/**/*.*',
	'config/*.js',
	'config/translation.json',
}
escrow_ignore {
	'config/*.lua',
	'stream/*.*',
	'server/version_check.lua',
}
dependency '/assetpacks'
