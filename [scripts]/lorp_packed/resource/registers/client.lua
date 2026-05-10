local config = lib.require('resource.registers.shared')
local cl_utils = lib.require('utils.client')
local ox_target = exports.ox_target

local function getList(data)
    local inputList = {}

    for i = 1, #data do
        local ply = data[i]
        inputList[#inputList + 1] = { value = ply.id, label = ('%s - %s'):format(ply.id, ply.name) }
    end

    return inputList
end

local function ChargeMenu()
    local data = lib.callback.await('lorp_billing:server:getCharacters', false)
    local playerJob = cl_utils.getPlayerJob()
    local inputList = getList(data)

    if #inputList == 0 then
        return cl_utils.notify('Billing', 'There are no customers nearby.', 'error', 5000)
    end

    local response = lib.inputDialog(playerJob.label, {
        { type = 'select', label = 'Customers', required = true, icon = 'fa-solid fa-user', options = inputList },
        { type = 'select', label = 'Account', required = true, icon = 'fa-solid fa-wallet', options = { { value = 'cash', label = 'Cash' }, { value = 'bank', label = 'Bank' } }},
        { type = "number", label = "How much?", icon = 'fa-solid fa-hand-holding-dollar', placeholder = "$", min = 1, description = "Input an amount to charge.", required = true }
    })

    if not response then return end

    TriggerServerEvent('lorp_billing:server:attemptCharge', { id = response[1], accountType = response[2], amount = response[3] })
end exports('ChargeMenu', ChargeMenu)

CreateThread(function()
    for job, data in pairs(config.jobs) do
        for i = 1, #data.locations do
            local coords = data.locations[i]
            ox_target:addSphereZone({
                coords = vec3(coords.x, coords.y, coords.z),
                radius = data.radius,
                distance = data.distance,
                debug = config.debug,
                options = {
                    {
                        label = 'Open Register',
                        icon = "fa-solid fa-money-check-dollar",
                        groups = job,
                        onSelect = function()
                            ChargeMenu()
                        end
                    }
                }
            })
        end
    end
end)

RegisterNetEvent("lorp_billing:client:sendConfirm", function(data)
    if GetInvokingResource() then return end

    local confirmation = lib.alertDialog({ header = ('**Do you accept the charge for $%s?**'):format(data.fee), centered = true, cancel = true, size = 'xs' })

    if confirmation == 'confirm' then
        data.confirm = true
    end

    TriggerServerEvent('lorp_billing:server:chargePlayer', data)
end)
