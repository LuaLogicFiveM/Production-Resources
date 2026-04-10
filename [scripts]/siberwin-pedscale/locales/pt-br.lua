-- Portuguese Brazilian language file
if not Locale then Locale = {} end

Locale["pt-br"] = {
    current_scale = "Altura atual", current_weight = "Peso atual", reset = "Resetar", apply = "Aplicar",
    scale_size = "Escala de altura", weight_size = "Escala de peso", adjust_character = "Ajuste a altura e peso do seu personagem.",
    scale_applied = "Altura aplicada com sucesso", weight_applied = "Peso aplicado com sucesso", scale_reset = "Personagem resetado para tamanho normal",
    
    info_tip_1 = "A proporção da escala afeta o tamanho geral e a aparência do seu personagem.",
    info_tip_2 = "Permaneça dentro da faixa recomendada para a melhor experiência de jogo.",
    info_tip_3 = "Durante animações de movimento, sua escala pode se ajustar temporariamente.",
    info_tip_4 = "Mudanças na escala podem afetar as animações de entrada e saída de veículos.",
    
    notification_scale_applied_title = "Escala aplicada", notification_scale_applied_message = "Escala {scale} aplicada com sucesso!",
    notification_scale_reset_title = "Escala resetada", notification_scale_reset_message = "Escala do personagem resetada para tamanho normal",
    notification_framework_title = "Sistema de escala", notification_framework_loading = "Carregando escala salva: {scale}",
    notification_scale_system_title = "Sistema de escala", notification_model_changed = "Modelo do personagem mudou, reaplicando escala...",
    notification_periodic_title = "Verificação periódica", notification_periodic_reapply = "Reaplicando escala: {scale}",
    
    notification_setweight_usage = "Uso: /setweight <valor> (ex.: /setweight 0.9)",
    notification_setweight_invalid_number = "Valor de peso inválido. Por favor insira um número válido.",
    notification_setweight_out_of_range = "Peso {weight} fora da faixa. Faixa válida: {min} - {max}",
    notification_setweight_applied_title = "Peso definido", notification_setweight_applied = "Peso definido para {weight} via comando!",
    
    notification_error_title = "Erro", notification_setscale_usage = "Uso: /setscale <valor> (ex.: /setscale 0.6)",
    notification_setscale_invalid_number = "Valor de escala inválido. Por favor insira um número válido.",
    notification_setscale_out_of_range = "Escala {scale} fora da faixa. Faixa válida: {min} - {max}",
    notification_setscale_applied_title = "Escala definida", notification_setscale_applied = "Escala definida para {scale} via comando!",
    
    notification_permission_denied_title = "Permissão negada", notification_permission_denied_message = "Você não tem permissão para usar este script! Framework ou papel do Discord necessário.",
    notification_discord_permission_denied = "Você não tem o papel do Discord necessário!",
    notification_discord_not_connected = "Sua conta do Discord não está conectada ao servidor!",
    notification_discord_role_check_failed = "Verificação do papel do Discord falhou!",
    notification_givescale_usage = "Uso: /givescalemenu <player_id>", notification_givescale_player_not_found = "Jogador não encontrado!",
    notification_givescale_success = "Menu de escala aberto para o jogador {playerName} ({playerId})",
    notification_givescale_permission_denied = "Você não tem permissão para usar este comando!",
    notification_givescale_menu_opened = "O menu de escala foi aberto para você por um administrador",
    
    notification_checkscale_permission_denied = "Você não tem permissão para usar este comando!",
    notification_checkscale_no_records = "Nenhum registro encontrado no banco de dados!",
    notification_checkscale_records_loaded = "{count} registros carregados",
    notification_checkscale_record_deleted = "Registro deletado com sucesso: {identifier}",
    notification_checkscale_delete_failed = "Erro ao deletar registro!",
    checkscale_title = "Gerenciamento de registros de escala", checkscale_identifier = "Identificador",
    checkscale_scale_value = "Valor da escala", checkscale_updated_at = "Atualizado em", checkscale_actions = "Ações",
    checkscale_delete = "Deletar", checkscale_confirm_delete = "Deletar este registro?", checkscale_close = "Fechar",
    checkscale_total_records = "Total de registros:", checkscale_confirm_delete_message = "Tem certeza que deseja deletar este registro?",
    checkscale_cancel = "Cancelar", checkscale_delete_confirm = "Deletar",
}

return Locale["pt-br"]