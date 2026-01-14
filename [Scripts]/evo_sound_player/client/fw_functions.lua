-- These functions are specific to framework used in config.
-- If you want to use custom implementation or own framework,
-- set Config.framework to 'Standalone'


function OnBoomboxEntityCreated(entity) 
    if entity ~= nil then
        if Framework == 'QBCore' then
            exports['qb-target']:AddTargetEntity(entity, {
                options = {
                    {
                        num = 1,
                        type = "client",
                        event = "EVO:evo_sound_player:client:playBoombox",
                        icon = "fas fa-play",
                        label = "Open Menu",
                        args = { entity = entity }
                    },
                    {
                        num = 2,
                        type = "client",
                        event = "EVO:evo_sound_player:client:pickupBoombox",
                        icon = "fas fa-hand-paper",
                        label = "Grab Boombox",
                        args = { entity = entity, save = false }
                    },
                    {
                        num = 3,
                        type = "client",
                        event = "EVO:evo_sound_player:client:pickupBoombox",
                        icon = "fas fa-trash",
                        label = "Destroy",
                        args = { entity = entity, save = true }
                    },
                },
                distance = 2.5
            })
        elseif Framework == "Qbox" then
            exports['ox_target']:addLocalEntity(entity, {
                {
                    num = 1,
                    type = "client",
                    event = "EVO:evo_sound_player:client:playBoombox",
                    icon = "fas fa-play",
                    label = "Open Menu",
                    args = { entity = entity },
                    distance = 2.5
                },
                {
                    num = 2,
                    type = "client",
                    event = "EVO:evo_sound_player:client:pickupBoombox",
                    icon = "fas fa-hand-paper",
                    label = "Grab Boombox",
                    args = { entity = entity, save = false },
                    distance = 2.5
                },
                {
                    num = 3,
                    type = "client",
                    event = "EVO:evo_sound_player:client:pickupBoombox",
                    icon = "fas fa-trash",
                    label = "Destroy",
                    args = { entity = entity, save = true },
                    distance = 2.5
                },
            })
        elseif Framework == "ESX" then
            exports['ox_target']:addLocalEntity(entity, {
                {
                    num = 1,
                    type = "client",
                    event = "EVO:evo_sound_player:client:playBoombox",
                    icon = "fas fa-play",
                    label = "Open Menu",
                    args = { entity = entity },
                    distance = 2.5
                },
                {
                    num = 2,
                    type = "client",
                    event = "EVO:evo_sound_player:client:pickupBoombox",
                    icon = "fas fa-hand-paper",
                    label = "Grab Boombox",
                    args = { entity = entity, save = false },
                    distance = 2.5
                },
                {
                    num = 3,
                    type = "client",
                    event = "EVO:evo_sound_player:client:pickupBoombox",
                    icon = "fas fa-trash",
                    label = "Destroy",
                    args = { entity = entity, save = true },
                    distance = 2.5
                },
            })
        elseif Framework == "ND_Core" then
            exports['ox_target']:addLocalEntity(entity, {
                {
                    num = 1,
                    type = "client",
                    event = "EVO:evo_sound_player:client:playBoombox",
                    icon = "fas fa-play",
                    label = "Open Menu",
                    args = { entity = entity },
                    distance = 2.5
                },
                {
                    num = 2,
                    type = "client",
                    event = "EVO:evo_sound_player:client:pickupBoombox",
                    icon = "fas fa-hand-paper",
                    label = "Grab Boombox",
                    args = { entity = entity, save = false },
                    distance = 2.5
                },
                {
                    num = 3,
                    type = "client",
                    event = "EVO:evo_sound_player:client:pickupBoombox",
                    icon = "fas fa-trash",
                    label = "Destroy",
                    args = { entity = entity, save = true },
                    distance = 2.5
                },
            })
        end
    end
end

function OnBoomboxEntityDeleted(entity) 
    if entity ~= nil then
        if Framework == 'QBCore' then
            exports['qb-target']:RemoveTargetEntity(entity)
        elseif Framework == "Qbox" then
            exports['ox_target']:removeLocalEntity(entity)
        elseif Framework == "ESX" then
            exports['ox_target']:removeLocalEntity(entity)
        elseif Framework == "ND_Core" then
            exports['ox_target']:removeLocalEntity(entity)
        elseif Framework == "Standalone" then
            print("onBoomboxEntityCreated not implemented")
        end
    end
end

------------------------------------------
--  COMMANDS
------------------------------------------
if Config.radio.command ~= nil then
    RegisterCommand(Config.radio.command, function()
        RadioCommandImpl()
    end, false)
end


if Config.boombox.command ~= nil then
    RegisterCommand(Config.boombox.command, function()
        BoomboxCommandImpl()
    end, false)
end


if Config.zones.command ~= nil then
    RegisterCommand(Config.zones.command, function()
        ZonesCommandImpl()
    end, false)
end
