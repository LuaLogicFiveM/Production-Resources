Config = {}

--use /n for new lines and +TEXT+ for "button" style text (example: Press +SPACE+ to jump.)

Config.Tabs = {
    {
        name = "Information",
        header = "Information",
        content = {
            {
                text = "Basic information that is known in most Cities",
            },
            {
                text = "+Starting Out+ - Starting out after loading in you will be greeted with our multi-character system where you are able to create two characters that you will not have the option to delete after creation. In order to create a character you must enter the information requested, all icons of the required fields of the character creation screen will light up white when they are filled in accordingly, after customizing your player, you can open the vMenu (M) to spawn a vehicle to get around the City. \n\n +Common Items+ - Common items that you will need daily can be found in the corner stores. Eating and drinking is not required on the server it will not lower your health when you get low hunger or thirst. You should start with enough money to afford any starter items you will need to start a job or survive for a while. \n\n +Licensing+ - To receive a legal weapon you must first obtain your License to Carry, this can be found at the City Hall found at the flag icon on your map. If you have any questions feel free to call and ask a law enforcement officer through the services app on your phone. Remind yourself that just because you have a License to Carry does not mean you are immune to the law, you are still obligated to use your weapon in self-defense cases only, mirroring off real life gun laws. Any weapon without a serial number is considered illegal and not registered. \n\n +Queue Priority+ - You are able to get free priority by putting our Discord link as your Discord status which is free to you. Join the Discord for more information! (discord.gg/lorp)",
            },
        }
    },
    {
        name = "Keybinds",
        header = "Keybinds",
        content = {
            {
                text = "Functions in the server that are connected to a default key listed below",
            },
            {
                text = "+F1+ - Phone \n\n +F2+ - Inventory \n\n +F3+ - Emote Menu \n\n +F4+ - Multi-job Menu \n\n +F5+ - Shortcut Menu \n\n +F6+ - Job Menu \n\n +F7+ - Billing Menu \n\n +F11+ - Hud Menu \n\n +M+ - vMenu \n\n +B+ - Point \n\n +K+ - Trunks & Gloveboxes \n\n +Y+ - Clothing Options",
            },
        }
    },
    {
        name = "Jobs",
        header = "Jobs",
        content = {
            {
                text = "Activities around the City that can return dirty or clean currency",
            },
            {
                text = "Illegal",
            },
            {
                text = "+Moonshine+ \n\n The old man on the map will teach you how to start moonshining",
                image = "img/jobs_illegal_moonshine.png",
            },
            {
                text = "+Drug Labs+ \n\n You are able to own a lab or have access from another owner at limited locations",
                image = "img/jobs_illegal_labs.png",
            },
            --[[{
                text = "+Street Racing+ \n\n You will need the tablet from a store",
                image = "img/jobs_illegal_racing.png",
            },]]
            {
                text = "+Drugs+ \n\n Public locations, you can sell the drugs through a trap phone from the black market",
                image = "img/jobs_illegal_drugs.png",
            },
            {
                text = "+Crafting+ \n\n Hidden locations that give you the ability to craft weapons & ammo",
                image = "img/jobs_illegal_crafting.png",
            },
            {
                text = "+Fraud+ \n\n Hidden locations in the North-East quarter of the City, both locations are nearby each other",
                image = "img/jobs_illegal_fraud.png",
            },
            {
                text = "Legal",
            },
            {
                text = "+Mining+ \n\n Postal 331: Farm materials for crafting at hidden locations or sell them for cash",
                image = "img/jobs_legal_mining.png",
            },
        }
    },
    {
        name = "Heist",
        header = "Heist",
        content = {
            {
                text = "Illegal missions that are high-risk high-reward",
            },
            {
                text = "+ATM Heist+ \n\n (3rd Eye ATM, Left-ALT)",
                image = "img/heist_atm.png",
            },
            --[[{
                text = "+Bank Heist+ \n\n Bombs (Found from player to player)",
                image = "img/heist_banks.png",
            },
            {
                text = "+Gruppe 6 Heist+ \n\n Tablet (Stores)",
                image = "img/heist_gruppe6.png",
            },]]
            {
                text = "+Boat Heist+ \n\n (Gang Exclusive)",
                image = "img/heist_boat.png",
            },
            {
                text = "+Crate Heist+ \n\n (Gang Exclusive)",
                image = "img/heist_crate.png",
            },
        }
    },
    {
        name = "Points of Interest",
        header = "Points of Interest",
        content = {
            {
                text = "Common spots to hang around that are commonly populated",
            },
            {
                text = "+Sandy Shores City Hall+ \n\n Postal 289: Government building to receive licensing or jobs",
                image = "img/poi_cityhall.png",
            },
            {
                text = "+Sandy Shores BP+ \n\n Postal 254: Local gas station to get gas or host a meet",
                image = "img/poi_sandy_bp.png",
            },
            {
                text = "+Waffle House+ \n\n Postal 112: A meet spot to hangout at",
                image = "img/poi_wafflehouse.png",
            },
            {
                text = "+Top Golf+ \n\n Postal 565: A functional top golf course to play & wager with friends",
                image = "img/poi_golf.png",
            },
            {
                text = "+Boxing Gym+ \n\n Postal 041: A functional boxing gym to host a fight night or handle differences",
                image = "img/poi_boxing.png",
            },
        }
    },
}
