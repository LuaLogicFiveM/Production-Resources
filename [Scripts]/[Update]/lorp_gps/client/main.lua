local crewData = {
    inCrew = false,
    isLeader = false,
    crewId = nil,
    members = {},
    blips = {}
}

local pendingInvite = nil

-- Check if player has GPS item
local function HasGPS()
    local hasItem = exports.ox_inventory:Search('count', Config.GPSItem)
    return hasItem > 0
end

-- Show notification
local function ShowNotification(message, type)
    lib.notify({
        title = 'GPS Crew',
        description = message,
        type = type or 'info',
        position = Config.NotificationPosition,
        duration = Config.NotificationDuration
    })
end

-- Create blip for crew member
local function CreateMemberBlip(serverId, coords, isLeader)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local config = isLeader and Config.Blips.Leader or Config.Blips.Member
    
    SetBlipSprite(blip, config.sprite)
    SetBlipColour(blip, config.color)
    SetBlipScale(blip, config.scale)
    SetBlipAsShortRange(blip, false)
    
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(config.label)
    EndTextCommandSetBlipName(blip)
    
    return blip
end

-- Update crew blips
local function UpdateCrewBlips()
    -- Remove old blips
    for _, blip in pairs(crewData.blips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    crewData.blips = {}
    
    if not crewData.inCrew then return end
    
    -- Create new blips
    for serverId, member in pairs(crewData.members) do
        if member.coords then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - member.coords)
            
            if Config.MaxDistance == 0 or distance <= Config.MaxDistance then
                crewData.blips[serverId] = CreateMemberBlip(serverId, member.coords, member.isLeader)
            end
        end
    end
end

-- Open invite menu
local function OpenInviteMenu()
    local input = lib.inputDialog(_('invite_title'), {
        {
            type = 'number',
            label = _('invite_input_label'),
            description = _('invite_input_desc'),
            required = true,
            min = 1,
            max = 1024
        }
    })
    
    if not input then return end
    
    local targetId = tonumber(input[1])
    if targetId then
        TriggerServerEvent('ek_gpscrew:server:invitePlayer', targetId)
    end
end

-- Open kick menu
local function OpenKickMenu()
    local options = {}
    
    for serverId, member in pairs(crewData.members) do
        if not member.isLeader and serverId ~= GetPlayerServerId(PlayerId()) then
            table.insert(options, {
                title = string.format(_('menu_member'), member.name, serverId),
                icon = 'user-minus',
                onSelect = function()
                    local alert = lib.alertDialog({
                        header = _('menu_kick'),
                        content = string.format(_('confirm_kick'), member.name),
                        centered = true,
                        cancel = true
                    })
                    
                    if alert == 'confirm' then
                        TriggerServerEvent('ek_gpscrew:server:kickMember', serverId)
                    end
                end
            })
        end
    end
    
    if #options == 0 then
        ShowNotification(_('no_members_kick'), 'error')
        return
    end
    
    lib.registerContext({
        id = 'gpscrew_kick',
        title = _('menu_kick_title'),
        options = options
    })
    
    lib.showContext('gpscrew_kick')
end

-- Open crew menu
local function OpenCrewMenu()
    if not HasGPS() then
        ShowNotification(_('no_gps'), 'error')
        return
    end
    
    local options = {}
    
    -- Check for pending invite first
    if pendingInvite then
        table.insert(options, {
            title = _('pending_invite'),
            description = string.format(_('pending_invite_desc'), pendingInvite.inviterName),
            icon = 'envelope',
            disabled = true
        })
        
        table.insert(options, {
            title = _('accept_invite_option'),
            description = 'Join ' .. pendingInvite.inviterName .. '\'s crew',
            icon = 'check',
            iconColor = 'green',
            onSelect = function()
                TriggerServerEvent('ek_gpscrew:server:acceptInvite', pendingInvite.crewId)
                pendingInvite = nil
            end
        })
        
        table.insert(options, {
            title = _('decline_invite_option'),
            description = 'Refuse the invitation',
            icon = 'times',
            iconColor = 'red',
            onSelect = function()
                TriggerServerEvent('ek_gpscrew:server:declineInvite', pendingInvite.crewId)
                pendingInvite = nil
            end
        })
        
        lib.registerContext({
            id = 'gpscrew_main',
            title = _('menu_title'),
            options = options
        })
        
        lib.showContext('gpscrew_main')
        return
    end
    
    if not crewData.inCrew then
        -- Create crew option
        table.insert(options, {
            title = _('menu_create'),
            description = _('menu_create_desc'),
            icon = 'users',
            onSelect = function()
                TriggerServerEvent('ek_gpscrew:server:createCrew')
            end
        })
    else
        -- Show crew info
        local memberCount = 0
        for _ in pairs(crewData.members) do
            memberCount = memberCount + 1
        end
        
        table.insert(options, {
            title = string.format(_('menu_members'), memberCount, Config.MaxCrewSize),
            icon = 'users',
            disabled = true
        })
        
        -- Leader options
        if crewData.isLeader then
            table.insert(options, {
                title = _('menu_invite'),
                description = _('menu_invite_desc'),
                icon = 'user-plus',
                onSelect = function()
                    OpenInviteMenu()
                end
            })
            
            table.insert(options, {
                title = _('menu_kick'),
                description = _('menu_kick_desc'),
                icon = 'user-minus',
                onSelect = function()
                    OpenKickMenu()
                end
            })
            
            table.insert(options, {
                title = _('menu_disband'),
                description = _('menu_disband_desc'),
                icon = 'trash',
                onSelect = function()
                    local alert = lib.alertDialog({
                        header = _('menu_disband'),
                        content = _('confirm_disband'),
                        centered = true,
                        cancel = true
                    })
                    
                    if alert == 'confirm' then
                        TriggerServerEvent('ek_gpscrew:server:disbandCrew')
                    end
                end
            })
        else
            -- Member options
            table.insert(options, {
                title = _('menu_leave'),
                description = _('menu_leave_desc'),
                icon = 'door-open',
                onSelect = function()
                    local alert = lib.alertDialog({
                        header = _('menu_leave'),
                        content = _('confirm_leave'),
                        centered = true,
                        cancel = true
                    })
                    
                    if alert == 'confirm' then
                        TriggerServerEvent('ek_gpscrew:server:manualLeaveCrew')
                    end
                end
            })
        end
        
        -- List members
        for serverId, member in pairs(crewData.members) do
            local memberName = member.name
            if member.isLeader then
                memberName = string.format(_('menu_leader'), memberName)
            end
            if serverId == GetPlayerServerId(PlayerId()) then
                memberName = memberName .. ' (' .. _('menu_you') .. ')'
            end
            
            table.insert(options, {
                title = memberName,
                icon = member.isLeader and 'crown' or 'user',
                disabled = true
            })
        end
    end
    
    lib.registerContext({
        id = 'gpscrew_main',
        title = _('menu_title'),
        options = options
    })
    
    lib.showContext('gpscrew_main')
