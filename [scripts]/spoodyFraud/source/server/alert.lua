--- In this code, you can edit/configure the police report system, or add your own!

---@class alert
alert = {}
local cooldown = false

---@param location any
---@param productType 'Clone' | 'Check' | 'SIM Card'
function alert.sendPoliceReport(location, productType)
    if cooldown then return end

    local label, coords

    if Configuration.DispatchSystem == 'none' then return end

    if type(location) ~= "string" then
        label = "ATM"
        coords = location
    end

    if type(location) == "string" then
        if productType == 'Clone' then
            label = ('An ATM at %s has reported a fradulent card swipe.'):format(location)
            coords = Configuration.Selling.Clones.Locations[location].Location
        elseif productType == 'Check' then
            label = ('The bank at %s has reported a fradulent check.'):format(location)
            coords = Configuration.Selling.Checks.Locations[location].Location
        elseif productType == 'SIM Card' then
            label = ('A phone provider has reported a stolen SIM card marked on your radar.')
            coords = Configuration.Selling.Sims.Locations[location].Location
        end
    end

    cooldown = true

    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = { Configuration.Settings.Police.PoliceJob },
        coords = coords,
        title = '10-64 Police Report',
        message = label,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = 'Filed Report',
            time = 5,
            radius = 0,
        }
    })

    SetTimeout(5000, function()
        cooldown = false
    end)
end