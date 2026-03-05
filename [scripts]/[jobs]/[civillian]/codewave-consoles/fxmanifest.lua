shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
lua54 'yes'
data_file 'DLC_ITYP_REQUEST' 'stream/gkms_techworkz_props.ytyp' -- Prop made By GKMS
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'client/client.lua',
    'client/client_transfers.lua',
    'notify.lua'
}
ui_page "web/index.html"
files {
    "web/index.html",
    'web/script.js',
    'web/style.css',
	'web/sounds/*.mp3',
    'web/image/*.png'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}
escrow_ignore {
    'config.lua',  --
    'notify.lua' 
  }
dependency '/assetpacks'
