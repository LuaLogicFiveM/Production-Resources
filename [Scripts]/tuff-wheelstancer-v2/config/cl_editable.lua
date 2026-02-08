function Config:CreateRadialMenu(id, title, icon, callback)
    -- Custom Code
end

-- If The Radial menu requires a event to trigger, Trigger This : tuff-wheelstancer:radialmenu


function Config.RemoveRadialMenu(id)
    -- Custom Code
end

-- Target Scripts For Car lift!
if Config.Carlift.Interaction.type ~= 'DrawText' then
    local targetResource = Config.Carlift.Interaction.TargetResourceName
    local type = Config.Carlift.Interaction.type
    local Target
    if exports[targetResource] and GetResourceState(targetResource) == 'started' then
        Target = exports[targetResource]
    elseif type == 'ox' and GetResourceState('ox_target') == 'started' then
        Target = exports['ox_target']
    elseif type == 'qb' and GetResourceState("qb-target") == 'started' then
        Target = exports['qb-target']
    else
        Config.Carlift.Interaction.type = 'DrawText' -- revert back to drawtext since Target is not available
        error('[MAJOR ERROR] No Target Resource found. Please review config.lua')
    end

    RemoveTargetZone = function(zoneName)
        if type == 'ox' then
            Target:removeZone(zoneName)
        elseif type == 'qb' then
            Target:RemoveZone(zoneName)
        end
    end
    AddEntityTarget = function(entity, label, name, onSelect)
        if type == 'ox' then
            local createdTarget = Target:addLocalEntity(entity, {
                label = label,
                name = name,
                onSelect = onSelect,
                icon = 'fas fa-magnifying-glass',
                canInteract = function(entity, distance, data)
                    return not IsPedInAnyVehicle(PlayerPedId(), false)
                end,
            })
            return createdTarget
        elseif type == 'qb' then
            Target:AddEntityZone(name, entity, {
                name = name,
                debugPoly = Config.debugPoly,
            }, {
                options = {
                    {
                        icon = 'fas fa-magnifying-glass',
                        label = label,
                        action = onSelect,
                        canInteract = function(entity, distance, data)
                            return not IsPedInAnyVehicle(PlayerPedId(), false)
                        end,
                    }
                },
                distance = 1.5,
            })
            return name
        end
    end
    AddSphereZone = function(coords, label, name, radius, onSelect)
        if type == 'ox' then
            local createdTarget = Target:addSphereZone({
                coords = coords,
                radius = radius,
                debug = Config.debugPoly,
                options = {
                    label = label,
                    name = name,
                    onSelect = onSelect,
                    distance = 1.8,
                    icon = "fa-solid fa-car-side",
                    canInteract = function(entity, distance, data)
                        return not IsPedInAnyVehicle(PlayerPedId(), false)
                    end,
                }
            })
            return createdTarget
        elseif type == 'qb' then
            Target:AddCircleZone(name, coords, radius, {
                name = name,
                debugPoly = Config.debugPoly,
                useZ = true
            }, {
                options = {
                    {
                        icon = "fa-solid fa-car-side",
                        label = label,
                        action = onSelect,
                        canInteract = function(entity, distance, data)
                            return not IsPedInAnyVehicle(PlayerPedId(), false)
                        end,
                    }
                },
                distance = 1.8
            })
            return name
        end
    end
end

RetrieveRealPlate = function(plate, vehicle) -- if you have a fake plate script you can implement it here to retrieve the real plate of the vehicle
    plate = NormalizePlate(plate)
    if GetResourceState('brazzers-fakeplates') == 'started' and exports['brazzers-fakeplates'] then
        local hasFakePlate = lib.callback.await('wheelstancer:brazzersFakePlate', plate)
        if hasFakePlate then return NormalizePlate(hasFakePlate) else return plate end
    end
    return plate
end

Notify = function(title, msgKey, cooldown, ntype)
    if not cooldown then cooldown = 3000 end
    if not ntype then ntype = 'success' end
    if ntype == "Success" then
        ntype = "success"
    end
    local languageKey = Language or "en"
    local translatedMessage = Translations[languageKey][msgKey] or Translations["en"][msgKey]
    if not translatedMessage or translatedMessage == '' then
        translatedMessage = msgKey
    end
    if Config.Notify == "codem" then
        TriggerEvent('codem-notification:Create', translatedMessage, "bminfo", title, cooldown)
    elseif Config.Notify == "esx" then
        ESX.ShowNotification(translatedMessage)
    elseif Config.Notify == "qb" then
        QBCore.Functions.Notify({ text = translatedMessage, caption = title }, ntype, cooldown)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert(title, translatedMessage, cooldown, ntype)
    elseif Config.Notify == 'wasabi' then
        exports.wasabi_notify:notify(title, translatedMessage, cooldown, ntype)
    elseif Config.Notify == 't-notify' then
        exports['t-notify']:Alert({ style = ntype, message = translatedMessage, duration = cooldown, })
    elseif Config.Notify == 'r_notify' then
        exports.r_notify:notify({
            title = title,
            content = translatedMessage,
            type = ntype,
            icon = "fas fa-check",
            duration =
                cooldown,
            position = 'top-right',
            sound = false
        })
    elseif Config.Notify == 'pNotify' then
        exports['pNotify']:SendNotification({
            text = translatedMessage,
            type = ntype,
            timeout = cooldown,
            layout =
            'centerRight'
        })
    elseif Config.Notify == 'mythic' then
        exports['mythic_notify']:SendAlert('inform', translatedMessage, cooldown)
    elseif Config.Notify == "ox_lib" or lib then
        lib.notify({
            title = title,
            description = translatedMessage,
            type = ntype
        })
    end
end

-- Custom 3d Text function
function Draw3DText(x, y, z, str, r, g, b, a, font, scaleSize, enableProportional, enableCenter, enableOutline,
                    enableShadow, sDist, sR, sG, sB, sA, boxR, boxG, boxB, boxA, padding)
    local onScreen = World3dToScreen2d(x, y, z)
    if not onScreen then return end

    SetDrawOrigin(x, y, z, 0)

    local scale = 0.25
    local fontId = font or 0
    local pad = padding or 0.003 -- horizontal padding around the text box

    -- Text setup
    SetTextScale(scale, scale)
    SetTextFont(fontId)
    SetTextColour(r or 255, g or 255, b or 255, a or 255)
    if enableProportional then SetTextProportional(true) end
    if enableCenter then SetTextCentre(true) end
    if enableOutline then SetTextOutline() end
    if enableShadow then
        SetTextDropshadow(sDist or 1, sR or 0, sG or 0, sB or 0, sA or 255)
    end

    -- EXPERIMENTAL BOX
    BeginTextCommandGetWidth("STRING")
    AddTextComponentString(str)
    local textWidth = GetTextScreenWidth(true)
    DrawRect(
        0.0, 0.0 + 0.0125, --
        textWidth + pad * 2, 0.03,
        boxR or 27, boxG or 27, boxB or 27, boxA or 120
    )

    SetTextEntry("STRING")
    AddTextComponentString(str)

    -- Draw the text over the box
    DrawText(0.0, 0.0)

    ClearDrawOrigin()
end

-- External Methods to open the stancer menu!
AddEventHandler('tuff:openStanceMenu', function()
    TryOpenStanceMenu(false --[[ Should Allow Opening Anywhere ?! ]],
        nil --[[ If not opening Anywhere, What is the stance location id, can see it in the Config.Stance_Location ]])
end)
