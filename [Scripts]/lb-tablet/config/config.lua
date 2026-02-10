Config = {}
Config.Debug = false -- Set to true to enable debug mode

Config.DatabaseChecker = {}
Config.DatabaseChecker.Enabled = true -- if true, the tablet will check the database for any issues and fix them if possible
Config.DatabaseChecker.AutoFix = true -- if true, the tablet will automatically fix any issues & add new tables if needed

Config.LBPhone = "auto" -- Set to false if you don't want to link lb-phone to lb-tablet

Config.OpenCommand = "tablet" -- the command to open the tablet. can be set to false to disable

Config.Logs = {}
Config.Logs.Enabled = true
Config.Logs.Service = "fivemanage" -- fivemanage, discord or ox_lib. if discord, set your webhook in server/apiKeys.lua
Config.Logs.Avatar = false -- attempt to get the player's avatar for discord logging?
Config.Logs.Dataset = "Tablet" -- fivemanage dataset
Config.Logs.Actions = {
    TakePhoto = true,
    Police = true,
    Ambulance = true,
    Dispatch = true
}

--[[ FRAMEWORK OPTIONS ]] --
Config.Framework = "esx"
--[[
    Supported frameworks:
        * esx: es_extended, https://github.com/esx-framework/esx-legacy
        * qb: qb-core, https://github.com/qbcore-framework/qb-core
        * qbox: qbox, https://github.com/Qbox-project/qbx_core
        * standalone: no framework, standalone framework using the registration database by default
]]

Config.BillingScript = "vivum" --[[
    Supported options:
        * auto
        * framework
        * vivum
]]

Config.RegistrationApp = false -- add an app that lets players create their own characters, vehicles etc? useful for standalone servers

Config.HousingScript = "auto"
Config.JailScript = "tk"
--[[
    Supported jail scripts:
        * auto: automatically detect the jail script (recommended)
        * qalle: esx-qalle-jail https://github.com/qalle-git/esx-qalle-jail
        * esx: esx_jail https://github.com/esx-community/esx_jail
        * pickle: pickle_prisons https://github.com/PickleModifications/pickle_prisons
        * qb: qb-prison https://github.com/qbcore-framework/qb-prison
        * xt: xt-prison
        * qbox: qbx_prison
        * rcore: rcore_prison
        * tk: tk-jail
]]

Config.Genders = "auto"
-- Config.Genders = {
--     {
--         label = "Male",
--         value = "m"
--     },
--     {
--         label = "Female",
--         value = "f"
--     }
-- }

Config.Item = {}
Config.Item.Require = true -- require a tablet item to use the tablet
Config.Item.Name = "tablet" -- name of the tablet item
Config.Item.Inventory = "auto"
Config.RequireItemDutyBlips = false -- require a tablet item to be shown on duty blips?
Config.DutyBlipOptions = {
    Show = true, -- show blips for players on duty on the in-game map?
    Category = 7,
    Sprite = 1,
    Color = 0,
    FriendIndicator = true,
    Outline = false,
    OutlineColour = { 93, 182, 229 },
    Scale = 0.9,
    ShortRange = true,
    ShowHeading = true,
    Name = "{name} - {callsign}",
    VehicleTypes = {
        car = 56,
        bike = 226,
        heli = 64,
        boat = 455,
        plane = 423,
    }
}

Config.AutoCreateEmail = true
Config.EmailDomain = "lorp.fun"
Config.DobFormat = "auto" -- default for qb-core

--[[ LANGUAGE OPTIONS ]] --
Config.DefaultLocale = "en"
Config.DateLocale = "en-US" -- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat
Config.DateFormat = "auto" -- auto: use the date format from the locale, or set a custom format (e.g. "DDDD, MMMM DD")
Config.CurrencyFormat = "$%s"

--[[ VOICE OPTIONS ]] --
Config.Voice = {}
Config.Voice.RecordNearby = true -- Should video & audio recording include nearby players?

--[[ ENTITY OPTIONS ]] --
Config.TabletModel = `lb_tablet_prop` -- the prop of the tablet, if you want to use a custom tablet model, you can change this here
Config.TabletRotation = vector3(0.0, 180.0, 0.0) -- the rotation of the tablet when attached to a player
Config.TabletOffset = vector3(0.05, -0.005, -0.04) -- the offset of the tablet when attached to a player
Config.ServerSideSpawn = true -- should the tablet entity be spawned on the server?

