return {
    --[[ 
        LEVEL SYSTEM TOGGLE
        Controls whether the K9 progression system is active
    ]]
    disable = true, -- Set to false to enable level system, true to disable
    -- When disabled (true): Dogs always obey commands, no XP gained, no level progression
    -- When enabled (false): Dogs gain XP and improve performance as they level up

    --[[ 
        EXPERIENCE POINT SYSTEM
        Controls how K9s gain experience from performing actions
    ]]
    chance_to_receive_xp = 20, -- Percentage chance to gain XP when performing actions (0-100)
    xp_per_action = {from = 5, to = 20}, -- Random XP amount gained per successful action

    --[[ 
        LEVEL PROGRESSION TABLE
        Define unlimited levels with custom stats for each level
        
        PARAMETER EXPLANATIONS:
        • xp = Total experience points required to reach this level
        • fail = Percentage chance for the dog to disobey commands (0-100)
        • tracking_speed = Movement speed while following tracks (1.0 = slowest, 5.0 = fastest)
        • tackle_chance = Percentage chance to tackle target during attacks (0-100)
        
        NOTES:
        - Levels must be numbered consecutively starting from 1
        - XP requirements should increase with each level
        - Higher levels should have better stats
        - These values override settings from the main config when level system is enabled
    ]]
    levels = {
        -- LEVEL 1: Rookie K9 (Starting level)
        [1] = { 
            xp = 0,             -- No XP required (starting level)
            fail = 30,          -- 30% chance to disobey commands
            tracking_speed = 1.0, -- Slow tracking speed
            tackle_chance = 10  -- Low tackle success rate
        },
        
        -- LEVEL 2: Trained K9
        [2] = { 
            xp = 150,           -- 150 XP required to reach level 2
            fail = 20,          -- 20% chance to disobey commands
            tracking_speed = 2.0, -- Moderate tracking speed
            tackle_chance = 20  -- Improved tackle success rate
        },
        
        -- LEVEL 3: Experienced K9
        [3] = { 
            xp = 350,           -- 350 XP required to reach level 3
            fail = 10,          -- 10% chance to disobey commands
            tracking_speed = 3.0, -- Good tracking speed
            tackle_chance = 30  -- Good tackle success rate
        },
        
        -- LEVEL 4: Veteran K9
        [4] = { 
            xp = 800,           -- 800 XP required to reach level 4
            fail = 5,           -- 5% chance to disobey commands
            tracking_speed = 4.0, -- Fast tracking speed
            tackle_chance = 30  -- High tackle success rate
        },
        
        -- LEVEL 5: Elite K9 (Maximum level)
        [5] = { 
            xp = 1500,          -- 1500 XP required to reach level 5
            fail = 0,           -- Never disobeys commands
            tracking_speed = 5.0, -- Maximum tracking speed
            tackle_chance = 30  -- Maximum tackle success rate
        },
    }
}