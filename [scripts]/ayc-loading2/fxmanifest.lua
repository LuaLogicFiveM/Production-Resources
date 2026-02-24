
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper
fx_version 'cerulean'
game 'common'

author 'Ayccoe & Wrench'
description 'Ayccoe\'s Loading Screen v2'
version '2.4.0'

lua54 'yes'

server_scripts {
	'secret.lua',
	'sv.lua',
}

client_scripts {
	'cl.lua',
}

escrow_ignore {
	'secret.lua',
	'config.lua'
}

files {
	'ui/dist/index.html',
	'ui/dist/*',
	'ui/dist/**/*',
}

loadscreen_manual_shutdown 'yes'

loadscreen_cursor 'yes'

use_experimental_fxv2_oal 'yes'

loadscreen 'ui/dist/index.html'
dependency '/assetpacks'