if not Locale then
    Locale = {}
end

Locale.cs = {
    current_scale = "Aktuální výška",
    current_weight = "Aktuální váha",
    reset = "Resetovat",
    apply = "Použít",
    scale_size = "Měřítko výšky",
    weight_size = "Měřítko váhy",
    adjust_character = "Upravte výšku a váhu vaší postavy.",
    scale_applied = "Výška byla úspěšně použita",
    weight_applied = "Váha byla úspěšně použita",
    scale_reset = "Postava byla resetována na normální velikost",
    
    info_tip_1 = "Poměr měřítka ovlivňuje celkovou velikost a vzhled vaší postavy.",
    info_tip_2 = "Zůstaňte v doporučeném rozsahu pro nejlepší herní zážitek.",
    info_tip_3 = "Během animací pohybu se vaše měřítko může dočasně upravit.",
    info_tip_4 = "Změny měřítka mohou ovlivnit animace vstupu a výstupu z vozidel.",
    
    notification_scale_applied_title = "Měřítko použito",
    notification_scale_applied_message = "Měřítko {scale} bylo úspěšně použito!",
    notification_scale_reset_title = "Měřítko resetováno",
    notification_scale_reset_message = "Měřítko postavy bylo resetováno na normální velikost",
    notification_framework_title = "Systém měřítka",
    notification_framework_loading = "Načítání uloženého měřítka: {scale}",
    notification_scale_system_title = "Systém měřítka",
    notification_model_changed = "Model postavy se změnil, znovu aplikuji měřítko...",
    notification_periodic_title = "Periodická kontrola",
    notification_periodic_reapply = "Znovu aplikuji měřítko: {scale}",
    
    notification_setweight_usage = "Použití: /setweight <hodnota> (např.: /setweight 0.9)",
    notification_setweight_invalid_number = "Neplatná hodnota váhy. Prosím zadejte platné číslo.",
    notification_setweight_out_of_range = "Váha {weight} je mimo rozsah. Platný rozsah: {min} - {max}",
    notification_setweight_applied_title = "Váha nastavena",
    notification_setweight_applied = "Váha nastavena na {weight} pomocí příkazu!",
    
    notification_error_title = "Chyba",
    notification_setscale_usage = "Použití: /setscale <hodnota> (např.: /setscale 0.6)",
    notification_setscale_invalid_number = "Neplatná hodnota měřítka. Prosím zadejte platné číslo.",
    notification_setscale_out_of_range = "Měřítko {scale} je mimo rozsah. Platný rozsah: {min} - {max}",
    notification_setscale_applied_title = "Měřítko nastaveno",
    notification_setscale_applied = "Měřítko nastaveno na {scale} pomocí příkazu!",
    
    notification_permission_denied_title = "Oprávnění zamítnuto",
    notification_permission_denied_message = "Nemáte oprávnění k použití tohoto skriptu! Vyžadován Framework nebo Discord role.",
    notification_discord_permission_denied = "Nemáte vyžadovanou Discord roli!",
    notification_discord_not_connected = "Váš Discord účet není připojen k serveru!",
    notification_discord_role_check_failed = "Kontrola Discord role se nezdařila!",
    
    notification_givescale_usage = "Použití: /givescalemenu <player_id>",
    notification_givescale_player_not_found = "Hráč nenalezen!",
    notification_givescale_success = "Menu měřítka otevřeno pro hráče {playerName} ({playerId})",
    notification_givescale_permission_denied = "Nemáte oprávnění k použití tohoto příkazu!",
    notification_givescale_menu_opened = "Menu měřítka bylo pro vás otevřeno administrátorem",
    
    notification_checkscale_permission_denied = "Nemáte oprávnění k použití tohoto příkazu!",
    notification_checkscale_no_records = "V databázi nebyly nalezeny žádné záznamy!",
    notification_checkscale_records_loaded = "Načteno {count} záznamů",
    notification_checkscale_record_deleted = "Záznam úspěšně smazán: {identifier}",
    notification_checkscale_delete_failed = "Při mazání záznamu došlo k chybě!",
    checkscale_title = "Správa záznamů měřítka",
    checkscale_identifier = "Identifikátor",
    checkscale_scale_value = "Hodnota měřítka",
    checkscale_updated_at = "Aktualizováno",
    checkscale_actions = "Akce",
    checkscale_delete = "Smazat",
    checkscale_confirm_delete = "Smazat tento záznam?",
    checkscale_close = "Zavřít",
    checkscale_total_records = "Celkem záznamů:",
    checkscale_confirm_delete_message = "Jste si jisti, že chcete smazat tento záznam?",
    checkscale_cancel = "Zrušit",
    checkscale_delete_confirm = "Smazat",
}

return Locale.cs