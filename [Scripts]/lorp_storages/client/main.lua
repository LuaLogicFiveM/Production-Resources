local storageOpen = false
local ox_target = exports.ox_target

local function ShowStorageManagementUI()
    SendNUIMessage({ action = 'showUI' })
    Wait(50)
    Framework.TriggerCallback('lorp_storage:server:getStorageUnits', function(storageUnits, error)
        if error then
            SendNUIMessage({ action = 'showError', message = error })
            return
        end
        storageOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openManagementUI',
            data = {
                storageUnits = storageUnits
            }
        })
    end)
end

CreateThread(function()
    for i, location in ipairs(Config.StorageLocations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, Config.Blip.sprite)
        SetBlipDisplay(blip, Config.Blip.display)
        SetBlipScale(blip, Config.Blip.scale)
        SetBlipColour(blip, Config.Blip.colour)
        SetBlipAsShortRange(blip, Config.Blip.shortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.name)
        EndTextCommandSetBlipName(blip)
    end

    for i, location in ipairs(Config.StorageLocations) do
        ox_target:addBoxZone({
            coords = vec3(location.x, location.y, location.z),
            size = vec3(2, 2, 3),
            rotation = location.w,
            debug = false,
            options = {
                {
                    name = 'storage_access_' .. i,
                    icon = Config.Target.icon,
                    label = Config.Target.label,
                    onSelect = function()
                        ShowStorageManagementUI()
                    end
                }
            }
        })
    end
end)

local function ShowPurchaseUI()
    SendNUIMessage({ action = 'showUI' })
    Wait(50)
    storageOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openPurchaseUI',
        data = {
            price = Config.StorageUnit.price,
            capacity = Config.UpgradeLevels[1].slots
        }
    })
end

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    storageOpen = false
    cb('ok')
end)

RegisterNUICallback('purchaseStorage', function(data, cb)
    TriggerServerEvent('lorp_storage:server:purchaseStorage', data.label, data.icon)
    cb('ok')
end)

RegisterNUICallback('openStorage', function(data, cb)
    SetNuiFocus(false, false)
    storageOpen = false
    SendNUIMessage({ action = 'forceCloseUI' })
    Wait(100)
    if not data.stashId then
        SendNUIMessage({
            action = 'showError',
            message = 'Storage ID is missing. Please try again.'
        })
        cb('error')
        return
    end
    TriggerServerEvent('lorp_storage:server:openStorage', data.stashId)
    cb('ok')
end)

RegisterNUICallback('renameStorage', function(data, cb)
    TriggerServerEvent('lorp_storage:server:renameStorage', data.stashId, data.newLabel)
    cb('ok')
end)

RegisterNUICallback('upgradeStorage', function(data, cb)
    TriggerServerEvent('lorp_storage:server:upgradeStorage', data.stashId)
    cb('ok')
end)

RegisterNUICallback('changeIcon', function(data, cb)
    TriggerServerEvent('lorp_storage:server:changeIcon', data.stashId, data.icon)
    cb('ok')
end)

RegisterNUICallback('shareAccess', function(data, cb)
    TriggerServerEvent('lorp_storage:server:shareAccess', data.stashId, data.playerId)
    cb('ok')
end)

RegisterNUICallback('removeAccess', function(data, cb)
    TriggerServerEvent('lorp_storage:server:removeAccess', data.stashId, data.identifier)
    cb('ok')
end)

RegisterNUICallback('getSharedAccess', function(data, cb)
    TriggerServerEvent('lorp_storage:server:getSharedAccess', data.stashId)
    cb('ok')
end)

RegisterNUICallback('openStorageManagement', function(data, cb)
    TriggerServerEvent('lorp_storage:server:openStorageManagement', data.stashId)
    cb('ok')
end)

RegisterNetEvent('lorp_storage:client:openStorageManagement')
AddEventHandler('lorp_storage:client:openStorageManagement', function(data)
    SendNUIMessage({
        action = 'showStorageManagement',
        data = data
    })
    SetNuiFocus(true, true)
    storageOpen = true
end)

RegisterNetEvent('lorp_storage:client:updateSharedAccess')
AddEventHandler('lorp_storage:client:updateSharedAccess', function(stashId, sharedAccess)
    SendNUIMessage({
        action = 'updateSharedAccess',
        data = {
            stashId = stashId,
            sharedAccess = sharedAccess
        }
    })
end)

RegisterNetEvent('lorp_storage:client:refreshStorageUI')
AddEventHandler('lorp_storage:client:refreshStorageUI', function()
    ShowStorageManagementUI()
end)

RegisterNUICallback('showPurchaseUI', function(data, cb)
    ShowPurchaseUI()
    cb('ok')
end)
