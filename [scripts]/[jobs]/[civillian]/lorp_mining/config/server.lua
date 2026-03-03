return {

    ----------------------------------------------
    --        💬 Setup logging system
    ----------------------------------------------

    logs = {
        -- What logging service do you want to use?
        -- Available options: 'fivemanage', 'fivemerr', 'discord' & 'none'
        -- It is highly recommended to use a proper logging service such as Fivemanage or Fivemerr
        service = 'discord',
        -- Do you want to include screenshots with your logs?
        -- This is only applicable to Fivemanage and Fivemerr
        screenshots = false,
        -- You can enable (true) or disable (false) specific player events to log here
        events = {
            -- 'mined' is when a player mines a rock
            mined = true,
            -- 'smelted' is when a player smelts an ingot
            smelted = true,
            -- 'purchase' is when a player makes a purchase from shop
            purchased = true,
            -- 'pawned' is when a player pawns an item
            pawned = true,
        },
        -- If service = 'discord', you can customize the webhook data here
        -- If not using Discord, this section can be ignored
        discord = {
            -- The name of the webhook
            name = 'Mining Logs',
            -- The webhook link
            link = 'https://ptb.discord.com/api/webhooks/1193124191340351488/ifh1J_EzZ7ZIHB_31nBAXTjXnEgK3NMZIVdAjxR4pK9PfGvuw4ZzYNP_V0ldZ9Gb3ptB',
            -- The webhook profile image
            image = '',
            -- The webhook footer image
            footer = ''
        }
    },

}