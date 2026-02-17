function ParseISODateString(IsoString)
    local year, month, day, hour, min, sec = IsoString:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
    return os.time({ year = year, month = month, day = day, hour = hour, min = min, sec = sec })
end

-- Locales
local Locales = DreamLocales[DreamCore.Language]

-- Global Variables


-- Auto Impound System
local VehicleIdleTime = {}
--[[MySQL.ready(function()
    -- Auto Impound
    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        while true do
            Citizen.Wait(DreamCore.ImpoundAutomatic.interval)
            lib.notify({title = 'Auto Impound', description = 'All inactive vehicles will be automatically impounded in 30 seconds', type = 'warning', position = 'top', duration = 10000})
            SetTimeout(10 * 1000, function()
                lib.notify({title = 'Auto Impound', description = 'All inactive vehicles will be automatically impounded in 20 seconds', type = 'warning', position = 'top', duration = 10000})
            end)
            SetTimeout(20 * 1000, function()
                lib.notify({title = 'Auto Impound', description = 'All inactive vehicles will be automatically impounded in 10 seconds', type = 'warning', position = 'top', duration = 7000})
            end)
            SetTimeout(27 * 1000, function()
                lib.notify({title = 'Auto Impound', description = 'All inactive vehicles will be automatically impounded in 3 seconds', type = 'warning', position = 'top', duration = 1000})
            end)
            SetTimeout(28 * 1000, function()
                lib.notify({title = 'Auto Impound', description = 'All inactive vehicles will be automatically impounded in 2 seconds', type = 'warning', position = 'top', duration = 1000})
            end)
            SetTimeout(29 * 1000, function()
                lib.notify({title = 'Auto Impound', description = 'All inactive vehicles will be automatically impounded in 1 seconds', type = 'warning', position = 'top', duration = 1000})
            end)
            SetTimeout(30 * 1000, function()
                AutoImpoundOldVehicles()
                lib.notify({title = 'Auto Impound', description = 'All inactive vehicles have been automatically impounded', type = 'warning', position = 'top', duration = 10000})
            end)
        end
    end)
end)]]

function AutoImpoundOldVehicles()
    local VehiclePool = GetGamePool('CVehicle')
    for i = 1, #VehiclePool do
        local Vehicle = VehiclePool[i]
        local Plate = GetVehicleNumberPlateText(Vehicle):match("^%s*(.-)%s*$")

        --  Check if vehicle is free
        local NobodyIsInVehicle = true
        for i2 = 1, 10, 1 do
            if GetPedInVehicleSeat(Vehicle, i2) ~= 0 then
                NobodyIsInVehicle = false
            end
        end

        if NobodyIsInVehicle then
            -- Check idle time
            if (os.time() - (VehicleIdleTime[Plate] or os.time())) >= math.floor(DreamCore.ImpoundAutomatic.impoundAfter / 1000) then
                local VehicleData = DreamFramework.GetOwnedVehicleData(Plate)
                if VehicleData then
                    --[[ImpoundVehicle('AUTOIMPOUND', VehicleData.props, {
                        plate    = Plate,
                        officer  = 'Auto Impound',
                        unlock   = false,
                        offence  = 'auto_impound',
                        duration = math.floor(os.time() * 1000),
                        note     = ''
                    })]]
                    DeleteEntity(Vehicle)
                end
            end
        end
    end
end

RegisterCommand(DreamCore.ImpoundCommands.startAutoImpoundOldVehicles, function(source, args, rawCommand)
    AutoImpoundOldVehicles()
end, true)

RegisterNetEvent('dream_policeimpound:server:enteredVehicle', function(netId)
    if not netId then return end
    local Vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(Vehicle) then return end
    local Plate = GetVehicleNumberPlateText(Vehicle):match("^%s*(.-)%s*$")

    local NobodyIsInVehicle = true
    for i = 1, 10, 1 do
        if GetPedInVehicleSeat(Vehicle, i) ~= 0 then
            NobodyIsInVehicle = false
        end
    end

    if NobodyIsInVehicle then
        VehicleIdleTime[Plate] = nil
    end
end)

RegisterNetEvent('dream_policeimpound:server:exitedVehicle', function(netId)
    if not netId then return end
    local Vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(Vehicle) then return end
    local Plate = GetVehicleNumberPlateText(Vehicle):match("^%s*(.-)%s*$")
    VehicleIdleTime[Plate] = os.time()
end)

lib.callback.register('dream_policeimpound:server:getFormData', function(source)
    local source = source
    local OfficerName = 'Unknown'

    if DreamFramework.getPlayerFromId(source) then
        OfficerName = ShortOfficerName(DreamFramework.getPlayerName(source))
    end

    -- Offences
    local AllOffences = MySQL.Sync.fetchAll('SELECT * FROM police_impound_offence')

    return {
        officerName = OfficerName,
        offences = AllOffences
    }
end)

