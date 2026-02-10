local TargetPed = nil

local InputCooldowns = {
    ["Thief"] = 0,
    ["HandsUp"] = 0
}

local PlayerState = {
    ["IsStealing"] = false,
    ["IsBeingRobbed"] = false,
    ["HasHandsUp"] = false
}

local function StopHandsUpState()
    ClearPedTasks(cache.ped)
    PlayerState["HasHandsUp"] = false
    TriggerServerEvent('lorp_robbing:server:state', false)
    LocalPlayer.state.invBusy = false
end

local function LoadAnimDict(animDict)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Wait(0)
		end
	end
end

local function MakeEntityFaceEntity(entity1, entity2)
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading(entity1, heading)
end

CreateThread(function()
    LoadAnimDict('anim@mugging@victim@toss_ped@')
end)

exports("IsPlayerStealing", function()
    return PlayerState["IsStealing"]
end)

exports("IsPlayerBeingRobbed", function()
    return PlayerState["IsBeingRobbed"]
end)

exports("HasPlayerHandsUp", function()
    return PlayerState["HasHandsUp"]
end)

RegisterNetEvent('lorp_robbing:client:reset')
AddEventHandler('lorp_robbing:client:reset', function()
    PlayerState["IsStealing"] = false
    TargetPed = nil
    ClearPedTasks(cache.ped)
    lib.hideContext(false)
    lib.closeInputDialog()
end)

local stolenItems = {}

RegisterNetEvent('lorp_robbing:client:setupMenu')
AddEventHandler('lorp_robbing:client:setupMenu', function(targetPedNetId, targetInventory)
    TargetPed = NetworkGetEntityFromNetworkId(targetPedNetId)

    if not PlayerState["IsStealing"] then
        PlayerState["IsStealing"] = true
        TaskAimGunAtEntity(cache.ped, TargetPed, -1, true)
    end

    local serverId = GetPlayerServerId(PlayerId())

    if lib.getOpenContextMenu() then
        if lib.getOpenContextMenu() == 'thief_'..serverId..'' then
            lib.hideContext(false)
        end
    end

    local TargetStealableItems = {}

    for _,v in pairs(targetInventory) do
        if v.amount ~= 0 and not stolenItems[v.item] then
            local itemLabel = v.label

            if not itemLabel then itemLabel = v.item end

            local itemTitle = "x" ..v.amount.. " " ..itemLabel
            local hasAmountSelection = true

            TargetStealableItems[#TargetStealableItems + 1] = {
                title = itemTitle,
                icon = Config.Menu["IconsPath"].."/"..v.item..".png",
                arrow = hasAmountSelection,
                onSelect = function()
                    local input = lib.inputDialog(Config.Menu["DialogTitle"], {
                        {type = 'input', label = Config.Menu["InputItemTitle"], default = v.label, disabled = true},
                        {type = 'number', label = Config.Menu["InputAmountTitle"], description = Config.Menu["InputAmountDescription"], required = true, min = 1, max = v.amount}
                    })

                    if not input then 
                        lib.registerContext({
                            id = 'thief_'..serverId..'',
                            title = Config.Menu["Title"],
                            options = TargetStealableItems,
                            onExit = function()
                                stolenItems = {}
                                TriggerServerEvent('lorp_robbing:server:stopRobbery')
                                lib.closeInputDialog()
                            end
                        })

                        lib.showContext('thief_'..serverId..'')
                        return
                    end

                    stolenItems[v.item] = v.amount

                    TriggerServerEvent('lorp_robbing:server:steal', v.item, input[2], v.data)
                end
            }
        end
    end

    if #TargetStealableItems == 0 then
        TargetStealableItems[#TargetStealableItems + 1] = {
            title = 'No Items',
            icon = 'xmark',
            readOnly = true
        }
    end

    lib.registerContext({
        id = 'thief_'..serverId..'',
        title = Config.Menu["Title"],
        options = TargetStealableItems,
        onExit = function()
            stolenItems = {}
            TriggerServerEvent('lorp_robbing:server:stopRobbery')
            lib.closeInputDialog()
        end
    })

    lib.showContext('thief_'..serverId..'')
end)

RegisterNetEvent('lorp_robbing:client:confirmState')
AddEventHandler('lorp_robbing:client:confirmState', function(state)
    local clientState = PlayerState["HasHandsUp"]

    if state ~= clientState then
        TriggerServerEvent('lorp_robbing:server:state', clientState)
    end
end)

RegisterNetEvent('lorp_robbing:client:updateState')
AddEventHandler('lorp_robbing:client:updateState', function(isBeingRobbed, thiefPed)
    PlayerState["IsBeingRobbed"] = isBeingRobbed
    if isBeingRobbed then
        MakeEntityFaceEntity(cache.ped, NetworkGetEntityFromNetworkId(thiefPed))
    else
        StopHandsUpState()
    end
    Config.Functions.IsBeingRobbed(isBeingRobbed)
end)

