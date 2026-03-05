Config = {}

Config.useModernUI = true               -- In March 2023 the jobs have passed huge rework, and the UI has been changed. Set it to false, to use OLD no longer supported UI.
Config.splitReward = false          -- This option work's only when useModernUI is false. If this option is true, the payout is: (Config.OnePercentWorth * Progress ) / PartyCount, if false then: (Config.OnePercentWorth * Progress)
Config.UseBuiltInNotifications = true   -- Set to false if you want to use ur framework notification style. Otherwise, the built in modern notifications will be used.=

Config.letBossSplitReward = true                    -- If it's true, then boss can manage whole party rewards percent in menu. If you'll set it to false, then everybody will get same amount.
Config.multiplyRewardWhileWorkingInGroup = true     -- If it's false, then reward will stay by default. For example $1000 for completing whole job. If you'll set it to true, then the payout will depend on how many players is there in the group. For example, if for full job there's $1000, then if player will work in 4 member group, the reward will be $4000. (baseReward * partyCount)
Config.UseTarget = false                -- Change it to true if you want to use a target system. All setings about the target system are under target.lua file.
Config.RequiredJob = "none"             -- Set to "none" if you dont want using jobs. If you are using target, you have to set "job" parameter inside every export in target.lua
Config.RequireJobAlsoForFriends = false          -- If it's false, then only host needs to have the job, if it's true then everybody from group needs to have the Config.RequiredJob
Config.RequireOneFriendMinimum = false  -- Set to true if you want to force players to create teams
Config.Reward = math.random(500, 750)                    -- Complete transport will give the team this value. 
Config.GiveRewardAfterHeist = true      -- Set to false, if you don't want to give players money after they have got robbed.
Config.JobCooldown = 0 * 60 -- 10 * 60            -- 0 minutes cooldown between making jobs (in brackets there's example for 10 minutes)
Config.GiveKeysToAllLobby = true                -- Set to false if you want to give keys only for group creator while starting job
Config.ProgressBarOffset = "25px"                   -- Value in px of counter offset on screen
Config.ProgressBarAlign = "bottom-right"            -- Align of the progressbar

Config.EnableInteriorRefreshing = true              -- Experimental feature for those who have issues with crashses. Disable to fix crashses. May result in script unexpected work

-- ^ Options: top-left, top-center, top-right, bottom-left, bottom-center, bottom-right

Config.RewardItemsToGive = {
    -- {
    --     item_name = "water",
    --     chance = 100,
    --     amount = 1,
    -- },
}

Config.RequiredItem = "none"                        -- Set it to anything you want, to require players to have some item in their inventory before they start the job
Config.RequireItemFromWholeTeam = true              -- If it's false, then only host needs to have the required item, otherwise all team needs it.

Config.EnableDeliveriesToNonVaultPlaces = true     -- Set to true, if you want script to be able to deliver money to places where isVault = false in Config.BankLocations
Config.EnableEnteringCodeAnim = true                -- Set to false if you're using some custom MLO, and the anim dosen't looks good for u
Config.EnableHighlightBags = true                   -- Set to false if you dont want bags to highlight.
Config.ReEnableEngineAfterBlockingTime = 20000      -- Time in ms. When criminals will block the truck engine, after this time the engine will be reenabled

Config.EnableVehicleTeleporting = true          -- If its true, then the script will teleport the host to the company vehicle. If its false, then the company vehicle will apeear, but the whole squad need to go enter the car manually
Config.JobVehicleModel = "stockade"             -- Model of the company car

Config.vehicleRearBagsOffsets = {               -- Here you can change offsets for bags inside job vehicle
    [1] = { xyz = vec3(0.12, -1.32, 0.75), rotation = vec3(0.0, 15.0, 90.0) },
    [2] = { xyz = vec3(0.46, -1.32, 0.75), rotation = vec3(0.0, 15.0, 90.0) },
    [3] = { xyz = vec3(0.46, -2.36, 0.75), rotation = vec3(0.0, 15.0, 90.0) },
    [4] = { xyz = vec3(0.12, -2.36, 0.75), rotation = vec3(0.0, 15.0, 90.0) }
}

Config.InteractionKey = {
    -- Key dedicated to interaction with vehicles, vault doors, trolleys etc. 
    keyIndex = 51,
    keyString = "~r~[E] | ~s~",
}

Config.OpenDoorsTextBackwardOffset = -3.5       -- Backward offset to draw "Open Doors" text. Leave default if you're using default stockade as job vehicle model
Config.OpenDoorTextUpDownOffset = 1.5           -- Backward offset to draw "Open Doors" text. Leave default if you're using default stockade as job vehicle model

Config.PenaltyAmount = 100                      -- Penalty that is levied when a player finishes work without a company vehicle or not completed
Config.DeleteVehicleWithPenalty = true         -- Delete Vehicle even if its not company veh, and player accepted the penalty

Config.TrolleyModel = "prop_tea_trolly"         -- Trolleys model inside vault
Config.CashModel = "prop_anim_cash_pile_02"     -- One pile that is being spawned on the trolley
Config.AttachSettings = {
    -- Piles attaching on the trolleys settings
    startingOffset = vector3(-0.43, -0.17, 0.38),
    totalLenght = 12,
    totalHeight = 1,
    totalRows = 3,
}

Config.AutoCashGrabbing = true

Config.TabletPassword = "password"              -- Password for tablet
Config.TabletItemName = "gruppesechstablet"     -- Item you need to use to open the tablet

Config.DefaultMessages = {
    -- Enter here any messages that you want to be displayed on the chat at the very beggining
    "Use the /guidebook for more info"
}

Config.PossibleLoots = {
    -- Here you can change possible loots for crime. Remember that the loot is not the payout. Payout for crime is loot * (Config.PercentForCrimeFromWholeLoot / 100) (By default 15% of loot)
    [1] = { loot = 25000, chance = 75 },
    [2] = { loot = 50000, chance = 50 },
    [3] = { loot = 75000, chance = 25 },
    [4] = { loot = 100000, chance = 12.5 },
}

Config.PercentForCrimeFromWholeLoot = math.random(70, 80)    -- How many % of the whole loot the crime player will get after heist complete
Config.splitCrimeReward = false             -- Decide if reward should be splitted among the whole party, or every party member should get 100% of the reward
Config.ZonesName = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

Config.MinimunFriendsToStartHeist = 1           -- Set Minimum friends count required to start the heist. 
Config.MinimumCopsToStartHeist = 0              -- Set Minimum cops on duty count required to start heist
Config.RequiredSecondsToFetch = math.random(10, 20)              -- The time in seconds that is required to take control of a cash transport

Config.HeistVehBlipSettings = {
    -- Cash Transport truck blip settings, used in cops notification, and for crime after heist start.
    sprite = 477,
    color = 43,
    scale = 1.2,
    label = "Target Heist Truck",
    labelForCops = "Cash Transport Heist",
}

Config.AtmsLocations = {
    [1] = { coords = vector4(-56.94, -1751.34, 28.42, 230.3) },
    [2] = { coords = vector4(146.83, -1035.4, 28.34, 338.79) },
    [3] = { coords = vector4(25.34, -946.29, 28.36, 159.95)  },
    [4] = { coords = vector4(-204.95, -861.83, 29.27, 200.8) },
    [5] = { coords = vector4(-718.2, -914.85, 18.22, 263.38) },
    [6] = { coords = vector4(-820.93, -1081.14, 10.13, 207.38) },
    [7] = { coords = vector4(-1572.16, -547.39, 33.96, 4.1)  },
    [8] = { coords = vector4(1153.06, -326.29, 68.21, 276.57)},
    [9] = { coords = vector4(-165.42, 233.71, 93.92, 272.27) },
} 

Config.enableAtmsFillingUp = true               -- Set it to false, if you want to make script just source -> target transportation. When it's true, you also need to fill out some atms around the city, only then deliver the money to target
Config.howMuchAtmFillWillRemoveFromLoot = 5000  -- The heist loot will be smaller every ATM filling, here you can change this value
Config.neededAtms = 3                           -- Set how many ATM's you need to fill up
Config.AtmGuardModel = `s_m_m_prisguard_01`     -- Model of ped that will be spawned near the ATM

Config.VaultDoorsModels = {

    -- Add here some models of doors that you're using in your banks. Here's some of the defaults ones.

    --`v_ilev_gb_vauldr`,
    --`hei_prop_heist_sec_door`,
    --`prop_ld_vault_door`,
    --`reh_prop_reh_door_vault_01a`,
    --`ch_prop_ch_vault_d_door_01a`,

    -- For k4mb1 Map:
    --`k4mb1_genbank_framedoor`,
}

Config.DeliveryLocations = {
    -- Locations where bags have to delivered after complete heist
    { coords = vec3(459.810852, -546.846252, 27.2276749), rotation = vec3(0.0, -15.0, 0.0) },
    { coords = vec3(-92.62852, -73.6846161, 57.55671), rotation = vec3(0.0, 15.0, -120.0) },
    { coords = vec3(-212.200363, -1364.79993, 29.9253143), rotation = vec3(0.0, 15.0, -25.0) },
    { coords = vec3(-1296.69287, -1249.671, 3.1778616), rotation = vec3(0.0, -15.0, 0.0) },
}

Config.RestrictBlipToRequiredJob = false            -- Set to true, to hide job blip for players, who dont have RequiredJob. If requried job is "none", then this option will not have any effect.
Config.Blips = { -- Here you can configure Company blip.
    [1] = {
        Sprite = 460,
        Color = 69,
        Scale = 0.8,
        Pos = vector3(-195.32, -835.13, 30.73),
        Label = 'Gruppe Sechs Job'
    },
}

Config.MarkerSettings = {   -- used only when Config.UseTarget = false. Colors of the marker. Active = when player stands inside the marker.
    Active = {
        r = 129, 
        g = 214,
        b = 0,
        a = 200,
    },
    UnActive = {
        r = 65,
        g = 107,
        b = 0,
        a = 200,
    }
}

Config.Locations = {       -- Here u can change all of the base job locations. 
    DutyToggle = {
        Coords = {
            vector3(-195.32, -835.13, 30.73),
        },
        CurrentAction = 'open_dutyToggle',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~start/finish~s~ work.',
        type = 'duty',
        scale = {x = 1.0, y = 1.0, z = 1.0}
    },
    FinishJob = {
        Coords = {
            vector3(-143.95, -822.31, 31.44),
        },
        CurrentAction = 'finish_job',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~end ~s~working.',
        scale = {x = 3.0, y = 3.0, z = 3.0}
    },

}

Config.SpawnPoint = vector4(-143.95, -822.31, 30.89, 69.7)    -- Company car spawn point

Config.EnableClothesChange = false
Config.Clothes = {
    male = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 1, variation = 0},
        ["pants"] = {clotheId = 24, variation = 0},
        ["bag"] = {clotheId = 45, variation = 0},
        ["shoes"] = {clotheId = 61, variation = 0},
        ["t-shirt"] = {clotheId = 58, variation = 0},
        ["torso"] = {clotheId = 139, variation = 7},
        ["kevlar"] = {clotheId = 11, variation = 1},
        ["decals"] = {clotheId = 0, variation = 0},
    },
    
    female = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 17, variation = 0},
        ["pants"] = {clotheId = 34, variation = 0},
        ["bag"] = {clotheId = 45, variation = 0},
        ["shoes"] = {clotheId = 101, variation = 0},
        ["t-shirt"] = {clotheId = 35, variation = 0},
        ["torso"] = {clotheId = 136, variation = 7},
        ["kevlar"] = {clotheId = 9, variation = 1},
        ["decals"] = {clotheId = 0, variation = 0},
    }
}

