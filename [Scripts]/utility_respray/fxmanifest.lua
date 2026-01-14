shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author 'MXC'
shared_scripts {
    "config.lua",
    "config_functions.lua"
}
client_scripts {
    "@utility_lib/client/native.lua",
    "build/client/_server.lua",
    "build/client/data.lua",
    "build/client/internal_api.lua",
    "build/client/functions/*.lua",
    "build/client/modules/*.lua",
    "build/client/classes/*.lua",
    "build/client/weapon/*.lua",
    "build/client/main.lua",
}
server_scripts {
    "@utility_lib/server/native.lua",
    "build/server/**.lua",
}
files {
    'stream/meta/weaponarchetypes.meta',
	'stream/meta/weaponanimations.meta',
	'stream/meta/pedpersonality.meta',
	'stream/meta/weapons.meta',
	'stream/meta/carcols_gen9.meta',
    'stream/meta/carmodcols_gen9.meta',
    "stream/**.ytyp"
}
data_file 'WEAPON_METADATA_FILE' '**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' '**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' '**/weapons.meta'
data_file 'CARCOLS_GEN9_FILE' '**/carcols_gen9.meta'
data_file 'CARMODCOLS_GEN9_FILE' '**/carmodcols_gen9.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
leap_ignore {
    "config.lua",
    "config_functions.lua",
}
escrow_ignore {
    "config.lua",
    "config_functions.lua",
}
dependency '/assetpacks'
