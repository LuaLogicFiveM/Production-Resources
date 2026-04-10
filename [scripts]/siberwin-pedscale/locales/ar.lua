if not Locale then
    Locale = {}
end

Locale.ar = {
    current_scale = "الارتفاع الحالي",
    current_weight = "الوزن الحالي",
    reset = "إعادة تعيين",
    apply = "تطبيق",
    scale_size = "مقياس الارتفاع",
    weight_size = "مقياس الوزن",
    adjust_character = "اضبط ارتفاع ووزن شخصيتك.",
    scale_applied = "تم تطبيق الارتفاع بنجاح",
    weight_applied = "تم تطبيق الوزن بنجاح",
    scale_reset = "تم إعادة تعيين الشخصية إلى الحجم الطبيعي",
    
    info_tip_1 = "نسبة المقياس تؤثر على الحجم العام ومظهر شخصيتك.",
    info_tip_2 = "ابق ضمن النطاق الموصى به لأفضل تجربة لعب.",
    info_tip_3 = "أثناء رسوم الحركة، قد يتم ضبط مقياسك مؤقتاً.",
    info_tip_4 = "تغييرات المقياس قد تؤثر على رسوم دخول وخروج المركبات.",
    
    notification_scale_applied_title = "تم تطبيق المقياس",
    notification_scale_applied_message = "تم تطبيق المقياس {scale} بنجاح!",
    notification_scale_reset_title = "تم إعادة تعيين المقياس",
    notification_scale_reset_message = "تم إعادة تعيين مقياس الشخصية إلى الحجم الطبيعي",
    notification_framework_title = "نظام المقياس",
    notification_framework_loading = "تحميل المقياس المحفوظ: {scale}",
    notification_scale_system_title = "نظام المقياس",
    notification_model_changed = "تم تغيير نموذج الشخصية، إعادة تطبيق المقياس...",
    notification_periodic_title = "فحص دوري",
    notification_periodic_reapply = "إعادة تطبيق المقياس: {scale}",
    
    notification_setweight_usage = "الاستخدام: /setweight <القيمة> (مثال: /setweight 0.9)",
    notification_setweight_invalid_number = "قيمة وزن غير صالحة. يرجى إدخال رقم صالح.",
    notification_setweight_out_of_range = "الوزن {weight} خارج النطاق. النطاق الصالح: {min} - {max}",
    notification_setweight_applied_title = "تم تعيين الوزن",
    notification_setweight_applied = "تم تعيين الوزن إلى {weight} عبر الأمر!",
    
    notification_error_title = "خطأ",
    notification_setscale_usage = "الاستخدام: /setscale <القيمة> (مثال: /setscale 0.6)",
    notification_setscale_invalid_number = "قيمة مقياس غير صالحة. يرجى إدخال رقم صالح.",
    notification_setscale_out_of_range = "المقياس {scale} خارج النطاق. النطاق الصالح: {min} - {max}",
    notification_setscale_applied_title = "تم تعيين المقياس",
    notification_setscale_applied = "تم تعيين المقياس إلى {scale} عبر الأمر!",
    
    notification_permission_denied_title = "تم رفض الإذن",
    notification_permission_denied_message = "ليس لديك إذن لاستخدام هذا السكريبت! مطلوب Framework أو دور Discord.",
    notification_discord_permission_denied = "ليس لديك دور Discord المطلوب!",
    notification_discord_not_connected = "حساب Discord الخاص بك غير متصل بالخادم!",
    notification_discord_role_check_failed = "فشل في فحص دور Discord!",
    
    notification_givescale_usage = "الاستخدام: /givescalemenu <معرف_اللاعب>",
    notification_givescale_player_not_found = "اللاعب غير موجود!",
    notification_givescale_success = "تم فتح قائمة المقياس للاعب {playerName} ({playerId})",
    notification_givescale_permission_denied = "ليس لديك إذن لاستخدام هذا الأمر!",
    notification_givescale_menu_opened = "تم فتح قائمة المقياس لك من قبل المدير",
    
    notification_checkscale_permission_denied = "ليس لديك إذن لاستخدام هذا الأمر!",
    notification_checkscale_no_records = "لم يتم العثور على سجلات في قاعدة البيانات!",
    notification_checkscale_records_loaded = "تم تحميل {count} سجل",
    notification_checkscale_record_deleted = "تم حذف السجل بنجاح: {identifier}",
    notification_checkscale_delete_failed = "حدث خطأ أثناء حذف السجل!",
    checkscale_title = "إدارة سجلات المقياس",
    checkscale_identifier = "المعرف",
    checkscale_scale_value = "قيمة المقياس",
    checkscale_updated_at = "تم التحديث في",
    checkscale_actions = "الإجراءات",
    checkscale_delete = "حذف",
    checkscale_confirm_delete = "حذف هذا السجل؟",
    checkscale_close = "إغلاق",
    checkscale_total_records = "إجمالي السجلات:",
    checkscale_confirm_delete_message = "هل أنت متأكد من أنك تريد حذف هذا السجل؟",
    checkscale_cancel = "إلغاء",
    checkscale_delete_confirm = "حذف",
}

return Locale.ar