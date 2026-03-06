fx_version "cerulean"
lua54 "yes"
game "gta5"

name "g-dutyV2"
version "1.3.0"
description "A Advanced duty system for FiveM"
author "G3DEV - justgroot"

shared_scripts{
	'src/shared/Config.lua',
	"locales/locale.lua",
	"locales/translations/*.lua",
	"src/utils/global.lua",
}

ui_page 'web/build/index.html'
files {
   'web/build/index.html',
   'web/build/**/*',
}

client_script{
	"src/utils/client.lua",
	"bridge/**/client.lua",
	"src/client/*.lua",
	"src/theme/theme.lua",
}
server_scripts{
	'src/shared/sv_config.lua',
	"@oxmysql/lib/MySQL.lua",
	"bridge/**/server.lua",
	'src/server/utils.lua',
	"src/server/*.lua",
}

escrow_ignore{
	"src/shared/*.lua",
	"src/client/cl_edit.lua",
	"src/server/sv_edit.lua",
	"bridge/**/server.lua",
	"bridge/**/client.lua",
	"src/theme/theme.lua",
	"locales/translations/*.lua",
}

dependency '/assetpacks'