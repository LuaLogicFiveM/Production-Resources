shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games {'gta5'}

author 'TW-Store'
description 'TW-Store transport stream pack discord.gg/tworst'
version '1.0'

files {
	'carcols.meta',
	'carvariations.meta',
	'handling.meta',
	'vehicles.meta',
	'vehiclelayouts.meta'
}

data_file 'DLC_ITYP_REQUEST' 'tworst_illegalbox_v2.ytyp'

data_file 'HANDLING_FILE'			'handling.meta'
data_file 'VEHICLE_METADATA_FILE'	'vehicles.meta'
data_file 'CARCOLS_FILE'			'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'	'carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 	'vehiclelayouts.meta'
	

client_script 'vehicle_names.lua'

escrow_ignore {
    'vehicle_names.lua',
}

lua54 'yes'
dependency '/assetpacks'
