shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.0.18'
lua54 'yes'

shared_scripts {
    'shared/config.lua',
    'shared/auto_detect.lua',
    'shared/locales.lua',
    'shared/functions.lua',
}

client_scripts {
    'client/**/*.lua',
}

server_scripts {
    --OPTIONAL DEPENDENCY INTEGRATIONS--
    --'@mysql-async/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'mysql-async'.⚠️

    --'@vrp/lib/utils.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'vrp'.⚠️
    --'@vrp/lib/Tunnel.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'vrp'.⚠️
	--'@vrp/lib/Proxy.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'vrp'.⚠️

   'server/**/*.lua',
   'server/core/read_directory.js'
}

exports {
    'Callback'
}

server_exports {
    'RegisterServerCallback',
    'ReadDirectory'
}

escrow_ignore {
    'client/**/*.lua',
    'server/**/*.lua',
    'shared/**/*.lua'
}
dependency '/assetpacks'
