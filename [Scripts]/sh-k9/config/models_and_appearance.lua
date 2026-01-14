return {
    --[[ 
        AVAILABLE K9 MODELS
        Only certain dog models in GTA V can perform attack animations
        These are the tested and working models for the K9 system
    ]]
    models = {
        -- DEFAULT GTA V MODELS (no additional resources required)
        { label = 'Shepherd', hash = `a_c_shepherd` },
        { label = 'Rottweiler', hash = `a_c_rottweiler` },
        { label = 'Bluetick', hash = `bluetick` },
        { label = 'Foxhound', hash = `foxhound` },

        -- PREMIUM MODELS (require separate purchase and installation)
        -- Uncomment the line below if you have purchased models from Mouby's Dog House
        -- Shop: https://moubys-dog-house.tebex.io/category/2145444
        -- { label = 'Malinois', hash = `malinois` }, 
        
        --[[ 
            ADD MORE MODELS HERE:
            { label = 'Display Name', hash = `model_hash` },
            
            IMPORTANT: Only add models that support attack animations!
            Most civilian dog models cannot attack and will cause issues.
        ]]
    },

    --[[ 
        ================================================================================================
        APPEARANCE CUSTOMIZATION SYSTEM
        ================================================================================================
        
        HOW THE SYSTEM WORKS:
        
        1. DEFAULT APPEARANCES:
           - Every model has a 'default' appearance using base GTA V assets
           - No additional resources required for default appearances
           - These are automatically detected and loaded
        
        2. CUSTOM APPEARANCES:
           - Require specific resource packs to be installed
           - System detects resources by their folder name
           - Each resource can add new customization options
        
        3. UNSUPPORTED MODELS:
           - Models without defined appearances show "Random Appearance" button only
           - You can add custom appearances following the guide below
        
        RESOURCE DETECTION:
        - The system checks if resources are installed by their folder names
        - If a resource is found, its appearance options become available
        - If not found, those options are hidden from the menu
        
        ================================================================================================
        HOW TO ADD APPEARANCE OPTIONS FOR NEW MODELS
        ================================================================================================
        
        STEP 1: Test the Model
        1. Register a new K9 with your desired model
        2. Spawn the K9 in-game
        3. Use command: /k9devappearance
        4. Check your client console (F8) for appearance data
        
        STEP 2: Analyze the Data
        - Look for components that actually change the model's appearance
        - Test different drawable and texture combinations
        - Note: Many components/textures may do nothing - this is normal
        
        STEP 3: Add Configuration
        - Use the format shown below in the appearance table
        - Include only working components and textures
        - Give descriptive labels for each customization option
        
        STEP 4: Test and Refine
        - Test all combinations in-game
        - Remove options that don't work properly
        - Ensure texture counts are correct (textures start from 0)
        
        IMPORTANT NOTES:
        - totalTextures = 1 means texture index 0 only
        - totalTextures = 3 means texture indices 0, 1, 2
        - Always test thoroughly before adding to production server
        
        CONTRIBUTION:
        If you successfully configure a new model, consider sharing it!
        Create a support ticket with your configuration code to help other users.
        
        ================================================================================================
    ]]
    
    appearance = { 
        --[[ 
            ROTTWEILER APPEARANCES
            Default GTA V Rottweiler model with base game customization options
        ]]
        [`a_c_rottweiler`] = {
            -- Base game appearance (no additional resources required)
            default = {
                { 
                    label = 'Skin', 
                    component = 4, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Brown, Black, Mixed colors
                },
                { 
                    label = 'No Collar', 
                    component = 3, 
                    drawable = 1, 
                    textures = { 1 } -- Remove collar completely
                },
                { 
                    label = 'Collar Style', 
                    component = 3, 
                    drawable = 0, 
                    textures = { 0, 1, 2, 3 } -- Different collar colors/styles
                },
            },
        },

        --[[ 
            GERMAN SHEPHERD APPEARANCES
            Multiple resource options available for enhanced customization
        ]]
        [`a_c_shepherd`] = {
            -- Base game appearance (no additional resources required)
            default = {
                { 
                    label = 'Skin', 
                    component = 0, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Different coat patterns
                },
            },

            -- FREE RESOURCE: Enhanced German Shepherd
            -- Download: https://forum.cfx.re/t/how-to-german-shepherd-malinois-k9-dog-1-0-1/1065040
            -- Installation: Extract to resources folder, ensure resource name is 'k9_model'
            ['k9_model'] = {
                { 
                    label = 'Skin', 
                    component = 0, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Traditional, Dark, Light patterns
                },
                { 
                    label = 'Vest Color', 
                    component = 3, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Black, Blue, Green tactical vests
                },
                { 
                    label = 'Vest Type', 
                    component = 8, 
                    drawable = 0, 
                    textures = { 0, 1, 2, 3, 5, 6, 7 } -- Different vest types and attachments
                },
            },

            -- PREMIUM RESOURCE: Riley K9 Model
            -- Purchase: https://moubys-dog-house.tebex.io/package/5176462
            -- Installation: Extract to resources folder, ensure resource name is 'riley'
            ['riley'] = {
                { 
                    label = 'Skin', 
                    component = 0, 
                    drawable = 0, 
                    textures = { 0, 1 } -- Two premium coat styles
                },
                { 
                    label = 'No Vest', 
                    component = 3, 
                    drawable = 1, 
                    textures = { 0 } -- Clean, unequipped appearance
                },
                { 
                    label = 'Vest Type', 
                    component = 3, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Police, SWAT, Tactical vest styles
                },
            }
        },

        --[[ 
            BELGIAN MALINOIS APPEARANCES
            Premium model with professional law enforcement appearance options
        ]]
        -- PREMIUM RESOURCE: Belgian Malinois
        -- Purchase: https://moubys-dog-house.tebex.io/package/6260956
        -- Installation: Extract to resources folder, ensure resource name is 'malinois'
        [`malinois`] = {
            ['malinois'] = {
                { 
                    label = 'Coat Color', 
                    component = 0, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Fawn, Mahogany, Sable variations
                },
                { 
                    label = 'Service Mode', 
                    component = 3, 
                    drawable = 1, 
                    textures = { 0 } -- Off-duty appearance (no equipment)
                },
                { 
                    label = 'Duty Equipment', 
                    component = 3, 
                    drawable = 0, 
                    textures = { 0, 1, 2 } -- Standard, Heavy, Specialized gear
                },
            },
        },

        --[[ 
            ADD YOUR CUSTOM MODELS HERE:
            
            [`your_model_hash`] = {
                ['resource_name'] = {
                    { 
                        label = 'Customization Name', 
                        component = X, 
                        drawable = Y, 
                        textures = { 0, 1, 2, ... } 
                    },
                    -- Add more customization options...
                },
            },
            
            EXAMPLE TEMPLATE:
            [`a_c_yourdog`] = {
                default = {
                    { 
                        label = 'Primary Color', 
                        component = 0, 
                        drawable = 0, 
                        textures = { 0, 1, 2 } 
                    },
                },
                ['your_resource'] = {
                    { 
                        label = 'Special Feature', 
                        component = 1, 
                        drawable = 0, 
                        textures = { 0, 1 } 
                    },
                },
            },
        ]]
    }
}

--[[ 
    ================================================================================================
    CONFIGURATION TROUBLESHOOTING
    ================================================================================================
    
    COMMON ISSUES & SOLUTIONS:
    
    1. MODEL NOT APPEARING IN MENU:
       - Check if model hash is correct (use /k9devappearance)
       - Ensure model resource is properly installed and started
       - Verify model supports attack animations
    
    2. APPEARANCE OPTIONS NOT WORKING:
       - Confirm resource folder name matches configuration
       - Test component/drawable/texture combinations manually
       - Some options may be model-specific and not work on all variants
    
    3. RESOURCE DETECTION FAILING:
       - Resource folder name must match exactly (case-sensitive)
       - Ensure resource is started before the K9 script
       - Check server console for resource loading errors
    
    4. TEXTURES NOT DISPLAYING:
       - Texture indices start from 0, not 1
       - Don't include texture indices that don't exist
       - Some models have unused texture slots that do nothing
    
    BEST PRACTICES:
    - Always backup original files before modifications
    - Test new configurations on development server first
    - Document custom configurations for team members
    
    ================================================================================================
]]