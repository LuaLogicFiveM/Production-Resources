local challengeStart = os.time()
local challenges = {}

local function generateNewChallenges()
    local selectedChallenges = {}
    local usedIndices = {}

    for _ = 1, math.min(DailyChallenges, #ChallengeTypes) do
        local idx

        repeat
            idx = math.random(1, #ChallengeTypes)
        until not usedIndices[idx]

        usedIndices[idx] = true

        table.insert(selectedChallenges, ChallengeTypes[idx])
    end

    for _, challengeType in ipairs(selectedChallenges) do
        local challengeData = Challenges[challengeType]
        local generationFunction = ChallengeGenerations[challengeType]

        if generationFunction then
            local generatedData = generationFunction(challengeData)

            local reward = challengeData.reward[math.random(1, #challengeData.reward)]

            MySQL.query.await("INSERT INTO fishing_challenges (challenge_type, data, reward, start_date, end_date) VALUES (@type, @data, @reward, CURDATE(), CURDATE() + INTERVAL 1 DAY)", {
                type = challengeType,
                data = json.encode(generatedData),
                reward = reward
            })
        end
    end

    lib.print.debug("Generated " .. #selectedChallenges .. " new challenges", json.encode(selectedChallenges))
end

local function resetDailyChallenges()
    local deactivated = MySQL.update.await("UPDATE fishing_challenges SET is_active = FALSE WHERE end_date <= CURDATE()")

    local currentChallenges = MySQL.single.await("SELECT COUNT(*) AS count FROM fishing_challenges WHERE is_active = TRUE LIMIT ?", {
        DailyChallenges
    })

    if deactivated > 0 and currentChallenges.count == 0 or currentChallenges.count == 0 then
        lib.print.debug("Deactivated " .. deactivated .. " fishing challenges")
        generateNewChallenges()
    end

    challenges = {}

    local activeChallenges = MySQL.query.await("SELECT *, UNIX_TIMESTAMP(start_date) AS start_date FROM fishing_challenges WHERE is_active = TRUE")

    for _, challenge in ipairs(activeChallenges) do
        challengeStart = challenge.start_date

        local data = json.decode(challenge.data)

        lib.print.debug("Challenge: " .. challenge.challenge_type, json.encode(data))

        table.insert(challenges, {
            id = challenge.challenge_id,
            type = challenge.challenge_type,
            data = data,
            reward = challenge.reward
        })
    end
end

MySQL.ready(function()
    local sqls = {
        [[
            create table if not exists fishing_challenges
            (
                challenge_id   int auto_increment
                    primary key,
                challenge_type varchar(50)          not null,
                data           longtext             not null,
                reward         varchar(255)         not null,
                is_active      tinyint(1) default 1 null,
                start_date     date                 not null,
                end_date       date                 not null
            );
        ]],
        [[
            create table if not exists fishing_catches
            (
                state_id       varchar(255)                           null,
                character_name varchar(255)                          null,
                item_name      varchar(50)                           null,
                item_count     int                                   null,
                item_weight    double                                null,
                time_caught    timestamp default current_timestamp() null
            );
        ]],
        [[
            ALTER TABLE fishing_catches ADD COLUMN IF NOT EXISTS character_name varchar(100) null AFTER state_id;
        ]],
        [[
            create index if not exists fishing_catches_item_name_index
                on fishing_catches (item_name);
        ]],
        [[
            create table if not exists fishing_challenges_completed
            (
                state_id       varchar(255)                           not null,
                challenge      int                                   not null,
                time_completed timestamp default current_timestamp() null,
                primary key (state_id, challenge)
            );
        ]],
        [[
            create table if not exists fishing_tournaments_won
            (
                state_id    varchar(255)                           not null,
                leaderboard enum ('monthly', 'weekly')            null,
                period_won  timestamp default current_timestamp() not null,
                paid_out    timestamp default current_timestamp() null
            );
        ]]
    }

    for _, sql in ipairs(sqls) do
        MySQL.query.await(sql)
    end

    resetDailyChallenges()
end)

lib.cron.new('0 0 * * *', function()
    resetDailyChallenges()
end)

bridge.fw.registerCommand(
    DailyChallengesResetCommand,
    "Reset daily fishing challenges",
    nil,
    "group.admin",
    function(source)
        MySQL.update.await("UPDATE fishing_challenges SET is_active = FALSE")
        generateNewChallenges()
        resetDailyChallenges()

        bridge.fw.notify(source, 'success', "Daily fishing challenges have been reset.")
    end
)

AddEventHandler("prp-fishing:fishCaught", function(pSource, itemName, fullItemName, count, metaData)
    lib.print.debug("Fish caught", itemName, fullItemName, count, json.encode(metaData))

    local stateId = bridge.fw.getIdentifier(pSource)
    lib.print.debug("Player state ID for caught fish:", stateId)

    if not stateId then
        error("Offline player just caught an fish?")
    end

    local characterName = bridge.fw.getCharacterName(stateId) or "Unknown"

    local insertSQL = [[
        INSERT INTO fishing_catches (state_id, character_name, item_name, item_count, item_weight)
        VALUES (@stateId, @characterName, @itemName, @count, @weight)
    ]]

    local affectedRows = MySQL.update.await(insertSQL, {
        stateId = stateId,
        characterName = characterName,
        itemName = itemName,
        count = count,
        weight = metaData.weight / 1000
    })

    if affectedRows > 0 then
        lib.print.debug("Fish caught and saved", itemName, count)
    end
end)

local function generateLabel(challenge, data, progress)
    local challengeData = Challenges[challenge]

    if not challengeData then
        return locale("UNKNOWN_CHALLENGE")
    end

    local label = challengeData.label

    if challenge == "CATCH_X_AMOUNT_Y" then
        local itemData = bridge.inv.getItemData("small_" .. data.fish)

        return string.format(label, progress .. "/" .. data.amount, itemData?.label or data.fish)
    end

    return string.format(label, progress .. "/" .. data.amount)
end

lib.callback.register("prp-fishing:getDailyChallenges", function(pSource)
    local playerChallenges = {}

    local playerStateId = bridge.fw.getIdentifier(pSource)

    if not playerStateId then
        error("Offline player trying to get daily challenges?")
    end

    local fishesCaught = MySQL.query.await("SELECT item_name, SUM(item_count) AS count FROM fishing_catches WHERE state_id = @stateId AND time_caught > FROM_UNIXTIME(@start) GROUP BY item_name", {
        stateId = playerStateId,
        start = challengeStart
    })

    local totalWeight = MySQL.single.await("SELECT SUM(item_weight) AS total FROM fishing_catches WHERE state_id = @stateId AND time_caught > FROM_UNIXTIME(@start)", {
        stateId = playerStateId,
        start = challengeStart
    })

    local totalFishes = 0
    local fishesKeyed = {}

    for _, fish in ipairs(fishesCaught) do
        totalFishes = totalFishes + fish.count

        fishesKeyed[fish.item_name] = (fishesKeyed[fish.item_name] or 0) + fish.count
    end

    lib.print.debug(json.encode(fishesKeyed, {
        indent = true
    }))

    for _, challenge in ipairs(challenges) do
        lib.print.debug(json.encode(challenge, {
            indent = true
        }))

        local progress = challenge.data.fish and (fishesKeyed[challenge.data.fish] or 0) or totalFishes

        if challenge.type == "CATCH_X_WEIGHT" then
            progress = totalWeight.total
        end

        if not progress then
            progress = 0
        end

        local percent = progress / challenge.data.amount * 100

        local hasCompletedChallenge = MySQL.single.await("SELECT COUNT(*) AS count FROM fishing_challenges_completed WHERE state_id = @stateId AND challenge = @challenge", {
            stateId = playerStateId,
            challenge = challenge.id
        })

        table.insert(playerChallenges, {
            id = challenge.id,
            type = challenge.type,
            label = generateLabel(challenge.type, challenge.data, progress),
            percent = percent,
            completed = hasCompletedChallenge.count > 0,
            reward = challenge.reward
        })
    end

    lib.print.debug("Player challenges", json.encode(playerChallenges))

    return playerChallenges
end)

lib.callback.register("prp-fishing:completeChallenge", function(pSource, challengeId)
    local stateId = bridge.fw.getIdentifier(pSource)

    if not stateId then
        error("Offline player trying to complete a challenge?")
    end

    local reward = MySQL.single.await("SELECT reward FROM fishing_challenges WHERE challenge_id = @id", {
        id = challengeId
    })

    if not reward or not reward.reward then
        return false
    end

    local completed = MySQL.update.await("INSERT INTO fishing_challenges_completed (state_id, challenge) VALUES (@stateId, @challenge)", {
        stateId = stateId,
        challenge = challengeId
    })

    if completed <= 0 then
        return false
    end

    local money = tonumber(reward.reward)

    if not money then
        return false
    end

    local hasAdded = bridge.fw.addMoney(pSource, "cash", money, "fishing_challenge")

    return hasAdded
end)