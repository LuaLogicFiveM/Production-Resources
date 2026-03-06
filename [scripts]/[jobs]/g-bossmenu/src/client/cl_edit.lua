-- Notifications
local Notification = Config.SystemSettings.Notify
Notify = function(message, type, duration)
    if not type then
        type = "success"
    end
    if not duration then
        duration = 5000
    end

    if Notification == "esx" then
        ESX.ShowNotification(message)
    elseif Notification == "okok" then
        exports.okokNotify:Alert(type, message, duration, type, false)
    elseif Notification == "qbcore" then
        if type == "info" then
            type = "primary"
        end
        QBCore.Functions.Notify(message, type, duration)
    elseif Notification == "ox_lib" then
        exports["ox_lib"]:notify({
            title = "Notification",
            description = message,
            type = type,
            duration = duration,
            position = "top-right"
        })
    elseif Notification == "17mov" then
        exports["17mov_Hud"]:ShowNotification(message, type, "Notification", duration)
    elseif Notification == "standalone" then
        AddTextEntry("g_bridge", message)
        BeginTextCommandThefeedPost("g_bridge")
        EndTextCommandThefeedPostTicker(false, true)
    elseif Notification == "g-notifications" then
        exports["g-notifications"]:Notify({
            title = "Notification",
            description = message,
            type = type,
            duration = duration,
            position = "top-right"
        })
    else
        print("Notification type not found")
    end
end

RegisterNetEvent("justgroot:g-bossmenu:notify", function(message, type, duration)
    Notify(message, type, duration)
end)

-- TextUI
local TextUi = Config.TextUI
function TextUiShow(message)
    if not message then
        return
    end
    if TextUi == "okok" then
        exports.okokTextUI:Open(message, "darkblue", "right")
    elseif TextUi == "ox_lib" then
        exports["ox_lib"]:showTextUI(message)
    elseif TextUi == "esx" then
        ---@diagnostic disable-next-line: missing-parameter
        ESX.ShowHelpNotification(message)
    elseif TextUi == "qbcore" then
        exports["qb-core"]:DrawText(message, "right")
    end
end

function TextUiNewHide()
    if TextUi == "okok" then
        exports.okokTextUI:Close()
    elseif TextUi == "qbcore" then
        exports["qb-core"]:HideText()
    elseif TextUi == "ox_lib" then
        exports["ox_lib"]:hideTextUI()
    end
end

