Config.Functions = {
    --#region Client
    StartSelection = function()
        
    end,

    StopSelection = function()

    end,

    -- Returns true if the player can interact with the respray feature
    -- entity: table entity
    -- tableConfig: table config from Config.TablesPositions
    -- dropping: boolean if the player is dropping or picking up the respray gun
    CanRespray = function(entity, tableConfig, dropping)
        return true
    end,

    -- Returns true if the player can interact with the clean feature
    -- entity: table entity
    -- tableConfig: table config from Config.TablesPositions
    -- dropping: boolean if the player is dropping or picking up the sponge
    CanClean = function(entity, tableConfig, dropping)
        return true
    end,

    VehiclePropertiesChanged = function(veh)

    end,

    -- Called when the player aims at a vehicle and the spraygun bar should be displayed
    StartSpraygunBar = function(progress)
    end,

    -- Called when the player stops aiming at a vehicle
    StopSpraygunBar = function()
    end,

    -- Called every frame while the player is aiming at a vehicle
    UpdateSpraygunBar = function(progress)
        DrawTimeBar(Config.Translations["paint_progress"].label, progress, Config.Translations["paint_progress"].color, Config.Translations["paint_progress"].offset)
    end

    --[[ 
        CustomJobCheck = function(filter)
            
        end, 
    ]]

    --[[
        TargetAddModel = function(models, options)
    
        end,
        TargetAddLocalEntity = function(entity, options)
    
        end,
        TargetRemoveLocalEntity = function(entity)
    
        end,
    ]]
    --#endregion
}