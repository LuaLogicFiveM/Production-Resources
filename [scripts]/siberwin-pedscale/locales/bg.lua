if not Locale then
    Locale = {}
end

Locale.bg = {
    current_scale = "Текущ ръст",
    current_weight = "Текущо тегло",
    reset = "Нулиране",
    apply = "Приложи",
    scale_size = "Мащаб на ръста",
    weight_size = "Мащаб на теглото",
    adjust_character = "Настройте ръста и теглото на вашия герой.",
    scale_applied = "Ръстът е приложен успешно",
    weight_applied = "Теглото е приложено успешно",
    scale_reset = "Героят е нулиран до нормален размер",
    
    info_tip_1 = "Съотношението на мащаба влияе на общия размер и външен вид на вашия герой.",
    info_tip_2 = "Оставайте в препоръчания диапазон за най-добро игрово изживяване.",
    info_tip_3 = "По време на анимации за движение, вашият мащаб може временно да се настрои.",
    info_tip_4 = "Промените в мащаба могат да повлияят на анимациите за влизане и излизане от превозни средства.",
    
    notification_scale_applied_title = "Мащабът е приложен",
    notification_scale_applied_message = "Мащабът {scale} е приложен успешно!",
    notification_scale_reset_title = "Мащабът е нулиран",
    notification_scale_reset_message = "Мащабът на героя е нулиран до нормален размер",
    notification_framework_title = "Система за мащаб",
    notification_framework_loading = "Зареждане на запазен мащаб: {scale}",
    notification_scale_system_title = "Система за мащаб",
    notification_model_changed = "Моделът на героя се промени, повторно прилагане на мащаба...",
    notification_periodic_title = "Периодична проверка",
    notification_periodic_reapply = "Повторно прилагане на мащаба: {scale}",
    
    notification_setweight_usage = "Употреба: /setweight <стойност> (напр.: /setweight 0.9)",
    notification_setweight_invalid_number = "Невалидна стойност на теглото. Моля, въведете валидно число.",
    notification_setweight_out_of_range = "Теглото {weight} е извън диапазона. Валиден диапазон: {min} - {max}",
    notification_setweight_applied_title = "Теглото е зададено",
    notification_setweight_applied = "Теглото е зададено на {weight} чрез команда!",
    
    notification_error_title = "Грешка",
    notification_setscale_usage = "Употреба: /setscale <стойност> (напр.: /setscale 0.6)",
    notification_setscale_invalid_number = "Невалидна стойност на мащаба. Моля, въведете валидно число.",
    notification_setscale_out_of_range = "Мащабът {scale} е извън диапазона. Валиден диапазон: {min} - {max}",
    notification_setscale_applied_title = "Мащабът е зададен",
    notification_setscale_applied = "Мащабът е зададен на {scale} чрез команда!",
    
    notification_permission_denied_title = "Разрешението е отказано",
    notification_permission_denied_message = "Нямате разрешение да използвате този скрипт! Нуждае се от Framework или роля на Discord.",
    notification_discord_permission_denied = "Нямате необходимата роля на Discord!",
    notification_discord_not_connected = "Вашият акаунт в Discord не е свързан с сървъра!",
    notification_discord_role_check_failed = "Проверката на ролята в Discord не успя!",
    
    notification_givescale_usage = "Употреба: /givescalemenu <player_id>",
    notification_givescale_player_not_found = "Играчът не е намерен!",
    notification_givescale_success = "Менюто за мащаб е отворено за играч {playerName} ({playerId})",
    notification_givescale_permission_denied = "Нямате разрешение да използвате тази команда!",
    notification_givescale_menu_opened = "Менюто за мащаб е отворено за вас от администратор",
    
    notification_checkscale_permission_denied = "Нямате разрешение да използвате тази команда!",
    notification_checkscale_no_records = "Няма намерени записи в базата данни!",
    notification_checkscale_records_loaded = "{count} записа са заредени",
    notification_checkscale_record_deleted = "Записът е изтрит успешно: {identifier}",
    notification_checkscale_delete_failed = "Възникна грешка при изтриване на записа!",
    checkscale_title = "Управление на записи за мащаб",
    checkscale_identifier = "Идентификатор",
    checkscale_scale_value = "Стойност на мащаба",
    checkscale_updated_at = "Актуализиран на",
    checkscale_actions = "Действия",
    checkscale_delete = "Изтрий",
    checkscale_confirm_delete = "Изтрий този запис?",
    checkscale_close = "Затвори",
    checkscale_total_records = "Общо записи:",
    checkscale_confirm_delete_message = "Сигурни ли сте, че искате да изтриете този запис?",
    checkscale_cancel = "Отказ",
    checkscale_delete_confirm = "Изтрий",
}

return Locale.bg