-- Do not touch if you don't know what you're doing.
-- open paycheck user logic
CreateThread(function()
    local bossmenu = Config.Menu.BossMenu

    if bossmenu then
        -- bossmenu
        for jobName, jobConfig in pairs(bossmenu) do
            if jobConfig.coords then
                for i, coords in pairs(jobConfig.coords) do
                    if Config.SystemSettings.OpenMenuVia == "target" then
                        Target.AddTargetBoxZone(
                            "bossmenu_" .. tostring(i),
                            vector3(coords.x, coords.y, coords.z - 0.5),
                            2.0,
                            coords.w,
                            {
                                {
                                    name = "bossmenu_" .. tostring(i),
                                    icon = Config.Icons.bossTargetIcon,
                                    label = LAN("open_bossmenu"),
                                    onSelect = function()
                                        TriggerEvent("justgroot:g-bossmenu:open:menu:bosmenu", jobName, i)
                                    end,
                                },
                            },
                            Config.SystemSettings.Debug
                        )
                    elseif Config.SystemSettings.OpenMenuVia == "textui" then
                        SetupInteractionZone(
                            { coords.x, coords.y, coords.z },
                            LAN("open_bossmenu"),
                            "justgroot:g-bossmenu:open:menu:bosmenu",
                            jobName,
                            i
                        )
                    end
                end
            end
        end

        -- jobApplication
        for jobName, jobConfig in pairs(bossmenu) do
            local pages = jobConfig.pages
            local jobApplicationEnabledInPages = true

            if pages and pages.enable_job_application == false then
                jobApplicationEnabledInPages = false
            end

            if not jobApplicationEnabledInPages then
                goto continue_jobapp
            end

            if not jobConfig.JobApplication or not jobConfig.JobApplication.enabled then
                goto continue_jobapp
            end
            if jobConfig.JobApplication and jobConfig.JobApplication.coords then
                for i, coords in pairs(jobConfig.JobApplication.coords) do
                    if Config.SystemSettings.OpenMenuVia == "target" then
                        Target.AddTargetBoxZone(
                            "jobapplication_" .. tostring(i),
                            vector3(coords.x, coords.y, coords.z - 0.5),
                            2.0,
                            coords.w,
                            {
                                {
                                    name = "jobapplication_" .. tostring(i),
                                    icon = Config.Icons.jobApplicationTargetIcon,
                                    label = LAN("open_jobapplication"),
                                    onSelect = function()
                                        TriggerEvent("justgroot:g-bossmenu:open:menu:jobapplication", jobName, i)
                                    end,
                                },
                            },
                            Config.SystemSettings.Debug
                        )
                    elseif Config.SystemSettings.OpenMenuVia == "textui" then
                        SetupInteractionZone(
                            { coords.x, coords.y, coords.z },
                            LAN("open_jobapplication"),
                            "justgroot:g-bossmenu:open:menu:jobapplication",
                            jobName,
                            i
                        )
                    end
                end
            end
            ::continue_jobapp::
        end

        -- vehicleShop
        for jobName, jobConfig in pairs(bossmenu) do
            local pages = jobConfig.pages
            local vehicleManagementEnabledInPages = true

            if pages and pages.enable_vehicle_management == false then
                vehicleManagementEnabledInPages = false
            end

            if not vehicleManagementEnabledInPages then
                goto continue_vs
            end

            if not jobConfig.vehicleShop or not jobConfig.vehicleShop.enable or not jobConfig.vehicleShop.vehicleMenu then
                goto continue_vs
            end

            local vehicleMenu = jobConfig.vehicleShop.vehicleMenu
            if not vehicleMenu.coords or type(vehicleMenu.coords) ~= "table" then
                goto continue_vs
            end

            for i, coords in pairs(vehicleMenu.coords) do
                if not coords then
                    goto next_vs_coord
                end

                local x, y, z, w = coords.x or coords[1], coords.y or coords[2], coords.z or coords[3], coords.w or coords[4] or 0.0
                if not x or not y or not z then
                    goto next_vs_coord
                end

                if Config.SystemSettings.OpenMenuVia == "target" then
                    Target.AddTargetBoxZone(
                        "vehicleShop_" .. tostring(i),
                        vector3(x, y, z - 0.5),
                        2.0,
                        w,
                        {
                            {
                                name = "vehicleShop_" .. tostring(i),
                                icon = Config.Icons.vehicleShopTargetIcon,
                                label = LAN("open_vehicleShop"),
                                onSelect = function()
                                    TriggerEvent("justgroot:g-bossmenu:open:menu:vehicleShop", jobName, i)
                                end,
                            },
                        },
                        Config.SystemSettings.Debug
                    )
                elseif Config.SystemSettings.OpenMenuVia == "textui" then
                    SetupInteractionZone(
                        { x, y, z },
                        LAN("open_vehicleShop"),
                        "justgroot:g-bossmenu:open:menu:vehicleShop",
                        jobName,
                        i
                    )
                end

                ::next_vs_coord::
            end

            ::continue_vs::
        end
    end
end)


-- Creating peds
local SpawnedPeds = {}

local function DeleteAllSpawnedPeds()
    for i = 1, #SpawnedPeds do
        local ped = SpawnedPeds[i]
        if ped and DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    SpawnedPeds = {}
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteAllSpawnedPeds()
    end
end)

