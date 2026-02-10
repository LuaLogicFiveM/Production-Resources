bridge = bridge or {}

local progressBarSystem = 'ox'

Citizen.CreateThread(function()
    Wait(500)
    if GetResourceState("progressbar") == "started" then
        if exports.progressbar and exports.progressbar.Progress then
            progressBarSystem = 'qb'
        end
    end
end)

function bridge.showProgress(options, onFinish, onCancel)
    --[[
            options = {
                duration = integer,
                title = string,
                animation = {
                    dict = string,
                    anim = string,
                    flag = integer
                }
                disable = {
                    move = bool,
                    car = bool,
                    combat = bool,
                }
            }
    ]]

    if progressBarSystem == 'qb' then
        exports.progressbar:Progress({
            name = options.title,
            duration = options.duration,
            label = options.title,
            useWhileDead = options.useWhileDead or false,
            canCancel = options.canCancel == nil and true or options.canCancel,
            animation = options.animation and {
                animDict = options.animation.dict,
                anim = options.animation.anim,
                flags = options.animation.flag or 49,
            } or nil,
            controlDisables = options.disable and {
                disableMovement = options.disable.move or false,
                disableCarMovement = options.disable.car or false,
                disableMouse = options.disable.mouse or false,
                disableCombat = options.disable.combat or false,
            } or nil,
            prop = options.prop,
            propTwo = options.propTwo,
        }, function(cancelled)
            if not cancelled then
                if onFinish then onFinish() end
            else
                if onCancel then onCancel() end
            end
        end)
    elseif progressBarSystem == 'ox' then
        local success = exports["ox_lib"]:progressBar({
            duration = options.duration,
            label = options.title,
            useWhileDead = options.useWhileDead or false,
            canCancel = options.canCancel == nil and true or options.canCancel,
            anim = options.animation and {
                dict = options.animation.dict,
                clip = options.animation.anim,
                flags = options.animation.flag
            } or nil,
            disable = options.disable or {},
            prop = options.prop,
        })

        if success then
            if onFinish then onFinish() end
        else
            if onCancel then onCancel() end
        end
    else
        print(
            '^1 FATAL ERROR: There is no compatible progress system, add your own system in plt_drugs/client/bridge/progressbar.lua^7')
        if onFinish then onFinish() end
    end
end
