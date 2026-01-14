Config = {}

Config.Debug = false
Config.RequireItems = false -- Enable the items requirements and usage
Config.KitchenSpecificJobs = true -- Enable kitchen specific job requirements (if you dont have kitchen specific jobs you can disable this to improve performance)
Config.CheckItems = false -- Check if items are available in your inventory (do not disable if you do not know what you are doing)
Config.FirePropagateToPlayers = false -- Fire will propagate to all players (also causing fire damage)

Config.Recovery = true -- When a player with a pickup in hand left the server, the server will try to retrieve the pickup and reposition it where it was taken, if that slot is not empty it will be cleared.

Config.RenderScaleforms = 20
Config.CookingAnimationSmoothness = 120 -- higher = smoother but more resource intensive (between 100 and 200 is a good balance, this is the steps of the animations)

Config.CustomTargetResource = "" -- if you have a custom target (ox_target and qb-target are supported without modifications) resource name set it here

Config.KitchenCreator = {
    command = "kitchen_creator",
    enabled = false -- Enabling this will expose some internal functions that can enable exploits, disable when not needed
}

-- Help us translate!
--  You can contribute by improving existing translations or adding translations for new languages
--  https://localazy.com/p/mxc
Config.Language = "en"

-- Uncomment only if you want to ovverride the default translations provided by localazy
Config.Translations = {
    --["error_no_space"] = "~r~You dont have enough space in your inventory",
    --["error_hamburger_layers"] = "~r~You can't add more layers to this hamburger",

    --["pizza_pizzabox_interactions"] = "~INPUT_PICKUP~ Slice the pizza\n~INPUT_JUMP~ Open/close the pizza box\n\n~INPUT_CELLPHONE_CANCEL~ Put away the pizza",
    --["pizza_pizza_station"] = "~y~ %d~w~/30 Toppings\n\n~INPUT_WEAPON_WHEEL_PREV~~INPUT_WEAPON_WHEEL_NEXT~ Rotate topping\n~INPUT_VEH_MELEE_LEFT~ Add selected topping\n~INPUT_MAP_POI~ Remove closest topping\n\n~INPUT_CELLPHONE_CANCEL~ Exit"
    --["give_name"] = "Give it a name"

    --["creator_snapping_free"] = "Free",
    --["creator_ppm"] = "Prop placing",
    --["creator_ppm_type"] = "Type",
    --["creator_ppm_table_hidden"] = "Table hidden?",
    --["creator_ppm_table_reset_rotation"] = "Reset rotation",
    --["creator_ppm_table_snapping"] = "Snapping",
    --["creator_ppm_type_desc"] = "Scroll to change the table type",
    --["creator_ppm_table_hidden_desc"] = 'If toggled the table will be hidden, only props on it will be visible',

    --["creator_ppm_notify"] = "~INPUT_MOVE_UP_ONLY~ Translate mode\n~INPUT_RELOAD~ Rotate mode\n~INPUT_COVER~ Local/World mode\n\n~INPUT_JUMP~ Snap to ground\n~INPUT_DUCK~ ~INPUT_MULTIPLAYER_INFO~ Undo last action\n\n~INPUT_MAP_POI~ Mouse control",
    --["creator_ppm_hider_notify"] = "~INPUT_ATTACK~ Confirm selected entity\n~INPUT_CELLPHONE_CANCEL~ Cancel",

    --["creator_table_title"] = "Creator - Table",
    --["creator_table_edit"] = "Edit",
    --["creator_table_delete"] = "Delete",

    --["creator_add_furniture"] = "Add new furniture",
    --["creator_add_entity_hider"] = "Add new entity hider",

    --["creator_confirm"] = "Confirm",
    --["creator_confirm_name"] = "Give it a name!",

    ["kebab_take_spit"] = "Take doner spit",
    ["kebab_store_spit"] = "Store doner spit",

    ["kebab_finish"] = "Press ~INPUT_PICKUP~ to finish the doner kebab",

    ["add_mais"] = "Add mais",
    ["add_yogurt"] = "Add yogurt",
    ["add_hotsauce"] = "Add hot sauce",
    ["add_doner_kebab"] = "Add doner kebab",
    ["toggle_door"] = "Toggle door",

    ["kebab_grill_bread_pita"] = "Start cooking pita",
    ["kebab_grill_bread_wrap"] = "Start cooking wrap",
    ["kebab_cut_spit"] = "Shave doner",
}

-- Used only if Config.RequireItems = true
Config.Containers = {
    label = "Container",
    maxWeight = 6000
}

Config.Expansions = {}

-- Internal items, not referencing any real inventory item
-- Duration is the cooking time in milliseconds 
-- (includes burning, so the actual cooking time [raw to cooked] is 73% of the duration)
Config.CookingItems = {
    ["Fries"] = {
        duration = 60000
    },
    ["BurgerMeat"] = {
        duration = 60000
    }
}

Config.AllowCustomName = {
    enabled = true,
    oxlib = false -- Use ox_lib input dialog?
}

-- Global job checking
-- Leave empty to disable
Config.Jobs = {
    -- ["mechanic"] = 1, -- [job_name] = job_grade
    -- ["mechanic2"] = 1
    --
    -- OR
    -- 
    -- "mechanic", -- job_name
    -- "mechanic2"
}