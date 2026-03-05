fx_version "cerulean"
game { "gta5" }
lua54 "yes"

author "your a nerd | https://reaperac.com"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

shared_script "imports/bypass.lua"
shared_script "imports/bypass_c.lua"
server_script "imports/bypass_s.lua"
shared_script "imports/bypass.js"

server_scripts {
    "scripts/index.js",
    "classes/class.lua",
    "classes/core/server/Natives.lua",
    "classes/core/server/Logger.lua",
    "classes/server/Convar.lua",
    "classes/core/server/Security.lua",
    "classes/core/server/RPC.lua",
    "classes/core/server/Settings.lua",
    "classes/server/ConfigBlocks.lua",
    "scripts/convars.lua",
    "classes/server/HTTP.lua",
    "classes/server/KeyLock.lua",
    "classes/shared/Checks.lua",
    "classes/shared/TTL.lua",
    "classes/shared/Ratelimits.lua",
    "classes/server/Cache.lua",
    "classes/server/Command.lua",
    "classes/server/ConfigBlocks.lua",
    "classes/server/Compression.lua",
    "classes/server/Entities.lua",
    "classes/server/Falcon.lua",
    "classes/server/Features.lua",
    "classes/server/ini_parser.lua",
    "classes/server/Json.lua",
    "classes/server/Math.lua",
    "classes/server/MsgpackProtection.lua",
    "classes/server/NativeChecks.lua",
    "classes/server/OS.lua",
    "classes/server/Player.lua",
    "classes/server/Resource.lua",
    "classes/server/Resources.lua",
    "classes/server/String.lua",
    "classes/server/StringFormat.lua",
    "classes/server/System.lua",
    "classes/server/Table.lua",
    "classes/server/UncommonExecution.lua",
    "classes/server/Weapons.lua",
    "classes/server/XML_Parser.lua",
    "scripts/**/config.lua",
    "scripts/**/server.lua",

    -- "scripts/events"
    "scripts/events/server/key_lock.lua",
    "scripts/events/server/pro_addon.lua",
    "scripts/events/server.lua",

    -- "scripts/entities"
    "scripts/entities/server/logger.lua",
    "scripts/entities/server/management.lua",
    "scripts/entities/server/metrics.lua",
    "scripts/entities/server/ratelimits.lua",

    -- "scripts/server"
    "scripts/server/installer.lua",
    "scripts/server/pro-addon.lua",
}

client_scripts {
    "classes/class.lua",
    "classes/client/Math.lua",
    "classes/client/Table.lua",
    "classes/client/String.lua",
    "classes/client/PedTaskTypes.lua",
    "classes/client/PedConfigFlags.lua",
    "classes/client/Weapons.lua",
    "classes/core/client/Natives.lua",
    "classes/core/client/Logger.lua",
    "classes/core/client/Security.lua",
    "classes/core/client/RPC.lua",
    "classes/client/Config.lua",
    "classes/client/Player.lua",
    "classes/client/NUI.lua",
    "classes/client/Detections.lua",
    "classes/client/NativeChecks.lua",
    "classes/client/Entities.lua",
    "scripts/**/client.lua",
    "scripts/detections/pro_detections/*.lua",
    "scripts/tests.lua"
}

client_script "client.lua"
server_script "scripts/proxy.js"
server_script "server.lua"

files {
    'web/build/assets/*',
    'web/build/index.html',
    "patches/*.lua",
    "data_files/*.json",
    "imports/bypass.js",
    "imports/imports.lua"
}

ui_page "web/build/index.html"

escrow_ignore {
    "natives/*.lua",
    "patches/*.lua",
    "imports/imports.lua",
    "scripts/weapons/config.lua",
    "imports/bypass_c.lua",

    -- "entities"
    "scripts/entities/server/management.lua",
    "scripts/entities/server/ratelimits.lua",
}
dependency '/assetpacks'