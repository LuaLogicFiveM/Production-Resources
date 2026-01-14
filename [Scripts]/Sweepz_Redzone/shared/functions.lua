function debugPrint(...)
    if Config.Debug then
        local data = {...}
        local str = ""
        for i = 1, #data do
            if type(data[i]) == "table" then
                str = str .. json.encode(data[i])
            elseif type(data[i]) ~= "string" then
                str = str .. tostring(data[i])
            else
                str = str .. data[i]
            end

            if i ~= #data then
                str = str .. " "
            end
        end
        print("^3[Debug]^7: " .. str)
    end
end

function Notification(text, server, source)
    if server then
        TriggerClientEvent('esx:showNotification', source, text)
        TriggerClientEvent('QBCore:Notify', source, text)
    else
        TriggerEvent('esx:showNotification', text)
        TriggerEvent('QBCore:Notify', text)
    end
end

function RespawnPlayer(source)
    local data = {}
    data.revive = true
    TriggerClientEvent('ak47_ambulancejob:revive', source)
    TriggerClientEvent('Sweepz_Redzone:Revive', source) -- Dont Change
    TriggerClientEvent('Sweepz_Redzone:Revive2', -1, source) -- Dont Change
    --local qbx_core = exports.qbx_core
    --qbx_core:SetMetadata(src, "isDead", false)
end

local ox_inventory = exports.ox_inventory
-- everyKill giving only boolean
function AddMoney(src, amount, everyKill)
    if tonumber(amount) > 0 then
        ox_inventory:AddItem(src, 'money', amount)
    end
end

-- everyKill giving only boolean
function GiveItem(src, itemName, itemCount, everyKill)
    if tonumber(itemCount) > 0 then
        ox_inventory:AddItem(src, itemName, itemCount)
    end
end