--[[ MISC OPTIONS ]] --
Config.KeepInput = true -- keep input when nui is focused (meaning you can walk around etc)
Config.DisableFocusTalking = true -- disable the focus key (default ALT) when talking in-game? Potentially fixes issues with PTT getting stuck (open mic)
Config.SyncFlashlight = true -- should flashlight be synced between players?
Config.AutoDeleteNotifications = true -- true = delete 1 week old notifications, false = keep all notifications. you can also set to a number (in hours) to delete after that time
Config.FadeOutsideTablet = true -- should the tablet fade when the cursor is outside of the tablet?
Config.EvidenceStash = true -- allow players to store evidence for cases in the tablet?
Config.DutyBlipInterval = 5000 -- how often should duty blips update? in milliseconds

Config.RequireDutyMDT = true -- require being on duty to be able to use work apps?

Config.LiveEdit = {}
Config.LiveEdit.Enabled = true
Config.LiveEdit.UpdateInterval = 250 -- how often (in ms) to update the live edit state?

--[[ DISPATCH OPTIONS ]]--
Config.RequireDutyDispatch = true -- require being on duty to see dispatch notifications?

Config.DispatchEnabled = false -- enable dispatch?
Config.DispatchVisible = false -- should the dispatch be visible? If false, you will only see dispatch in the MDT apps
Config.DispatchPosition = "right" -- position of the dispatch notifications (left / right)
Config.DispatchCompatibility = true -- add dispatch exports & events from other dispatch/mdt scripts? (note: this may not work with all scripts, we strongly recommend using the lb-tablet exports directly)
Config.AllowClientDispatch = true -- add client-sided exports for dispatch? (note: this allows modders to trigger dispatches, but may be needed for some scripts)
Config.ShowDispatchWithoutItem = true -- show dispatch even if the player doesn't have a tablet item?
Config.DispatchUpdateZIndex = true -- set the z-index to 99 when a dispatch comes in? this makes the dispatch appear over other UIs.
Config.HideDispatchWhenDead = true
Config.DispatchBlip = {
    Enabled = false, -- allow creating blips for dispatches
    Default = {
        Enabled = false, -- automatically create a blip for dispatches if one has not been provided?
        Type = "radius", -- default / radius
        Radius = 50.0,
        RandomCoords = true, -- randomize the coords within the radius?
        Sprite = 161, -- https://docs.fivem.net/docs/game-references/blips/#blips
        Color = 1, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        Size = 1.5,
        ShortRange = false, -- show blip only when close to it?
        Label = "{dispatch_title}", -- Available placeholders: {dispatch_title}, {id}, {priority}
    }
}

Config.BaseDispatch = {}
Config.BaseDispatch.Enabled = false -- enable the base dispatch system? calls for e.g. hijacking, shooting, etc
Config.BaseDispatch.Debug = false -- draw a line to the witness?
Config.BaseDispatch.RequireWitness = true -- require a witness (NPC) to trigger dispatch?
Config.BaseDispatch.RequireLos = true -- require line of sight from the witness to the player to trigger dispatch?
Config.BaseDispatch.MaxDistance = 100 -- maximum distance from the player to the witness to trigger dispatch
Config.BaseDispatch.CallPolice = true -- should a nearby NPC call the police when a dispatch is triggered?
Config.BaseDispatch.Chance = 100 -- chance of a dispatch being triggered (0-100)
Config.BaseDispatch.IgnorePolice = true -- don't add dispatches if a police caused them?
Config.BaseDispatch.Actions = {
    --[[
        To disable an action, set it to false.
        Options:
            - police: boolean -- should the police be notified?
            - ambulance: boolean -- should the ambulance be notified?
            - chance: number -- chance of the action being triggered (0-100)
            - cooldown: number -- how often this action can be triggered by each player
            - serverCooldown: number -- how often this action can be triggered (server-wide cooldown)
            - dispatch
                - priority: "low" | "medium" | "high"
                - time: number -- how long the dispatch should be visible (in seconds)
                - sound: string
    ]]
    CarJacking = false,
    VehicleTheft = false,
    Explosion = false,
    Gunshot = {
        police = true,
        ambulance = true,
        cooldown = 60,
        serverCooldown = 10,
        ignoredWeaponGroups = { -- https://docs.fivem.net/natives/?_0xC3287EE3050FB74C
            "DIGISCANNER",
            "FIREEXTINGUISHER",
            "HACKINGDEVICE",
            "METALDETECTOR",
            "NIGHTVISION",
            "PARACHUTE",
            "PETROLCAN",
            "STUNGUN",
            "TRANQILIZER",
            "UNARMED",
            "UNKNOWN"
        },
        dispatch = {
            priority = "high",
            time = 10,
        },
    },
    Armed = false,
}

