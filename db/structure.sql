CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fantasy_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `legal_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doc_cnpj` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doc_ie` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doc_im` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `representant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_representant_id_fk` (`representant_id`),
  CONSTRAINT `companies_representant_id_fk` FOREIGN KEY (`representant_id`) REFERENCES `people` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middlename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doc_cpf` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doc_rg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20130228131241');

INSERT INTO schema_migrations (version) VALUES ('20130301003903');

INSERT INTO schema_migrations (version) VALUES ('20130301004429');