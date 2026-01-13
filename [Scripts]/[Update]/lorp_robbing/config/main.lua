Config = {
    Keybinds = { -- You can select any keybinds from here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        ["Thief"] = "H",
        ["HandsUp"] = "X"
    },

    InputCooldowns = {
        ["Thief"] = 1, -- Second(s)
        ["HandsUp"] = 1, -- Second(s)
    },

    Settings = {
        ["Cooldown"] = {
            ["Enabled"] = false,
            ["Duration"] = 10, -- Minute(s)
        },
        ["MaxDistance"] = 2.0,
    },

    Whitelisted = {
        ["Areas"] = {
           {coords = vector3(172.0816, -1770.5901, 29.1176), range = 250.0},
        }
    },

    Blacklisted = {
        ["Inventory"] = { -- ["item_name"] = maximum,
            ["money"] = 50000,
            ["black_money"] = 50000,
            ["ammo-9"] = 500,
            ['ammo-10'] = 500,
            ["ammo-45"] = 500,
            ["ammo-40"] = 500,
            ["ammo-762"] = 500,
            ["ammo-556"] = 500,
            ["ammo-22"] = 500,
            ["ammo-5.7"] = 500,
            ["ammo-12"] = 100,
            ["ammo-20"] = 100,
            ["ammo-50"] = 0,
            ["id_card"] = 0,
            ["drivers_license"] = 0,
            ["hunting_license"] = 0,
            ["commercial_licenese"] = 0,
            ["boating_license"] = 0,
            ["fishing_license"] = 0,
            ["sheriff_badge"] = 0,
            ["sahp_badge"] = 0,
            ["ems_badge"] = 0,
            ['armour'] = 0,
			['bodycam'] = 0,
			['dashcam'] = 0,
			['alcohol_tester'] = 0,
			['tablet'] = 0,
			['tracking_bracelet'] = 0,
			['tintmeter'] = 0,
			['handcuffs'] = 0,
			['spikestrip'] = 0,
			['evidence_laptop'] = 0,
			['evidence_box'] = 0,
			['baggy_empty'] = 0,
			['hydrogen_peroxide'] = 0,
			['fingerprint_brush'] = 0,
			['fingerprint_scanner'] = 0,
			['finger_scanner'] = 0,
			['WEAPON_PROLASER4'] = 0,
			['WEAPON_BOLAWRAP'] = 0,
			['WEAPON_PEPPERSPRAY'] = 0,
			['WEAPON_ANTIDOTE'] = 0,
			['WEAPON_FLASHBANG'] = 0,
			['WEAPON_AIRSOFTR870'] = 0,
			['WEAPON_AIRSOFTM4'] = 0,
			['WEAPON_AIRSOFTGLOCK20'] = 0,
			['WEAPON_SIG_SAUCER'] = 0,
			['WEAPON_GLOCK19GEN4'] = 0,
			['WEAPON_GLOCK20'] = 0,
			['WEAPON_FBIARB'] = 0,
			['WEAPON_FM1_BENELLIM4'] = 0,
			['WEAPON_M870'] = 0,
			['WEAPON_HK417'] = 0,
			['WEAPON_LWRC'] = 0,
			['WEAPON_KS1'] = 0,
			['WEAPON_LBRS'] = 0,
			['WEAPON_SIG516'] = 0,
			['WEAPON_P90'] = 0,
			['WEAPON_HEAVYSNIPER'] = 0,
			['WEAPON_STUNGUN'] = 0,
			['WEAPON_FLASHLIGHT'] = 0,
			['WEAPON_BEANBAG'] = 0,
			['taser_cartridge'] = 0,
			['ammo-beanbag'] = 0,
        },
    },

    Menu = {
        ["Title"] = "Target's Inventory",
        ["DialogTitle"] = "Choose Amount",
        ["InputItemTitle"] = "Item",
        ["InputAmountTitle"] = "Amount",
        ["InputAmountDescription"] = "Choose amount to steal.",
        ["Currency"] = "$",
        ["IconsPath"] = "nui://ox_inventory/web/images"
    },

    Animation = {
        ["Dictionary"] = "rytrak@hangsup@clip",
        ["Name"] = "hangsup_clip",
        ["BlendInSpeed"] = 2.0,
        ["BlendOutSpeed"] = 4.0
    },

    Notifications = {
        ["Steal"] = true,
        ["NoPlayersNearby"] = true
    },

    Messages = {
        ["cooldown"] = "You can\'t rob right now. Try again later!",
        ["something_went_wrong"] = "Something went wrong.",
        ["wrong_area"] = "You are not in a robbable area.",
        ["you_stole"] = "You stole",
        ["thief_stole"] = "Thief stole",
        ["from_you"] = "from you",
        ["no_players_nearby"] = "No players with hands up nearby."
    },

    Functions = {
        CanPlayerSteal = function(ped)
            if cache.vehicle then return false end
            if IsEntityDead(ped) then return false end

            local BlacklistedMelees = {"WEAPON_UNARMED", "WEAPON_KNUCKLE", "WEAPON_FLASHLIGHT"}

            if IsPedArmed(ped, 4) then
                return true
            end

            if IsPedArmed(ped, 1) then
                local approvedMelee = false

                for _, melee in pairs(BlacklistedMelees) do
                    if GetHashKey(melee) == GetSelectedPedWeapon(ped) then
                        approvedMelee = true
                        break
                    end
                end

                return approvedMelee
            end

            return false
        end,
        IsBeingRobbed = function(bool)
            local ped = PlayerPedId()
            if bool then
                -- If he's being robbed, disable some things that he shouldn't use.
                FreezeEntityPosition(ped, true)
                SetPedEnableWeaponBlocking(ped, true)
            else
                -- Once stopped being robbed, enable the things you disabled.
                FreezeEntityPosition(ped, false)
                SetPedEnableWeaponBlocking(ped, false)
            end
        end
    }
}