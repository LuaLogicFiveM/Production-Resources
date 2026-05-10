local crews = {}
local playerCrews = {}
local ESX = nil
local QBCore = nil

-- Initialize Framework
CreateThread(function()
    if Config.Framework == 'esx' then
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == 'qb' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

-- Get character name based on framework
local function GetCharacterName(source)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getName()
        end
    elseif Config.Framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    end
    return GetPlayerName(source)
end

-- Check if player has GPS
local function HasGPS(source)
    local hasItem = exports.ox_inventory:Search(source, 'count', Config.GPSItem)
    return hasItem > 0
end

-- Generate unique crew ID
local function GenerateCrewId()
    return 'crew_' .. os.time() .. '_' .. math.random(1000, 9999)
end

-- Notify player
local function Notify(source, description, type)
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'GPS Crew',
        description = description,
        type = type or 'info'
    })
end

-- Get crew members data
local function GetCrewMembersData(crewId)
    local crew = crews[crewId]
    if not crew then return {} end
    
    local membersData = {}
    for _, serverId in ipairs(crew.members) do
        membersData[serverId] = {
            name = GetCharacterName(serverId),
            isLeader = serverId == crew.leader,
            coords = crew.positions[serverId]
        }
    end
    
    return membersData
end

-- Broadcast to crew
local function BroadcastToCrew(crewId, event, ...)
    local crew = crews[crewId]
    if not crew then return end
    
    for _, serverId in ipairs(crew.members) do
        TriggerClientEvent(event, serverId, ...)
    end
end

-- Create crew
RegisterNetEvent('ek_gpscrew:server:createCrew', function()
    local source = source
    
    if not HasGPS(source) then
        Notify(source, 'You don\'t have a GPS!', 'error')
        return
    end
    
    if playerCrews[source] then
        Notify(source, 'You are already in a crew', 'error')
        return
    end
    
    local crewId = GenerateCrewId()
    
    crews[crewId] = {
        leader = source,
        members = {source},
        positions = {},
        invites = {}
    }
    
    playerCrews[source] = crewId
    
    TriggerClientEvent('ek_gpscrew:client:crewCreated', source, crewId)
    
    local membersData = GetCrewMembersData(crewId)
    TriggerClientEvent('ek_gpscrew:client:joinedCrew', source, crewId, membersData, true)
end)

-- Invite player
RegisterNetEvent('ek_gpscrew:server:invitePlayer', function(targetId)
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then
        Notify(source, 'You are not in any crew', 'error')
        return
    end
    
    local crew = crews[crewId]
    
    if crew.leader ~= source then
        Notify(source, 'You are not the crew leader', 'error')
        return
    end
    
    if #crew.members >= Config.MaxCrewSize then
        Notify(source, 'Crew is full', 'error')
        return
    end
    
    if targetId == source then
        Notify(source, 'You cannot invite yourself', 'error')
        return
    end
    
    if playerCrews[targetId] then
        Notify(source, 'This player already has a crew', 'error')
        return
    end
    
    -- Check if player exists
    if not GetPlayerName(targetId) then
        Notify(source, 'Player not found', 'error')
        return
    end
    
    local targetName = GetCharacterName(targetId)
    local inviterName = GetCharacterName(source)
    
    crew.invites[targetId] = {
        inviter = source,
        time = os.time()
    }
    
    Notify(source, 'Invite sent to ' .. targetName, 'success')
    
    TriggerClientEvent('ek_gpscrew:client:receiveInvite', targetId, inviterName, source, crewId)
    
    -- Auto-expire invite
    SetTimeout(Config.AutoAcceptTimeout, function()
        if crew.invites and crew.invites[targetId] then
            crew.invites[targetId] = nil
            Notify(targetId, 'Invite expired', 'info')
        end
    end)
end)

-- Accept invite
RegisterNetEvent('ek_gpscrew:server:acceptInvite', function(crewId)
    local source = source
    
    if not HasGPS(source) then
        Notify(source, 'You don\'t have a GPS!', 'error')
        return
    end
    
    if playerCrews[source] then
        Notify(source, 'You are already in a crew', 'error')
        return
    end
    
    local crew = crews[crewId]
    if not crew then return end
    
    if not crew.invites[source] then
        Notify(source, 'You have no pending invite', 'error')
        return
    end
    
    if #crew.members >= Config.MaxCrewSize then
        Notify(source, 'Crew is full', 'error')
        return
    end
    
    crew.invites[source] = nil
    table.insert(crew.members, source)
    playerCrews[source] = crewId
    
    local playerName = GetCharacterName(source)
    local membersData = GetCrewMembersData(crewId)
    
    TriggerClientEvent('ek_gpscrew:client:joinedCrew', source, crewId, membersData, false)
    
    BroadcastToCrew(crewId, 'ek_gpscrew:client:memberJoined', source, {
        name = playerName,
        isLeader = false,
        coords = nil
    })
    
    Notify(crew.leader, playerName .. ' accepted the invite', 'success')
end)

