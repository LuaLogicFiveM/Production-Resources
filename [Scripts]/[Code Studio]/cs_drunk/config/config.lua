Config = {}

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework
-- false = For Standalone

Config.ServerType = 'ESX'    --['QB'|'ESX'|false]


Config.OpenUI = {
    useCommand = false,
    Command_Name = 'atest',

    useItem = true,  --Enable ServerType in sv_function.lua
    Item_Name = 'alcohol_tester'
}


Config.Wait_TIme = 2    --Blower Waiting Time in seconds

Config.Animations = {
    Enable = true,
    Tester_Prop = `prop_inhaler_01`,

    Share_Anim = 'package_dropoff',
    Share_Dict = 'mp_safehouselost@',

    Use_Anim = 'loop',
    Use_Dict = 'mp_player_inteat@pnq'
}

Config.DrunkLevel = {
    [25] = 'green',     --Low Value [25 means upto 25 is low value of drunk]
    [75] = 'yellow',    --Mid Value
    [100] = 'red'       --High Value
}


Config.DrunkSettings = {
    Enable = true,             --Enble/Disable Drunk Value Deductions after certain time
    Reduce_Interval = 5.0,      --This will reduce alcholic level after certain minutes (In Minutes)
    Reduce_Level = 5            --Reduce Level
}

Config.DrunkEffect = true    --Enble/Disable Drunk Effect
Config.Effect_Interval = {
    --You can add more stages if you want
    [10] = {    --Drunk Level at which this Effect will occur
        Enable = true,                      --Enable/Disable Stage
        Animation = 'move_m@drunk@a'        --WalkStyle
    },
    [40] = {
        Enable = true,
        Animation = 'move_m@drunk@moderatedrunk'
    },
    [80] = {
        Enable = true,
        Animation = 'move_m@drunk@slightlydrunk'
    },
    [95] = {                     --Heavy Drunk Max Stage
        Enable = true,
        Animation = 'move_m@drunk@verydrunk'
    },
}


----Language Editor----

Config.Language = {
    wait_blow = 'WAIT',
    blow_txt = 'BLOW',
    tester_share = 'Alchohol Tester Given to Nearby Player',
    tester_smoke = 'Tell Nearest Player to Blow Air'
}