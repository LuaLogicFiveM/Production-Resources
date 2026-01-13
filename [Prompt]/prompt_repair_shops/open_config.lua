Config.EnableAnimatedProps = true -- If you want DEFAULT props without custom animations just put false on here.

-- Interaction key configuration
-- interactionControl: FiveM control index (default 38 = INPUT_CONTEXT / "E")
-- interactionKeyLabel: What shows in the UI prompt for the key
Config.InteractionControl = 38
Config.InteractionKeyLabel = "E"

Config.Messages = {
    interactButton = "Interact",
    noAccess = "You don't have access to this object",
    alreadyInUse = "This object is already in use",
    menuTitle = "Animated Objects",
    testAllAnimations = "Test all animations",
    open = "Open",
    close = "Close",
    -- textUI: Template for the in-world interaction prompt
    -- Available placeholders: {key}, {action}, {name}, {label}
    textUI = "[{key}] {action} {label}",
}

Config.InteriorEntitySets = { -- "1" is the default "basic" interior, "2" is the "upgraded" interior
    ['chumash'] = "1", 
    ['city'] = "2", 
    ['highway'] = "1", 
    ['paleto'] = "1", 
    ['beach'] = "2",
}
