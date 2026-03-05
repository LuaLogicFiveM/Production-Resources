--print("[ULC] Brake Extras Loaded")
local realBrakeThreshold = 3
local shouldUseRealBrakes = function()
    return (MyVehicleConfig.brakeConfig.speedThreshold or 3) <= realBrakeThreshold
end
local braking = false
local brakeControlEnabled = true -- New toggle variable to control braking system

-------------------
-- MAIN FUNCTIONS --
-------------------

local disabledExtras = {}

local function setBrakeExtras(newState)
    for _, v in pairs(MyVehicleConfig.brakeConfig.brakeExtras) do
        local currentState
        if IsVehicleExtraTurnedOn(MyVehicle, v) then currentState = 0 else currentState = 1 end
        if currentState == newState then break end
        ULC:SetStage(v, newState, false, true)
    end
    if newState == 0 then
        if not MyVehicleConfig.brakeConfig.disableExtras then return end
        for _, v in pairs(MyVehicleConfig.brakeConfig.disableExtras) do
            if IsVehicleExtraTurnedOn(MyVehicle, v) then
                ULC:SetStage(v, 1, false, true)
                table.insert(disabledExtras, v)
            end
        end
    elseif newState == 1 then
        for _, v in pairs(disabledExtras) do
            ULC:SetStage(v, 0, false, true)
        end
        disabledExtras = {}
    end
end

----------------------------
-- REALISTIC BRAKE LIGHTS --
----------------------------
if shouldUseRealBrakes then
    print("Realistic brake light functionality initialized.")
    local mode = "STANDARD"

    CreateThread(function()
        local sleep = 1000
        while true do
            Wait(sleep)
            if mode == "RBL" then print("real-brake-lights resource detected, integrating brake light functionality.") return end
            if not MyVehicle then sleep = 1000 goto continue end
            if not shouldUseRealBrakes() then sleep = 1000 goto continue end
            if not MyVehicleConfig.brakeConfig.useBrakes then sleep = 1000 goto continue end
            if not brakeControlEnabled then sleep = 1000 goto continue end -- Skip logic if brake control is disabled
            if braking then goto continue end
            sleep = 250
            local speed = GetVehicleSpeedConverted(MyVehicle)
            if speed < realBrakeThreshold and shouldUseRealBrakes() and not IsControlPressed(0, 72) then
                setBrakeExtras(0)
            else
                setBrakeExtras(1)
            end
            ::continue::
        end
    end)

    AddStateBagChangeHandler('rbl_brakelights', null, function(bagName, key, value)
        Wait(0)
        mode = "RBL"
        if not MyVehicle then return end
        if not MyVehicleConfig.brakeConfig.useBrakes then return end
        if not brakeControlEnabled then return end -- Skip logic if brake control is disabled
        local vehicle = GetEntityFromStateBagName(bagName)
        if vehicle == 0 or vehicle ~= MyVehicle then return end
        local newState
        if value then newState = 0 else newState = 1 end
        setBrakeExtras(newState)
    end)
end

-----------------
-- KEYBINDINGS --
-----------------

RegisterCommand('+ulc:brakePattern', function()
    braking = true
    if MyVehicle and MyVehicleConfig.brakeConfig.useBrakes and brakeControlEnabled then
        if GetVehicleCurrentGear(MyVehicle) == 0 then return end
        local speed = GetVehicleSpeedConverted(MyVehicle)
        if shouldUseRealBrakes() or speed > (MyVehicleConfig.brakeConfig.speedThreshold or 3) then
            setBrakeExtras(0)
        end
    end
    SendNUIMessage({
        type = 'toggleBrakeIndicator',
        state = true
    })
end)

RegisterCommand('-ulc:brakePattern', function()
    braking = false
    if MyVehicle and MyVehicleConfig.brakeConfig.useBrakes and brakeControlEnabled then
        local speed = GetVehicleSpeedConverted(MyVehicle)
        if shouldUseRealBrakes() and speed < realBrakeThreshold then return end
        setBrakeExtras(1)
    end
    SendNUIMessage({
        type = 'toggleBrakeIndicator',
        state = false
    })
end)

RegisterKeyMapping('+ulc:brakePattern', 'Enable Brake Pattern (Hold)', 'keyboard', 's')

RegisterCommand('toggleBrakeControl', function()
    brakeControlEnabled = not brakeControlEnabled
    local state = brakeControlEnabled and "enabled" or "disabled"
    print("[ULC] Brake control " .. state)
    if not brakeControlEnabled then
        setBrakeExtras(1)
    end
end)

RegisterKeyMapping('toggleBrakeControl', 'Toggle Brake Control', 'keyboard', 'b')

CreateThread(function()
    while true do
        Wait(0)
        if not brakeControlEnabled then
            setBrakeExtras(1)
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                if IsControlPressed(0, 71) then
                    brakeControlEnabled = true
                    setBrakeExtras(0)
                end
            end
        end
    end
end)