Config = {}

-- Behavior modes:
-- 'always' -> Always show crosshair
-- 'armed'  -> Show when holding a weapon (not unarmed)
-- 'aiming' -> Show only when aiming (ADS/aim key)
Config.DefaultMode = 'armed'

-- Hide the default GTA V weapon reticle
Config.HideDefaultReticle = true

-- Default visual settings
Config.DefaultSettings = {
    type = 'vector',   -- 'vector' | 'png'
    style = 'dot', -- vector styles: 'classic' | 't' | 'dot' | 'circle' | 'x'
    color = { r = 255, g = 255, b = 255, a = 255 },
    size = 4,         -- line length
    thickness = 2,    -- line width
    gap = 6,          -- gap from center
    outline = true,
    dotInCenter = false,
    -- PNG mode settings
    pngPreset = '1',
    pngScale = 100,    -- percent
    pngOpacity = 100,  -- percent
}

-- Highlight when aiming at an NPC (like the original reticle turns red)
Config.EnemyAimHighlight = true
Config.EnemyColor = { r = 255, g = 64, b = 64, a = 255 }
-- Only highlight while actually aiming (recommended)
Config.HighlightOnlyWhenAiming = true
-- Also highlight while aiming at players (true by default)
Config.HighlightPlayers = true

-- (reserved for future use)