-- Decline invite
RegisterNetEvent('ek_gpscrew:server:declineInvite', function(crewId)
    local source = source
    local crew = crews[crewId]
    
    if not crew then return end
    
    if crew.invites[source] then
        local inviter = crew.invites[source].inviter
        crew.invites[source] = nil
        
        local playerName = GetCharacterName(source)
        Notify(inviter, playerName .. ' declined the invite', 'info')
    end
end)

-- Leave crew (automatic when GPS lost)
RegisterNetEvent('ek_gpscrew:server:leaveCrew', function()
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then
        return
    end
    
    local crew = crews[crewId]
    if not crew then return end
    
    local playerName = GetCharacterName(source)
    
    -- If leader leaves (without GPS), disband the crew
    if crew.leader == source then
        BroadcastToCrew(crewId, 'ek_gpscrew:client:crewDisbanded')
        
        for _, memberId in ipairs(crew.members) do
            playerCrews[memberId] = nil
        end
        
        crews[crewId] = nil
        return
    end
    
    for i, memberId in ipairs(crew.members) do
        if memberId == source then
            table.remove(crew.members, i)
            break
        end
    end
    
    crew.positions[source] = nil
    playerCrews[source] = nil
    
    TriggerClientEvent('ek_gpscrew:client:leftCrew', source)
    BroadcastToCrew(crewId, 'ek_gpscrew:client:memberLeft', source, playerName)
end)

-- Manual leave crew (from menu)
RegisterNetEvent('ek_gpscrew:server:manualLeaveCrew', function()
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then
        Notify(source, 'You are not in any crew', 'error')
        return
    end
    
    local crew = crews[crewId]
    if not crew then return end
    
    if crew.leader == source then
        Notify(source, 'Leader cannot leave crew. Disband it instead', 'error')
        return
    end
    
    local playerName = GetCharacterName(source)
    
    for i, memberId in ipairs(crew.members) do
        if memberId == source then
            table.remove(crew.members, i)
            break
        end
    end
    
    crew.positions[source] = nil
    playerCrews[source] = nil
    
    TriggerClientEvent('ek_gpscrew:client:leftCrew', source)
    BroadcastToCrew(crewId, 'ek_gpscrew:client:memberLeft', source, playerName)
end)

-- Kick member
RegisterNetEvent('ek_gpscrew:server:kickMember', function(targetId)
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then
        Notify(source, 'You are not in any crew', 'error')
        return
    end
    
    local crew = crews[crewId]
    
    if crew.leader ~= source then
        Notify(source, 'You are not the crew leader', 'error')
        return
    end
    
    if targetId == source then return end
    
    local targetName = GetCharacterName(targetId)
    
    for i, memberId in ipairs(crew.members) do
        if memberId == targetId then
            table.remove(crew.members, i)
            break
        end
    end
    
    crew.positions[targetId] = nil
    playerCrews[targetId] = nil
    
    TriggerClientEvent('ek_gpscrew:client:kicked', targetId)
    BroadcastToCrew(crewId, 'ek_gpscrew:client:memberLeft', targetId, targetName)
    
    Notify(source, 'You kicked ' .. targetName .. ' from the crew', 'success')
end)

-- Disband crew
RegisterNetEvent('ek_gpscrew:server:disbandCrew', function()
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then
        Notify(source, 'You are not in any crew', 'error')
        return
    end
    
    local crew = crews[crewId]
    
    if crew.leader ~= source then
        Notify(source, 'You are not the crew leader', 'error')
        return
    end
    
    BroadcastToCrew(crewId, 'ek_gpscrew:client:crewDisbanded')
    
    for _, memberId in ipairs(crew.members) do
        playerCrews[memberId] = nil
    end
    
    crews[crewId] = nil
end)

-- Update position
RegisterNetEvent('ek_gpscrew:server:updatePosition', function(coords)
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then return end
    
    local crew = crews[crewId]
    if not crew then return end
    
    crew.positions[source] = coords
    
    local membersData = GetCrewMembersData(crewId)
    BroadcastToCrew(crewId, 'ek_gpscrew:client:updateMembers', membersData)
end)

-- Player dropped
AddEventHandler('playerDropped', function()
    local source = source
    local crewId = playerCrews[source]
    
    if not crewId then return end
    
    local crew = crews[crewId]
    if not crew then return end
    
    local playerName = GetCharacterName(source)
    
    if crew.leader == source then
        BroadcastToCrew(crewId, 'ek_gpscrew:client:crewDisbanded')
        
        for _, memberId in ipairs(crew.members) do
            playerCrews[memberId] = nil
        end
        
        crews[crewId] = nil
    else
        for i, memberId in ipairs(crew.members) do
            if memberId == source then
                table.remove(crew.members, i)
                break
            end
        end
        
        crew.positions[source] = nil
        playerCrews[source] = nil
        
        BroadcastToCrew(crewId, 'ek_gpscrew:client:memberLeft', source, playerName)
    end
end)
