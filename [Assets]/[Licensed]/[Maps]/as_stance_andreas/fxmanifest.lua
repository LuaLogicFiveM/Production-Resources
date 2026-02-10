shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
author 'AS MLO - Azzox'
description 'AS MLO STANCE ANDREAS'
lua54 'yes'
version '1.2'
this_is_a_map 'yes'
dependencies { 
    'as_mapdata',
    '/gameBuild:3095',  -- Requires at least GAME build 3095.
}
client_script "as_da_entityset.lua"
file "audio/as_da_game.dat151.rel"
data_file "AUDIO_GAMEDATA" "audio/as_da_game.dat"
escrow_ignore {
    'stream/base/*.ydr',
    'as_da_entityset.lua'
}
dependency '/assetpacks'
