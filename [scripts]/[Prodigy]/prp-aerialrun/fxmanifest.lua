shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
files {
    "locales/*.json",
    "dui/bombTimer/**/*",
}
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "init.lua"
}
server_scripts {
    "config.lua",
    "server/sync.lua",
    "server/class.lua",
    "server/server.lua",
    "server/queue.lua",
}
client_scripts {
    "client/utils.lua",
    "client/parachute.lua",
    "client/client.lua",
    "client/crateSync.lua",
    "client/npc.lua"
}
escrow_ignore {
    "server/**/*.lua",
    "config.lua",
    "init.lua"
}
dependency '/assetpacks'
