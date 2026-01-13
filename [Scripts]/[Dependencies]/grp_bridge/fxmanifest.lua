shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.3.2'
author 'APOLLO'
description 'Bridge for GRP Development'
shared_scripts {
    'configs/config.lua',
    'shared/shared.lua',
    'shared/init.lua'
}
client_scripts {
    'client/main.lua'
}
server_scripts {
    'server/main.lua'
}
files {
    'client/api/*.lua',
    'client/api/inventory/*.lua',
    'client/api/fuel/*.lua',
    'client/api/vehiclekeys/*.lua',
    'server/api/*.lua',
    'server/api/banking/*.lua',
    'server/api/inventory/*.lua'
}
escrow_ignore {
    '**/*'
}
dependency '/assetpacks'
