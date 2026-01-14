shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'

client_scripts {
	'client/client.lua',
	'client/functions.lua'
}
server_scripts {
   "server/server.lua",
   "server/functions.lua",
   "@oxmysql/lib/MySQL.lua"
}
shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}
files {
	"html/*.html",
	"html/*.js",
	"html/*.css",
    "html/*.png"
}
ui_page "html/index.html"
escrow_ignore {
	'config.lua',
	'server/functions.lua',
	'client/functions.lua',
	'MANIFESTS/*.lua'
}
  lua54 'yes'
dependency '/assetpacks'
