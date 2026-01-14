CREATE TABLE IF NOT EXISTS `vivum_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(24) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  `sender` varchar(60) NOT NULL,
  `sender_partner` varchar(60) DEFAULT NULL,
  `recipient` varchar(60) NOT NULL,
  `sender_label` tinytext DEFAULT NULL,
  `recipient_label` tinytext DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `payments_num` tinyint(4) NOT NULL DEFAULT 1,
  `payments_period` tinyint(4) DEFAULT NULL,
  `current_payment` tinyint(4) NOT NULL DEFAULT 0,
  `last_completed_payment` datetime DEFAULT NULL,
  `summary` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`)
);

ALTER TABLE `vivum_invoices` ADD COLUMN IF NOT EXISTS `amount_paid_total` int(11) NOT NULL DEFAULT 0 AFTER `amount`;
ALTER TABLE `vivum_invoices` ADD COLUMN IF NOT EXISTS `amount_paid_current` int(11) NOT NULL DEFAULT 0 AFTER `amount_paid_total`;
ALTER TABLE `vivum_invoices` ADD COLUMN IF NOT EXISTS `attachments` TEXT DEFAULT NULL AFTER `summary`;

CREATE INDEX IF NOT EXISTS `idx_id` ON `vivum_invoices` (`id`);
CREATE INDEX IF NOT EXISTS `idx_recipient` ON `vivum_invoices` (`recipient`);
CREATE INDEX IF NOT EXISTS `idx_sender` ON `vivum_invoices` (`sender`);
CREATE INDEX IF NOT EXISTS `idx_status` ON `vivum_invoices` (`status`);

CREATE TABLE IF NOT EXISTS `vivum_invoices_accounts` (
  `id` varchar(60) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE INDEX IF NOT EXISTS `idx_avatar_id` ON `vivum_invoices_accounts` (`id`);