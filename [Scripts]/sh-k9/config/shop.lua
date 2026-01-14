--[[ 
    ================================================================================================
    K9 EQUIPMENT SHOP SYSTEM
    ================================================================================================
    
    REQUIREMENTS:
    • Framework (QBCore, QBX, ESX, or ND)
    • Inventory system compatible with your framework
    • Items must be registered in your inventory system
    
    IMPORTANT:
    • This system only works with supported frameworks and inventories
    • Standalone users cannot use this shop system
    • All items must exist in your inventory configuration before enabling this shop
    
    ================================================================================================
]]--

local settings = require 'config.config'
local k9_items = settings.items -- Import item settings from main configuration

return {
    --[[ 
        SHOP SYSTEM TOGGLE
        Enable or disable the K9 equipment shop entirely
    ]]
    enable = false, -- Set to false to completely disable the shop system

    --[[ 
        SHOP TYPE CONFIGURATION
        Choose how players access the K9 equipment shop
        
        OPTIONS:
        • 'npc' = Shop accessed through an NPC at a specific location
        • 'house' = Shop accessed through dog house interaction (if dog house system is enabled)
    ]]
    type = 'npc', -- Change to 'house' if you want shop integrated with dog houses

    --[[ 
        NPC SHOP CONFIGURATION
        Only used when type = 'npc'
        Configure the appearance and location of the shop NPC
    ]]
    npc = {
        skin = `s_m_y_cop_01`, -- NPC model hash (police officer by default)
        pos = vector4(421.38, -1011.21, 28.12, 181.43), -- x, y, z, heading (Mission Row Police Station)
        scenario = 'WORLD_HUMAN_COP_IDLES' -- NPC animation
        
        --[[ 
            ALTERNATIVE NPC MODELS:
            • `s_f_y_cop_01` = Female police officer
            • `s_m_m_security_01` = Security guard
            • `a_m_y_business_01` = Business person
            • `s_m_y_construct_01` = Construction worker
            
            SCENARIO OPTIONS:
            • 'WORLD_HUMAN_STAND_IMPATIENT' = Standing and waiting
            • 'WORLD_HUMAN_CLIPBOARD' = Holding clipboard
            • 'WORLD_HUMAN_GUARD_STAND' = Security guard stance
            
            More scenarios: https://wiki.rage.mp/index.php?title=Scenarios
        ]]
    },

    --[[ 
        SHOP INVENTORY
        Configure all items available for purchase in the K9 shop
        
        ITEM CONFIGURATION STRUCTURE:
        • label = Display name shown in shop menu
        • description = Helpful text explaining item purpose
        • icon = Font Awesome icon (without 'fa-' prefix gets added automatically)
        • item = Item name from inventory system (imported from main config)
        • price = Cost in server currency (0 = free)
        
        ICON REFERENCE: https://fontawesome.com/icons
    ]]
    items = {
        --[[ SURVEILLANCE EQUIPMENT ]]--
        {
            label = 'Camera',
            description = 'Mount bodycam and watch his perspective.',
            icon = 'fa-camera',
            item = k9_items.camera, -- References camera item from main config
            price = 0,
        },
        {
            label = 'GPS',
            description = 'Never lose location of your doggie.',
            icon = 'fa-location-dot',
            item = k9_items.gps, -- References GPS item from main config
            price = 0,
        },

        --[[ CARE & MAINTENANCE ]]--
        {
            label = 'Food',
            description = "Give him some snacks, he's hungry!",
            icon = 'fa-bone',
            item = k9_items.feed, -- References feed item from main config
            price = 0,
        },
        {
            label = 'Leash',
            description = "Take him for the walk.",
            icon = 'fa-dog',
            item = k9_items.leash, -- References leash item from main config
            price = 0,
        },

        --[[ PROTECTIVE EQUIPMENT ]]--
        {
            label = 'Armor',
            description = "Increases armor to withstand more damage.",
            icon = 'fa-shield-halved',
            item = k9_items.armor, -- References armor item from main config
            price = 0,
        },

        --[[ MEDICAL SUPPLIES ]]--
        {
            label = 'Bandage',
            description = "Restores a small amount of health.",
            icon = 'fa-heart',
            item = k9_items.heal, -- References heal item from main config
            price = 0,
        },
        {
            label = 'Medkit',
            description = "Revives your dog.",
            icon = 'fa-suitcase-medical',
            item = k9_items.medkit, -- References medkit item from main config
            price = 0,
        },

        --[[ 
            ADD CUSTOM ITEMS HERE:
            
            {
                label = 'Item Display Name',
                description = 'Detailed description of what this item does and why players need it.',
                icon = 'fa-icon-name', -- Font Awesome icon name
                item = 'your_item_name', -- Must match inventory item name exactly
                price = 100, -- Price in server currency
            },
            
            EXAMPLE ADDITIONAL ITEMS:
            
            {
                label = 'K9 Toy Ball',
                description = 'Training ball for fetch commands.',
                icon = 'fa-baseball',
                item = k9_items.ball,
                price = 25,
            },
            {
                label = 'Training Frisbee',
                description = 'Training tool for agility and distance fetch commands.',
                icon = 'fa-circle',
                item = k9_items.frisbee,
                price = 35,
            },
        ]]
    },
}

--[[ 
    ================================================================================================
    CONFIGURATION GUIDE & TROUBLESHOOTING
    ================================================================================================
    
    SETUP INSTRUCTIONS:
    
    1. ENABLE FRAMEWORK INTEGRATION:
       • Ensure you're using QBCore, QBX, ESX, or ND Framework
       • Verify inventory system is working properly
       • Test item giving/receiving before enabling shop
    
    2. CONFIGURE ITEMS IN MAIN CONFIG:
       • Go to configs/config.lua
       • Set item names in the 'items' section
       • Ensure all item names match your inventory exactly
       • Set to 'false' to disable items you don't want in shop
    
    3. REGISTER ITEMS IN INVENTORY:
       • Add all K9 items to your inventory's item database
       • Include proper item descriptions and metadata
       • Test spawning items manually before enabling shop
    
    4. CUSTOMIZE SHOP LOCATION:
       • Change NPC position to fit your server's layout
       • Consider placing near police stations or training facilities
       • Ensure location is accessible and logical for roleplay
    
    ================================================================================================
    
    TROUBLESHOOTING COMMON ISSUES:
    
    ITEMS NOT WORKING:
    • Confirm item names match inventory exactly (case-sensitive)
    • Check if items are properly registered in inventory
    • Verify main config has correct item names (not 'false')
    
]]