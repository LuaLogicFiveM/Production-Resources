shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

lua54 'yes'
fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'

files {
    'audio/apollo_mc_cypressflats_game.dat151.rel',
    'audio/apollo_mc_cypressgarage_game.dat151.rel',
    'audio/apollo_mc_cypress_tunnel_game.dat151.rel',
}

data_file 'AUDIO_GAMEDATA' 'audio/apollo_mc_cypressflats_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/apollo_mc_cypressgarage_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/apollo_mc_cypress_tunnel_game.dat'

client_script 'apollo_cypressflats_entityset_mods.lua'

escrow_ignore {
    'stream/front_sign_unlocked/*.ydr',
    'stream/unlocked/*.ydr',
    'stream/unlocked_logos/*.ydr',
    'stream/ytd/*.ytd',
    'apollo_cypressflats_entityset_mods.lua',
}

dependency '/assetpacks'
