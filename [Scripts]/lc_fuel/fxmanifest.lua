shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

ui_page "nui/ui.html"

lua54 'yes'

escrow_ignore {
	'**'
}

client_scripts {
	"client/client.lua",
	"client/client_gas.lua",
	"client/client_electric.lua",
	"client/client_refuel.lua",
	"client/client_fuel_chart.lua",
	"client/client_fuel_type.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server/server.lua",
}

shared_scripts {
	"lang/*.lua",
	"config.lua",
	"@lc_utils/functions/loader.lua",
}

files {
	"version",
	"nui/lang/*",
	"nui/ui.html",
	"nui/panel.js",
	"nui/scripts/*",
	"nui/css/*",
	"nui/images/*",
	"nui/fonts/Technology.woff",
}

dependency "lc_utils"
provides 'LegacyFuel'

data_file 'DLC_ITYP_REQUEST' 'stream/prop_electric_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop_eletricpistol.ytyp'