RegisterNetEvent('lorp_robbing:client:updateStatus')
AddEventHandler('lorp_robbing:client:updateStatus', function()
    TaskPlayAnim(cache.ped, Config.Animation["Dictionary"], Config.Animation["Name"], Config.Animation["BlendInSpeed"], Config.Animation["BlendOutSpeed"], -1, 50, 0, false, false, false)
    PlayerState["HasHandsUp"] = true
    TriggerServerEvent('lorp_robbing:server:state', true)
    LocalPlayer.state.invBusy = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local ped = cache.ped

        if IsEntityDead(ped) then
            if PlayerState["IsStealing"] then
                TriggerServerEvent('lorp_robbing:server:cancelRobbery')
                lib.hideContext(false)
                lib.closeInputDialog()
            elseif PlayerState["HasHandsUp"] then
                StopHandsUpState()
            elseif PlayerState["IsBeingRobbed"] then
                TriggerServerEvent('lorp_robbing:server:cancelRobbery')
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if PlayerState["HandsUp"] then
            if not IsEntityPlayingAnim(cache.ped, Config.Animation["Dictionary"], Config.Animation["Name"], 3) then
                StopHandsUpState()
                if PlayerState["IsBeingRobbed"] then
                    TriggerServerEvent('lorp_robbing:server:cancelRobbery')
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if PlayerState["IsStealing"] then

            local myCoords = GetEntityCoords(cache.ped)

            if not DoesEntityExist(TargetPed) then TriggerServerEvent('lorp_robbing:server:cancelRobbery') lib.hideContext(false) lib.closeInputDialog() end

            local targetCoords = GetEntityCoords(TargetPed)

            if (#(myCoords - targetCoords) > Config.Settings["MaxDistance"]) then TriggerServerEvent('lorp_robbing:server:cancelRobbery') lib.hideContext(false) lib.closeInputDialog() end
        else
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if PlayerState["IsBeingRobbed"] then
            DisableAllControlActions(0)
            DisablePlayerFiring(PlayerId(), true)
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if InputCooldowns["Thief"] >= 1 then
            InputCooldowns["Thief"] = InputCooldowns["Thief"] - 1
        end
        if InputCooldowns["HandsUp"] >= 1 then
            InputCooldowns["HandsUp"] = InputCooldowns["HandsUp"] - 1
        end
    end
end)

RegisterCommand('$handsup', function()
    local ped = cache.ped

    if InputCooldowns["HandsUp"] >= 1 then return end

    if IsPedInAnyVehicle(ped, true) then return end

    if PlayerState["IsBeingRobbed"] then return end

    if not PlayerState["HasHandsUp"] then

        if IsEntityDead(ped) then return end

        if IsPedRunning(ped) then return end

        InputCooldowns["HandsUp"] = Config.InputCooldowns["HandsUp"]

        TriggerEvent('ox_inventory:disarm', true)

        LoadAnimDict(Config.Animation["Dictionary"])
        TaskPlayAnim(ped, Config.Animation["Dictionary"], Config.Animation["Name"], Config.Animation["BlendInSpeed"], Config.Animation["BlendOutSpeed"], -1, 50, 0, false, false, false)
        PlayerState["HasHandsUp"] = true
        TriggerServerEvent('lorp_robbing:server:state', true)
    else
        StopHandsUpState()
    end
end, false)

RegisterCommand('$thief', function()
    local ped = cache.ped

    if InputCooldowns["Thief"] >= 1 then return end

    if IsPedInAnyVehicle(ped, true) then return end

    if not PlayerState["IsStealing"] then

        if IsEntityDead(ped) then return end

        InputCooldowns["Thief"] = Config.InputCooldowns["Thief"]

        if Config.Functions.CanPlayerSteal(ped) then
            TriggerServerEvent('lorp_robbing:server:request')
        end
    else
        lib.hideContext(true)
    end
end, false)

RegisterKeyMapping('$handsup', 'Hands Up', 'keyboard', Config.Keybinds["HandsUp"])
RegisterKeyMapping('$thief', 'Thief', 'keyboard', Config.Keybinds["Thief"])

local function IsPedFacingPedAlternative(pedA, pedB, threshold)
    threshold = threshold or 0.7

    local posA = GetEntityCoords(pedA)
    local posB = GetEntityCoords(pedB)

    local forwardA = GetEntityForwardVector(pedA)
    local forwardB = GetEntityForwardVector(pedB)

    local dirAToB = posB - posA
    local dirBToA = posA - posB

    local lenA = #(dirAToB)
    local lenB = #(dirBToA)

    if lenA == 0 or lenB == 0 then return false end

    dirAToB = dirAToB / lenA
    dirBToA = dirBToA / lenB

    local dotA = forwardA.x * dirAToB.x + forwardA.y * dirAToB.y + forwardA.z * dirAToB.z
    local dotB = forwardB.x * dirBToA.x + forwardB.y * dirBToA.y + forwardB.z * dirBToA.z

    return dotA >= threshold and dotB >= threshold
end

CreateThread(function()
    exports.ox_target:addGlobalPlayer({
        label = 'Rob Player',
        name = 'player:rob',
        icon = 'gun',
        distance = 2.0,
        onSelect = function()
            local ped = cache.ped

            if InputCooldowns["Thief"] >= 1 then return end

            if IsPedInAnyVehicle(ped, true) then return end

            if not PlayerState["IsStealing"] then
                InputCooldowns["Thief"] = Config.InputCooldowns["Thief"]

                if Config.Functions.CanPlayerSteal(ped) then
                    TriggerServerEvent('lorp_robbing:server:request')
                end
            else
                lib.hideContext(true)
            end
        end,
        canInteract = function(entity)
            return Config.Functions.CanPlayerSteal(cache.ped) and not PlayerState["IsStealing"] and IsPedFacingPedAlternative(cache.ped, entity, 0.75)
        end
    })
end)