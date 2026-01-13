shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'client/main.lua',
    'client/client_sales.lua',
    'notify.lua'
}
ui_page "web/index.html"
files {
    "web/index.html",
    'web/script.js',
    'web/style.css',
    'stream/*.ytyp',
    'stream/*.ytd',
    'stream/*.ydr',
    'web/sounds/pickaxe.ogg',
	'web/sounds/*.mp3',
    'web/image/*.png'
}
server_scripts {
    'server/server_sales.lua',
    'server/main.lua'
}
escrow_ignore {
    'config.lua',  -- 
  }
dependency '/assetpacks'
