shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version   "cerulean"
lua54        "yes"
games        { "gta5" }
version      "1.0.5"
ui_page "html/index.html"
files {
    "html/**/*"
}
shared_scripts {
    "modules/shared_*.lua",
    "locales/*.lua"
}
client_scripts {
    "config.lua",
    "config_rdroffsets.lua",
    "config_scroffsets.lua",
    "client/editable_api.lua",
    "client/editable_client.lua",
    "client/radar_data.lua",
    "client/main.lua",
    "client/radar.lua",
    "client/scrambler.lua",
    "client/editor.lua",
    "client/gizmo.js"
}
server_scripts {
    "config.lua",
    "config_rdroffsets.lua",
    "config_scroffsets.lua",
    "modules/server_*.lua",
    "server/*.lua"
}
escrow_ignore {
    "config.lua",
    "config_*.lua",
    "**/editable_*.lua",
    "server/*.lua",
    "**/server_*.lua",
    "**/shared_*.lua",
    "locales/*.lua",
    "addon/*.lua",
    "client/radar_data.lua",
}
dependency '/assetpacks'
