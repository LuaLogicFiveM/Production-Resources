if not Config.PoliceAlerts.ENABLE or Config.PoliceAlerts.Explosion.ENABLE then return end

local function Dbg(msg)
    if Config.Debug then
        Citizen.Trace('[PoliceAlerts][Explosion] ' .. msg .. '\n')
    end
end

local LastExplosionTick = -1
local LastExplosionKey = nil

local function Quantize(n, step)
    step = step or 5.0
    return math.floor((n / step) + 0.5) * step
end

local function MakeExplosionKey(coords, explosionType)
    local x = Quantize(coords.x, 6.0)
    local y = Quantize(coords.y, 6.0)
    local z = Quantize(coords.z, 6.0)
    return ('%s|%d|%d|%d'):format(tostring(explosionType or -1), x, y, z)
end

local function IsPlayerInExplosionWhitelistZone(coords)
    local zones = Config.PoliceAlerts.Explosion.WhitelistedZones
    if not zones then return false end

    for _, zone in pairs(zones) do
        if #(coords - zone.coords) <= zone.distance then
            return true
        end
    end
    return false
end

local function ParseExplosionArgs(args, fallbackCoords)
    if type(args) ~= 'table' then
        return nil, fallbackCoords
    end

    local explosionType = args[1]
    local x, y, z = args[2], args[3], args[4]

    if type(x) == 'number' and type(y) == 'number' and type(z) == 'number' then
        return explosionType, vector3(x, y, z)
    end

    return explosionType, fallbackCoords
end

local function TryExplosionAlert(explosionType, explosionCoords)
    local ped = PlayerPedId()
    local cfg = Config.PoliceAlerts.Explosion

    if IsCooldownActive('explosion') then
        Dbg('Cooldown is still active, returning.')
        return
    end
    if IsPlayerJobWhitelisted() then
        Dbg('Player job whitelisted, returning.')
        return
    end
    if IsPlayerInExplosionWhitelistZone(explosionCoords) then
        Dbg('Player is in a whitelisted zone, returning.')
        return
    end
    if IsPlayerInNoSnitchingZone() then
        Dbg('Player is in a no-snitching zone, returning.')
        return
    end
    if not RandomPoliceCallChance(Config.PoliceAlerts.Explosion.random_chance) then
        Dbg('Random chance to call police failed, returning.')
        return
    end

    local maxDist = cfg.max_distance_from_player
    local pcoords = GetEntityCoords(ped)
    if #(pcoords - explosionCoords) > maxDist then
        return
    end

    local key = MakeExplosionKey(explosionCoords, explosionType)
    if key == LastExplosionKey then
        return
    end
    LastExplosionKey = key

    local settleMs = 250
    if settleMs > 0 then
        Wait(settleMs)
    end

    local playerData = GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.PoliceAlerts.police_jobs,
        coords = explosionCoords or playerData.coords,
        title = Locale('policealerts_explosion_title'),
        message = Locale('policealerts_explosion_message_heard', playerData.street),
        flash = 0,
        sound = 1,
        blip = {
            sprite = 436,
            scale = 1.2,
            colour = 5,
            flashes = false,
            text = Locale('policealerts_explosion_title'),
            time = 5,
            radius = 100,
        }
    })

    StartCooldown('explosion', cfg.cooldown)
end


AddEventHandler('gameEventTriggered', function(eventName, args)
    local cfg = Config.PoliceAlerts.Explosion

    if not eventName:find('Explosion') then
        return
    end

    local tick = GetGameTimer()
    if LastExplosionTick == tick then
        return
    end
    LastExplosionTick = tick

    local ped = PlayerPedId()
    local fallback = GetEntityCoords(ped)

    local explosionType, explosionCoords = ParseExplosionArgs(args, fallback)

    TryExplosionAlert(explosionType, explosionCoords)
end)