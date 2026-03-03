shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games {"gta5"}
version '1.2'
lua54 'yes'
files {
    'web/build/index.html',
    'web/build/**/*',
}
ui_page 'web/build/index.html'
data_file 'DLC_ITYP_REQUEST' 'stream/ak47_idcardv2.ytyp'
shared_scripts {
	"@ox_lib/init.lua",
	"config.lua",
	"locales/locale.lua",
	"locales/en.lua",
}
client_scripts {
	"framework/client/*.lua",
	"client/*",
} 
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"framework/server/*.lua",
	"server/*",
} 
escrow_ignore {
	"framework/**/*",
	"INSTALL ME FIRST/**/*",
    "config.lua",
    "locales/*.lua",
    "client/utils.lua",
    "server/utils.lua",
    "stream/DarkAnimations/*",
}
dependency '/assetpacks'
