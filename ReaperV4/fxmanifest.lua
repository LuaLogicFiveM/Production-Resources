fx_version "cerulean"
game { "gta5" }
lua54 "yes"

author "your a nerd | https://reaperac.com"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

shared_script "imports/bypass.js"
shared_script "imports/bypass.lua"
client_script "imports/bypass_c.lua"
server_script "imports/bypass_s.lua"

server_scripts {
    "scripts/index.js",
    "classes/class.lua",
    "scripts/**/config.lua",
    "classes/server/*.lua",
    "scripts/**/server.lua",
    "server.lua"
}

client_scripts {
    "classes/class.lua",
    "classes/client/*.lua",
    "scripts/**/client.lua",
    "scripts/detections/pro_detections/*.lua",
    "client.lua"
}

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
    "imports/bypass_c.lua"
}

-- dependencies {
--     '/server:12966',
--     '/onesync',
-- }
dependency '/assetpacks'