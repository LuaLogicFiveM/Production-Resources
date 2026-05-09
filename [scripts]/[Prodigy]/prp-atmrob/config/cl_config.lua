Config = {}

-- // Vehicle classes that cannot be attached to the ATM via rope
Config.NoAttachClass = {
    [8] = true, -- Motorcycles
    [13] = true, -- Cycles
    [14] = true, -- Boats
    [15] = true, -- Helicopters
    [16] = true, -- Planes
    [21] = true, -- Trains
}

Config.NoAttachModels = {
    [`blazer`] = true,
    [`blazer2`] = true,
    [`blazer3`] = true,
    [`blazer4`] = true,
    [`blazer5`] = true,
    [`airtug`] = true,
    [`armytanker`] = true,
    [`armytrailer`] = true,
    [`armytrailer2`] = true,
    [`baletrailer`] = true,
    [`boattrailer`] = true,
    [`boattrailer2`] = true,
    [`boattrailer3`] = true,
    [`caddy`] = true,
    [`caddy2`] = true,
    [`caddy3`] = true,
    [`docktrailer`] = true,
    [`forklift`] = true,
    [`freighttrailer`] = true,
    [`graintrailer`] = true,
    [`mower`] = true,
    [`proptrailer`] = true,
    [`raketrailer`] = true,
    [`tanker`] = true,
    [`tanker2`] = true,
    [`tr2`] = true,
    [`tr3`] = true,
    [`tr4`] = true,
    [`trailerlarge`] = true,
    [`trailerlogs`] = true,
    [`trailers`] = true,
    [`trailers2`] = true,
    [`trailers3`] = true,
    [`trailers4`] = true,
    [`trailers5`] = true,
    [`trailersmall`] = true,
    [`trflat`] = true,
    [`tvtrailer`] = true,
    [`tvtrailer2`] = true,
    [`rcbandito`] = true,
    [`veto`] = true,
    [`veto2`] = true,
}

-- // The amount of strength to add when pull the ATM. Higher number = easier to pull
-- // Must be > 0
-- Config.PullAmountMultiplier = 1.7
Config.PullAmountMultiplier = 1.7

Config.RequiredItemsForSearch = {
    rope = nil,
    hack = nil,
    explosive = nil
}
