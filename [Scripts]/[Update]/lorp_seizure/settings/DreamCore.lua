--[[
    Thank you for using our script. We are happy to have you here. If you need help, you can join our Discord server.
    https://discord.gg/zppUXj4JRm
]]

DreamLocales = {} -- Do not touch this!!!
DreamFramework = {} -- Do not touch this!!!
DreamCore = {} -- Do not touch this!!!

-- Dream Police Impound Settings
DreamCore.Language = 'en'
DreamCore.GiveCredits = false -- Set to false if you don't want to give credits

DreamCore.AllowedPoliceJobs = { 'sheriff', 'sahp', 'gov' } -- Allowed Police Jobs
DreamCore.ImpoundStatusIconColor = {
    [2] = '#d4af37',
    [3] = '#374f6b',
}
DreamCore.ImpoundCommands = {
    startAutoImpoundOldVehicles = 'autoimpound'
}
DreamCore.ImpoundAutomatic = {
    interval = 30 * 60 * 1000, -- in ms
    impoundAfter = 1 * 60 * 60 * 1000 -- in ms
}
DreamCore.ImpoundDurationFormat = '%m.%d.%Y %H:%M:%S'
DreamCore.ImpoundStations = {
    {
        label = 'Los Santos Impound',
        coords = vector3(408.9779, -1622.7163, 29.2919),
        ped = {
            model = 's_m_y_cop_01',
            coords = vector3(408.9779, -1622.7163, 28.2919),
            heading = 227.8904,
        },
        blip = {
            sprite = 67,
            color = 68,
            label = 'Los Santos Impound',
        },
        parkout = {
            coords = vector3(405.2425, -1644.0477, 28.2919),
            heading = 228.4430,
        }
    }
}

DreamCore.ImpoundForm = {
    Duration = {
        selection = 'time', -- date or time
        formatDate = "MM.DD.YYYY",
        formatTime = '12', -- 24 or 12
    },
    CustomFineAmount = false,
    DisableInput = {
        officer = true,
        model = false,
        plate = true,
    }
}
DreamCore.TuncionXP = {
    -- 🔗 Tuncion XP integration → https://github.com/Tuncion/tuncion_xp
    -- ⚡ activate = true = use XP/Level system from Tuncion
    -- ❌ activate = false = ignore / no XP integration
    -- 🎯 adjust XP values below for specific actions

    activate = false,
    resourceName = 'tuncion_xp',

    -- 📝 Actions (XP)
    impoundVehicle = 10,
    vehicleParkedOut = 5
}

--[[ QBCORE ONLY ]]

--[[ If set to true, the vehicle will be deleted from player_vehicles until the fine is paid.]]
--[[ If set to false, the vehicle's state will be updated to 2 (impounded). ]]
DreamCore.DeleteVehicle = true

--[[ QBCORE ONLY ]]

DreamCore.Target = function()
    if GetResourceState('ox_target') == 'started' then
        return 'ox'
    elseif GetResourceState('qb-target') == 'started' then
        return 'qb'
    else
        return error('No target system found! Please adjust DreamCore.Target!!!')
    end
end
