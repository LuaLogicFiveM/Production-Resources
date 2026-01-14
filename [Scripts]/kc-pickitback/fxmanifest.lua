shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
github 'https://github.com/clementinise/kc-pickitback'
version '2.1.3'

shared_scripts {
	'locales/*.lua',
	'config.lua',
}

client_script 'client/*.lua'

server_script 'server/server.lua'

escrow_ignore {
  'config.lua',
  'client/custom_export.lua',
  'locales/*.lua'
}

fivem_checker 'yes'
dependency '/assetpacks'
