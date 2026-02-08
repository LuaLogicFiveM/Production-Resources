fx_version "cerulean"
game 'gta5'
version '1.4.0'
lua54 'yes'

dependencies {
    "/server:10488",
    "ox_lib",
    "tgiann-core",
    'yarn'
}

escrow_ignore {
    "configs/*.lua",
    "server/collectors/InventoryItems/*.lua",
}

shared_script "@ox_lib/init.lua"

client_scripts {
    "configs/configClient.lua",
    "client/*.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@tgiann-core/server/databaseCreator/main.lua",
    "configs/config.lua",
    "server/database.lua",
    "server/utils/*.lua",
    "server/main.lua",
    "server/endpoints/*.lua",
    "server/collectors/**/*.lua",
    "server/server.js"
}

dependency '/assetpacks'