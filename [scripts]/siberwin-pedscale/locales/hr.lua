-- Croatian language file
if not Locale then Locale = {} end

Locale.hr = {
    current_scale = "Trenutna visina", current_weight = "Trenutna težina", reset = "Resetiraj", apply = "Primijeni",
    scale_size = "Skala visine", weight_size = "Skala težine", adjust_character = "Prilagodite visinu i težinu vašeg lika.",
    scale_applied = "Visina je uspješno primijenjena", weight_applied = "Težina je uspješno primijenjena",
    scale_reset = "Lik je resetiran na normalnu veličinu",
    
    info_tip_1 = "Omjer skale utječe na ukupnu veličinu i izgled vašeg lika.",
    info_tip_2 = "Ostanite u preporučenom rasponu za najbolje iskustvo igranja.",
    info_tip_3 = "Tijekom animacija pokreta, vaša skala se može privremeno prilagoditi.",
    info_tip_4 = "Promjene skale mogu utjecati na animacije ulaska i izlaska iz vozila.",
    
    notification_scale_applied_title = "Skala je primijenjena", notification_scale_applied_message = "Skala {scale} je uspješno primijenjena!",
    notification_scale_reset_title = "Skala je resetirana", notification_scale_reset_message = "Skala lika je resetirana na normalnu veličinu",
    notification_framework_title = "Sustav skale", notification_framework_loading = "Učitavanje spremljene skale: {scale}",
    notification_scale_system_title = "Sustav skale", notification_model_changed = "Model lika je promijenjen, ponovo primjenjujem skalu...",
    notification_periodic_title = "Periodička provjera", notification_periodic_reapply = "Ponovo primjenjujem skalu: {scale}",
    
    notification_setweight_usage = "Korištenje: /setweight <vrijednost> (npr.: /setweight 0.9)",
    notification_setweight_invalid_number = "Neispravna vrijednost težine. Molimo unesite valjani broj.",
    notification_setweight_out_of_range = "Težina {weight} je izvan raspona. Valjani raspon: {min} - {max}",
    notification_setweight_applied_title = "Težina postavljena", notification_setweight_applied = "Težina postavljena na {weight} putem naredbe!",
    
    notification_error_title = "Greška", notification_setscale_usage = "Korištenje: /setscale <vrijednost> (npr.: /setscale 0.6)",
    notification_setscale_invalid_number = "Neispravna vrijednost skale. Molimo unesite valjani broj.",
    notification_setscale_out_of_range = "Skala {scale} je izvan raspona. Valjani raspon: {min} - {max}",
    notification_setscale_applied_title = "Skala postavljena", notification_setscale_applied = "Skala postavljena na {scale} putem naredbe!",
    
    notification_permission_denied_title = "Dozvola odbijena", notification_permission_denied_message = "Nemate dozvolu za korištenje ovog skripte! Potreban Framework ili Discord uloga.",
    notification_discord_permission_denied = "Nemate potrebnu Discord ulogu!",
    notification_discord_not_connected = "Vaš Discord račun nije povezan sa serverom!",
    notification_discord_role_check_failed = "Provjera Discord uloge nije uspjela!",
    notification_givescale_usage = "Korištenje: /givescalemenu <player_id>", notification_givescale_player_not_found = "Igrač nije pronađen!",
    notification_givescale_success = "Izbornik skale otvoren za igrača {playerName} ({playerId})",
    notification_givescale_permission_denied = "Nemate dozvolu za korištenje ove naredbe!",
    notification_givescale_menu_opened = "Administrator vam je otvorio izbornik skale",
    
    notification_checkscale_permission_denied = "Nemate dozvolu za korištenje ove naredbe!",
    notification_checkscale_no_records = "Nema pronađenih zapisa u bazi podataka!",
    notification_checkscale_records_loaded = "Učitano je {count} zapisa",
    notification_checkscale_record_deleted = "Zapis uspješno uklonjen: {identifier}",
    notification_checkscale_delete_failed = "Dogodila se greška prilikom brisanja zapisa!",
    checkscale_title = "Upravljanje zapisima skale", checkscale_identifier = "Identifikator",
    checkscale_scale_value = "Vrijednost skale", checkscale_updated_at = "Ažurirano", checkscale_actions = "Radnje",
    checkscale_delete = "Ukloni", checkscale_confirm_delete = "Ukloniti ovaj zapis?", checkscale_close = "Zatvori",
    checkscale_total_records = "Ukupno zapisa:", checkscale_confirm_delete_message = "Jeste li sigurni da želite ukloniti ovaj zapis?",
    checkscale_cancel = "Odustani", checkscale_delete_confirm = "Ukloni",
}

return Locale.hr