Config.Lang = {

    -- Here you can changea all translations used in client.lua, and server.lua. Dont forget to translate it also under the HTML and JS file.

    -- Client
    ["no_permission"] = "Only the party owner can do that!",
    ["keybind"] = 'Marker Interaction',
    ["too_far"] = "Your party has started work, but you are too far from headquarters.",
    ["kicked"] = "You kicked %s out of the party",
    ["alreadyWorking"] = "First, complete the previous order",
    ["quit"] = "You have left the Team",
    ["wrongCar"] = "This is not your company vehicle",
    ["CarNeeded"] = "You need your company vehicle to finish the job.",
    ["nobodyNearby"] = "There is no one around",
    ["cantInvite"] = "To be able to invite more people, you must first finish the job",
    ["cantInviteCrime"] = "To be able to invite more people, you must first finish the heist",
    ["inviteSent"] = "Invite Sent!",
    ["spawnpointOccupied"] = "The car's spawn site is occupied",
    ["enterCode"] = "Enter Code",
    ["grabMoney"] = "Start grabbing",
    ["srcBank"] = "Source Bank",
    ["targetBank"]  = "Target Bank",
    ["notAllBags"] = "Your team didn't deliver all bags!",
    ["throwBag"] = "Throw Bag",
    ["notEverythingDone"] = "You didn't grab all the money!",
    ["someonesInside"] = "Someone is inside the vault! You cant lock him",
    ["startingTutorial"] = "The job involves transporting cash from the source bank or location, to the destination bank. Head to the designated location for more information. Remember that this is a dangerous job, you can expect numerous robbery attempts.",
    ["beforeMoneyGrabInBank"] =   "Your first step is to collect cash from the carts in the safe. You can't miss a single bill, nor can you leave anyone locked in the safe. Don't forget to close the vault door when you leave",
    ["beforeMoneyGrab"] =   "Your first step is to collect cash from the carts. You can't miss a single bill, after you'll collect all, the next steps will be explained",
    ["afterMoneyGrabTutorialInBank"] = "You took all the cash from the safe. Now close the vault door and then pack the bags of money on the car's trunk. Follow the procedures, if you don't put the bags down, you won't be able to move the car.",
    ["afterMoneyGrabTutorial"] = "You took all the cash from the carts. Now pack the bags of money on the car's trunk. Follow the procedures, if you don't put the bags down, you won't be able to move the car.",
    ["afterBagLoadingTutorial"] = "Bags loaded. From now on you can move the vehicle. Go to the marked place to deliver the bags!",
    ["afterDeliveringBagsTutorial"] = "You delivered the bags to the safe. This is where your work ends. Close the door to the safe and head to the base to get paid",
    ["AfterArrivalToTargetBank"] = "You approached the target bank, we unlocked the possibility of opening the back door. Go to the back of the cart to open the door and take your bags and go to the safe",
    ["afterAttack"] = "You have been attacked. Your cash will probably be stolen. Do not continue work, return to base",
    ["notReadyWarning"] = "The work is not completed. You can leave the service now but you will be charged a penalty and your paycheck will not be paid.",
    ["wrongCarWarning"] = "This is not your company car. You can still finish the job, but you will be charged a penalty",
    ["cantOpenTabletWhileOnDuty"] = "You cannot open this tablet while in transit",
    ["alreadyBusy"] = "You can't start a robbery because you're on duty or you're already running a robbery", 
    ["tooLate"] = "Transport with cash arrived at the site. You were late",
    ["endJob"] = "End Job",
    ["afterStartingHeist"] = "Your team has launched a heist on a cash shipment. Those with a tablet can now open it, there are written out all the steps you need to take to rob the truck. You have to hurry, once the truck approaches the bank, your chance is gone.",
    ["startingFetching"] = "Tablet is now connecting to the truck.. Please do not move away from the truck to avoid breaking the connection",
    ["deliveryLocation"] = "Deliver Bags Here",
    ["copsNotification"] = "Suspicious activity around the transportation of cash was detected. Check it out - location marked on the GPS",
    ["didntMakeThirdStep"] = "You Didn't take a bag from the truck",
    ["notADriver"] = "You need to be a driver of vehicle to end the job",
    ["atmBlip"] = "Fill the ATM",
    ["deliverCash"] = "Deliver Cash To Guard",
    ["partyIsFull"] = "Failed to send an invite, your group is full",
    ["wrongReward1"] = "The payout percentage should be between 0 and 100",
    ["wrongReward2"] = "The total percentage of all payouts exceeded 100%",
    ["dontForgetDoors"] = "Don't forget to close vault doors!",
    ["cantLeaveLobby"] = "You can't leave the lobby while you're working. First, end the job.",
    
    -- Server
    ["isAlreadyHost"] = "This player leads his team.",
    ["isBusy"] = "This player already belongs to another team.", 
    ["hasActiveInvite"] = "This Player already has an active invitation from someone.",
    ["HaveActiveInvite"] = "You already have an active invitation to join the team.",
    ["InviteDeclined"] = "Your invitation has been declined.",
    ["InviteAccepted"] = "Your invitation has been accepted!",
    ["error"] = "There was a Problem joining a team. Please try again later.",
    ["kickedOut"] = "You've been kicked out of the team!",
    ["reward"] = "You have received a payout of $",
    ["RequireOneFriend"] = "This job requires at least one team member",
    ["penalty"] = "You paid a fine in the amount of $",
    ["clientsPenalty"] = "The team's host accepted the punishment. You have not received the payment",
    ["noFreeLocations"] = "We currently have no orders for you",
    ["notEnoughClients"] = "You don't have enough team members to launch a heist",
    ["notEnoughPolice"] = "There are not enough officers on duty in the city",
    ["dontHaveReqItem"] = "You or someone from your team do not have the required item to start work",
    ["notEverybodyHasRequiredJob"] = "Not every of your friends have the required job",
    ["alreadyInLegalParty"] = "This player is already working somewhere else",
    ["someoneIsOnCooldown"] = "%s can't start the job now (cooldown: %s)", 
    ["hours"] = "h",
    ["minutes"] = "m",
    ["seconds"] = "s",
    ["newBoss"] = "The previous lobby boss has left the server. You are now the team leader",
}

