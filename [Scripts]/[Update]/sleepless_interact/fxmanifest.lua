shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-- FX Information
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
version '2.1.3'
shared_scripts {
	'@ox_lib/init.lua',
}
client_scripts {
	'client/compat/init.lua',
	'init.lua',
	'client/*.lua',
}
files {
	'web/**',
	'client/modules/*.lua',
	'client/framework/*.lua',
	'client/compat/resources/*.lua'
}
provides {
	'ox_target',
	'qtarget'
}
dependency 'ox_lib'
