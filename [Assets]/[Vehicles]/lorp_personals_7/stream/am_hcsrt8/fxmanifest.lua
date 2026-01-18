fx_version 'cerulean'
game 'gta5'

version '1.0'

files {
    'data/*.meta',
	"audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"audioconfig/*.dat10.rel",
	"sfx/**/*.awc"
}

data_file 'HANDLING_FILE'			'data/handling.meta'
data_file 'CARCOLS_FILE'			'data/carcols.meta'
data_file 'VEHICLE_METADATA_FILE'	'data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'	'data/carvariations.meta'
data_file "AUDIO_SYNTHDATA" "audioconfig/lg81hcredeye_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg81hcredeye_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg81hcredeye_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg81hcredeye"
dependency '/assetpacks'