lib.callback.register('dream_policeimpound:server:impoundVehicle', function(source, VehicleProps, ImpoundData)
    local src = source
    local Identifier = DreamFramework.GetIdentifier(src)

    if Identifier then
        return ImpoundVehicle(Identifier, VehicleProps, ImpoundData)
    else
        return { success = false, message = Locales['GlobalVehicle']['ImpoundTarget']['Notify']['ImpoundFail']['WrongIdentifer']:format(VehicleProps.plate) }
    end
end)

function ImpoundVehicle(OfficerIdentifier, VehicleProps, ImpoundData)
    local VehicleOwner = DreamFramework.GetOwnedVehicleOwner(VehicleProps.plate)
    if VehicleOwner then
        -- Insert Impound Data
        MySQL.Sync.execute('INSERT INTO police_impound (officer, officer_name, status, duration, fine, offence, notes, vehicle, vehicle_plate, vehicle_owner, vehicle_owner_name) VALUES (@officer, @officer_name, @status, @duration, @fine, @offence, @notes, @vehicle, @vehicle_plate, @vehicle_owner, @vehicle_owner_name)', {
            ['@officer'] = OfficerIdentifier,
            ['@officer_name'] = ImpoundData.officer,
            ['@status'] = ImpoundData.unlock and 3 or 2,
            ['@duration'] = os.date('%Y-%m-%d %H:%M:%S', math.floor(ImpoundData.duration / 1000)),
            ['@fine'] = ImpoundData.fine, -- Not used it's NULL
            ['@offence'] = ImpoundData.offence,
            ['@notes'] = ImpoundData.note,
            ['@vehicle'] = json.encode(VehicleProps),
            ['@vehicle_plate'] = VehicleProps.plate,
            ['@vehicle_owner'] = VehicleOwner,
            ['@vehicle_owner_name'] = DreamFramework.GetPlayerNameByIdentifier(VehicleOwner),
        })

        -- Delete from owned vehicles db
        DreamFramework.DeleteOwnedVehicle(VehicleProps.plate)

        -- Try to notify the owner
        local xTarget = DreamFramework.getPlayerFromId(VehicleOwner)
        if xTarget then
            TriggerClientEvent('dream_policeimpound:client:notify', DreamFramework.getPlayerSourceFromPlayer(xTarget), Locales['GlobalVehicle']['ImpoundTarget']['Notify']['ImpoundInfo']:format(VehicleProps.plate))
        end

        -- Webhook
        if DreamCore.Webhooks.Enabled then
            SendDiscordWebhook({
                link = DreamCore.Webhooks.ImpoundVehicle,
                color = DreamCore.Webhooks.Color,
                thumbnail = DreamCore.Webhooks.IconURL,
                author = {
                    name = DreamCore.Webhooks.Author,
                    icon_url = DreamCore.Webhooks.IconURL
                },
                title = "🚓 Impound Vehicle",
                description = ("**🆔 Officer ID:** `%s`\n**👮 Officer Name:** `%s`\n**📋 Offence:** `%s`\n**⏳ Duration:** `%s`\n**🔒 Lock:** `%s`\n**🏎️ Vehicle Plate:** `%s`\n**🧑 Vehicle Owner ID:** `%s`\n**🧑 Vehicle Owner Name:** `%s`\n**📝 Notes:** `%s`"):format(
                    OfficerIdentifier,
                    ImpoundData.officer,
                    ImpoundData.offence,
                    os.date('%Y-%m-%d %H:%M:%S', math.floor(ImpoundData.duration / 1000)),
                    ImpoundData.unlock and 'Need Unlock through LSPD' or 'No Unlock needed',
                    VehicleProps.plate,
                    VehicleOwner,
                    DreamFramework.GetPlayerNameByIdentifier(VehicleOwner) or 'N/A',
                    ImpoundData.note ~= '' and ImpoundData.note or "N/A"
                ),
                footer = {
                    text = "Made with ❤️ by Dream Development",
                    icon_url = DreamCore.Webhooks.IconURL
                },
            })
        end

        -- Tuncion XP
        if DreamCore.TuncionXP.activate then
            local xPlayer = DreamFramework.getPlayerFromId(OfficerIdentifier)
            if xPlayer then exports[DreamCore.TuncionXP.resourceName]:addXP(DreamFramework.getPlayerSourceFromPlayer(xPlayer), DreamCore.TuncionXP.impoundVehicle, '🚓 Impound Vehicle') end
        end

        return { success = true, message = Locales['GlobalVehicle']['ImpoundTarget']['Notify']['ImpoundSuccess']:format(VehicleProps.plate) }
    else
        return { success = false, message = Locales['GlobalVehicle']['ImpoundTarget']['Notify']['ImpoundFail']['NoOwner']:format(VehicleProps.plate) }
    end
