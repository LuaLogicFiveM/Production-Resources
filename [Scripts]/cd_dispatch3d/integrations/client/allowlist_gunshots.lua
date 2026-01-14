function IsPlayingPaintball()
    local inPaintball = GetResourceState("pug-paintball") == "started" and exports["pug-paintball"]:IsInPaintball()
    local inBattleRoyale = GetResourceState("pug-battleroyale") == "started" and exports["pug-battleroyale"]:IsInBattleRoyale()
    return inPaintball and inBattleRoyale
end