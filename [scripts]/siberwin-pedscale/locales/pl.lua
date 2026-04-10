-- Polish language file
if not Locale then Locale = {} end

Locale.pl = {
    current_scale = "Obecny wzrost", current_weight = "Obecna waga", reset = "Resetuj", apply = "Zastosuj",
    scale_size = "Skala wzrostu", weight_size = "Skala wagi", adjust_character = "Dostosuj wzrost i wagę swojej postaci.",
    scale_applied = "Wzrost został pomyślnie zastosowany", weight_applied = "Waga została pomyślnie zastosowana",
    scale_reset = "Postać została zresetowana do normalnego rozmiaru",
    
    info_tip_1 = "Współczynnik skali wpływa na ogólny rozmiar i wygląd twojej postaci.",
    info_tip_2 = "Pozostań w zalecanym zakresie dla najlepszego doświadczenia w grze.",
    info_tip_3 = "Podczas animacji ruchu, twoja skala może zostać tymczasowo dostosowana.",
    info_tip_4 = "Zmiany skali mogą wpłynąć na animacje wchodzenia i wychodzenia z pojazdów.",
    
    notification_scale_applied_title = "Skala zastosowana", notification_scale_applied_message = "Skala {scale} została pomyślnie zastosowana!",
    notification_scale_reset_title = "Skala zresetowana", notification_scale_reset_message = "Skala postaci została zresetowana do normalnego rozmiaru",
    notification_framework_title = "System skali", notification_framework_loading = "Ładowanie zapisanej skali: {scale}",
    notification_scale_system_title = "System skali", notification_model_changed = "Model postaci został zmieniony, ponowne stosowanie skali...",
    notification_periodic_title = "Kontrola okresowa", notification_periodic_reapply = "Ponowne stosowanie skali: {scale}",
    
    notification_setweight_usage = "Użycie: /setweight <wartość> (np.: /setweight 0.9)",
    notification_setweight_invalid_number = "Nieprawidłowa wartość wagi. Proszę wprowadzić prawidłową liczbę.",
    notification_setweight_out_of_range = "Waga {weight} jest poza zakresem. Prawidłowy zakres: {min} - {max}",
    notification_setweight_applied_title = "Waga ustawiona", notification_setweight_applied = "Waga ustawiona na {weight} za pomocą komendy!",
    
    notification_error_title = "Błąd", notification_setscale_usage = "Użycie: /setscale <wartość> (np.: /setscale 0.6)",
    notification_setscale_invalid_number = "Nieprawidłowa wartość skali. Proszę wprowadzić prawidłową liczbę.",
    notification_setscale_out_of_range = "Skala {scale} jest poza zakresem. Prawidłowy zakres: {min} - {max}",
    notification_setscale_applied_title = "Skala ustawiona", notification_setscale_applied = "Skala ustawiona na {scale} za pomocą komendy!",
    
    notification_permission_denied_title = "Odmowa dostępu", notification_permission_denied_message = "Nie masz uprawnień do używania tego skryptu! Wymagany Framework lub rola Discord.",
    notification_discord_permission_denied = "Nie masz wymaganej roli Discord!",
    notification_discord_not_connected = "Twoje konto Discord nie jest podłączone do serwera!",
    notification_discord_role_check_failed = "Sprawdzenie roli Discord nie powiodło się!",
    notification_givescale_usage = "Użycie: /givescalemenu <player_id>", notification_givescale_player_not_found = "Gracz nie został znaleziony!",
    notification_givescale_success = "Menu skali otwarte dla gracza {playerName} ({playerId})",
    notification_givescale_permission_denied = "Nie masz uprawnień do używania tej komendy!",
    notification_givescale_menu_opened = "Menu skali zostało otwarte dla ciebie przez administratora",
    
    notification_checkscale_permission_denied = "Nie masz uprawnień do używania tej komendy!",
    notification_checkscale_no_records = "Nie znaleziono rekordów w bazie danych!",
    notification_checkscale_records_loaded = "Załadowano {count} rekordów",
    notification_checkscale_record_deleted = "Rekord został pomyślnie usunięty: {identifier}",
    notification_checkscale_delete_failed = "Wystąpił błąd podczas usuwania rekordu!",
    checkscale_title = "Zarządzanie rekordami skali", checkscale_identifier = "Identyfikator",
    checkscale_scale_value = "Wartość skali", checkscale_updated_at = "Zaktualizowano", checkscale_actions = "Akcje",
    checkscale_delete = "Usuń", checkscale_confirm_delete = "Usunąć ten rekord?", checkscale_close = "Zamknij",
    checkscale_total_records = "Łączna liczba rekordów:", checkscale_confirm_delete_message = "Czy na pewno chcesz usunąć ten rekord?",
    checkscale_cancel = "Anuluj", checkscale_delete_confirm = "Usuń",
}

return Locale.pl