Config.RealTime = true -- if true, the time will use real life time depending on where the user lives, if false, the time will be the ingame time.
Config.CustomTime = false -- NOTE: set Config.RealTime to false if using this. you can set this to a function that returns custom time, as a table: { hour = 0-23, minute = 0-59 }

Config.FrameColor = "#39334d" -- This is the color of the tablet frame. Default (#39334d) is purple.
Config.AllowFrameColorChange = true -- Allow players to change the color of their tablet frame?

Config.AllowExternal = { -- allow people to upload external images? (note: this means they can upload nsfw/gore etc)
    Police = true,
    Ambulance = true,
    Registration = true,
    Gallery = true,
    Mail = false,
    Other = false,
}

-- Blacklisted domains for external images. You will not be able to upload from these domains.
Config.ExternalBlacklistedDomains = {
    "imgur.com",
    "discord.com",
    "discordapp.com",
}

-- Whitelisted domains for external images. If this is not empty/nil/false, you will only be able to upload images from these domains.
Config.ExternalWhitelistedDomains = {
    "fivemanage.com",
    "fmfile.com",
}

-- Set to false/empty to disable
Config.UploadWhitelistedDomains = { -- domains that are allowed to upload images to the phone (prevent using devtools to upload images)
    "fivemanage.com",
    "fmfile.com",
    "cfx.re" -- lb-upload
}

Config.ShowLocationsInDispatch = true -- show locations in the police & ambulance dispatches?
Config.Locations = { -- Locations that'll appear in the maps app
    {
        position = vector2(2821.1423, 4761.0698),
        name = "Sheriff\'s Office",
        description = "Los Santos County Sheriff\'s Office",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
    },
    {
        position = vector2(833.9344, -1292.6493),
        name = "SAHP",
        description = "San Andreas Highway Patrol Office",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
    },
    {
        position = vector2(1089.6823, 2721.3835),
        name = "Sandy Shores",
        description = "Sandy Shores Medical Hospital",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
    },
}

Config.Locales = { -- If your desired language isn't here, you may contribute at https://github.com/lbphone/lb-tablet-locales
    {
        locale = "en",
        name = "English"
    },
    {
        locale = 'fr',
        name = 'Français'
    },
    {
        locale = 'sv',
        name = 'Svenska'
    },
    {
        locale = "de",
        name = "Deutsch"
    },
    {
        locale = "es",
        name = "Español"
    },
    {
        locale = "pt-br",
        name = "Português (Brasil)"
    },
    {
        locale = "ba",
        name = "Bosanski"
    },
    {
        locale = "nl",
        name = "Nederlands"
    },
    {
        locale = "ar",
        name = "العربية"
    },
    {
        locale = "cs",
        name = "Čeština"
    },
    {
        locale = "tr",
        name = "Türkçe"
    },
    {
        locale = "ro",
        name = "Romana"
    },
    {
        locale = "ua",
        name = "Українська"
    },
    {
        locale = "cn",
        name = "简体中文"
    },
}

-- See https://docs.lbscripts.com/tablet/script-integration/custom-apps/
-- Required fields:
--  identifier: The identifier of the app (string)
--  name: The name of the app (string)
-- Optional fields:
--  description: The description of the app (string)
--  icon: The icon of the app (string)
--  price: The price of the app (number)
--  images: An array of images for the app (string[])
--  developer: The developer of the app (string)
--  size: The size of the app, in kB (number)
--  ui: The URL of the app (string)
--  defaultApp: Whether the app is a default app (boolean)
-- Actions:
--  onInstall: A function that is called when the app is installed
--  onOpen: A function that is called when the app is opened
--  onClose: A function that is called when the app is closed
--  onUninstall: A function that is called when the app is uninstalled
Config.CustomApps = {}

--[[ SERVICES APP OPTIONS ]] --
Config.Services = {}
Config.Services.MessageOffline = true -- if true, players can message companies even if no one in the company is online
Config.Services.SeeEmployees = "employees" -- who should be able to see employees? they will see name, online status & phone number. options are: "everyone", "employees" or "none"
Config.Services.DeleteConversations = true -- allow employees to delete conversations?

Config.Services.Management = {
    Enabled = true, -- if true, employees & the boss can manage the companyW
    Duty = true, -- if true, employees can go on/off duty

    -- Boss actions
    Deposit = true, -- if true, the boss can deposit money into the company
    Withdraw = true, -- if true, the boss can withdraw money from the company
    Hire = true, -- if true, the boss can hire employees
    Fire = true, -- if true, the boss can fire employees
    Promote = true, -- if true, the boss can promote employees
}

Config.Services.Companies = { -- the companies that are shown in the app
    {
        job = "sheriff",
        name = "Sheriff\'s Office",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
        canMessage = true, -- if true, players can message the company
        location = {
            name = "Blaine County",
            coords = {
                x = 428.9,
                y = -984.5,
            }
        }
    },
    {
        job = "sahp",
        name = "San Andreas Highway Patrol Office",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
        canMessage = true, -- if true, players can message the company
        location = {
            name = "San Andreas",
            coords = {
                x = 833.9344,
                y = -1292.6493
            }
        }
    },
    {
        job = "ems",
        name = "EMS",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
        canMessage = true,
        location = {
            name = "Pillbox",
            coords = {
                x = 304.2,
                y = -587.0
            }
        }
    },
    {
        job = "realestate",
        name = "Real Estate Agency",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
        canMessage = true, -- if true, players can message the company
        location = {
            name = "Real Estate Office",
            coords = {
                x = -684.7641,
                y = 275.8139
            }
        }
    },
}

--[[ POLICE APP OPTIONS ]] --
Config.Police = {}

Config.Police.DutyBlips = true -- show blips for police officers on duty?

Config.Police.Callsign = {}
Config.Police.Callsign.AutoGenerate = true -- should a callsign be automatically generated when a police profile is created? please note that if you enable this after profiles have been created, the callsigns will not be updated
Config.Police.Callsign.Format = "111" --[[
    Callsign format:
        * 1: number 0-9
        * A: uppercase letter A-Z
        * a: lowercase letter a-z
        * ^: escape character
]]
Config.Police.Callsign.RequireTemplate = false -- Require users to follow the format of the callsign template?
Config.Police.Callsign.AllowChange = true

Config.Police.Jail = {}
Config.Police.Jail.Refresh = true -- should jail_time be updated by the tablet script? Set to false if you've fully configured your jail script to work with lb-tablet
Config.Police.Jail.Interval = 60 -- how often (in seconds) to update the jail time
Config.Police.Jail.CanUnjail = "auto" -- auto: true if supported jail script, otherwise false
Config.Police.Jail.AllowJailJailed = false -- allow police to jail players that are already jailed? (meaning they exist in lbtablet_police_jail)

Config.Police.Charges = {}
Config.Police.Charges.CountMethod = "stack" -- stack / highest, Should the charges stack or use the highest fine & jail amount?

Config.Police.Triangulation = {}
Config.Police.Triangulation.RequireCall = true -- require the phone number being triangulated to be in a call?
Config.Police.Triangulation.CellTowerTime = 500 -- how many milliseconds between each cell tower when searching?
Config.Police.Triangulation.SuccessRate = 50 -- how many % that the phone number will be found
Config.Police.Triangulation.RangeMultiplier = 1.0 -- how much to multiply the cell tower range by when searching?

Config.Police.PhoneUnlock = {}
Config.Police.PhoneUnlock.Time = { 120, 240 } -- how many minutes should it take to unlock a phone? This is a range, randomized
Config.Police.PhoneUnlock.Chance = 50 -- how many % that the phone will be unlocked
Config.Police.PhoneUnlock.Attempts = 2 -- how many attempts should the police have to unlock a phone, in total?

Config.Police.Wiretapping = {}
Config.Police.Wiretapping.MinimumCallDuration = 10 -- how many seconds the call must be active before it can be listened to?

Config.Police.Profile = {}
Config.Police.Profile.Fields = {
    dob = true,
    phoneNumber = true,
    gender = true,
    job = true,
    identifier = false,
    fingerprint = true,
}

Config.Police.Profile.Involvement = {
    report = {
        officer = true,
        civilian = true,
        suspect = true
    },
    case = {
        officer = true,
        civilian = true,
        criminal = true
    }
}

-- Here you can add custom fields that will be shown in profiles in the police app.
-- You can either edit the `Queries.Users.FetchProfile` query to return the data, or you can modify the `GetCustomFields` function
Config.Police.Profile.CustomFields = {
    -- {
    --     label = "DNA",
    --     value = "dna"
    -- }
}

Config.Police.Vehicle = {}
Config.Police.Vehicle.Fields = {
    model = true,
    plate = true,
    color = true,
    location = true,
    owner = true,
}

-- Here you can add custom fields that will be shown in vehicles in the police app.
-- You can modify the `GetCustomFields` function to return the data
Config.Police.Vehicle.CustomFields = {
    -- {
    --     label = "Insurance",
    --     value = "insurance"
    -- }
}

Config.Police.AutoRegisterWeapons = {}
Config.Police.AutoRegisterWeapons.Enabled = true -- automatically register weapons? this required a supported inventory (ox_inventory). Can be modified in server/custom/functions/registerWeapon.lua
Config.Police.AutoRegisterWeapons.AddUnregistered = false -- add unregistered weapons to the database?
Config.Police.AutoRegisterWeapons.IgnoreList = {
    "WEAPON_PETROLCAN",
    "WEAPON_SPRAYGUN"
}

Config.Police.Notifications = {
    NewBulletin = true,
    NewCase = true,
    NewReport = true,
    NewWarrant = true,
    NewChat = true,
    ChatMessage = true,
}

--[[
    Here you can set the offence classes & their color. Please note that you need to set the name of the class in the locales, e.g. in config/locales/en.json
    Available colors:
        grey    - #8e8e93
        blue    - #0a84ff
        green   - #32d74b
        red     - #ff3b30
        orange  - #ff9d0a
        yellow  - #cca250
        pink    - #ff3b30
        purple  - #af52de
        brown   - #a2845e
        navy    - #0a84ff
        cyan    - 5ac8fa
--]]

Config.Police.OffenceClasses = {
    infraction = "green",
    misdemeanor = "orange",
    felony = "red"
}

Config.Police.AdminPermissions = {
    logs = {
        view = true
    },
    bulletin = {
        pin = true,
        delete = true
    },
    case = {
        delete = true
    },
    warrant = {
        delete = true
    },
    report = {
        delete = true
    }
}

Config.Police.Permissions = {
    ["sheriff"] = {
        home = {
            view = 0,
        },
        dispatch = {
            view = 0,
            delete = 5,
        },
        unit = {
            view = 0,
            edit = 10,
            create = 10,
            delete = 10,
        },
        profile = {
            edit = 0,
            view = 0
        },
        vehicle = {
            edit = 0,
            view = 0
        },
        property = {
            edit = 0,
            view = 0,
        },
        weapon = {
            create = 5,
            delete = 10,
            edit = 5,
            view = 0,
        },
        report = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0
        },
        case = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0,
            fine = 0,
        },
        warrant = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0
        },
        offence = {
            create = 10,
            edit = 10,
            delete = 10,
            view = 0
        },
        employee = {
            view = 0,
        },
        chat = {
            -- The creator is always able to edit, kick and invite
            create = 0,
            edit = 10,
            kick = 10,
            invite = 10,
            view = 0
        },
        jail = {
            create = 0,
            edit = 0,
            unjail = 0,
            view = 0
        },
        phone = {
            view = 0,
            triangulate = 10,
            unlock = 10,
            createWiretap = 10,
            removeWiretap = 10, -- you can always remove your own wiretaps
            listenWiretap = 10,
            callHistory = 10,
        },
        logs = {
            view = 10,
        },
        tag = {
            create = 0,
            delete = 0,
        },
        license = {
            revoke = 5,
            add = 5,
            view = 0
        },
        bulletin = {
            create = 5,
            pin = 5,
            delete = 5, -- you are always able to delete your own bulletins
            edit = 5, -- you can always edit your own bulletins
            view = 0
        },
        stash = {
            view = 0,
        }
    },
    ["sahp"] = {
        home = {
            view = 0,
        },
        dispatch = {
            view = 0,
            delete = 5,
        },
        unit = {
            view = 0,
            edit = 7,
            create = 7,
            delete = 7,
        },
        profile = {
            edit = 0,
            view = 0
        },
        vehicle = {
            edit = 0,
            view = 0
        },
        property = {
            edit = 0,
            view = 0,
        },
        weapon = {
            create = 5,
            delete = 7,
            edit = 5,
            view = 0,
        },
        report = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0
        },
        case = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0,
            fine = 0,
        },
        warrant = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0
        },
        offence = {
            create = 7,
            edit = 7,
            delete = 7,
            view = 0
        },
        employee = {
            view = 0,
        },
        chat = {
            -- The creator is always able to edit, kick and invite
            create = 0,
            edit = 7,
            kick = 7,
            invite = 7,
            view = 0
        },
        jail = {
            create = 0,
            edit = 0,
            unjail = 0,
            view = 0
        },
        phone = {
            view = 0,
            triangulate = 7,
            unlock = 7,
            createWiretap = 7,
            removeWiretap = 7, -- you can always remove your own wiretaps
            listenWiretap = 7,
            callHistory = 7,
        },
        logs = {
            view = 10,
        },
        tag = {
            create = 0,
            delete = 0,
        },
        license = {
            revoke = 5,
            add = 5,
            view = 0
        },
        bulletin = {
            create = 5,
            pin = 5,
            delete = 5, -- you are always able to delete your own bulletins
            edit = 5, -- you can always edit your own bulletins
            view = 0
        },
        stash = {
            view = 0,
        }
    },
}

