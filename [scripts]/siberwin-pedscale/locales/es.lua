if not Locale then
    Locale = {}
end

Locale.es = {
    current_scale = "Altura actual",
    current_weight = "Peso actual",
    reset = "Restablecer",
    apply = "Aplicar",
    scale_size = "Escala de altura",
    weight_size = "Escala de peso",
    adjust_character = "Ajusta la altura y peso de tu personaje.",
    scale_applied = "Altura aplicada exitosamente",
    weight_applied = "Peso aplicado exitosamente",
    scale_reset = "Personaje restablecido a tamaño normal",
    
    info_tip_1 = "La proporción de escala afecta el tamaño general y la apariencia de tu personaje.",
    info_tip_2 = "Mantente dentro del rango recomendado para la mejor experiencia de juego.",
    info_tip_3 = "Durante las animaciones de movimiento, tu escala puede ajustarse temporalmente.",
    info_tip_4 = "Los cambios de escala pueden afectar las animaciones de entrada y salida de vehículos.",
    
    notification_scale_applied_title = "Escala aplicada",
    notification_scale_applied_message = "¡Escala {scale} aplicada exitosamente!",
    notification_scale_reset_title = "Escala restablecida",
    notification_scale_reset_message = "Escala del personaje restablecida a tamaño normal",
    notification_framework_title = "Sistema de escala",
    notification_framework_loading = "Cargando escala guardada: {scale}",
    notification_scale_system_title = "Sistema de escala",
    notification_model_changed = "Modelo del personaje cambiado, reaplicando escala...",
    notification_periodic_title = "Verificación periódica",
    notification_periodic_reapply = "Reaplicando escala: {scale}",
    
    notification_setweight_usage = "Uso: /setweight <valor> (ej.: /setweight 0.9)",
    notification_setweight_invalid_number = "Valor de peso inválido. Por favor ingresa un número válido.",
    notification_setweight_out_of_range = "El peso {weight} está fuera de rango. Rango válido: {min} - {max}",
    notification_setweight_applied_title = "Peso establecido",
    notification_setweight_applied = "¡Peso establecido a {weight} mediante comando!",
    
    notification_error_title = "Error",
    notification_setscale_usage = "Uso: /setscale <valor> (ej.: /setscale 0.6)",
    notification_setscale_invalid_number = "Valor de escala inválido. Por favor ingresa un número válido.",
    notification_setscale_out_of_range = "La escala {scale} está fuera de rango. Rango válido: {min} - {max}",
    notification_setscale_applied_title = "Escala establecida",
    notification_setscale_applied = "¡Escala establecida a {scale} mediante comando!",
    
    notification_permission_denied_title = "Permiso denegado",
    notification_permission_denied_message = "¡No tienes permiso para usar este script! Se requiere Framework o rol de Discord.",
    notification_discord_permission_denied = "¡No tienes el rol de Discord requerido!",
    notification_discord_not_connected = "¡Tu cuenta de Discord no está conectada al servidor!",
    notification_discord_role_check_failed = "¡Falló la verificación del rol de Discord!",
    
    notification_givescale_usage = "Uso: /givescalemenu <player_id>",
    notification_givescale_player_not_found = "¡Jugador no encontrado!",
    notification_givescale_success = "Menú de escala abierto para el jugador {playerName} ({playerId})",
    notification_givescale_permission_denied = "¡No tienes permiso para usar este comando!",
    notification_givescale_menu_opened = "El menú de escala ha sido abierto para ti por un administrador",
    
    notification_checkscale_permission_denied = "¡No tienes permiso para usar este comando!",
    notification_checkscale_no_records = "¡No se encontraron registros en la base de datos!",
    notification_checkscale_records_loaded = "{count} registros cargados",
    notification_checkscale_record_deleted = "Registro eliminado exitosamente: {identifier}",
    notification_checkscale_delete_failed = "¡Error al eliminar el registro!",
    checkscale_title = "Gestión de registros de escala",
    checkscale_identifier = "Identificador",
    checkscale_scale_value = "Valor de escala",
    checkscale_updated_at = "Actualizado en",
    checkscale_actions = "Acciones",
    checkscale_delete = "Eliminar",
    checkscale_confirm_delete = "¿Eliminar este registro?",
    checkscale_close = "Cerrar",
    checkscale_total_records = "Total de registros:",
    checkscale_confirm_delete_message = "¿Estás seguro de que quieres eliminar este registro?",
    checkscale_cancel = "Cancelar",
    checkscale_delete_confirm = "Eliminar",
}

return Locale.es