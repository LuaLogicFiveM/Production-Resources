ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('ak47_usablecookies:notify')
AddEventHandler('ak47_usablecookies:notify', function(msg)
    ESX.ShowNotification(msg)
end)

RegisterNetEvent('ak47_usablecookies:progress')
AddEventHandler('ak47_usablecookies:progress', function(msg, time)
    --Use your progressbar here
end)

function ShowNotificationDefault(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end

function tofloat(value)
    return tonumber(string.format("%.2f", value))
end

--If you want to add some effect on smoke then make events like this and add your effect inside
function effectJoint()
    local ped = PlayerPedId()
    SetTimecycleModifierStrength(0.0)
    SetTimecycleModifier('spectator6')
    SetPedMotionBlur(ped, true)
    Citizen.Wait(5000)
    SetTimecycleModifierStrength(0.66)
    Citizen.Wait(3000)
    ShakeGameplayCam('DRUNK_SHAKE', 2.5)
    Citizen.Wait(3000)
    AddArmourToPed(ped, 50)
    Citizen.Wait(15000)
    ClearTimecycleModifier()
    Citizen.Wait(15000)
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    SetPedMotionBlur(ped, false)
    Citizen.Wait(15000)
end

function effectVape()
    Citizen.Wait(5000)
    local ped = PlayerPedId()
    AddArmourToPed(ped, 50)
end

--On Smoke Joint Events
AddEventHandler('ak47_usablecookies:onsmoke:cake_mix_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:cereal_milk_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:cheetah_piss_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:gary_payton_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:gelatti_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:georgia_pie_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:jefe_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:snow_man_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:white_runtz_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:blueberry_cruffin_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:whitecherry_gelato_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:fine_china_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:pink_sandy_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:zushi_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:apple_gelato_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:biscotti_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:collins_ave_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:marathon_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:oreoz_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:pirckly_pear_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:runtz_og_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:blue_tomyz_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:ether_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:froties_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:gmo_cookies_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:ice_cream_cake_pack_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:khalifa_kush_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:la_confidential_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:marshmallow_og_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:moon_rock_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:sour_diesel_joint', function()
    effectJoint()
end)

AddEventHandler('ak47_usablecookies:onsmoke:tahoe_og_joint', function()
    effectJoint()
end)

--On Smoke Vape Events
AddEventHandler('ak47_usablecookies:onvape:blueberry_jam_cookie', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:butter_cookie', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:get_figgy', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:key_lime_cookie', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:marshmallow_crisp', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:no_99', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:paris_fog', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:pogo', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:pumpkin_cookie', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:shamrock_cookie', function()
    effectVape()
end)

AddEventHandler('ak47_usablecookies:onvape:strawberry_jam_cookie', function()
    effectVape()
end)