Config.Police.Header = {
    Logo = "./assets/img/icons/police/logo.webp",
    Title = "Police Department",
    Subtitle = "Mobile Police Terminal"
}

Config.Police.ReportTypes = {
    "Assault",
    "Robbery",
    "Burglary",
    "Theft",
    "Fraud",
    "Homicide",
    "Kidnapping",
    "Arson",
    "Vandalism",
    "Drug Offense",
    "Traffic Violation",
    "Domestic Violence",
    "Cybercrime",
    "Weapons Violation",
    "Public Disturbance",
    "Trespassing",
    "Harassment",
    "Missing Person",
    "Extortion",
    "Identity Theft",
    "Interrogation",
    "Other"
}

Config.Police.WarrantTypes = {
    "Arrest Warrant",
    "Search Warrant",
    "Bench Warrant",
    "Extradition Warrant",
    "Probation Violation Warrant",
    "Material Witness Warrant",
    "Execution Warrant",
    "Parole Violation Warrant"
}

Config.Police.WarrantStatuses = {
    active = {
        color = "red",
        label = "Active"
    },
    cancelled = {
        color = "orange",
        label = "Cancelled"
    },
    expired = {
        color = "red",
        label = "Expired"
    },
}

Config.Police.DefaultUnitStatus = "available"
Config.Police.UnitStatuses = {
    available = {
        label = "Available",
        color = "green",
    },
    busy = {
        label = "Busy",
        color = "red",
    },
    at_station = {
        label = "At Station",
        color = "blue",
    },
    on_call = {
        label = "On Call",
        color = "yellow",
    }
}

