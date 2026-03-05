shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

---@section fx_information

fx_version("cerulean")
game("gta5")
lua54("yes")

---@section: resource_information

name("z_fire")
author("Zea Development - https://discord.gg/zHvPyJzhQU")
url("https://zeadevelopment.com/")
version("6bd32e7")

---@section: language

language("en")

---@section: dev_mode

dev_mode("false")

---@section: shared_script

shared_script({
    "settings/*.lua",
})

---@section: files

files({
    "web/**",
    "settings/jsons/*.json",
})

---@section: server_script

server_script({
    "core/server/init.lua",
    "core/server/main.lua",
    "core/server/classes/*.lua",
    "core/server/classes/*.js",
})

---@section: client_script

client_script({
    "core/client/init.lua",
    "core/client/main.lua",
    "core/client/classes/*.lua",
})

---@section: ui_page

ui_page("web/index.html")

---@section: escrow_ignore

escrow_ignore({
    "settings/config.lua",
    "core/client/classes/Utilities.lua",
    "core/client/classes/Enumerators.lua",
    "core/client/classes/Exports.lua",
    "core/client/classes/Bridge.lua",
    "core/server/classes/Bridge.lua",
    "core/server/classes/Exports.lua",
    "core/server/classes/Webhook.lua",
})
dependency '/assetpacks'
