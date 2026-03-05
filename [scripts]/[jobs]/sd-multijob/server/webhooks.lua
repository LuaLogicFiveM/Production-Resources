--[[
    Application Webhook Configuration

    When a webhook is configured for a job, applications will be sent to the Discord webhook
    instead of being stored in the database. This is useful if you want to handle applications
    externally (e.g., through Discord) rather than through the in-game boss menu.

    Note: When using webhooks, applications will NOT appear in the boss menu's application list.
    The boss will need to review applications via Discord instead.
]]

ApplicationWebhooks = {
    -- Global setting to enable/disable webhook functionality
    enabled = false,

    -- Default webhook settings (used if a job doesn't have its own settings)
    default = {
        -- Bot name that appears in Discord
        username = 'Job Applications',
        -- Avatar URL for the bot (leave empty for default)
        avatar_url = '',
        -- Embed color (decimal color value, e.g., 3066993 for green)
        color = 3066993,
    },

    -- Per-job webhook configuration
    -- If a job is listed here with a valid webhook URL, applications will be sent to Discord
    -- If a job is NOT listed here or has an empty webhook, applications go to the database as normal
    jobs = {
        -- Example configuration:

        police = {
            webhook = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN',
            -- Optional overrides (if not set, uses default values above)
            username = 'LSPD Recruitment',
            avatar_url = 'https://example.com/police-logo.png',
            color = 255, -- Blue
            -- If true, also stores in database (hybrid mode). If false, webhook only.
            alsoStoreInDatabase = false,
        },

        ambulance = {
            webhook = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN',
            username = 'EMS Recruitment',
            color = 16711680, -- Red
            alsoStoreInDatabase = false,
        },
    },
}
