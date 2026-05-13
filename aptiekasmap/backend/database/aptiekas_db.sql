
DROP TABLE IF EXISTS `availability`;

CREATE TABLE `availability` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pharmacy_id` bigint unsigned NOT NULL,
  `medicine_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `price` decimal(8,2) NOT NULL,
  `status` enum('available','unavailable') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `availability_pharmacy_id_foreign` (`pharmacy_id`),
  KEY `availability_medicine_id_foreign` (`medicine_id`),
  CONSTRAINT `availability_medicine_id_foreign` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE,
  CONSTRAINT `availability_pharmacy_id_foreign` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


LOCK TABLES `availability` WRITE;
INSERT INTO `availability` VALUES (1,1,1,50,1.45,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(2,1,2,30,2.10,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(3,1,3,0,5.80,'unavailable','2026-05-10 15:12:29','2026-05-10 15:12:29'),(4,2,1,20,1.35,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(5,2,2,5,1.99,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(6,2,4,40,3.20,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(7,3,1,100,1.29,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(8,3,5,15,4.50,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(9,3,6,8,6.75,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(10,4,3,12,5.90,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(11,4,4,25,3.10,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(12,5,1,60,1.40,'available','2026-05-10 15:12:29','2026-05-10 15:12:29'),(13,5,5,20,4.30,'available','2026-05-10 15:12:29','2026-05-10 15:12:29');
UNLOCK TABLES;

DROP TABLE IF EXISTS `cache`;

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `cache` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `cache_locks`;

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `cache_locks` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `failed_jobs` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `job_batches` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `jobs` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `medicines`;

CREATE TABLE `medicines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_substance` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `form` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dose` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manufacturer` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `medicines` WRITE;
INSERT INTO `medicines` VALUES (1,'Paracetamol BENU','Paracetamols','Tabletes','500mg','BENU Pharma','Pretsāpju un pretdrudža līdzeklis','2026-05-10 15:12:29','2026-05-10 15:12:29'),(2,'Ibuprofen Grindeks','Ibuprofēns','Tabletes','400mg','Grindeks AS','Pretiekaisuma un pretsāpju līdzeklis','2026-05-10 15:12:29','2026-05-10 15:12:29'),(3,'Amoxicillin Sandoz','Amoksicilīns','Kapsulas','500mg','Sandoz','Plaša spektra antibiotiķis','2026-05-10 15:12:29','2026-05-10 15:12:29'),(4,'Loratadīns Teva','Loratadīns','Tabletes','10mg','Teva','Pretalerģijas līdzeklis','2026-05-10 15:12:29','2026-05-10 15:12:29'),(5,'Omeprazols EG','Omeprazols','Kapsulas','20mg','EG Labo','Kuņģa skābes mazinātājs','2026-05-10 15:12:29','2026-05-10 15:12:29'),(6,'Ārstnieciskais sīrups','Dekstrometorfāns','Šķidrums','15mg/5ml','Nycomed','Klepus nomākšanai','2026-05-10 15:12:29','2026-05-10 15:12:29');
UNLOCK TABLES;

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_05_07_194721_add_role_to_users_table',1),(5,'2026_05_07_194907_create_medicines_pharmacies_availability_tables',1),(6,'2026_05_07_201700_create_personal_access_tokens_table',1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `medicine_id` bigint unsigned NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` enum('read','not_read') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not_read',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  KEY `notifications_medicine_id_foreign` (`medicine_id`),
  CONSTRAINT `notifications_medicine_id_foreign` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `notifications` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `password_reset_tokens` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `personal_access_tokens` WRITE;
INSERT INTO `personal_access_tokens` VALUES (2,'App\\Models\\User',5,'aptiekasmap','298fe649976d68247483b624450df7aef954ce0e1d6eb95d209dde81843acd6d','[\"*\"]','2026-05-11 10:27:22',NULL,'2026-05-11 10:27:20','2026-05-11 10:27:22'),(4,'App\\Models\\User',1,'aptiekasmap','056a618016cd0003f95fcca475b705de186f64ce13d1b9bd8f083a3491dcaac4','[\"*\"]','2026-05-13 06:49:47',NULL,'2026-05-13 06:49:40','2026-05-13 06:49:47');
UNLOCK TABLES;

DROP TABLE IF EXISTS `pharmacies`;

CREATE TABLE `pharmacies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `pharmacies` WRITE;
INSERT INTO `pharmacies` VALUES (1,'BENU Aptieka Brīvības','Brīvības iela 85, Rīga',56.9560123,24.1234567,'+37167001111','2026-05-10 15:12:29','2026-05-10 15:12:29'),(2,'Mēness Aptieka Centrs','Elizabetes iela 10, Rīga',56.9510000,24.1150000,'+37167002222','2026-05-10 15:12:29','2026-05-10 15:12:29'),(3,'Euroaptieka Imanta','Imanta 7. līnija 1, Rīga',56.9310000,24.0200000,'+37167003333','2026-05-10 15:12:29','2026-05-10 15:12:29'),(4,'Dr. Tālivaldis Aptieka','Dzirnavu iela 55, Rīga',56.9490000,24.1100000,'+37167004444','2026-05-10 15:12:29','2026-05-10 15:12:29'),(5,'Apotheka Pārdaugava','Kurzemes prospekts 3, Rīga',56.9400000,24.0800000,'+37167005555','2026-05-10 15:12:29','2026-05-10 15:12:29');
UNLOCK TABLES;

DROP TABLE IF EXISTS `search_history`;

CREATE TABLE `search_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `medicine_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `search_history_user_id_foreign` (`user_id`),
  CONSTRAINT `search_history_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `search_history` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `sessions` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'Administrators','admin@aptiekasmap.lv',NULL,'$2y$12$.qGQoIaVQTLGApQxZgLnHOCjSl.EmUhlpDuBFmKWD2Xy7MD4spcY2','admin',NULL,'2026-05-10 15:12:28','2026-05-10 15:12:28'),(2,'Jānis Bērziņš','janis@gmail.com',NULL,'$2y$12$hRBDfBoIXjHzj9mLa.WZHu6WgRrRwUbL38tsRhZ4mKMkkzGJz6mM.','user',NULL,'2026-05-10 15:12:28','2026-05-10 15:12:28'),(3,'Anna Kalniņa','anna@gmail.com',NULL,'$2y$12$C2zqnHz76O9w.xYmLXEd8ePpc36bUASktc3s7Op5v7zb03kAwtf1q','user',NULL,'2026-05-10 15:12:28','2026-05-10 15:12:28'),(4,'BENU Pārstāvis','benu@benu.lv',NULL,'$2y$12$UdYts32xthFKxV.CniPGquXSSE0tcrqxye3ZubYP/fsBLox.AOcZm','pharmacy_rep',NULL,'2026-05-10 15:12:29','2026-05-10 15:12:29'),(5,'tu','uyf@edaw.lv',NULL,'$2y$12$GjvusqNNJxhmnJZdKlKzBu8HIWj8IqdJb0nvkyOBgv0SynfA4rJOe','user',NULL,'2026-05-11 10:27:20','2026-05-11 10:27:20');
UNLOCK TABLES;