CREATE TABLE IF NOT EXISTS `storageunits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(250) DEFAULT NULL,
  `pin` longtext DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `storageunits` (`id`, `identifier`, `pin`) VALUES
	(1, NULL, NULL),
	(2, NULL, NULL),
	(3, NULL, NULL),
	(4, NULL, NULL),
	(5, NULL, NULL),
	(6, NULL, NULL),
	(7, NULL, NULL),
	(8, NULL, NULL),
	(9, NULL, NULL),
	(10, NULL, NULL),
	(11, NULL, NULL),
	(12, NULL, NULL),
	(13, NULL, NULL),
	(14, NULL, NULL);