CreateThread(function()
    DeleteAllSpawnedPeds()

    Wait(100)

    local bossmenu = Config.Menu.BossMenu
    if not bossmenu then
        return
    end

    for jobName, jobConfig in pairs(bossmenu) do
        if not jobConfig then
            goto continue
        end

        local pages = jobConfig.pages
        if pages and pages.enable_job_application == false then
            goto continue
        end

        if not jobConfig.JobApplication then
            goto continue
        end
        if not jobConfig.JobApplication.enabled then
            goto continue
        end

        local jobApp = jobConfig.JobApplication

        if not jobApp.ped or jobApp.ped.enable ~= true then
            goto continue
        end

        local pedModel = jobApp.ped.model
        if not pedModel then
            goto continue
        end

        if not jobApp.coords or type(jobApp.coords) ~= "table" or #jobApp.coords == 0 then
            goto continue
        end

        local pedModelHash = RRequestModel(pedModel, 20000)
        if not pedModelHash then
            if Config.SystemSettings.Debug then
                print(("^3[g-bossmenu]^7 Failed to load ped model '%s' (hash: %d) for job '%s'"):format(
                    tostring(pedModel), joaat(pedModel), tostring(jobName)))
            end
            goto continue
        end

        for _, coord in pairs(jobApp.coords) do
            if not coord then
                goto next_coord
            end

            local x, y, z, w = coord.x or coord[1], coord.y or coord[2], coord.z or coord[3], coord.w or coord[4] or 0.0

            if not x or not y or not z then
                goto next_coord
            end

            local ped = CreatePed(4, pedModelHash, x, y, z - 1.0, w, false, true)
            if not ped or ped == 0 or not DoesEntityExist(ped) then
                goto next_coord
            end

            SpawnedPeds[#SpawnedPeds + 1] = ped

            SetEntityHeading(ped, w)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedCanBeTargetted(ped, false)
            SetPedFleeAttributes(ped, 0, false)
            SetPedDiesWhenInjured(ped, false)
            SetPedKeepTask(ped, true)

            if jobApp.ped.scenario and type(jobApp.ped.scenario) == "string" then
                TaskStartScenarioInPlace(ped, jobApp.ped.scenario, 0, true)
            end

            Wait(100)

            ::next_coord::
        end

        SetModelAsNoLongerNeeded(pedModelHash)

        ::continue::
    end

    -- vehicleShop ped spawns
    for jobName, jobConfig in pairs(bossmenu) do
        if not jobConfig then
            goto continue_vs
        end

        local pages = jobConfig.pages
        if pages and pages.enable_vehicle_management == false then
            goto continue_vs
        end

        if not jobConfig.vehicleShop or not jobConfig.vehicleShop.enable or not jobConfig.vehicleShop.vehicleMenu then
            goto continue_vs
        end

        local vehicleMenu = jobConfig.vehicleShop.vehicleMenu
        if not vehicleMenu.ped or vehicleMenu.ped.spawn ~= true then
            goto continue_vs
        end

        if not vehicleMenu.coords or type(vehicleMenu.coords) ~= "table" or #vehicleMenu.coords == 0 then
            goto continue_vs
        end

        local vsPedModel = vehicleMenu.ped.model
        if not vsPedModel then
            goto continue_vs
        end

        local vsPedModelHash = RRequestModel(vsPedModel, 20000)
        if not vsPedModelHash then
            if Config.SystemSettings.Debug then
                print(("^3[g-bossmenu]^7 Failed to load vehicleShop ped model '%s' (hash: %d) for job '%s'"):format(
                    tostring(vsPedModel), joaat(vsPedModel), tostring(jobName)))
            end
            goto continue_vs
        end

        for i, coords in pairs(vehicleMenu.coords) do
            if not coords then
                goto next_coord_vs
            end

            local x, y, z, w = coords.x or coords[1], coords.y or coords[2], coords.z or coords[3],
                coords.w or coords[4] or 0.0
            if not x or not y or not z then
                goto next_coord_vs
            end

            local ped = CreatePed(4, vsPedModelHash, x, y, z - 1.0, w, false, true)
            if not ped or ped == 0 or not DoesEntityExist(ped) then
                goto next_coord_vs
            end

            SpawnedPeds[#SpawnedPeds + 1] = ped

            SetEntityHeading(ped, w)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedCanBeTargetted(ped, false)
            SetPedFleeAttributes(ped, 0, false)
            SetPedDiesWhenInjured(ped, false)
            SetPedKeepTask(ped, true)

            if vehicleMenu.ped.scenario and type(vehicleMenu.ped.scenario) == "string" then
                TaskStartScenarioInPlace(ped, vehicleMenu.ped.scenario, 0, true)
            end

            Wait(100)
            ::next_coord_vs::
        end

        SetModelAsNoLongerNeeded(vsPedModelHash)
        ::continue_vs::
    end
end)
