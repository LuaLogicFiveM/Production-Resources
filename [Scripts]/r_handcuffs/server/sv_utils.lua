/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-handcuffs-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Framework Part ]]

ESX = exports["es_extended"]:getSharedObject()
local ox_inventory = exports.ox_inventory

if Config.Framework.OXInventory then
    exports('handcuffs', function(event, item, inventory, slot, data)
        TriggerClientEvent('r_handcuffs:client:execCuffs', inventory.id)
    end)

    exports('handcuff_keys', function(event, item, inventory, slot, data)
        TriggerClientEvent('r_handcuffs:client:execUncuffs', inventory.id)
    end)

    exports('rope', function(event, item, inventory, slot, data)
        TriggerClientEvent('r_handcuffs:client:execRope', inventory.id)
    end)

    exports('grinder', function(event, item, inventory, slot, data)
        TriggerClientEvent('r_handcuffs:client:execGrinder', inventory.id)
    end)

    exports('knife', function(event, item, inventory, slot, data)
        TriggerClientEvent('r_handcuffs:client:execUnrope', inventory.id)
    end)
end

-- [[ Event ]]

local jobs = { ['sheriff'] = 0, ['sahp'] = 0 }

local function hasJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer and jobs[xPlayer.getJob().name] or false
end

RegisterNetEvent('r_handcuffs:server:cuffs', function(pid)
    local src = source
    local tgt = pid
    if not hasJob(src) then return end
    --if not IsPlayerBehind(pid, src) then return end

    if Player(tgt).state[Config.StatebagsName.handcuffs] or Player(tgt).state[Config.StatebagsName.rope] then return end
    if Player(src).state[Config.StatebagsName.handcuffs] or Player(src).state[Config.StatebagsName.rope] then return end

    ox_inventory:RemoveItem(src, 'handcuffs', 1)
    ox_inventory:AddItem(src, 'handcuff_keys', 1)
    exports.lorp_packed:SendLog('__**Cuff Logs**__', "\nSource Name: "..GetPlayerName(src).. "\nSource Identifiers: "..json.encode(GetPlayerIdentifiers(src)).. "\nTarget Name: "..GetPlayerName(tgt)..'\nTarget Identifiers: '..json.encode(GetPlayerIdentifiers(tgt)), 'https://ptb.discord.com/api/webhooks/1193124191340351488/ifh1J_EzZ7ZIHB_31nBAXTjXnEgK3NMZIVdAjxR4pK9PfGvuw4ZzYNP_V0ldZ9Gb3ptB')
    CuffPlayer(src, tgt, 'cuffs')
end)

RegisterNetEvent('r_handcuffs:server:uncuffs', function(pid)
    local src = source
    if not hasJob(src) then return end
    if not IsPlayerBehind(pid, src) then return end
    if not Player(pid).state[Config.StatebagsName.handcuffs] then return end
    if Player(src).state[Config.StatebagsName.handcuffs] or Player(src).state[Config.StatebagsName.rope] then return end

    UncuffPlayer(src, pid, 'cuffs')
    ox_inventory:AddItem(src, 'handcuffs', 1)
    ox_inventory:RemoveItem(src, 'handcuff_keys', 1)
    exports.lorp_packed:SendLog('__**Uncuff Logs**__', "\nSource Name: "..GetPlayerName(src).. "\nSource Identifiers: "..json.encode(GetPlayerIdentifiers(src)).. "\nTarget Name: "..GetPlayerName(pid)..'\nTarget Identifiers: '..json.encode(GetPlayerIdentifiers(pid)), 'https://ptb.discord.com/api/webhooks/1193124191340351488/ifh1J_EzZ7ZIHB_31nBAXTjXnEgK3NMZIVdAjxR4pK9PfGvuw4ZzYNP_V0ldZ9Gb3ptB')
end)

RegisterNetEvent('r_handcuffs:server:rope', function(pid)
    local src = source
    if not IsPlayerBehind(pid, src) then return end
    if Player(pid).state[Config.StatebagsName.handcuffs] or Player(pid).state[Config.StatebagsName.rope] then return end
    if Player(src).state[Config.StatebagsName.handcuffs] or Player(src).state[Config.StatebagsName.rope] then return end    
    ox_inventory:RemoveItem(src, 'rope', 1)

    CuffPlayer(source, pid, 'rope')
    exports.lorp_packed:SendLog('__**Rope Logs**__', "\nSource Name: "..GetPlayerName(src).. "\nSource Identifiers: "..json.encode(GetPlayerIdentifiers(src)).. "\nTarget Name: "..GetPlayerName(pid)..'\nTarget Identifiers: '..json.encode(GetPlayerIdentifiers(pid)), 'https://ptb.discord.com/api/webhooks/1193124191340351488/ifh1J_EzZ7ZIHB_31nBAXTjXnEgK3NMZIVdAjxR4pK9PfGvuw4ZzYNP_V0ldZ9Gb3ptB')
end)

RegisterNetEvent('r_handcuffs:server:unrope', function(pid)
    local src = source
    if not IsPlayerBehind(pid, src) then return end

    UncuffPlayer(src, pid, 'rope')
    exports.lorp_packed:SendLog('__**Unrope Logs**__', "\nSource Name: "..GetPlayerName(src).. "\nSource Identifiers: "..json.encode(GetPlayerIdentifiers(src)).. "\nTarget Name: "..GetPlayerName(pid)..'\nTarget Identifiers: '..json.encode(GetPlayerIdentifiers(pid)), 'https://ptb.discord.com/api/webhooks/1193124191340351488/ifh1J_EzZ7ZIHB_31nBAXTjXnEgK3NMZIVdAjxR4pK9PfGvuw4ZzYNP_V0ldZ9Gb3ptB')
end)

RegisterNetEvent('r_handcuffs:server:grinder', function(pid)
    local src = source
    if not IsPlayerBehind(pid, src) then return end

    GrinderPlayer(src, pid)
    exports.lorp_packed:SendLog('__**Grinder Logs**__', "\nSource Name: "..GetPlayerName(src).. "\nSource Identifiers: "..json.encode(GetPlayerIdentifiers(src)).. "\nTarget Name: "..GetPlayerName(pid)..'\nTarget Identifiers: '..json.encode(GetPlayerIdentifiers(pid)), 'https://ptb.discord.com/api/webhooks/1193124191340351488/ifh1J_EzZ7ZIHB_31nBAXTjXnEgK3NMZIVdAjxR4pK9PfGvuw4ZzYNP_V0ldZ9Gb3ptB')
end)

-- [[ Functions ]]

function GetPlayerLicense(player)
    for _,v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return string.gsub(v, "license:", "")
        end
    end
end