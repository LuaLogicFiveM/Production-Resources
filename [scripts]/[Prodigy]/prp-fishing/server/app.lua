---@param rewards table
---@return string[]
local function getRewardsAsStrings(rewards)
    local stringRewards = {}

    for _, rewardItem in ipairs(rewards) do
        if rewardItem.name == "money" then
            table.insert(stringRewards, locale("REWARD_MONEY", rewardItem.count))
        elseif rewardItem.name == "trophy" then
            table.insert(stringRewards, locale("1_1_TROPHY"))
        else
            local itemData = bridge.inv.getItemData(rewardItem.name)

            table.insert(stringRewards, itemData and itemData.label or rewardItem.name)
        end
    end

    return stringRewards
end

local function getWinningsStashId(stateId)
    return "FISH_WINNINGS_" .. stateId
end

local function ensureWinningsStash(stateId)
    local stashId = getWinningsStashId(stateId)

    bridge.inv.createStash({
        id = stashId,
        label = locale("TOURNAMENT_WINNINGS"),
        slots = 8,
        maxWeight = 10000,
        owner = stateId
    })

    return stashId
end

lib.callback.register("prp-fishing:openWinningsStash", function(pSource)
    local stateId = bridge.fw.getIdentifier(pSource)
    local stashId = ensureWinningsStash(stateId)

    bridge.inv.openStash(pSource, stashId)
end)

lib.callback.register("prp-fishing:getProfile", function(pSource, stateId)
    -- characterName: 'Amadeus Leijonhjerta',

    -- tournamentsWon: 0,
    -- fishCaught: 231,
    -- fishCaught30: 53,
    -- heaviestFish: 12.3,
    -- heaviestFishLabel: 'Blue Marlin',
    -- totalWeight: 172.3,
    -- rarestFish: 'Blue Marlin',

    local query = [[
        SELECT
            SUM(item_count) AS fishCaught,
            SUM(CASE WHEN time_caught >= DATE_SUB(NOW(), INTERVAL 30 DAY) THEN 1 ELSE 0 END) AS fishCaught30,
            MAX(item_weight) AS heaviestFish,
            (SELECT item_name FROM fishing_catches fc2
            WHERE fc2.state_id = fc.state_id
            ORDER BY item_weight DESC LIMIT 1) AS heaviestFishLabel,
            (SELECT item_name FROM fishing_catches fc3
            WHERE fc3.state_id = fc.state_id
            GROUP BY item_name
            ORDER BY SUM(item_count) ASC, item_name DESC
            LIMIT 1) AS rarestFish
        FROM fishing_catches fc
        WHERE state_id = @stateId
    ]]

    local challengesCompletedQuery = [[
        SELECT
            COUNT(*) AS count
        FROM
            fishing_challenges_completed
        WHERE
            state_id = @stateId
    ]]

    local profile = MySQL.single.await(query, {
        stateId = stateId
    })

    local challenges = MySQL.single.await(challengesCompletedQuery, {
        stateId = stateId
    })

    profile.challengesCompleted = challenges.count

    local heaviestFishLabel = profile.heaviestFishLabel

    if heaviestFishLabel then
        local itemData = bridge.inv.getItemData("small_" .. heaviestFishLabel)

        profile.heaviestFishLabel = itemData and itemData.label or heaviestFishLabel
    else
        profile.heaviestFishLabel = locale("NOT_CAUGHT")
    end

    local rarestFish = profile.rarestFish

    if rarestFish then
        local itemData = bridge.inv.getItemData("small_" .. rarestFish)

        profile.rarestFishLabel = itemData and itemData.label or rarestFish
    else
        profile.rarestFishLabel = locale("NOT_CAUGHT")
    end

    lib.print.debug(json.encode(profile, {
        indent = true
    }))

    profile.characterName = bridge.fw.getCharacterName(stateId) or locale("UNKNOWN")

    return profile
end)

