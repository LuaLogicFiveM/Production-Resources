shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

ui_page "nui/index.html"

lua54 'yes'

client_scripts {
	"functions/client/*.lua",
	"custom_scripts/client/*.lua",
	"frameworks/qbcore/client.lua",
	"frameworks/esx/client.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"functions/server/*.lua",
	"custom_scripts/server/*.lua",
	"frameworks/qbcore/server.lua",
	"frameworks/esx/server.lua",
}

shared_scripts {
	"config.lua",
	"functions/shared.lua",
	"lang/*.lua"
}

files {
	"version",
	"functions/loader.lua",
	"nui/index.html",
	"nui/index.js",
	"nui/js/*",
	"nui/css/*"
}