Config.HintNotifications = {
    Grabbing = "~INPUT_FRONTEND_PAUSE_ALTERNATE~ Stop Grabbing~n~~INPUT_SKIP_CUTSCENE~ Grab pile",
    GrabbingAuto = "~INPUT_FRONTEND_PAUSE_ALTERNATE~ Stop Grabbing",
    Throwing = "~INPUT_CONTEXT~ Throw bag", 
    OpenDoors = "~INPUT_CONTEXT~ Open Doors",
    GrabBag = "~INPUT_CONTEXT~ Grab Bag"
}

Config.BankLocations = {
    [1] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(27.7850, -1343.7874, 26.3849), rotation = vec3(0, 0, 355.5997)},
        },
        DeliveryLocations = {
            { coords = vec3(24.4891, -1343.4446, 26.3849), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(24.1861, -1344.6930, 29.4968), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(29.32, -1346.2, 29.5),
    },
    [2] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(-43.7612, -1749.1018, 29.4228), rotation = vec3(0, 0, 139.2043)},
        },
        DeliveryLocations = {
            { coords = vec3(-41.1254, -1751.6910, 29.4228), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(-44.7927, -1753.8545, 29.4291), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(-43.7612, -1749.1018, 29.4228),
    },
    [3] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(1159.7603, -314.5881, 69.2068), rotation = vec3(0, 0, 194.5049)},
        },
        DeliveryLocations = {
            { coords = vec3(1163.3817, -314.5682, 69.2068), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(1162.8873, -318.4412, 69.2096), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(1159.7603, -314.5881, 69.2068),
    },
    [4] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(376.8370, 329.3177, 100.4544), rotation = vec3(0, 0, 346.1762)},
        },
        DeliveryLocations = {
            { coords = vec3(373.3061, 330.7336, 100.4544), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(374.2690, 333.4668, 100.4544), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(374.2690, 333.4674, 100.4544),
    },
    [5] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(-709.5999, -904.8096, 19.2173), rotation = vec3(0, 0, 184.5025)},
        },
        DeliveryLocations = {
            { coords = vec3(-705.9185, -905.2458, 19.2173), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(-707.5557, -909.1103, 19.2200), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(-707.5557, -909.1103, 19.2200),
    },
    [7] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(-1218.7325, -915.8171, 11.3263), rotation = vec3(0, 0, 31.1517)},
        },
        DeliveryLocations = {
            { coords = vec3(-1220.3354, -911.5316, 12.3263), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(-1223.6763, -909.6431, 12.3263),
    },
    [8] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(1126.1915, -980.8179, 45.4157), rotation = vec3(0, 0, 191.2802)},
        },
        DeliveryLocations = {
            { coords = vec3(1126.5514, -982.2504, 45.4158), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(1130.6715, -982.7417, 46.4158), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(1130.6715, -982.7417, 46.4158),
    },
    [9] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(2676.3696, 3284.3738, 52.1291), rotation = vec3(0, 0, 58.7631)},
        },
        DeliveryLocations = {
            { coords = vec3(2674.2234, 3281.3042, 52.1291), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(2671.7705, 3282.9985, 52.1291), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(2671.7705, 3282.9985, 52.1291),
    },
    [10] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(1961.3469, 3744.9573, 29.2317), rotation = vec3(0, 0, 27.1725)},
        },
        DeliveryLocations = {
            { coords = vec3(1957.9075, 3743.4287, 29.2317), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(1956.4257, 3746.2012, 29.2317), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(1956.4257, 3746.2012, 29.2317),
    },
    [11] = {
        rewardBonus = math.random(50, 75),
        isVault = false,
        ObjectsToDelete = {
            -- Add here what props you want to delete from ur interior, for example some locked doors or somehting
        },
        TrolleysCoords = {
            { coords = vector3(-3043.5503, 586.6823, 4.7968), rotation = vec3(0, 0, 111.2614)},
        },
        DeliveryLocations = {
            { coords = vec3(-3045.6704, 582.4157, 4.7968), rotation = vec3(0.0, 15.00, 0.0)},
            { coords = vec3(-3042.8240, 582.9838, 4.7968), rotation = vec3(0.0, 15.00, 0.0)},
        },
        BlipCoords = vector3(-3042.8240, 582.9838, 4.7968),
    },
}
