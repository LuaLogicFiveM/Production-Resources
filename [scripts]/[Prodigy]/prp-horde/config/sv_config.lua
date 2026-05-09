svConfig = {}

svConfig.interiors = {
    {
        name = 'Syndicate',
        key = 'syndicate',
        insideCoords = vector4(2154.66, 2921.00, -81.09, 272.13),
        outsideCoords = vector4(3.69, -201.09, 52.73, 161.57),
        enterTargetCoords = vector3(3.97, -200.45, 53.12),
        exitTargetCoords = vector3(2154.90, 2919.64, -81.03),
        chestModel = `sm_prop_smug_rsply_crate01a`,
        chestCoords = vector3(2181.5, 2926.0, -85.8),
        chestRotation = vector3(0.0, 0.0, 90.0),
        storageModel = `v_ind_cfcovercrate`,
        storageCoords = vector3(-0.42, -201.56, 51.74),
        storageRotation = vector3(0.0, 0.0, 90.0),
        shop = vector3(2186.48, 2929.00, -84.5),
        pedModels = {
            `u_m_y_juggernaut_01`,
            `mp_m_avongoon`,
        },
    },
    {
        name = 'Cayo Mansion',
        key = 'cayo',
        hardMode = true,
        insideCoords = vector4(4989.9, -5717.7, 18.9, 237.0),
        outsideCoords = vector4(4981.9, -5710.3, 18.9, 49.8),
        enterTargetCoords = vector3(4982.54, -5710.98, 20.15),
        exitTargetCoords = vector3(4989.20, -5716.89, 20.12),
        chestModel = `sm_prop_smug_rsply_crate01a`,
        chestCoords = vector3(4996.82, -5721.67, 18.91),
        chestRotation = vector3(0.0, 0.0, 90.0),
        storageModel = `v_ind_cfcovercrate`,
        storageCoords = vector3(4974.74, -5712.48, 18.91),
        storageRotation = vector3(0.0, 0.0, -43.0),
        shop = vector3(4996.33, -5724.78, 19.89),
        shopModel = `as_prop_as_laptop_01a`,
        shopRotation = vector3(0.0, 0.0, -90.00),
        pedModels = {
            `s_m_m_highsec_01`,
            `s_m_m_highsec_02`,
            `u_m_m_jewelsec_01`,
            `s_m_m_scientist_01`,
            `s_m_y_swat_01`,
            `mp_m_meth_01`,
            `u_m_y_juggernaut_01`,
            `mp_m_avongoon`,
        },
        bossModels = {
            `u_m_y_juggernaut_01`,
            `ho_glad`,
            `ho_fat`,
        },
        eliteModels = {
            `a_m_m_eastsa_01`,
        },
    },
    {
        name = 'Doomsday Bunker',
        key = 'doomsday',
        hardMode = true,
        insideCoords = vector4(857.2, -3249.3, -99.4, 354.5),
        outsideCoords = vector4(147.23, 6365.87, 31.80, 0.00),
        enterTargetCoords = vector3(147.23, 6366.87, 31.80),
        exitTargetCoords = vector3(857.18, -3250.49, -98.06),
        chestModel = `sm_prop_smug_rsply_crate01a`,
        chestCoords = vector3(842.89, -3243.83, -99.70),
        chestRotation = vector3(0.0, 0.0, 90.0),
        storageModel = `v_ind_cfcovercrate`,
        storageCoords = vector3(144.34, 6370.40, 30.53),
        storageRotation = vector3(0.0, 0.0, 28.0),
        shop = vector3(840.62, -3245.13, -98.60),
        shopModel = `as_prop_as_laptop_01a`,
        shopRotation = vector3(0.0, 0.0, 180.00),
        pedModels = {
            `s_m_m_highsec_01`,
            `s_m_m_highsec_02`,
            `u_m_m_jewelsec_01`,
            `s_m_y_swat_01`,
        },
        bossModels = {
            `u_m_y_juggernaut_01`,
            `ho_glad`,
            -- `ho_fat`,
        },
        eliteModels = {
            `a_m_m_eastsa_01`,
        },
    }
}

svConfig.startingNpc = {
    models = { `s_m_y_ammucity_01`, `s_m_y_blackops_02`, `s_m_y_prisoner_01` },
    -- Setting to true, on server start, random location will be choosen, other wise NPC will spawn in every location
    randomLocation = false,
    scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
    -- anim = {
    --     dict = 'anim@heists@box_carry@',
    --     name = 'idle',
    --     flag = 1,
    -- },
    locations = {
        vector4(-64.3291, 172.4507, 80.4939, 253.7517)
    }
}

svConfig.phoneNumberForMessage = '131-482-211'

svConfig.mission = {
    name = 'horde',
    label = locale('HORDE_MISSION_LABEL'),
    description = locale('HORDE_MISSION_DESCRIPTION'),
    type = 'heist',
    minimalGroupSize = config.debug and 1 or 4,
    maximumGroupSize = 5,
    hasQueue = true,
    policeRequired = config.debug and 0 or 4,
    timeout = 180, -- timeout is in minutes, current value is 3 hours
    concurrentMissions = 2,
    cooldown = 60,  -- minutes
}

svConfig.groundLootItems = {
    {
        id = 'horde_small',
        weight = 5,
        label = 'Horde Small Item',
        animation = {
            priority = 1,
            dictionary = 'anim@heists@box_carry@',
            animation = 'idle',
            prop = {
                hash = `h4_prop_h4_box_ammo_01a`,
                bone = 28422,
                position = vector3(-0.00499999988824, -0.03500000014901, -0.16500000655651),
                rotation = vector3(0, 0, -86),
            },
        },
    },
    {
        id = 'horde_medium',
        weight = 8,
        label = 'Horde Medium Item',
        animation = {
            priority = 1,
            dictionary = 'anim@heists@box_carry@',
            animation = 'idle',
            prop = {
                hash = `m24_2_prop_m42_weaponcrate_02a`,
                bone = 28422,
                position = vector3(-0.03500000014901, -0.01499999966472, -0.10000000149011),
                rotation = vector3(43, 3.5, -3),
            },
        },
    },
    {
        id = 'horde_big',
        weight = 10,
        label = 'Horde Big Item',
        animation = {
            priority = 1,
            dictionary = 'anim@heists@box_carry@',
            animation = 'idle',
            prop = {
                hash = `h4_prop_h4_box_ammo_02a`,
                bone = 28422,
                position = vector3(-0.05000000074505, 0.02500000037252, -0.01499999966472),
                rotation = vector3(35.5, 1.5, -1.5),
            },
        },
    },
}

