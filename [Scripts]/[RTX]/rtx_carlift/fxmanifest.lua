shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'

game 'gta5'

version '100.0'

server_scripts {
	'config.lua',
	'language/main.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'language/main.lua',
	'client/main.lua'
}

files {
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/gizmoapi.js',
	'html/debounce.min.js',
	'html/BebasNeueBold.ttf',
	'html/img/*.png'
}

ui_page 'html/ui.html'

exports {
	'IsVehicleOnLift',
}

lua54 'yes'

escrow_ignore {
  'config.lua',
  'language/main.lua'
}





dependency '/assetpacks'
