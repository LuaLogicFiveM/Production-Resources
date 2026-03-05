

    MAKE SURE TO ADD THE IMAGES IN QB-INVENTORY - HTML - IMAGES 

-- STEP 1: Put Polartheplug_Glizzy folder into your resources then ensure it in your server.cfg

-- STEP 2: ADD FIRST CODE LIST TO    ■   [qb-core/shared/items.lua]                                    ■  under the | QBShared.Items = 

    weapon_glizzy = { name = 'weapon_glizzy', label = 'Glizzy', weight = 500, type = 'weapon', ammotype = nil, image = 'weapon_glizzy.png', unique = false, useable = true, description = 'A large Glizzy' },
    

-- STEP 3: ADD THIRD CODE LIST TO    ■   [qb-smallresources/client/weapdraw.lua]                       ■  under the | local weapons = {

'WEAPON_GLIZZY',


-- STEP 4: ADD FOURTH CODE LIST TO   ■   [qb-weapons/config.lua]                                ■  under the | Config.DurabilityMultiplier = 

weapon_glizzy          = 0.15,


