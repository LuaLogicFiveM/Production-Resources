local notif = lib.load('config.shared').system.notification

TargetSystem = (GetResourceState('ox_target') == 'started' and 'ox') or 
    (GetResourceState('qb-target') == 'started' and 'qb') or 'custom'

---@param data table {msg: string, type: string, duration: number}
function Notification(data)
    if notif == 'ox' then
        lib.notify({
            type = data.type,
            title = data.msg,
            duration = data.duration
        })
    elseif notif == 'qb' then
        local notify = exports['qb-core']:GetCoreObject().Functions.Notify
        local type = data.type == 'info' and 'primary' or data.type

        notify(data.msg, type, data.duration)
    elseif notif == 'custom' then
        warn('You can add your own notification system in bridge/client/notif.lua - line 17')
    else
        warn('The notification system support only ox, qb or custom value. Please check your config/shared.lua file - line 4')
    end
end

RegisterNetEvent('patoche:wipeout:client:notif', Notification)

---@param data table {coords (vector3), size (vector3), debug (boolean), rotation (number), options (table {groups (table), onSelect (function), icon (string), label (string)}
function CustomTarget(data)
    -- EXAMPLE : 
    exports.ox_target:addBoxZone({
        coords = data.coords,
        size = data.size,
        debug = data.debug,
        rotation = data.rotation,
        options = data.options
    })
end

---@param zoneName string
function RemoveCustomTarget(zoneName)
    -- EXAMPLE :
    exports.ox_target:removeZone(zoneName)
end