Config.Police.DefaultUnits = {
    --[[{
        name = "Unit 1",
        status = "available",
    },]]
}

Config.Police.Templates = {
    Report = "# Report template\n\n**Date:**\n**Reported By:** (Name & Callsign / Badge number)\n\n**Incident Details:**\n**Evidence Collected:**\n**Actions Taken:**\n\n**Additional Notes:**",
    Case = "# Case template\n\n**Date Opened:**\n**Filed by:** (Name & Callsign / Badge number)\n\n**Incident Details:**\n**Key Evidence:**\n**Investigation Progress:**\n\n**Additional Notes:**",
    Warrant = "# Warrant template\n\n**Date Issued:**\n**Requested By:** (Name & Callsign / Badge number)\n\n**Reason:**\n**Location / Target:**\n**Execution Details:**\n\n**Additional Notes:**"
}

--[[ AMBULANCE APP OPTIONS ]] --
Config.Ambulance = {}

Config.Ambulance.DutyBlips = true -- show blips for ambulance/doctors that are on duty?

Config.Ambulance.Header = {
    Logo = "./assets/img/icons/ambulance/logo.webp",
    Title = "Los Santos Medical Services",
    Subtitle = "Mobile Database Terminal"
}

Config.Ambulance.Profile = {}
Config.Ambulance.Profile.Fields = {
    dob = true,
    phoneNumber = true,
    gender = true,
    height = true,
    bloodType = true,
    identifier = false,
    fingerprint = false,
}

