return {
    base = {
        rodSpeed = 0.55,

        fishSpeed = 0.2,
        dashSpeed = 0.4,
        dashFrequency = 0.15,
        
        catchZone = 6,
        catchTime = 2500,
        progressDecay = 0.15,
        totalTime = 20000,
    },
    
    controls = {
        left = {
            keys = {'LEFT', 'A'}
        },
        
        right = {
            keys = {'RIGHT', 'D'}
        }
    },
    
    rarityDifficulty = {
        common = 4,
        uncommon = 5,
        rare = 6,
        epic = 6,
        legendary = 7,
        treasure = 5
    },

    difficultyImpact = {
        rodSpeed = -0.05,
        
        fishSpeed = 0.15,
        dashSpeed = 0.15,
        dashFrequency = 0.05,
        
        catchZone = -0.08,
        catchTime = 0.15,
        progressDecay = 0.12,
        totalTime = -0.08
    }
}