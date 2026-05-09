local dbs = {
    [[
        create table if not exists dartboards (
            `id` int auto_increment primary key,
            `x` double not null,
            `y` double not null,
            `z` double not null,
            `rotX` double not null,
            `rotY` double not null,
            `rotZ` double not null,
            `placedBy` text not null,
            `createdAt` datetime default current_timestamp()
        );
    ]]
}

Dartboards = {} ---@type table<number, { id: number, data: table<number> }>
local requestedDartboards = {} ---@type table<string, boolean>

CreateThread(function()
    Wait(200)
    for i=1, #dbs do
        local s, e = pcall(function()
            exports.oxmysql:query(dbs[i])
        end)

        if not s then
            print("^1Error executing query: " .. dbs[i] .. " | Error: " .. e .. "^0")
        end
    end

    Wait(1000)

    local dartboards = exports.oxmysql:query_async("select * from dartboards")
    for i=1, #dartboards do
        local data = dartboards[i]
        Dartboards[data.id] = {
            id = data.id,
            data = { data.x, data.y, data.z, data.rotX, data.rotY, data.rotZ }
        }
    end
end)

---@param src number | string
---@param includeLast boolean?
---@return string
function GetCharacterName(src, includeLast)
    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then return "Unknown" end
    local characterName = bridge.fw.getCharacterName(identifier)
    if not characterName then return "Unknown" end
    return characterName
end

---@param src number | string
---@param amount number
---@return boolean
function PlayerCanAfford(src, amount)
    local walletAmount = bridge.fw.getMoney(src, "cash")
    return (walletAmount >= amount)
end

CreateThread(function()
    bridge.fw.registerCommand(
        Config.PlaceDartboardCommandName,
        locale("CMD_DARTBOARD_PLACE_HELP"),
        nil,
        Config.PlaceDartboardCommandRestriction,
    function(src, args)
        TriggerClientEvent("prp-dartboard:client:placeDartboard", src)
    end)
end)

RegisterNetEvent("prp-dartboard:server:addDartboard", function(x, y, z, rotX, rotY, rotZ)
    local src = source

    if not bridge.fw.isAdmin(src) then return end

    local identifier = bridge.fw.getIdentifier(src)
    if not identifier then return end

    bridge.log.send(Config.LogWebhookURL, locale("DARTBOARD_PLACED"), locale("PLACED_DARTBOARD_LOG", GetCharacterName(src), x, y, z, rotX, rotY, rotZ))

    local id = exports.oxmysql:insert_async("insert into dartboards (x, y, z, rotX, rotY, rotZ, placedBy) values (?, ?, ?, ?, ?, ?, ?)", { x, y, z, rotX, rotY, rotZ, identifier })

    Dartboards[id] = {
        id = id,
        data = { x, y, z, rotX, rotY, rotZ }
    }

    bridge.fw.notify(src, locale("DARTBOARD_PLACED_NOTIFICATION"), "success")

    TriggerClientEvent("prp-dartboard:client:addDartboard", -1, id, x, y, z, rotX, rotY, rotZ)
end)

RegisterNetEvent("prp-dartboard:server:removeDartboard", function(x, y, z)
    local src = source

    if not bridge.fw.isAdmin(src) then return end

    local coords = vec3(x, y, z)
    local removedId = nil
    for k, dartboard in pairs(Dartboards) do
        if #(vec3(dartboard.data[1], dartboard.data[2], dartboard.data[3]) - coords) < 1.0 then
            exports.oxmysql:update_async("delete from dartboards where id = ?", { dartboard.id })
            removedId = k
            Dartboards[k] = nil
            break
        end
    end

    if not removedId then return end

    bridge.log.send(Config.LogWebhookURL, locale("DARTBOARD_REMOVED"), locale("REMOVED_DARTBOARD_LOG", GetCharacterName(src), x, y, z))

    TriggerClientEvent("prp-dartboard:client:removeDartboard", -1, removedId, x, y, z)
end)

RegisterNetEvent("prp-dartboard:server:requestDartboards", function()
    local src = source

    if requestedDartboards[tostring(src)] then return end
    requestedDartboards[tostring(src)] = true

    local isAdmin = bridge.fw.isAdmin(src)
    TriggerClientEvent("prp-dartboard:client:setDartboards", src, Dartboards, isAdmin)
end)

AddEventHandler("onPlayerDropped", function(reason)
    local src = source
    requestedDartboards[tostring(src)] = nil
end)