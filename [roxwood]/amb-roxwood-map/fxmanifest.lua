shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games {'gta5'}

this_is_a_map 'yes'

lua54 'yes'

before_level_meta 'roxpop.meta'

after_level_meta 'roxheight.meta'

client_scripts
{
    'water.lua',
    'streetnames.lua',
    'birdheight.lua'
}


escrow_ignore {
    'birdheight.lua',
    'streetnames.lua',
    'doortuning.ymt',
    'water.xml',
    'heightmap.dat',
	'stream/stage_1/amb_rox_stage_1_path/*.ydr',
}

file 'roxheight.meta'
file 'roxpop.meta'
file 'roxwood_game.dat151.rel'
file 'water.xml'
file 'heightmap.dat'
file 'popzonerox.ipl'
file 'zonebind.ymt'
file 'doortuning.ymt'
file 'vfxfogvolumeinfo.ymt'

data_file 'AUDIO_GAMEDATA' 'roxwood_game.dat'
data_file 'ZONEBIND_FILE' 'zonebind.ymt'

dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
