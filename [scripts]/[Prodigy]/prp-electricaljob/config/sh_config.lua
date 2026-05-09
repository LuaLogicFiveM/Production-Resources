-- init locales
lib.locale()

Config = Config or {}

Config.StartByNPC = true
Config.DefaultBlip = true
Config.BlipSettings = {
    sprite = 354,
    color = 5,
    scale = 0.8,
    routeColor = 38,
    routeColor2 = 69
}
Config.Job = {}
Config.EnableDebugPrints = true

---@type JobOptions
Config.Job.Electrical = {
    id = "Electrical",
    name = locale("ELECTRICAL_JOB_LABEL"),
    maxMembers = 4,
    limit = 50,
    salaryPerBox = 100,
    depots = {
        {
            pedCoords = vector4(468.354919, -1900.960205, 24.398476, 117.919945),
            pedModel = `s_m_m_gardener_01`,
            vehSpawns = {
                vector4(464.370789, -1900.824463, 25.327444, 213.159882),
            },
        },
    },
}

Config.WhitelistedProps = {
    ["prop_elecbox_04a"] = true,
    ["prop_elecbox_05a"] = true,
    [`prop_elecbox_04a_open`] = true,
    [`prop_elecbox_05a_open`] = true,
}

Config.ReplaceProps = {
    [`prop_elecbox_05a`] = `prop_elecbox_05a_open`,
    [`prop_elecbox_04a`] = `prop_elecbox_04a_open`,
}

Config.WhitelistedZones = {
    ["AIRP"] = true,
    ["ALAMO"] = true,
    ["ALTA"] = true,
    ["BANHAMC"] = true,
    ["BANNING"] = true,
    ["BEACH"] = true,
    ["BHAMCA"] = true,
    ["BRADP"] = true,
    ["BRADT"] = true,
    ["BURTON"] = true,
    ["CALAFB"] = true,
    ["CANNY"] = true,
    ["CCREAK"] = true,
    ["CHAMH"] = true,
    ["CHIL"] = true,
    ["CHU"] = true,
    ["CYPRE"] = true,
    ["DAVIS"] = true,
    ["DELBE"] = true,
    ["DELPE"] = true,
    ["DELSOL"] = true,
    ["DESRT"] = true,
    ["DOWNT"] = true,
    ["DTVINE"] = true,
    ["EAST_V"] =  true,
    ["EBURO"] = true,
    ["ELGORL"] = true,
    ["ELYSIAN"] = true,
    ["GALFISH"] = true,
    ["GOLF"] = true,
    ["GRAPES"] = true,
    ["GREATC"] = true,
    ["HARMO"] = true,
    ["HAWICK"] = true,
    ["HORS"] = true,
    ["HUMLAB"] = true,
    ["KOREAT"] = true,
    ["LACT"] = true,
    ["LAGO"] =  true,
    ["LDAM"] = true,
    ["LEGSQU"] = true,
    ["LMESA"] = true,
    ["LOSPUER"] = true,
    ["MIRR"] = true,
    ["MORN"] = true,
    ["MOVIE"] = true,
    ["MTGORDO"] = true,
    ["MTJOSE"] = true,
    ["MURRI"] = true,
    ["NCHU"] = true,
    ["OCEANA"] = true,
    ["PALCOV"] = true,
    ["PALETO"] = true,
    ["PALFOR"] = true,
    ["PALHIGH"] = true,
    ["PBLUFF"] = true,
    ["PBOX"] = true,
    ["PROCOB"] = true,
    ["RANCHO"] = true,
    ["RGLEN"] = true,
    ["RICHM"] = true,
    ["ROCKF"] = true,
    ["RTRAK"] = true,
    ["SANAND"] = true,
    ["SANDY"] = true,
    ["SKID"] = true,
    ["SLAB"] =  true,
    ["STRAW"] = true,
    ["TATAMO"] = true,
    ["TERMINA"] = true,
    ["TEXTI"] = true,
    ["TONGVAH"] = true,
    ["TONGVAV"] = true,
    ["VCANA"] = true,
    ["VESP"] = true,
    ["VINE"] = true,
    ["WINDF"] = true,
    ["WVINE"] =  true,
    ["ZP_ORT"] =  true,
    ["ZQ_UAR"] = true,
}