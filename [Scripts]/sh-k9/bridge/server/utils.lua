-- variables --
local settings = require 'config.config'
local dc_roles = settings.restrictions.badger_discord.roles
local using_badger = settings.restrictions.badger_discord.enable
local using_ace = settings.restrictions.use_ace_perms
local jobs = settings.restrictions.jobs

-- functions
local function HasDiscordRole(src)
    local get_roles = exports.Badger_Discord_API:GetDiscordRoles(src)
    for _, id in each(get_roles) do
        if dc_roles[id] then return true end
    end
    return false
end

local function HasAcePerm(src)
    return IsPlayerAceAllowed(src, 'k9')
end

function HasAccess(src)
    -- badger discord roles
    if using_badger then 
        return HasDiscordRole(src) 
    end

    -- ace perms
    if using_ace then 
        return HasAcePerm(src) == 1 
    end

    -- job check, framework depending
    local job = GetJob(src)
    local has_job = jobs[job]

    return has_job
end

-- callbacks
lib.callback.register('sh-k9:cb:HasAccess', function(source)
    return HasAccess(source)
end)