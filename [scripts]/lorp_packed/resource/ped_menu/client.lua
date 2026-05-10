local config = require 'resource.ped_menu.shared'

local function PreviewPed(model)
    lib.requestModel(model)
    local positionBuffer = {}
    local bufferSize = 5
    local clonedPed = CreatePed(26, model, 0.0, 0.0, 0.0, 0, false, false)

    SetEntityInvincible(clonedPed, true)
    SetEntityCanBeDamaged(clonedPed, false)
    SetEntityCollision(clonedPed, false, true)
    SetBlockingOfNonTemporaryEvents(clonedPed, true)
    NetworkSetEntityInvisibleToNetwork(clonedPed, true)
    FreezeEntityPosition(clonedPed, true)

    local world, normal = GetWorldCoordFromScreenCoord(0.66135417461395, 0.8787036895752)
    local target = world + normal * 3.5
    local camRot = GetGameplayCamRot(2)

    table.insert(positionBuffer, target)
    if #positionBuffer > bufferSize then
        table.remove(positionBuffer, 1)
    end

    local averagedTarget = vector3(0, 0, 0)
    for _, position in ipairs(positionBuffer) do
        averagedTarget = averagedTarget + position
    end

    averagedTarget = (averagedTarget / #positionBuffer)

    SetEntityCoords(clonedPed, averagedTarget.x, averagedTarget.y, averagedTarget.z, false, false, false, true)
    SetEntityHeading(clonedPed, camRot.z + 170.0)
    SetEntityRotation(clonedPed, camRot.x*(-1), 0, camRot.z + 170.0, 0.0, false)

    return clonedPed
end

local function SelectMenu(model, hasPerms, lastMenu)
    local pedModel = PreviewPed(model)
    lib.registerContext({
        id = 'ped_menu_options',
        title = 'Preview',
        menu = lastMenu,
        canClose = false,
        onBack = function()
            DeleteEntity(pedModel)
        end,
        options = {
            {
                title = 'Spawn (Hover for Info)',
                metadata = {
                    Masks = GetNumberOfPedDrawableVariations(pedModel, 1),
                    Hair = GetNumberOfPedDrawableVariations(pedModel, 2),
                    Arms = GetNumberOfPedDrawableVariations(pedModel, 3),
                    Pants = GetNumberOfPedDrawableVariations(pedModel, 4),
                    Bags = GetNumberOfPedDrawableVariations(pedModel, 5),
                    Shoes = GetNumberOfPedDrawableVariations(pedModel, 6),
                    Chains = GetNumberOfPedDrawableVariations(pedModel, 7),
                    Undershirts = GetNumberOfPedDrawableVariations(pedModel, 8),
                    Vests = GetNumberOfPedDrawableVariations(pedModel, 9),
                    Decals = GetNumberOfPedDrawableVariations(pedModel, 10),
                    Shirts = GetNumberOfPedDrawableVariations(pedModel, 11),
                    Hats = GetNumberOfPedPropDrawableVariations(pedModel, 0),
                    Glasses = GetNumberOfPedPropDrawableVariations(pedModel, 1),
                    Ear_Accs = GetNumberOfPedPropDrawableVariations(pedModel, 2),
                    Mouth = GetNumberOfPedPropDrawableVariations(pedModel, 3),
                    L_Wrist = GetNumberOfPedPropDrawableVariations(pedModel, 6),
                    R_Wrist = GetNumberOfPedPropDrawableVariations(pedModel, 7),
                },
                disabled = not hasPerms,
                onSelect = function()
                    DeleteEntity(pedModel)
                    exports['illenium-appearance']:setPlayerModel(model)
                    SetPedComponentVariation(cache.ped, 2, 1, 0, 0)
                    lib.showContext('ped_menu_options')
                    lib.notify({title = 'Ped Menu', description = 'You have selected a new ped, some peds have clothing options, visit a clothing store to view the options.', position = 'top', type = 'success', duration = 10000})
                end
            }
        }
    })
    lib.showContext('ped_menu_options')
end

local function OpenPedList(category, roles)
    local pedList = config.peds[category]
    local menu = { id = category, title = 'Available Peds', menu = 'ped_menu', options = {} }

    for model, data in pairs(pedList) do
        menu.options[#menu.options+1] = {
            title = data.title,
            args = { roles = roles, model = model, menu = category },
            onSelect = function(args)
                SelectMenu(args.model, args.roles[tostring(data.role)] or false, args.menu)
            end
        }
    end

    lib.registerContext(menu)
    lib.showContext(menu.id)
end

local function OpenPedMenu(roles)
    lib.registerContext({
        id = 'ped_menu',
        title = 'Ped Menu',
        options = {
            {
                title = 'Reset Ped',
                icon = 'repeat',
                onSelect = function()
                    ExecuteCommand('reloadskin')
                    lib.notify({title = 'Ped Menu', description = 'You have reset your ped, if this does not work, select an outfit in the clothing store or outfit bag.', position = 'top', type = 'warning', duration = 10000})
                end
            },
            {
                title = 'Law Enforcement',
                icon = 'handcuffs',
                arrow = true,
                args = { menu = 'ped_menu_law', roles = roles },
                onSelect = function(args)
                    OpenPedList(args.menu, args.roles)
                end
            },
            {
                title = 'Celebrities',
                icon = 'microphone-lines',
                arrow = true,
                args = { menu = 'ped_menu_celebrity', roles = roles },
                onSelect = function(args)
                    OpenPedList(args.menu, args.roles)
                end
            },
            {
                title = 'Gangs',
                icon = 'skull-crossbones',
                arrow = true,
                args = { menu = 'ped_menu_gang', roles = roles },
                onSelect = function(args)
                    OpenPedList(args.menu, args.roles)
                end
            },
            {
                title = 'Events',
                arrow = true,
                args = { menu = 'ped_menu_event', roles = roles },
                onSelect = function(args)
                    OpenPedList(args.menu, args.roles)
                end
            },
        }
    })
    lib.showContext('ped_menu')
end

RegisterNetEvent('lorp_ped_menu:client:open')
AddEventHandler('lorp_ped_menu:client:open', function(roles)
    OpenPedMenu(roles)
end)