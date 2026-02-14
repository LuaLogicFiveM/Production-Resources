shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

lua54 'yes'
fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'

author 'Prompt Studio'
description 'Sandy Shores Apartments'
version '1.0.3'

client_scripts {
    'config.lua',
    'proximity_loader.lua',
    'interior_manager.lua'
}


data_file 'DLC_ITYP_REQUEST' 'stream/shells/prompt_sandy_apts_shells.ytyp'

escrow_ignore {
    'config.lua',
    'stream/map/unlocked/**'
}


server_scripts{
	'sv_loader.lua'
}
dependency '/assetpacks'
