-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.5.10 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for oauth2_server
CREATE DATABASE IF NOT EXISTS `oauth2_server` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `oauth2_server`;


-- Dumping structure for table oauth2_server.clients
CREATE TABLE IF NOT EXISTS `clients` (
  `id` varchar(255) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `grants` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table oauth2_server.clients: ~1 rows (approximately)
DELETE FROM `clients`;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` (`id`, `client_secret`, `grants`) VALUES
	('client1', 'secret1', 'password');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;


-- Dumping structure for table oauth2_server.tokens
CREATE TABLE IF NOT EXISTS `tokens` (
  `access_token` varchar(255) NOT NULL,
  `access_token_expires_at` datetime NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `refresh_token` varchar(225) NOT NULL,
  PRIMARY KEY (`access_token`),
  KEY `client_id` (`client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `tokens_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table oauth2_server.tokens: ~30 rows (approximately)
DELETE FROM `tokens`;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` (`access_token`, `access_token_expires_at`, `client_id`, `user_id`, `refresh_token`) VALUES
	('10eae574a28495fd181fa92e8ce6d6116ba9b3f7', '2024-12-20 00:50:18', 'client1', 1, '73dd7fa9b9f59ab99b0eba9adc976acfaca912b0'),
	('2c32476e5329ec95c2a856cfe5bce293736d9ed8', '2024-12-16 09:35:57', 'client1', 1, ''),
	('2f913a7243239d405160ac5b758f0278c875d68f', '2024-12-16 17:44:27', 'client1', 1, ''),
	('3539e36ad2be8586bbfe442ab712b2bf8e14fa8d', '2024-12-20 00:01:04', 'client1', 1, '2d70256822524591dfdb6d29b350789ae80af349'),
	('3a62538e16d7b13650e978177a476842d3fd380a', '2024-12-16 09:37:19', 'client1', 1, ''),
	('4143db18c558d6ceadd70b2e57af3409b5966d60', '2024-12-18 16:17:07', 'client1', 1, '34b4e43df19f303a0296c622f6231cdbb6109bee'),
	('439ea6630052eda824f03a95c355ca37c7d429cb', '2024-12-16 08:34:14', 'client1', 1, ''),
	('4b9df47c2e28cf0dedc7d6f780a752b1ede7d71e', '2024-12-16 08:26:39', 'client1', 1, ''),
	('56b3fd42d9a7b4ecc6612b0663e0adbacad2e850', '2024-12-16 08:40:37', 'client1', 1, ''),
	('56eacec5981e471a836e2eee07cb177424f8ae06', '2024-12-16 08:27:29', 'client1', 1, ''),
	('5ec030175e4ce8f32677ba6c0f98a687e2bc328d', '2024-12-16 09:12:55', 'client1', 1, ''),
	('621b3200153cfe5c1f7815ac500907ae2a48424b', '2024-12-16 08:37:17', 'client1', 1, ''),
	('6b1aa8d20754a9e765719ecb7aaa308043814621', '2024-12-21 21:38:44', 'client1', 1, 'ee7b495ce8bf1640977a633aede646f2a38a6924'),
	('934c0fd2da3b021016db8a61417aecc1b80bef4e', '2024-12-16 17:30:20', 'client1', 1, ''),
	('94501bef7f4186f1f944ba8fe4e33abe0eba5284', '2024-12-20 00:17:57', 'client1', 1, '8d443f20f1c9efcfb30315dd1ab8697ee2970c82'),
	('97241305d518af089289ab9d57a58162d51bd6e7', '2024-12-16 17:30:19', 'client1', 1, ''),
	('97c23e80b23ac9910355b2e42bf8aef8e18495f4', '2024-12-20 00:40:50', 'client1', 1, '89df75864e46dda0fa0e16051a240a78db0c4f84'),
	('9feaf284586751a9fc43543f7f87511e056457f3', '2024-12-20 01:00:14', 'client1', 1, '24fe23fc2d7584ce8c67580fa5cdc4d4f82dbf5f'),
	('a63bbb299f916d73f0b80bef6ad7d74347ab7959', '2024-12-21 21:22:32', 'client1', 1, '418049430824676d13e39e98a72c558dd7a0f85c'),
	('aad33e09fb26a4beb317ad390324189f65ec69cb', '2024-12-16 17:27:09', 'client1', 1, ''),
	('ac2f80b2155b4a7fe2a6ba99e7870bc3030ae6de', '2024-12-16 17:42:51', 'client1', 1, ''),
	('ae40bc21fac57cdd84cbbefcad5bb03cca9f1898', '2024-12-20 01:09:03', 'client1', 1, '19f3e1a82b948b08135ff17dba50a0f800fc4317'),
	('ae464cdedbce03955ed2816006c7bae098bf8ba8', '2024-12-17 17:57:39', 'client1', 1, ''),
	('aea2a4c87bc30f3636cba1b1c9203658434ffcba', '2024-12-19 20:16:55', 'client1', 1, '3bd5bde744aa36321f3a1267bca202e2f0e0359d'),
	('c1f370e61e24a3e4fd42100e8e9cd510461b0777', '2024-12-20 11:00:30', 'client1', 1, '74402f1a5a71c2cba86132cbb8ed64c6ee0b2a1f'),
	('c52371cff6ea4c01f344e04852073710b58d48de', '2024-12-16 17:38:39', 'client1', 1, ''),
	('e688c871b58c68cab7d99755133e8a858b85745f', '2024-12-21 21:47:07', 'client1', 1, 'b2c989190399cb0038354fccffe3e80ac73ccf2a'),
	('ea5aebda504684716b970608eefce3dde16f87dc', '2024-12-17 17:22:31', 'client1', 1, ''),
	('ecf3213084c0b44cf920712eea4505b9413c765c', '2024-12-17 17:15:19', 'client1', 1, ''),
	('f061240eb16e5f2bb6800d646d026a9705ccfd41', '2024-12-17 17:32:09', 'client1', 1, '');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;


-- Dumping structure for table oauth2_server.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table oauth2_server.users: ~1 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`) VALUES
	(1, 'user', 'password');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
