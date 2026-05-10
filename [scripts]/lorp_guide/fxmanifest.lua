shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper



fx_version 'cerulean'
lua54 'yes'
game 'gta5'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/styles.css',
    'html/scripts.js',
    'html/img/**.png',
    'html/img/**.gif',
}

client_script {
    'client/cl-main.lua', 
    'shared.lua'
}

escrow_ignore {
	'shared.lua',
}

dependency '/assetpacks'