end

lib.callback.register('dream_policeimpound:server:getImpoundVehicles', function(source)
    local source = source

    if DreamFramework.getPlayerFromId(source) then
        local Identifier = DreamFramework.GetIdentifier(source)
        local ImpoundVehicles = {}

        if IsInArray(DreamCore.AllowedPoliceJobs, DreamFramework.getPlayerJob(source, 'name')) then
            ImpoundVehicles = MySQL.Sync.fetchAll('SELECT * FROM police_impound WHERE NOT status = 1', {})
        else
            ImpoundVehicles = MySQL.Sync.fetchAll('SELECT * FROM police_impound WHERE vehicle_owner = @vehicle_owner AND NOT status = 1', {
                ['@vehicle_owner'] = Identifier
            })
        end

        if #ImpoundVehicles <= 0 then
            return { success = false, message = Locales['LocalEntity']['ImpoundStation']['Notify']['NoImpoundVehicles'] }
        end

        -- Status Mapping
        local AllAvailableStatus = MySQL.Sync.fetchAll('SELECT * FROM police_impound_status', {})
        local StatusMapping = {}
        for k, v in pairs(AllAvailableStatus) do
            StatusMapping[v.id] = {
                id = v.id,
                name = v.name,
            }
        end

        -- Offence Mapping
        local AllAvailableOffences = MySQL.Sync.fetchAll('SELECT * FROM police_impound_offence', {})
        local OffenceMapping = {}
        for k, v in pairs(AllAvailableOffences) do
            OffenceMapping[v.id] = {
                id = v.id,
                name = v.name,
                amount = v.amount
            }
        end

        -- Update Impound Data
        for k, v in pairs(ImpoundVehicles) do
            ImpoundVehicles[k].status = StatusMapping[v.status]
            ImpoundVehicles[k].offence = OffenceMapping[v.offence]
            ImpoundVehicles[k].vehicle = json.decode(v.vehicle)
            ImpoundVehicles[k].vehicle_plate = v.vehicle_plate
            ImpoundVehicles[k].vehicle_owner = v.vehicle_owner
            ImpoundVehicles[k].vehicle_owner_name = v.vehicle_owner_name
            ImpoundVehicles[k].duration = os.date(DreamCore.ImpoundDurationFormat, math.floor(v.duration / 1000))
        end

        return { success = true, data = ImpoundVehicles }
    end
end)

lib.callback.register('dream_policeimpound:server:unlockVehicle', function(source, ImpoundVehicleId)
    MySQL.Sync.execute('UPDATE police_impound SET status = 2 WHERE id = @id', {
        ['@id'] = ImpoundVehicleId
    })

    -- Try to notify the owner
    local ImpoundVehicleData = MySQL.Sync.fetchAll('SELECT * FROM police_impound WHERE id = @id', {
        ['@id'] = ImpoundVehicleId
    })?[1]

    local xTarget = DreamFramework.getPlayerFromId(ImpoundVehicleData?.vehicle_owner)
    if xTarget then
        TriggerClientEvent('dream_policeimpound:client:notify', DreamFramework.getPlayerSourceFromPlayer(xTarget), Locales['LocalEntity']['ImpoundStation']['Notify']['ImpoundVehicleUnlockInfo']:format(ImpoundVehicleData.vehicle_plate))
    end

    -- Webhook
    if DreamCore.Webhooks.Enabled then
        SendDiscordWebhook({
            link = DreamCore.Webhooks.UnlockVehicle,
            color = DreamCore.Webhooks.Color,
            thumbnail = DreamCore.Webhooks.IconURL,
            author = {
                name = DreamCore.Webhooks.Author,
                icon_url = DreamCore.Webhooks.IconURL
            },
            title = "🚓 Vehicle Unlocked",
            description = ("**🆔 Officer ID:** `%s`\n**👮 Officer Name:** `%s`\n**🏎️ Vehicle Plate:** `%s`\n**🧑 Vehicle Owner ID:** `%s`\n**🧑 Vehicle Owner Name:** `%s`"):format(
                DreamFramework.GetIdentifier(source),
                ShortOfficerName(DreamFramework.getPlayerName(source)),
                ImpoundVehicleData?.vehicle_plate,
                ImpoundVehicleData?.vehicle_owner,
                ImpoundVehicleData?.vehicle_owner_name
            ),
            footer = {
                text = "Made with ❤️ by Dream Development",
                icon_url = DreamCore.Webhooks.IconURL
            },
        })
    end

    return {
        success = true,
        message = Locales['LocalEntity']['ImpoundStation']['Notify']['PoliceVehicleUnlockSuccess']
    }
end)

