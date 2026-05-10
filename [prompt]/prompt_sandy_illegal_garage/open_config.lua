Config.EnableAnimations = false -- Enable/Disable all animated props
Config.EnablePlayerAnimations = false -- Enable/Disable player interaction animations
Config.Debug = false -- Enable/Disable debug messages in console
Config.UseOxTarget = true -- Use ox_target for interactions (if available)

--[[
    PERMISSIONS SYSTEM
    Set Config.Permissions.enabled = true to enable job-based restrictions
    Then configure allowedJobs on each prop in config.lua
]]
Config.Permissions = {
    enabled = false, -- Set to true to enable job restrictions
    
    -- Framework detection: 'auto', 'qb', 'qbox', 'esx', 'standalone'
    -- 'auto' will try to detect your framework automatically
    framework = 'auto',
    
    -- If you want to use ACE permissions instead of jobs, set this to true
    -- Then set acePermission on each prop (e.g. acePermission = "compound.lift")
    useAce = false,
    
    -- Default message when player doesn't have access
    noAccessMessage = "You don't have access to this"
}

-- Interaction key configuration
Config.InteractionKey = {
    control = 38,  -- Control ID (38 = E, 47 = G, 23 = F, 74 = H, 18 = Enter)
    display = "E"  -- Display text for UI
}

Config.Messages = {
    interactButton = "Interact",
    noAccess = "You don't have access to this object",
    alreadyInUse = "This object is already in use",
    menuTitle = "Animated Objects",
    testAllAnimations = "Test all animations",
    open = "Open",
    close = "Close",
}