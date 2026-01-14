for k, v in pairs(Config.DefaultKeys) do
    if(not Config.DevMode and string.find(k, "editor")) then
        -- we don't need editor keys while not in devmode
        goto nextKey
    end
    local controlString =("%s_%s"):format("policeradar", k)
    RegisterKeyMapping("+"..controlString, _L("key_"..k), 'keyboard', v)
    RegisterCommand("+"..controlString, function()
        SetKeyState(k, true)
    end, false)
    RegisterCommand("-"..controlString, function()
        SetKeyState(k, false)
    end, false)
    ::nextKey::
end

if(GetResourceState("es_extended") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("esx:showNotification", notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("QBCore:Notify", notification)
    end
else
	function HudAddNotification(notification)
        ShowNotification("Police Radar", notification, "")
    end
end

RegisterNetEvent("sf-policeradar:showNotification", function(text)
    HudAddNotification(text)
end)

function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('policeradarNotification', message)
    BeginTextCommandThefeedPost("policeradarNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CALL911", notifImage or "CHAR_CALL911", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("policeradarHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("policeradarHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("policeradarHelpNotification")
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function EditorState(state)
    -- ox_inventory example 
    LocalPlayer.state:set('invHotkeys', not state, false)
end

local inUi = false
RegisterCommand("radar_pos", function()
    if(VehicleThread and GetFollowPedCamViewMode() ~= 4) then
        inUi = true
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        while inUi do
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 4, true)
            DisableControlAction(0, 5, true)
            Citizen.Wait(0)
        end
        for i=1, 30 do
            DisableControlAction(0, 200, true)
            Citizen.Wait(0)
        end
    end
end, false)

RegisterNUICallback("sf-policeradar:exit", function(data, cb)
    inUi = false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb({})
end)

if(Config.DevMode) then
    RegisterCommand("radar_edit", function()
        if(not IsPedInAnyVehicle(PlayerPedId())) then
            HudAddNotification(_L("no_vehicle"))
            return
        end
        EditorThread()
    end, false) 
    
    RegisterCommand("scrambler_edit", function()
        if(not IsPedInAnyVehicle(PlayerPedId())) then
            HudAddNotification(_L("no_vehicle"))
            return
        end
        EditorThread(true)
    end, false)
end

function CanViewRadar()
    return true
end

function CanEditRadar()
    return true
end