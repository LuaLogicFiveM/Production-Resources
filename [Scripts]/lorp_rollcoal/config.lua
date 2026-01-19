Config                                  = {}

Config.toggleSmokeCommand               = "rollcoal" -- Toggles the enahnced smoke locally (for lower end pcs)

Config.minSize                          = 0.1           -- the minimum smoke size
Config.minRPM                           = 0.7           -- 0.0 to 1.0 (0.7 - 0.85  are good values)
Config.scaleSmokeSizeWithVehicleWeight  = false

Config.defaultIntervalType              = 0             -- 0 = Constant, 1 = Interval, 2 = Interval short
Config.defaultParticleType              = 1             -- 0 = Thick Light Gray, 1 = Coal Gray, 2 = Medium Gray, 3 = Thin Light Gray 
Config.defaultSizeScale                 = 2.50             -- How quickly the smoke size scales (minimum 1.01)
Config.defaultEngineUpgradeRequired     = "off"         -- only allow smoke on specific engines "off" = disabled, -1 = stock, 0 = upgrade 1, 1 = upgrade 2, 2 = upgrade 3, 3 = upgrade 4
Config.defaultSizeReduction             = 5             -- Size is devided by this number
Config.defaultParticleDuration          = -1            -- after how long the particles dissapear. if set to -1, the particles will stay until naturally disolving. RECOMMENDED keeping at -1 (in seconds)

Config.useWhitelistedOnly               = true
Config.whitelist                        = {
    ["tremburd5thc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["drewscostal"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Nathan16hc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tullyl5p"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tlixxbb6g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["mikes7.3"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["SDSTOCK5GDUAL"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["NATHAN5G2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["mikes6.7"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tcmoney"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["SDBAWGS250"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sfwide24"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["mullets2g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Mikes7.3"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["TRILLZ5THGEN"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["NATHANSTREETCAT"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["nathan5g"] = {
        sizeScale = 5,
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sdlow5gdual"] = {
        sizeScale = 5,
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddydurdav9"] = {
        sizeScale = 5,
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tom23sirhd"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["masons6.7"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddylilmanv5"] = {
        sizeScale = 5,
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["cattletrucksv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddylilmanv4"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tlixxdevoram"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["AJSV45"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremtucksteel"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["drewsdonv7"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["mzunc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["drewstilmanv8"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddylilmanv3"] = {
        sizeScale = 5,
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddylilmanv2"] = {
        sizeScale = 5,
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["drewstilmanv5"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["drewsbeast7tree"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Drewsslipjrv1"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremwood5p"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["drewstilmanv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddyyodiiiv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremburdmax"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ajsv124"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ajsv141"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremfreckycummin"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["wmf_23hc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["TULLYPLATI250"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["yodiplati"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremghostcummins"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremclipz2500"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddyf3bubba"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ajsv115"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["nathandavis"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ajsv98"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ajsv99"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tullybub250"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["mega10x10"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ram2500"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["eu_55yob92"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["chuckkv74"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["whiteout5g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["ajsv53"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["bigcamslucasv3"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["chuckkwideobsv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["BRNANDO"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["chuckkv50"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["diddynaliv4"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["chuckkv20"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["cowboy4g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["kennywaldo2024"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["diddyplati"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["chuckkprev13"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["trillzchasev1"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["caddic59"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["nathan4g2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["chuckktopg"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Chuckkprev22"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Nathanpay"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Nathansilas"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Nathanchitv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zacc92bullets"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["whotfisdylan"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddytowpig2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["diddylongbox"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["johnboycum"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["SD2genbuba"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zaccsingw23"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zacc18afd"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["diddy2g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["daddytowpig"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zaccdragthurd"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["diddy6blow"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremshady06"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["johndragqueen"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["mustygreener"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["silv91"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zaccdrag3rd"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremevan250"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sdrj5g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremwayne3rd"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["leancat"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["trembigt2g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremdave19"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sdkg1street5g"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["TREMBRYCEHC"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tremwhistlbz"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["CMUSG4"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sfstreetdually"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sf24chevy"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zacc4fuel4"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["Smokeys4thsingle"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zyndianajones"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["joesdaniel"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sfviribus64"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffsgavv10"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffspercv5"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffsranch"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["tully350dually"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sdjtxdenali"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["3rdgenweldersrig"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffsgavv8"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["kbg5th"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["R2BT"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["R2HCST"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["gmcsquaredually"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["godzsema71f150"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["GODzXLT22F350SEMA"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["slippyhc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["6blowcummins"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["f250bubba"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["kittyweld"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["slips23"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffscunt"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["pappydual"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["willysplat"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["willysleanedout350"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["willyswork"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["bubbabands"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["cumminsjeep"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["peachesnc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["bcfabjeep"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["southern1st"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffsrugerv7"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["willy23gmc"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["muffsjohnnyv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sdrjfabcat"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zacccuswrang"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["cokedhale"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["joeschapo"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["wtrfall6o"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["fm00rep"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["costadaily"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sff350flat"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["shystiecountryv2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["thatwidefound"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["cokednate3"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["204sWeldingRig"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zacckg5"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["willyswork2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sr510"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["enzohd"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["willysskoop2"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["doughdiddyy"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["zaccany60"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["larryinternet"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["br4th"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
    ["sfjesco4th"] = {
        sizeScale = "DEFAULT",
        engineUpgradeRequired = "DEFAULT",
        intervalType  = "DEFAULT",
        particleType = "DEFAULT",
        sizeReduction = "DEFAULT",
        particleDuration = "DEFAULT"
    },
}