function Notification(msg)
    lib.notify({
        title = 'Notification',
        description = msg
    })
end

RegisterNetEvent('cs:multijob:openUI', function()
    openUI()
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function()
    if CodeStudio.AllowAutoJobSavining then
        TriggerServerEvent("cs:multijob:checkForJob")
    end
end)

RegisterNetEvent("esx:setJob", function()
    if CodeStudio.AllowAutoJobSavining then
        TriggerServerEvent("cs:multijob:checkForJob")
    end
end)

RegisterNUICallback('toggleDuty', function(_, cb)
    if CodeStudio.ServerType == 'QB' then
        TriggerServerEvent('QBCore:ToggleDuty')
    else
        TriggerServerEvent('ESX:ToggleDuty:multijob')
    end
end)



function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict) Wait(5)
    end
end

function loadModel(model) 
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
end

function ExecuteAnimation(start)
    ClearPedTasks(cache.ped)

    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(cache.ped, v) then
            DeleteObject(v)
            DetachEntity(v, 0, 0)
            SetEntityAsMissionEntity(v, true, true)
            Wait(100)
            DeleteEntity(v)
        end
    end

    if start then
        local prop = `prop_cs_tablet`
        loadModel(prop)
        loadAnimDict('amb@code_human_in_bus_passenger_idles@female@tablet@base')
        local tabletObj = CreateObject(prop, GetEntityCoords(cache.ped), true, true, true)
        local tabletBoneIndex = GetPedBoneIndex(cache.ped, 60309)
        AttachEntityToEntity(tabletObj, cache.ped, tabletBoneIndex, 0.03, 0.002, -0.0, 10.0, 160.0, 0.0, true, false, false, false, 2, true)
        TaskPlayAnim(cache.ped, 'amb@code_human_in_bus_passenger_idles@female@tablet@base', 'base', 5.0, 5.0, -1, 51, 0, false, false, false)
    else
        if IsEntityPlayingAnim(cache.ped, "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 3) then
            ClearPedTasks(cache.ped)
        end
    end
end

if CodeStudio.OpenUI.LocationBased then
    CreateThread(function()
        local hash = CodeStudio.OpenUI.TargetPed
        loadModel(hash)
        local coords = CodeStudio.OpenUI.Location
        local NPC = CreatePed(5, hash, coords.x, coords.y, coords.z, coords.w, false, false)
        FreezeEntityPosition(NPC, true)
        SetEntityInvincible(NPC, true)
        SetBlockingOfNonTemporaryEvents(NPC, true)
        SetModelAsNoLongerNeeded(hash)
        TaskStartScenarioInPlace(NPC,'WORLD_HUMAN_STAND_MOBILE')
        if CodeStudio.OpenUI.Target ~= 'ox_target' then
            local option = { 
                {
                    action = function()
                        openUI()
                    end,
                    icon = "fas fa-circle",
                    label = CodeStudio.Language.target_label
                }
            }
            exports[CodeStudio.OpenUI.Target]:AddEntityZone('MultiJobNPC', NPC, {
                name="MultiJobNPC",
                useZ = true
            }, {
                options = option,
                distance = 2.5
            })
        elseif CodeStudio.OpenUI.Target == 'ox_target' then
            local option = { 
                {
                    onSelect = function()
                        openUI()
                    end,
                    icon = "fas fa-circle",
                    label = CodeStudio.Language.target_label
                }
            }
            exports.ox_target:addLocalEntity(NPC, option)
        end
    end)
end

if CodeStudio.OpenUI.OpenWithCommand then
    RegisterCommand(CodeStudio.OpenUI.OpenCommandName, function()
        TriggerEvent('cs:multijob:openUI')
    end)
    if CodeStudio.OpenUI.OpenWithKey then
        RegisterKeyMapping(CodeStudio.OpenUI.OpenCommandName, CodeStudio.Language.keybinds_text , 'keyboard', CodeStudio.OpenUI.DefaultOpenKey)
    end
end
