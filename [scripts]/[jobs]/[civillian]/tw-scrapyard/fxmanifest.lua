shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.05'
name 'tw-scrapyard'

shared_scripts {
	'locales/*.lua',
	'config/*.lua',
	-- '@vrp/lib/utils.lua',
}

-- shared_script '@vrp/lib/utils.lua' -VRP

client_scripts {
	'locales/*.lua',
	-- "@vrp/lib/Utils.lua",
	'client/state.lua',
	'client/utility.lua',
	'client/utils.lua',
	'client/main.lua',
	'client/manual_placement.lua',
	'client/item_pickup.lua',
	'client/vehicle.lua',
	'client/grid_renderer.lua',
	'client/press.lua',
	'client/shredding.lua',
	'client/furnace.lua',
	'client/grate.lua',
	'client/dust.lua',
	'client/rail.lua',
	'client/crafting_tables.lua',
	'client/sell_npcs.lua',
	'client/furnace_dui.lua',
	'client/doorlock.lua',
}
server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'mysql-async'.:warning:
	'@oxmysql/lib/MySQL.lua',
	-- '@vrp/lib/Utils.lua',
	'server/aSQLInsert.lua',
	'server/utility.lua',
	'server/lobby.lua',
	'server/server.lua',
	'server/vehicle.lua',
	'server/editable.lua',
	'server/mission.lua',
	'server/press.lua',
	'server/shredding.lua',
	'server/crafting.lua',
	'server/furnace.lua',
	'server/grate.lua',
	'server/dust.lua',
	'server/rail.lua',
	'server/scrap.lua',
	'server/craft.lua',
	'server/doorlock.lua',
	'locales/*.lua',
}

ui_page "html/index.html"
files {
	"html/**/*.**",
	"html/*.**",
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'client/utility.lua',
	'client/utils.lua',
	'server/utility.lua',
	'server/editable.lua',
	'server/aSQLInsert.lua'
}

lua54 'yes'

dependency '/assetpacks'
