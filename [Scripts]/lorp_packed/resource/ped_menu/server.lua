local lorp_discord_api = exports.lorp_discord_api
local config = require 'resource.ped_menu.shared'

RegisterCommand(config.command, function(source)
    local src = source
    local playerRoles = lorp_discord_api:GetUserRoles(src)
    TriggerClientEvent('lorp_ped_menu:client:open', src, playerRoles)
end, false)