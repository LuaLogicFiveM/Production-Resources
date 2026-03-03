CreateThread(function()
    local ESX = exports.es_extended:getSharedObject()
    local jobs = ESX.GetJobs()
    local jobData = {}

    for jobName, job in pairs(jobs) do
        for _, rankData in pairs(job.grades) do
            rankData.skin_female = nil
            rankData.skin_male = nil
            rankData.id = nil
            rankData.name = nil
            rankData.grade = nil
            rankData.job_name = nil
        end

        jobs[jobName] = job.grades
        jobData[jobName] = job.label
    end

    local function splitKeyValueTableIntoPages(tbl, pages)
        local keys = {}

        -- collect keys
        for k in pairs(tbl) do
            keys[#keys + 1] = k
        end

        -- keep order stable (important for Discord)
        table.sort(keys)

        local result = {}
        for i = 1, pages do
            result[i] = {}
        end

        local total = #keys
        local perPage = math.ceil(total / pages)

        for i, key in ipairs(keys) do
            local page = math.ceil(i / perPage)
            result[page][key] = tbl[key]
        end

        return result
    end

    local pages = splitKeyValueTableIntoPages(jobData, 5)

    local client = Client:new {
        token = GetConvar('discord_token', ""),
        guildId = GetConvar('discord_guild_id', ""),
        applicationId = GetConvar('discord_application_id', ""),
        intents = {
            Intents.GUILD_MESSAGES,
            Intents.GUILD_MESSAGE_REACTIONS,
            Intents.GUILD_MESSAGE_TYPING,
            Intents.DIRECT_MESSAGES,
            Intents.DIRECT_MESSAGE_REACTIONS,
            Intents.DIRECT_MESSAGE_TYPING,
            Intents.MESSAGE_CONTENT,
            Intents.GUILD_VOICE_STATES,
        }
    }

    client:on("ready", function()
        print("Bot is ready!")

        client:createCommand({
            name = "jobsearch",
            description = "Search a job for rank data",
            options = {
                {
                    name = "job",
                    description = "The job code (not label)",
                    type = OptionType.STRING,
                    required = true
                }
            }
        })

        client:createCommand({
            name = "embed",
            description = "Send an embed"
        })
    end)

    client:on("interactionCreate", function(interaction)
        if not interaction:hasRole({ "1082487503967232000", "1082487500871843860" }) then
            interaction:reply("You do not have permissions to use this command", true)
            return
        end

        if interaction.data.name == 'jobsearch' then
            local searchedJob = jobs[interaction.data.options[1].value]

            if not searchedJob then
                interaction:reply('This job was unable to be found, please be sure you are using the job code not label.', true)
                return
            end

            local jobSearchEmbed = Embed:new()
                :setTitle("Job Data")
                :setDescription(json.encode(searchedJob, {indent=true, sort_keys=true}))
                :setColor(0x00FF00)
                :setFooter("LuaLogic", "https://i.ibb.co/Xrv6s0nm/Lua-Logic-Logo.png")

            interaction:reply({
                embeds = {
                    jobSearchEmbed
                }
            }, false)

            return
        end

        if interaction.data.name == 'jobs' then
            local actionButtons = ActionRow:new()

            local embed = Embed:new()
                :setTitle("Job Table Data")
                :setDescription("- **Table Information**  \n  - if you are looking for a job code, find it here.  \n  - You can also use /jobsearch [job] to find rank data.  \n  - This list is in alphabetical order.")
                :setColor(0x00FF00)
                :setFooter("LuaLogic", "https://i.ibb.co/Xrv6s0nm/Lua-Logic-Logo.png")

            for pageId, pageData in ipairs(pages) do
                actionButtons:addComponent(
                    Button:new()
                    :setLabel(('Page %i'):format(pageId))
                    :setStyle(1)
                    :setCustomId(('page_%i'):format(pageId))
                )
            end

            interaction:reply({
                embeds = {
                    embed
                },
                components = {
                    actionButtons
                }
            }, false)

            return
        end

        local interactionId = interaction:getCustomId()

        if string.sub(interactionId, 1, 5) == 'page_' then
            local pageId = tonumber(string.sub(interactionId, 6, 7))
            local pageData = pages[pageId]

            interaction:reply(json.encode(pageData, {indent=true, sort_keys=true}), true)
            return
        end
    end)

    client:connect()
end)
