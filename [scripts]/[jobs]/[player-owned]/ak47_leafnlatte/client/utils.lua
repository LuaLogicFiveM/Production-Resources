ESX = exports.es_extended:getSharedObject()
PlayerData = {}

Citizen.CreateThread(function()
    createBlip()
end)

RegisterNetEvent('ak47_leafnlatte:openbossaction', function()
    TriggerEvent('esx_society:openBossMenu', 'leafnlatte')
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded', function()
    PlayerData = ESX.GetPlayerData()
end)

local effectid = 0
function effectHookah()
    local ped = PlayerPedId()
    local effectnow = effectid
    SetTimecycleModifierStrength(0.0)
    SetTimecycleModifier('spectator6')
    Citizen.Wait(5000)
    if effectid ~= effectnow then return end
    SetTimecycleModifierStrength(0.66)
    Citizen.Wait(3000)
    if effectid ~= effectnow then return end
    ShakeGameplayCam('DRUNK_SHAKE', 0.3)
    Citizen.Wait(3000)
    if effectid ~= effectnow then return end
    AddArmourToPed(ped, 50)
    RequestClipSet('MOVE_M@DRUNK@SLIGHTLYDRUNK')
    while not HasClipSetLoaded('MOVE_M@DRUNK@SLIGHTLYDRUNK') do
        Citizen.Wait(0)
    end
    SetPedMovementClipset(ped, 'MOVE_M@DRUNK@SLIGHTLYDRUNK', true)
    Citizen.Wait(30000)
    if effectid ~= effectnow then return end
    ClearTimecycleModifier()
    Citizen.Wait(15000)
    if effectid ~= effectnow then return end
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    Citizen.Wait(15000)
    if effectid ~= effectnow then return end
    ResetPedMovementClipset(ped, 0)
end

-- hookah effect
local effectRunning = false
AddEventHandler('ak47_leafnlatte:smoke', function()
    if not effectRunning then
        effectRunning = true
        effectHookah()
        effectRunning = false
    end
end)

AddEventHandler('ak47_leafnlatte:onuse:kushkrisps', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:onuse:herbaldelightgummies', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:onuse:blazebites', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:onuse:chroniccrunchcookies', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:onuse:hightimebrownies', function()
    effectid += 1
    effectHookah()
end)

--bar effect
AddEventHandler('ak47_leafnlatte:ondrink:cocktail', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:champagne', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:daiquiri', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:redwine', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:whitewine', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:whisky', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:tequilashots', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:mojito', function()
    effectid += 1
    effectHookah()
end)
AddEventHandler('ak47_leafnlatte:ondrink:leaflatte', function()
    effectid += 1
    effectHookah()
end)

function createBlip()
    --[[local coords = Config.Shop.blip.pos
    local radius = Config.Shop.blip.radius + 0.00
    local blipRd = AddBlipForRadius(coords, radius)
    SetBlipHighDetail(blipRd, true)
    SetBlipColour(blipRd, Config.Shop.blip.radius_color)
    SetBlipAlpha (blipRd, 128)
    SetBlipAsShortRange(blipRd, true)
    local blip = AddBlipForCoord(coords)
    SetBlipHighDetail(blip, true)
    SetBlipSprite (blip, Config.Shop.blip.sprite)
    SetBlipScale  (blip, Config.Shop.blip.size)
    SetBlipColour (blip, Config.Shop.blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Shop.blip.name)
    EndTextCommandSetBlipName(blip)]]
end

RegisterNetEvent('ak47_leafnlatte:notify')
AddEventHandler('ak47_leafnlatte:notify', function(msg, type)
    exports['ox_lib']:notify({
        type = type or 'info',
        description = msg,
        position = 'top',
    })
end)

RegisterNetEvent('ak47_leafnlatte:progress')
AddEventHandler('ak47_leafnlatte:progress', function(msg, time)
    lib.progressCircle({
        duration = time,
        label = msg,
    })
end)

function playAnim(dir, anim, blendIn, blendOut, duration, flag, playbackRate)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(dir)
    while not HasAnimDictLoaded(dir) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, dir, anim, blendIn + 0.0, blendOut + 0.0, duration, flag, playbackRate, 0, 0, 0)
end

function GetHeadingFromPoints(a, b)
    if not a or not b then
        return 0.0
    end
    if a.x == b.x and a.y == b.y then
        return 0.0
    end
    if #(a - b) < 1 then
        return 0.0
    end
    local theta = math.atan(b.x - a.x,a.y - b.y)
    if theta < 0.0 then
        theta = theta + (math.pi * 2)
    end
    return math.deg(theta) + 180 % 360
end

function drawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, r, g, b, a, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureDict, textureDict)
	DrawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, r, g, b, a, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureDict, textureDict)
end

function tofloat(value)
    return tonumber(string.format("%.2f", value))
end

DrawTxt3D = function(coords, text)
    local str = text
    AddTextEntry(GetCurrentResourceName(), str)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

function DrawText3D(coords, text, size, font)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
    local size           = size

    if size == nil then
        size = 1
    end

    local scale = (size / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(font)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end