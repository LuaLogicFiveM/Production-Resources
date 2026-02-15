shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
author 'Prompt Mods Studio | Escobar'
version "1.0.2"

files {
    'escobar_timecycle_fd_prompt.xml',
    'audio/prompt_fd_door_sound_game.dat151.rel',  
}

data_file 'TIMECYCLEMOD_FILE' 'escobar_timecycle_fd_prompt.xml'
data_file 'AUDIO_GAMEDATA' 'audio/prompt_fd_door_sound_game.dat'

escrow_ignore {
    'stream/unlocked/**'
}

-- scripts --
lua54 'yes'

server_scripts{
	'sv_loader.lua'
}
dependency '/assetpacks'
