local function OpenLeaderboardMenu(leaderboardType)
    local data = lib.callback.await("prp-fishing:loadApp", false, leaderboardType)

    if not data then
        return bridge.fw.notify('error', locale("LEADERBOARD_ERROR"))
    end

    local options = {}
    local medals = { "medal", "award", "certificate" }

    for i, player in ipairs(data.top) do
        table.insert(options, {
            title = ("#%d - %s"):format(i, player.name),
            icon = medals[i] or "user",
            description = locale("PLAYER_CAUGHT_FISH", player.name, player.fishCaught),
            metadata = {
                { label = locale("REWARDS_LABEL"), value = table.concat(player.rewards, ", ") }
            }
        })
    end

    if data.myScore and data.myScore.fishCaught then
        table.insert(options, {
            title = locale("YOUR_STANDING"),
            icon = "user",
            metadata = {
                { label = locale("POSITION"), value = "#" .. (data.myScore.position or "?") },
                { label = locale("FISH_CAUGHT"), value = tostring(data.myScore.fishCaught) }
            }
        })
    else
        table.insert(options, {
            title = locale("YOUR_STANDING"),
            icon = "user",
            description = locale("NO_FISH_CAUGHT")
        })
    end

    bridge.fw.contextMenu({
        id = "fishing_leaderboard_player",
        title = locale("LEADERBOARD_TITLE", leaderboardType == "weekly" and locale("WEEKLY") or locale("MONTHLY")),
        options = options,
        menu = "fishing_tournaments_player"
    })

    bridge.fw.showContext("fishing_leaderboard_player")
end

local function OpenTournamentStandings()
    bridge.fw.contextMenu({
        id = "fishing_tournaments_player",
        title = locale("TOURNAMENTS_TITLE"),
        options = {
            {
                title = locale("WEEKLY"),
                icon = "calendar-week",
                onSelect = function()
                    OpenLeaderboardMenu("weekly")
                end
            },
            {
                title = locale("MONTHLY"),
                icon = "calendar",
                onSelect = function()
                    OpenLeaderboardMenu("monthly")
                end
            }
        }
    })

    bridge.fw.showContext("fishing_tournaments_player")
end

local function OpenFishingProfile()
    local stateId = bridge.fw.getIdentifier()
    local profile = lib.callback.await("prp-fishing:getProfile", false, stateId)

    if not profile then
        return bridge.fw.notify('error', locale("PROFILE_ERROR"))
    end

    local heaviestValue = profile.heaviestFishLabel or locale("NOT_CAUGHT")

    if profile.heaviestFish and profile.heaviestFish > 0 then
        heaviestValue = ("%s (%s)"):format(profile.heaviestFishLabel, locale("WEIGHT_KG", string.format("%.2f", profile.heaviestFish)))
    end

    bridge.fw.contextMenu({
        id = "fishing_profile",
        title = profile.characterName,
        options = {
            {
                title = locale("FISH_CAUGHT"),
                icon = "fish",
                metadata = {
                    { label = locale("TOTAL"), value = tostring(profile.fishCaught or 0) },
                    { label = locale("LAST_30_DAYS"), value = tostring(profile.fishCaught30 or 0) },
                }
            },
            {
                title = locale("RECORDS"),
                icon = "award",
                metadata = {
                    { label = locale("HEAVIEST_FISH"), value = heaviestValue },
                    { label = locale("RAREST_FISH"), value = profile.rarestFishLabel or locale("NOT_CAUGHT") },
                }
            },
            {
                title = locale("CHALLENGES_COMPLETED_COUNT"),
                icon = "trophy",
                description = tostring(profile.challengesCompleted or 0)
            }
        }
    })

    bridge.fw.showContext("fishing_profile")
end

-- Standalone NPC setup
RegisterNetEvent("prp-fishing:client:ready", function()
    local npc = FishingProfileNPC

    if not npc then return end

    exports['prp-bridge']:RemovePedInteraction("FISHING_PROFILE_NPC")

    exports['prp-bridge']:AddPedInteraction("FISHING_PROFILE_NPC", {
        model = npc.model,
        coords = npc.coords,
        heading = npc.heading,
        radius = npc.radius or 25.0,
        scenario = npc.scenario,
        options = {
            {
                label = locale("FISHING_PROFILE"),
                icon = "fas fa-id-card",
                onSelect = function()
                    OpenFishingProfile()
                end
            },
            {
                label = locale("TOURNAMENTS_TITLE"),
                icon = "fas fa-ranking-star",
                onSelect = function()
                    OpenTournamentStandings()
                end
            }
        }
    })

    if npc.blip then
        BlipUtil.add("FISHING_PROFILE_NPC", npc.blip.label, npc.coords, npc.blip.sprite, npc.blip.color, npc.blip.scale or 0.65)
    end
end)
