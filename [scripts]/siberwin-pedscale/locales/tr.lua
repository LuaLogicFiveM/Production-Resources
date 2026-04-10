if not Locale then
    Locale = {}
end

Locale.tr = {
    current_scale = "Mevcut Boy",
    current_weight = "Mevcut Kilo",
    reset = "Sıfırla",
    apply = "Uygula",
    scale_size = "Boy Ölçeği",
    weight_size = "Kilo Ölçeği",
    adjust_character = "Karakterinizin boy ve kilo ölçeğini ayarlayın.",
    scale_applied = "Boy başarıyla uygulandı",
    weight_applied = "Kilo başarıyla uygulandı",
    scale_reset = "Karakter normale sıfırlandı",
    
    -- Info tips
    info_tip_1 = "Boyut oranı karakterinizin genel büyüklüğünü ve görünümünü etkiler.",
    info_tip_2 = "En iyi oyun deneyimi için önerilen aralıkta kalın.",
    info_tip_3 = "Hareket animasyonları sırasında boyutunuz geçici olarak ayarlanabilir.",
    info_tip_4 = "Boyut değişiklikleri araç girişi ve çıkışı animasyonlarını etkileyebilir.",
    
    -- Notifications
    notification_scale_applied_title = "Boyut Uygulandı",
    notification_scale_applied_message = "Boyut {scale} başarıyla uygulandı!",
    notification_scale_reset_title = "Boyut Sıfırlandı",
    notification_scale_reset_message = "Karakter boyutu normal boyuta sıfırlandı",
    notification_framework_title = "Ölçek Sistemi",
    notification_framework_loading = "Kaydedilen boyut yükleniyor: {scale}",
    notification_scale_system_title = "Boyut Sistemi",
    notification_model_changed = "Karakter modeli değişti, boyut yeniden uygulanıyor...",
    notification_periodic_title = "Periyodik Kontrol",
    notification_periodic_reapply = "Boyut yeniden uygulanıyor: {scale}",
    
    -- SetWeight command notifications
    notification_setweight_usage = "Kullanım: /setweight <değer> (örn: /setweight 0.9)",
    notification_setweight_invalid_number = "Geçersiz kilo değeri. Lütfen geçerli bir sayı girin.",
    notification_setweight_out_of_range = "Kilo {weight} aralık dışında. Geçerli aralık: {min} - {max}",
    notification_setweight_applied_title = "Kilo Ayarlandı",
    notification_setweight_applied = "Kilo komut ile {weight} olarak ayarlandı!",
    
    -- SetScale command notifications
    notification_error_title = "Hata",
    notification_setscale_usage = "Kullanım: /setscale <değer> (örn: /setscale 0.6)",
    notification_setscale_invalid_number = "Geçersiz boyut değeri. Lütfen geçerli bir sayı girin.",
    notification_setscale_out_of_range = "Boyut {scale} aralık dışında. Geçerli aralık: {min} - {max}",
    notification_setscale_applied_title = "Boyut Ayarlandı",
    notification_setscale_applied = "Boyut komut ile {scale} olarak ayarlandı!",
    
    -- Permission mesajları
    notification_permission_denied_title = "İzin Reddedildi",
    notification_permission_denied_message = "Bu scripti kullanma izniniz yok! Framework veya Discord rolü gerekli.",
    notification_discord_permission_denied = "Discord'da gerekli rolünüz yok!",
    notification_discord_not_connected = "Discord hesabınız sunucuya bağlı değil!",
    notification_discord_role_check_failed = "Discord rol kontrolü başarısız oldu!",
    
    -- GiveScaleMenu mesajları
    notification_givescale_usage = "Kullanım: /givescalemenu <oyuncu_id>",
    notification_givescale_player_not_found = "Oyuncu bulunamadı!",
    notification_givescale_success = "Oyuncu {playerName} ({playerId}) için scale menüsü açıldı",
    notification_givescale_permission_denied = "Bu komutu kullanma izniniz yok!",
    notification_givescale_menu_opened = "Size admin tarafından scale menüsü açıldı",
    
    -- CheckScale mesajları
    notification_checkscale_permission_denied = "Bu komutu kullanma izniniz yok!",
    notification_checkscale_no_records = "Veritabanında kayıt bulunamadı!",
    notification_checkscale_records_loaded = "{count} adet kayıt yüklendi",
    notification_checkscale_record_deleted = "Kayıt başarıyla silindi: {identifier}",
    notification_checkscale_delete_failed = "Kayıt silinirken hata oluştu!",
    checkscale_title = "Scale Kayıtları Yönetimi",
    checkscale_identifier = "Kimlik",
    checkscale_scale_value = "Scale Değeri",
    checkscale_updated_at = "Güncelleme Tarihi",
    checkscale_actions = "İşlemler",
    checkscale_delete = "Sil",
    checkscale_confirm_delete = "Bu kayıt silinsin mi?",
    checkscale_close = "Kapat",
    
    -- Yeni CheckScale anahtarları
    checkscale_total_records = "Toplam Kayıt:",
    checkscale_confirm_delete_message = "Bu kaydı silmek istediğinizden emin misiniz?",
    checkscale_cancel = "İptal",
    checkscale_delete_confirm = "Sil",
}

return Locale.tr