shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
lua54 'yes'

version '1.0.1'

ui_page "web/index.html"
files {
    "web/index.html",
    "web/script.js",
    "web/locales.js",
    "web/styles.css",
    "web/*.png",
}

client_scripts {
    "boxingLib/client.lua",
    "lib/shared.lua",
    "lib/locales.lua",
    "lib/clients/client.lua",
    "lib/clients/adminMenu.lua",
    "lib/clients/clientFunctions.lua",
    "editables/editableClient.lua",
    "lib/clients/clSyncEvents.lua",
    "lib/clients/startMatch.lua",
    "lib/clients/getReady.lua",
    "lib/clients/animationsClient.lua",
    "lib/clients/stamina.lua",
    "lib/clients/gym.lua"
}

server_scripts {
    "boxingLib/server.lua",
    "lib/locales.lua",
    "lib/version.lua",
    "lib/shared.lua",
    "lib/servers/server.lua",
    "editables/editableServer.lua",
    "lib/servers/svSyncEvents.lua",
    "lib/servers/startMatchServer.lua",
    "lib/servers/gymServer.lua"
}

escrow_ignore {
    "lib/shared.lua",
    "lib/locales.lua",
    -- Client
    "editables/editableClient.lua",
    "lib/clients/stamina.lua",
    "lib/clients/gym.lua",
    --Server
    "editables/editableServer.lua",
    "lib/servers/gymServer.lua"
}

shared_scripts {
    '@ox_lib/init.lua',
}

exports 'addGymStat'
exports 'checkGymStat'
exports 'removeGymStat'
dependency '/assetpacks'