Config.Ambulance.Callsign = {}
Config.Ambulance.Callsign.AutoGenerate = true -- should a callsign be automatically generated when a Ambulance profile is created? please note that if you enable this after profiles have been created, the callsigns will not be updated
Config.Ambulance.Callsign.Format = "11-1111" --[[
    Callsign format:
        * 1: number 0-9
        * A: uppercase letter A-Z
        * a: lowercase letter a-z
        * ^: escape character
]]
Config.Ambulance.Callsign.RequireTemplate = false -- Require users to follow the format of the callsign template?
Config.Ambulance.Callsign.AllowChange = true

Config.Ambulance.Notifications = {
    NewBulletin = true,
    NewChat = true,
    NewReport = true,
    ChatMessage = true,
}

Config.Ambulance.ReportTypes = {
    "Injury",
    "Illness",
    "Vehicle Accident",
    "Overdose",
    "Cardiac Arrest",
    "Stroke",
    "Respiratory Distress",
    "Burn Injury",
    "Fall Injury",
    "Drowning",
    "Poisoning",
    "Seizure",
    "Trauma",
    "Allergic Reaction",
    "Shock",
    "Heatstroke",
    "Hypothermia",
    "Labor and Delivery",
    "Mental Health Crisis",
    "Other"
}

Config.Ambulance.DefaultUnitStatus = "available"
Config.Ambulance.UnitStatuses = {
    available = {
        label = "Available",
        color = "green",
    },
    busy = {
        label = "Busy",
        color = "red",
    },
    at_station = {
        label = "At Station",
        color = "blue",
    },
    on_call = {
        label = "On Call",
        color = "yellow",
    }
}

