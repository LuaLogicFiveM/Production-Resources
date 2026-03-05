Config = {}
Config.Locale = 'en'

--You can set admin in alternative ways-------------------
--Ace Permission
Config.AdminWithAce = true
--Or group
Config.AdminWithGroup = {
    owner = true,
    manager = true,
}
--Or license
Config.AdminWithLicense = {
    --['license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'] = true,
}
--Or identifier
Config.AdminWithIdentifier = {
    --['xxxxxxxx'] = true,
}
----------------------------------------------------------

Config.Inventory = 'ox_inventory' -- ak47_inventory, ox_inventory, qs-inventory, codem-inventory, origen_inventory, tgiann-inventory

-- account = 'coin' in the shop
Config.SpecialCoin = {
    tablename           = 'cointable',   --adjust this [I don't know what coin script you are using or not, so don't open ticket for this]
    identifiercolumname = 'identifier',  --adjust this [I don't know what coin script you are using or not, so don't open ticket for this]
    coincolumname       = 'coin',        --adjust this [I don't know what coin script you are using or not, so don't open ticket for this]
}

Config.TargetScript = 'qtarget' -- don't change if you are using ox_target
Config.ShowDistance = 5.0

Config.GiveIdCommandAccessByJob = {
    ['sasp'] = {
        minimumrank = 5,
        items = {'id_card', 'weapons_license', 'hunting_license', 'boating_license', 'fishing_license', 'sasp_badge'}
    },
    ['bcso'] = {
        minimumrank = 5,
        items = {'id_card', 'weapons_license', 'hunting_license', 'boating_license', 'fishing_license', 'sheriff_badge'}
    },
    ['gov'] = {
        minimumrank = 0,
        items = {'id_card', 'weapons_license', 'hunting_license', 'boating_license', 'fishing_license', 'sheriff_badge'}
    },
    ['safd'] = {
        minimumrank = 1,
        items = {'id_card', 'medical_license', 'ems_badge'}
    }
}

Config.GiveIdCommandAccessByGang = { --only ak47_gangs supported
    --[[ballas = {
        minimumrank = 3,
        items = {'weedlicense'}
    },]]
}

