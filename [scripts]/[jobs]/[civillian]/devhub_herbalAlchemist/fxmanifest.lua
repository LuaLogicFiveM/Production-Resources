shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
version '1.1.2'
 
ui_page "html/index.html"

files {
    "html/**/*",
}

client_scripts {
    'configs/shared.lua',
    'configs/client.lua',
    'escrowed/**/sh.*.lua',
    'escrowed/**/c.*.lua',
}
server_scripts {
    'configs/server.lua',
    'configs/shared.lua',
    'configs/skillTree.lua',
    'escrowed/**/sh.*.lua',
    'escrowed/**/s.*.lua',
}

escrow_ignore {
    'configs/*.lua',
    'items.lua'
}
dependency '/assetpacks'
