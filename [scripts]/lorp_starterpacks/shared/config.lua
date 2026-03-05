Config = {}

Config.Debug = false                      -- enable debug mode to see more information in the console
Config.CheckVersion = false                -- check for the latest version of the script
Config.DBChecking = true                  -- check if the database table, and columns are initialized properly (only enable this if you are having issues with the database)
Config.CheckPacksCommand = 'checkpacks'   -- command to check all players who have received the starter pack

Config.TargetResource = 'ox_target'       -- supported: ox_target, qb-target
Config.InventoryResource = 'ox_inventory'                            -- supported: ox_inventory, qb-inventory, ps-inventory, qs-inventory, codem-inventory
Config.SQLResource = 'oxmysql'            -- supported: oxmysql, mysql-async, ghmattimysql

Config.UsePlayerLicense = false            -- if you want to use player license to check if they have received the starter pack or not

Config.UseTarget = true                   -- enable target system to interact with the peds
Config.Use3DText = false                  -- enable 3D text to show the interaction text

Config.CommandConfig = {                  -- command to give the starter package
    enable           = false,
    command          = 'starterpack',
    command_help     = 'Get your starter pack',
    starterpack_type = 'start',
    starter_vehicle  = {
        enable = true,
        model = 'adder',
        random_vehicle = true,
    }
}

Config.DialogInfo = { -- dialog settings for the starter pack
    enable = true,
    title = 'Starter Pack',
    dialog_type = 'rules', -- available types: rules, quiz, captcha (only one type can be enabled)
    alert_description = 'You will receive a starter pack after accepting the rules / completing the quiz/captcha.',

    quiz = {
        questions = {
            {
                question = 'What is the first rule of roleplay?',
                description = 'This question tests your understanding of roleplay basics.',
                answers = {
                    { label = 'Always stay in character',       correct = true },
                    { label = 'Ignore other players',           correct = false },
                    { label = 'Break character for fun',        correct = false },
                    { label = 'Use out-of-character knowledge', correct = false },
                }
            },
            {
                question = 'What should you do if someone is breaking server rules?',
                description = 'This question tests your knowledge of server etiquette.',
                answers = {
                    { label = 'Report them to staff using /report',       correct = true },
                    { label = 'Confront them in-character', correct = false },
                    { label = 'Ignore it and move on',      correct = false },
                    { label = 'Start a fight with them',    correct = false },
                }
            },
            {
                question = 'What does "Fail RP" mean?',
                description = 'This question tests your understanding of roleplay terms.',
                answers = {
                    { label = 'Actions that break roleplay immersion', correct = true },
                    { label = 'Winning a roleplay scenario',           correct = false },
                    { label = 'A type of roleplay event',              correct = false },
                    { label = 'A server rule about driving',           correct = false },
                }
            },
        }
    },

    captcha = {
        captcha_type = 'ra' -- rl: random letters, rn: random numbers, ra: random alphanumeric
    },

    rules = {
        {
            title = 'Rule #1: Stay In Character',
            description =
            'Always remain in character while playing. Breaking character without a valid reason is not allowed.',
        },
        {
            title = 'Rule #2: No Meta-Gaming',
            description =
            'Do not use out-of-character (OOC) knowledge in-character (IC). This includes information from Discord, Twitch, or other sources.',
        },
        {
            title = 'Rule #3: Respect Other Players',
            description =
            'Treat all players with respect. Harassment, hate speech, or toxic behavior will not be tolerated.',
        },
        {
            title = 'Rule #4: No Random Deathmatch (RDM)',
            description = 'Do not engage in random violence or kill other players without a valid roleplay reason.',
        },
        {
            title = 'Rule #5: Follow Server Guidelines',
            description = 'Adhere to all server rules and guidelines. Failure to do so may result in warnings or bans.',
        },
    }
}

Config.Locations = {
    ["1"] = {                                                                       -- Unique identifier for the location
        starterpack_type = 'start',                                                -- Type of starter pack given to the player (set to false if you don't want to give a starter pack item)
        label            = 'Claim Starter Pack',                                 -- Target label (shown to the player)
        icon             = 'fa-solid fa-gift',                                      -- Target icon (from FontAwesome)

        coords           = vec4(751.1611, 2509.3733, 73.2492, 2.0692), -- Coordinates and heading of the NPC (ped)

        ped              = {                                                        -- Settings for the ped (NPC)
            model = 'a_m_y_business_03',                                            -- Ped model (see the FiveM ped model list)
            scenario = 'Standing',                                                  -- Ped scenario (animation/behavior)
        },

        safezone         = { -- Safe zone settings (optional)
            enable = false,  -- Enable or disable the safe zone
            zone_points = {
                vec3(-1035.819, -2734.205, 20.169),
                vec3(-1035.999, -2727.598, 20.134),
                vec3(-1043.567, -2723.403, 20.126),
                vec3(-1049.598, -2731.540, 20.169),
                vec3(-1041.131, -2739.401, 20.169),
            } -- Define safe zone points (if enabled) using vector3
        },

        starter_vehicle  = {         -- Vehicle settings for players receiving a starter vehicle
            enable = true,           -- Enable or disable the starter vehicle
            model = 'adder',         -- Vehicle model (from FiveM vehicle model list) will be ignored if random_vehicle is set to true
            random_vehicle = true,   -- Spawn a random vehicle from the list (true/false)
            teleport_player = false, -- Teleport player to the vehicle (true/false)
            fuel = 100.0, -- Fuel level of the vehicle when spawned
            vehicle_spawns = {       -- Spawn points for the vehicle (multiple spawn locations)
                vec4(743.4727, 2500.4604, 72.3730, 176.7612),
                vec4(747.7388, 2501.0066, 72.6843, 175.2299),
                vec4(752.2410, 2499.2070, 72.4858, 182.2984),
                vec4(759.6600, 2496.8105, 72.2293, 274.1793),
                vec4(772.9225, 2497.9229, 72.7203, 276.2117),
            },
        },

        receiving_radius = 20.0, -- Radius around the location where players can receive the starter pack
        distance         = 2.0,  -- Distance from the ped to interact with it
    },
}

Config.RandomVehicles = { -- list of vehicles to be given randomly to the player
    vehicles = {
        "a33maxima",
        "03sierra",
    }
}

Config.StarterPackItems = { -- items that will be given to player
    ["start"] = {
        { item = 'money',   amount = 10000 },
        { item = 'black_money',   amount = 2500 },
    },
}

---@param vehicle any
---@param fuel number
---@decription Set fuel level of the vehicle using the fuel resources
Config.SetFuel = function(vehicle, fuel)
    exports["lc_fuel"]:SetFuel(vehicle, fuel)
end

---@param vehicle any
---@return string
---@decription If you have a custom vehicle key system you can give the key to the player
Config.GiveKey = function(vehicle, plate)
    exports.wasabi_carlock:GiveKey(plate)
end

---@param message string
---@param type string
---@param is_server boolean
---@decription Send notification to the player
Config.Notification = function(message, type, is_server, src)
    local Core, Framework = GetCore()
    if is_server then
        if Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 5000)
        end
    else
        if Framework == "esx" then
            -- TriggerEvent("esx:showNotification", message)
            Core.ShowNotification(message, type, 5000)
        else
            Core.Functions.Notify(message, type, 5000)
        end
    end
end
