-- Japanese language file
if not Locale then Locale = {} end

Locale.ja = {
    current_scale = "現在の身長", current_weight = "現在の体重", reset = "リセット", apply = "適用",
    scale_size = "身長スケール", weight_size = "体重スケール", adjust_character = "キャラクターの身長と体重を調整します。",
    scale_applied = "身長が正常に適用されました", weight_applied = "体重が正常に適用されました", scale_reset = "キャラクターが通常サイズにリセットされました",
    
    info_tip_1 = "スケール比はキャラクターの全体的なサイズと外観に影響します。",
    info_tip_2 = "最高のゲーム体験のために推奨範囲内に留まってください。",
    info_tip_3 = "移動アニメーション中に、スケールが一時的に調整される場合があります。",
    info_tip_4 = "スケールの変更は車両の乗降アニメーションに影響する可能性があります。",
    
    notification_scale_applied_title = "スケールが適用されました", notification_scale_applied_message = "スケール {scale} が正常に適用されました！",
    notification_scale_reset_title = "スケールがリセットされました", notification_scale_reset_message = "キャラクタースケールが通常サイズにリセットされました",
    notification_framework_title = "スケールシステム", notification_framework_loading = "保存されたスケールを読み込み中: {scale}",
    notification_scale_system_title = "スケールシステム", notification_model_changed = "キャラクターモデルが変更されました。スケールを再適用中...",
    notification_periodic_title = "定期チェック", notification_periodic_reapply = "スケールを再適用中: {scale}",
    
    notification_setweight_usage = "使用法: /setweight <値> (例: /setweight 0.9)",
    notification_setweight_invalid_number = "無効な体重値です。有効な数値を入力してください。",
    notification_setweight_out_of_range = "体重 {weight} は範囲外です。有効範囲: {min} - {max}",
    notification_setweight_applied_title = "体重が設定されました", notification_setweight_applied = "コマンドにより体重が {weight} に設定されました！",
    
    notification_error_title = "エラー", notification_setscale_usage = "使用法: /setscale <値> (例: /setscale 0.6)",
    notification_setscale_invalid_number = "無効なスケール値です。有効な数値を入力してください。",
    notification_setscale_out_of_range = "スケール {scale} は範囲外です。有効範囲: {min} - {max}",
    notification_setscale_applied_title = "スケールが設定されました", notification_setscale_applied = "コマンドによりスケールが {scale} に設定されました！",
    
    notification_permission_denied_title = "権限が拒否されました", notification_permission_denied_message = "このスクリプトを使用する権限がありません！FrameworkまたはDiscordロールが必要です。",
    notification_discord_permission_denied = "必要なDiscordロールを持っていません！",
    notification_discord_not_connected = "DiscordアカウントがサーバーにConnection接続されていません！",
    notification_discord_role_check_failed = "Discordロールチェックが失敗しました！",
    notification_givescale_usage = "使用法: /givescalemenu <player_id>", notification_givescale_player_not_found = "プレイヤーが見つかりません！",
    notification_givescale_success = "プレイヤー {playerName} ({playerId}) のスケールメニューが開かれました",
    notification_givescale_permission_denied = "このコマンドを使用する権限がありません！",
    notification_givescale_menu_opened = "管理者によってスケールメニューが開かれました",
    
    notification_checkscale_permission_denied = "このコマンドを使用する権限がありません！",
    notification_checkscale_no_records = "データベースにレコードが見つかりません！",
    notification_checkscale_records_loaded = "{count} 件のレコードが読み込まれました",
    notification_checkscale_record_deleted = "レコードが正常に削除されました: {identifier}",
    notification_checkscale_delete_failed = "レコードの削除中にエラーが発生しました！",
    checkscale_title = "スケールレコード管理", checkscale_identifier = "識別子",
    checkscale_scale_value = "スケール値", checkscale_updated_at = "更新日時", checkscale_actions = "アクション",
    checkscale_delete = "削除", checkscale_confirm_delete = "このレコードを削除しますか？", checkscale_close = "閉じる",
    checkscale_total_records = "総レコード数:", checkscale_confirm_delete_message = "このレコードを削除してもよろしいですか？",
    checkscale_cancel = "キャンセル", checkscale_delete_confirm = "削除",
}

return Locale.ja