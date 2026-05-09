PLAYERS_INSIDE_GAMES = {}

local games = {}

local gameCounter = 0

function getGameByGroupId(groupId)
    for k, v in pairs(games) do
        if v.groupId == groupId then
            return v
        end
    end
end

function getGame(playerId)
    local gameId = PLAYERS_INSIDE_GAMES[playerId]

    if not gameId then
        return
    end

    local game = games[gameId]

    if not game then
        return
    end

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)
    if not groupId then
        return
    end

    if game.groupId ~= groupId then
        return
    end

    return game
end

function startNewHorde(partyId, taskId, hardMode)
    local config = hardMode and svConfig.hardMission or svConfig.mission
    gameCounter += 1

    local group = exports['prp-bridge']:GetGroupByPartyUuid(partyId)
    if not group then
        return
    end

    local groupId = group.getUuid()
    for _, member in pairs(group.getMembers()) do
        exports['prp-bridge']:startCooldownByIdentifier(
            member.identifier, 
            config.name, 
            config.cooldown
        )
    end

    local interiorPool = {}

    for k, v in pairs(svConfig.interiors) do
        if (not v.hardMode and not hardMode) or (v.hardMode and hardMode) then
            table.insert(interiorPool, v)
        end
    end

    local uniqueId = lib.string.random('.........')

    local gameData = {
        groupId = groupId,
        taskId = taskId,
        bucketId = gameCounter,
        uniqueId = uniqueId,
        hardMode = hardMode,
        interiorKey = interiorPool[math.random(#interiorPool)].key,
    }

    local game

    if hardMode then
        game = HardGame:new(gameData)
    else
        game = Game:new(gameData)
    end

    game:start()

    game:sendStartingSMS()

    games[uniqueId] = game

    return game
end

function startTestingHordeGame(playerId)
    Wait(1)
    local stateId = bridge.fw.getIdentifier(playerId)
    if not stateId then
        bridge.fw.notify(playerId, 'error', 'No state ID.')
        return
    end

    local group = exports['prp-bridge']:GetGroupFromMemberByIdentifier(stateId)
    if not group then
        bridge.fw.notify(playerId, 'error', 'No group.')
        return
    end

    if not group.getPartyUuid() then
        group.createUniqueueParty('crime')
    end

    local partyId = group.getPartyUuid()
    if not partyId then
        bridge.fw.notify(playerId, 'error', 'Failed to create party.')
        return
    end

    local game = startNewHorde(partyId, 'taskId', false)
    if not game then
        bridge.fw.notify(playerId, 'error', 'Failed to start horde game.')
        return
    end

    game:enter(playerId)
    game:addCurrency(1000000)
    game:endLootingPhase(playerId)
    game:openCurrencyShop(playerId)

    Wait(5 * 1000)
    game:finish()
end

AddEventHandler('prp-groups:internal:joinedGroup', function(playerId, groupId, activityId)
    playerId = tonumber(playerId)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    TriggerClientEvent('prp-horde:client:addEnterExitTargets', playerId, game.uniqueId, game.enterTargetCoords,
        game.exitTargetCoords)
end)

AddEventHandler('prp-groups:internal:leftGroup', function(playerId, groupId)
    playerId = tonumber(playerId)
    if not playerId then return end

    local game = getGameByGroupId(groupId)

    if not game then
        return
    end

    local stateId = bridge.fw.getIdentifier(playerId)

    if game.groupId == stateId then
        game:groupDisbanded()
        return
    end

    if game.playersInside[playerId] then
        game:exit(playerId)
    end

    if game.involvedStateIds and game.involvedStateIds[stateId] then
        game.involvedStateIds[stateId] = nil
    end

    TriggerClientEvent('prp-horde:client:removeEntranceTarget', playerId, game.uniqueId)
end)

RegisterNetEvent('prp-horde:server:endGame', function()
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:endByPlayer(playerId)
end)

RegisterNetEvent('prp-horde:server:endLooting', function()
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:endLootingPhase(playerId)
end)

RegisterNetEvent('prp-horde:server:finalShopClosed', function()
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    if not game.finished then
        return
    end

    game:exit(playerId)
end)

RegisterNetEvent('prp-horde:server:revivePlayer', function(targetPlayerId)
    local playerId = tonumber(source)
    if not playerId then return end

    targetPlayerId = tonumber(targetPlayerId)
    if not targetPlayerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:revivePlayer(playerId, targetPlayerId)
end)

local function gameTick()
    for id, game in pairs(games) do
        if game.destroy then
            local queue = game.hardMode and queues.hard or queues.normal 

            queue.setTaskIsExecuting(game.taskId, false)
            games[id] = nil
        else
            game:tick()
        end
    end
end

CreateThread(function()
    while true do
        Wait(1000 * 1)

        local success, exception = pcall(function()
            gameTick()
        end)

        if not success then
            lib.print.debug('GAME TICK LOOP FAILED!', exception)
        end
    end
end)

RegisterNetEvent('prp-horde:server:enter', function(gameId)
    local playerId = tonumber(source)
    if not playerId then return end

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)
    if not groupId then
        return
    end

    local game = games[gameId]

    if not game then
        return
    end

    if game.groupId ~= groupId then
        return
    end

    game:enter(playerId)
end)

RegisterNetEvent('prp-horde:server:exit', function(gameId)
    local playerId = tonumber(source)
    if not playerId then return end

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)
    if not groupId then
        return
    end

    local game = games[gameId]

    if not game then
        return
    end

    if game.groupId ~= groupId then
        return
    end

    game:exit(playerId)
end)

