-- Hungarian language file  
if not Locale then Locale = {} end

Locale.hu = {
    current_scale = "Jelenlegi magasság", current_weight = "Jelenlegi súly", reset = "Visszaállítás", apply = "Alkalmazás",
    scale_size = "Magasság skála", weight_size = "Súly skála", adjust_character = "Állítsd be a karaktered magasságát és súlyát.",
    scale_applied = "Magasság sikeresen alkalmazva", weight_applied = "Súly sikeresen alkalmazva",
    scale_reset = "Karakter visszaállítva normál méretre",
    
    info_tip_1 = "A skála arány befolyásolja a karaktered általános méretét és megjelenését.",
    info_tip_2 = "Maradj az ajánlott tartományon belül a legjobb játékélményért.",
    info_tip_3 = "Mozgási animációk során a skálád ideiglenesen módosulhat.",
    info_tip_4 = "A skála változások befolyásolhatják a jármű be- és kiszállási animációkat.",
    
    notification_scale_applied_title = "Skála alkalmazva", notification_scale_applied_message = "Skála {scale} sikeresen alkalmazva!",
    notification_scale_reset_title = "Skála visszaállítva", notification_scale_reset_message = "Karakter skála visszaállítva normál méretre",
    notification_framework_title = "Skála rendszer", notification_framework_loading = "Mentett skála betöltése: {scale}",
    notification_scale_system_title = "Skála rendszer", notification_model_changed = "Karakter modell megváltozott, skála újra alkalmazása...",
    notification_periodic_title = "Időszakos ellenőrzés", notification_periodic_reapply = "Skála újra alkalmazása: {scale}",
    
    notification_setweight_usage = "Használat: /setweight <érték> (pl.: /setweight 0.9)",
    notification_setweight_invalid_number = "Érvénytelen súly érték. Kérlek adj meg egy érvényes számot.",
    notification_setweight_out_of_range = "Súly {weight} tartományon kívül. Érvényes tartomány: {min} - {max}",
    notification_setweight_applied_title = "Súly beállítva", notification_setweight_applied = "Súly beállítva {weight} értékre parancs által!",
    
    notification_error_title = "Hiba", notification_setscale_usage = "Használat: /setscale <érték> (pl.: /setscale 0.6)",
    notification_setscale_invalid_number = "Érvénytelen skála érték. Kérlek adj meg egy érvényes számot.",
    notification_setscale_out_of_range = "Skála {scale} tartományon kívül. Érvényes tartomány: {min} - {max}",
    notification_setscale_applied_title = "Skála beállítva", notification_setscale_applied = "Skála beállítva {scale} értékre parancs által!",
    
    notification_permission_denied_title = "Engedély megtagadva", notification_permission_denied_message = "Nincs engedélyed ennek a scriptnek a használatára! Framework vagy Discord szerep szükséges.",
    notification_discord_permission_denied = "Nincs meg a szükséges Discord szereped!",
    notification_discord_not_connected = "A Discord fiókod nincs csatlakoztatva a szerverhez!",
    notification_discord_role_check_failed = "Discord szerep ellenőrzés sikertelen!",
    notification_givescale_usage = "Használat: /givescalemenu <player_id>", notification_givescale_player_not_found = "Játékos nem található!",
    notification_givescale_success = "Skála menü megnyitva {playerName} ({playerId}) játékos számára",
    notification_givescale_permission_denied = "Nincs engedélyed ennek a parancsnak a használatára!",
    notification_givescale_menu_opened = "A skála menüt egy adminisztrátor megnyitotta számodra",
    
    notification_checkscale_permission_denied = "Nincs engedélyed ennek a parancsnak a használatára!",
    notification_checkscale_no_records = "Nincsenek rekordok az adatbázisban!",
    notification_checkscale_records_loaded = "{count} rekord betöltve",
    notification_checkscale_record_deleted = "Rekord sikeresen törölve: {identifier}",
    notification_checkscale_delete_failed = "Hiba történt a rekord törlése során!",
    checkscale_title = "Skála rekordok kezelése", checkscale_identifier = "Azonosító",
    checkscale_scale_value = "Skála érték", checkscale_updated_at = "Frissítve", checkscale_actions = "Műveletek",
    checkscale_delete = "Törlés", checkscale_confirm_delete = "Törölni ezt a rekordot?", checkscale_close = "Bezárás",
    checkscale_total_records = "Összes rekord:", checkscale_confirm_delete_message = "Biztos vagy benne, hogy törölni akarod ezt a rekordot?",
    checkscale_cancel = "Mégse", checkscale_delete_confirm = "Törlés",
}

return Locale.hu