svConfig.groundLootTable = {
    { itemId = 'horde_small',  weight = 20 },
    { itemId = 'horde_medium', weight = 10 },
    { itemId = 'horde_big',    weight = 5 },
}

svConfig.groundLootRolls = 1

svConfig.groundItemCurrency = {
    horde_small = 50,
    horde_medium = 75,
    horde_big = 150,
}

----------- ITEMS
svConfig.reviveItem = 'horde_revive'
svConfig.crateKeyItem = 'horde_crate_key'
svConfig.armorPlateItem = 'armour'

----------- CURRENCY
svConfig.currencyPerKill = 50
svConfig.currencyPerHeadshot = 200

svConfig.votingTime = 30
svConfig.lootingTime = 300 -- 5 minutes


svConfig.loadout = {
    {
        name = "weapon_pistol",
        count = 1,
        metaData = {
            serial = 'scratched'
        },
    },
    {
        name = "ammo-9",
        count = 100,
    },
    {
        name = "water",
        count = 10,
    },
    {
        name = "armour",
        count = 1,
    },
}

svConfig.excludeLoadoutItems = {
    phone = true,
    radio = true
}

svConfig.deathAnimPool = {
    { 'dead',                'dead_a' },
    { 'dead',                'dead_b' },
    { 'dead',                'dead_c' },
    { 'dead',                'dead_d' },
    { 'dead',                'dead_e' },
    { 'dead',                'dead_f' },
    { 'dead',                'dead_h' },
    { 'misslamar1dead_body', 'dead_idle' },
}

svConfig.pedLootTable = {
    lootTable = {
        COMMON = {
            { name = 'bandage', min = 1, max = 1 },
            { name = 'bandage', min = 1, max = 1 },
            { name = 'ammo-9',  min = 1, max = 1 },
        },
    },
    guaranteedRarities = {
        COMMON = 1,
    },
}

svConfig.sharedLootTable = {
    lootTable = {
        COMMON = {
            { name = 'bandage', min = 1, max = 1 },
        },
    },
    guaranteedRarities = {
        COMMON = 1,
    },
}

svConfig.minWaves = 9
svConfig.maxWaves = 12

