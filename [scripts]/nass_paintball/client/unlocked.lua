function spectatingStatus(isSpectating)
    -- This function will be called everytime someone starts or stops spectating
    -- isSpectating will be true when they start spectating and false when they stop spectating.
    
end

function gameStatus(isInGame)
    -- This function will be called everytime someone starts or stops a game
    -- isInGame will be true when they start and false when they stop.
    --[[if not isInGame then
        local playerPed = PlayerPedId()
        ClearPedProp(playerPed, 0)
    end]]
end

function uiOpened(isOpened)
    --This function is called when the UI is opened or closed
    --isOpened will be true when the UI is opened and false when it is closed
end

exports('inHTML', function()
    return inHTML
end)

exports('inGame', function()
    return inGame
end)

exports('isSpectating', function()
    return isSpectating
end)

playingEliminationAnimation = false
CreateThread(function()
    AddTextEntry("nass_paintball_gun", "Paintball Gun")
    for k,v in pairs(Config.setupLocations) do
        if v.blip.enabled then
            v.blip.coords = v.coords
            nass.createBlip(v.blip)
        end
        if v.ped.enabled then
            v.ped.coords = v.coords
            nass.createPedAtPoint(v.ped, GetCurrentResourceName())
        end
        if Config.target.enabled then
            Wait(5000)
            local options = {{
                label = Config.target.label,
                icon = Config.target.icon,
                event = "nass_paintball:openPaintball",
            }}
            if Config.loadMaps then
                table.insert(options, {
                    label = "Load Maps",
                    icon = Config.target.icon,
                    event = "nass_paintball:loadMaps",
                })
            end
            nass.target.addBoxZone(v.coords.xyz, v.coords.w, Config.target.size, Config.target.distance, options)
        end
    end
    
    if not Config.target.enabled then
        while true do 
            for k,v in pairs(Config.setupLocations) do
                local ped = PlayerPedId()
                local sleep = 500
                if #(GetEntityCoords(ped) - v.coords.xyz) < 20 then
                    sleep = 0
                    if #(GetEntityCoords(ped) - v.coords.xyz) < 3 and not inHTML then
                        nass.showHelpNotification(Config.locale["press_e"])
                        if IsControlPressed(0, 38) then
                            openPaintball()
                            Wait(3000)
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end
end)
function spawnLobby(game, team)
    if Config.radio.enabled and team ~= nil then
        if GetResourceState('pma-voice') == 'started' then
            exports['pma-voice']:setRadioChannel(game.bucket + (team/10))
        elseif GetResourceState('cs_walkietalkie') == 'started' then
            exports["cs_walkietalkie"]:joinRadio(game.bucket + (team/10))
        elseif GetResourceState('saltychat') == 'started' then
            exports.saltychat:SetRadioChannel(game.bucket + (team/10), true)
        end
    end

    if GetResourceState('qb-inventory') == 'started' then LocalPlayer.state:set('inv_busy', true, true) end
    if GetResourceState('ox_inventory') == 'started' then exports.ox_inventory:weaponWheel(true) end
    if GetResourceState('qs-inventory') == 'started' then exports['qs-inventory']:WeaponWheel(true) end
    
    local mapData = Config.maps[game.settings.map]
    if game.settings.mode == "Gun Game" then
        currentWeapon = Config.gunGameWeapons[countedKills+1]
        nass.loadModel(joaat("nass_paintball_gun"))
    else
        currentWeapon = game.settings.weapon
    end

    if game.settings.mode == "Dog Tags" then
        SendNUIMessage({event = "showMiniScore", status=true, mode="Dog Tags"}) 
    elseif game.settings.mode == "CTF" then
        SendNUIMessage({event = "showMiniScore", status=true, mode="CTF"})
        local flagPole = CreateObject(`nass_flag_pole`, mapData.flags[1].x,mapData.flags[1].y,mapData.flags[1].z, false, false, false)
        local flag = CreateObject(`nass_flag_red`, mapData.flags[1].x,mapData.flags[1].y,mapData.flags[1].z, false, false, false)
        FreezeEntityPosition(flagPole, true)
        SetEntityHeading(flag, mapData.flags[1].w)
        AttachEntityToEntity(flag, flagPole, GetPedBoneIndex(flag, 24816), 0.0, 0.0, 2.2, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        flagData[1] = {obj=flagPole, flag=flag, taken=false, ogCoords = mapData.flags[1]}

        
        flagPole = CreateObject(`nass_flag_pole`, mapData.flags[2].x,mapData.flags[2].y,mapData.flags[2].z, false, false, false)
        flag = CreateObject(`nass_flag_blue`, mapData.flags[2].x,mapData.flags[2].y,mapData.flags[2].z, false, false, false)
        FreezeEntityPosition(flagPole, true)
        SetEntityHeading(flag, mapData.flags[2].w)
        AttachEntityToEntity(flag, flagPole, GetPedBoneIndex(flag, 24816), 0.0, 0.0, 2.2, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        flagData[2] = {obj=flagPole, flag=flag, taken=false, ogCoords = mapData.flags[2]}
    elseif game.settings.mode == "Team Deathmatch" then
        SendNUIMessage({event = "showMiniScore", status=true, mode="Team Deathmatch"})
    end
    
    local ped = PlayerPedId()
    SetWeaponsNoAutoswap(true)
    if currentWeapon == "nass_paintball_gun" then
        nass.loadModel(joaat(currentWeapon))
    end
    
    GiveWeaponToPed(ped, joaat(currentWeapon), Config.ammoAmount, false, true)
    SetCurrentPedWeapon(ped, joaat(currentWeapon), true)
    if Config.infniteAmmo then
        SetPedInfiniteAmmo(ped, true, joaat(currentWeapon))
    end
    FreezeEntityPosition(PlayerPedId(), false)
    inGame = true
    gameStatus(inGame)
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Wait(10)
    end
    
    SendNUIMessage({event = "startTimer", time = game.settings.timeLimit, show=true}) 
    SetEntityOnlyDamagedByPlayer(ped, true)
    requestAudio()
    SetWeaponDamageModifier(joaat(currentWeapon), (0.00000000000000000000000001)) 
    SetEntityHealth(ped, 200)
    health = Config.defaultHealth
    SendNUIMessage({event = "updateHealth", health = health}) 
    local playerWeapon = joaat(currentWeapon)
    Wait(500)
    while inGame do
        Wait(0)
        --HudWeaponWheelIgnoreSelection()
		DisableControlAction(0, 37, true)
        SetPedSuffersCriticalHits(ped, false)
        if not currentGame?.game?.settings then
            break
        end
        if Config.infiniteStamina then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        local hasWeapon, weaponHash = GetCurrentPedWeapon(ped)
        if IsPedSwappingWeapon(ped) or weaponHash ~= joaat(currentWeapon) then
            GiveWeaponToPed(ped, joaat(currentWeapon), Config.ammoAmount, false, true)
        end 
        N_0x4757f00bc6323cfe(joaat(currentWeapon), (0.00000000000000000000000001)) 

        -- Disable Pistol whip
        DisableControlAction(0, 140, true)
        --DisableControlAction(0, 141, true)
        --DisableControlAction(0, 142, true)
        DisableControlAction(0, 263, true)
        DisableControlAction(0, 264, true)
        if game.settings.mode == "Dog Tags" then
            for k,v in pairs(createdDogTags) do
                if tostring(GetPlayerServerId(PlayerId())) ~= k and #(GetEntityCoords(ped) - v.pos) < 1.3 then
                    TriggerServerEvent("nass_paintball:collectDogTag", game, v, k)
                    Wait(500)
                end
            end
        elseif game.settings.mode == "CTF" then
            for k,v in pairs(mapData.flags) do
                if #(GetEntityCoords(ped) - GetEntityCoords(flagData[k].obj)) < 1.3 then
                    if k == currentGame.team then
                        if flagData[k].taken then
                            if GetEntityType(GetEntityAttachedTo(flagData[k].obj)) ~= 1 then
                                TriggerServerEvent("nass_paintball:returnFlag", game, k == 2 and 1 or 2, true)
                            end
                        elseif carryingFlag then
                            if flagData[1].taken ~= true or flagData[2].taken ~= true then
                                carryingFlag = false
                                TriggerServerEvent("nass_paintball:scoreFlag", game, k)
                                Wait(2000)
                            end
                        end
                    elseif not isDeadWaiting and (not flagData[k].taken or GetEntityType(GetEntityAttachedTo(flagData[k].obj)) ~= 1)  then
                        carryingFlag = true
                        TriggerServerEvent("nass_paintball:pickupFlag", game, k, PedToNet(ped))
                        Wait(500)
                    end
                end
            end
        end
    end

    

    if Config.radio.enabled and team ~= nil then
        if GetResourceState('pma-voice') == 'started' then
            exports['pma-voice']:setRadioChannel(0)
        elseif GetResourceState('cs_walkietalkie') == 'started' then
            exports["cs_walkietalkie"]:joinRadio(0)
        elseif GetResourceState('saltychat') == 'started' then
            exports.saltychat:SetRadioChannel("", true)
        end
    end

    if game.settings.mode == "Gun Game" then
        for k, v in pairs(Config.gunGameWeapons) do
            SetWeaponDamageModifier(joaat(v), (1.0)) 
        end
    else
        SetWeaponDamageModifier(joaat(currentWeapon), (1.0)) 
    end
    if game.settings.mode == "Dog Tags" then
        for k,v in pairs(createdDogTags) do
            DeleteEntity(v.obj)
        end
        createdDogTags = {}
        SendNUIMessage({event = "showMiniScore", status=false, mode="Dog Tags"}) 
    elseif game.settings.mode == "CTF" then
        SendNUIMessage({event = "showMiniScore", status=false, mode="CTF"})
        carryingFlag = false
        DeleteEntity(flagData[1].obj)
        DeleteEntity(flagData[1].flag)
        DeleteEntity(flagData[2].obj)
        DeleteEntity(flagData[2].flag)
        flagData = {} 
    elseif game.settings.mode == "Team Deathmatch" then
        SendNUIMessage({event = "showMiniScore", status=false, mode="Team Deathmatch"})
    end
    SetEntityOnlyDamagedByPlayer(ped, false)
    SetPedSuffersCriticalHits(ped, true)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    RemoveWeaponFromPed(ped, joaat(currentWeapon))

    if GetResourceState('qb-inventory') == 'started' then LocalPlayer.state:set('inv_busy', false, true) end
    if GetResourceState('ox_inventory') == 'started' then exports.ox_inventory:weaponWheel(false) end
    if GetResourceState('qs-inventory') == 'started' then exports['qs-inventory']:WeaponWheel(false) end
    FreezeEntityPosition(PlayerPedId(), false)
end

function requestAudio()
    -- Load the audio bank once at the start
    RequestScriptAudioBank('weapon/dlccustomweaponsounds/custom_weapon_sounds', false)
    
    CreateThread(function()
        while inGame do
            -- Keep the audio bank loaded while in game
            Wait(10000)
        end
        
        -- Release the audio bank when the game ends
        ReleaseNamedScriptAudioBank('weapon/dlccustomweaponsounds/custom_weapon_sounds')
    end)
end

RegisterNetEvent('nass_paintball:gotKill')
AddEventHandler('nass_paintball:gotKill', function()
    if GetInvokingResource() ~= nil then return end
    if not inGame then return end

    if Config.resetHealth then
        health = Config.defaultHealth
        SendNUIMessage({event = "updateHealth", health = health})
    end
    SendNUIMessage({event = "playSound", name = "killSound", status = true}) 
    --Wait(1500)
    --SendNUIMessage({event = "playSound", name = "killSound", status = false}) 
end)


RegisterNetEvent('nass_paintball:announce')
AddEventHandler('nass_paintball:announce', function(msg)
    local showAnnounce = true
    CreateThread(function()
        Wait(10000)
        showAnnounce = false
    end)
    while showAnnounce do
        Wait(0)
        scaleform = anouncmentScaleform("mp_big_message_freemode", msg)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
    end
end)

function anouncmentScaleform(scaleform, msg)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(Config.locale["gameover"])
    PushScaleformMovieFunctionParameterString(msg)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function playOpeningAnimation(map, game, team)
    local createdPeds = {}
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(50) end

    local mapData, inHTML, isCreated = Config.maps[map], false, false
    currentGame = {game = game, team = team or currentGame.team}
    SendNUIMessage({event = "gameStarted"})
    if Config.clothing then
        setClothing(ped, team)
    end
    
    FreezeEntityPosition(ped, true)
    respawnPlayer(ped, function(spawnCoords)
        if mapData.arena.enabled then
            local interiorID, sceneID, mapScene = setArena(mapData.arena.category, mapData.arena.map)
            
            -- Add timeout for interior loading
            local timeout = 0
            local maxTimeout = 50 -- 5 seconds max
            while (not IsInteriorEntitySetActive(interiorID, sceneID) or not IsInteriorEntitySetActive(interiorID, mapScene) or not IsIplActive("xs_arena_interior")) and timeout < maxTimeout do
                Wait(100)
                timeout = timeout + 1
            end
            
            -- Request collision at the arena coordinates
            RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
            timeout = 0
            while not HasCollisionLoadedAroundEntity(ped) and timeout < maxTimeout do
                Wait(100)
                timeout = timeout + 1
            end
        end
    
        if Config.mapSpawning.enabled then
            Wait(Config.mapSpawning.waitTime)
        end
    
        if not mapData.animation.enabled then
            SendNUIMessage({event = "playSound", name = "backgroundAmbience", status = true})
            FreezeEntityPosition(ped, false)
            spawnLobby(game, team)
            return
        end
    
        local playersTable, cam = rearrangeTable(game.players), CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        local pedModels, usedSkins = {"mp_m_freemode_01", "mp_f_freemode_01"}, {}
        local mainPedModel = pedModels[nass.getGender(ped) == "female" and 2 or 1]
        local x, y, z, w = mapData.animation.opening.pedPos.x,mapData.animation.opening.pedPos.y,mapData.animation.opening.pedPos.z,mapData.animation.opening.pedPos.w
        local x2, y2, z2, w2 = nass.getDirectionCoords(mapData.animation.opening.firstCamPos.x, mapData.animation.opening.firstCamPos.y, mapData.animation.opening.firstCamPos.z, mapData.animation.opening.firstCamPos.w, 5, "back")
    
        -- Create up to three peds for the animation
        for i = 1, math.min(3, #playersTable) do
            local randPlayer = playersTable[math.random(1, #playersTable)]
            while usedSkins[NetToPed(randPlayer.ped)] do
                Wait(10)
                randPlayer = playersTable[math.random(1, #playersTable)]
            end
            local pedModel = pedModels[nass.getGender(NetToPed(randPlayer.ped)) == "female" and 2 or 1]
            if i ~= 1 then
                x, y, z, w = nass.getDirectionCoords(x, y, z, w, 1, (i == 2 and "right" or "left"))
            end
    
            local newPed = nass.createPed({
                model = pedModel,
                coords = vector4(x, y, z, w),
                distance = 400.0,
            })
    
            if i == 1 then
                x, y, z, w = nass.getDirectionCoords(x, y, z, w, 1.8, "back")
            end
            nass.setClothing(newPed, nass.getClothing(NetToPed(randPlayer.ped)))
            usedSkins[NetToPed(randPlayer.ped)] = true
    
            local randAnim = Config.animationDicts[math.random(1, #Config.animationDicts)]
            nass.requestAnimDict(randAnim.dict)
            TaskPlayAnim(newPed, randAnim.dict, randAnim.anim, 8.0, 8.0, -1, 50, 0, false, false, false)
            TaskGoStraightToCoord(newPed, x2, y2, z2, 1.2, -1, w2, 1.0)
            table.insert(createdPeds, {ped=newPed, dict=randAnim.dict, anim=randAnim.anim})
        end
        SendNUIMessage({event = "playSound", name = "openingAnimation", status = true}) 
        -- Camera setup and fade in
        SetCamCoord(cam, table.unpack(mapData.animation.opening.firstCamPos.xyz + vector3(0.0, 0.0, 1.0)))
        SetCamRot(cam, 0, 0, mapData.animation.opening.firstCamPos.w, 0)
        SetCamFov(cam, 60)
        RenderScriptCams(true, false, 0, 1, 0)
        SetCamActive(cam, true)
        
    
        DoScreenFadeIn(500)
        Wait(4500) -- Wait for animation to play
    
        -- Transition to second camera position and animation
        DoScreenFadeOut(200)
        while not IsScreenFadedOut() do Wait(50) end
    
        -- Reposition peds and play second animation
        x, y, z, w = nass.getDirectionCoords(mapData.animation.opening.secondCamPos.x,mapData.animation.opening.secondCamPos.y,mapData.animation.opening.secondCamPos.z,mapData.animation.opening.secondCamPos.w, 0.5, "back")
        x2, y2, z2, w2 = nass.getDirectionCoords(mapData.animation.opening.secondCamPos.x,mapData.animation.opening.secondCamPos.y,mapData.animation.opening.secondCamPos.z,mapData.animation.opening.secondCamPos.w, 20, "front")
    
        for k, data in ipairs(createdPeds) do
            local ped = data.ped
            if k == 1 then
                SetEntityCoords(ped, x, y, z, w)
                TaskGoStraightToCoord(ped, x2, y2, z2, 1.3, -1, w2, 1.0)
                x, y, z, w = nass.getDirectionCoords(x, y, z, w, 1.8, "back")
            elseif k == 2 then
                x2, y2, z2, w2 = nass.getDirectionCoords(x2, y2, z2, w2, 1, "right")
                x, y, z, w = nass.getDirectionCoords(x, y, z, w, 1, "right")
                SetEntityCoords(ped, x, y, z, w)
                TaskGoStraightToCoord(ped, x2, y2, z2, 1.3, -1, w2, 1.0)
            elseif k == 3 then
                x2, y2, z2, w2 = nass.getDirectionCoords(x2, y2, z2, w2, 1, "left")
                x, y, z, w = nass.getDirectionCoords(x, y, z, w, 1, "left")
                SetEntityCoords(ped, x, y, z, w)
            end
    
            TaskPlayAnim(ped, data.dict, data.anim, 8.0, 8.0, -1, 50, 0, false, false, false)
        end
    
        SetCamCoord(cam, table.unpack(mapData.animation.opening.secondCamPos.xyz + vector3(0.0, 0.0, 1.0)))
        SetCamRot(cam, 0, 0, mapData.animation.opening.secondCamPos.w, 0)
        SetCamFov(cam, 60)
        RenderScriptCams(true, false, 0, 1, 0)
        SetCamActive(cam, true)
    
        DoScreenFadeIn(200)
        Wait(5000) -- Wait for second animation to play
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Wait(50) end
    
        -- Cleanup
        for _, data in ipairs(createdPeds) do DeletePed(data.ped) end
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
    
        SendNUIMessage({event = "playSound", name = "backgroundAmbience", status = true})
        spawnLobby(game, team)
    end)
end

function playWinningAnimation(map, team)
    local createdPeds = {}
    local mapData = Config.maps[map]
    DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Wait(50)
	end
    
    if not mapData.animation.enabled then return true end
    local ped
    local model = "mp_m_freemode_01"
    local x, y, z, w
    local currentOffset, OffsetAddition, direction = 0, 8/#team, "first"
    for k, v in pairs(team) do
        local playerIdx = GetPlayerFromServerId(tonumber(v.src))
        local targetPed = GetPlayerPed(playerIdx)
        x, y, z, w = nass.getDirectionCoords(mapData.animation.winning.pedPos.x, mapData.animation.winning.pedPos.y, mapData.animation.winning.pedPos.z, mapData.animation.winning.pedPos.w, currentOffset, direction)
        local ped = nass.createPed{
            model = (nass.getGender(targetPed) == "female" and "mp_f_freemode_01" or model),
            coords = vector4(x, y, z, w),
            distance = 400.0,
        }
        table.insert(createdPeds, ped)
        nass.setClothing(ped, nass.getClothing(targetPed))
        
        if direction == "first" then
            direction = "left"
            currentOffset = currentOffset+OffsetAddition
        elseif direction == "left" then
            direction = "right"
        elseif direction == "right" then
            direction = "left"
            currentOffset = currentOffset+OffsetAddition
        end
        
    end
    local function lerp(a, b, t)
        return a * (1 - t) + b * t
    end
    
    local function interpolateCamera(startPos, endPos, t)
        local newPos = {}
        newPos.x = lerp(startPos.x, endPos.x, t)
        newPos.y = lerp(startPos.y, endPos.y, t)
        newPos.z = lerp(startPos.z, endPos.z, t)
        newPos.w = lerp(startPos.w, endPos.w, t)
        return vector3(newPos.x, newPos.y, newPos.z)
    end
    SendNUIMessage({event = "playSound", name = "openingAnimation", status = true}) 
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, table.unpack(mapData.animation.winning.firstCamPos.xyz + vector3(0.0, 0.0, 1.0)))
    SetCamRot(cam, 0, 0, GetHeadingFromVector_2d(mapData.animation.winning.firstCamPos.x-mapData.animation.winning.pedPos.x, mapData.animation.winning.firstCamPos.y-mapData.animation.winning.pedPos.y)-180, 0)
    SetCamFov(cam, 60)
    RenderScriptCams(true, false, 0, 1, 0)
    SetCamActive(cam, true)
    Wait(1000)
    for k, v in pairs(createdPeds) do
        local randAnim = Config.animationDicts[math.random(1, #Config.animationDicts)]
        nass.requestAnimDict(randAnim.dict)
        TaskPlayAnim(v, randAnim.dict, randAnim.anim, 8.0, 8.0, -1, 49, 0, false, false, false)
    end

    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Wait(10)
    end
    local totalTime = 7000 
    local currentTime = 0
    while currentTime <= totalTime do
        local deltaTime = GetFrameTime() * 1000 -- Convert to milliseconds for consistency
        currentTime = currentTime + deltaTime -- Accumulate elapsed time
        local t = math.min(currentTime / totalTime, 1) -- Correct calculation of t
        local newCamPos = interpolateCamera(mapData.animation.winning.firstCamPos, mapData.animation.winning.secondCamPos, t)
        SetCamCoord(cam, newCamPos.x, newCamPos.y, newCamPos.z + 1.0) -- Adjusted to use x, y, z directly
        SetCamRot(cam, 0, 0, GetHeadingFromVector_2d(newCamPos.x - mapData.animation.winning.pedPos.x, newCamPos.y - mapData.animation.winning.pedPos.y) - 180, 2) -- Adjust rotation as necessary
        
        Wait(0) -- Wait for the next frame
    end
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(50)
    end
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    for k, v in pairs(createdPeds) do
        DeletePed(v)
    end
    
    return true
end

function eliminationAnimation(ped)
    FreezeEntityPosition(ped, true)
    playingEliminationAnimation = true
    nass.requestAnimDict(Config.deathAnimation.dict)
	ClearPedTasks(ped)
    TaskPlayAnim(ped, Config.deathAnimation.dict, Config.deathAnimation.anim, 8.0, 8.0, -1, 3, 0, false, false, false)
    CreateThread(function()
        while playingEliminationAnimation do
            local sleep = 1250
            if not IsEntityPlayingAnim(ped, Config.deathAnimation.dict, Config.deathAnimation.anim, 3) then
                sleep = 0
                ClearPedTasks(ped)
                TaskPlayAnim(ped, Config.deathAnimation.dict, Config.deathAnimation.anim, 8.0, 8.0, -1, 3, 0, false, false, false)
            end
            Wait(sleep)
        end
        FreezeEntityPosition(PlayerPedId(), false)
    end)
    RemoveAnimDict(Config.deathAnimation.dict)
end

if Config.leaderboard.enabled then
    RegisterCommand("+"..Config.leaderboard.name, function()
        if currentGame?.game == nil then return end
        local data
        if currentGame.game.settings.mode == "FFA" or currentGame.game.settings.mode == "Gun Game" then
            data = {
                mode = currentGame.game.settings.mode,
                weapon = currentGame.game.settings.weapon,
                players = currentGame.game.scoreBoard,
                gameData = currentGame.game,
            }
        else
            data = {
                mode = currentGame.game.settings.mode,
                weapon = currentGame.game.settings.weapon,
                players = currentGame.game.teams,
                gameData = currentGame.game,
            }
        end
        SendNUIMessage({event = "leaderboard", status=true, data = data}) 
    end)

    RegisterCommand("-"..Config.leaderboard.name, function()
        data = {
            mode = currentGame?.game?.settings?.mode or "Teams",
            weapon = nil,
            players = nil,
            gameData = nil,
        }
        SendNUIMessage({event = "leaderboard", status=false, data = data}) 
    end)

    RegisterKeyMapping("+"..Config.leaderboard.name, Config.locale["show_leaderboard"], 'keyboard', Config.leaderboard.keybind)
end

RegisterNetEvent('nass_paintball:loadMaps')
AddEventHandler('nass_paintball:loadMaps', function()
    local ped = PlayerPedId()
    local ogCoords = GetEntityCoords(ped)
    for k,v in pairs(Config.maps) do
        if not v.arena.enabled then
            SetEntityCoords(ped, v.center.x, v.center.y, v.center.z)
            FreezeEntityPosition(ped, true)
            Wait(15000)
        end
    end
    SetEntityCoords(ped, ogCoords.x, ogCoords.y, ogCoords.z+1)
    FreezeEntityPosition(ped, false)
end)
