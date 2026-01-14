Config = {} -- Do not alter

-- 🔎 Looking for more high quality scripts?
-- 🛒 Shop Now: https://lationscripts.com
-- 💬 Join Discord: https://discord.gg/9EbY4nM5uu
-- 😢 How dare you leave this option false?!
Config.YouFoundTheBestScripts = false

----------------------------------------------
--        🛠️ Setup the basics below
----------------------------------------------

Config.Setup = {
    -- Use only if needed, directed by support or know what you're doing
    -- Notice: enabling debug features will significantly increase resmon
    -- And should always be disabled in production
    debug = false,
    -- Do you want to be notified via server console if an update is available?
    version = false,
    -- Target system, available options are: 'ox_target', 'qb-target', 'qtarget', 'custom' & 'none'
    -- 'custom' needs to be added to client/functions.lua
    -- If 'none' then TextUI is used instead of targeting
    target = 'ox_target',
    -- Notification system, available options are: 'ox_lib', 'esx', 'qb', 'okok' & 'custom'
    -- 'custom' needs to be added to client/functions.lua
    notify = 'ox_lib',
    -- If using TextUI (Config.Setup.target = 'none') then what key do you want to open the shop?
    -- Default is 38 (E), find more control ID's here: https://docs.fivem.net/docs/game-references/controls/
    interact = 38,
    -- 'auto_clear' is a system to automatically clear shops after certain amount of time
    auto_clear = {
        -- Do you want to enable the auto clearing system?
        enable = true,
        -- If enable = true, how long (in minutes) should shops be cleared?
        interval = 60 * 5
    }
}

----------------------------------------------
--       🏪 Create your pawn shops
----------------------------------------------

Config.Shops = {
    ['vinewood'] = { -- Unique identifier for this shop
        name = 'Pawn & Jewelry', -- Shop name
        slots = 25, -- How many slots are available
        weight = 100000, -- How much weight is available
        coords = vec4(-1459.2361, -413.2576, 35.75, 180.0), -- Where this shop exists
        radius = 2.0, -- How large of a circle zone radius (for targeting only)
        spawnPed = true, -- Spawn a ped to interact with here?
        pedModel = 'a_m_y_beach_02', -- If spawnPed = true, what ped model?
        -- You can limit the hours at which the shop is available here
        -- Min is the earliest the shop is available (default 06:00AM)
        -- Max is the latest the shop is available (detault 21:00 aka 9PM)
        -- If you want it available 24/7, set min to 0 and max to 24
        hour = { min = 6, max = 18 },
        account = 'dirty', -- Give 'cash', 'bank' or 'dirty' money when selling here?
        allowlist = {
            ['golden_banana'] = { label = 'Golden Banana', price = math.random(5000, 7500) },
            ['emerald'] = { label = 'Emerald', price = math.random(1000, 2500) },
            ['ruby_necklace'] = { label = 'Ruby Necklace', price = math.random(1000, 2500) },
            ['panther'] = { label = 'Panther', price = math.random(1000, 2500) },
            ['ruby'] = { label = 'Ruby', price = math.random(1000, 2500) },
            ['jewels'] = { label = 'Jewels', price = math.random(50, 100) },
        },
        -- If placeholders = true then the "slots" amount above will be overridden
        -- This option will fill the shop with "display" items, and only
        -- Display items that are possible to sell here. If false, it will be
        -- An empty inventory, and the "slots" amount above will not be overridden
        placeholders = true,
        blip = {
            enabled = true,
            sprite = 59, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 0, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.8,
            label = 'Pawn & Jewlery'
        }
    },
}