-- Russian language file
if not Locale then Locale = {} end

Locale.ru = {
    current_scale = "Текущий рост", current_weight = "Текущий вес", reset = "Сброс", apply = "Применить",
    scale_size = "Масштаб роста", weight_size = "Масштаб веса", adjust_character = "Настройте рост и вес вашего персонажа.",
    scale_applied = "Рост успешно применён", weight_applied = "Вес успешно применён", scale_reset = "Персонаж сброшен до нормального размера",
    
    info_tip_1 = "Соотношение масштаба влияет на общий размер и внешний вид вашего персонажа.",
    info_tip_2 = "Оставайтесь в рекомендуемом диапазоне для лучшего игрового опыта.",
    info_tip_3 = "Во время анимаций движения ваш масштаб может временно настраиваться.",
    info_tip_4 = "Изменения масштаба могут повлиять на анимации входа и выхода из транспорта.",
    
    notification_scale_applied_title = "Масштаб применён", notification_scale_applied_message = "Масштаб {scale} успешно применён!",
    notification_scale_reset_title = "Масштаб сброшен", notification_scale_reset_message = "Масштаб персонажа сброшен до нормального размера",
    notification_framework_title = "Система масштаба", notification_framework_loading = "Загрузка сохранённого масштаба: {scale}",
    notification_scale_system_title = "Система масштаба", notification_model_changed = "Модель персонажа изменена, повторное применение масштаба...",
    notification_periodic_title = "Периодическая проверка", notification_periodic_reapply = "Повторное применение масштаба: {scale}",
    
    notification_setweight_usage = "Использование: /setweight <значение> (например: /setweight 0.9)",
    notification_setweight_invalid_number = "Неверное значение веса. Пожалуйста, введите корректное число.",
    notification_setweight_out_of_range = "Вес {weight} вне диапазона. Допустимый диапазон: {min} - {max}",
    notification_setweight_applied_title = "Вес установлен", notification_setweight_applied = "Вес установлен на {weight} через команду!",
    
    notification_error_title = "Ошибка", notification_setscale_usage = "Использование: /setscale <значение> (например: /setscale 0.6)",
    notification_setscale_invalid_number = "Неверное значение масштаба. Пожалуйста, введите корректное число.",
    notification_setscale_out_of_range = "Масштаб {scale} вне диапазона. Допустимый диапазон: {min} - {max}",
    notification_setscale_applied_title = "Масштаб установлен", notification_setscale_applied = "Масштаб установлен на {scale} через команду!",
    
    notification_permission_denied_title = "Доступ запрещён", notification_permission_denied_message = "У вас нет разрешения на использование этого скрипта! Требуется Framework или роль Discord.",
    notification_discord_permission_denied = "У вас нет требуемой роли Discord!",
    notification_discord_not_connected = "Ваш аккаунт Discord не подключён к серверу!",
    notification_discord_role_check_failed = "Проверка роли Discord не удалась!",
    notification_givescale_usage = "Использование: /givescalemenu <player_id>", notification_givescale_player_not_found = "Игрок не найден!",
    notification_givescale_success = "Меню масштаба открыто для игрока {playerName} ({playerId})",
    notification_givescale_permission_denied = "У вас нет разрешения на использование этой команды!",
    notification_givescale_menu_opened = "Меню масштаба было открыто для вас администратором",
    
    notification_checkscale_permission_denied = "У вас нет разрешения на использование этой команды!",
    notification_checkscale_no_records = "В базе данных не найдено записей!",
    notification_checkscale_records_loaded = "Загружено {count} записей",
    notification_checkscale_record_deleted = "Запись успешно удалена: {identifier}",
    notification_checkscale_delete_failed = "Произошла ошибка при удалении записи!",
    checkscale_title = "Управление записями масштаба", checkscale_identifier = "Идентификатор",
    checkscale_scale_value = "Значение масштаба", checkscale_updated_at = "Обновлено", checkscale_actions = "Действия",
    checkscale_delete = "Удалить", checkscale_confirm_delete = "Удалить эту запись?", checkscale_close = "Закрыть",
    checkscale_total_records = "Всего записей:", checkscale_confirm_delete_message = "Вы уверены, что хотите удалить эту запись?",
    checkscale_cancel = "Отмена", checkscale_delete_confirm = "Удалить",
}

return Locale.ru