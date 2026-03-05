shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
version '2.0'
lua54 'yes'
this_is_a_map 'yes'
-- client_script 'staticEmitter.lua'
-- file "staticEmitter.lua"
file "audio/as_rex_diner_game.dat151.rel"
file "audio/as_rex_garage_game.dat151.rel"
data_file "AUDIO_GAMEDATA" "audio/as_rex_diner_game.dat"
data_file "AUDIO_GAMEDATA" "audio/as_rex_garage_game.dat"
escrow_ignore {
    'stream/**/*.ytd',
    'stream/**/*.ymap',
    'stream/**/*.ytyp'
}
dependency '/assetpacks'
