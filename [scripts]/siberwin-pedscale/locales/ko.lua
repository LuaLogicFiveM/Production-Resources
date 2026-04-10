-- Korean language file
if not Locale then Locale = {} end

Locale.ko = {
    current_scale = "현재 키", current_weight = "현재 체중", reset = "리셋", apply = "적용",
    scale_size = "키 스케일", weight_size = "체중 스케일", adjust_character = "캐릭터의 키와 체중을 조정하세요.",
    scale_applied = "키가 성공적으로 적용되었습니다", weight_applied = "체중이 성공적으로 적용되었습니다", scale_reset = "캐릭터가 정상 크기로 리셋되었습니다",
    
    info_tip_1 = "스케일 비율은 캐릭터의 전체적인 크기와 외관에 영향을 미칩니다.",
    info_tip_2 = "최상의 게임 경험을 위해 권장 범위 내에 머물러 주세요.",
    info_tip_3 = "움직임 애니메이션 중에는 스케일이 일시적으로 조정될 수 있습니다.",
    info_tip_4 = "스케일 변경은 차량 승하차 애니메이션에 영향을 줄 수 있습니다.",
    
    notification_scale_applied_title = "스케일 적용됨", notification_scale_applied_message = "스케일 {scale}이 성공적으로 적용되었습니다!",
    notification_scale_reset_title = "스케일 리셋됨", notification_scale_reset_message = "캐릭터 스케일이 정상 크기로 리셋되었습니다",
    notification_framework_title = "스케일 시스템", notification_framework_loading = "저장된 스케일 로딩 중: {scale}",
    notification_scale_system_title = "스케일 시스템", notification_model_changed = "캐릭터 모델이 변경됨, 스케일 재적용 중...",
    notification_periodic_title = "주기적 확인", notification_periodic_reapply = "스케일 재적용 중: {scale}",
    
    notification_setweight_usage = "사용법: /setweight <값> (예: /setweight 0.9)",
    notification_setweight_invalid_number = "잘못된 체중 값입니다. 유효한 숫자를 입력해주세요.",
    notification_setweight_out_of_range = "체중 {weight}이 범위를 벗어났습니다. 유효 범위: {min} - {max}",
    notification_setweight_applied_title = "체중 설정됨", notification_setweight_applied = "명령어를 통해 체중이 {weight}로 설정되었습니다!",
    
    notification_error_title = "오류", notification_setscale_usage = "사용법: /setscale <값> (예: /setscale 0.6)",
    notification_setscale_invalid_number = "잘못된 스케일 값입니다. 유효한 숫자를 입력해주세요.",
    notification_setscale_out_of_range = "스케일 {scale}이 범위를 벗어났습니다. 유효 범위: {min} - {max}",
    notification_setscale_applied_title = "스케일 설정됨", notification_setscale_applied = "명령어를 통해 스케일이 {scale}로 설정되었습니다!",
    
    notification_permission_denied_title = "권한 거부됨", notification_permission_denied_message = "이 스크립트를 사용할 권한이 없습니다! Framework 또는 Discord 역할이 필요합니다.",
    notification_discord_permission_denied = "필요한 Discord 역할이 없습니다!",
    notification_discord_not_connected = "Discord 계정이 서버에 연결되어 있지 않습니다!",
    notification_discord_role_check_failed = "Discord 역할 확인에 실패했습니다!",
    notification_givescale_usage = "사용법: /givescalemenu <player_id>", notification_givescale_player_not_found = "플레이어를 찾을 수 없습니다!",
    notification_givescale_success = "플레이어 {playerName} ({playerId})에게 스케일 메뉴가 열렸습니다",
    notification_givescale_permission_denied = "이 명령어를 사용할 권한이 없습니다!",
    notification_givescale_menu_opened = "관리자에 의해 스케일 메뉴가 열렸습니다",
    
    notification_checkscale_permission_denied = "이 명령어를 사용할 권한이 없습니다!",
    notification_checkscale_no_records = "데이터베이스에서 레코드를 찾을 수 없습니다!",
    notification_checkscale_records_loaded = "{count}개의 레코드가 로드되었습니다",
    notification_checkscale_record_deleted = "레코드가 성공적으로 삭제되었습니다: {identifier}",
    notification_checkscale_delete_failed = "레코드 삭제 중 오류가 발생했습니다!",
    checkscale_title = "스케일 레코드 관리", checkscale_identifier = "식별자",
    checkscale_scale_value = "스케일 값", checkscale_updated_at = "업데이트됨", checkscale_actions = "작업",
    checkscale_delete = "삭제", checkscale_confirm_delete = "이 레코드를 삭제하시겠습니까?", checkscale_close = "닫기",
    checkscale_total_records = "총 레코드:", checkscale_confirm_delete_message = "정말로 이 레코드를 삭제하시겠습니까?",
    checkscale_cancel = "취소", checkscale_delete_confirm = "삭제",
}

return Locale.ko