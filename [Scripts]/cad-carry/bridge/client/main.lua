--- Dead Check
---@return boolean
function IsDead()
    local player = PlayerPedId()
    local playerState = LocalPlayer.state
    return IsEntityDead(player) or playerState.dead or playerState.isDead
end

--- Target Dead Checks
---@param target number Target player ped
---@return boolean
function IsTargetDead(target)
    local targetPlayer = NetworkGetPlayerIndexFromPed(target)
    local targetServerId = GetPlayerServerId(targetPlayer)
    local targetState = Player(targetServerId).state
    return IsEntityDead(target) or targetState.dead or targetState.isDead
end

--- Check if target ped can be carried (dead or hands up)
---@param targetPed number Target player ped
---@return boolean
function IsTargetCarriable(targetPed)
    if not Config.RequireDeadOrHandsUp then return true end

    local isDead = IsTargetDead(targetPed)
    local animations = {
        { dict = "missminuteman_1ig_2", anim = "handsup_base" },
        { dict = "mp_arresting", anim = "idle" },
        { dict = "random@mugging3", anim = "handsup_standing_base" },
        { dict = "anim@move_m@prisoner_cuffed", anim = "idle" }
    }
    local isHandsUp = false
    for _, anim in ipairs(animations) do
        if IsEntityPlayingAnim(targetPed, anim.dict, anim.anim, 3) then
            isHandsUp = true
            break
        end
    end

    return isDead or isHandsUp
end

--- Carry Checks (if true then person being carried will be back on their feet / carry will be cancelled)
---@return boolean
function ChecksCarry()
    local player = PlayerPedId()
    return (Config.EnableDeadCarry and IsDead()) or LocalPlayer.state.intrunk
end

--- InTrunk Checks (if true then the person will be thrown out of trunk)
---@param player number Player ped id
---@param vehicle number Vehicle entity id
---@return boolean
function ChecksInTrunk(player, vehicle)
    local c1 = GetEntityCoords(player)
    local c2 = GetEntityCoords(vehicle)
    return #(c1 - c2) > 8 or GetVehicleEngineHealth(vehicle) < 100.0
        -- or (Config.EnableDeadCarry and IsDead())
end

--- Check If trunk is full
---@param vehicle number Vehicle entity id
---@return boolean
function IsTrunkFull(vehicle, forceValue)
    if Config.AllowMultipleInTrunk then
        return forceValue
    end
    return Entity(vehicle).state.isintrunk
end

--- Get vehicle lock status
---@param vehicle number Vehicle entity id
---@return boolean
function IsVehicleLocked(vehicle)
    if Config.CheckVehicleLocked then
        local lockStatus = GetVehicleDoorLockStatus(vehicle)
        return (lockStatus ~= 0) and (lockStatus ~= 1)
    else
        return false
    end
end

--- This function is triggered when controls disabled loop is started (ref: Config.DisableControls)
function OnControlsDisabled()
    -- Add your code here
end

--- This function is triggered when controls disabled loop is ended (ref: Config.DisableControls)
function OnControlsEnabled()
    -- Add your code here
end

-- This function is triggered to fade in screen
function ScreenFadeIn()
    if Config.EnableScreenFade then
        DoScreenFadeIn(500)
    end
end

-- This function is triggered to fade out screen
function ScreenFadeOut()
    if Config.EnableScreenFade then
        DoScreenFadeOut(500)
        while IsScreenFadedOut() do
            Wait(500)
        end
    end
end

local showingText = nil
--- Help Notification
---@param text string Text you want to show
function ShowText(text)
    if Config.TextUI == 'ox_lib' then
        if showingText ~= text then
            showingText = text
            lib.showTextUI(text, {
                position = 'bottom-center',
                style = {
                    backgroundColor = '#000000',
                    color = '#ffffff'
                }
            })
        end
    elseif Config.TextUI == 'qb' then
        if showingText ~= text then
            showingText = text
            exports['qb-core']:DrawText(text)
        end
    elseif Config.TextUI == 'esx' then
        if showingText ~= text then
            showingText = text
            exports.esx_textui:TextUI(text)
        end
    else
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextRightJustify(true)
        AddTextEntry('cadHelpNotification', text)
        BeginTextCommandDisplayHelp('cadHelpNotification')
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end

--- Hide Notification (Only if you are using UI for notifications like lib.showTextUI)
function HideText()
    if Config.TextUI == 'ox_lib' then
        if showingText ~= nil then
            lib.hideTextUI()
            showingText = nil
        end
    elseif Config.TextUI == 'qb' then
        if showingText ~= nil then
            exports['qb-core']:HideText()
            showingText = nil
        end
    elseif Config.TextUI == 'esx' then
        if showingText ~= nil then
            exports.esx_textui:HideUI()
            showingText = nil
        end
    end
end

--- Notification Event (To be triggered from server side files)
---@param text string Text you want to show
RegisterNetEvent('cad-carry:notify', function(text)
    if Config.Notify == 'ox_lib' then
        lib.notify({ description = text })
    elseif Config.Notify == 'qb' then
        TriggerEvent('QBCore:Notify', text)
    elseif Config.Notify == 'esx' then
        TriggerEvent('ESX:Notify', nil, nil, text)
    else
        ShowText(text)
    end
end)
