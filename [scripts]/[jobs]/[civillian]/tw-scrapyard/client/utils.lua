local State = Tworst.State

function LoadModel(hash)
    if not IsModelInCdimage(hash) then return false end
    RequestModel(hash)
    local t = GetGameTimer() + 5000
    while not HasModelLoaded(hash) and GetGameTimer() < t do Wait(0) end
    SetModelAsNoLongerNeeded(hash)
    return HasModelLoaded(hash)
end

function DrawText3D(x, y, z, text)
    if not text then text = "Metin yok" end -- Eğer metin yoksa varsayılan değer ver
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

 function Draw3DTextforTable(x, y, z, text, scale, color)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

function SendNotification(msg, typ)
    if Config and Config.sendNotification then
        Config.sendNotification({ text = msg, type = typ or "info" })
    end
end

function IsPlayerBusy()
    if State.hasLongTongs or (State.tongsEntity and DoesEntityExist(State.tongsEntity)) then
        return true, Locales[Config.Locale]['busy_holding_tongs']
    end

    if carryingObject and carryingObject.active then
        return true, Locales[Config.Locale]['busy_holding_item']
    end

    if ItemPickup and ItemPickup.carryingItem then
        return true, Locales[Config.Locale]['busy_holding_item']
    end

    if carryingCase then
        return true, Locales[Config.Locale]['busy_holding_box']
    end

    if State.carryingCase then
        return true, Locales[Config.Locale]['busy_holding_box']
    end


    return false, nil
end

function GetTimingConfig(category, key, fallback)
    if Config.Timing and Config.Timing[category] and Config.Timing[category][key] then
        return Config.Timing[category][key]
    end
    return fallback or 1000
end

function GetInteractionConfig(category, key, fallback)
    if Config.Interaction and Config.Interaction[category] and Config.Interaction[category][key] then
        return Config.Interaction[category][key]
    end
    return fallback or 1.0
end
