-- Italian language file
if not Locale then Locale = {} end

Locale.it = {
    current_scale = "Altezza attuale", current_weight = "Peso attuale", reset = "Ripristina", apply = "Applica",
    scale_size = "Scala altezza", weight_size = "Scala peso", adjust_character = "Regola l'altezza e il peso del tuo personaggio.",
    scale_applied = "Altezza applicata con successo", weight_applied = "Peso applicato con successo", scale_reset = "Personaggio ripristinato alla dimensione normale",
    
    info_tip_1 = "Il rapporto di scala influisce sulla dimensione complessiva e sull'aspetto del tuo personaggio.",
    info_tip_2 = "Rimani nell'intervallo raccomandato per la migliore esperienza di gioco.",
    info_tip_3 = "Durante le animazioni di movimento, la tua scala potrebbe regolarsi temporaneamente.",
    info_tip_4 = "I cambiamenti di scala possono influenzare le animazioni di entrata e uscita dai veicoli.",
    
    notification_scale_applied_title = "Scala applicata", notification_scale_applied_message = "Scala {scale} applicata con successo!",
    notification_scale_reset_title = "Scala ripristinata", notification_scale_reset_message = "Scala del personaggio ripristinata alla dimensione normale",
    notification_framework_title = "Sistema di scala", notification_framework_loading = "Caricamento scala salvata: {scale}",
    notification_scale_system_title = "Sistema di scala", notification_model_changed = "Modello del personaggio cambiato, riapplicando la scala...",
    notification_periodic_title = "Controllo periodico", notification_periodic_reapply = "Riapplicando la scala: {scale}",
    
    notification_setweight_usage = "Uso: /setweight <valore> (es.: /setweight 0.9)",
    notification_setweight_invalid_number = "Valore del peso non valido. Inserisci un numero valido.",
    notification_setweight_out_of_range = "Il peso {weight} è fuori intervallo. Intervallo valido: {min} - {max}",
    notification_setweight_applied_title = "Peso impostato", notification_setweight_applied = "Peso impostato a {weight} tramite comando!",
    
    notification_error_title = "Errore", notification_setscale_usage = "Uso: /setscale <valore> (es.: /setscale 0.6)",
    notification_setscale_invalid_number = "Valore della scala non valido. Inserisci un numero valido.",
    notification_setscale_out_of_range = "La scala {scale} è fuori intervallo. Intervallo valido: {min} - {max}",
    notification_setscale_applied_title = "Scala impostata", notification_setscale_applied = "Scala impostata a {scale} tramite comando!",
    
    notification_permission_denied_title = "Permesso negato", notification_permission_denied_message = "Non hai il permesso di usare questo script! Richiesto Framework o ruolo Discord.",
    notification_discord_permission_denied = "Non hai il ruolo Discord richiesto!",
    notification_discord_not_connected = "Il tuo account Discord non è connesso al server!",
    notification_discord_role_check_failed = "Controllo del ruolo Discord fallito!",
    notification_givescale_usage = "Uso: /givescalemenu <player_id>", notification_givescale_player_not_found = "Giocatore non trovato!",
    notification_givescale_success = "Menu scala aperto per il giocatore {playerName} ({playerId})",
    notification_givescale_permission_denied = "Non hai il permesso di usare questo comando!",
    notification_givescale_menu_opened = "Il menu scala è stato aperto per te da un amministratore",
    
    notification_checkscale_permission_denied = "Non hai il permesso di usare questo comando!",
    notification_checkscale_no_records = "Nessun record trovato nel database!",
    notification_checkscale_records_loaded = "{count} record caricati",
    notification_checkscale_record_deleted = "Record eliminato con successo: {identifier}",
    notification_checkscale_delete_failed = "Errore durante l'eliminazione del record!",
    checkscale_title = "Gestione record scala", checkscale_identifier = "Identificatore",
    checkscale_scale_value = "Valore scala", checkscale_updated_at = "Aggiornato il", checkscale_actions = "Azioni",
    checkscale_delete = "Elimina", checkscale_confirm_delete = "Eliminare questo record?", checkscale_close = "Chiudi",
    checkscale_total_records = "Record totali:", checkscale_confirm_delete_message = "Sei sicuro di voler eliminare questo record?",
    checkscale_cancel = "Annulla", checkscale_delete_confirm = "Elimina",
}

return Locale.it