


-- STEP 1: Put the Polartheplug_weaponpack folder into your resources folder and then ensure it in your server.cfg
-- STEP 2: ADD IMAGES TO INVENTORY     [qs-inventory\html\images]
-- STEP 3: ADD FIRST CODE LIST TO      [qs-inventory\shared\items.lua]   under the ItemList =  {
-- STEP 4: ADD SECOND CODE LIST TO     [qs-inventory\shared\weapons.lua] under the WeaponList =  {
-- STEP 5: ADD THIRD CODE LIST TO      [qs-inventory\config\weapons.lua] under the Config.DurabilityMultiplier = { 

STEP 3
## qs-inventory\shared\items.lua

['weapon_glizzy'] =  {
    ['name'] =  'weapon_glizzy',
    ['label'] =  'Glizzy',
    ['weight'] =  500,
    ['type'] =  'weapon',
    ['ammotype'] = nil,
    ['image'] =  'weapon_glizzy.png',
    ['unique'] =  true,
    ['useable'] =  false,
    ['description'] =  'it does not contain a description.'
},



STEP 4
-- qs-inventory\shared\weapons.lua

local weapons = {
    ['WEAPON_GLIZZY'] =  {
        ['name'] = 'WEAPON_GLIZZY',
        ['label'] = 'Glizzy',
        ['weapontype'] = 'Melee',
        ['ammotype'] = nil,
        ['damagereason'] = 'Slapped / Violated / Eviscerated'
    },
}


STEP 5
-----if you are using qb-core then put these in your qb-core/shared/weapons.lua

[`weapon_glizzy`]                = { name = 'weapon_glizzy', label = 'Glizzy', weapontype = 'Melee', ammotype = nil, damagereason = 'Slapped / Violated / Eviscerated' },
	
    
    qs-inventory\config\weapons.lua
    -- Drop this under the Config.DurabilityMultiplier 
    
        ['WEAPON_GLIZZY']           = 0.10,
       
    