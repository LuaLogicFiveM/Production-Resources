lib.locale()

--[[local playerJob = {}

RegisterNetEvent('esx:playerLoaded', function (xPlayer)
    playerJob = {job = xPlayer.job.name, grade = xPlayer.job.grade}
end)

RegisterNetEvent("esx:setJob") 
AddEventHandler('esx:setJob', function(job, lastJob)
    playerJob = {job = job.name, grade = job.grade}
end)]]

local function openContextMenu(lockerName)
    lib.registerContext({
      id = 'dg_evidencelocker_menu_' .. lockerName,
      title = locale('menu_title'),
      options = {
            {
                title = locale('create_stash'),
                description = locale('create_stash_desc'),
                icon = 'fa-solid fa-folder-plus',
                onSelect = function()
                    local input = lib.inputDialog(locale('create_stash'), { locale('input_stash_name') })
                    if input and input[1] then
                      TriggerServerEvent('lorp_evidence_locker:create', lockerName, input[1])
                    end
                end
            },
            {
                title = locale('search_stash'),
                description = locale('search_stash_desc'),
                icon = 'fa-solid fa-search',
                onSelect = function()
                    local input = lib.inputDialog(locale('search_stash'), { locale('input_stash_name') })
                    if input and input[1] then
                      TriggerServerEvent('lorp_evidence_locker:search', lockerName, input[1])
                    end
                end
            },
            {
                title = locale('list_stashes'),
                description = locale('list_stashes_desc'),
                icon = 'fa-solid fa-list',
                onSelect = function()
                    TriggerServerEvent('lorp_evidence_locker:showAll', lockerName)
                end
            },
            {
                title = locale('clear_stash'),
                description = locale('clear_stash_desc'),
                icon = 'fa-solid fa-trash',
                onSelect = function()
                    TriggerServerEvent('lorp_evidence_locker:clearMenu', lockerName)
                end
            },
            {
                title = locale('delete_stash'),
                description = locale('delete_stash_desc'),
                icon = 'fa-solid fa-triangle-exclamation',
                onSelect = function()
                    TriggerServerEvent('lorp_evidence_locker:deleteMenu', lockerName)
                end
            }
        }
    })
    lib.showContext('dg_evidencelocker_menu_' .. lockerName)
end


RegisterNetEvent('lorp_evidence_locker:openMenu', function(lockerName, lockers)
    local options = {
        {
            title = locale('back'),
            icon = 'fa-solid fa-arrow-left',
            onSelect = function() openContextMenu(lockerName) end
        }
    }

    for _, locker in ipairs(lockers) do
        table.insert(options, {
            title = locker.name,
            description = locale('open_stash_desc') .. ' ' .. locker.name,
            onSelect = function()
                TriggerServerEvent('lorp_evidence_locker:search', lockerName, locker.name)
            end
        })
    end

    lib.registerContext({
        id = 'dg_evidencelocker_list_' .. lockerName,
        title = locale('select_stash'),
        description = locale('select_stash_desc'),
        options = options
    })
    lib.showContext('dg_evidencelocker_list_' .. lockerName)
end)


RegisterNetEvent('lorp_evidence_locker:openClearMenu', function(lockerName, lockers)
    local options = {
        {
          title = locale('back'),
          icon = 'fa-solid fa-arrow-left',
          onSelect = function() openContextMenu(lockerName) end
        }
    }

    for _, locker in ipairs(lockers) do
        table.insert(options, {
            title = locker.name,
            description = locale('clear_stash_desc') .. ' ' .. locker.name,
            icon = 'fa-solid fa-trash',
            onSelect = function()
                TriggerServerEvent('lorp_evidence_locker:confirmClear', lockerName, locker.stash_name)
            end
        })
    end

    lib.registerContext({
        id = 'dg_evidencelocker_clear_' .. lockerName,
        title = locale('clear_stash'),
        options = options
    })
    lib.showContext('dg_evidencelocker_clear_' .. lockerName)
end)

RegisterNetEvent('lorp_evidence_locker:confirmClear', function(lockerName, stashName)
    local confirmed = lib.alertDialog({
        header = locale('clear_stash'),
        content = locale('confirm_clear_stash'),
        centered = true,
        cancel = true,
        size = 'md',
        labels = { cancel = locale('cancel'), confirm = locale('confirm') }
    })

    if confirmed == 'confirm' then
        TriggerServerEvent('lorp_evidence_locker:clear', lockerName, stashName)
    end
end)


RegisterNetEvent('lorp_evidence_locker:openDeleteMenu', function(lockerName, lockers)
    local options = {
        {
            title = locale('back'),
            icon = 'fa-solid fa-arrow-left',
            onSelect = function() openContextMenu(lockerName) end
        }
    }

    for _, locker in ipairs(lockers) do
        table.insert(options, {
            title = locker.name,
            description = locale('delete_stash_desc') .. ' ' .. locker.name,
            icon = 'fa-solid fa-triangle-exclamation',
            onSelect = function()
                TriggerServerEvent('lorp_evidence_locker:confirmDelete', lockerName, locker.stash_name)
            end
        })
    end

    lib.registerContext({
        id = 'dg_evidencelocker_delete_' .. lockerName,
        title = locale('delete_stash'),
        options = options
    })
    lib.showContext('dg_evidencelocker_delete_' .. lockerName)
end)

RegisterNetEvent('lorp_evidence_locker:confirmDelete', function(lockerName, stashName)
    local confirmed = lib.alertDialog({
        header = locale('delete_stash'),
        content = locale('confirm_delete_stash'),
        centered = true,
        cancel = true,
        size = 'md',
        labels = { cancel = locale('cancel'), confirm = locale('confirm') }
    })

    if confirmed == 'confirm' then
        TriggerServerEvent('lorp_evidence_locker:delete', lockerName, stashName)
    end
end)

local function createStashZone(id, lockerData)
    exports.ox_target:addBoxZone({
        coords = lockerData.coords,
        size = vec3(2, 2, 2),
        rotation = 0,
        debug = false,
        options = {
            {
                label = locale('open_stash'),
                icon = 'fa-solid fa-archive',
                groups = {[id] = 0},
                onSelect = function()
                    openContextMenu(id)
                end
            }
        }
    })
end

local function removeStashZone(id)
    exports.ox_target:removeZone(id)
end

CreateThread(function()
    for jobName, locker in pairs(Config.EvidenceLockers) do
        local stashPoint = lib.points.new({
            coords = locker.coords,
            distance = 50,
            locker = locker,
            jobName = jobName
        })

        function stashPoint:onEnter()
            createStashZone(self.jobName, self.locker)
        end

        function stashPoint:onExit()
            removeStashZone(self.jobName)
        end
    end
end)
