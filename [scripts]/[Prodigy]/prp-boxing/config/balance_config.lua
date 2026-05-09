Config = Config or {}

Config.DefenseStaminaDrain = 5 -- % stamina drain per sec while guarding
Config.StaminaRegen = 25 -- % stamina regen per sec
Config.StaminaRegenDelay = 750 -- miliseconds after last action to start regen
Config.HealthRegen = 0
Config.HealthRegenDelay = 0 -- miliseconds after last hit to start regen
Config.RemoveMaxStaminaPercentage = 3 -- percentage of max stamina to remove on round end based on total stamina used 
Config.SprintSpeedMultiplier = 2.0 -- multiplier for sprinting speed
Config.SprintStaminaCost = 50 -- stamina cost per second of sprinting

Config.AttackStaminaCost = {
    ["hook_body_l"] = 8,
    ["hook_body_pow_l"] = 12,
    ["hook_body_r"] = 8,
    ["hook_body_pow_r"] = 12,
    ["hook_head_l"] = 10,
    ["hook_head_pow_l"] = 14,
    ["hook_head_r"] = 10,
    ["hook_head_pow_r"] = 14,
    ["jab_body_l"] = 4,
    ["jab_body_pow_l"] = 6,
    ["jab_body_r"] = 4,
    ["jab_body_pow_r"] = 6,
    ["jab_head_l"] = 6,
    ["jab_head_pow_l"] = 8,
    ["jab_head_r"] = 6,
    ["jab_head_pow_r"] = 8,
    ["upper_body_l"] = 10,
    ["upper_body_pow_l"] = 14,
    ["upper_body_r"] = 10,
    ["upper_body_pow_r"] = 14,
    ["upper_head_l"] = 12,
    ["upper_head_pow_l"] = 16,
    ["upper_head_r"] = 12,
    ["upper_head_pow_r"] = 16,
}

Config.AttackDamage = {
    ["hook_body_l"] = 8,
    ["hook_body_pow_l"] = 12,
    ["hook_body_r"] = 8,
    ["hook_body_pow_r"] = 12,
    ["hook_head_l"] = 10,
    ["hook_head_pow_l"] = 16,
    ["hook_head_r"] = 10,
    ["hook_head_pow_r"] = 16,
    ["jab_body_l"] = 4,
    ["jab_body_pow_l"] = 8,
    ["jab_body_r"] = 4,
    ["jab_body_pow_r"] = 8,
    ["jab_head_l"] = 6,
    ["jab_head_pow_l"] = 10,
    ["jab_head_r"] = 6,
    ["jab_head_pow_r"] = 10,
    ["upper_body_l"] = 10,
    ["upper_body_pow_l"] = 20,
    ["upper_body_r"] = 10,
    ["upper_body_pow_r"] = 20,
    ["upper_head_l"] = 14,
    ["upper_head_pow_l"] = 24,
    ["upper_head_r"] = 14,
    ["upper_head_pow_r"] = 24,
}

Config.DefenseStaminaCost = {
    ["hook_body_l"] = 2,
    ["hook_body_pow_l"] = 6,
    ["hook_body_r"] = 2,
    ["hook_body_pow_r"] = 6,
    ["hook_head_l"] = 3,
    ["hook_head_pow_l"] = 8,
    ["hook_head_r"] = 3,
    ["hook_head_pow_r"] = 8,
    ["jab_body_l"] = 2,
    ["jab_body_pow_l"] = 3,
    ["jab_body_r"] = 2,
    ["jab_body_pow_r"] = 3,
    ["jab_head_l"] = 3,
    ["jab_head_pow_l"] = 4,
    ["jab_head_r"] = 3,
    ["jab_head_pow_r"] = 4,
    ["upper_body_l"] = 2,
    ["upper_body_pow_l"] = 5,
    ["upper_body_r"] = 2,
    ["upper_body_pow_r"] = 5,
    ["upper_head_l"] = 3,
    ["upper_head_pow_l"] = 6,
    ["upper_head_r"] = 3,
    ["upper_head_pow_r"] = 6,
}

Config.KOThreshold = 30
Config.KOAttacks = {
    ["hook_head_pow_l"] = 10,
    ["hook_head_pow_r"] = 10,
    ["jab_head_pow_l"] = 8,
    ["jab_head_pow_r"] = 8,
    ["upper_head_pow_l"] = 12,
    ["upper_head_pow_r"] = 12,
}


