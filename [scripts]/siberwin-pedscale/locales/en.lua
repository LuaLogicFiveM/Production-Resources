if not Locale then
    Locale = {}
end

Locale.en = {
    current_scale = "Current Height",
    current_weight = "Current Weight",
    reset = "Reset",
    apply = "Apply",
    scale_size = "Height Scale",
    weight_size = "Weight Scale",
    adjust_character = "Adjust your character's height and weight.",
    scale_applied = "Height applied successfully",
    weight_applied = "Weight applied successfully",
    scale_reset = "Character reset to normal size",
    
    -- Info tips
    info_tip_1 = "Scale ratio affects your character's overall size and appearance.",
    info_tip_2 = "Stay within recommended range for best gameplay experience.",
    info_tip_3 = "During movement animations, your scale may temporarily adjust.",
    info_tip_4 = "Scale changes may affect vehicle entry and exit animations.",
    
    -- Notifications
    notification_scale_applied_title = "Scale Applied",
    notification_scale_applied_message = "Scale {scale} applied successfully!",
    notification_scale_reset_title = "Scale Reset",
    notification_scale_reset_message = "Character scale reset to normal size",
    notification_framework_title = "Scale System",
    notification_framework_loading = "Loading saved scale: {scale}",
    notification_scale_system_title = "Scale System",
    notification_model_changed = "Character model changed, reapplying scale...",
    notification_periodic_title = "Periodic Check",
    notification_periodic_reapply = "Reapplying scale: {scale}",
    
    -- SetWeight command notifications
    notification_setweight_usage = "Usage: /setweight <value> (e.g., /setweight 0.9)",
    notification_setweight_invalid_number = "Invalid weight value. Please enter a valid number.",
    notification_setweight_out_of_range = "Weight {weight} is out of range. Valid range: {min} - {max}",
    notification_setweight_applied_title = "Weight Set",
    notification_setweight_applied = "Weight set to {weight} via command!",
    
    -- SetScale command notifications
    notification_error_title = "Error",
    notification_setscale_usage = "Usage: /setscale <value> (e.g., /setscale 0.6)",
    notification_setscale_invalid_number = "Invalid scale value. Please enter a valid number.",
    notification_setscale_out_of_range = "Scale {scale} is out of range. Valid range: {min} - {max}",
    notification_setscale_applied_title = "Scale Set",
    notification_setscale_applied = "Scale set to {scale} via command!",
    
    -- Permission message
    notification_permission_denied_title = "Permission Denied",
    notification_permission_denied_message = "You don't have permission to use this script! Framework or Discord role required.",
    notification_discord_permission_denied = "You don't have the required Discord role!",
    notification_discord_not_connected = "Your Discord account is not connected to the server!",
    notification_discord_role_check_failed = "Discord role check failed!",
    
    -- GiveScaleMenu message
    notification_givescale_usage = "Usage: /givescalemenu <player_id>",
    notification_givescale_player_not_found = "Player not found!",
    notification_givescale_success = "Scale menu opened for player {playerName} ({playerId})",
    notification_givescale_permission_denied = "You don't have permission to use this command!",
    notification_givescale_menu_opened = "Scale menu has been opened for you by an admin",
    
    -- CheckScale message
    notification_checkscale_permission_denied = "You don't have permission to use this command!",
    notification_checkscale_no_records = "No records found in database!",
    notification_checkscale_records_loaded = "{count} records loaded",
    notification_checkscale_record_deleted = "Record successfully deleted: {identifier}",
    notification_checkscale_delete_failed = "Error occurred while deleting record!",
    checkscale_title = "Scale Records Management",
    checkscale_identifier = "Identifier",
    checkscale_scale_value = "Scale Value",
    checkscale_updated_at = "Updated At",
    checkscale_actions = "Actions",
    checkscale_delete = "Delete",
    checkscale_confirm_delete = "Delete this record?",
    checkscale_close = "Close",
    checkscale_total_records = "Total Records:",
    checkscale_confirm_delete_message = "Are you sure you want to delete this record?",
    checkscale_cancel = "Cancel",
    checkscale_delete_confirm = "Delete",
}

return Locale.en