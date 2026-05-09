shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
author "Prodigy Studios"
this_is_a_map "yes"
data_file "AUDIO_GAMEDATA" "destiny_th_game.dat"
shared_script "@ox_lib/init.lua"
client_script "client.lua"
files {
    "destiny_th_game.dat151.rel",
}
dependency '/assetpacks'
