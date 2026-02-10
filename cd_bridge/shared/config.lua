Cfg = {}

---------------------------------------------------------------------
-- AUTO-DETECT
-- 'auto_detect' will scan running resources and pick the best match.
-- Only change values if you want to FORCE a specific system.
---------------------------------------------------------------------

-- auto_detect | esx | qbcore | qbox | vrp | standalone | other
Cfg.Framework = 'auto_detect'

-- auto_detect | ghmattimysql | oxmysql | none
Cfg.Database = 'auto_detect'

Cfg.BridgeDebugSQL = false -- Print SQL queries
Cfg.BridgeDebug = false -- Print debug information
Cfg.DisableDuty = false -- Disable the built-in framework duty system. Set this to true if you do not want to use your framework’s duty system or any duty system at all.


Cfg.Language = 'EN' -- EN | ES | FR | DE | IT | PT | PT-BR | NL | PL | RU | TR | ZH | JA | AR | UA | CZ | DK | SE | NO | KR | HI

-- auto_detect | cd_notification | chat | esx | mythic_notify | okokNotify | origen_notify | ox_lib | pNotify | ps-ui | qbcore | qbox | rtx_notify | vms_notifyv2 | ZSX_UIV2 | other
Cfg.Notification = 'auto_detect'

-- auto_detect | cd_drawtextui | jg-textui | ox_lib | okokTextUI | ps-ui | qb-core | tgiann-core | vms_notifyv2 | ZSX_UIV2 | none | other
Cfg.DrawTextUI = 'auto_detect'

-- auto_detect | ox_target | qb-target | none
Cfg.Target = 'auto_detect'

-- auto_detect | esx | ox_inventory | qs-inventory | qb-inventory | qbcore | tgiann-inventory | none | other
Cfg.Inventory = 'auto_detect'

-- auto_detect | cd_easytime | qb-weathersync | vSync | none | other
Cfg.TimeWeather = 'auto_detect'

-- auto_detect | F_RealCarKeysSystem | ak47_qb_vehiclekeys | ak47_vehiclekeys | cd_garage | fivecode_carkeys | loaf_keysystem | mk_vehiclekeys | MrNewbVehicleKeys | qs-vehiclekeys | stasiek_vehiclekeys | t1ger_keys | tgiann-hotwire | ti_vehicleKeys | vehicles_keys | wasabi_carlock | xd_locksystem | qbx_vehiclekeys | qb-vehiclekeys | none  | other
Cfg.VehicleKeys = 'auto_detect'

-- auto_detect | BigDaddy-Fuel | cdn-fuel | esx-sna-fuel | FRFuel | lc_fuel | LegacyFuel | lj-fuel | lyre_fuel | mnr_fuel | myFuel | ND_Fuel | okokGasStation | ox_fuel | ps-fuel | qb-fuel | qb-sna-fuel | qs-fuelstations | rcore_fuel | Renewed-Fuel | ti_fuel | x-fuel | none | other
Cfg.VehicleFuel = 'auto_detect'

-- auto_detect | esx_phone | gcphone | gksphone | lb-phone | npwd | okokPhone | qb-phone | qbx_npwd | 17mov_Phone | none | other
Cfg.Phone = 'auto_detect'

-- auto_detect | cd_dispatch | cd_dispatch3d | codem-dispatch | core_dispatch | esx_outlawalert | emergencydispatch | lb-tablet | ps-dispatch | qs-dispatch | rcore_dispatch | tk_dispatch | none | other
Cfg.Dispatch = 'auto_detect'

-- auto_detect | cd_garage | AdvancedParking | none | other
Cfg.PersistentVehicles = 'auto_detect'

-- auto_detect | av_gangs | rcore_gangs | none | other
Cfg.Gang = 'auto_detect'

-- auto_detect | origen_police | none | other
Cfg.Duty = 'auto_detect'

---------------------------------------------------------------------

ESXVehiclesTables = { 'vehicles',  } -- Add additional vehicles tables if needed, used for storing vehicle data on esx.

---------------------------------------------------------------------

function Locale(locale_key, ...)
    if not locale_key then
        ERROR('0080', 'Locale key is nil')
        return ''
    end

    local lang = (Cfg and Cfg.Language) or 'EN'

    local function get(tbl)
        if not tbl then return nil end
        return (tbl[lang] and tbl[lang][locale_key]) or (tbl.EN and tbl.EN[locale_key])
    end

    local message = get(LocalesTable) or get(Locales) or get(BridgeLocalesTable)

    if not message then
        ERROR('0081', 'Locale not found: ' .. tostring(locale_key))
        return tostring(locale_key)
    end

    if select('#', ...) == 0 then
        return message
    end

    local ok, formatted = pcall(string.format, message, ...)
    if ok then
        return formatted
    end

    ERROR('0082',('String format failed for locale key: %s | Args: %s'):format(tostring(locale_key), json.encode({ ... })))

    return message
end

Cfg.Keys={['ESC']=322,['F1']=288,['F2']=289,['F3']=170,['F5']=166,['F6']=167,['F7']=168,['F8']=169,['F9']=56,['F10']=57,['~']=243,['1']=157,['2']=158,['3']=160,['4']=164,['5']=165,['6']=159,['7']=161,['8']=162,['9']=163,['-']=84,['=']=83,['BACKSPACE']=177,['TAB']=37,['Q']=44,['W']=32,['E']=38,['R']=45,['T']=245,['Y']=246,['U']=303,['P']=199,['[']=39,[']']=40,['ENTER']=18,['CAPS']=137,['A']=34,['S']=8,['D']=9,['F']=23,['G']=47,['H']=74,['K']=311,['L']=182,['LEFTSHIFT']=21,['Z']=20,['X']=73,['C']=26,['V']=0,['B']=29,['N']=249,['M']=244,[',']=82,['.']=81,['LEFTCTRL']=36,['LEFTALT']=19,['SPACE']=22,['RIGHTCTRL']=70,['HOME']=213,['PAGEUP']=10,['PAGEDOWN']=11,['DELETE']=178,['LEFTARROW']=174,['RIGHTARROW']=175,['TOP']=27,['DOWNARROW']=173,['NENTER']=201,['N4']=108,['N5']=60,['N6']=107,['N+']=96,['N-']=97,['N7']=117,['N8']=61,['N9']=118,['UPARROW']=172,['INSERT']=121}