local function getTopQuery(topType, date)
    if topType == "weekly" then
        if date then
            return [[
                SELECT
                    fc.state_id AS id,
                    COALESCE(fc.character_name, 'Unknown') AS name,
                    SUM(fc.item_count) AS fishCaught,
                    EXISTS(
                        SELECT 1 FROM fishing_tournaments_won ftw
                        WHERE ftw.state_id = fc.state_id
                        AND YEARWEEK(ftw.period_won, 1) = YEARWEEK(@date, 1)
                        AND ftw.leaderboard = @leaderboard
                    ) AS hasWon
                FROM
                    fishing_catches fc
                WHERE
                    YEARWEEK(fc.time_caught, 1) = YEARWEEK(@date, 1)
                GROUP BY
                    fc.state_id
                ORDER BY
                    fishCaught DESC
                LIMIT 3
            ]]
        end

        return [[
            SELECT
                fc.state_id AS id,
                COALESCE(fc.character_name, 'Unknown') AS name,
                SUM(fc.item_count) AS fishCaught,
                EXISTS(
                    SELECT 1 FROM fishing_tournaments_won ftw
                    WHERE ftw.state_id = fc.state_id
                    AND YEARWEEK(ftw.period_won, 1) = YEARWEEK(CURDATE(), 1)
                    AND ftw.leaderboard = @leaderboard
                ) AS hasWon
            FROM
                fishing_catches fc
            WHERE
                YEARWEEK(fc.time_caught, 1) = YEARWEEK(CURDATE(), 1)
            GROUP BY
                fc.state_id
            ORDER BY
                fishCaught DESC
            LIMIT 3
        ]]
    end

    if date then
        return [[
            SELECT
                fc.state_id AS id,
                COALESCE(fc.character_name, 'Unknown') AS name,
                SUM(fc.item_count) AS fishCaught,
                EXISTS(
                    SELECT 1 FROM fishing_tournaments_won ftw
                    WHERE ftw.state_id = fc.state_id
                    AND DATE_FORMAT(ftw.period_won, '%Y-%m') = DATE_FORMAT(@date, '%Y-%m')
                    AND ftw.leaderboard = @leaderboard
                ) AS hasWon
            FROM
                fishing_catches fc
            WHERE
                DATE_FORMAT(fc.time_caught, '%Y-%m') = DATE_FORMAT(@date, '%Y-%m')
            GROUP BY
                fc.state_id
            ORDER BY
                fishCaught DESC
            LIMIT 3
        ]]
    end

    return [[
        SELECT
            fc.state_id AS id,
            COALESCE(fc.character_name, 'Unknown') AS name,
            SUM(fc.item_count) AS fishCaught,
            EXISTS(
                SELECT 1 FROM fishing_tournaments_won ftw
                WHERE ftw.state_id = fc.state_id
                AND DATE_FORMAT(ftw.period_won, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')
                AND ftw.leaderboard = @leaderboard
            ) AS hasWon
        FROM
            fishing_catches fc
        WHERE
            fc.time_caught >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
            AND fc.time_caught < DATE_FORMAT(CURRENT_DATE + INTERVAL 1 MONTH, '%Y-%m-01')
        GROUP BY
            fc.state_id
        ORDER BY
            fishCaught DESC
        LIMIT 3
    ]]
end

lib.callback.register("prp-fishing:loadApp", function(pSource, type)
    -- initialState.top = [
    -- 	{
    -- 		id: 1,
    -- 		name: 'John Kowalski',
    -- 		fishCaught: 125,
    -- 		rewards: ['Trophy', 'Golden Fishing Rod'],
    -- 	},
    -- 	{
    -- 		id: 2,
    -- 		name: 'Jane Doe',
    -- 		fishCaught: 112,
    -- 		rewards: ['Trophy'],
    -- 	},
    -- 	{
    -- 		id: 3,
    -- 		name: 'Jenny Johnson',
    -- 		fishCaught: 101,
    -- 		rewards: ['Trophy'],
    -- 	},
    -- ];

    -- initialState.myScore = {
    -- 	fishCaught: 109,
    -- 	position: 2,
    -- };

    local stateId = bridge.fw.getIdentifier(pSource)

    local topCatchersQuery = getTopQuery(type)

    local topCatchers = MySQL.query.await(topCatchersQuery, {
        leaderboard = type
    })

    for position = 1, #topCatchers do
        local reward = Rewards[type][position]

        topCatchers[position].rewards = getRewardsAsStrings(reward)
    end

    local myScoreQuery = [[
        SELECT
            SUM(item_count) AS fishCaught,
            RANK() OVER (ORDER BY SUM(item_count) DESC) AS position
        FROM
            fishing_catches
        WHERE
            time_caught >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
            AND time_caught < DATE_FORMAT(CURRENT_DATE + INTERVAL 1 MONTH, '%Y-%m-01')
            AND state_id = @stateId
    ]]

    if type == "weekly" then
        myScoreQuery = [[
            SELECT
                SUM(item_count) AS fishCaught,
                RANK() OVER (ORDER BY SUM(item_count) DESC) AS position
            FROM
                fishing_catches
            WHERE
                time_caught >= DATE_SUB(CURRENT_DATE, INTERVAL WEEKDAY(CURRENT_DATE) DAY)
                AND time_caught < DATE_ADD(DATE_SUB(CURRENT_DATE, INTERVAL WEEKDAY(CURRENT_DATE) DAY), INTERVAL 1 WEEK)
                AND state_id = @stateId
        ]]
    end

    local myScore = MySQL.single.await(myScoreQuery, {
        stateId = stateId
    })

    local data = {
        top = topCatchers,
        myScore = myScore
    }

    lib.print.debug(json.encode(data, {
        indent = true
    }))

    return data
end)

-- For some reason ox_lib dialog date gives month + 1?
local function adjustMonth(timestamp)
    -- Extract just the date portion (YYYY-MM-DD)
    local dateStr = timestamp:match("^(%d+-%d+-%d+)") or timestamp

    -- Parse year, month, day
    local year, month, day = dateStr:match("(%d+)-(%d+)-(%d+)")
    year, month, day = tonumber(year), tonumber(month), tonumber(day)

    -- Subtract 1 month with proper year adjustment
    month = month - 1
    if month < 1 then
        month = 12
        year = year - 1
    end

    -- Format back to YYYY-MM-DD with leading zeros
    return string.format("%04d-%02d-%02d", year, month, day)
end

lib.callback.register("prp-fishing:getTop", function(_, type, date)
    local topCatchersQuery = getTopQuery(type, date)

    lib.print.debug(topCatchersQuery, adjustMonth(date))

    local topCatchers = MySQL.query.await(topCatchersQuery, {
        date = adjustMonth(date),
        leaderboard = type
    })

    lib.print.debug(json.encode(topCatchers, {
        indent = true
    }))

    for position = 1, #topCatchers do
        topCatchers[position].rewards = getRewardsAsStrings(Rewards[type][position])
    end

    return topCatchers
end)

lib.callback.register("prp-fishing:giveOutReward", function(pSource, stateId, position, rewardType, periodWon)
    if not bridge.fw.isAdmin(pSource) then
        lib.print.warn(("Non-admin player %d attempted to give out fishing tournament reward"):format(pSource))
        return false
    end

    local reward = Rewards[rewardType] and Rewards[rewardType][position]
    if not reward then
        return false
    end

    -- Verify the player actually holds this position on the leaderboard
    local adjustedDate = adjustMonth(periodWon)
    local topCatchersQuery = getTopQuery(rewardType, periodWon)
    local topCatchers = MySQL.query.await(topCatchersQuery, {
        date = adjustedDate,
        leaderboard = rewardType
    })

    local verified = false
    if topCatchers and topCatchers[position] then
        local actualId = topCatchers[position].state_id or topCatchers[position].id
        if actualId == stateId then
            verified = true
        end
    end

    if not verified then
        lib.print.warn(("Reward rejected: player %s is not in position %d for %s leaderboard"):format(tostring(stateId), position, rewardType))
        return false
    end

    local query = [[
        INSERT INTO
            fishing_tournaments_won (state_id, leaderboard, period_won)
        VALUES
            (@stateId, @leaderboard, @periodWon)
    ]]

    local success = MySQL.update.await(query, {
        stateId = stateId,
        leaderboard = rewardType,
        periodWon = adjustedDate
    })

    if success > 0 then
        local inventoryId = ensureWinningsStash(stateId)

        for _, rewardData in ipairs(reward) do
            local name = rewardData.name
            local count = rewardData.count

            if name == "money" then
                local src = bridge.fw.getSrcFromIdentifier(stateId)

                if src then
                    bridge.fw.addMoney(src, "cash", count, "fishing_tournament_" .. rewardType)
                    bridge.fw.notify(src, 'inform', locale("RECEIVED_MONEY", count, position, rewardType))
                end
            elseif name == "trophy" then
                local monthNumber = tonumber(adjustMonth(periodWon):match("^%d+%-(%d+)%-"))

                if FishingTrophyMonths[monthNumber] then
                    bridge.inv.giveItem(inventoryId, "pr_trophy_fish_" .. FishingTrophyMonths[monthNumber], 1)
                end
            else
                bridge.inv.giveItem(inventoryId, name, count)
            end
        end

        return true
    end
end)

local function GetPreviousPeriodDate(mode)
    local now = os.time()
    local d = os.date("*t", now)

    if mode == "monthly" then
        d.day = 1
        d.month = d.month - 1
        return os.date("%Y-%m-%d", os.time(d))
    elseif mode == "weekly" then
        local currentWeekday = tonumber(os.date("%w", now))
        local daysToSubtract = (currentWeekday == 0 and 6) or (currentWeekday - 1 + 7)
        if currentWeekday == 1 then daysToSubtract = 7 end

        return os.date("%Y-%m-%d", now - (daysToSubtract * 86400))
    end
end

local function ProcessAutomatedRewards(mode)
    local periodRewards = Rewards[mode]
    if not periodRewards then
        lib.print.debug("[Fishing] Error: No rewards defined for mode " .. tostring(mode))
        return
    end

    local rawDate = GetPreviousPeriodDate(mode)
    local periodWon = rawDate

    lib.print.debug(string.format("[Fishing] Processing %s rewards for date: %s", mode, periodWon))

    local topCatchersQuery = getTopQuery(mode, rawDate)

    local topCatchers = MySQL.query.await(topCatchersQuery, {
        date = periodWon,
        leaderboard = mode
    })

    if topCatchers and #topCatchers > 0 then
        for position, playerData in ipairs(topCatchers) do
            local rewardConfig = periodRewards[position]

            if rewardConfig then
                local stateId = playerData.state_id or playerData.id

                local alreadyWon = MySQL.scalar.await([[
                    SELECT 1 FROM fishing_tournaments_won
                    WHERE state_id = ? AND leaderboard = ? AND period_won = ?
                ]], { stateId, mode, periodWon })

                if not alreadyWon then
                    local success = MySQL.update.await([[
                        INSERT INTO fishing_tournaments_won (state_id, leaderboard, period_won)
                        VALUES (?, ?, ?)
                    ]], { stateId, mode, periodWon })

                    if success > 0 then
                        local inventoryId = ensureWinningsStash(stateId)

                        for _, item in ipairs(rewardConfig) do
                            local name = item.name
                            local count = item.count

                            if name == "money" then
                                local src = bridge.fw.getSrcFromIdentifier(stateId)
                                if src then
                                    bridge.fw.addMoney(src, "cash", count, "fishing_tournament_" .. mode)
                                    bridge.fw.notify(src, 'inform', locale("RECEIVED_MONEY", count, position, mode))
                                end
                            elseif name == "trophy" then
                                local monthNumber = tonumber(periodWon:match("^%d+%-(%d+)%-"))

                                if FishingTrophyMonths[monthNumber] then
                                    bridge.inv.giveItem(inventoryId,
                                        "pr_trophy_fish_" .. FishingTrophyMonths[monthNumber], 1)
                                end
                            else
                                bridge.inv.giveItem(inventoryId, name, count)
                            end
                        end
                        print(string.format("[Fishing] Success: Given %s Reward (Rank %d) to ID %s", mode, position,
                            stateId))
                    end
                end
            end
        end
    else
        print("[Fishing] No winners found for " .. mode)
    end
end

lib.cron.new('0 12 * * 1', function()
    ProcessAutomatedRewards("weekly")
end)

lib.cron.new('0 12 1 * *', function()
    ProcessAutomatedRewards("monthly")
end)

RegisterCommand("runfishing", function(source, args)
    if source == 0 then
        local mode = args[1]
        if mode == "weekly" or mode == "monthly" then
            ProcessAutomatedRewards(mode)
        else
            print("Usage: runfishing [weekly/monthly]")
        end
    end
end, true)

bridge.fw.registerCommand(
    "fishing_tournaments",
    "Fishing Tournaments Admin Menu",
    nil,
    "group.admin",
    function(source)
        TriggerClientEvent("prp-fishing:client:openTournamentsMenu", source)
    end
)
