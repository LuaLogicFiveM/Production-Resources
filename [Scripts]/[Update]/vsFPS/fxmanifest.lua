shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

author 'VibeScripts - [VS] Lefoxy'
description '[FREE] vsFPS - by VibeScripts'
version '1.0.0'

lua54 'yes'

client_scripts {
    'config.lua',
    'client.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/config.css',
}

escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'
