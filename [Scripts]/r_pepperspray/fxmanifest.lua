shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'rytrak.fr'
ui_page 'html/index.html'

files {
    'html/*',

    'data/contentunlocks.meta',
    'data/weaponanimations.meta',
    'data/weaponarchetypes.meta',
    'data/loadouts.meta',
    'data/weapons.meta'
}

escrow_ignore {
	'config.lua',
    'client/cl_exports.lua',
	'client/cl_utils.lua',
    'server/sv_utils.lua'
}

shared_script 'config.lua'

server_script {
    'server/sv_utils.lua',
    'server/server.lua'
}

client_scripts {
	'client/cl_utils.lua',
	'client/client.lua',
    'client/cl_exports.lua'
}

data_file 'WEAPONINFO_FILE' 'data/weapons.meta'
data_file 'WEAPON_METADATA_FILE' 'data/weaponarchetypes.meta'
data_file 'LOADOUTS_FILE' 'data/loadouts.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/contentunlocks.meta'
dependency '/assetpacks'