end

-- Register command
RegisterCommand(Config.CommandName, function()
    OpenCrewMenu()
end, false)

-- Register ox_inventory item use
exports('useGPS', function(data, slot)
    OpenCrewMenu()
end)

-- Server events
RegisterNetEvent('ek_gpscrew:client:crewCreated', function(crewId)
    crewData.inCrew = true
    crewData.isLeader = true
    crewData.crewId = crewId
    ShowNotification(_('crew_created'), 'success')
end)

RegisterNetEvent('ek_gpscrew:client:joinedCrew', function(crewId, members, isLeader)
    crewData.inCrew = true
    crewData.isLeader = isLeader
    crewData.crewId = crewId
    crewData.members = members
    ShowNotification(_('crew_joined'), 'success')
    UpdateCrewBlips()
end)

RegisterNetEvent('ek_gpscrew:client:leftCrew', function()
    crewData.inCrew = false
    crewData.isLeader = false
    crewData.crewId = nil
    crewData.members = {}
    UpdateCrewBlips()
    ShowNotification(_('crew_left'), 'info')
end)

RegisterNetEvent('ek_gpscrew:client:crewDisbanded', function()
    crewData.inCrew = false
    crewData.isLeader = false
    crewData.crewId = nil
    crewData.members = {}
    UpdateCrewBlips()
    ShowNotification(_('crew_disbanded'), 'info')
end)

RegisterNetEvent('ek_gpscrew:client:memberJoined', function(serverId, memberData)
    crewData.members[serverId] = memberData
    ShowNotification(string.format(_('player_joined'), memberData.name), 'success')
    UpdateCrewBlips()
end)

RegisterNetEvent('ek_gpscrew:client:memberLeft', function(serverId, memberName)
    crewData.members[serverId] = nil
    ShowNotification(string.format(_('player_left'), memberName), 'info')
    UpdateCrewBlips()
end)

RegisterNetEvent('ek_gpscrew:client:kicked', function()
    crewData.inCrew = false
    crewData.isLeader = false
    crewData.crewId = nil
    crewData.members = {}
    UpdateCrewBlips()
    ShowNotification(_('player_kicked'), 'error')
end)

RegisterNetEvent('ek_gpscrew:client:updateMembers', function(members)
    crewData.members = members
    UpdateCrewBlips()
end)

RegisterNetEvent('ek_gpscrew:client:receiveInvite', function(inviterName, inviterId, crewId)
    if pendingInvite then return end
    
    pendingInvite = {
        inviterName = inviterName,
        inviterId = inviterId,
        crewId = crewId
    }
    
    ShowNotification(string.format(_('invite_received'), inviterName), 'info')
end)

-- Update player position to server
CreateThread(function()
    while true do
        Wait(Config.BlipUpdateInterval)
        
        if crewData.inCrew then
            -- Check if player still has GPS
            if not HasGPS() then
                ShowNotification(_('gps_lost'), 'error')
                TriggerServerEvent('ek_gpscrew:server:leaveCrew')
                crewData.inCrew = false
                crewData.isLeader = false
                crewData.crewId = nil
                crewData.members = {}
                UpdateCrewBlips()
            else
                local coords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('ek_gpscrew:server:updatePosition', coords)
            end
        end
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    for _, blip in pairs(crewData.blips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
end)
