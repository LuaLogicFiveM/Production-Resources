local config = lib.require('resource.registers.shared')
local sv_utils = lib.require('utils.server')

local function securityCheck(job)
    return job and config.jobs[job] or false
end

local function sendLog(title, message)
    local embed = { { ['title'] = title, ['description'] = message, } }
    PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode({ username = 'Billing Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

local function getNearbyCharacters(coords)
    local players = GetActivePlayers()
    local nearby = {}

    for i = 1, #players do
        local playerId = players[i]
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(coords - playerCoords)

        if distance <= config.distance then
            local name = GetPlayerName(playerId)
            nearby[#nearby+1] = {
                id = playerId,
                name = name,
            }
        end
    end

    return nearby
end

lib.callback.register('lorp_billing:server:getCharacters', function(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local nearby = getNearbyCharacters(coords)
    return nearby
end)

RegisterNetEvent('lorp_billing:server:attemptCharge', function(data)
    local src = source
    local srcJob = sv_utils.getPlayerJob(src)

    if not securityCheck(srcJob.name) then return end

    local tgt = data.id

    if not tgt then
        return sv_utils.notify(src, 'Billing', 'Person Not Online', 'error', 5000)
    end

    if data.amount <= 0 then 
        return sv_utils.notify(src, 'Billing', 'Must be a valid amount above 0.', 'error', 5000)
    end

    local srcPed = GetPlayerPed(src)
    local tgtPed = GetPlayerPed(data.id)

    if #(GetEntityCoords(srcPed) - GetEntityCoords(tgtPed)) > config.distance then
        return sv_utils.notify(src, 'Billing', 'The person you are charging is not near you?', 'error', 5000)
    end

    local info = { srcid = src, trgid = data.id, fee = data.amount, account = data.accountType, confirm = false}
    TriggerClientEvent('lorp_billing:client:sendConfirm', data.id, info)
end)

RegisterNetEvent('lorp_billing:server:chargePlayer', function(data)
    local src = data.srcid
    local job = sv_utils.getPlayerJob(src)

    if not securityCheck(job.name) then return end

    local perc = config.jobs[job.name].percent or 0
    local commission = math.ceil(data.fee * perc)

    if not data.confirm then
        return sv_utils.notify(src, 'Billing', 'Customer declined the charge.', 'error', 5000)
    end

    local tgt = data.trgid
    local canPay

    if data.account == 'bank' then
        canPay = sv_utils.removeBank(tgt, data.fee)
    else
        canPay = sv_utils.removeItem(tgt, 'money', data.fee)
    end

    if canPay then
        local billerName = GetPlayerName(src)
        local targetName = GetPlayerName(tgt)

        if config.commission then
            exports['cs_bossmenu']:AddMoney(job.name, data.fee)
            sv_utils.addItem(src, 'money', commission)
            sv_utils.notify(src, 'Billing', ('You billed a customer for $%s & recevied $%s commission'):format(data.fee, commission), 'success', 5000)
            sendLog("Charge/Billing", "Biller: `" .. billerName .. "`\nCustomer: `" .. targetName .. "`\nBusiness: `" .. job.name .. "`\nAmount:`$" .. data.fee .. "`\nCommission:`$" .. commission .. "`")
        else
            exports['cs_bossmenu']:AddMoney(job.name, data.fee)
            sv_utils.notify(src, 'Billing', ('You billed a customer for $%s.'):format(data.fee), 'success', 5000)
            sendLog("Charge/Billing", "Biller: `" .. billerName .. "`\nCustomer: `" .. targetName .. "`\nBusiness: `" .. job.name .. "`\nAmount:`$" .. data.fee .. "`")
        end

        sv_utils.notify(tgt, 'Billing', ('You have been charged $%s from %s'):format(data.fee, job.label), 'success', 5000)
    else
        sv_utils.notify(tgt, 'Billing', "You don't have enough money for this.", "error", 5000)
        sv_utils.notify(src, 'Billing', 'Customer does not have enough money for this.', 'error', 5000)
    end
end)
