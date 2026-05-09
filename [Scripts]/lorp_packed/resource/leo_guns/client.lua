local Jobs = {['bcso'] = true, ['gsp'] = true, ['gov'] = true}
local PlayerJob
local WhitelistedWeapons = {
    [`WEAPON_PROLASER4`] = true,
    [`WEAPON_BOLAWRAP`] = true,
    [`WEAPON_PEPPERSPRAY`] = true,
    [`WEAPON_ANTIDOTE`] = true,
    [`WEAPON_FLASHBANG`] = true,
    [`WEAPON_AIRSOFTR870`] = true,
    [`WEAPON_AIRSOFTM4`] = true,
    [`WEAPON_AIRSOFTGLOCK20`] = true,
    [`WEAPON_SIG_SAUCER`] = true,
    [`WEAPON_GLOCK19GEN4`] = true,
    [`WEAPON_GLOCK20`] = true,
    [`WEAPON_FBIARB`] = true,
    [`WEAPON_FM1_BENELLIM4`] = true,
    [`WEAPON_M870`] = true,
    [`WEAPON_HK417`] = true,
    [`WEAPON_LWRC`] = true,
    [`WEAPON_KS1`] = true,
    [`WEAPON_LBRS`] = true,
    [`WEAPON_SIG516`] = true,
    [`WEAPON_P90`] = true,
    [`WEAPON_HEAVYSNIPER`] = true,
    [`WEAPON_STUNGUN`] = true,
    [`WEAPON_FLASHLIGHT`] = true,
    [`WEAPON_BEANBAG`] = true,
    [`WEAPON_MEGAPHONE`] = true,
}

RegisterNetEvent('esx:playerLoaded', function (xPlayer)
    PlayerJob = xPlayer.job.name
end)

RegisterNetEvent("esx:setJob") 
AddEventHandler('esx:setJob', function(job)
    PlayerJob = job.name
end)

lib.onCache('weapon', function(weapon)
    if weapon and WhitelistedWeapons[weapon] and not Jobs[PlayerJob] then
        TriggerEvent('ox_inventory:disarm')
    end
end)