Config.AttackingShake = {
    ["jab_head_l"] = { -0.4, -0.25, 220, 1.0 },
    ["jab_head_r"] = {  0.4, -0.25, 220, 1.0 },
    ["jab_body_l"] = { -0.35, -0.2, 220, 1.0 },
    ["jab_body_r"] = {  0.35, -0.2, 220, 1.0 },
    ["jab_head_pow_l"] = { -0.5, -0.3, 500, 1.2 },
    ["jab_head_pow_r"] = {  0.5, -0.3, 500, 1.2 },
    ["jab_body_pow_l"] = { -0.45, -0.25, 500, 1.2 },
    ["jab_body_pow_r"] = {  0.45, -0.25, 500, 1.2 },
    ["hook_body_l"] = { -0.9, -0.3, 300, 1.1 },
    ["hook_body_r"] = {  0.9, -0.3, 300, 1.1 },
    ["hook_head_l"] = { -1.0, -0.35, 300, 1.1 },
    ["hook_head_r"] = {  1.0, -0.35, 300, 1.1 },
    ["hook_body_pow_l"] = { -1.3, -0.4, 500, 1.3 },
    ["hook_body_pow_r"] = {  1.3, -0.4, 500, 1.3 },
    ["hook_head_pow_l"] = { -1.4, -0.45, 500, 1.3 },
    ["hook_head_pow_r"] = {  1.4, -0.45, 500, 1.3 },
    ["upper_body_l"] = { -0.3, 0.8, 400, 1.2 },
    ["upper_body_r"] = {  0.3, 0.8, 400, 1.2 },
    ["upper_head_l"] = { -0.35, 1.0, 400, 1.3 },
    ["upper_head_r"] = {  0.35, 1.0, 400, 1.3 },
    ["upper_body_pow_l"] = { -0.4, 1.1, 500, 1.4 },
    ["upper_body_pow_r"] = {  0.4, 1.1, 500, 1.4 },
    ["upper_head_pow_l"] = { -0.45, 1.2, 500, 1.5 },
    ["upper_head_pow_r"] = {  0.45, 1.2, 500, 1.5 },
}

Config.GettingHitShake = {
    ["jab_head_l"] = { -0.55, 0.30, 200, 1.1 },
    ["jab_head_r"] = {  0.55, 0.30, 200, 1.1 },
    ["jab_body_l"] = { -0.45, 0.18, 200, 1.0 },
    ["jab_body_r"] = {  0.45, 0.18, 200, 1.0 },
    ["jab_head_pow_l"] = { -0.70, 0.40, 320, 1.2 },
    ["jab_head_pow_r"] = {  0.70, 0.40, 320, 1.2 },
    ["jab_body_pow_l"] = { -0.60, 0.28, 320, 1.2 },
    ["jab_body_pow_r"] = {  0.60, 0.28, 320, 1.2 },
    ["hook_body_l"] = { -1.10, 0.26, 260, 1.2 },
    ["hook_body_r"] = {  1.10, 0.26, 260, 1.2 },
    ["hook_head_l"] = { -1.25, 0.32, 280, 1.2 },
    ["hook_head_r"] = {  1.25, 0.32, 280, 1.2 },
    ["hook_body_pow_l"] = { -1.50, 0.36, 420, 1.35 },
    ["hook_body_pow_r"] = {  1.50, 0.36, 420, 1.35 },
    ["hook_head_pow_l"] = { -1.65, 0.42, 440, 1.35 },
    ["hook_head_pow_r"] = {  1.65, 0.42, 440, 1.35 },
    ["upper_body_l"] = { -0.25, 0.85, 320, 1.25 },
    ["upper_body_r"] = {  0.25, 0.85, 320, 1.25 },
    ["upper_head_l"] = { -0.30, 1.05, 340, 1.35 },
    ["upper_head_r"] = {  0.30, 1.05, 340, 1.35 },
    ["upper_body_pow_l"] = { -0.35, 1.20, 460, 1.45 },
    ["upper_body_pow_r"] = {  0.35, 1.20, 460, 1.45 },
    ["upper_head_pow_l"] = { -0.40, 1.35, 520, 1.55 },
    ["upper_head_pow_r"] = {  0.40, 1.35, 520, 1.55 },
}

Config.GymBoosts = {
    ["dexterity"] = {
        [250] = {
            maxHealth = 1.05,
        },
        [500] = {
            maxHealth = 1.1,
        },
        [750] = {
            maxHealth = 1.15,
        },
        [1000] = {
            maxHealth = 1.2,
        },
    },
    ["strength"] = {
        [250] = {
            punchDamage = 1.05,
        },
        [500] = {
            punchDamage = 1.1,
        },
        [750] = {
            punchDamage = 1.15,
        },
        [1000] = {
            punchDamage = 1.2,
        },
    },
    ["endurance"] = {
        [250] = {
            maxStamina = 1.05,
            staminaRegen = 1.05,
        },
        [500] = {
            maxStamina = 1.1,
            staminaRegen = 1.1,
        },
        [750] = {
            maxStamina = 1.15,
            staminaRegen = 1.15,
        },
        [1000] = {
            maxStamina = 1.2,
            staminaRegen = 1.2,
        },
    }
}