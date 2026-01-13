shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'

game 'gta5'

version '20.0'

server_scripts {
	'config.lua',
	'language/main.lua',
	'server/main.lua',
	'server/attr1.lua',
	'server/attr2.lua',
	'server/attr3.lua',
	'server/attr4.lua',
	'server/attr5.lua',
	'server/attr6.lua',
	'server/attr7.lua',
	'server/attr9.lua',
	'server/other.lua'
}

client_scripts {
	'config.lua',
	'language/main.lua',
	'client/main.lua',
	'client/attr1.lua',
	'client/attr2.lua',
	'client/attr3.lua',
	'client/attr4.lua',
	'client/attr5.lua',
	'client/attr6.lua',
	'client/attr7.lua',
	'client/attr9.lua'
}

files {
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/gizmoapi.js',
	'html/debounce.min.js',
	'html/BebasNeueBold.ttf',
	'html/NakaraRegular.ttf',
	'html/img/*.png'
}

exports {
	'IsPlayerOnRide', -- exports["rtx_spawnableattractions"]:IsPlayerOnRide() -- it will return if player is on some theme park ride
}

ui_page 'html/ui.html'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'language/main.lua',
  'server/other.lua'
}
dependency '/assetpacks'
