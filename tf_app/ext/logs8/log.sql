/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `log_pageview` */

CREATE TABLE `log_pageview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(64) DEFAULT NULL,
  `date8` char(10) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `i_date` (`date8`,`count`),
  KEY `i_url` (`url`,`date8`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8;

/*Table structure for table `log_ref` */

CREATE TABLE `log_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date8` varchar(10) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `i_url` (`url`(255),`date8`),
  KEY `i_date` (`date8`,`count`)
) ENGINE=InnoDB AUTO_INCREMENT=586 DEFAULT CHARSET=utf8;

/*Table structure for table `log_uniqueview` */

CREATE TABLE `log_uniqueview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date8` varchar(10) DEFAULT NULL,
  `id_uv` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_date` (`date8`),
  KEY `i_uvid` (`id_uv`,`date8`)
) ENGINE=InnoDB AUTO_INCREMENT=611 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