Config.Ambulance.DefaultUnits = {
    -- {
    --     name = "Unit 1",
    --     status = "available",
    -- },
}

Config.Ambulance.Templates = {
    Report = "Report template\n\nDate:\nReported By: (Name & Callsign)\n\nReport Details:\nInjuries:\nActions Taken:\n\nAdditional Notes:",
}

--[[
    Here you can set the severities & their color. Please note that you need to set the name of the severity in the locales, e.g. in config/locales/en.json
    Available colors:
        grey    - #8e8e93
        blue    - #0a84ff
        green   - #32d74b
        red     - #ff3b30
        orange  - #ff9d0a
        yellow  - #cca250
        pink    - #ff3b30
        purple  - #af52de
        brown   - #a2845e
        navy    - #0a84ff
        cyan    - 5ac8fa
--]]

Config.Ambulance.Severities = {
    minor = "green",
    moderate = "orange",
    severe = "red",
    critical = "red"
}

Config.Ambulance.AdminPermissions = {
    report = {
        delete = true
    },
    tag = {
        delete = true
    },
    chat = {
        kick = true
    },
    bulletin = {
        pin = true,
        delete = true
    },
    condition = {
        create = true,
        edit = true,
        delete = true
    },
    logs = {
        view = true
    },
}

Config.Ambulance.Permissions = {
    ["ems"] = {
        home = {
            view = 0
        },
        dispatch = {
            view = 0,
            delete = 0,
        },
        unit = {
            view = 0,
            edit = 3,
            create = 3,
            delete = 3,
        },
        profile = {
            edit = 0,
            view = 0,
            bill = 0
        },
        report = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0
        },
        condition = {
            create = 0,
            edit = 0,
            delete = 0,
            view = 0
        },
        employee = {
            view = 0
        },
        chat = {
            create = 0,
            edit = 3,
            kick = 3,
            invite = 3,
            view = 0
        },
        logs = {
            view = 5
        },
        tag = {
            create = 0,
            delete = 0
        },
        bulletin = {
            create = 3,
            pin = 3,
            delete = 3, -- you are always able to delete your own bulletins
            edit = 3, -- you can always edit your own bulletins
            view = 0
        },
    },
}

--[[ Browser App Options ]] --
Config.Browser = {}
Config.Browser.DefaultBookmarks = {
    {
        title = "LB",
        url = "https://lbscripts.com/",
        icon = "https://lbscripts.com/assets/favicon.ico"
    }
}

Config.Browser.WhitelistedDomains = {
    -- "lbscripts.com",
}

Config.Browser.BlacklistedDomains = {
    -- "example.com",
}

--[[ KEY BINDINGS ]] --
Config.KeyBinds = {  -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    Open = {
        bind = "M",
        description = "Open your tablet"
    },
    Focus = {
        bind = "LMENU", -- ALT
        description = "Toggle cursor on your tablet"
    },
    Opacity = {
        bind = "LMENU",
        description = "Toggle tablet transparency"
    },

    -- Dispatch
    NotificationUp = {
        bind = "UP",
        description = "Go up in the dispatch list"
    },
    NotificationDown = {
        bind = "DOWN",
        description = "Go down in the dispatch list"
    },
    NotificationDismiss = {
        bind = "O",
        description = "Dismiss the current dispatch"
    },
    NotificationView = {
        bind = "G",
        description = "View the current dispatch"
    },
    NotificationRespond = {
        bind = "Z",
        description = "Respond to the current dispatch"
    },
    NotificationExpand = {
        bind = "J",
        description = "Expand to the current dispatch"
    },

    -- Camera
    FlipCamera = {
        bind = "UP",
        description = "Flip camera"
    },
    TakePhoto = {
        bind = "RETURN",
        description = "Take a photo/video"
    },
    ToggleFlash = {
        bind = "E",
        description = "Toggle flash"
    },
    LeftMode = {
        bind = "LEFT",
        description = "Change mode"
    },
    RightMode = {
        bind = "RIGHT",
        description = "Change mode"
    },
    RollLeft = {
        bind = "Z",
        description = "Roll camera to the left"
    },
    RollRight = {
        bind = "C",
        description = "Roll camera to the right"
    },
    FreezeCamera = {
        bind = "X",
        description = "Freeze camera"
    },
    ToggleCameraTip = {
        bind = "H",
        description = "Toggle camera tip"
    },
    UnlockTablet = {
        bind = "SPACE",
        description = "Unlock your tablet",
    },
}

