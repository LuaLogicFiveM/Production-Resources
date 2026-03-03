shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'vames™'
description 'vms_stores'
version '1.1.2'
shared_scripts {
	'config/config.lua',
	'config/config.robbery.lua',
	'config/config.storemanage.lua',
	'config/config.translation.lua',
}
client_scripts {
	'client/lib.lua',
	'client/client.lua',
	'client/nui.lua',
	'client/order.lua',
	'client/moneyescort.lua',
	'client/cameras.lua',
	'client/robbery.lua',
	'config/config.client.lua',
	'config/config.camera.lua',
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
	'stream/vms_shoppingbasket.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'vms_shoppingbasket.ytyp'
escrow_ignore {
	'config/*.lua',
	'server/version_check.lua',
}
dependency '/assetpacks'
