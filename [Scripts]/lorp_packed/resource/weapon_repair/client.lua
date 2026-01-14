local config = require 'resource.weapon_repair.shared'
local ox_inventory = exports.ox_inventory
local ox_target = exports.ox_target
local labels = {}

local function GetLabels()
    for k, v in pairs(ox_inventory:Items()) do
        labels[string.lower(k)] = v.label
    end
end CreateThread(GetLabels)

local function ColorScheme(value)
    if value >= 80 then
        return "green.6"
    elseif value >= 60 then
        return "yellow.6"
    elseif value >= 40 then
        return "orange.6"
    else
        return "red.8"
    end
end

local function createBlip(coords, sprite, scale, color, label)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 5)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)
    return blip
end

local function createModel(model, coords, heading)
    local requestModel = lib.requestModel(model)
    local repairBench = CreateObject(requestModel, coords.x, coords.y, coords.z, false, false, false)
    SetEntityHeading(repairBench, heading + 178.0)
    FreezeEntityPosition(repairBench, true)
    PlaceObjectOnGroundProperly(repairBench)
    SetModelAsNoLongerNeeded(requestModel)
    return repairBench
end

RegisterNetEvent('lorp_repair_bench:client:repair', function(data)
    if lib.progressCircle({
        label = 'Repairing...',
        duration = 13500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
        },
        anim = {
            dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            clip = 'machinic_loop_mechandplayer'
        }
    }) then 
        TriggerServerEvent('lorp_repair_bench:server:finishRepair', data)
    end
end)

local function RepairBenchMenu(data)
    local playerInventory = ox_inventory:GetPlayerItems()
    local menu = {
        id = 'repair_bench',
        title = 'Repair Bench',
        options = {}
    }

    for _, item in pairs(playerInventory) do
        if item.name and string.find(string.upper(item.name), 'WEAPON_') then
            local itemUpper = string.upper(item.name)
            if not config.blacklisted[itemUpper] then
                local descr = ""
                local partsList = {}
                local durability = item.metadata and item.metadata.durability or 100
                local repairs = item.metadata and item.metadata.repairs or 0

                for _, part in ipairs(data.required) do
                    local label = labels[string.lower(part.item)] or part.item
                    partsList[#partsList+1] = { label = label, amount = part.count }
                end

                table.sort(partsList, function(a, b) return #a.label < #b.label end)

                for _, part in ipairs(partsList) do
                    descr = descr .. string.format("%s (x%d) | ", part.label, part.amount)
                end

                descr = descr:sub(1, -3)

                menu.options[#menu.options+1] = {
                    icon = 'gun',
                    title = item.label .. ' ('..durability..') ('..repairs..')',
                    description = descr,
                    progress = durability,
                    colorScheme = ColorScheme(durability),
                    disabled = durability == 100 or repairs >= 3 or false,
                    --metadata = item.metadata,
                    args = {
                        weapon = item,
                        inventory = playerInventory,
                        dat = data
                    },
                    onSelect = function(args)
                        TriggerServerEvent('lorp_repair_bench:server:repair', args)
                    end,
                }
            end
        end
    end

    lib.registerContext(menu)
    lib.showContext(menu.id)
end exports('RepairBenchMenu', RepairBenchMenu) -- exports.lorp_packed:RepairBenchMenu({ blip = { enabled = true, label = "Weapon Repair Bench", color = 1, scale = 0.7, sprite = 110 }, bench = { model = "gr_prop_gr_bench_01a", coords = vector4(684.332, -716.611, 25.023, 182.9237) }, required = {{ count = 25, item = "scrap_metal" }, { count = 10000, item = "money" }}})

CreateThread(function()
    for _, BenchData in pairs(config.locations) do
        if BenchData.blip and BenchData.blip.enabled then
            local blip = createBlip(BenchData.bench.coords.xyz, BenchData.blip.sprite, BenchData.blip.scale, BenchData.blip.color, BenchData.blip.label)
            SetBlipCategory(blip, 12)
        end

        local repair_bench = lib.points.new({
            coords = vec3(BenchData.bench.coords.x, BenchData.bench.coords.y, BenchData.bench.coords.z),
            distance = config.distance
        })

        function repair_bench:onEnter()
            local repairBench = createModel(BenchData.bench.model, BenchData.bench.coords.xyz, BenchData.bench.coords.w)
            self.entity = repairBench
            ox_target:addLocalEntity(repairBench, {
                {
                    icon = 'fa-solid fa-gun',
                    label = 'Open Repair Bench',
                    distance = 2.0,
                    onSelect = function()
                        RepairBenchMenu(BenchData)
                    end
                }
            })
        end

        function repair_bench:onExit()
            ox_target:removeLocalEntity(self.entity)
            DeleteEntity(self.entity)
        end
    end
end)