shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'

game 'gta5'

version '220.0'

server_scripts {
	--'@mysql-async/lib/MySQL.lua',  -- enable this and remove oxmysql line (line 11) if you use mysql-async (only enable this for qbcore/esx framework)
	'@oxmysql/lib/MySQL.lua', -- enable this and remove mysql async line (line 10) if you use oxmysql (only enable this for qbcore/esx framework)
	'config.lua',
	'language/main.lua',
	'server/main.lua',
	'server/other.lua'
}

client_scripts {
	'config.lua',
	'language/main.lua',
	'client/main.lua',
	'client/other.lua'
}

files {
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/gizmoapi.js',
	'html/debounce.min.js',
	'html/BebasNeueBold.ttf',
	'html/img/*.png',
	'html/img/*.webp',
	'html/img/objects/*.webp',
	'html/img/yachtcolors/*.png',
	'html/img/yachtcolors/*.jpg'
}

ui_page 'html/ui.html'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'language/main.lua',
  'server/other.lua',
  'client/other.lua'
}
dependency '/assetpacks'
