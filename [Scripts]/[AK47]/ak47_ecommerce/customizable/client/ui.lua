Notify = function(msg, type, duration)
    lib.notify({
        type = type or 'info',
        description = msg,
        position = 'top',
        duration = duration
    })
end

ShowProgress = function(progressData, success, cancel)
    if lib.progressCircle({
        label = progressData.label,
        position = progressData.position,
        duration = progressData.duration,
        disable = progressData.disable,
        canCancel = progressData.canCancel,
        prop = progressData.prop,
        anim = progressData.anim,
    }) then
        if success then
            success()
        end
    else
        if cancel then
            cancel()
        end
    end
end

CancelProgress = function()
    if lib.progressActive() then
        lib.cancelProgress()
    end
end