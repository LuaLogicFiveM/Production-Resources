Config = {}

-- Set to 'true' to enable the command, 'false' to disable it.
Config.EnableCommands = { 
    guidebook     = true,
    policebook    = true,
    ambulancebook = false,
    mechbook      = false,
    govbook       = false,
}

-- Set to 'true' to enable item usage, 'false' to disable it.
Config.EnableItems = {
    guidebook              = false,
    police_manual_book     = false,
    ambulance_manual_book  = false,
    mechanic_manual_book   = false,
    government_manual_book = false,
}

-- Set the title that will appear in the UI for each guidebook.
Config.BookTitles = {
    warga      = "Leaned Out Roleplay",
    police     = "Law Enforcement",
    ambulance  = "Medical Protocols", 
    mechanic   = "Mechanic Procedures",
    government = "Government Rulebook",
}

-- Define the minimum job grade allowed to edit each guidebook.
Config.EditPermissions = {
    ['bcso']     = 13, -- Example: Only grade 4 and above (e.g., Chief of Police) can edit
    ['ems']  = 10, -- Example: Only grade 3 and above (e.g., Director)
    ['mechanic']   = 2, -- Example: Only grade 2 and above (e.g., Head Mechanic)
    ['government'] = 2,
}

-- Define which admin groups have access to all features.
Config.AdminGroups = {
    ['owner']      = true,
    ['manager']      = true,
}