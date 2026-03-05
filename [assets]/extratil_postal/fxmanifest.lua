shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
-- Files.
files {
    "MINIMAP_LOADER.gfx"    -- Always first in the list.
}
client_scripts {
    "config.lua",
	"client.lua"
}
dependency '/assetpacks'
