local bussy = false

local lumihud = GetResourceState("tgiann-lumihud") ~= "missing"
local tgiannProgressbar = GetResourceState("tgiann-progressbar") ~= "missing"

tgiCore.Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if bussy then
        Notify("alreadyError", "error")
        if onCancel then onCancel() end
        return false
    end

    bussy = true

    if lumihud then
        local success = exports['tgiann-lumihud']:Progress({
            name = name:lower(),
            duration = duration,
            label = label,
            useWhileDead = useWhileDead,
            canCancel = canCancel,
            controlDisables = disableControls,
            animation = animation and animation or {},
            prop = prop and prop or {},
            propTwo = propTwo and propTwo or {},
        })
        bussy = false
        if success then
            if onFinish then onFinish() end
        else
            if onCancel then onCancel() end
        end
        return success
    elseif tgiannProgressbar then
        local p = promise.new()
        exports['tgiann-progressbar']:Progress({
            name = name:lower(),
            duration = duration,
            label = label,
            useWhileDead = useWhileDead,
            canCancel = canCancel,
            controlDisables = disableControls,
            animation = animation and animation or {},
            prop = prop and prop or {},
            propTwo = propTwo and propTwo or {},
        }, function(cancelled)
            if not cancelled then
                p:resolve(true)
            else
                p:resolve(false)
            end
        end)
        local success = Citizen.Await(p)
        bussy = false
        if success then
            if onFinish then onFinish() end
        else
            if onCancel then onCancel() end
        end
        return success
    elseif config.framework == "qb" and not config.qbx then -- QB Framework
        local p = promise.new()
        tgiCore.core.Functions.Progressbar(
            name:lower(),
            label,
            duration,
            useWhileDead,
            canCancel,
            disableControls,
            animation or {},
            prop or {},
            propTwo or {},
            function()
                p:resolve(true)
            end,
            function()
                p:resolve(false)
            end)

        local success = Citizen.Await(p)

        bussy = false
        if success then
            if onFinish then onFinish() end
        else
            if onCancel then onCancel() end
        end
        return success
    else
        local success = lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = useWhileDead,
            canCancel = canCancel,
            disable = {
                car = disableControls.disableCarMovement,
                move = disableControls.disableMovement,
                combat = disableControls.disableCombat,
                mouse = disableControls.disableMouse,
            },
            anim = animation and {
                dict = animation.animDict,
                clip = animation.anim,
                flag = animation.flags
            },
            prop = prop and {
                model = prop.model,
                pos = prop.coords,
                rot = prop.rotation,
                bone = prop.bone
            },
        })
        bussy = false
        if success then
            if onFinish then onFinish() end
        else
            if onCancel then onCancel() end
        end
        return success
    end
end
