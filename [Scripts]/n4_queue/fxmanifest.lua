shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
name 'n4_queue'
version '1.7.1'
server_only 'yes'
lua54 'yes'
server_scripts {
    '@oxmysql/lib/MySQL.lua', --REMOVE THIS LINE IF YOU ARE NOT USING YOUR DATABASE FOR PRIO!
    'config.lua',
    'server/*.lua'
}
dependencies {
    '/server:6761',
    '/onesync'
}
escrow_ignore {
    'config.lua',
    'server/functions.lua',
    'server/version.lua'
}
dependency '/assetpacks'