-- You can customize the function in lb-phone/server/custom/functions/webrtc.lua
-- You can set your api key in lb-phone/server/apiKeys.lua
Config.DynamicWebRTC = {}
Config.DynamicWebRTC.Enabled = false -- enable dynamic WebRTC? (this will allow you to generate new WebRTC credentials for each user)
Config.DynamicWebRTC.Service = "cloudflare" -- supported by default: cloudflare
Config.DynamicWebRTC.RemoveStun = false -- remove the stun servers?

-- ICE Servers for WebRTC (ig live, live video). If you don't know what you're doing, leave this as it is.
-- see https://developer.mozilla.org/en-US/docs/Web/API/RTCPeerConnection/RTCPeerConnection
-- Config.RTCConfig = {
--     iceServers = {
--         { urls = "stun:stun.l.google.com:19302" },
--     }
-- }

--[[ PHOTO / VIDEO OPTIONS ]] --
Config.Camera = {}
Config.Camera.ShowTip = true -- show a tip in the top-left of key binds for the camera?
Config.Camera.Roll = true -- allow rolling the camera to the left & right?
Config.Camera.AllowRunning = true
Config.Camera.MaxFOV = 60.0 -- higher = zoomed out (ultrawide)
Config.Camera.MinFOV = 10.0 -- lower = zoomed in (telephoto)
Config.Camera.MaxLookUp = 80.0
Config.Camera.MaxLookDown = -80.0

Config.Camera.Vehicle = {}
Config.Camera.Vehicle.Zoom = true -- allow zooming in vehicles?
Config.Camera.Vehicle.MaxFOV = 80.0
Config.Camera.Vehicle.MinFOV = 10.0
Config.Camera.Vehicle.MaxLookUp = 50.0
Config.Camera.Vehicle.MaxLookDown = -30.0
Config.Camera.Vehicle.MaxLeftRight = 120.0
Config.Camera.Vehicle.MinLeftRight = -120.0

Config.Camera.Selfie = {}
Config.Camera.Selfie.Offset = vector3(0.04, 0.48, 0.42)
Config.Camera.Selfie.Rotation = vector3(40.0, 0.0, -180.0)
Config.Camera.Selfie.MaxFov = 90.0
Config.Camera.Selfie.MinFov = 50.0

Config.Camera.Freeze = {}
Config.Camera.Freeze.Enabled = true -- allow players to freeze the camera when taking photos? (this will make it so they can take photos in 3rd person)
Config.Camera.Freeze.MaxDistance = 10.0 -- max distance the camera can be from the player when frozen
Config.Camera.Freeze.MaxTime = 60 -- max time the camera can be frozen for (in seconds)

-- Set your api keys in lb-tablet/server/apiKeys.lua
Config.UploadMethod = {}
-- You can edit the upload methods in lb-tablet/config/upload.lua
-- We recommend Fivemanage, https://fivemanage.com
-- Use code LBPHONE10 for 10% off on Fivemanage
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
-- If you want to host uploads yourself, you can use LBUpload: https://github.com/lbphone/lb-upload
Config.UploadMethod.Video = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Imgur"
Config.UploadMethod.Image = "Fivemanage" -- "Fivemanage" or "LBUpload" or "Imgur"
Config.UploadMethod.Audio = "Fivemanage" -- "Fivemanage" or "LBUpload"

Config.Video = {}
Config.Video.Bitrate = 400 -- video bitrate (kbps), increase to improve quality, at the cost of file size
Config.Video.FrameRate = 24 -- video framerate (fps), 24 fps is a good mix between quality and file size used in most movies
Config.Video.MaxSize = 25 -- max video size (MB)
Config.Video.MaxDuration = 60 -- max video duration (seconds)

Config.Image = {}
Config.Image.Mime = "image/webp"
Config.Image.Quality = 0.95

if Config.UploadMethod.Image == "Imgur" then
    Config.Image.Mime = "image/png"
    Config.Image.Quality = 1.0
end
