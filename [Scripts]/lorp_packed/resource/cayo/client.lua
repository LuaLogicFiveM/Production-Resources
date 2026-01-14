local island = require "data.cayo"
local nearIsland = false

local function ActiveCayo()
    for _, part in pairs(island) do
        RequestIpl(part)
    end
end

local function SetupAmbient()
    SetAudioFlag("DisableFlightMusic", true)
    SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones", true, true)
    SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones", false, true)
    SetZoneEnabled(GetZoneFromNameId("PrLog"), false)
end

local function ActiveCayoPoint()
    lib.points.new({
        coords = vec3(5046, -5106, 6),
        distance = 2500,
        onEnter = function()
            nearIsland = true
            SetAiGlobalPathNodesType(1)
            LoadGlobalWaterType(1)
        end,
        onExit = function()
            nearIsland = false
            SetAiGlobalPathNodesType(0)
            LoadGlobalWaterType(0)
        end,
    })
end

AddEventHandler("onClientResourceStart", function(resourceName)
    local scriptName = cache.resource or GetCurrentResourceName()
    if resourceName ~= scriptName then return end
    ActiveCayo()
    SetupAmbient()
    ActiveCayoPoint()
end)

local isCayoMinimapLoaded = false

CreateThread(function()
    while true do
        -- We don't need to do something every frame in every cases
        ---@type integer
        local wait = 185 -- This should be low enough that, when the pause menu is opened, the minimap is toggled to be visible.

        if IsPauseMenuActive() and not IsMinimapInInterior() then
            -- If the player is in the pause menu and not looking at an interior minimap
            if isCayoMinimapLoaded then
                -- If the minimap was loaded with SetToggleMinimapHeistIsland, then we disable it
                isCayoMinimapLoaded = false
                SetToggleMinimapHeistIsland(false)
            end
            -- We force load the Cayo Perico minimap
            SetRadarAsExteriorThisFrame()
            SetRadarAsInteriorThisFrame(GetHashKey("h4_fake_islandx"), 4700.0, -5145.0, 0, 0)
            wait = 0

        elseif not isCayoMinimapLoaded and nearIsland then
            -- If the minimap is not loaded with SetToggleMinimapHeistIsland and the player is close to cayo perico, then we load it
            isCayoMinimapLoaded = true
            SetToggleMinimapHeistIsland(true)
        end
        Wait(wait)
    end
end)