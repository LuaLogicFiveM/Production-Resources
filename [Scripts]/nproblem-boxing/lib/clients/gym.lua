if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']

if NMConfig['Framework'] == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif NMConfig['Framework'] == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end
local framework = NMConfig['Framework']
local inCooldown = false

RegisterNetEvent('nm_boxing_createGymTargets', function()
    if NMConfig['GYM']['isAllowedToUseGymMachines'] then
        createGymTargets()
    end
end)

function skillBar()
    if NMConfig['GYM']['useSkillBar'] then
        local success = lib.skillCheck({'easy','easy','easy', 'easy','easy','easy','easy', {areaSize = 50, speedMultiplier = 1}, 'easy'}, {'w', 'a', 's', 'd'})
        return success
    else
        return true
    end
end

function makeAnim(tip, data)
    if inCooldown then TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymCooldown', 'error', 5000) return end
    if tip == 'bench' then
        SetEntityCoords(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), data.plyCoord.x, data.plyCoord.y, data.plyCoord.z, 0, 0, 0, true)
        SetEntityHeading(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), data.plyHeading)
        exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), true)
        local hash = GetHashKey("prop_barbell_100kg")
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
            RequestModel(hash)
        end
        local benchProp = CreateObject(hash, exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()), true, true, true)
        AttachEntityToEntity(benchProp, exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), GetPedBoneIndex(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), 57005), 0.17, 0.33, 0.0, -43.0, -43.0, -103.0, true, true, false, false, 1, true)
        local animDict = "amb@prop_human_seat_muscle_bench_press@idle_a"
        local animName = "idle_a"

        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Wait(100)
        end
        TaskPlayAnim(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), animDict, animName, 8.0, 8.0, -1, 0, 0.0, false, false, false)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                local duration = GetAnimDuration(animDict, animName)
                local waitTime = math.floor(duration * 1000)
        
                Wait(waitTime)
            end
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            DeleteObject(benchProp)
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymBenchFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            DeleteObject(benchProp)
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            setCooldown()
        end
    elseif tip == 'cardio' then
        SetEntityCoords(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), data.plyCoord.x, data.plyCoord.y, data.plyCoord.z, 0, 0, 0, true)
        SetEntityHeading(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), data.plyHeading)
        exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), true)

        TaskStartScenarioAtPosition(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', data.plyCoord.x, data.plyCoord.y, data.plyCoord.z, data.plyHeading, 100000, 0, true, true)
        local animDict = "amb@world_human_jog_standing@male@idle_a"
        local animName = "idle_a"
        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Wait(100)
        end
        TaskPlayAnim(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), animDict, animName, 8.0, 8.0, -1, 49, 0.0, false, false, false)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                local duration = GetAnimDuration(animDict, animName)
                local waitTime = math.floor(duration * 1000)
        
                Wait(waitTime)
            end
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymCardioFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            setCooldown()
        end
    elseif tip == 'pullup' then
        SetEntityCoords(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), data.plyCoord.x, data.plyCoord.y, data.plyCoord.z, 0, 0, 0, true)
        SetEntityHeading(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), data.plyHeading)
        exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), true)

        TaskStartScenarioInPlace(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), "prop_human_muscle_chin_ups", 0, true)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                Wait(10000)
            end
            Wait(4000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymPullUpFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            setCooldown()
        end
    elseif tip == 'situp' then
        exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), true)

        TaskStartScenarioInPlace(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), "world_human_sit_ups", 0, true)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                Wait(10000)
            end
            Wait(4000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymSitUpFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            setCooldown()
        end
    elseif tip == 'onehandcurl' then
        local animDict = "amb@world_human_muscle_free_weights@male@barbell@base"
        local animName = "base"

        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Wait(100)
        end
        local hash = GetHashKey("prop_barbell_01")
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
            RequestModel(hash)
        end
        local firstDumbell = CreateObject(hash, exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()), true, true, true)
        local secondDumbell = CreateObject(hash, exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()), true, true, true)
        AttachEntityToEntity(firstDumbell, exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), GetPedBoneIndex(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), 57005), 0.1, 0.0, 0.0, 288.0, 70.0, -36.0, true, true, false, false, 1, true)
        AttachEntityToEntity(secondDumbell, exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), GetPedBoneIndex(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), 18905), 0.1, 0.0, 0.0, 267.0, 91.0, -134.0, true, true, false, false, 1, true)
        Wait(500)
        TaskPlayAnim(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), animDict, animName, 8.0, 8.0, 25000, 0, 0.0, false, false, false)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                local duration = GetAnimDuration(animDict, animName)
                local waitTime = math.floor(duration * 1000)
        
                Wait(waitTime)
            end
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            DeleteObject(firstDumbell)
            DeleteObject(secondDumbell)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymOneHandCurlFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            DeleteObject(firstDumbell)
            DeleteObject(secondDumbell)
            setCooldown()
        end
    elseif tip == 'barbellcurl' then
        local animDict = "amb@world_human_muscle_free_weights@male@barbell@base"
        local animName = "base"

        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Wait(100)
        end
        local hash = GetHashKey("prop_curl_bar_01")
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, exports['nproblem-boxing']:G6DdW88AyHiyx2HlD3Nxb3b1Yano8kzG(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk()), true, true, true)
        AttachEntityToEntity(prop, exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), GetPedBoneIndex(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), 18905), 0.1, -0.1, 0.2, 90.0, 90.0, 30.0, true, true, false, false, 1, true)
        TaskPlayAnim(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), animDict, animName, 8.0, 8.0, -1, 0, 0.0, false, false, false)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                local duration = GetAnimDuration(animDict, animName)
                local waitTime = math.floor(duration * 1000)
        
                Wait(waitTime)
            end
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            DeleteObject(prop)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymBarbellCurlFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            DeleteObject(prop)
            setCooldown()
        end
    elseif tip == 'pushup' then
        exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), true)

        TaskStartScenarioInPlace(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), "world_human_push_ups", 0, true)
        local skillBar = skillBar()
        if skillBar then
            if not NMConfig['GYM']['useSkillBar'] then
                Wait(10000)
            end
            Wait(4000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'information', 'gymAfterWorkout', 'success', 5000)
            TriggerServerEvent('nm_boxing_addStamina')
            setCooldown()
        else
            TriggerEvent('nproblem_boxing_showNotifyToPlayer', 'warning', 'gymPushUpFail', 'error', 5000)
            exports['nproblem-boxing']:kONVYbPhE2SOEnqyXWHQLWBmkQxk9pEj(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk())
            exports['nproblem-boxing']:iGV1hK3W9E4OoqoV85VQhZUmopIRhY0T(exports['nproblem-boxing']:U3winWYxgo5IPZVVK5O8fZT8brQyIPAk(), false)
            setCooldown()
        end
    end