Config.Cards = {
    id_card = {
        label           = "CITIZEN ID",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(0, 0, 0, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#ffffff",
        prop = {
            model = 'prop_idcard',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    sasp_badge = {
        label           = "SASP BADGE",
        titleColor      = "#ffffff",
        textColorLight  = "#ffffff",
        textColorBold   = "#ffffff",
        barcodeColor    = "#ffffff",
        textShadowColor = "rgba(0, 0, 0, 0.5)",
        imgBorderColor  = "#ffffff",
        imgBgColor      = "#0055ff",
        classes = {
            "Training", "Cadet", "Trooper", "Sr. Trooper", "Corporal", "Sergeant", "Lieutenant", "Air-1", "Sniper", "S.W.A.T", "Captain", "Major", "Commissioner",
        },
        prop = {
            model = 'prop_policeid',
            bone = 28422,
            position = vector3(0.0600, 0.0210, -0.0400),
            rotation = vector3(-90.00, -180.00, 78.999),
        },
        animation = {
            dict = 'paper_1_rcm_alt1-8',
            clip = 'player_one_dual-8',
        },
    },
    sheriff_badge = {
        label           = "SHERIFF BADGE",
        titleColor      = "#ffffff",
        textColorLight  = "#ffffff",
        textColorBold   = "#ffffff",
        barcodeColor    = "#ffffff",
        textShadowColor = "rgba(0, 0, 0, 0.7)",
        imgBorderColor  = "#ffffff",
        imgBgColor      = "#ffbb00",
        classes = {
            "Recruit", "Corporal", "Sergeant", "Sr. Sergeant", "Lieutenant", "Captain", "Major", "Supervisor", "Moto Unit", "Gang Unit", "K9 Unit", "SWAT Unit", "Command", "Asst. Deputy", "Deputy Commissioner", "Commissioner",
        },
        prop = {
            model = 'prop_sheriffid',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    driver_license = {
        label           = "DRIVERS LICENSE",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "rgb(190 227 243)",
        classes = {
            "A", "A1", "BE", "C1", "C1E", "C1E",
            "C", "CE", "D1", "D1E", "D", "DE",
        },
        prop = {
            model = 'prop_driverlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    commercial_license = {
        label           = "COMMERCIAL DRIVERS LICENSE",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#ffe83b",
        classes = {
            "A", "A1", "BE", "C1", "C1E", "C1E",
            "C", "CE", "D1", "D1E", "D", "DE",
        },
        prop = {
            model = 'prop_driverlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    medical_license = {
        label           = "WEED LICENSE",
        titleColor      = "#ffffff",
        textColorLight  = "#ffffff",
        textColorBold   = "#ffffff",
        barcodeColor    = "#ffffff",
        textShadowColor = "rgba(0, 0, 0, 0.6)",
        imgBorderColor  = "#ffffff",
        imgBgColor      = "#0f9400",
        prop = {
            model = 'prop_weedlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    hunting_license = {
        label           = "HUNTING LICENSE",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#ff7b00",
        prop = {
            model = 'prop_weedlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    boating_license = {
        label           = "BOATING LICENSE",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#0055ff",
        prop = {
            model = 'prop_weedlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    fishing_license = {
        label           = "FISHING LICENSE",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#0099ff",
        prop = {
            model = 'prop_weedlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    ems_badge = {
        label           = "PARAMEDIC",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#ff0000",
        classes = {
            "Recruit", "Paramedic", "Doctor", "Surgeon", "Chief",
        },
        prop = {
            model = 'prop_emsid',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
    weapons_license = {
        label           = "LICENSE TO CARRY",
        titleColor      = "#000000",
        textColorLight  = "#000000",
        textColorBold   = "#000000",
        barcodeColor    = "#000000",
        textShadowColor = "rgba(245, 245, 245, 0.2)",
        imgBorderColor  = "#000000",
        imgBgColor      = "#ff5121",
        classes = {
            "Pistol", "Shotgun", "SMG", "AR", "Sniper"
        },
        prop = {
            model = 'prop_weaponlicense',
            bone = 28422,
            position = vector3(0.084, 0.02, -0.026),
            rotation = vector3(-173.8514, -88.0171, 63.0612),
        },
        animation = {
            dict = 'cop_badge_1@dad',
            clip = 'cop_badge_1_clip',
        },
    },
}

Config.Shops = {
	{
		name = "City Hall",
        blip = {enable = false, id = 498, color = 3, scale = 0.8},
        items = {
            {
            	item = "id_card",
            	label = "ID Card",
            	description = "Your citizenship id card",
            	price = 5000,
            	account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
            	licenseclass = nil,
            	expire = 6,
            },
            {
            	item = "driver_license",
            	label = "DRIVER LICENSE",
            	description = "Drivers License Class C",
            	price = 8000,
            	account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
            	licenseclass = "C",
            	expire = 1,
            },
            {
            	item = "commercial_license",
            	label = "COMMERCIAL DRIVERS LICENSE",
            	description = "Commercial Drivers License Class C",
            	price = 15000,
            	account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
            	licenseclass = "C",
            	expire = 1,
            },
        },
        zones = {
            {
                coords = vector4(1754.8326, 3806.6050, 35.4489, 127.7575),
                size = vector3(2.0, 2.0, 2.0),
            },
        },
        target = {label = "Licenses", icon = 'fa-id-card', distance = 2.0},
        peds = { --if empty then there will be no ped. Only polyzone
            'mp_m_securoguard_01',
        },
        scenario = 'WORLD_HUMAN_COP_IDLES' -- if nil then ped will not play any scenario
	},
    --[[{
        name = "Weapon Licenses",
        blip = {enable = true, id = 498, color = 1, scale = 0.8},
        items = {
            {
                item = "weapons_license", 
                label = "LICENSE TO CARRY", 
                description = "Firearms License Class [Handgun]",
                price = 25000, 
                account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
                licenseclass = "Handgun",
                expire = 1, -- in month
            },
            {
                item = "weapons_license", 
                label = "LICENSE TO CARRY", 
                description = "Firearms License Class [Shotgun]",
                price = 50000, 
                account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
                licenseclass = "Shotgun",
                expire = 1, -- in month
            },
            {
                item = "weapons_license", 
                label = "LICENSE TO CARRY", 
                description = "Firearms License Class [SMG]",
                price = 75000, 
                account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
                licenseclass = "SMG",
                expire = 1, -- in month
            },
            {
                item = "weapons_license", 
                label = "LICENSE TO CARRY", 
                description = "Firearms License Class [Rifle]",
                price = 250, 
                account = 'cash', -- 'cash', 'bank', 'black_money', 'coin'
                licenseclass = "Rifle",
                expire = 1, -- in month
            },
        },
        zones = {
            {
                coords = vector4(13.84, -1106.34, 29.78, 342.99),
                size = vector3(2.0, 2.0, 2.0),
            },
        },
        target = {label = "Weapons Licenses", icon = 'fa-id-card', distance = 2.0},
        peds = { --if empty then there will be no ped. Only polyzone
            's_m_y_ammucity_01',
        },
        scenario = 'WORLD_HUMAN_COP_IDLES' -- if nil then ped will not play any scenario
    },]]
}

