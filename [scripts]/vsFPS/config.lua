Config = {}

-- ============================================
-- GENERAL SETTINGS
-- ============================================

-- Command to open the FPS menu
Config.Command = "fps"

-- Enable/Disable sounds
Config.EnableSounds = true

-- Language (EN = English, DE = German)
Config.Language = "EN"

-- Menu position
-- Use "center" for vertical centering, or a number in pixels from top
-- Use "right" for right alignment, or a number in pixels from left
Config.MenuPosition = {
    top = "center",  -- "center" for vertical centering, or number in pixels
    right = 40       -- Distance from right (when using right alignment)
}

-- ============================================
-- ENABLE/DISABLE OPTIONS
-- ============================================

-- Enable or disable specific FPS modes in the menu
Config.Options = {
    low = true,        -- LOW mode
    rapid = true,      -- RAPID BOOST mode
    lowtex = true,     -- LOW TEXTURE mode
    nogpu = true,      -- NO GPU mode
    better = true,     -- BETTER GRAPHICS mode
    vignette = true,   -- VIGNETTE mode
    bw = true,         -- BLACK & WHITE mode
    reset = true,      -- RESET GRAPHICS (should always be true)
}

-- ============================================
-- LANGUAGE SETTINGS
-- ============================================

Config.Locale = {
    ["EN"] = {
        -- Menu Title
        menuTitle = "FPS MENU",
        
        -- Options
        optionLow = "LOW",
        optionLowDesc = "Minimal rendering",
        
        optionRapid = "RAPID BOOST",
        optionRapidDesc = "Strong FPS boost",
        
        optionLowTex = "LOW TEXTURE",
        optionLowTexDesc = "Reduce quality",
        
        optionNoGpu = "NO GPU",
        optionNoGpuDesc = "Potato mode",
        
        optionBetter = "BETTER GRAPHICS",
        optionBetterDesc = "High quality",
        
        optionVignette = "VIGNETTE",
        optionVignetteDesc = "Focus filter",
        
        optionBw = "BLACK & WHITE",
        optionBwDesc = "Old school look",
        
        optionReset = "RESET GRAPHICS",
        optionResetDesc = "Restore default",
    },
    
    ["DE"] = {
        -- Menu Title
        menuTitle = "FPS MENÜ",
        
        -- Options
        optionLow = "NIEDRIG",
        optionLowDesc = "Minimales Rendering",
        
        optionRapid = "SCHNELLER BOOST",
        optionRapidDesc = "Starker FPS-Boost",
        
        optionLowTex = "NIEDRIGE TEXTUREN",
        optionLowTexDesc = "Qualität reduzieren",
        
        optionNoGpu = "KEINE GPU",
        optionNoGpuDesc = "Kartoffel-Modus",
        
        optionBetter = "BESSERE GRAFIKEN",
        optionBetterDesc = "Hohe Qualität",
        
        optionVignette = "VIGNETTE",
        optionVignetteDesc = "Fokus-Filter",
        
        optionBw = "SCHWARZ & WEISS",
        optionBwDesc = "Old-School Look",
        
        optionReset = "GRAFIKEN ZURÜCKSETZEN",
        optionResetDesc = "Standard wiederherstellen",
    }
}

-- Get translation function
function Config.GetTranslation(key)
    local lang = Config.Locale[Config.Language] or Config.Locale["EN"]
    return lang[key] or key
end

