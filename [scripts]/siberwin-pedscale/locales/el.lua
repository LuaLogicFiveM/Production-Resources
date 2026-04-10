if not Locale then
    Locale = {}
end

Locale.el = {
    current_scale = "Τρέχον ύψος",
    current_weight = "Τρέχον βάρος",
    reset = "Επαναφορά",
    apply = "Εφαρμογή",
    scale_size = "Κλίμακα ύψους",
    weight_size = "Κλίμακα βάρους",
    adjust_character = "Προσαρμόστε το ύψος και το βάρος του χαρακτήρα σας.",
    scale_applied = "Το ύψος εφαρμόστηκε επιτυχώς",
    weight_applied = "Το βάρος εφαρμόστηκε επιτυχώς",
    scale_reset = "Ο χαρακτήρας επανήλθε σε κανονικό μέγεθος",
    
    info_tip_1 = "Ο λόγος κλίμακας επηρεάζει το συνολικό μέγεθος και την εμφάνιση του χαρακτήρα σας.",
    info_tip_2 = "Μείνετε εντός του συνιστώμενου εύρους για την καλύτερη εμπειρία παιχνιδιού.",
    info_tip_3 = "Κατά τη διάρκεια των κινούμενων εικόνων κίνησης, η κλίμακά σας μπορεί να προσαρμοστεί προσωρινά.",
    info_tip_4 = "Οι αλλαγές κλίμακας μπορεί να επηρεάσουν τις κινούμενες εικόνες εισόδου και εξόδου από οχήματα.",
    
    notification_scale_applied_title = "Η κλίμακα εφαρμόστηκε",
    notification_scale_applied_message = "Η κλίμακα {scale} εφαρμόστηκε επιτυχώς!",
    notification_scale_reset_title = "Η κλίμακα επαναφέρθηκε",
    notification_scale_reset_message = "Η κλίμακα χαρακτήρα επαναφέρθηκε σε κανονικό μέγεθος",
    notification_framework_title = "Σύστημα κλίμακας",
    notification_framework_loading = "Φόρτωση αποθηκευμένης κλίμακας: {scale}",
    notification_scale_system_title = "Σύστημα κλίμακας",
    notification_model_changed = "Το μοντέλο χαρακτήρα άλλαξε, επαναφέρω την κλίμακα...",
    notification_periodic_title = "Περιοδικός έλεγχος",
    notification_periodic_reapply = "Επαναφορά κλίμακας: {scale}",
    
    notification_setweight_usage = "Χρήση: /setweight <τιμή> (π.χ.: /setweight 0.9)",
    notification_setweight_invalid_number = "Άκυρη τιμή βάρους. Παρακαλώ εισάγετε έναν έγκυρο αριθμό.",
    notification_setweight_out_of_range = "Το βάρος {weight} είναι εκτός εύρους. Έγκυρο εύρος: {min} - {max}",
    notification_setweight_applied_title = "Το βάρος ορίστηκε",
    notification_setweight_applied = "Το βάρος ορίστηκε σε {weight} μέσω εντολής!",
    
    notification_error_title = "Σφάλμα",
    notification_setscale_usage = "Χρήση: /setscale <τιμή> (π.χ.: /setscale 0.6)",
    notification_setscale_invalid_number = "Άκυρη τιμή κλίμακας. Παρακαλώ εισάγετε έναν έγκυρο αριθμό.",
    notification_setscale_out_of_range = "Η κλίμακα {scale} είναι εκτός εύρους. Έγκυρο εύρος: {min} - {max}",
    notification_setscale_applied_title = "Η κλίμακα ορίστηκε",
    notification_setscale_applied = "Η κλίμακα ορίστηκε σε {scale} μέσω εντολής!",
    
    notification_permission_denied_title = "Η άδεια απορρίφθηκε",
    notification_permission_denied_message = "Δεν έχετε άδεια να χρησιμοποιήσετε αυτό το σκρίπτ! Απαιτείται Framework ή ρόλος Discord.",
    notification_discord_permission_denied = "Δεν έχετε τον απαιτούμενο ρόλο Discord!",
    notification_discord_not_connected = "Ο λογαριασμός σας στο Discord δεν είναι συνδεδεμένος στον διακομιστή!",
    notification_discord_role_check_failed = "Η ελεγχος ρόλου Discord απέτυχε!",
    
    notification_givescale_usage = "Χρήση: /givescalemenu <player_id>",
    notification_givescale_player_not_found = "Ο παίκτης δεν βρέθηκε!",
    notification_givescale_success = "Το μενού κλίμακας ανοίχτηκε για τον παίκτη {playerName} ({playerId})",
    notification_givescale_permission_denied = "Δεν έχετε άδεια να χρησιμοποιήσετε αυτή την εντολή!",
    notification_givescale_menu_opened = "Το μενού κλίμακας ανοίχτηκε για εσάς από έναν διαχειριστή",
    
    notification_checkscale_permission_denied = "Δεν έχετε άδεια να χρησιμοποιήσετε αυτή την εντολή!",
    notification_checkscale_no_records = "Δεν βρέθηκαν εγγραφές στη βάση δεδομένων!",
    notification_checkscale_records_loaded = "Φορτώθηκαν {count} εγγραφές",
    notification_checkscale_record_deleted = "Η εγγραφή διαγράφηκε επιτυχώς: {identifier}",
    notification_checkscale_delete_failed = "Προέκυψε σφάλμα κατά τη διαγραφή της εγγραφής!",
    checkscale_title = "Διαχείριση εγγραφών κλίμακας",
    checkscale_identifier = "Αναγνωριστικό",
    checkscale_scale_value = "Τιμή κλίμακας",
    checkscale_updated_at = "Ενημερώθηκε στις",
    checkscale_actions = "Ενέργειες",
    checkscale_delete = "Διαγραφή",
    checkscale_confirm_delete = "Διαγραφή αυτής της εγγραφής;",
    checkscale_close = "Κλείσιμο",
    checkscale_total_records = "Συνολικές εγγραφές:",
    checkscale_confirm_delete_message = "Είστε σίγουροι ότι θέλετε να διαγράψετε αυτή την εγγραφή;",
    checkscale_cancel = "Ακύρωση",
    checkscale_delete_confirm = "Διαγραφή",
}

return Locale.el