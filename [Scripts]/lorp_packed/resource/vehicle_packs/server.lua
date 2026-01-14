local vehicle_packs_cache = {}
local vehicle_packs_vehicles = {
    ['willyscruzin'] = 1092660483535945741,
    ['slippy10'] = 1092660483535945741,
    ['willysext'] = 1092660483535945741,
    ['codecountry'] = 1092660483535945741,
    ['slipsbus'] = 1092660483535945741,
    ['slipsnewbody'] = 1092660483535945741,
    ['muffsplatti'] = 1092660483535945741,
    ['muffsbubplat'] = 1092660483535945741,
    ['joes20sierra'] = 1092660483535945741,

    ['gstiroc'] = 1083488022781231205,
    ['gstramv1'] = 1083488022781231205,
    ['CONCEPTR'] = 1083488022781231205,
    ['hellacious'] = 1083488022781231205,
    ['RedeyeSuperstockSCV2'] = 1083488022781231205,
    ['xk21octaviavrs'] = 1083488022781231205,
    ['m4f82'] = 1083488022781231205,
    ['cullinank'] = 1083488022781231205,
    ['2ncsx7'] = 1083488022781231205,

    ['328nii'] = 1092660407396749352,
    ['370zh'] = 1092660407396749352,
    ['240sxhr'] = 1092660407396749352,
    ['180sxrb'] = 1092660407396749352,
    ['86karma'] = 1092660407396749352,
    ['84rx7k'] = 1092660407396749352,
    ['titanh'] = 1092660407396749352,
    ['s15rbjr'] = 1092660407396749352,
    ['s14hachi'] = 1092660407396749352,
    ['s13neverlift'] = 1092660407396749352,
    ['MonalisaFF3'] = 1092660407396749352,
    ['hotwaterlab'] = 1092660407396749352,
    ['gtrh'] = 1092660407396749352,
    ['e2000er34'] = 1092660407396749352,
    ['drifts15'] = 1092660407396749352,
    ['driftram'] = 1092660407396749352,
    ['driftaltezza'] = 1092660407396749352,
    ['daisx'] = 1092660407396749352,
    ['anubis'] = 1092660407396749352,
    ['ugc13gt'] = 1092660407396749352,
    ['rrc5gm'] = 1092660407396749352,
    ['07wrx'] = 1092660407396749352,
    ['blockparty'] = 1092660407396749352,
    ['GODzC6FD'] = 1092660407396749352,
    ['S145Drift'] = 1092660407396749352,
    ['drecamaross1'] = 1092660407396749352,
    ['DTRACKHAWK'] = 1092660407396749352,
    ['dzr1drag'] = 1092660407396749352,
    ['g4eye'] = 1092660407396749352,
    ['joesmxrda'] = 1092660407396749352,
    ['kiki'] = 1092660407396749352,
    ['MadMax'] = 1092660407396749352,
    ['VengeanceRadialVette'] = 1092660407396749352,
    ['vengelco3'] = 1092660407396749352,
    ['VengKane'] = 1092660407396749352,
    ['carXsuz'] = 1092660407396749352,
    ['freebo240'] = 1092660407396749352,
    ['GODzA90DRIFT'] = 1092660407396749352,

    ['kkslimcharger'] = 1092660481262628954,
    ['sethstreetgto'] = 1092660481262628954,
    ['sethstreetelco'] = 1092660481262628954,
    ['sethsaleen'] = 1092660481262628954,
    ['sethpromod'] = 1092660481262628954,
    ['sethiroc'] = 1092660481262628954,
    ['proModGTX'] = 1092660481262628954,
    ['prostock'] = 1092660481262628954,
    ['radialr32'] = 1092660481262628954,
    ['radialsupra'] = 1092660481262628954,
    ['seth65'] = 1092660481262628954,
    ['sethcts'] = 1092660481262628954,
    ['draggtr2'] = 1092660481262628954,
    ['dragmaro2'] = 1092660481262628954,
    ['dragrunner'] = 1092660481262628954,
    ['drags10'] = 1092660481262628954,
    ['nomods'] = 1092660481262628954,
    ['outlaw'] = 1092660481262628954,
    ['prettypenny'] = 1092660481262628954,
    ['promod2'] = 1092660481262628954,
    ['promod3'] = 1092660481262628954,
    ['beastmode1'] = 1092660481262628954,
    ['beastmodesl'] = 1092660481262628954,
    ['beastmodetrailer'] = 1092660481262628954,
    ['fireballcamaro'] = 1092660481262628954,
    ['joesnarcos'] = 1092660481262628954,
    ['leroy'] = 1092660481262628954,
    ['ProTree'] = 1092660481262628954,
    ['saleendionR'] = 1092660481262628954,
    ['vanzdragth'] = 1092660481262628954,
    ['Waffleztwistedtea'] = 1092660481262628954,
    ['zaccdragc'] = 1092660481262628954,

    ['minininjalema'] = 1105094060546457690,
    ['r33hs'] = 1105094060546457690,
    ['porscheag'] = 1105094060546457690,
    ['minir34lema'] = 1105094060546457690,
    ['minis14lema'] = 1105094060546457690,
    ['MiniViperLema'] = 1105094060546457690,
    ['minixclasslema'] = 1105094060546457690,
    ['minia90lema'] = 1105094060546457690,
    ['miniageralema'] = 1105094060546457690,
    ['minicag'] = 1105094060546457690,
    ['minidv4rlema'] = 1105094060546457690,
    ['minievoque'] = 1105094060546457690,
    ['miniferrarilema'] = 1105094060546457690,
    ['minigolflema'] = 1105094060546457690,
    ['gtrag'] = 1105094060546457690,
    ['jeepag'] = 1105094060546457690,
    ['minimiatalema'] = 1105094060546457690,
    ['minimk4lema'] = 1105094060546457690,
    ['minimonsterlema'] = 1105094060546457690,
    ['mouseag'] = 1105094060546457690,
    ['mustangag'] = 1105094060546457690,
    ['legoporsche'] = 1105094060546457690,
    ['legochiron'] = 1105094060546457690,
    ['lsen'] = 1105094060546457690,

    ['b21raider'] = 1109680343218397244,
    ['darkstar'] = 1109680343218397244,
    ['eagle'] = 1109680343218397244,
    ['f14d2'] = 1109680343218397244,
    ['f22a'] = 1109680343218397244,
    ['ha420'] = 1109680343218397244,
    ['kawac2'] = 1109680343218397244,
    ['mh60k'] = 1109680343218397244,
    ['shahed136'] = 1109680343218397244,
    ['spybaloon'] = 1109680343218397244,
    ['wyvern'] = 1109680343218397244,

    ['skoopsmudtruck'] = 1249959063387635765,
    ['damudtrok'] = 1249959063387635765,
    ['tyymegaford'] = 1249959063387635765,
    ['sdmega350'] = 1249959063387635765,
    ['johnnymudtrok'] = 1249959063387635765,
    ['gt500offroad'] = 1249959063387635765,
    ['joesrickynigv4'] = 1249959063387635765,
    ['apexdon'] = 1249959063387635765,
    ['doughboymudtrok'] = 1249959063387635765,
    ['elaniptaco'] = 1249959063387635765,

    ['joesjohnnyv4'] = 1250296911882358887,
    ['M3BXANE'] = 1250296911882358887,
    ['mazfd'] = 1250296911882358887,
    ['rmodmustangs'] = 1250296911882358887,
    ['aventador'] = 1250296911882358887,
    ['ZL1Hycade'] = 1250296911882358887,
    ['16k5bk_sj'] = 1250296911882358887,
    ['f8snlargog'] = 1250296911882358887,
    ['GODzTRACKCAT'] = 1250296911882358887,

    ['crimsonlm'] = 1249959179804868658,
    ['sprintcar'] = 1249959179804868658,
    ['scarlm'] = 1249959179804868658,
    ['StreetStock'] = 1249959179804868658,
    ['USRAMOD'] = 1249959179804868658,
    ['SuperLateModel'] = 1249959179804868658,
    ['openbmod'] = 1249959179804868658,
    ['2017krypt'] = 1249959179804868658,

    ['asea'] = 1249958990872580117,
    ['jifamily'] = 1249958990872580117,
    ['dc_s63wald'] = 1249958990872580117,
    ['escaladesport'] = 1249958990872580117,
    ['lcbeast'] = 1249958990872580117,
    ['morhawk'] = 1249958990872580117,
    ['scarnrs3'] = 1249958990872580117,
    ['bmwm8hamann'] = 1249958990872580117,

    ['cmusg'] = 1250281315824041984,
    ['tor15luke'] = 1250281315824041984,

    ['joessuperv3'] = 1250297877868187718,

    ['ag_leaned_rp'] = 1082487503967232000,

    ['58DROP'] = 1399550614505263104,
    ['RAY63'] = 1399550614505263104,
    ['IMPALA59C'] = 1399550614505263104,
    ['RAY64'] = 1399550614505263104,
    ['CHECO75'] = 1399550614505263104,

    ['ghostsching'] = 1399550879891460106,
    ['ghostscholo'] = 1399550879891460106,
    ['ghostscholo7'] = 1399550879891460106,
    ['THEREAPERCHOP24'] = 1399550879891460106,
    ['HELLSPAWN'] = 1399550879891460106,
    ['NAGLFAR'] = 1399550879891460106,
    ['DARKFATE'] = 1399550879891460106,
}

CreateThread(function()
    Wait(500)
    for hash, roleid in pairs(vehicle_packs_vehicles) do
        vehicle_packs_cache[hash] = roleid
    end
end)

local discord = exports.lorp_discord_api

local function VehicleCheck(source, vehicle)
    local hash = GetEntityModel(NetworkGetEntityFromNetworkId(vehicle))
    local roleid = vehicle_packs_cache[hash]

    if not roleid then return true end

    local roles = discord:GetUserRoles(source)
    return roles and roles[tostring(roleid)] or false
end

RegisterNetEvent('lorp_packed:server:requestCheck', function(vehicle)
    local src = source
    local canDrive = VehicleCheck(src, vehicle)

    if canDrive then return end

    Wait(500)
    TaskLeaveAnyVehicle(GetPlayerPed(src), 0, 0)
    lib.notify(src, {title = 'Vehicle Packs', description = 'You are unable to drive this vehicle without access to the vehicle pack. (/vehiclepacks)', type = 'error', position = 'top'})
end)