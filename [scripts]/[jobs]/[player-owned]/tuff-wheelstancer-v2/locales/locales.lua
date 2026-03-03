Language = "en" -- if you want to set a new language set it below

MenuLabels = {

    WHEEL_TYPE               = 'Wheel Type',
    WHEEL_NUMBER             = 'Wheel Number',
    ALL_WHEELS_WIDTH         = 'Wheel Width',
    ALL_WHEELS_SIZE          = 'Wheel Size',
    ALL_WHEELS_OFFSET        = 'All Wheel Offset',
    ALL_WHEELS_CAMBER        = 'All Wheel Camber',
    SUSPENSION_HEIGHT        = 'Suspension Height',
    WHEEL_FRONT_LEFT_OFFSET  = 'Front Left Offset',
    WHEEL_FRONT_RIGHT_OFFSET = 'Front Right Offset',
    WHEEL_REAR_LEFT_OFFSET   = 'Rear Left Offset',
    WHEEL_REAR_RIGHT_OFFSET  = 'Rear Right Offset',
    WHEEL_FRONT_LEFT_CAMBER  = 'Front Left Camber',
    WHEEL_FRONT_RIGHT_CAMBER = 'Front Right Camber',
    WHEEL_REAR_LEFT_CAMBER   = 'Rear Left Camber',
    WHEEL_REAR_RIGHT_CAMBER  = 'Rear Right Camber',

    SELECT_ALL_WHEELS        = "SELECT ALL WHEELS",
    CONFIRM_STANCE           = "CONFIRM STANCE",
    RESET_ALL                = "RESET ALL",
    EXIT                     = "Exit",
    TOTAL_PRICE              = "TOTAL PRICE:",
    RESET                    = "Reset",
    PREVIEW                  = "Preview",
    PRESETS                  = "Presets",
    MOVE_UI                  = "Move UI",
    NO_PRESETS_YET           = "NO PRESETS YET",
    PRESETS_SUBTEXT          = "Your custom presets will appear here once created",
    GO_BACK                  = "GO BACK",
    NO_CHANGES_MADE          = "You haven't made any changes!",
    PRESET_APPLIED           = "Preset {name} has been applied !",
    PRESET_SAVED             = "Preset {name} has been saved !",
    PRESET_DELETED           = "Preset {name} has been deleted !",
    APPLY_PRESET             = "APPLY PRESET",
    DELETE_PRESET            = "DELETE PRESET",
    SAVE_PRESET              = "SAVE PRESET",
    ENTER_PRESET_NAME        = "Enter Preset Name...",
    BILL_PLAYER              = "BILL PLAYER",
    SEND_INVOICE             = "SEND INVOICE",
    PLAYER_ID                = "PLAYER ID",
    ENTER_PLAYER_ID          = "Enter Player ID...",
    CANCEL                   = "CANCEL",
    BANK                     = "BANK",
    CASH                     = "CASH",
    INVOICE_SENT_INFO        = 'Stance Invoice has been sent to you, kindly review and pay',
    
    -- Game Hints
    LEFT_CLICK_DRAG_BOLT     = 'LEFT CLICK AND DRAG TO UNSCREW BOLT', -- 'LEFT CLICK AND DRAG TO UNSCREW BOLT'
    EXIT_MINIGAME            = 'EXIT MINIGAME', -- 'EXIT MINIGAME'
    ROTATE_CAMERA_ANGLE      = 'ROTATE CAMERA ANGLE', -- 'ROTATE CAMERA ANGLE'
    ZOOM_IN_OUT              = 'ZOOM IN/OUT', -- 'ZOOM IN/OUT'
    END_PREVIEW_MODE         = 'END PREVIEW MODE', -- 'END PREVIEW MODE'
}
Translations = {
    ["en"] = {
        -- General Messages
        job_error                 = 'You do not have the required job to use Stance Menu',
        blacklisted_error         = 'This Vehicle is Blacklisted / Not Allowed for Stance',
        save_successfully         = "Save successfully",
        not_enoughmoney           = "You do not have enough money",
        not_owned                 = "This vehicle is not owned",
        no_item                   = "You don't have stancekit item",
        pending_apply             = 'Stance is pending for appliance,Bring it to a lift!',
        no_money                  = 'You Dont have Enough Money!',

        no_identifier             = "This vehicle is not have owned",
        not_allow_sendinvoice     = "You don't have permission to send invoice",
        not_allow_open            = "You don't have permission to use stance item",
        not_allowzone_open        = "You can't use stance at this zone",
        not_inzone                = "You cant use stancer outside stance locations",
        no_allow_to_remove_stance = "You don't have permission to remove stance",
        no_vehicle                = "You are not sitting inside the vehicle",
        remove_stance_success     = "Successfully Removed the stance from this vehicle",
        no_stance_found           = "No stance found against this vehicle",
        item_error                = "You don't have stance item",
        removed_item              = "You have removed stance item",
        removed_item_title        = "Removed Item",
        stance_success            = "Vehicle stance applied successfully",
        stance_success_admin      = "Vehicle stance applied successfully by Administration",
        no_change                 = "You don't change any value",
        you_have_been_charge      = "You have been charged :money:",
        animation_error           = "You need to stance vehicle first!",
        cant_saved_preset         = "You need to enter a name",
        preset_removed            = "Preset removed!",
        preset_added              = "Preset added!",
        player_unknown            = 'Entered ID does not exist',
        billed_player             = 'Successfully billed the player',
        invalid_data              = 'Data Entered is Invalid. Double Check To Make Sure',
        minigame_busy             = 'Someone else is working on this wheel!',
        invalid_data_open_again   = 'Invalid Wheel Datas,Please Try Opening the menu again',
        
        -- RadialMenu
        radialmenuOpen            = 'Open Stance Menu',

        -- Targets and DrawText :
        adjust_susp               = 'Adjust The Wheel Suspension ',
        install_wheel             = 'Install New Wheel ',
        remove_wheel              = 'Remove The Wheel ',
        adjust_rot                = 'Adjust Wheel Rotation ',
        open_liftmenu             = 'Open Lift Menu',
        no_pending_stance         = 'The Vehicle Does not have a pending stance input',
        pickdrop_wheel            = 'Pick/Drop a Wheel',
        view_receipt              = 'View Receipt Data',

        open_wheelinput           = 'Press [E] To Open Wheel Input',

        -- Key Mappings , These will be shown when the player wants to change hotkeys in fivem settings.

        car_lift_button           = 'Stance Lift Actions Button',
        car_lift_menu             = 'Stance Lift Menu Open Button',
        open_stance_button        = 'Open Stance Menu',


        -- Webhook Infos
        typeRemoval   = ' Removal',
        typeAppliance = ' Applied',
        vehicle_plate = 'Vehicle Plate',
        player_name   = 'Player Name',
        player_sid    = 'Player Server ID',
        player_id     = 'Player Identifier',
        player_job    = 'Player Job',
        player_money  = 'Player Money'

    },
}