lib.callback.register('dream_policeimpound:server:parkOutVehicle', function(source, ImpoundVehicleId)
    local Identifier = DreamFramework.GetIdentifier(source)
    local ImpoundVehicleData = MySQL.Sync.fetchAll('SELECT * FROM police_impound WHERE id = @id', {
        ['@id'] = ImpoundVehicleId
    })?[1]

    if ImpoundVehicleData and Identifier then
        local FineAmount = nil

        if ImpoundVehicleData.fine then
            FineAmount = ImpoundVehicleData.fine
        else
            local OffenceData = MySQL.Sync.fetchAll('SELECT * FROM police_impound_offence WHERE id = @id', {
                ['@id'] = ImpoundVehicleData.offence
            })?[1]
            FineAmount = OffenceData.amount
        end

        if math.floor(ImpoundVehicleData.duration / 1000) <= os.time() then
            -- Check if the player has enough money
            if FineAmount <= DreamFramework.getPlayerMoney(source, 'money') then
                DreamFramework.removePlayerMoney(source, 'money', FineAmount)

                MySQL.Sync.execute('UPDATE police_impound SET status = 1 WHERE id = @id', {
                    ['@id'] = ImpoundVehicleId
                })

                -- Insert in owned vehicles
                DreamFramework.InsertOwnedVehicle(ImpoundVehicleData.vehicle_plate, Identifier, ImpoundVehicleData.vehicle)

                -- Webhook
                if DreamCore.Webhooks.Enabled then
                    SendDiscordWebhook({
                        link = DreamCore.Webhooks.ParkOutVehicle,
                        color = DreamCore.Webhooks.Color,
                        thumbnail = DreamCore.Webhooks.IconURL,
                        author = {
                            name = DreamCore.Webhooks.Author,
                            icon_url = DreamCore.Webhooks.IconURL
                        },
                        title = "🚓 Vehicle Parked Out",
                        description = ("**🏎️ Vehicle Plate:** `%s`\n**🧑 Vehicle Owner ID:** `%s`\n**🧑 Vehicle Owner Name:** `%s`\n**💸 Fine Paid:** `$%s`"):format(
                            ImpoundVehicleData?.vehicle_plate,
                            ImpoundVehicleData?.vehicle_owner,
                            DreamFramework.GetPlayerNameByIdentifier(ImpoundVehicleData?.vehicle_owner),
                            FineAmount
                        ),
                        footer = {
                            text = "Made with ❤️ by Dream Development",
                            icon_url = DreamCore.Webhooks.IconURL
                        },
                    })
                end

                -- Tuncion XP
                if DreamCore.TuncionXP.activate then
                    exports[DreamCore.TuncionXP.resourceName]:addXP(source, DreamCore.TuncionXP.vehicleParkedOut, '🚓 Vehicle Parked Out')
                end

                return { success = true, message = Locales['LocalEntity']['ImpoundStation']['Notify']['ImpoundVehicleParkOut'] }
            else
                return { success = false, message = Locales['LocalEntity']['ImpoundStation']['Notify']['ImpoundNotEnoughMoney'] }
            end
        else
            return { success = false, message = Locales['LocalEntity']['ImpoundStation']['Notify']['ImpoundVehicleDuration']:format(os.date(DreamCore.ImpoundDurationFormat, math.floor(ImpoundVehicleData.duration / 1000))) }
        end
    else
        return { success = false, message = Locales['LocalEntity']['ImpoundStation']['Notify']['ImpoundVehicleInvalid'] }
    end
end)

function ShortOfficerName(OfficerName)
    local firstNameInitial = OfficerName:match("^(%a)") or ""
    local lastName = OfficerName:match("%s(%a+)$") or ""
    return firstNameInitial .. ". " .. lastName
end

function IsInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

function SendDiscordWebhook(WebhookData)
    local EmbedDataArray = {}
    local EmbedData = {}

    EmbedData.color = WebhookData.color

    if WebhookData.author then
        EmbedData.author = {}
        EmbedData.author.name = WebhookData.author.name
        EmbedData.author.icon_url = WebhookData.author.icon_url
    end

    if WebhookData.title then
        EmbedData.title = WebhookData.title
    end

    if WebhookData.thumbnail then
        EmbedData.thumbnail = {}
        EmbedData.thumbnail.url = WebhookData.thumbnail
    end

    EmbedData.description = WebhookData.description

    if WebhookData.footer then
        EmbedData.footer = {}
        EmbedData.footer.text = WebhookData.footer.text
        EmbedData.footer.icon_url = WebhookData.footer.icon_url
    end

    table.insert(EmbedDataArray, EmbedData)

    PerformHttpRequest(WebhookData.link, function(err, text, headers) end, 'POST', json.encode({ embeds = EmbedDataArray }), { ['Content-Type'] = 'application/json' })
end