end

function setCooldown()
    inCooldown = true
    Wait(math.random(10000,25000))
    inCooldown = false
end

function createGymTargets()
    local categories = {
        { 
            key = 'Benches', 
            labelPrefix = 'Bench', 
            animKey = 'bench', 
            coordsKey = 'targetCoord' 
        },
        { 
            key = 'Cardios', 
            labelPrefix = 'Cardio', 
            animKey = 'cardio', 
            coordsKey = 'targetCoord' 
        },
        { 
            key = 'Pullups', 
            labelPrefix = 'Pull Up', 
            animKey = 'pullup', 
            coordsKey = 'targetCoord' 
        },
        { 
            key = 'Situps', 
            labelPrefix = 'Sit Up', 
            animKey = 'situp' 
        },
        { 
            key = 'OneHandCurl', 
            labelPrefix = 'One Hand Curl', 
            animKey = 'onehandcurl' 
        },
        { 
            key = 'BarbellCurl', 
            labelPrefix = 'Barbell Curl', 
            animKey = 'barbellcurl' 
        },
        { 
            key = 'Pushups', 
            labelPrefix = 'Pushup', 
            animKey = 'pushup' 
        }
    }

    for _, cat in ipairs(categories) do
        local list = NMConfig['GYM'][cat.key]
        for i = 1, #list do
            local targetName = string.lower(cat.labelPrefix:gsub(" ", "")) .. i
            local coords = cat.coordsKey and list[i][cat.coordsKey] or list[i]
            local label = cat.labelPrefix
            local animKey = cat.animKey

            if NMConfig['Target']['targetType'] == 'qb' then
                exports['qb-target']:AddCircleZone(targetName, coords, 1.5, {
                    name = targetName, 
                    useZ = true, 
                    debugPoly = false,
                }, {
                    options = {
                        {
                            icon = "fa-solid fa-dumbbell",
                            label = label,
                            action = function()
                                makeAnim(animKey, list[i])
                            end,
                        },
                    },
                    distance = 2
                })
            elseif NMConfig['Target']['targetType'] == 'ox' then
                exports.ox_target:addSphereZone({
                    coords = coords,
                    name = targetName,
                    radius = 1.5,
                    debug = false,
                    drawSprite = true,
                    options = {
                        {
                            icon = "fa-solid fa-dumbbell",
                            label = label,
                            onSelect = function()
                                makeAnim(animKey, list[i])
                            end,
                        },
                    }
                })
            end
        end
    end
end
