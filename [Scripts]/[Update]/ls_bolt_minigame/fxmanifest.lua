shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'Lith Studios | Swizz'
description 'Bolt Minigame by Lith Studios'
version '1.0.5'

files {
    'stream/wheel_spacer.ytyp'
}

data_file "DLC_ITYP_REQUEST" "stream/wheel_spacer.ytyp"

client_scripts {
    'config.lua',
    'client/editables.lua',
    'client/client.lua',
    'client/functions.lua'
}

escrow_ignore {
    'config.lua',
    'stream/*',
    'client/editables.lua'
}

dependency '/assetpacks'
