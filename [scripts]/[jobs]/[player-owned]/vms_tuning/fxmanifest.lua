shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'vames™'
description 'vms_tuning'
version '2.1.5'
shared_scripts {
	'config/config.lua',
	'config/config.missions.lua',
	'config/config.custommods.lua',
	'config/config.translation.lua',
}
client_scripts {
	'client/*.lua',
	'config/config.installationparts.lua',
	'config/config.client.lua',
	'config/config.tuningmenu.lua',
	'config/config.vehicles.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config/config.server.lua',
	'server/*.lua',
	'server/custom_mods/*.lua',
}
ui_page 'html/ui.html'
files {
	'html/*.*',
	'html/**/*.*',
	'config/*.json',
	'meta/carcols_gen9.meta',
    'meta/carmodcols_gen9.meta',
	'audioconfig/**/*.dat151.rel',
	'audioconfig/**/*.dat54.rel',
	'sfx/**/*.awc'
}
-- https://pl.gta5-mods.com/vehicles/mercedes-amg-m177-m178-amg-gt-engine-sound-pack-oiv-add-on-fivem
data_file 'AUDIO_GAMEDATA' 		'audioconfig/ta176m177/ta176m177_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/ta176m177/ta176m177_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_ta176m177'
data_file 'AUDIO_GAMEDATA' 		'audioconfig/ta178amgb/ta178amgb_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/ta178amgb/ta178amgb_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_ta178amgb'
-- https://pl.gta5-mods.com/vehicles/mercedes-benz-v8-engine-sound-pack-oiv-addon-fivem
data_file 'AUDIO_GAMEDATA' 		'audioconfig/mercedesm113/mercedesm113_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/mercedesm113/mercedesm113_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_mercedesm113'
data_file 'AUDIO_GAMEDATA' 		'audioconfig/mercedesm155/mercedesm155_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/mercedesm155/mercedesm155_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_mercedesm155'
-- https://pl.gta5-mods.com/vehicles/lamborghini-avendator-l539-v12-engine-sound-oiv-add-on-fivem
data_file 'AUDIO_GAMEDATA' 		'audioconfig/ta023l539/ta023l539_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/ta023l539/ta023l539_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_ta023l539'
-- https://pl.gta5-mods.com/vehicles/bmw-m2-bmw-n55-s55-engine-sound-oiv-addon-fivem
data_file 'AUDIO_GAMEDATA' 		'audioconfig/n55b30t0/n55b30t0_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/n55b30t0/n55b30t0_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_n55b30t0'
data_file 'AUDIO_GAMEDATA' 		'audioconfig/s55b30/s55b30_game.dat'
data_file 'AUDIO_SOUNDDATA' 	'audioconfig/s55b30/s55b30_sounds.dat'
data_file 'AUDIO_WAVEPACK' 		'sfx/dlc_s55b30'
escrow_ignore {
	'audioconfig/**/*.dat151.rel',
	'audioconfig/**/*.dat54.rel',
	'sfx/**/*.awc',
	
	'config/*.lua',
	'server/version_check.lua'
}
dependency '/assetpacks'
