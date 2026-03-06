fx_version "cerulean"
lua54 "yes"
game "gta5"

name "g-bossmenu"
version "1.3.1"
description "Advanced & Complete Boss Menu"
author "G3DEV - justgroot"

shared_scripts {
    "src/shared/Config.lua",
    "locales/locale.lua",
    "locales/translations/*.lua",
    "src/utils/global.lua",
    "src/shared/jobVehicles.lua",
}
ui_page 'web/build/index.html'
-- ui_page 'http://localhost:5173/'
files {
    'web/build/index.html',
    'web/build/**/*',
    'web/jobApplicationFormData.json',
}

client_script {
    "bridge/**/client.lua",
    "src/utils/client.lua",
    "src/client/nui/cl_common.lua",
    "src/client/*.lua",
    "src/client/nui/*.lua",
    "src/theme/theme.lua",
}

server_scripts {
    "src/shared/sv_config.lua",
    "@oxmysql/lib/MySQL.lua",
    "bridge/**/server.lua",
    "src/server/*.lua",
    "src/server/services/*.lua",
    "src/server/nui/*.lua",
}


escrow_ignore {
    "src/shared/*.lua",
    "src/client/cl_edit.lua",
    "src/server/sv_edit.lua",
    "src/server/logs.lua",
    "src/server/DB.lua",
    "src/server/logs.lua",
    "src/theme/theme.lua",
    "bridge/**/server.lua",
    "bridge/**/client.lua",
    "locales/translations/*.lua",
}

dependency '/assetpacks'