-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 04, 2012 at 06:00 PM
-- Server version: 5.5.24
-- PHP Version: 5.3.10-1ubuntu3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ushahidi`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE IF NOT EXISTS `actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(75) NOT NULL,
  `qualifiers` text NOT NULL,
  `response` varchar(75) NOT NULL,
  `response_vars` text NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user defined actions triggered by certain events' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `actions_log`
--

CREATE TABLE IF NOT EXISTS `actions_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of triggered actions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `alert`
--

CREATE TABLE IF NOT EXISTS `alert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `alert_type` tinyint(4) NOT NULL COMMENT '1 - MOBILE, 2 - EMAIL',
  `alert_recipient` varchar(200) DEFAULT NULL,
  `alert_code` varchar(30) DEFAULT NULL,
  `alert_confirmed` tinyint(4) NOT NULL DEFAULT '0',
  `alert_lat` varchar(150) DEFAULT NULL,
  `alert_lon` varchar(150) DEFAULT NULL,
  `alert_radius` tinyint(4) NOT NULL DEFAULT '20',
  `alert_ip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_alert_code` (`alert_code`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores alerts subscribers information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `alert_category`
--

CREATE TABLE IF NOT EXISTS `alert_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_id` bigint(20) unsigned DEFAULT NULL,
  `category_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_id` (`alert_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores subscriber alert categories' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `alert_sent`
--

CREATE TABLE IF NOT EXISTS `alert_sent` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `alert_id` bigint(20) unsigned NOT NULL,
  `alert_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `alert_id` (`alert_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of alerts sent out to subscribers' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_banned`
--

CREATE TABLE IF NOT EXISTS `api_banned` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `banned_ipaddress` varchar(50) NOT NULL,
  `banned_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For logging banned API IP addresses' AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_log`
--

CREATE TABLE IF NOT EXISTS `api_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `api_task` varchar(10) NOT NULL,
  `api_parameters` varchar(100) NOT NULL,
  `api_records` tinyint(11) NOT NULL,
  `api_ipaddress` varchar(50) NOT NULL,
  `api_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For logging API activities' AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_settings`
--

CREATE TABLE IF NOT EXISTS `api_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default_record_limit` int(11) NOT NULL DEFAULT '20',
  `max_record_limit` int(11) DEFAULT NULL,
  `max_requests_per_ip_address` int(11) DEFAULT NULL,
  `max_requests_quota_basis` int(11) DEFAULT NULL,
  `modification_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For storing API logging settings' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `badge`
--

CREATE TABLE IF NOT EXISTS `badge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores description of badges to be assigned' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `badge_users`
--

CREATE TABLE IF NOT EXISTS `badge_users` (
  `user_id` int(11) unsigned NOT NULL,
  `badge_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`badge_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores assigned badge information';

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(10) NOT NULL DEFAULT 'en_US',
  `category_position` tinyint(4) NOT NULL DEFAULT '0',
  `category_title` varchar(255) DEFAULT NULL,
  `category_description` text,
  `category_color` varchar(20) DEFAULT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_image_thumb` varchar(255) DEFAULT NULL,
  `category_visible` tinyint(4) NOT NULL DEFAULT '1',
  `category_trusted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_visible` (`category_visible`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information about categories defined for a deployment' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `parent_id`, `locale`, `category_position`, `category_title`, `category_description`, `category_color`, `category_image`, `category_image_thumb`, `category_visible`, `category_trusted`) VALUES
(1, 0, 'en_US', 0, 'Category 1', 'Category 1', '9900CC', NULL, NULL, 1, 0),
(2, 0, 'en_US', 1, 'Category 2', 'Category 2', '3300FF', NULL, NULL, 1, 0),
(3, 0, 'en_US', 2, 'Category 3', 'Category 3', '663300', NULL, NULL, 1, 0),
(4, 0, 'en_US', 4, 'Trusted Reports', 'Reports from trusted reporters', '339900', NULL, NULL, 1, 1),
(5, 0, 'en_US', 3, 'NONE', 'Holds uncategorized reports', '009887', NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `category_lang`
--

CREATE TABLE IF NOT EXISTS `category_lang` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) unsigned NOT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `category_title` varchar(255) DEFAULT NULL,
  `category_description` text,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for category titles and descriptions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `checkin`
--

CREATE TABLE IF NOT EXISTS `checkin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  `incident_id` bigint(20) unsigned DEFAULT '0',
  `checkin_description` varchar(255) DEFAULT NULL,
  `checkin_date` datetime NOT NULL,
  `checkin_auto` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores checkin information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `city_lat` varchar(150) DEFAULT NULL,
  `city_lon` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores cities of countries retrieved by user.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cluster`
--

CREATE TABLE IF NOT EXISTS `cluster` (
  `id` int(11) NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `latitude_min` double NOT NULL,
  `longitude_min` double NOT NULL,
  `latitude_max` double NOT NULL,
  `longitude_max` double NOT NULL,
  `child_count` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `left_side` int(11) NOT NULL,
  `right_side` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_id` (`incident_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores information used for clustering of reports on the map.';

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `checkin_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT '0',
  `comment_author` varchar(100) DEFAULT NULL,
  `comment_email` varchar(120) DEFAULT NULL,
  `comment_description` text,
  `comment_ip` varchar(100) DEFAULT NULL,
  `comment_spam` tinyint(4) NOT NULL DEFAULT '0',
  `comment_active` tinyint(4) NOT NULL DEFAULT '0',
  `comment_date` datetime DEFAULT NULL,
  `comment_date_gmt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `checkin_id` (`checkin_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores comments made on reports/checkins' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` varchar(10) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `capital` varchar(100) DEFAULT NULL,
  `cities` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a list of all countries and their capital cities' AUTO_INCREMENT=248 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `iso`, `country`, `capital`, `cities`) VALUES
(1, 'AD', 'Andorra', 'Andorra la Vella', 0),
(2, 'AE', 'United Arab Emirates', 'Abu Dhabi', 0),
(3, 'AF', 'Afghanistan', 'Kabul', 0),
(4, 'AG', 'Antigua and Barbuda', 'St. John''s', 0),
(5, 'AI', 'Anguilla', 'The Valley', 0),
(6, 'AL', 'Albania', 'Tirana', 0),
(7, 'AM', 'Armenia', 'Yerevan', 0),
(8, 'AN', 'Netherlands Antilles', 'Willemstad', 0),
(9, 'AO', 'Angola', 'Luanda', 0),
(10, 'AQ', 'Antarctica', '', 0),
(11, 'AR', 'Argentina', 'Buenos Aires', 0),
(12, 'AS', 'American Samoa', 'Pago Pago', 0),
(13, 'AT', 'Austria', 'Vienna', 0),
(14, 'AU', 'Australia', 'Canberra', 0),
(15, 'AW', 'Aruba', 'Oranjestad', 0),
(16, 'AX', 'Aland Islands', 'Mariehamn', 0),
(17, 'AZ', 'Azerbaijan', 'Baku', 0),
(18, 'BA', 'Bosnia and Herzegovina', 'Sarajevo', 0),
(19, 'BB', 'Barbados', 'Bridgetown', 0),
(20, 'BD', 'Bangladesh', 'Dhaka', 0),
(21, 'BE', 'Belgium', 'Brussels', 0),
(22, 'BF', 'Burkina Faso', 'Ouagadougou', 0),
(23, 'BG', 'Bulgaria', 'Sofia', 0),
(24, 'BH', 'Bahrain', 'Manama', 0),
(25, 'BI', 'Burundi', 'Bujumbura', 0),
(26, 'BJ', 'Benin', 'Porto-Novo', 0),
(27, 'BL', 'Saint BarthÃ©lemy', 'Gustavia', 0),
(28, 'BM', 'Bermuda', 'Hamilton', 0),
(29, 'BN', 'Brunei', 'Bandar Seri Begawan', 0),
(30, 'BO', 'Bolivia', 'La Paz', 0),
(31, 'BR', 'Brazil', 'BrasÃ­lia', 0),
(32, 'BS', 'Bahamas', 'Nassau', 0),
(33, 'BT', 'Bhutan', 'Thimphu', 0),
(34, 'BV', 'Bouvet Island', '', 0),
(35, 'BW', 'Botswana', 'Gaborone', 0),
(36, 'BY', 'Belarus', 'Minsk', 0),
(37, 'BZ', 'Belize', 'Belmopan', 0),
(38, 'CA', 'Canada', 'Ottawa', 0),
(39, 'CC', 'Cocos Islands', 'West Island', 0),
(40, 'CD', 'Democratic Republic of the Congo', 'Kinshasa', 0),
(41, 'CF', 'Central African Republic', 'Bangui', 0),
(42, 'CG', 'Congo Brazzavile', 'Brazzaville', 0),
(43, 'CH', 'Switzerland', 'Berne', 0),
(44, 'CI', 'Ivory Coast', 'Yamoussoukro', 0),
(45, 'CK', 'Cook Islands', 'Avarua', 0),
(46, 'CL', 'Chile', 'Santiago', 0),
(47, 'CM', 'Cameroon', 'YaoundÃ©', 0),
(48, 'CN', 'China', 'Beijing', 0),
(49, 'CO', 'Colombia', 'BogotÃ¡', 0),
(50, 'CR', 'Costa Rica', 'San JosÃ©', 0),
(51, 'CS', 'Serbia and Montenegro', 'Belgrade', 0),
(52, 'CU', 'Cuba', 'Havana', 0),
(53, 'CV', 'Cape Verde', 'Praia', 0),
(54, 'CX', 'Christmas Island', 'Flying Fish Cove', 0),
(55, 'CY', 'Cyprus', 'Nicosia', 0),
(56, 'CZ', 'Czech Republic', 'Prague', 0),
(57, 'DE', 'Germany', 'Berlin', 0),
(58, 'DJ', 'Djibouti', 'Djibouti', 0),
(59, 'DK', 'Denmark', 'Copenhagen', 0),
(60, 'DM', 'Dominica', 'Roseau', 0),
(61, 'DO', 'Dominican Republic', 'Santo Domingo', 0),
(62, 'DZ', 'Algeria', 'Algiers', 0),
(63, 'EC', 'Ecuador', 'Quito', 0),
(64, 'EE', 'Estonia', 'Tallinn', 0),
(65, 'EG', 'Egypt', 'Cairo', 0),
(66, 'EH', 'Western Sahara', 'El-Aaiun', 0),
(67, 'ER', 'Eritrea', 'Asmara', 0),
(68, 'ES', 'Spain', 'Madrid', 0),
(69, 'ET', 'Ethiopia', 'Addis Ababa', 0),
(70, 'FI', 'Finland', 'Helsinki', 0),
(71, 'FJ', 'Fiji', 'Suva', 0),
(72, 'FK', 'Falkland Islands', 'Stanley', 0),
(73, 'FM', 'Micronesia', 'Palikir', 0),
(74, 'FO', 'Faroe Islands', 'TÃ³rshavn', 0),
(75, 'FR', 'France', 'Paris', 0),
(76, 'GA', 'Gabon', 'Libreville', 0),
(77, 'GB', 'United Kingdom', 'London', 0),
(78, 'GD', 'Grenada', 'St. George''s', 0),
(79, 'GE', 'Georgia', 'Tbilisi', 0),
(80, 'GF', 'French Guiana', 'Cayenne', 0),
(81, 'GG', 'Guernsey', 'St Peter Port', 0),
(82, 'GH', 'Ghana', 'Accra', 0),
(83, 'GI', 'Gibraltar', 'Gibraltar', 0),
(84, 'GL', 'Greenland', 'Nuuk', 0),
(85, 'GM', 'Gambia', 'Banjul', 0),
(86, 'GN', 'Guinea', 'Conakry', 0),
(87, 'GP', 'Guadeloupe', 'Basse-Terre', 0),
(88, 'GQ', 'Equatorial Guinea', 'Malabo', 0),
(89, 'GR', 'Greece', 'Athens', 0),
(90, 'GS', 'South Georgia and the South Sandwich Islands', 'Grytviken', 0),
(91, 'GT', 'Guatemala', 'Guatemala City', 0),
(92, 'GU', 'Guam', 'HagÃ¥tÃ±a', 0),
(93, 'GW', 'Guinea-Bissau', 'Bissau', 0),
(94, 'GY', 'Guyana', 'Georgetown', 0),
(95, 'HK', 'Hong Kong', 'Hong Kong', 0),
(96, 'HM', 'Heard Island and McDonald Islands', '', 0),
(97, 'HN', 'Honduras', 'Tegucigalpa', 0),
(98, 'HR', 'Croatia', 'Zagreb', 0),
(99, 'HT', 'Haiti', 'Port-au-Prince', 0),
(100, 'HU', 'Hungary', 'Budapest', 0),
(101, 'ID', 'Indonesia', 'Jakarta', 0),
(102, 'IE', 'Ireland', 'Dublin', 0),
(103, 'IL', 'Israel', 'Jerusalem', 0),
(104, 'IM', 'Isle of Man', 'Douglas, Isle of Man', 0),
(105, 'IN', 'India', 'New Delhi', 0),
(106, 'IO', 'British Indian Ocean Territory', 'Diego Garcia', 0),
(107, 'IQ', 'Iraq', 'Baghdad', 0),
(108, 'IR', 'Iran', 'Tehran', 0),
(109, 'IS', 'Iceland', 'ReykjavÃ­k', 0),
(110, 'IT', 'Italy', 'Rome', 0),
(111, 'JE', 'Jersey', 'Saint Helier', 0),
(112, 'JM', 'Jamaica', 'Kingston', 0),
(113, 'JO', 'Jordan', 'Amman', 0),
(114, 'JP', 'Japan', 'Tokyo', 0),
(115, 'KE', 'Kenya', 'Nairobi', 0),
(116, 'KG', 'Kyrgyzstan', 'Bishkek', 0),
(117, 'KH', 'Cambodia', 'Phnom Penh', 0),
(118, 'KI', 'Kiribati', 'South Tarawa', 0),
(119, 'KM', 'Comoros', 'Moroni', 0),
(120, 'KN', 'Saint Kitts and Nevis', 'Basseterre', 0),
(121, 'KP', 'North Korea', 'Pyongyang', 0),
(122, 'KR', 'South Korea', 'Seoul', 0),
(123, 'KW', 'Kuwait', 'Kuwait City', 0),
(124, 'KY', 'Cayman Islands', 'George Town', 0),
(125, 'KZ', 'Kazakhstan', 'Astana', 0),
(126, 'LA', 'Laos', 'Vientiane', 0),
(127, 'LB', 'Lebanon', 'Beirut', 0),
(128, 'LC', 'Saint Lucia', 'Castries', 0),
(129, 'LI', 'Liechtenstein', 'Vaduz', 0),
(130, 'LK', 'Sri Lanka', 'Colombo', 0),
(131, 'LR', 'Liberia', 'Monrovia', 0),
(132, 'LS', 'Lesotho', 'Maseru', 0),
(133, 'LT', 'Lithuania', 'Vilnius', 0),
(134, 'LU', 'Luxembourg', 'Luxembourg', 0),
(135, 'LV', 'Latvia', 'Riga', 0),
(136, 'LY', 'Libya', 'Tripolis', 0),
(137, 'MA', 'Morocco', 'Rabat', 0),
(138, 'MC', 'Monaco', 'Monaco', 0),
(139, 'MD', 'Moldova', 'Chi_in_u', 0),
(140, 'ME', 'Montenegro', 'Podgorica', 0),
(141, 'MF', 'Saint Martin', 'Marigot', 0),
(142, 'MG', 'Madagascar', 'Antananarivo', 0),
(143, 'MH', 'Marshall Islands', 'Uliga', 0),
(144, 'MK', 'Macedonia', 'Skopje', 0),
(145, 'ML', 'Mali', 'Bamako', 0),
(146, 'MM', 'Myanmar', 'Yangon', 0),
(147, 'MN', 'Mongolia', 'Ulan Bator', 0),
(148, 'MO', 'Macao', 'Macao', 0),
(149, 'MP', 'Northern Mariana Islands', 'Saipan', 0),
(150, 'MQ', 'Martinique', 'Fort-de-France', 0),
(151, 'MR', 'Mauritania', 'Nouakchott', 0),
(152, 'MS', 'Montserrat', 'Plymouth', 0),
(153, 'MT', 'Malta', 'Valletta', 0),
(154, 'MU', 'Mauritius', 'Port Louis', 0),
(155, 'MV', 'Maldives', 'MalÃ©', 0),
(156, 'MW', 'Malawi', 'Lilongwe', 0),
(157, 'MX', 'Mexico', 'Mexico City', 0),
(158, 'MY', 'Malaysia', 'Kuala Lumpur', 0),
(159, 'MZ', 'Mozambique', 'Maputo', 0),
(160, 'NA', 'Namibia', 'Windhoek', 0),
(161, 'NC', 'New Caledonia', 'NoumÃ©a', 0),
(162, 'NE', 'Niger', 'Niamey', 0),
(163, 'NF', 'Norfolk Island', 'Kingston', 0),
(164, 'NG', 'Nigeria', 'Abuja', 0),
(165, 'NI', 'Nicaragua', 'Managua', 0),
(166, 'NL', 'Netherlands', 'Amsterdam', 0),
(167, 'NO', 'Norway', 'Oslo', 0),
(168, 'NP', 'Nepal', 'Kathmandu', 0),
(169, 'NR', 'Nauru', 'Yaren', 0),
(170, 'NU', 'Niue', 'Alofi', 0),
(171, 'NZ', 'New Zealand', 'Wellington', 0),
(172, 'OM', 'Oman', 'Muscat', 0),
(173, 'PA', 'Panama', 'Panama City', 0),
(174, 'PE', 'Peru', 'Lima', 0),
(175, 'PF', 'French Polynesia', 'Papeete', 0),
(176, 'PG', 'Papua New Guinea', 'Port Moresby', 0),
(177, 'PH', 'Philippines', 'Manila', 0),
(178, 'PK', 'Pakistan', 'Islamabad', 0),
(179, 'PL', 'Poland', 'Warsaw', 0),
(180, 'PM', 'Saint Pierre and Miquelon', 'Saint-Pierre', 0),
(181, 'PN', 'Pitcairn', 'Adamstown', 0),
(182, 'PR', 'Puerto Rico', 'San Juan', 0),
(183, 'PS', 'Palestinian Territory', 'East Jerusalem', 0),
(184, 'PT', 'Portugal', 'Lisbon', 0),
(185, 'PW', 'Palau', 'Koror', 0),
(186, 'PY', 'Paraguay', 'AsunciÃ³n', 0),
(187, 'QA', 'Qatar', 'Doha', 0),
(188, 'RE', 'Reunion', 'Saint-Denis', 0),
(189, 'RO', 'Romania', 'Bucharest', 0),
(190, 'RS', 'Serbia', 'Belgrade', 0),
(191, 'RU', 'Russia', 'Moscow', 0),
(192, 'RW', 'Rwanda', 'Kigali', 0),
(193, 'SA', 'Saudi Arabia', 'Riyadh', 0),
(194, 'SB', 'Solomon Islands', 'Honiara', 0),
(195, 'SC', 'Seychelles', 'Victoria', 0),
(196, 'SD', 'Sudan', 'Khartoum', 0),
(197, 'SE', 'Sweden', 'Stockholm', 0),
(198, 'SG', 'Singapore', 'Singapur', 0),
(199, 'SH', 'Saint Helena', 'Jamestown', 0),
(200, 'SI', 'Slovenia', 'Ljubljana', 0),
(201, 'SJ', 'Svalbard and Jan Mayen', 'Longyearbyen', 0),
(202, 'SK', 'Slovakia', 'Bratislava', 0),
(203, 'SL', 'Sierra Leone', 'Freetown', 0),
(204, 'SM', 'San Marino', 'San Marino', 0),
(205, 'SN', 'Senegal', 'Dakar', 0),
(206, 'SO', 'Somalia', 'Mogadishu', 0),
(207, 'SR', 'Suriname', 'Paramaribo', 0),
(208, 'ST', 'Sao Tome and Principe', 'SÃ£o TomÃ©', 0),
(209, 'SV', 'El Salvador', 'San Salvador', 0),
(210, 'SY', 'Syria', 'Damascus', 0),
(211, 'SZ', 'Swaziland', 'Mbabane', 0),
(212, 'TC', 'Turks and Caicos Islands', 'Cockburn Town', 0),
(213, 'TD', 'Chad', 'N''Djamena', 0),
(214, 'TF', 'French Southern Territories', 'Martin-de-ViviÃ¨s', 0),
(215, 'TG', 'Togo', 'LomÃ©', 0),
(216, 'TH', 'Thailand', 'Bangkok', 0),
(217, 'TJ', 'Tajikistan', 'Dushanbe', 0),
(218, 'TK', 'Tokelau', '', 0),
(219, 'TL', 'East Timor', 'Dili', 0),
(220, 'TM', 'Turkmenistan', 'Ashgabat', 0),
(221, 'TN', 'Tunisia', 'Tunis', 0),
(222, 'TO', 'Tonga', 'Nuku''alofa', 0),
(223, 'TR', 'Turkey', 'Ankara', 0),
(224, 'TT', 'Trinidad and Tobago', 'Port of Spain', 0),
(225, 'TV', 'Tuvalu', 'Vaiaku', 0),
(226, 'TW', 'Taiwan', 'Taipei', 0),
(227, 'TZ', 'Tanzania', 'Dar es Salaam', 0),
(228, 'UA', 'Ukraine', 'Kiev', 0),
(229, 'UG', 'Uganda', 'Kampala', 0),
(230, 'UM', 'United States Minor Outlying Islands', '', 0),
(231, 'US', 'United States', 'Washington', 0),
(232, 'UY', 'Uruguay', 'Montevideo', 0),
(233, 'UZ', 'Uzbekistan', 'Tashkent', 0),
(234, 'VA', 'Vatican', 'Vatican City', 0),
(235, 'VC', 'Saint Vincent and the Grenadines', 'Kingstown', 0),
(236, 'VE', 'Venezuela', 'Caracas', 0),
(237, 'VG', 'British Virgin Islands', 'Road Town', 0),
(238, 'VI', 'U.S. Virgin Islands', 'Charlotte Amalie', 0),
(239, 'VN', 'Vietnam', 'Hanoi', 0),
(240, 'VU', 'Vanuatu', 'Port Vila', 0),
(241, 'WF', 'Wallis and Futuna', 'MatÃ¢''Utu', 0),
(242, 'WS', 'Samoa', 'Apia', 0),
(243, 'YE', 'Yemen', 'Sanâ€˜aâ€™', 0),
(244, 'YT', 'Mayotte', 'Mamoudzou', 0),
(245, 'ZA', 'South Africa', 'Pretoria', 0),
(246, 'ZM', 'Zambia', 'Lusaka', 0),
(247, 'ZW', 'Zimbabwe', 'Harare', 0);

-- --------------------------------------------------------

--
-- Table structure for table `externalapp`
--

CREATE TABLE IF NOT EXISTS `externalapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Info on external apps(mobile) that work with your deployment' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `externalapp`
--

INSERT INTO `externalapp` (`id`, `name`, `url`) VALUES
(1, 'iPhone', 'http://download.ushahidi.com/track_download.php?download=ios'),
(2, 'Android', 'http://download.ushahidi.com/track_download.php?download=android');

-- --------------------------------------------------------

--
-- Table structure for table `feed`
--

CREATE TABLE IF NOT EXISTS `feed` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feed_name` varchar(255) DEFAULT NULL,
  `feed_url` varchar(255) DEFAULT NULL,
  `feed_cache` text,
  `feed_active` tinyint(4) DEFAULT '1',
  `feed_update` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about RSS Feeds a deployment subscribes to' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `feed_item`
--

CREATE TABLE IF NOT EXISTS `feed_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feed_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned DEFAULT '0',
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_title` varchar(255) DEFAULT NULL,
  `item_description` text,
  `item_link` varchar(255) DEFAULT NULL,
  `item_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feed_id` (`feed_id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores feed items pulled from each RSS Feed' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `form`
--

CREATE TABLE IF NOT EXISTS `form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_title` varchar(200) NOT NULL,
  `form_description` text,
  `form_active` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores all report submission forms created(default+custom)' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `form`
--

INSERT INTO `form` (`id`, `form_title`, `form_description`, `form_active`) VALUES
(1, 'Default Form', 'Default form, for report entry', 1),
(2, 'konafa', 'about konafa', 1);

-- --------------------------------------------------------

--
-- Table structure for table `form_field`
--

CREATE TABLE IF NOT EXISTS `form_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_name` varchar(200) DEFAULT NULL,
  `field_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - TEXTFIELD, 2 - TEXTAREA (FREETEXT), 3 - DATE, 4 - PASSWORD, 5 - RADIO, 6 - CHECKBOX',
  `field_required` tinyint(4) DEFAULT '0',
  `field_options` text,
  `field_position` tinyint(4) NOT NULL DEFAULT '0',
  `field_default` varchar(200) DEFAULT NULL,
  `field_maxlength` int(11) NOT NULL DEFAULT '0',
  `field_width` smallint(6) NOT NULL DEFAULT '0',
  `field_height` tinyint(4) DEFAULT '5',
  `field_isdate` tinyint(4) NOT NULL DEFAULT '0',
  `field_ispublic_visible` tinyint(4) NOT NULL DEFAULT '0',
  `field_ispublic_submit` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_form_id` (`form_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores all custom form fields created by users' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `form_field`
--

INSERT INTO `form_field` (`id`, `form_id`, `field_name`, `field_type`, `field_required`, `field_options`, `field_position`, `field_default`, `field_maxlength`, `field_width`, `field_height`, `field_isdate`, `field_ispublic_visible`, `field_ispublic_submit`) VALUES
(1, 2, 'price', 1, 1, NULL, 1, '0.00', 0, 0, 5, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `form_field_option`
--

CREATE TABLE IF NOT EXISTS `form_field_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_field_id` int(11) NOT NULL DEFAULT '0',
  `option_name` varchar(200) DEFAULT NULL,
  `option_value` text,
  PRIMARY KEY (`id`),
  KEY `form_field_id` (`form_field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Options related to custom form fields' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `form_field_option`
--

INSERT INTO `form_field_option` (`id`, `form_field_id`, `option_name`, `option_value`) VALUES
(1, 1, 'field_datatype', 'text'),
(2, 1, 'field_hidden', '0');

-- --------------------------------------------------------

--
-- Table structure for table `form_response`
--

CREATE TABLE IF NOT EXISTS `form_response` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_field_id` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL,
  `form_response` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_form_field_id` (`form_field_id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores responses to custom form fields' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `geometry`
--

CREATE TABLE IF NOT EXISTS `geometry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `geometry` geometry NOT NULL,
  `geometry_label` varchar(150) DEFAULT NULL,
  `geometry_comment` varchar(255) DEFAULT NULL,
  `geometry_color` varchar(20) DEFAULT NULL,
  `geometry_strokewidth` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `geometry` (`geometry`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores map geometries i.e polygons, lines etc' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `incident`
--

CREATE TABLE IF NOT EXISTS `incident` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned NOT NULL,
  `form_id` int(11) NOT NULL DEFAULT '1',
  `locale` varchar(10) NOT NULL DEFAULT 'en_US',
  `user_id` int(11) unsigned DEFAULT NULL,
  `incident_title` varchar(255) DEFAULT NULL,
  `incident_description` longtext,
  `incident_date` datetime DEFAULT NULL,
  `incident_mode` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - WEB, 2 - SMS, 3 - EMAIL, 4 - TWITTER',
  `incident_active` tinyint(4) NOT NULL DEFAULT '0',
  `incident_verified` tinyint(4) NOT NULL DEFAULT '0',
  `incident_dateadd` datetime DEFAULT NULL,
  `incident_dateadd_gmt` datetime DEFAULT NULL,
  `incident_datemodify` datetime DEFAULT NULL,
  `incident_alert_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 - Not Tagged for Sending, 1 - Tagged for Sending, 2 - Alerts Have Been Sent',
  `incident_zoom` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_active` (`incident_active`),
  KEY `incident_date` (`incident_date`),
  KEY `form_id` (`form_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores reports submitted' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `incident`
--

INSERT INTO `incident` (`id`, `location_id`, `form_id`, `locale`, `user_id`, `incident_title`, `incident_description`, `incident_date`, `incident_mode`, `incident_active`, `incident_verified`, `incident_dateadd`, `incident_dateadd_gmt`, `incident_datemodify`, `incident_alert_status`, `incident_zoom`) VALUES
(1, 1, 1, 'en_US', 1, 'Hello Ushahidi!', 'Welcome to Ushahidi. Please replace this report with a valid incident', '2012-04-04 12:54:31', 1, 1, 1, NULL, NULL, NULL, 0, NULL),
(2, 2, 0, 'en_US', 1, 'مشكلة', 'شوية كلام', '2012-07-24 01:20:00', 1, 0, 0, '2012-07-24 06:22:12', NULL, NULL, 0, 13);

-- --------------------------------------------------------

--
-- Table structure for table `incident_category`
--

CREATE TABLE IF NOT EXISTS `incident_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '5',
  PRIMARY KEY (`id`),
  UNIQUE KEY `incident_category_ids` (`incident_id`,`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `incident_category`
--

INSERT INTO `incident_category` (`id`, `incident_id`, `category_id`) VALUES
(1, 1, 1),
(2, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `incident_lang`
--

CREATE TABLE IF NOT EXISTS `incident_lang` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `incident_title` varchar(255) DEFAULT NULL,
  `incident_description` longtext,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for report titles and descriptions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `incident_person`
--

CREATE TABLE IF NOT EXISTS `incident_person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `person_first` varchar(200) DEFAULT NULL,
  `person_last` varchar(200) DEFAULT NULL,
  `person_email` varchar(120) DEFAULT NULL,
  `person_phone` varchar(60) DEFAULT NULL,
  `person_ip` varchar(50) DEFAULT NULL,
  `person_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `incident_person`
--

INSERT INTO `incident_person` (`id`, `incident_id`, `person_first`, `person_last`, `person_email`, `person_phone`, `person_ip`, `person_date`) VALUES
(1, 2, 'abdelhady', 'muhammad', 'obad85@gmail.com', NULL, NULL, '2012-07-24 06:22:12');

-- --------------------------------------------------------

--
-- Table structure for table `layer`
--

CREATE TABLE IF NOT EXISTS `layer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layer_name` varchar(255) DEFAULT NULL,
  `layer_url` varchar(255) DEFAULT NULL,
  `layer_file` varchar(100) DEFAULT NULL,
  `layer_color` varchar(20) DEFAULT NULL,
  `layer_visible` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds static layer information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE IF NOT EXISTS `level` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `level_title` varchar(200) DEFAULT NULL,
  `level_description` varchar(200) DEFAULT NULL,
  `level_weight` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores level of trust assigned to reporters of the platform' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`id`, `level_title`, `level_description`, `level_weight`) VALUES
(1, 'SPAM + Delete', 'SPAM + Delete', -2),
(2, 'SPAM', 'SPAM', -1),
(3, 'Untrusted', 'Untrusted', 0),
(4, 'Trusted', 'Trusted', 1),
(5, 'Trusted + Verify', 'Trusted + Verify', 2);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `latitude` double NOT NULL DEFAULT '0',
  `longitude` double NOT NULL DEFAULT '0',
  `location_visible` tinyint(4) NOT NULL DEFAULT '1',
  `location_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores location information' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `location_name`, `country_id`, `latitude`, `longitude`, `location_visible`, `location_date`) VALUES
(1, 'Nairobi', 115, -1.28730007070501, 36.8214511820082, 1, '2009-06-30 00:00:00'),
(2, 'مكان يعني', 65, 26.818274, 30.800889, 1, '2012-07-24 06:22:12');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE IF NOT EXISTS `maintenance` (
  `allowed_ip` varchar(15) NOT NULL,
  PRIMARY KEY (`allowed_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Puts a site in maintenance mode if data exists in this table';

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `checkin_id` bigint(20) unsigned DEFAULT NULL,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `badge_id` int(11) DEFAULT NULL,
  `media_type` tinyint(4) DEFAULT NULL COMMENT '1 - IMAGES, 2 - VIDEO, 3 - AUDIO, 4 - NEWS, 5 - PODCAST',
  `media_title` varchar(255) DEFAULT NULL,
  `media_description` longtext,
  `media_link` varchar(255) DEFAULT NULL,
  `media_medium` varchar(255) DEFAULT NULL,
  `media_thumb` varchar(255) DEFAULT NULL,
  `media_date` datetime DEFAULT NULL,
  `media_active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `checkin_id` (`checkin_id`),
  KEY `badge_id` (`badge_id`),
  KEY `message_id` (`message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores any media submitted along with a report/checkin' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT '0',
  `incident_id` bigint(20) unsigned DEFAULT '0',
  `user_id` int(11) unsigned DEFAULT '0',
  `reporter_id` bigint(20) unsigned DEFAULT NULL,
  `service_messageid` varchar(100) DEFAULT NULL,
  `message_from` varchar(100) DEFAULT NULL,
  `message_to` varchar(100) DEFAULT NULL,
  `message` text,
  `message_detail` text,
  `message_type` tinyint(4) DEFAULT '1' COMMENT '1 - INBOX, 2 - OUTBOX (From Admin), 3 - DELETED',
  `message_date` datetime DEFAULT NULL,
  `message_level` tinyint(4) DEFAULT '0' COMMENT '0 - UNREAD, 1 - READ, 99 - SPAM',
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `reporter_id` (`reporter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores tweets, emails and SMS messages' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `openid`
--

CREATE TABLE IF NOT EXISTS `openid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `openid` varchar(255) NOT NULL,
  `openid_email` varchar(127) NOT NULL,
  `openid_server` varchar(255) NOT NULL,
  `openid_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores usersâ€™ openid information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) NOT NULL,
  `page_description` longtext,
  `page_tab` varchar(100) NOT NULL,
  `page_active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user created pages' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `plugin`
--

CREATE TABLE IF NOT EXISTS `plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_name` varchar(100) NOT NULL,
  `plugin_url` varchar(250) DEFAULT NULL,
  `plugin_description` text,
  `plugin_priority` tinyint(4) DEFAULT '0',
  `plugin_active` tinyint(4) DEFAULT '0',
  `plugin_installed` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_name` (`plugin_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds a list of all plugins installed on a deployment' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `plugin`
--

INSERT INTO `plugin` (`id`, `plugin_name`, `plugin_url`, `plugin_description`, `plugin_priority`, `plugin_active`, `plugin_installed`) VALUES
(1, 'viddler', NULL, NULL, 0, 0, 0),
(2, 'sharing', NULL, NULL, 0, 0, 0),
(3, 'smssync', NULL, NULL, 0, 0, 0),
(4, 'clickatell', NULL, NULL, 0, 0, 0),
(5, 'frontlinesms', NULL, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `private_message`
--

CREATE TABLE IF NOT EXISTS `private_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL,
  `from_user_id` int(11) DEFAULT '0',
  `private_subject` varchar(255) NOT NULL,
  `private_message` text NOT NULL,
  `private_message_date` datetime NOT NULL,
  `private_message_new` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores private messages sent between Members' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `comment_id` bigint(20) unsigned DEFAULT NULL,
  `rating` tinyint(4) DEFAULT '0',
  `rating_ip` varchar(100) DEFAULT NULL,
  `rating_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores credibility ratings for reports and comments' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `reporter`
--

CREATE TABLE IF NOT EXISTS `reporter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `service_id` int(10) unsigned DEFAULT NULL,
  `level_id` int(11) unsigned DEFAULT NULL,
  `service_account` varchar(255) DEFAULT NULL,
  `reporter_first` varchar(200) DEFAULT NULL,
  `reporter_last` varchar(200) DEFAULT NULL,
  `reporter_email` varchar(120) DEFAULT NULL,
  `reporter_phone` varchar(60) DEFAULT NULL,
  `reporter_ip` varchar(50) DEFAULT NULL,
  `reporter_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`),
  KEY `service_id` (`service_id`),
  KEY `level_id` (`level_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information on report submitters via email, twitter and sms' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `reports_view` tinyint(4) NOT NULL DEFAULT '0',
  `reports_edit` tinyint(4) NOT NULL DEFAULT '0',
  `reports_evaluation` tinyint(4) NOT NULL DEFAULT '0',
  `reports_comments` tinyint(4) NOT NULL DEFAULT '0',
  `reports_download` tinyint(4) NOT NULL DEFAULT '0',
  `reports_upload` tinyint(4) NOT NULL DEFAULT '0',
  `messages` tinyint(4) NOT NULL DEFAULT '0',
  `messages_reporters` tinyint(4) NOT NULL DEFAULT '0',
  `stats` tinyint(4) NOT NULL DEFAULT '0',
  `settings` tinyint(4) NOT NULL DEFAULT '0',
  `manage` tinyint(4) NOT NULL DEFAULT '0',
  `users` tinyint(4) NOT NULL DEFAULT '0',
  `manage_roles` tinyint(4) NOT NULL DEFAULT '0',
  `checkin` tinyint(4) NOT NULL DEFAULT '1',
  `checkin_admin` tinyint(4) NOT NULL DEFAULT '0',
  `access_level` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Defines user access levels and privileges on a deployment' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `reports_view`, `reports_edit`, `reports_evaluation`, `reports_comments`, `reports_download`, `reports_upload`, `messages`, `messages_reporters`, `stats`, `settings`, `manage`, `users`, `manage_roles`, `checkin`, `checkin_admin`, `access_level`) VALUES
(1, 'login', 'Login privileges, granted after account confirmation', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0),
(2, 'admin', 'Administrative user, has access to almost everything.', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 90),
(3, 'superadmin', 'Super administrative user, has access to everything.', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 100),
(4, 'member', 'Regular user with access only to the member area', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10);

-- --------------------------------------------------------

--
-- Table structure for table `roles_users`
--

CREATE TABLE IF NOT EXISTS `roles_users` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores roles assigned to users registered on a deployment';

--
-- Dumping data for table `roles_users`
--

INSERT INTO `roles_users` (`user_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `scheduler`
--

CREATE TABLE IF NOT EXISTS `scheduler` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scheduler_name` varchar(100) NOT NULL,
  `scheduler_last` int(10) unsigned NOT NULL DEFAULT '0',
  `scheduler_weekday` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_day` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_hour` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_minute` smallint(6) NOT NULL,
  `scheduler_controller` varchar(100) NOT NULL,
  `scheduler_active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores schedules for cron jobs' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `scheduler`
--

INSERT INTO `scheduler` (`id`, `scheduler_name`, `scheduler_last`, `scheduler_weekday`, `scheduler_day`, `scheduler_hour`, `scheduler_minute`, `scheduler_controller`, `scheduler_active`) VALUES
(1, 'Feeds', 1344090834, -1, -1, -1, 0, 's_feeds', 1),
(2, 'Alerts', 1344091953, -1, -1, -1, -1, 's_alerts', 1),
(3, 'Email', 1344090936, -1, -1, -1, 0, 's_email', 1),
(4, 'Twitter', 1344090936, -1, -1, -1, 0, 's_twitter', 1),
(5, 'Cleanup', 1344090936, -1, -1, -1, 0, 's_cleanup', 1);

-- --------------------------------------------------------

--
-- Table structure for table `scheduler_log`
--

CREATE TABLE IF NOT EXISTS `scheduler_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `scheduler_id` int(10) unsigned NOT NULL,
  `scheduler_status` varchar(20) DEFAULT NULL,
  `scheduler_date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduler_id` (`scheduler_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions' AUTO_INCREMENT=170 ;

--
-- Dumping data for table `scheduler_log`
--

INSERT INTO `scheduler_log` (`id`, `scheduler_id`, `scheduler_status`, `scheduler_date`) VALUES
(1, 1, '200', 1343054206),
(2, 2, '200', 1343054206),
(3, 3, '200', 1343054212),
(4, 4, '200', 1343054212),
(5, 5, '200', 1343054212),
(6, 2, '200', 1343054246),
(7, 2, '200', 1343054321),
(8, 1, '200', 1343110329),
(9, 2, '200', 1343110329),
(10, 3, '200', 1343110329),
(11, 4, '200', 1343110329),
(12, 5, '200', 1343110330),
(13, 2, '200', 1343110445),
(14, 2, '200', 1343110509),
(15, 2, '200', 1343110696),
(16, 2, '200', 1343110766),
(17, 2, '200', 1343110823),
(18, 2, '200', 1343110909),
(19, 2, '200', 1343110932),
(20, 2, '200', 1343111005),
(21, 2, '200', 1343111042),
(22, 2, '200', 1343111144),
(23, 2, '200', 1343111213),
(24, 2, '200', 1343111228),
(25, 2, '200', 1343111289),
(26, 2, '200', 1343111404),
(27, 2, '200', 1343111475),
(28, 2, '200', 1343111546),
(29, 2, '200', 1343112065),
(30, 1, '200', 1343216552),
(31, 2, '200', 1343216552),
(32, 3, '200', 1343216555),
(33, 4, '200', 1343216555),
(34, 5, '200', 1343216555),
(35, 2, '200', 1343216590),
(36, 1, '200', 1343419408),
(37, 2, '200', 1343419408),
(38, 3, '200', 1343419503),
(39, 4, '200', 1343419503),
(40, 5, '200', 1343419503),
(41, 2, '200', 1343419503),
(42, 2, '200', 1343420565),
(43, 2, '200', 1343420587),
(44, 1, '200', 1343428148),
(45, 2, '200', 1343428148),
(46, 3, '200', 1343428238),
(47, 4, '200', 1343428238),
(48, 5, '200', 1343428238),
(49, 3, '200', 1343428256),
(50, 4, '200', 1343428256),
(51, 5, '200', 1343428256),
(52, 3, '200', 1343428284),
(53, 4, '200', 1343428284),
(54, 5, '200', 1343428284),
(55, 1, '200', 1343430013),
(56, 2, '200', 1343430013),
(57, 3, '200', 1343430103),
(58, 4, '200', 1343430103),
(59, 5, '200', 1343430103),
(60, 2, '200', 1343431373),
(61, 2, '200', 1343431400),
(62, 2, '200', 1343431467),
(63, 2, '200', 1343431721),
(64, 2, '200', 1343431757),
(65, 2, '200', 1343431800),
(66, 2, '200', 1343431844),
(67, 2, '200', 1343432130),
(68, 2, '200', 1343432613),
(69, 1, '200', 1343438089),
(70, 2, '200', 1343438089),
(71, 2, '200', 1343438168),
(72, 3, '200', 1343438179),
(73, 4, '200', 1343438179),
(74, 5, '200', 1343438179),
(75, 3, '200', 1343438259),
(76, 4, '200', 1343438259),
(77, 5, '200', 1343438259),
(78, 2, '200', 1343438515),
(79, 2, '200', 1343438547),
(80, 1, '200', 1343480261),
(81, 2, '200', 1343480261),
(82, 2, '200', 1343480287),
(83, 3, '200', 1343480352),
(84, 4, '200', 1343480352),
(85, 5, '200', 1343480352),
(86, 3, '200', 1343480378),
(87, 4, '200', 1343480378),
(88, 5, '200', 1343480378),
(89, 1, '200', 1343480525),
(90, 2, '200', 1343480525),
(91, 3, '200', 1343480615),
(92, 4, '200', 1343480615),
(93, 5, '200', 1343480615),
(94, 2, '200', 1343483615),
(95, 2, '200', 1343483642),
(96, 2, '200', 1343483768),
(97, 2, '200', 1343483900),
(98, 2, '200', 1343483945),
(99, 1, '200', 1343484011),
(100, 2, '200', 1343484011),
(101, 3, '200', 1343484101),
(102, 4, '200', 1343484101),
(103, 5, '200', 1343484101),
(104, 2, '200', 1343484112),
(105, 2, '200', 1343484323),
(106, 2, '200', 1343484513),
(107, 2, '200', 1343484550),
(108, 2, '200', 1343484970),
(109, 2, '200', 1343486124),
(110, 2, '200', 1343486161),
(111, 2, '200', 1343486265),
(112, 2, '200', 1343486281),
(113, 2, '200', 1343486381),
(114, 2, '200', 1343486820),
(115, 2, '200', 1343486844),
(116, 2, '200', 1343486885),
(117, 1, '200', 1343506417),
(118, 2, '200', 1343506417),
(119, 3, '200', 1343506418),
(120, 4, '200', 1343506418),
(121, 5, '200', 1343506419),
(122, 2, '200', 1343506643),
(123, 1, '200', 1343509827),
(124, 2, '200', 1343509827),
(125, 3, '200', 1343509827),
(126, 4, '200', 1343509827),
(127, 5, '200', 1343509827),
(128, 2, '200', 1343509870),
(129, 2, '200', 1343509922),
(130, 2, '200', 1343510191),
(131, 2, '200', 1343510221),
(132, 2, '200', 1343510303),
(133, 2, '200', 1343510345),
(134, 2, '200', 1343510423),
(135, 2, '200', 1343510495),
(136, 2, '200', 1343510527),
(137, 2, '200', 1343510580),
(138, 2, '200', 1343510584),
(139, 1, '200', 1343548379),
(140, 2, '200', 1343548380),
(141, 3, '200', 1343548380),
(142, 4, '200', 1343548380),
(143, 5, '200', 1343548380),
(144, 1, '200', 1343548898),
(145, 2, '200', 1343548898),
(146, 3, '200', 1343548899),
(147, 4, '200', 1343548899),
(148, 5, '200', 1343548899),
(149, 1, '200', 1343649110),
(150, 2, '200', 1343649110),
(151, 3, '200', 1343649122),
(152, 4, '200', 1343649122),
(153, 5, '200', 1343649122),
(154, 1, '200', 1343720887),
(155, 2, '200', 1343720887),
(156, 3, '200', 1343720898),
(157, 4, '200', 1343720898),
(158, 5, '200', 1343720898),
(159, 1, '200', 1343902962),
(160, 2, '200', 1343902963),
(161, 3, '200', 1343902974),
(162, 4, '200', 1343902974),
(163, 5, '200', 1343902975),
(164, 1, '200', 1344090834),
(165, 2, '200', 1344090834),
(166, 3, '200', 1344090936),
(167, 4, '200', 1344090936),
(168, 5, '200', 1344090936),
(169, 2, '200', 1344091953);

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(100) DEFAULT NULL,
  `service_description` varchar(255) DEFAULT NULL,
  `service_url` varchar(255) DEFAULT NULL,
  `service_api` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Info on input sources i.e SMS, Email, Twitter' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `service_name`, `service_description`, `service_url`, `service_api`) VALUES
(1, 'SMS', 'Text messages from phones', NULL, NULL),
(2, 'Email', 'Email messages sent to your deployment', NULL, NULL),
(3, 'Twitter', 'Tweets tweets tweets', 'http://twitter.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(127) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores session information';

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `last_activity`, `data`) VALUES
('s3tceo15vldg9k2vhdhqhopns4', 1343860614, 'JJoN7x7Dm+L6Yq11cQLr8LS0PdRxFKE01p3Uar+HvzGi2trM7beG0Tlij1ZjchgUJkpQDf87B2bHYixRf5y5vBLlPVRdFOsmX+gzzOkBB8aIUP3pUvn6TXZj36O7IxxqiE2VdmavCbl0UMA5C4FifwZdkDWD2St8V5nYBg7+/fBOfBWH049aYxYQI3bbKtAxik9v94WFiG5hKZ3aNIws8jVhQJMOnOQgHyVm6yMyLEpJCwuw7xWs8cq0M6kOhFmrrOlY5c4uMATWg2wNPVFt1g8f8Ds7i16VSF30iDaQZu9ociE5hZjR2OCsKVfo0JqHcdyk/RSzYgDgCSsiRqiQ7l59/C3AYFAyJDcfMbTVxf8XfpNNmR5br3MHmTQXrOXQ1QeBlazdP2hVVtjB4HIeG/NHJm2lsoMeF/4HIN+pBvTipEzMSKTruVXw6+7w6FqPQagJ0NAOvpcbEmd0N6HhIg=='),
('dedup7dkapls3taogvt53h8hd4', 1343860615, '4JqeR4AFpsuHLgEyzPRhjZ+wN8YNs86EP17VdWN1inuYfpteKv8yB+/KYXUET5CNpiND637Ed/ikyRBkgbPUoW+3BLvTWA8WxWso/FKtEmbtiOwO/MKu4dRnjPj9S7994M8GY1WDPRZC+yRX7cSAqOY/KlsfLkn6AR1H3NXpIMGGdQTJ1gL2B7cSZmu7303QFpizlvXYZWOPda9IYC81SHTDvUORxeHy/YB6mhCyJ9bZSkIgaqIwxjfDXCH3f0sxuva1jWVpsd4a9NQG+q3fbPjfmVzqYUlFQRjUE1r4hWXWrDQDAXg1PZHb8RmHukq3UWcETglRrmWGhxHVI6dDdSxy/I5cwebOgBWPdj60Kw//cHgc95WwQFOAY3tUjCJ2viBP4nkWyFTv5Q2CtRO3D2bC81mxybVaKF44ZKgLST5uLK5s4m1oJYcHE2m9ozIMXlNn3EXeBhCG9jEthuNiHVqsWT2ssFk8tMnjYxnL452L42miDaay2IX44Rk3bpD30ut2NMvxMlFlSQfx9FZHRZJymxaJN8IBLs2k7Y+gl5+r/iFNymnASOeEr0q6qhdU6oUmLpyB4XNknciq9Qi3O29IvdpQ/JtSb9rrnRbo5oPx1XlPFsCu0WXS1+2aBDPKD+nV0OsTfP52/D2gfTYjOCEjPuEO0Ql6nvkL1Kgt6/mX2XEfVusVTxdI4uBc1CuSoBSbDvrEA/5C4x4Po3aDzIh0nO8xsuATQY8A6OFGhQfa6EbwfiuonmpoHjXCmA/MeroVpHUzLvek54QdxG1QfwDOIT14ZBTyBf/2GlO/TBARn73jti1RoeTNj3D1uag+RwzzTK2muCAYF+PAQVAHW8fBFB6ucDNqgkeYtxAUg+pCDg+TXlD6aJeQ4fVHUYtYNO5CKE9W22XlVKAc8RWE3f5rz+kDzgD+LR+ZFAi0fpaJl03rKP6/VAn7FH8ignEAxaeC6hf7MKny5eDwgBJmTZcgamY3q8JUMxPrJ44vdVINoyVTquryZTV4/KQFhO1U2uKzbZHawRcsFtn4PCZqcMt7n2V0efv4W61SY+HbS7TMzrZaYr9N4sz2HdjUc0/9gmN62iYDBp6mgcgOGMBIQW9Lw/6/BOA4cpUk9uccrdJoPI0JNLQR+QMGQfQC9+xalf95BllYZdf9YN47LXM3HtH2Rp20F1HH5Z5pjalGy+Zx5A328v1iKwV9HHlfip1KYFCpGaHs5QtJ4F7g8E3G2TPet8nvJw0IB5Hy4U1Ua0LJSVEmGE1LtGjrLFrd0aQ4o/d4DfjUe1diUFIGpl0oTFomgu13NW1PP9qQ8Y8cqpNEXZvNk11nwiWprcNLxgcB1EyIM5nnW5jFDcoMr2u39uKzPRUQQHJBNTIs1sq6qLwt7w=='),
('7dup0qpf7bapcprb3meqvvhc81', 1343902905, 'NiGGwKy5lz1zJw4jT1UNhUUKBVQ/5Imu+/UuDz9kCVGQV4s1+5DO2gInJLFj4HwudF7zEucnSAUb0ElbuGB/ed8VR9RFf1VovjX1tdqhNudK6QswNCOsoAsFO4gPLdjF9FTbdo96XBEqJhKT6EIOl4wOSRGc2dQ9Bh2bUxVHVQAyC+/ii261FjxRFWQlqkqSTSB0cv+KQr6IyHrn6MadN4uro3h/S7vMmQ7uBzpMJY2CLoZeMp8unEnRrK1DcbvBDhC9fw6M+++OugBhcaeHqwwmJYHrzznD/BHuHa4rnrIvX1ELsPSGgtVin7xHtvM7a+2w/bDcpeBNjL18SnuJarur90JAxhhhd3aXot3XbhAcTUw8DvjTPtRjWdFIoyzBn1ufsGGiaAKbE7xTHWYt9t5WriKlYvXwwI2rQnvj6DCy3/xKu0OSLCdsmF1aQ4e0n247bzvA3YJpj9v54rLhVQ=='),
('et6fvu97fr2as9otcq93efg7p2', 1343902975, 'CS23mW4PePKtk5yDbVyr192EgeSHZ2PaYU1fDGx32Xr13G3IhfUvoMYQW4t3nmE7nPQGB2gxPOaY0px2PRWjGSdb18sm/PxT3hbDyIBSYIIpZpu2y0GwSRAyaO0e8EyMljSyX5k62VYgW5Q8v8G/6mMR+dvOtGtT3ubJr7/U0fXQxOpWHkXe7er39Op6d58YE9qFt2dVltCDz9If5yFTw55tI7J2MIYK4Q2G/+qeyup51V1QISI/jR58tyGrhhEAAYvURJYTZ3QGmSXt18DTPDYfAYUJL8yZkYrkTo+lvqIivUwyzwgwO7JpXUKBGbZZzzEaJuHu+e6QefiPtBu5Qt5oH0LsDlnXC1uWQK17rYpanOFXzIT5CAHiGuMqW7/3u4peoDJuv7dtCMhpNcvgqCE3js9TO8wRZFbfUK44McdFTCWrx5EZX3Um1g86eV/n+lfg0w/mWD3l8l1wwKCsPSaMtjiSFVZDgowEmVFq7D5Kfo/lsjtA3Pc4cOiy58E9yFgCh8K1DhiGOWvj206K0oZQiLNsfwTacG6HZ3PBJLXm'),
('89gv14bndsm09iriech7tf8vl1', 1343720988, 'g/94fOkeiNk2cc0YkVGibaRa3Cbfg4tUmw8GdEAeZVYk9lLFQEyVG1MD8tS311456IjE8xuXkmNptHvugK8EkjlEIztkXZUW13DK7pYpoKLrtkc0aRWfEZ81lKEIycCHcJmJOx7QQhbv+GrzkgtISbiZPvTyRUZ4/KZL2+Tx9MPau/D4x62JdfNuqbA932dTSfrzql9JyrU8MtyzKEIWJGS42NpVWYMi65R8bMhzPhxHQz+RkNbpvS56UkbEau9rgHLj1WfZA6y7xqozW5fpAAgzA5/8eQ5UH54htfO8dEXX8zTIL1d5z+AF/2upzViTFmPPOp6Y6/8fwXDb9M3RIOkLJO4DP0Zge5R3iRNS/IuMMOTYIE9LDj1iANMwwQ/h/A1fzQYUDKBV4Pg5YdpateNMQ7mCwmQFeQDmw4BQp0aKNfBFEl2+6lk3wVuu2Sq98J95eAXzyoP+mONmGFLa9jGHXfe/e0LQk6MOp1d5L/bn7PZKRQsReVudxy9vhVbb9d+wq2QmUIuQjY97zvHimXtzq4WSeATjoDu1buO1Z3wgbvS6rP/wratwsNxFcw+rkwH6d8B/5GPd1G43GJnrWwhTd+COV0l7ybBOLoSv+UauRR6pqTty/m1UDIQv8fHDV+vIQBjJEREI98rqirbweg2J0TL8WDvZY902sKijoOKB9rABZ/iJbDgNc5jVFNsQ+J+XrnEwXCYa4T252I/eDt9N4RrzLG0E15DhbfcQTBnJIqcfPJkWyr3+fCcnUsn4T8iQfCozS9TkSEVY/c+ZWNPlNCEDygc6Zk53F0W6MfvcGRx6GN/UisS2PdSnrIIkTnSH49M73O9sDioHUG9bYXB1ajoZj1lFd+sGOlC9aTgADPNCBtfu6bE7ipeYiKXFKDGMSf73axp6Me3OnIEN2Ohs+spcTDI+d6Gnp/VUHe90zG4TjZPcb7le6RKM5oINBxiKVB9SCfPfkpANfOwDjPsMn7LRW76HV1Bi2zduXkhROflNzJ0py2xkfFBfYfDBC//GJm7NLhei4f4HxnX7KGyF8y2Q+dNOOC44oBEXCR8CzpEtUvVkI6UtgoWD5N9GLJlkwZQ6eBbp4H/nsFPiEwpwB2xrzNY5llfLqx0bM5PATS0d3ufsAZe6doY6dJykad6ILQDWl+IQ6o3t7hwFefLQi8PhOA2aMwJVyhzNv2nM172lPjolfSZHq4qWjrOVv9HGwhq0cQHaVS+CfXzV5rTfAnGiQai9x68DZuifdnJCXFHTTu0HxByG5rR98yEyhaKp85Ut+I8nsiHh93kEoMDl5J3ROrH9TfaHnRUdW0ok'),
('0or4s0fjdvvpc3n7dk9851jt23', 1343649022, 'jxzqICzhvawLlZgt3fDcsu1Bg4JhpBS+TSi6v6V/HlVC3eoCf5iBBA/Mk1assXiebxc1wFhh+funEWowloBkNqwkYeRXDuS+kVxMrh79cTg0W9VekJG4H2rxrziRVfmUImJSKfHDGq22bN4yYOZIqjL6Yq/kiSs9tthmt4Hv+94pg6rq7m2MzBXoWdHWTDr1VMvjbN1blQZ2AAm2WI95kyQBF06rTP7eaFrbz3MoyQfMmbCg6ySuJS+PR/HWJ8k+BqSJPY6q+ewEiwh9EpMBYZNmafGXrEwcczYd/qPw/hjQ5jxD2hbR/dntqoLUAv8+EkWE7h8J5thTb1UhBf9ErBvk4NllEWNXh/MCljsxToQZfrMy6XjKk9cfRmImQn2sMm+kY5QlaUABUm8hj3/egze2ZHPIHpuHtjpDwA6CjaJJqiFarLLGVdEsZRXfyOFkh6raaomn9sQm/bUitmvumQ=='),
('sbl2v6hi5lj8b07ku9118kha30', 1343649122, 'eEYDl3H1kAk6P6d79+nlIc6FZH19OuIZfIkWGdYjz8JR93wlAguIUgYnIUCLI568uL3FbwkbXHcQ+8MuRKJd1b9bRT/MYRh3Km4pdn3UPMho827a1pGoRvCCUu3obVjZLVRCVPYRq0Ba8xq6kBstVnuTZyiTYRQDbD1D+6+8ngs2k0lr2/aMFRWG5mbo0bcCIRX/jv9mM1btSHmMZANp7AwFVryyNW80wUnu3GDalv2n2rB4+EDBPOc21spXba6pfhf1xut2HX4lH4wJ9PJ1yjRpN4bwALah9t9QwZQgj8eGGnM1a0SE2U3/PBqxopQ2zE1skAZTy8F4lz7d+mHC+Stv6wnOfU9PnAU4c5pI1i4UXgC62DU0hmGdrVCksspYaJTodGm3RbZlsv5vJUIqfsUXIpgrrO/oSZUM+gSfi7S/aKsTBQFcm37DKb6M6skKslUqC1Ic4RK8Sof56vxqwSk8MPY3RKVc0RIPh4fVpsSJb8T3iTCxyIiEUJSy43uDv2lsTvpEx6dMUWeXZkWkBvffm79lpTBazToIYcScJ3Mw/6IBXmy7lg5bJh12QV7FRnbp+RsOWpQjoBd/GkK5OJX4tep5gSuVCr9IFXyszbJ9t6dPUjwhl13VwbNeSM/j2RbUSTOYnqF4UrTAqIueBDCrlKY9BtqgCdBzJVu5oIkHKSFqxPkc7MrbsMsHztlKO5r6I3xirenlgVtS8M5jnJnnhnqcfHQhnJDmDOvIPjFsdof2ciMOy7Qv4ot56hRHfX56MvEAp+oGbzfe4UzRiBvK3SRKR9jWOSKiU7GSSJunS9B+preRCbg/dI1/SSCFd00m/XO9ISAMzUqsDs9D1v6r9DdUWFYAA4+A1eXcwT/WCOykTO+5vhg9gw0VhoamFRV1vqBnyEOCN19Wwf46MWtEkJoB2wlKAw297LES0Jpka5i9Dp3YM796T9Sh8+/H8Jw8D9B0t3T1Kw1X+lYAPiwSK+1w+eaz1ZnIAG4tk9LARWBhVyboH/XSVK08GiNXzEYKbZUbBQjaiscwbyDvvx9ibvaqCqxX/d/EDCmoz4mGZ+P8dmjd+F4AZ64Ya7ZJ8VJHfBl2wr7X7qxVVCaRtwCg0zzzbRQPsa0DnY4vhXIn6Lqlph1lDc0vIzSdw0hs550W7z/xYR7h222/SFJB4Jn+UNl2yovOjGKQ9tPEhRBS3oj59dOs/sVMjXMPdD8loy9e7aN76Qp0OaEMFXXb285hEChiEAOtHOQV4UAoYm7Ihly+Q+gMYwDYwE8fgbQ210OUnLT5EGLvfODgSExi5dWCsI8ZedDXvVSkFrRvKjonZNbNWvveGlqiZPe4f3jEyHHHzUk3yIVM9s81S9YDvciPkybBTzemcDPv+++j9+PIYQ=='),
('ka3msm1rptf1uvi88imu303pr4', 1343548899, 'fSpHllBZchG60B65adDvNyRGgpUcS95fnc/xwpKxNdM8f41J83mUME64l+75DkVzMWkbgQwHdWxxvn1iMZhnw3KeoaZEHEYZ0WILvkOjTY79dDyWrMzepyevGVVF2tTNQY6aqgOR1LSZvB16bKFYVxHov9YIY1va6X+z5W3e2u+rrcTUPoqpIn2C5OMMrn26ox9sDqhSrePMf37l2c5InN+xKflOhqe+GdXnReePLOxDa7o3j3YF58oBx40bt8ffEa1DjIjo+iZOAD5RCZKPxQObgDQuPsLbs2OffXJkbRSSJUcM2pxUdjrXzQJH+oPsyZ0bhwLZXeH3h+SExf7eLDbqt0NlBpA3xXg3DMqrYP+bmZXoYseMASZGLXI6zDAnGoeWN6hSqgWUVkfNBj68iqWlBg8Pz/zaVs1QKnqJrSywuw2+6/mDnCl4frvkyxyeUlegfYddoe+7/kWJS08gPYB5FGLXAtTf8vXK1Jhf5AFU1gcFCMp1ri3T8ua20USrm3iw8JoSajs7kl/r9Z2MvBtNmqBGbS82oqRvjCQZehjFxbjdxJfOnAKC+D8FtZmvc1h/tRAXX1bNMsMoovuOxOjJWgNzIxMcBThjTh06i69hZTNiyODk2ct01T0ZX3pdGOmLxPg95LxSdQMclQALVSgB2NeRj2rc/MfI5RXvjAh1fb92/XKUtVTOCnxOiUvGAdeA0lcKZd/Tojtb5Gfl3SJ1osNr96EOLQkw1texn5DpsUpQkv6cY2B4Av8hb1/duouOc7098q9DpB0WrWvnz33I8kXpMc3Y1ew+8sRkAMuQAIkKMlVyAXFD2Gu2m9DXagf9eoNt1+7yx2iG/i0bVAoG4jCaK0seEAOtqnvQV7wHtuj0JxOxadJykkZwdiHTuOt5pwWVCbR36PLXHVEuJ5RyqhcfUsYsjpyl3amjsTVqWw61LwlLe5FRUCayLQ8JhsKAcWypu1s68aYbNHun6GkmmmnkDCfudT2PdurhMJCtgE5+cgFQ4fQWfw5fW/p98040TpK2JVo3vZUSV+lhLzyaivV2wRdcQkzUk+447NYXQ98NVqmqvgCz87mUWR81lnPkCBeJTxAJaAKEVDn1aW6C852+iUdZppBnuz8uLwqntfvzpw6y3HtjbrQYZ8g0QCzu'),
('gl4vd2fp1s8uh7huakqqb3a401', 1344092004, 'ma9EZFqKe83flS3OjYO/VwC0FeRNqmmXKtpjxxWiyZHBi7r6E/pq5dhNyLMhkdor/lS+NgCaPr9O39lrjDJE6WtemaWFpNVsbLxvUCFWQ8lHrxpYdysbEPKYQvxOHai5NpLsVQpgaaq0jjfwr+9x82pdUrZNODZqpB50y7tQy6sR/rSjTR6itFSCxxf6oITZGrMjVMCDq2rrMjXi869DDQPaazh6HnO3oT22m9hB/UTw5VrgjjIyB8A4Y+pV6P9wfAaQmh03bUL5QhHqaf3TNVt3FyZSf/iR0+VLOF6Fq6jxlQvoFwSugACEVPIfaIZRFmOhSgQ9B9sFDVRWobYmUbh4KNuoG/uF+v6zkYv0kVNXx575KrW6A12LMaFAlDNHhLxSxcCpxCOQjJKQQdGGnt15BNBfnc6EdWUXfnK6LDDQRoKdVstWSNLiVURBhjao7ldbGLQIPZlnwTQ4oYcuDAxqNZqpZE0vKFhWSexiEwIJwMmo9fzcJzGeEQCXNkUWo+MWhtmIH+7UmQIQj26OjveAMcM1Ngk0tlXmbOiMYEjEIS/Sf9JVwnkRclic0bsTZRNMqH0gVu+WV4tOGyidyc8FPTTMQHjrVqVQ/FB5rCN1Gv0WFfJDjsWS9xV7w4V+4w/athX0A1qAQpRkyEmmGBv0QlYeaxwCxjXJ8qQlN7tttT9s3J+jtG2RD+8wZ0DSedqBW33byRHv8fcrMhmhsmUI5dT5ZmwVhlT2k2NqFrR6ZhEeI+91cxD/8A1EC2h/WDBbOVGTqKxHtYO/AbAuHysrKLGxMIpWOGmqP3/IJeSSieb8mHPKyXbYdvJTWR56Zczz35F+KVT3DAIXuA+4MxZvrc7XCYPYWnHZWGdsf1n9TPaX8li6uXwinH93Vc1QfSiAcTxuWzmyekSBONUvALzZ1+k6NaZA+aAqdWSvbDqkGfXvJc7zcL9LRxxr8MFmEGhL7Rl4RIC4rMvhrwRqNffuaUXEeoxz/juekyNnPS84n6zvjwQ+G5V87f6uEEm2iHeNd6vObwZ1d0hkVaORakjuE+Aw75Kddi17ffvMsS9QjYtYMffZhPyGuDmXz6F07XBlPQfGqcu8LMCUrWOrQwckIYuqwuhPti3oyNPyQQ1dG9AYxazpkiZpjhGwHX3Prj7ozHa8jTu6geVFzhSCAxIpUZfZXfiYqnL8fzRfQF8zRmF9NaNJpmuUBprlhqAykI+wSAO+jkBym2JXq/do91D+d562bEHQokgxTpkhL/sfe5ibZcg0u/dOb/rWcwD6qSgXSJN7TqsMqXeCqy66QGL2k+2oX/tOskOw21E4iUHu'),
('bgo8ts3ghnos5fslqltho8sss5', 1344090956, 'WGrPV7XcGlUTItf81iLWC5zTUfEFUg+j1/GQfm1i8mptOYXbVPhsd5KeT/PnyQINW/AeSrNOtKO81po/wCt0FkcCiGdldG5a7tVb9cZQTsTzXhn0APe1lZI6+tLndtDfZnEKWPQcT7OfvaMYIMrqEW6Rj/kbqynFTG0hltJczolJonXAwCj1ShyzA5UoynqPW0kJqZ6EQ0dm7aXuM4rYH1BDmb5v+q09cu5bD1rbPCTiL5mMcx/qPGU8BWmjaIJxPoemWxCpYTh8DzJTE6Z9Q/aBTUV7Q+K+82tCuKFyNVG4qnAst/FnHQrojnaByQgjwUbCP7T0RvSrEqvFfV39vrlcgcDFErvQfbc35DBW1YR7va1rmJOE824/AHHzprrlWhvOa+qVY4btRs45bo2Zpy5mnaz+J8QZ6RSNRXXCYJhzV91llBEn9PWm6vX6cQQm9cSZtUAXnH0f45R78gfpYnWETbpBWvWosOVWcAFjOrzUMQ5LAuQ9PMSkBr+foPrRXcbduOlhoBCuXjVlALUY1FobQ9QZMda6F3623UoyDoQkeNowPVvb2X98VZczfRNBOLXde9VOv9oEq1HllRlUtxuVmL3Yfoco4Mg+bx0Akd1hdq+3tLSyC0Govy11l5zMsvM77UgEHWkqLagXZxvhiOuajEXW2or63Qlcm4zjf12g7m0qh5xXkR+M5+/UWzSuCaqgb//FEwN9vb/xk0t/Go2fGp07qYyxZsW2ARF7z5Cu29Z6wTsr1NYpVmLBwdYI+hH+Tr339p8Z1ksT+AkufRHeFz3/wt+jHkP8S9yZ+F9qcYZ1s7tRCj46J9ps4zLSPqZl4E0YQgvnz4kKnWT923gqjJ+TVqlp3nJiQQNDcOh1w690WgTwXlxkQ8bmKUrguYM5a22kA9S5MGiTaBce0MIBgXwoHlmspwfcXWwKqv6wPnKy94WeCPu9eejekmD17TpzT0uFJYwVEyi21letteVgtrEaHTvNqIga0poXdBQCFordmHofCXVfup1r+d1c2uNmdys3cEiatREpvd/OZrJfNvHvOeSr+kyxR92IehSk4lEq5/y39ncddqOuCXV/fSao2Y3zliCevMZlTmgEDsnlY83OIy3PWnPK9xuk8wimXEeW6rkd8pTrAY9GYxsZxjhJ');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_name` varchar(255) DEFAULT NULL,
  `site_tagline` varchar(255) DEFAULT NULL,
  `site_banner_id` int(11) DEFAULT NULL,
  `site_email` varchar(120) DEFAULT NULL,
  `site_key` varchar(100) DEFAULT NULL,
  `site_language` varchar(10) NOT NULL DEFAULT 'en_US',
  `site_style` varchar(50) NOT NULL DEFAULT 'default',
  `site_timezone` varchar(80) DEFAULT NULL,
  `site_contact_page` tinyint(4) NOT NULL DEFAULT '1',
  `site_help_page` tinyint(4) NOT NULL DEFAULT '1',
  `site_message` text NOT NULL,
  `site_copyright_statement` text,
  `site_submit_report_message` text NOT NULL,
  `allow_reports` tinyint(4) NOT NULL DEFAULT '1',
  `allow_comments` tinyint(4) NOT NULL DEFAULT '1',
  `allow_feed` tinyint(4) NOT NULL DEFAULT '1',
  `allow_stat_sharing` tinyint(4) NOT NULL DEFAULT '1',
  `allow_clustering` tinyint(4) NOT NULL DEFAULT '0',
  `cache_pages` tinyint(4) NOT NULL DEFAULT '0',
  `cache_pages_lifetime` int(4) NOT NULL DEFAULT '1800',
  `private_deployment` tinyint(4) NOT NULL DEFAULT '0',
  `default_map` varchar(100) NOT NULL DEFAULT 'osm_mapnik',
  `default_map_all` varchar(20) NOT NULL DEFAULT 'CC0000',
  `default_map_all_icon_id` int(11) DEFAULT NULL,
  `api_google` varchar(200) DEFAULT NULL,
  `api_live` varchar(200) DEFAULT NULL,
  `api_akismet` varchar(200) DEFAULT NULL,
  `default_country` int(11) DEFAULT NULL,
  `multi_country` tinyint(4) NOT NULL DEFAULT '0',
  `default_city` varchar(150) DEFAULT NULL,
  `default_lat` varchar(100) DEFAULT NULL,
  `default_lon` varchar(100) DEFAULT NULL,
  `default_zoom` tinyint(4) NOT NULL DEFAULT '10',
  `items_per_page` smallint(6) NOT NULL DEFAULT '5',
  `items_per_page_admin` smallint(6) NOT NULL DEFAULT '20',
  `sms_provider` varchar(100) DEFAULT NULL,
  `sms_no1` varchar(100) DEFAULT NULL,
  `sms_no2` varchar(100) DEFAULT NULL,
  `sms_no3` varchar(100) DEFAULT NULL,
  `google_analytics` text,
  `twitter_hashtags` text,
  `blocks` text,
  `blocks_per_row` tinyint(4) NOT NULL DEFAULT '2',
  `date_modify` datetime DEFAULT NULL,
  `stat_id` bigint(20) DEFAULT NULL COMMENT 'comes from centralized stats',
  `stat_key` varchar(30) NOT NULL,
  `email_username` varchar(100) NOT NULL,
  `email_password` varchar(100) NOT NULL,
  `email_port` int(11) NOT NULL,
  `email_host` varchar(100) NOT NULL,
  `email_servertype` varchar(100) NOT NULL,
  `email_ssl` int(5) NOT NULL,
  `ftp_server` varchar(100) DEFAULT NULL,
  `ftp_user_name` varchar(100) DEFAULT NULL,
  `alerts_email` varchar(120) NOT NULL,
  `checkins` tinyint(4) NOT NULL DEFAULT '0',
  `facebook_appid` varchar(150) DEFAULT NULL,
  `facebook_appsecret` varchar(150) DEFAULT NULL,
  `allow_alerts` tinyint(4) NOT NULL DEFAULT '0',
  `manually_approve_users` tinyint(4) NOT NULL DEFAULT '0',
  `require_email_confirmation` tinyint(4) NOT NULL DEFAULT '0',
  `db_version` varchar(20) DEFAULT NULL,
  `ushahidi_version` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a deploymentâ€™s general settings' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `site_name`, `site_tagline`, `site_banner_id`, `site_email`, `site_key`, `site_language`, `site_style`, `site_timezone`, `site_contact_page`, `site_help_page`, `site_message`, `site_copyright_statement`, `site_submit_report_message`, `allow_reports`, `allow_comments`, `allow_feed`, `allow_stat_sharing`, `allow_clustering`, `cache_pages`, `cache_pages_lifetime`, `private_deployment`, `default_map`, `default_map_all`, `default_map_all_icon_id`, `api_google`, `api_live`, `api_akismet`, `default_country`, `multi_country`, `default_city`, `default_lat`, `default_lon`, `default_zoom`, `items_per_page`, `items_per_page_admin`, `sms_provider`, `sms_no1`, `sms_no2`, `sms_no3`, `google_analytics`, `twitter_hashtags`, `blocks`, `blocks_per_row`, `date_modify`, `stat_id`, `stat_key`, `email_username`, `email_password`, `email_port`, `email_host`, `email_servertype`, `email_ssl`, `ftp_server`, `ftp_user_name`, `alerts_email`, `checkins`, `facebook_appid`, `facebook_appsecret`, `allow_alerts`, `manually_approve_users`, `require_email_confirmation`, `db_version`, `ushahidi_version`) VALUES
(1, 'morsiwatch', 'تعالوا نراقب', NULL, 'obad85@gmail.com', NULL, 'ar_EG', 'unicorn', NULL, 1, 1, '', '', '', 1, 1, 1, 1, 0, 0, 1800, 0, 'google_normal', 'CC0000', NULL, 'AIzaSyDumcJZ43iOQ6QYWBlJfbJblPk3JfOrXWc', 'Apumcka0uPOF2lKLorq8aeo4nuqfVVeNRqJjqOcLMJ9iMCTsnMsNd9_OvpA8gR0i', '', 65, 0, 'nairobi', '30.044398340549', '31.235798137513', 7, 5, 20, NULL, NULL, NULL, NULL, '', '', 'reports_block|news_block', 2, '2012-07-28 14:36:00', 42805, '09da814c2a285f03efb2216b727637', 'abdelhady', 'abdelhady', 25, 'localhost', 'imap', 0, NULL, NULL, 'obad85@gmail.com', 0, NULL, NULL, 0, 0, 0, '90', '2.4');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `riverid` varchar(128) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(127) NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` char(50) NOT NULL,
  `logins` int(10) unsigned NOT NULL DEFAULT '0',
  `last_login` int(10) unsigned DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag incase admin opts in for email notifications',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `color` varchar(6) NOT NULL DEFAULT 'FF0000',
  `code` varchar(30) DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `public_profile` tinyint(1) NOT NULL DEFAULT '1',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `needinfo` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores registered usersâ€™ information' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `riverid`, `name`, `email`, `username`, `password`, `logins`, `last_login`, `notify`, `updated`, `color`, `code`, `confirmed`, `public_profile`, `approved`, `needinfo`) VALUES
(1, '', 'Administrator', 'obad85@gmail.com', 'admin', '3b01bba5b996897a42d7ae88f81b6d2c63d5c2bdf2ef2dd23e', 18, 1344090845, 0, '2012-08-04 14:34:05', 'FF0000', NULL, 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_devices`
--

CREATE TABLE IF NOT EXISTS `user_devices` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Works with checkins';

-- --------------------------------------------------------

--
-- Table structure for table `user_tokens`
--

CREATE TABLE IF NOT EXISTS `user_tokens` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `user_agent` varchar(40) NOT NULL,
  `token` varchar(64) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  `expires` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_token` (`token`),
  KEY `fk_user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user_tokens`
--

INSERT INTO `user_tokens` (`id`, `user_id`, `user_agent`, `token`, `created`, `expires`) VALUES
(1, 1, 'b73d980f5f92d2f5254a48b2de83829049cc9acd', 'X29EePN36bBMkCzA79E1pxoliCLPMLwY', 1343054203, 1344263803),
(2, 1, '95a8dbaf745bfa784f2a3d51a3f98f789617bd71', 'TINI5gEaptp2frrfgEwXYLxuGTDCKBpq', 1343112049, 1344321649),
(3, 1, 'b73d980f5f92d2f5254a48b2de83829049cc9acd', 'LQugHN75gH1V3V151hhgHebdOfMORY44', 1343483634, 1344693234),
(4, 1, 'b73d980f5f92d2f5254a48b2de83829049cc9acd', 'xdvFDdoE3FbgKjB8CgrvSs0C2Rjn81kX', 1343510487, 1344720087);

-- --------------------------------------------------------

--
-- Table structure for table `verified`
--

CREATE TABLE IF NOT EXISTS `verified` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `verified_date` datetime DEFAULT NULL,
  `verified_status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports' AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