svConfig.waves = {
    [1] = {
        health = 100,
        armor = 100,
        accuracy = 30,
        weapons = {
            { hash = `WEAPON_PISTOL`, weight = 10 },
        },
        gangXP = 20,
        perkXP = 2,
        pedLootRolls = 1,
        numberOfPeds = 8,
    },
    [2] = {
        health = 110,
        armor = 120,
        accuracy = 30,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_PISTOL`, weight = 10 },
            { hash = `WEAPON_SMG`,    weight = 5 },
        },
        pedLootRolls = 1,
        numberOfPeds = 10,
    },
    [3] = {
        health = 120,
        armor = 130,
        accuracy = 35,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_SMG`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 10,
        stress = 10,
    },
    [4] = {
        health = 130,
        armor = 150,
        accuracy = 50,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_SMG`,          weight = 10 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 12,
        stress = 10,
    },
    [5] = {
        health = 140,
        armor = 170,
        accuracy = 60,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 12,
        stress = 10,
    },
    [6] = {
        health = 150,
        armor = 180,
        accuracy = 70,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 14,
        stress = 20,
    },
    [7] = {
        health = 160,
        armor = 200,
        accuracy = 80,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 16,
        stress = 20,
    },
    [8] = {
        health = 170,
        armor = 220,
        accuracy = 100,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 16,
        stress = 30,
    },
    [9] = {
        health = 180,
        armor = 240,
        accuracy = 100,
        gangXP = 20,
        perkXP = 2,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 16,
        stress = 40,
    },
    [10] = {
        health = 200,
        armor = 250,
        accuracy = 100,
        gangXP = 20,
        perkXP = 4,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 20,
        stress = 50,
    },
    [11] = {
        health = 200,
        armor = 250,
        accuracy = 100,
        gangXP = 20,
        perkXP = 4,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 20,
        stress = 50,
    },
    [12] = {
        health = 200,
        armor = 250,
        accuracy = 100,
        gangXP = 20,
        perkXP = 4,
        weapons = {
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        pedLootRolls = 1,
        numberOfPeds = 20,
        stress = 50,
    },
}

svConfig.buffs = {
    currency15 = {
        type = 'currencyIncrease',
        description = '15% more currency',
        amount = 15,
        weight = 5,
        debuffs = {
            { id = 'pedHealth50',        weight = 5 },
            { id = 'pedMovementSpeed30', weight = 10 },
            { id = 'pedMovementSpeed60', weight = 10 },
            { id = 'noSprintJump',       weight = 10 },
        },
    },
    currency25 = {
        type = 'currencyIncrease',
        description = '25% more currency',
        amount = 25,
        weight = 5,
        debuffs = {
            { id = 'pedHealth50',        weight = 5 },
            { id = 'pedArmor60',         weight = 5 },
            { id = 'pedMovementSpeed30', weight = 10 },
            { id = 'pedMovementSpeed60', weight = 10 },
            { id = 'noSprintJump',       weight = 10 },
        },
    },
    currency30 = {
        type = 'currencyIncrease',
        description = '30% more currency',
        amount = 30,
        weight = 5,
        debuffs = {
            { id = 'pedHealth50',               weight = 10 },
            { id = 'pedArmor60',                weight = 10 },
            { id = 'pedMovementSpeed60',        weight = 10 },
            { id = 'incomingDamageIncrease150', weight = 5 },
            { id = 'incomingDamageIncrease200', weight = 5 },
        },
    },
    currency50 = {
        type = 'currencyIncrease',
        description = '50% more currency',
        amount = 50,
        weight = 5,
        hardMode = true,
        debuffs = {
            { id = 'pedHealth50',               weight = 5 },
            { id = 'pedArmor60',                weight = 5 },
            { id = 'incomingDamageIncrease150', weight = 5 },
            { id = 'incomingDamageIncrease200', weight = 5 },
        },
    },
    currency1000 = {
        type = 'killCurrencyIncrease',
        description = '250% more currency for kills and headshots',
        amount = 250,
        weight = 5,
        debuffs = {
            { id = 'oneHealth',                 weight = 20 },
            { id = 'incomingDamageIncrease200', weight = 1 },
        },
    },
    movementSpeed50 = {
        type = 'movementSpeed',
        description = '50% faster movement speed',
        amount = 50,
        weight = 5,
        debuffs = {
            { id = 'maxHealthDecrease25', weight = 20 },
            { id = 'pedMovementSpeed30',  weight = 10 },
            { id = 'pedMovementSpeed60',  weight = 10 },
        },
    },
    movementSpeed75 = {
        type = 'movementSpeed',
        description = '75% faster movement speed',
        amount = 75,
        weight = 5,
        debuffs = {
            { id = 'pedDamage50',         weight = 5 },
            { id = 'pedArmor60',          weight = 5 },
            { id = 'maxHealthDecrease25', weight = 20 },
            { id = 'pedMovementSpeed30',  weight = 10 },
            { id = 'pedMovementSpeed60',  weight = 10 },
        },
    },
    headshotCurrency25 = {
        type = 'headshotCurrencyBoost',
        description = '+25% currency for headshots',
        amount = 25,
        weight = 5,
        debuffs = {
            { id = 'pedDamage50',              weight = 10 },
            { id = 'pedHealth50',              weight = 10 },
            { id = 'pedArmor60',               weight = 10 },
            { id = 'outgoingDamageDecrease40', weight = 10 },
            { id = 'pedDamage100',             weight = 5 },
            { id = 'pedHealth100',             weight = 5 },
            { id = 'pedArmor110',              weight = 5 },
        },
    },
    headshotCurrency35 = {
        type = 'headshotCurrencyBoost',
        description = '+35% currency for headshots',
        amount = 35,
        weight = 5,
        debuffs = {
            { id = 'pedMovementSpeed60', weight = 5 },
            { id = 'pedDamage50',        weight = 10 },
            { id = 'pedHealth50',        weight = 10 },
            { id = 'pedArmor60',         weight = 10 },
        },
    },
    unlimitedSprint = {
        type = 'unlimitedSprint',
        description = 'Unlimited sprint',
        weight = 5,
        debuffs = {
            { id = 'pedMovementSpeed30',       weight = 20 },
            { id = 'pedMovementSpeed60',       weight = 20 },
            { id = 'outgoingDamageDecrease40', weight = 5 },
        },
    },
}

svConfig.debuffs = {
    incomingDamageIncrease150 = {
        type = 'incomingDamageIncrease',
        amount = 150,
        description = 'Take 150% more damage',
    },
    incomingDamageIncrease200 = {
        type = 'incomingDamageIncrease',
        amount = 200,
        description = 'Take 200% more damage',
    },
    outgoingDamageDecrease40 = {
        type = 'outgoingDamageDecrease',
        amount = 0.4,
        description = 'Deal 40% less damage',
    },
    maxHealthDecrease25 = {
        type = 'maxHealthDecrease',
        amount = 25,
        description = '25% less max health',
    },
    noSprintJump = {
        type = 'noSprintJump',
        description = 'No sprinting or jumping',
    },
    oneHealth = {
        type = 'oneHealth',
        description = 'You have 1 health',
    },
    pedDamage50 = {
        type = 'pedDamageIncrease',
        amount = 50,
        description = 'Guards deal 50% more damage',
    },
    pedDamage100 = {
        type = 'pedDamageIncrease',
        amount = 100,
        description = 'Guards deal 100% more damage',
    },
    pedHealth50 = {
        type = 'pedHealthIncrease',
        amount = 50,
        description = 'Guards have 50% more health',
    },
    pedHealth100 = {
        type = 'pedHealthIncrease',
        amount = 100,
        description = 'Guards have 100% more health',
    },
    pedArmor60 = {
        type = 'pedArmorIncrease',
        amount = 60,
        description = 'Guards have 60% more armor',
    },
    pedArmor110 = {
        type = 'pedArmorIncrease',
        amount = 110,
        description = 'Guards have 110% more armor',
    },
    pedMovementSpeed30 = {
        type = 'pedMovementSpeed',
        amount = 30,
        description = 'Guards move 30% faster',
    },
    pedMovementSpeed60 = {
        type = 'pedMovementSpeed',
        amount = 60,
        description = 'Guards move 60% faster',
    },
}

svConfig.shopWeapons = {
    -- pistols
    { itemId = 'weapon_snspistol',     weight = 25, price = 100 },
    { itemId = 'weapon_pistol',        weight = 25, price = 100 },
    { itemId = 'weapon_hipower',       weight = 25, price = 200 },
    { itemId = 'weapon_ceramicpistol', weight = 25, price = 200 },
    { itemId = 'weapon_usp',           weight = 40, price = 350 },
    { itemId = 'weapon_pistol_mk2',    weight = 40, price = 350 },
    { itemId = 'weapon_covertpistol',  weight = 40, price = 350 },
    { itemId = 'weapon_heavypistol',   weight = 10, price = 650 },
    { itemId = 'weapon_pistol50',      weight = 10, price = 650 },
    -- smg
    { itemId = 'weapon_microsmg',      weight = 10, price = 1000 },
    { itemId = 'weapon_smgpistol',     weight = 10, price = 1000 },
    { itemId = 'weapon_minismg',       weight = 10, price = 1000 },
    { itemId = 'weapon_smg',           weight = 10, price = 1000 },
    { itemId = 'weapon_combatpdw',     weight = 10, price = 1000 },
    { itemId = 'weapon_gusenberg',     weight = 10, price = 1000 },
    { itemId = 'weapon_uzi',           weight = 10, price = 1000 },
    { itemId = 'weapon_machinepistol', weight = 10, price = 1000 },
    { itemId = 'weapon_smg_mk2',       weight = 10, price = 1000 },
    { itemId = 'weapon_assaultsmg',    weight = 10, price = 1000 },
    -- ars
    { itemId = 'weapon_tacticalrifle', weight = 5,  price = 2500 },
    { itemId = 'weapon_assaultrifle',  weight = 5,  price = 2500 },
    { itemId = 'weapon_bullpuprifle',  weight = 5,  price = 2500 },
    { itemId = 'weapon_compactrifle',  weight = 5,  price = 2500 },
    { itemId = 'weapon_combatrifle',   weight = 5,  price = 2500 },
}

svConfig.shopItems = {
    -- ammo
    { itemId = 'ammo-9',       weight = 50, amount = 5,  price = 100 },
    { itemId = 'ammo-45',      weight = 25, amount = 10, price = 115 },
    { itemId = 'ammo-rifle',   weight = 5,  amount = 25, price = 125 },
    -- utils
    { itemId = 'bandage',      weight = 10, amount = 2,  price = 100 },
    { itemId = 'horde_revive', weight = 5,  amount = 1,  price = 450 },
    { itemId = 'horde_revive', weight = 5,  amount = 2,  price = 450 },
    -- armor plates
    { itemId = 'armour',       weight = 2,  amount = 2,  price = 1000 },
    -- troll items
    { itemId = 'burger',       weight = 5,  amount = 1,  price = 200 },
    { itemId = 'water',        weight = 5,  amount = 1,  price = 200 },
}

svConfig.shopPerks = {
    damage5 = {
        type = 'outgoingDamageIncrease',
        description = '5% more damage',
        amount = 5,
        weight = 5,
        price = 200,
    },
    damage10 = {
        type = 'outgoingDamageIncrease',
        description = '10% more damage',
        amount = 10,
        weight = 5,
        price = 400,
    },
    damage15 = {
        type = 'outgoingDamageIncrease',
        description = '15% more damage',
        amount = 15,
        weight = 5,
        price = 400,
        isRare = true,
    },
    damageTemporary50 = {
        type = 'outgoingDamageIncrease',
        description = '50% more damage (lasts 2 rounds)',
        amount = 15,
        weight = 5,
        price = 2000,
        isRare = true,
        roundsActive = 2,
    },
    defence5 = {
        type = 'incomingDamageDecrease',
        description = '5% less received damage',
        amount = 5,
        weight = 5,
        price = 200,
    },
    defence10 = {
        type = 'incomingDamageDecrease',
        description = '10% less received damage',
        amount = 10,
        weight = 5,
        price = 450,
    },
    defence15 = {
        type = 'incomingDamageDecrease',
        description = '15% less received damage',
        amount = 15,
        weight = 5,
        price = 450,
    },
    currencyBoost5 = {
        type = 'currencyIncrease',
        description = '5% more currency',
        amount = 5,
        weight = 5,
        price = 500,
    },
    currencyBoost10 = {
        type = 'currencyIncrease',
        description = '10% more currency',
        amount = 10,
        weight = 5,
        price = 1000,
    },
    currencyBoost15 = {
        type = 'currencyIncrease',
        description = '15% more currency',
        amount = 15,
        weight = 5,
        price = 1500,
    },
    currencyBoost20 = {
        type = 'currencyIncrease',
        description = '20% more currency',
        amount = 20,
        weight = 5,
        price = 2000,
    },
    lootingExtend = {
        type = 'lootingExtend',
        description = '30s more time in looting phase',
        amount = 30,
        weight = 5,
        price = 500,
        allowMultiple = true,
    },
    lessGuards10 = {
        type = 'lessGuards',
        description = '10% less guards',
        amount = 10,
        weight = 5,
        price = 1000,
    },
    roundHeal50 = {
        type = 'roundHeal',
        description = 'Every round you receive 50 health',
        amount = 50,
        weight = 5,
        price = 1000,
    },
    roundArmor3 = {
        type = 'roundArmor',
        description = 'Every round you get extra 3 armor plates',
        amount = 3,
        weight = 5,
        price = 1000,
    },
    moreRarePerks = {
        type = 'moreRarePerks',
        description = 'Chance for more rare perks',
        amount = 1,
        weight = 5,
        price = 2500,
    },
    moreRareWeapons = {
        type = 'moreRareWeapons',
        description = 'Chance for more rare weapons',
        amount = 1,
        weight = 5,
        price = 2500,
    },
    stopFire = {
        type = 'stopFire',
        description = 'Fire zones disabled (lasts 1 round)',
        amount = 1,
        weight = 5,
        price = 2500,
        hardMode = true,
    },
}

svConfig.finalShopItemCount = 6

svConfig.shopFinalItems = {
    { itemId = 'warehouse_entry',                       weight = 5,  amount = 1, price = 4000 },
    { itemId = 'moneyroll',                             weight = 12, amount = 1, price = 1000 },
    { itemId = 'boosting_contract_a',                   weight = 10, amount = 1, price = 2500 },
    { itemId = 'pdm_blowtorch',                         weight = 10, amount = 1, price = 1050 },
    { itemId = 'boosting_hack_a',                       weight = 10, amount = 1, price = 2250 },
    { itemId = 'boosting_hack_b',                       weight = 10, amount = 1, price = 2150 },
    { itemId = 'boosting_hack_c',                       weight = 10, amount = 1, price = 1500 },
    { itemId = 'boosting_hack_d',                       weight = 10, amount = 1, price = 500 },
    { itemId = 'boosting_hack_c',                       weight = 10, amount = 1, price = 4000 },
    { itemId = 'boosting_hack_d',                       weight = 10, amount = 1, price = 2500 },
    { itemId = 'crypto_usb_trj',                        weight = 10, amount = 1, price = 5000 },
    { itemId = 'crypto_usb_5race',                      weight = 10, amount = 1, price = 2500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 1, price = 4500 },
    { itemId = 'boosting_vinscratch_a',                 weight = 1,  amount = 1, price = 35000 },
    { itemId = 'blueprint_for_horde_hard_start',        weight = 1,  amount = 1, price = 7000 },
    { itemId = 'boosting_vinscratch_b',                 weight = 1,  amount = 1, price = 25000 },
    { itemId = 'cbs_entry_pass',                        weight = 5,  amount = 1, price = 20000 },
    { itemId = 'blueprint_wire_snitch_mk2',             weight = 10, amount = 1, price = 2500 },
    { itemId = 'blueprint_usb_phone_data',              weight = 10, amount = 1, price = 3500 },
    { itemId = 'blueprint_usb_phone_tap',               weight = 10, amount = 1, price = 2500 },
    { itemId = 'blueprint_listening_device',            weight = 10, amount = 1, price = 4500 },
    { itemId = 'blueprint_infiltrator_station',         weight = 10, amount = 1, price = 2500 },
    { itemId = 'blueprint_frequency_changer',           weight = 10, amount = 1, price = 4500 },
    { itemId = 'gang_chip_2',                           weight = 15, amount = 1, price = 500 },
    { itemId = 'blueprint_weapon_rack',                 weight = 1,  amount = 1, price = 15000 },
    -- {itemId = 'blueprint_for_pistol50', weight = 1, amount = 1, price = 25000},
    { itemId = 'horde_syndicate_token',                 weight = 2,  amount = 1, price = 10500 },
    { itemId = 'horde_cartel_token',                    weight = 2,  amount = 1, price = 10500 },
    { itemId = 'horde_mob_token',                       weight = 2,  amount = 1, price = 10500 },
    { itemId = 'ocean_run_entry',                       weight = 5,  amount = 1, price = 7500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 1, price = 5500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 2, price = 7500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 3, price = 9500 },
    { itemId = 'civ_book_rep',                          weight = 10, amount = 1, price = 5000 },
    { itemId = 'crime_book_rep',                        weight = 10, amount = 1, price = 5000 },
    { itemId = 'c_ammonia_barrel',                      weight = 10, amount = 1, price = 5000, metaData = { ammoniaLeft = 1000 } },
    { itemId = 'bank_small_drill',                      weight = 10, amount = 1, price = 5000 },
    { itemId = 'bank_thermite',                         weight = 10, amount = 1, price = 5000 },
    { itemId = 'bank_bomb',                             weight = 10, amount = 1, price = 5000 },
    { itemId = 'ammo_pistol',                           weight = 15, amount = 1, price = 500 },
    { itemId = 'jwh_start',                             weight = 1,  amount = 1, price = 15500 },
    { itemId = 'pdm_entry_pass',                        weight = 1,  amount = 1, price = 13500 },
    { itemId = 'blueprint_for_horde_hard_start',        weight = 1,  amount = 1, price = 25000 },
    { itemId = 'goldbar',                               weight = 10, amount = 1, price = 5000 },
    { itemId = 'diamond_ring',                          weight = 5,  amount = 1, price = 8500 },
    { itemId = 'rolex',                                 weight = 1,  amount = 1, price = 12500 },
    { itemId = 'goldbar',                               weight = 1,  amount = 2, price = 7500 },
    { itemId = 'diamond',                               weight = 5,  amount = 1, price = 5500 },
    { itemId = 'gold_chain',                            weight = 10, amount = 1, price = 3500 },
    { itemId = 'rolex',                                 weight = 1,  amount = 1, price = 7500 },
    { itemId = 'silver_earring',                        weight = 5,  amount = 1, price = 5500 },
    { itemId = 'diamond',                               weight = 10, amount = 2, price = 3500 },
    {
        itemId = 'case',
        weight = 5,
        amount = 1,
        price = 10000,
        metaData = {
            caseId = 'SKIN_CASE_V2',
            label = locale('SKIN_CASE_ITEM'),
            image = 'skin_case_v2',
        }
    },
}

--------- HARD MODE CONFIGS
svConfig.hardMission = {
    name = 'horde-hard',
    label = locale('HARD_HORDE_MISSION_LABEL'),
    description = locale('HARD_HORDE_MISSION_DESCRIPTION'),
    type = 'heist',
    minimalGroupSize = config.debug and 1 or 4,
    maximumGroupSize = 5,
    hasQueue = true,
    policeRequired = config.debug and 0 or 4,
    required = { type = 'item', name = 'horde_hard_start', label = locale('HARD_HORDE_START_ITEM_LABEL'), value = 1 },
    timeout = 180, -- timeout is in minutes, current value is 3 hours
    concurrentMissions = 5,
    cooldown = 60, -- minutes
    npc = {
        model = { `s_m_y_ammucity_01`, `s_m_y_blackops_02`, `s_m_y_prisoner_01` },
        randomLocation = true,
        locations = {
            vector4(576.4706, 2790.6145, 42.2009, 7.5290),
            vector4(-1798.7573, 3104.3516, 32.8418, 64.8927),
            vector4(-1663.8402, 158.3043, 61.7490, 112.3142)
        }
    }
}

svConfig.hardShopRolls = 10

svConfig.hardShopItems = {
    -- ammo
    { itemId = 'AMMO_PISTOL',          weight = 50, amount = 5,  price = 100 },
    { itemId = 'AMMO_SMG',             weight = 25, amount = 10, price = 115 },
    { itemId = 'AMMO_RIFLE',           weight = 5,  amount = 25, price = 125 },
    -- utils
    { itemId = 'firstaid',             weight = 10, amount = 2,  price = 100 },
    { itemId = 'heavyarmor',           weight = 10, amount = 2,  price = 250 },
    { itemId = 'painkillers',          weight = 10, amount = 1,  price = 250 },
    { itemId = 'painkillers',          weight = 2,  amount = 2,  price = 500 },
    { itemId = 'sandwich',             weight = 10, amount = 2,  price = 250 },
    { itemId = 'water',                weight = 10, amount = 4,  price = 250 },
    { itemId = 'bandage',              weight = 10, amount = 4,  price = 150 },
    { itemId = 'firstaid',             weight = 10, amount = 2,  price = 250 },
    { itemId = 'horde_crate_key',      weight = 10, amount = 1,  price = 500 },
    { itemId = 'horde_revive',         weight = 5,  amount = 1,  price = 450 },
    -- armor
    { itemId = 'heavyarmor',           weight = 5,  amount = 5,  price = 500 },
    { itemId = 'heavyarmor',           weight = 2,  amount = 2,  price = 1000 },
    { itemId = 'heavyarmor',           weight = 2,  amount = 1,  price = 1000 },
    -- consumables
    { itemId = 'sandwich',             weight = 2,  amount = 2,  price = 250 },
    { itemId = 'water',                weight = 2,  amount = 2,  price = 250 },
    { itemId = 'firstaid',             weight = 2,  amount = 2,  price = 750 },
}

svConfig.hardShopWeapons = {
    -- Pistols
    { itemId = 'weapon_ceramicpistol', weight = 50, price = 200 },
    {
        itemId = 'weapon_ceramicpistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_ceramicpistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_covertpistol',  weight = 80, price = 350 },
    {
        itemId = 'weapon_covertpistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_covertpistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_heavypistol', weight = 20, price = 650 },
    {
        itemId = 'weapon_heavypistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_heavypistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_hipower',     weight = 50, price = 200 },
    {
        itemId = 'weapon_hipower',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_hipower',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_pistol',   weight = 50, price = 100 },
    {
        itemId = 'weapon_pistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_pistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_pistol50', weight = 20, price = 650 },
    {
        itemId = 'weapon_pistol50',
        weight = 5,
        price = 1000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_pistol50',
        weight = 1,
        price = 1500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_pistol_mk2', weight = 80, price = 350 },
    {
        itemId = 'weapon_pistol_mk2',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_pistol_mk2',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_snspistol',  weight = 50, price = 100 },
    {
        itemId = 'weapon_snspistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_snspistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_usp',        weight = 80, price = 350 },
    {
        itemId = 'weapon_usp',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_usp',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },

    -- SMGs
    { itemId = 'weapon_assaultsmg', weight = 20, price = 1000 },
    {
        itemId = 'weapon_assaultsmg',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_assaultsmg',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_combatpdw', weight = 20, price = 1000 },
    {
        itemId = 'weapon_combatpdw',
        weight = 5,
        price = 2000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_combatpdw',
        weight = 1,
        price = 2500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_gusenberg', weight = 20, price = 1000 },
    {
        itemId = 'weapon_gusenberg',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_gusenberg',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_machinepistol', weight = 20, price = 1000 },
    {
        itemId = 'weapon_machinepistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_machinepistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_microsmg',      weight = 20, price = 1000 },
    {
        itemId = 'weapon_microsmg',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_microsmg',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_minismg', weight = 20, price = 1000 },
    {
        itemId = 'weapon_minismg',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_minismg',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_smg',     weight = 20, price = 1000 },
    {
        itemId = 'weapon_smg',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_smg',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_smg_mk2',   weight = 20, price = 1000 },
    {
        itemId = 'weapon_smg_mk2',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_smg_mk2',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_smgpistol', weight = 20, price = 1000 },
    {
        itemId = 'weapon_smgpistol',
        weight = 5,
        price = 1500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_smgpistol',
        weight = 1,
        price = 2000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_uzi',          weight = 20, price = 1000 },
    {
        itemId = 'weapon_uzi',
        weight = 5,
        price = 1000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_uzi',
        weight = 1,
        price = 1000,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },

    -- ARs
    { itemId = 'weapon_assaultrifle', weight = 10, price = 2500 },
    {
        itemId = 'weapon_assaultrifle',
        weight = 5,
        price = 3000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_assaultrifle',
        weight = 1,
        price = 3500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_bullpuprifle', weight = 10, price = 2500 },
    {
        itemId = 'weapon_bullpuprifle',
        weight = 5,
        price = 3000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_bullpuprifle',
        weight = 1,
        price = 3500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_combatrifle',  weight = 10, price = 2500 },
    {
        itemId = 'weapon_combatrifle',
        weight = 5,
        price = 2500,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_combatrifle',
        weight = 1,
        price = 2500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_compactrifle',  weight = 10, price = 2500 },
    {
        itemId = 'weapon_compactrifle',
        weight = 5,
        price = 3000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_compactrifle',
        weight = 1,
        price = 3500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
    { itemId = 'weapon_tacticalrifle', weight = 10, price = 2500 },
    {
        itemId = 'weapon_tacticalrifle',
        weight = 5,
        price = 3000,
        metaData = {
            damageModifier = 1.2,
            rarity = 'EPIC',
        }
    },
    {
        itemId = 'weapon_tacticalrifle',
        weight = 1,
        price = 3500,
        metaData = {
            damageModifier = 1.4,
            rarity = 'LEGENDARY',
        }
    },
}

svConfig.hardFinalShopItemCount = 6

svConfig.hardShopFinalItems = {
    { itemId = 'warehouse_entry',                       weight = 5,  amount = 1, price = 4000 },
    { itemId = 'boosting_contract_a',                   weight = 10, amount = 1, price = 2500 },
    { itemId = 'pdm_blowtorch',                         weight = 10, amount = 1, price = 1050 },
    { itemId = 'boosting_hack_a',                       weight = 10, amount = 1, price = 2250 },
    { itemId = 'boosting_hack_b',                       weight = 10, amount = 1, price = 2150 },
    { itemId = 'crypto_usb_trj',                        weight = 10, amount = 1, price = 5000 },
    { itemId = 'crypto_usb_5race',                      weight = 10, amount = 1, price = 2500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 1, price = 4500 },
    { itemId = 'boosting_vinscratch_a',                 weight = 1,  amount = 1, price = 35000 },
    { itemId = 'boosting_vinscratch_b',                 weight = 1,  amount = 1, price = 25000 },
    { itemId = 'cbs_entry_pass',                        weight = 5,  amount = 1, price = 15000 },
    { itemId = 'rolex',                                 weight = 1,  amount = 1, price = 15000 },
    { itemId = 'ocean_run_entry',                       weight = 5,  amount = 1, price = 7500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 1, price = 5500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 2, price = 7500 },
    { itemId = 'crypto_usb_script',                     weight = 10, amount = 3, price = 9500 },
    { itemId = 'civ_book_rep',                          weight = 10, amount = 1, price = 5000 },
    { itemId = 'crime_book_rep',                        weight = 10, amount = 1, price = 5000 },
    { itemId = 'c_ammonia_barrel',                      weight = 10, amount = 1, price = 5000, metaData = { ammoniaLeft = 1000 } },
    { itemId = 'bank_small_drill',                      weight = 10, amount = 1, price = 5000 },
    { itemId = 'bank_thermite',                         weight = 10, amount = 1, price = 5000 },
    { itemId = 'bank_bomb',                             weight = 10, amount = 1, price = 5000 },
    { itemId = 'ammo_pistol',                           weight = 15, amount = 1, price = 500 },
    { itemId = 'jwh_start',                             weight = 1,  amount = 1, price = 15500 },
    { itemId = 'pdm_entry_pass',                        weight = 1,  amount = 1, price = 13500 },
    { itemId = 'goldbar',                               weight = 10, amount = 1, price = 5000 },
    { itemId = 'diamond_ring',                          weight = 5,  amount = 1, price = 8500 },
    { itemId = 'rolex',                                 weight = 1,  amount = 1, price = 12500 },
    { itemId = 'goldbar',                               weight = 1,  amount = 2, price = 7500 },
    { itemId = 'diamond',                               weight = 5,  amount = 1, price = 5500 },
    { itemId = 'gold_chain',                            weight = 10, amount = 1, price = 3500 },
    { itemId = 'rolex',                                 weight = 1,  amount = 1, price = 7500 },
    { itemId = 'silver_earring',                        weight = 5,  amount = 1, price = 5500 },
    { itemId = 'diamond',                               weight = 10, amount = 2, price = 3500 },
    { itemId = 'goldbar',                               weight = 1,  amount = 1, price = 3000 },
    { itemId = 'diamond_ring',                          weight = 1,  amount = 2, price = 25000 },
    { itemId = 'rolex',                                 weight = 1,  amount = 2, price = 25000 },
    { itemId = 'gold_chain',                            weight = 1,  amount = 2, price = 5000 },
    { itemId = 'silver_earring',                        weight = 1,  amount = 3, price = 5000 },
    { itemId = 'civ_book_rep',                          weight = 10, amount = 1, price = 2000 },
    { itemId = 'crime_book_rep',                        weight = 10, amount = 1, price = 2000 },
    { itemId = 'drug_race_map',                         weight = 1,  amount = 1, price = 5000 },
    { itemId = 'drug_race_plans',                       weight = 1,  amount = 1, price = 5000 },
    {
        itemId = 'case',
        weight = 5,
        amount = 1,
        price = 2500,
        metaData = {
            caseId = 'CASE_WITH_GUN_UPGRADE',
            label = locale('CASE_WITH_GUN_UPGRADE_ITEM'),
            image = 'case_with_gun_upgrade',
        }
    },
    {
        itemId = 'case',
        weight = 5,
        amount = 1,
        price = 2500,
        metaData = {
            caseId = 'SKIN_CASE_V2',
            label = locale('SKIN_CASE_ITEM'),
            image = 'skin_case_v2',
        }
    },
}

svConfig.mutations = {
    meleeZombies = {
        weight = 10,
    },
    explodingPeds = {
        weight = 10,
    },
    blackout = {
        weight = 10,
    },
    juggernaut = {
        armor = 150,
        health = 150,
        models = {
            `u_m_y_juggernaut_01`,
        },
    },
    noRevives = {
        weight = 10,
    },
    increasedAccuracy = {
        weight = 10,
        amount = 30,
    },
}

svConfig.hardDamagePercentIncrease = 100
svConfig.hardReviveAmount = 5

svConfig.boss = {
    health = 1000,
    armor = 1000,
    accuracy = 75,
    killReward = 5000,
    minWave = 15,
    maxCount = 1,
    baseChance = 100,
    weaponPool = {
        { hash = `WEAPON_MINIGUN`,         weight = 10 },
        { hash = `WEAPON_GRENADELAUNCHER`, weight = 5 },
    },
}

svConfig.elite = {
    health = 800,
    armor = 800,
    accuracy = 50,
    killReward = 2500,
    minWave = 5,
    maxCount = 1,
    baseChance = 10,
    weaponPool = {
        { hash = `WEAPON_ASSAULTRIFLE`,    weight = 10 },
        { hash = `WEAPON_GRENADELAUNCHER`, weight = 5 },
        { hash = `WEAPON_MINIGUN`,         weight = 2 },
    },
}

svConfig.hardModeTotalWaves = 15

svConfig.hardWaves = {
    [1] = {
        health = 150,
        armor = 150,
        accuracy = 30,
        lootingTime = 200,
        killingTime = 300,
        revivePrice = 50,
        reviveAdd = 2,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 10 },
            { hash = `WEAPON_SMG`,          weight = 1 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 1 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 8,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 2, max = 2 },
        poison = { min = 1, max = 1 },
        crates = {
            min = 1,
            max = 1,
            chance = 100,
            lootRolls = 6,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [2] = {
        health = 175,
        armor = 175,
        accuracy = 30,
        lootingTime = 190,
        killingTime = 300,
        revivePrice = 100,
        reviveAdd = 2,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 9 },
            { hash = `WEAPON_SMG`,          weight = 2 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 1 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 12,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 3 },
        poison = { min = 1, max = 2 },
        crates = {
            min = 2,
            max = 2,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [3] = {
        health = 200,
        armor = 200,
        accuracy = 30,
        lootingTime = 180,
        killingTime = 300,
        revivePrice = 100,
        reviveAdd = 2,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 8 },
            { hash = `WEAPON_SMG`,          weight = 3 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 1 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 12,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 4 },
        poison = { min = 1, max = 3 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [4] = {
        health = 200,
        armor = 200,
        accuracy = 30,
        lootingTime = 170,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 2,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 7 },
            { hash = `WEAPON_SMG`,          weight = 4 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 1 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 12,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 5 },
        poison = { min = 1, max = 4 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [5] = {
        health = 225,
        armor = 225,
        accuracy = 30,
        lootingTime = 160,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 5,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 6 },
            { hash = `WEAPON_SMG`,          weight = 5 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 2 }, -- AR begins scaling
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 12,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 6 },
        poison = { min = 1, max = 5 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [6] = {
        health = 250,
        armor = 250,
        accuracy = 30,
        lootingTime = 150,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 5,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 5 },
            { hash = `WEAPON_SMG`,          weight = 6 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 3 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 12,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 7 },
        poison = { min = 1, max = 6 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [7] = {
        health = 250,
        armor = 250,
        accuracy = 30,
        lootingTime = 140,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 5,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 4 },
            { hash = `WEAPON_SMG`,          weight = 7 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 4 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 16,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 8 },
        poison = { min = 1, max = 7 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [8] = {
        health = 285,
        armor = 285,
        accuracy = 35,
        lootingTime = 130,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 5,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 3 },
            { hash = `WEAPON_SMG`,          weight = 8 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 6 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 16,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 9 },
        poison = { min = 1, max = 8 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [9] = {
        health = 285,
        armor = 285,
        accuracy = 35,
        lootingTime = 120,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 5,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 2 },
            { hash = `WEAPON_SMG`,          weight = 8 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 8 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 16,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            -- {type = 'juggernaut', weight = 10},
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 10 },
        poison = { min = 1, max = 9 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [10] = {
        health = 285,
        armor = 285,
        accuracy = 35,
        lootingTime = 110,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 0,
        weapons = {
            { hash = `WEAPON_PISTOL`,       weight = 1 },
            { hash = `WEAPON_SMG`,          weight = 7 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 10 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 20,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            { type = 'juggernaut',        weight = 10 },
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 11 },
        poison = { min = 1, max = 10 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [11] = {
        health = 325,
        armor = 325,
        accuracy = 35,
        lootingTime = 100,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 0,
        weapons = {
            { hash = `WEAPON_SMG`,          weight = 6 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 12 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 20,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            { type = 'juggernaut',        weight = 10 },
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 12 },
        poison = { min = 1, max = 11 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [12] = {
        health = 325,
        armor = 325,
        accuracy = 35,
        lootingTime = 90,
        killingTime = 300,
        revivePrice = 200,
        reviveAdd = 0,
        weapons = {
            { hash = `WEAPON_SMG`,          weight = 5 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 13 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 20,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            { type = 'juggernaut',        weight = 10 },
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 13 },
        poison = { min = 1, max = 12 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [13] = {
        health = 325,
        armor = 325,
        accuracy = 35,
        lootingTime = 80,
        killingTime = 300,
        revivePrice = 500,
        reviveAdd = 0,
        weapons = {
            { hash = `WEAPON_SMG`,          weight = 4 },
            { hash = `WEAPON_ASSAULTRIFLE`, weight = 14 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 20,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            { type = 'juggernaut',        weight = 10 },
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 14 },
        poison = { min = 1, max = 13 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [14] = {
        health = 325,
        armor = 325,
        accuracy = 35,
        lootingTime = 70,
        killingTime = 300,
        revivePrice = 500,
        reviveAdd = 0,
        weapons = {
            { hash = `WEAPON_SMG`,             weight = 3 },
            { hash = `WEAPON_ASSAULTRIFLE`,    weight = 15 },
            { hash = `WEAPON_GRENADELAUNCHER`, weight = 1 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 20,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            { type = 'juggernaut',        weight = 10 },
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 15 },
        poison = { min = 1, max = 14 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
    [15] = {
        health = 350,
        armor = 350,
        accuracy = 35,
        lootingTime = 60,
        killingTime = 300,
        revivePrice = 1500,
        reviveAdd = 0,
        weapons = {
            { hash = `WEAPON_SMG`,             weight = 2 },
            { hash = `WEAPON_ASSAULTRIFLE`,    weight = 16 },
            { hash = `WEAPON_GRENADELAUNCHER`, weight = 1 },
        },
        gangXP = 30,
        perkXP = 4,
        pedLootRolls = 1,
        numberOfPeds = 20,
        mutationCount = 1,
        mutations = {
            -- {type = 'meleeZombies', weight = 10},
            { type = 'explodingPeds',     weight = 10 },
            { type = 'blackout',          weight = 5 },
            { type = 'juggernaut',        weight = 10 },
            { type = 'noRevives',         weight = 10 },
            { type = 'increasedAccuracy', weight = 10 },
        },
        fire = { min = 1, max = 16 },
        poison = { min = 1, max = 15 },
        crates = {
            min = 2,
            max = 3,
            chance = 100,
            lootRolls = 1,
            lootTable = {
                COMMON = {
                    { name = 'firstaid',        min = 2, max = 4 },
                    { name = 'heavyarmor',      min = 2, max = 4 },
                    { name = 'splint',          min = 1, max = 1 },
                    { name = 'improved_splint', min = 2, max = 4 },
                    { name = 'gauze',           min = 4, max = 8 },
                    { name = 'bandage',         min = 4, max = 8 },
                    { name = 'morphine',        min = 2, max = 4 },
                    { name = 'horde_revive',    min = 1, max = 1 },
                    { name = 'ammo_pistol',     min = 5, max = 10 },
                    { name = 'ammo_smg',        min = 5, max = 10 },
                    { name = 'ammo_rifle',      min = 5, max = 10 },
                },
            },
            guaranteedRarities = {
                COMMON = 1,
            },
        },
    },
}

svConfig.zombiePedModels = {
    `u_m_y_zombie_01`,
}

svConfig.zombieWeapons = {
    { hash = `WEAPON_HATCHET`, weight = 10 },
}

svConfig.halloween = false

svConfig.halloweenPedModels = {
    `u_m_y_zombie_01`,
}
