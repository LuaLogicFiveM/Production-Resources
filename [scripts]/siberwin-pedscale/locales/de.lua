if not Locale then
    Locale = {}
end

Locale.de = {
    current_scale = "Aktuelle Größe",
    current_weight = "Aktuelles Gewicht",
    reset = "Zurücksetzen",
    apply = "Anwenden",
    scale_size = "Größenskala",
    weight_size = "Gewichtsskala",
    adjust_character = "Passen Sie die Größe und das Gewicht Ihres Charakters an.",
    scale_applied = "Größe erfolgreich angewendet",
    weight_applied = "Gewicht erfolgreich angewendet",
    scale_reset = "Charakter auf normale Größe zurückgesetzt",
    
    info_tip_1 = "Das Skalenverhältnis beeinflusst die Gesamtgröße und das Aussehen Ihres Charakters.",
    info_tip_2 = "Bleiben Sie im empfohlenen Bereich für die beste Spielerfahrung.",
    info_tip_3 = "Während Bewegungsanimationen kann sich Ihre Skala vorübergehend anpassen.",
    info_tip_4 = "Skalenänderungen können die Ein- und Ausstiegsanimationen von Fahrzeugen beeinflussen.",
    
    notification_scale_applied_title = "Skala angewendet",
    notification_scale_applied_message = "Skala {scale} erfolgreich angewendet!",
    notification_scale_reset_title = "Skala zurückgesetzt",
    notification_scale_reset_message = "Charakterskala auf normale Größe zurückgesetzt",
    notification_framework_title = "Skalensystem",
    notification_framework_loading = "Gespeicherte Skala wird geladen: {scale}",
    notification_scale_system_title = "Skalensystem",
    notification_model_changed = "Charaktermodell geändert, Skala wird erneut angewendet...",
    notification_periodic_title = "Periodische Überprüfung",
    notification_periodic_reapply = "Skala wird erneut angewendet: {scale}",
    
    notification_setweight_usage = "Verwendung: /setweight <Wert> (z.B.: /setweight 0.9)",
    notification_setweight_invalid_number = "Ungültiger Gewichtswert. Bitte geben Sie eine gültige Zahl ein.",
    notification_setweight_out_of_range = "Gewicht {weight} liegt außerhalb des Bereichs. Gültiger Bereich: {min} - {max}",
    notification_setweight_applied_title = "Gewicht gesetzt",
    notification_setweight_applied = "Gewicht über Befehl auf {weight} gesetzt!",
    
    notification_error_title = "Fehler",
    notification_setscale_usage = "Verwendung: /setscale <Wert> (z.B.: /setscale 0.6)",
    notification_setscale_invalid_number = "Ungültiger Skalenwert. Bitte geben Sie eine gültige Zahl ein.",
    notification_setscale_out_of_range = "Skala {scale} liegt außerhalb des Bereichs. Gültiger Bereich: {min} - {max}",
    notification_setscale_applied_title = "Skala gesetzt",
    notification_setscale_applied = "Skala über Befehl auf {scale} gesetzt!",
    
    notification_permission_denied_title = "Berechtigung verweigert",
    notification_permission_denied_message = "Sie haben keine Berechtigung, dieses Skript zu verwenden! Framework oder Discord-Rolle erforderlich.",
    notification_discord_permission_denied = "Sie haben nicht die erforderliche Discord-Rolle!",
    notification_discord_not_connected = "Ihr Discord-Konto ist nicht mit dem Server verbunden!",
    notification_discord_role_check_failed = "Discord-Rollenprüfung fehlgeschlagen!",
    
    notification_givescale_usage = "Verwendung: /givescalemenu <player_id>",
    notification_givescale_player_not_found = "Spieler nicht gefunden!",
    notification_givescale_success = "Skalenmenü für Spieler {playerName} ({playerId}) geöffnet",
    notification_givescale_permission_denied = "Sie haben keine Berechtigung, diesen Befehl zu verwenden!",
    notification_givescale_menu_opened = "Das Skalenmenü wurde von einem Administrator für Sie geöffnet",
    
    notification_checkscale_permission_denied = "Sie haben keine Berechtigung, diesen Befehl zu verwenden!",
    notification_checkscale_no_records = "Keine Datensätze in der Datenbank gefunden!",
    notification_checkscale_records_loaded = "{count} Datensätze geladen",
    notification_checkscale_record_deleted = "Datensatz erfolgreich gelöscht: {identifier}",
    notification_checkscale_delete_failed = "Beim Löschen des Datensatzes ist ein Fehler aufgetreten!",
    checkscale_title = "Skalendatensätze-Verwaltung",
    checkscale_identifier = "Identifikator",
    checkscale_scale_value = "Skalenwert",
    checkscale_updated_at = "Aktualisiert am",
    checkscale_actions = "Aktionen",
    checkscale_delete = "Löschen",
    checkscale_confirm_delete = "Diesen Datensatz löschen?",
    checkscale_close = "Schließen",
    checkscale_total_records = "Gesamte Datensätze:",
    checkscale_confirm_delete_message = "Sind Sie sicher, dass Sie diesen Datensatz löschen möchten?",
    checkscale_cancel = "Abbrechen",
    checkscale_delete_confirm = "Löschen",
}

return Locale.de