RegisterNetEvent('prp-horde:server:searchPed', function(pointId)
    local playerId = tonumber(source)
    if not playerId then return end

    local gameId = PLAYERS_INSIDE_GAMES[playerId]

    local groupId = exports['prp-bridge']:GetGroupIdFromMember(playerId)
    if not groupId then
        return
    end

    local game = games[gameId]

    if not game then
        return
    end

    if game.groupId ~= groupId then
        return
    end

    local finished = lib.callback.await('prp-bridge:progress', playerId, {
        label = locale('PROGRESS_SEARCHING'),
        duration = 3000,
        canCancel = false,
        disarm = false,
        controlDisables = { disableMovement = true },
        animation = { animDict = 'reck@crim@sneakerboxget', animClip = 'sneakerboxget', animFlag = 0 },
    })

    if not finished then
        return
    end

    game:openPedInventory(playerId, pointId)
end)

RegisterNetEvent('prp-horde:server:openChest', function()
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:openMainInventory(playerId)
end)

RegisterNetEvent('prp-horde:server:pickupGroundLoot', function(stashId)
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    if not game.playersInside[playerId] then
        return
    end

    if not game.stashes or not game.stashes[stashId] then
        return
    end

    local stash = game.stashes[stashId]

    if stash.picked then
        return
    end

    if groundLootAttachedObjects[playerId] then
        bridge.fw.notify(playerId, 'error', locale('ALREADY_CARRYING_ITEM'))
        return
    end

    stash.picked = true

    local uuid = lib.string.random('..............................')
    bridge.inv.giveItem(playerId, stash.itemId, 1, { fromInventoryLoadout = true, uuid = uuid })

    game:insideEvent('prp-horde:client:removeGroundLootItem', stashId)

    local itemData = nil
    for _, item in pairs(svConfig.groundLootItems) do
        if item.id == stash.itemId then
            itemData = item
            break
        end
    end

    if itemData then
        groundLootAttachedObjects[playerId] = exports["prp-bridge"]:CreateAttachObject(playerId, stash.itemId)
        TriggerClientEvent("prp-horde:client:carryAnim", playerId, true, itemData.animation.dictionary, itemData.animation.animation)
    end
end)

RegisterNetEvent('prp-bridge:server:died', function()
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    if game.failed then
        return
    end

    game:setParticipantDead(playerId)
end)

local function playerHealed(playerId)
    playerId = tonumber(playerId)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    if game.failed then
        return
    end

    game:setParticipantAlive(playerId)
end

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    if GetInvokingResource() ~= 'monitor' or type(eventData) ~= 'table' or type(eventData.id) ~= 'number' then
        return
    end

    playerHealed(eventData.id)
end)

AddEventHandler('prp-bridge:server:playerUnload', function(playerId)
    if not PLAYERS_INSIDE_GAMES[playerId] then
        return
    end

    local gameId = PLAYERS_INSIDE_GAMES[playerId]

    if not games[gameId] then
        return
    end

    games[gameId].playersInside[playerId] = nil

    Player(playerId).state.isInHorde = nil

    games[gameId]:cleanupLocation(playerId)

    games[gameId]:returnPlayerSavedData(playerId)

    local data = games[gameId].playersSavedData[playerId]

    if data then
        SetTimeout(1000, function()
            bridge.fw.updateDisconnectLocation(data.stateId, games[gameId].outsideCoords)
        end)
    end

    games[gameId]:shouldGameEndEarly()
end)

AddEventHandler('playerDropped', function()
    local playerId = tonumber(source)
    if not playerId then return end

    if not PLAYERS_INSIDE_GAMES[playerId] then
        return
    end

    local gameId = PLAYERS_INSIDE_GAMES[playerId]

    if not games[gameId] then
        return
    end

    games[gameId].playersInside[playerId] = nil

    local data = games[gameId].playersSavedData[playerId]

    if data then
        SetTimeout(1000, function()
            local coords = games[gameId].outsideCoords
            TriggerEvent('Characters:Server:SetLastLocation', data.stateId, vector3(coords.x, coords.y, coords.z))
        end)
    end

    games[gameId]:shouldGameEndEarly()
end)

CreateThread(function()
    if config.adminCommand ~= nil then
        bridge.fw.registerCommand(config.adminCommand, locale('ADMIN_HORDE_EDIT_MODE_HELP_TEXT'), {
            {
                name = 'target',
                type = 'playerId',
                help = locale('ADMIN_HORDER_EDIT_PLAYER_ID_HELP_TEXT'),
            }
        }, "group.admin", function(src, args)
            editModeToggle(args.target)
        end)
    end

    if config.testingCommand ~= nil then
        bridge.fw.registerCommand(config.testingCommand, "Horde testing command", nil, "group.admin", function(src, args)
            startTestingHordeGame(src)
        end)
    end

    TriggerEvent('prp-horde:server:startup')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    for id, game in pairs(games) do
        game:exitAllPlayers()

        game:resetGroupLimits()

        if game.cleanup then
            game:cleanup()
        end
    end
end)
