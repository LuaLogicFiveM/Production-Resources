-- Dutch language file
if not Locale then Locale = {} end

Locale.nl = {
    current_scale = "Huidige lengte", current_weight = "Huidig gewicht", reset = "Resetten", apply = "Toepassen",
    scale_size = "Lengteschaal", weight_size = "Gewichtschaal", adjust_character = "Pas de lengte en het gewicht van je karakter aan.",
    scale_applied = "Lengte succesvol toegepast", weight_applied = "Gewicht succesvol toegepast", scale_reset = "Karakter gereset naar normale grootte",
    
    info_tip_1 = "De schaalverhouding beïnvloedt de algehele grootte en het uiterlijk van je karakter.",
    info_tip_2 = "Blijf binnen het aanbevolen bereik voor de beste game-ervaring.",
    info_tip_3 = "Tijdens bewegingsanimaties kan je schaal tijdelijk aanpassen.",
    info_tip_4 = "Schaalwijzigingen kunnen de in- en uitstapanimaties van voertuigen beïnvloeden.",
    
    notification_scale_applied_title = "Schaal toegepast", notification_scale_applied_message = "Schaal {scale} succesvol toegepast!",
    notification_scale_reset_title = "Schaal gereset", notification_scale_reset_message = "Karakter schaal gereset naar normale grootte",
    notification_framework_title = "Schaalsysteem", notification_framework_loading = "Opgeslagen schaal laden: {scale}",
    notification_scale_system_title = "Schaalsysteem", notification_model_changed = "Karakter model gewijzigd, schaal opnieuw toepassen...",
    notification_periodic_title = "Periodieke controle", notification_periodic_reapply = "Schaal opnieuw toepassen: {scale}",
    
    notification_setweight_usage = "Gebruik: /setweight <waarde> (bijv.: /setweight 0.9)",
    notification_setweight_invalid_number = "Ongeldige gewichtswaarde. Voer een geldig getal in.",
    notification_setweight_out_of_range = "Gewicht {weight} valt buiten bereik. Geldig bereik: {min} - {max}",
    notification_setweight_applied_title = "Gewicht ingesteld", notification_setweight_applied = "Gewicht ingesteld op {weight} via commando!",
    
    notification_error_title = "Fout", notification_setscale_usage = "Gebruik: /setscale <waarde> (bijv.: /setscale 0.6)",
    notification_setscale_invalid_number = "Ongeldige schaalwaarde. Voer een geldig getal in.",
    notification_setscale_out_of_range = "Schaal {scale} valt buiten bereik. Geldig bereik: {min} - {max}",
    notification_setscale_applied_title = "Schaal ingesteld", notification_setscale_applied = "Schaal ingesteld op {scale} via commando!",
    
    notification_permission_denied_title = "Toestemming geweigerd", notification_permission_denied_message = "Je hebt geen toestemming om dit script te gebruiken! Framework of Discord rol vereist.",
    notification_discord_permission_denied = "Je hebt niet de vereiste Discord rol!",
    notification_discord_not_connected = "Je Discord account is niet verbonden met de server!",
    notification_discord_role_check_failed = "Discord rol controle mislukt!",
    notification_givescale_usage = "Gebruik: /givescalemenu <player_id>", notification_givescale_player_not_found = "Speler niet gevonden!",
    notification_givescale_success = "Schaalmenu geopend voor speler {playerName} ({playerId})",
    notification_givescale_permission_denied = "Je hebt geen toestemming om dit commando te gebruiken!",
    notification_givescale_menu_opened = "Het schaalmenu is voor jou geopend door een beheerder",
    
    notification_checkscale_permission_denied = "Je hebt geen toestemming om dit commando te gebruiken!",
    notification_checkscale_no_records = "Geen records gevonden in database!",
    notification_checkscale_records_loaded = "{count} records geladen",
    notification_checkscale_record_deleted = "Record succesvol verwijderd: {identifier}",
    notification_checkscale_delete_failed = "Er is een fout opgetreden bij het verwijderen van het record!",
    checkscale_title = "Schaalrecords beheer", checkscale_identifier = "Identificatie",
    checkscale_scale_value = "Schaalwaarde", checkscale_updated_at = "Bijgewerkt op", checkscale_actions = "Acties",
    checkscale_delete = "Verwijderen", checkscale_confirm_delete = "Dit record verwijderen?", checkscale_close = "Sluiten",
    checkscale_total_records = "Totaal records:", checkscale_confirm_delete_message = "Weet je zeker dat je dit record wilt verwijderen?",
    checkscale_cancel = "Annuleren", checkscale_delete_confirm = "Verwijderen",
}

return Locale.nl