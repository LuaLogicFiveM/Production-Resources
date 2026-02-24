shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games {'gta5'}

author 'The Ambitioneers'
description 'Roxwood County DLC'


lua54 'yes'

server_scripts
{
    'startup.lua'
}

escrow_ignore 
{
    'startup.lua',
}
dependency '/assetpacks'
