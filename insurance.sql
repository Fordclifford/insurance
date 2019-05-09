-- MySQL dump 10.13  Distrib 5.5.62, for Win32 (AMD64)
--
-- Host: localhost    Database: mifostenant-default
-- ------------------------------------------------------
-- Server version	5.5.62

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acc_accounting_rule`
--

DROP TABLE IF EXISTS `acc_accounting_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_accounting_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `allow_multiple_debits` tinyint(1) NOT NULL DEFAULT '0',
  `credit_account_id` bigint(20) DEFAULT NULL,
  `allow_multiple_credits` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(500) DEFAULT NULL,
  `system_defined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounting_rule_name_unique` (`name`),
  KEY `FK_acc_accounting_rule_acc_gl_account_debit` (`debit_account_id`),
  KEY `FK_acc_accounting_rule_acc_gl_account_credit` (`credit_account_id`),
  KEY `FK_acc_accounting_rule_m_office` (`office_id`),
  CONSTRAINT `FK_acc_accounting_rule_acc_gl_account_credit` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_accounting_rule_acc_gl_account_debit` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_accounting_rule_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_accounting_rule`
--

LOCK TABLES `acc_accounting_rule` WRITE;
/*!40000 ALTER TABLE `acc_accounting_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_accounting_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_account`
--

DROP TABLE IF EXISTS `acc_gl_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` varchar(50) DEFAULT NULL,
  `gl_code` varchar(45) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `manual_journal_entries_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `account_usage` tinyint(1) NOT NULL DEFAULT '2',
  `classification_enum` smallint(5) NOT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acc_gl_code` (`gl_code`),
  KEY `FK_ACC_0000000001` (`parent_id`),
  KEY `FKGLACC000000002` (`tag_id`),
  CONSTRAINT `FKGLACC000000002` FOREIGN KEY (`tag_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_ACC_0000000001` FOREIGN KEY (`parent_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_account`
--

LOCK TABLES `acc_gl_account` WRITE;
/*!40000 ALTER TABLE `acc_gl_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_closure`
--

DROP TABLE IF EXISTS `acc_gl_closure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_closure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `closing_date` date NOT NULL,
  `is_deleted` int(20) NOT NULL DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `office_id_closing_date` (`office_id`,`closing_date`),
  KEY `FK_acc_gl_closure_m_office` (`office_id`),
  KEY `FK_acc_gl_closure_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_closure_m_appuser_2` (`lastmodifiedby_id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_closure`
--

LOCK TABLES `acc_gl_closure` WRITE;
/*!40000 ALTER TABLE `acc_gl_closure` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_closure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_financial_activity_account`
--

DROP TABLE IF EXISTS `acc_gl_financial_activity_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_financial_activity_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) NOT NULL DEFAULT '0',
  `financial_activity_type` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `financial_activity_type` (`financial_activity_type`),
  KEY `FK_office_mapping_acc_gl_account` (`gl_account_id`),
  CONSTRAINT `FK_office_mapping_acc_gl_account` FOREIGN KEY (`gl_account_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_financial_activity_account`
--

LOCK TABLES `acc_gl_financial_activity_account` WRITE;
/*!40000 ALTER TABLE `acc_gl_financial_activity_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_financial_activity_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_journal_entry`
--

DROP TABLE IF EXISTS `acc_gl_journal_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_journal_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `reversal_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `savings_transaction_id` bigint(20) DEFAULT NULL,
  `client_transaction_id` bigint(20) DEFAULT NULL,
  `reversed` tinyint(1) NOT NULL DEFAULT '0',
  `ref_num` varchar(100) DEFAULT NULL,
  `manual_entry` tinyint(1) NOT NULL DEFAULT '0',
  `entry_date` date NOT NULL,
  `type_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `entity_type_enum` smallint(5) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  `is_running_balance_calculated` tinyint(4) NOT NULL DEFAULT '0',
  `office_running_balance` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `organization_running_balance` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `payment_details_id` bigint(20) DEFAULT NULL,
  `share_transaction_id` bigint(20) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_acc_gl_journal_entry_m_office` (`office_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser_2` (`lastmodifiedby_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_journal_entry` (`reversal_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_account` (`account_id`),
  KEY `FK_acc_gl_journal_entry_m_loan_transaction` (`loan_transaction_id`),
  KEY `FK_acc_gl_journal_entry_m_savings_account_transaction` (`savings_transaction_id`),
  KEY `FK_acc_gl_journal_entry_m_payment_detail` (`payment_details_id`),
  KEY `FK_acc_gl_journal_entry_m_client_transaction` (`client_transaction_id`),
  KEY `FK_acc_gl_journal_entry_m_share_account_transaction` (`share_transaction_id`),
  KEY `transaction_date_index` (`transaction_date`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_account` FOREIGN KEY (`account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_journal_entry` FOREIGN KEY (`reversal_id`) REFERENCES `acc_gl_journal_entry` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_client_transaction` FOREIGN KEY (`client_transaction_id`) REFERENCES `m_client_transaction` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_payment_detail` FOREIGN KEY (`payment_details_id`) REFERENCES `m_payment_detail` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_savings_account_transaction` FOREIGN KEY (`savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_share_account_transaction` FOREIGN KEY (`share_transaction_id`) REFERENCES `m_share_account_transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_journal_entry`
--

LOCK TABLES `acc_gl_journal_entry` WRITE;
/*!40000 ALTER TABLE `acc_gl_journal_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_journal_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_product_mapping`
--

DROP TABLE IF EXISTS `acc_product_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_product_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_type` smallint(5) DEFAULT NULL,
  `payment_type` int(11) DEFAULT NULL,
  `charge_id` bigint(20) DEFAULT NULL,
  `financial_account_type` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_acc_product_mapping_m_charge` (`charge_id`),
  KEY `FK_acc_product_mapping_m_payment_type` (`payment_type`),
  CONSTRAINT `FK_acc_product_mapping_m_charge` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `FK_acc_product_mapping_m_payment_type` FOREIGN KEY (`payment_type`) REFERENCES `m_payment_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_product_mapping`
--

LOCK TABLES `acc_product_mapping` WRITE;
/*!40000 ALTER TABLE `acc_product_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_product_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_rule_tags`
--

DROP TABLE IF EXISTS `acc_rule_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_rule_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_rule_id` bigint(20) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `acc_type_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_ACCOUNT_RULE_TAGS` (`acc_rule_id`,`tag_id`,`acc_type_enum`),
  KEY `FK_acc_accounting_rule_id` (`acc_rule_id`),
  KEY `FK_m_code_value_id` (`tag_id`),
  CONSTRAINT `FK_acc_accounting_rule_id` FOREIGN KEY (`acc_rule_id`) REFERENCES `acc_accounting_rule` (`id`),
  CONSTRAINT `FK_m_code_value_id` FOREIGN KEY (`tag_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_rule_tags`
--

LOCK TABLES `acc_rule_tags` WRITE;
/*!40000 ALTER TABLE `acc_rule_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_rule_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_accounts`
--

DROP TABLE IF EXISTS `admin_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_accounts` (
  `id` int(25) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `series_id` varchar(60) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `admin_type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_accounts`
--

LOCK TABLES `admin_accounts` WRITE;
/*!40000 ALTER TABLE `admin_accounts` DISABLE KEYS */;
INSERT INTO `admin_accounts` VALUES (3,'root','$2y$10$syHHgu.lgAUcLH/p1bJNRuQcLqwBVDNsL5mYnS3uVL4gs7apT1pni',NULL,NULL,NULL,'admin'),(4,'superadmin','$2y$10$xpZc5KC.aU2XHkcqhuZGFuAnqmtL4Unt8MysOyylceq.19XIyoZpG','qlmwAB5M8G9am3ES','$2y$10$lYojnd7yQh6AsnzjrpjuYOYeGiLTFeBeBkJXkxWrWIOAWQizSf6Xe','2019-05-31 14:31:14','super'),(5,'joshua','$2y$10$8HI4ZVomrfYOKZRc98B0je0yW7ANrxxvxVrMyvsfs/GLRi0QVIiY6',NULL,NULL,NULL,'admin'),(6,'chetanw','$2y$10$iJSznl9t/iJmJWW1GcJyS.QJJ/pt8bR.jaixq5eZRzhbmGTW2QMLK',NULL,NULL,NULL,'admin');
/*!40000 ALTER TABLE `admin_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_account_number_format`
--

DROP TABLE IF EXISTS `c_account_number_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_account_number_format` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_type_enum` smallint(1) NOT NULL,
  `prefix_type_enum` smallint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_type_enum` (`account_type_enum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_account_number_format`
--

LOCK TABLES `c_account_number_format` WRITE;
/*!40000 ALTER TABLE `c_account_number_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `c_account_number_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_cache`
--

DROP TABLE IF EXISTS `c_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_cache` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cache_type_enum` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_cache`
--

LOCK TABLES `c_cache` WRITE;
/*!40000 ALTER TABLE `c_cache` DISABLE KEYS */;
INSERT INTO `c_cache` VALUES (1,1);
/*!40000 ALTER TABLE `c_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_configuration`
--

DROP TABLE IF EXISTS `c_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_trap_door` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_configuration`
--

LOCK TABLES `c_configuration` WRITE;
/*!40000 ALTER TABLE `c_configuration` DISABLE KEYS */;
INSERT INTO `c_configuration` VALUES (1,'maker-checker',NULL,NULL,0,0,NULL),(4,'amazon-S3',NULL,NULL,0,0,NULL),(5,'reschedule-future-repayments',NULL,NULL,1,0,NULL),(6,'reschedule-repayments-on-holidays',NULL,NULL,0,0,NULL),(7,'allow-transactions-on-holiday',NULL,NULL,0,0,NULL),(8,'allow-transactions-on-non_workingday',NULL,NULL,0,0,NULL),(9,'constraint_approach_for_datatables',NULL,NULL,0,0,NULL),(10,'penalty-wait-period',2,NULL,1,0,NULL),(11,'force-password-reset-days',0,NULL,0,0,NULL),(12,'grace-on-penalty-posting',0,NULL,1,0,NULL),(15,'savings-interest-posting-current-period-end',NULL,NULL,0,0,'Recommended to be changed only once during start of production. When set as false(default), interest will be posted on the first date of next period. If set as true, interest will be posted on last date of current period. There is no difference in the interest amount posted.'),(16,'financial-year-beginning-month',1,NULL,1,0,'Recommended to be changed only once during start of production. Allowed values 1 - 12 (January - December). Interest posting periods are evaluated based on this configuration.'),(17,'min-clients-in-group',5,NULL,0,0,'Minimum number of Clients that a Group should have'),(18,'max-clients-in-group',5,NULL,0,0,'Maximum number of Clients that a Group can have'),(19,'meetings-mandatory-for-jlg-loans',NULL,NULL,0,0,'Enforces all JLG loans to follow a meeting schedule belonging to parent group or Center'),(20,'office-specific-products-enabled',0,NULL,0,0,'Whether products and fees should be office specific or not? This property should NOT be changed once Mifos is Live.'),(21,'restrict-products-to-user-office',0,NULL,0,0,'This should be enabled only if, products & fees are office specific (i.e. office-specific-products-enabled is enabled). This property specifies if the products should be auto-restricted to office of the user who created the proudct? Note: This property should NOT be changed once Mifos is Live.'),(22,'office-opening-balances-contra-account',0,NULL,1,0,NULL),(23,'rounding-mode',6,NULL,1,1,'0 - UP, 1 - DOWN, 2- CEILING, 3- FLOOR, 4- HALF_UP, 5- HALF_DOWN, 6 - HALF_EVEN'),(24,'backdate-penalties-enabled',0,NULL,1,0,'If this parameter is disabled penalties will only be added to instalments due moving forward, any old overdue instalments will not be affected.'),(25,'organisation-start-date',0,NULL,0,0,NULL),(26,'paymenttype-applicable-for-disbursement-charges',NULL,NULL,0,0,'Is the Disbursement Entry need to be considering the fund source of the paymnet type'),(27,'interest-charged-from-date-same-as-disbursal-date',0,NULL,0,0,NULL),(28,'skip-repayment-on-first-day-of-month',14,NULL,0,0,'skipping repayment on first day of month'),(29,'change-emi-if-repaymentdate-same-as-disbursementdate',0,NULL,1,0,'In tranche loans, if repayment date is same as tranche disbursement date then allow to change the emi amount'),(30,'daily-tpt-limit',0,NULL,0,0,'Daily limit for third party transfers'),(31,'Enable-Address',NULL,NULL,0,0,NULL);
/*!40000 ALTER TABLE `c_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_external_service`
--

DROP TABLE IF EXISTS `c_external_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_external_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_external_service`
--

LOCK TABLES `c_external_service` WRITE;
/*!40000 ALTER TABLE `c_external_service` DISABLE KEYS */;
INSERT INTO `c_external_service` VALUES (3,'MESSAGE_GATEWAY'),(4,'NOTIFICATION'),(1,'S3'),(2,'SMTP_Email_Account');
/*!40000 ALTER TABLE `c_external_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_external_service_properties`
--

DROP TABLE IF EXISTS `c_external_service_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_external_service_properties` (
  `name` varchar(150) NOT NULL,
  `value` varchar(250) DEFAULT NULL,
  `external_service_id` bigint(20) NOT NULL,
  KEY `FK_c_external_service_properties_c_external_service` (`external_service_id`),
  CONSTRAINT `FK_c_external_service_properties_c_external_service` FOREIGN KEY (`external_service_id`) REFERENCES `c_external_service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_external_service_properties`
--

LOCK TABLES `c_external_service_properties` WRITE;
/*!40000 ALTER TABLE `c_external_service_properties` DISABLE KEYS */;
INSERT INTO `c_external_service_properties` VALUES ('s3_access_key',NULL,1),('s3_bucket_name',NULL,1),('s3_secret_key',NULL,1),('username','support@cloudmicrofinance.com',2),('password','support81',2),('host','smtp.gmail.com',2),('port','25',2),('useTLS','true',2),('host_name','localhost',3),('port_number','9191',3),('end_point','/',3),('tenant_app_key',NULL,3),('server_key','AAAAToBmqQQ:APA91bEodkE12CwFl8VHqanUbeJYg1E05TiheVz59CZZYrBnCq3uM40UYhHfdP-JfeTQ0L0zoLqS8orjvW_ze0_VF8DSuyyqkrDibflhtUainsI0lwgVz5u1YP3q3c3erqjlySEuRShS',4),('gcm_end_point','https://gcm-http.googleapis.com/gcm/send',4),('fcm_end_point','https://fcm.googleapis.com/fcm/send',4),('fromEmail','support@cloudmicrofinance.com',2),('fromName','support@cloudmicrofinance.com',2);
/*!40000 ALTER TABLE `c_external_service_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client motorbike details`
--

DROP TABLE IF EXISTS `client motorbike details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client motorbike details` (
  `client_id` bigint(20) NOT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `number_plate` varchar(255) DEFAULT NULL,
  `Engine` varchar(255) DEFAULT NULL,
  `cheses_number` varchar(255) DEFAULT NULL,
  `Others` varchar(255) DEFAULT NULL,
  `kra_pin` varchar(255) DEFAULT NULL,
  `COLOUR` varchar(255) DEFAULT NULL,
  `marketing_agent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client motorbike details`
--

LOCK TABLES `client motorbike details` WRITE;
/*!40000 ALTER TABLE `client motorbike details` DISABLE KEYS */;
INSERT INTO `client motorbike details` VALUES (615,'BAJAJ BOXER','KMEP 318Z','LOST CERT ',NULL,NULL,NULL,NULL,NULL),(2036,'HONDA ACE 125','kmdu 528k','n/a',NULL,NULL,NULL,NULL,NULL),(2037,'N','teret','N',NULL,NULL,NULL,NULL,NULL),(2038,'N','KMEG 357S','N',NULL,NULL,NULL,NULL,NULL),(2042,'BAJAJ BOXER 150','KMED 627T','n/a',NULL,NULL,NULL,NULL,NULL),(2044,'BOXER ','KMEH 205P','H5031380 DY162FMJ-2',NULL,NULL,NULL,NULL,NULL),(2051,'LIFAN LF125','KMER 162S','ENGINE : 156FMI-2C5051748 LF3PCJ5E2CB000043',NULL,NULL,NULL,NULL,NULL),(2065,'DAYUN RED COLOR ','KMEF 833G ','ENGINE: H5031380 CHASIS : DY162FMJ-2',NULL,NULL,NULL,NULL,NULL),(2072,'tesg','KMEJ 733E','test',NULL,NULL,NULL,NULL,NULL),(2074,'BOXER BAJAJ','KMED 077W','pfzwjk93858',NULL,NULL,NULL,NULL,NULL),(2076,'BAJAJ BOXER 150','KMDV 600X','n/a',NULL,NULL,NULL,NULL,NULL),(2080,'BAJAJ BOXER 150','KMCX 238Y','ENGINE: PFZWCH80629 CHASIS: MD2A21B26XWH30560',NULL,NULL,NULL,NULL,NULL),(2098,'DAYUN COLOR RED','KMEF 833G','H5031380 DY162FMJ-2',NULL,NULL,NULL,NULL,NULL),(2101,'SKYGO','KMCX 186S','CO000003019',NULL,NULL,NULL,NULL,NULL),(2105,'motorcycle','kmdl 523d','n/a',NULL,NULL,NULL,NULL,NULL),(2109,'SKYGO','KMDS 833E','ENGINE : 162FMJ5107952 CHASIS : LF3PCK00XFB012477',NULL,NULL,NULL,NULL,NULL),(2110,'motorcycle','kmdu 528k','n/a',NULL,NULL,NULL,NULL,NULL),(2113,'HONDA ACE E5','KMEN 788K','5DH152FMI-3J3100577',NULL,NULL,NULL,NULL,NULL),(2114,'BOXER BAJAJ','KMEK 185W','PFZWJK93858',NULL,NULL,NULL,NULL,NULL),(2115,'TVS HLX','KMEJ 688L','AF7NH1309280 MD625AF73HIN09079',NULL,NULL,NULL,NULL,NULL),(2116,'BOXER BAJAJ','KMDS 833E','pfzwjk93858',NULL,NULL,NULL,NULL,NULL),(2121,'TVS 100','KMEP 930L','ENGINE: FF5FB1414001 CHASIS : MD62NF52J1F34036',NULL,NULL,NULL,NULL,NULL),(2122,'BOXER BAJAJ','KMER 265E','PFZWJG71100 CHASIS : MD2A21BY8JWG95637',NULL,NULL,NULL,NULL,NULL),(2123,'TVS STAR ','KMDV 066V','MD625AF44G1A65539 DF4AG106633',NULL,NULL,NULL,NULL,NULL),(2124,'test','test','test',NULL,NULL,NULL,NULL,NULL),(2127,'BOXER BAJAJ','KMEA 900V','RUAI',NULL,NULL,NULL,NULL,NULL),(2129,'BOXER BAJAJ','KMEA 401T','PFZWGJ87848 CHASIS : MD2A21BZ0GWJ56959',NULL,NULL,NULL,NULL,NULL),(2130,'BOXER BAJAJ','KMEL 382P','ENGINE : PLZWJL58217 CHASIS : A21BY3JWL98112',NULL,NULL,NULL,NULL,NULL),(2132,'BAJAJ BOXER 150','KMEK 294D','n/a',NULL,NULL,NULL,NULL,NULL),(2133,'HONDA','KMEK 873Y','CO000003019',NULL,NULL,NULL,NULL,NULL),(2135,'SONLINK 150CC','KMEF 922S','CO000003019',NULL,NULL,NULL,NULL,NULL),(2136,'BOXER BAJAJ','KMDL 096E','PFZWEG20659',NULL,NULL,NULL,NULL,NULL),(2137,'TVS HLX 150','KMEL 892B','AF7BJ14008',NULL,NULL,NULL,NULL,NULL),(2138,'BOXER BAJAJ','kmed 327y','engine : pfzinha81573 chasis: mpzaz1by3wa91813-13',NULL,NULL,NULL,NULL,NULL),(2139,'LIFAN LF125','kmcw 991e','ENGINE : 156FMI-2C5051748 LF3PCJ5E2CB000043',NULL,NULL,NULL,NULL,NULL),(2141,'sky go 150-3 color blue','kmdd 023d','chs: LF3PCK00DB006020 eng : 162FMJD5109042',NULL,NULL,NULL,NULL,NULL),(2142,'BAJAJ BOXER ','kmdh 714l','MD2A21BZXEWA71966 PFZWEA33725',NULL,NULL,NULL,NULL,NULL),(2143,'HONDA ACE 125','KMEQ 804H','CHASIS : BFOJA3096FS402849 ENGINE : SDH152FMI-3G3300757',NULL,NULL,NULL,NULL,NULL),(2144,'CAPTAIN CP 175','KMDR 093K','ENGINE: 15013483 CHASIS : 11FA500162',NULL,NULL,NULL,NULL,NULL),(2145,'BAJAJ BOXER','KMEL 241H','ENGINE: PFZWJL61463 CHASIS: MD2A21BY0JWM98345',NULL,NULL,NULL,NULL,NULL),(2146,'BOXER BAJAJ','KMEJ 189R','n/a',NULL,NULL,NULL,NULL,NULL),(2147,'motorcycle','KMDW 459X','ENGINE: PFZWGB71025 CHASIS: MD2A21BZ9GWA74876',NULL,NULL,NULL,NULL,NULL),(2148,'HONDA ACE 125','KMDU 345W','ENGINE: SDH152FMI3F621126 CHASIS: BFOJA309IFS401124',NULL,NULL,NULL,NULL,NULL),(2149,'LION','KMCW 071U','ENGINE: LWAPCJ38CA901353 CHASIS : YF156FMI-2CABOI830',NULL,NULL,NULL,NULL,NULL),(2150,'RANGER 150-18','KMEH 090Q','ENGINE: 162FMJ470709052 CHASIS : LK1PCKL14H1101584',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `client motorbike details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_device_registration`
--

DROP TABLE IF EXISTS `client_device_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_device_registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `updatedon_date` datetime NOT NULL,
  `registration_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registration_key_client_device_registration` (`registration_id`),
  UNIQUE KEY `client_key_client_device_registration` (`client_id`),
  KEY `FK1_client_device_registration_m_client` (`client_id`),
  CONSTRAINT `FK1_client_device_registration_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_device_registration`
--

LOCK TABLES `client_device_registration` WRITE;
/*!40000 ALTER TABLE `client_device_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_device_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_insurance_details`
--

DROP TABLE IF EXISTS `client_insurance_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_insurance_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `commence_date` varchar(50) DEFAULT NULL,
  `period` varchar(50) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `print_status` enum('0','1') DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `due_date` varchar(255) DEFAULT NULL,
  `motorbike_details_id` int(11) DEFAULT NULL,
  `renewal` enum('0','1') DEFAULT '0',
  `policy_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_insurance_details`
--

LOCK TABLES `client_insurance_details` WRITE;
/*!40000 ALTER TABLE `client_insurance_details` DISABLE KEYS */;
INSERT INTO `client_insurance_details` VALUES (16,'03/08/2019','6','2019-03-05 16:21:58','1','2019-03-05 14:22:01','2019-09-08',2036,'0','HDO/0810/000025/2019'),(23,'03/14/2019','1','2019-03-14 13:54:46','1','2019-03-14 11:54:49','2019/04/13 00:00:00',2065,'0','HDO/0810/016189/2018- COMP'),(24,'03/14/2019','1','2019-03-14 14:46:10','1','2019-03-14 12:46:12','2019/04/13 00:00:00',2065,'0','HDO/0810/016189/2018- COMP'),(25,'03/14/2019','1','2019-03-14 15:29:15','1','2019-03-14 13:29:18','2019/04/13 00:00:00',2065,'0','HDO/0810/016189/2018- COMP'),(26,'03/14/2019','1','2019-03-15 08:51:34','1','2019-03-15 06:53:56','2019/04/13 00:00:00',2098,'0','HDO/0810/016189/2018- COMP'),(29,'03/16/2019','1','2019-03-16 10:13:43','1','2019-03-16 08:13:48','2019/04/15 00:00:00',2044,'0','HDO/0810/017068/2019'),(30,'03/16/2019','1','2019-03-16 10:16:37','1','2019-03-16 08:16:41','2019/04/15 00:00:00',2080,'0','HDO/0810/017068/2019'),(35,'03/22/2019','1','2019-03-21 10:17:07','1','2019-03-21 08:17:12','2019/04/21 00:00:00',2109,'0','HDO/0810/017068/2019     TPO '),(36,'03/26/2019','1','2019-03-25 16:33:36','1','2019-03-25 14:33:40','2019/04/25 00:00:00',2076,'0','HDO/0810/017068/2019   COMP'),(37,'03/26/2019','1','2019-03-25 16:42:46','1','2019-03-25 14:43:42','2019/04/25 00:00:00',2101,'0','HDO/0810/017068/2019   COMP'),(38,'03/27/2019','1','2019-03-26 10:54:16','1','2019-03-26 08:57:44','2019/04/26 00:00:00',2113,'0','HDO/0810/017068/2019   COMP'),(39,'03/28/2019','1','2019-03-27 13:28:39','1','2019-03-27 11:31:16','2019/04/27 00:00:00',2114,'0','HDO/0810/017068/2019   COMP'),(41,'03/28/2019','1','2019-03-27 14:30:55','1','2019-03-27 12:31:07','2019/04/27 00:00:00',2115,'0','HDO/0810/017068/2019   COMP'),(42,'03/29/2019','1','2019-03-28 09:10:24','1','2019-03-28 07:10:34','2019/04/28 00:00:00',2116,'0','HDO/0810/017068/2019    TPO'),(43,'03/28/2019','1','2019-03-28 11:49:14','1','2019-03-28 09:51:35','2019/04/27 00:00:00',2122,'0','HDO/0810/017068/2019   COMP'),(44,'03/30/2019','1','2019-03-29 11:43:05','1','2019-03-29 09:45:39','2019/04/29 00:00:00',2123,'0','HDO/0810/017068/2019   COMP'),(45,'03/30/2019','1','2019-03-29 13:02:41','1','2019-03-29 11:02:45','2019/04/29 00:00:00',2124,'0','HDO/0810/017068/2019   COMP'),(46,'04/02/2019','1','2019-04-02 07:40:56','1','2019-04-02 05:45:56','2019/05/01 00:00:00',2129,'0','HDO/0810/017068/2019   COMP'),(47,'04/04/2019','1','2019-04-02 11:07:09','1','2019-04-02 09:07:37','2019/05/03 00:00:00',2127,'0','HDO/0810/017068/2019   COMP'),(49,'04/03/2019','1','2019-04-02 14:37:50','1','2019-04-02 12:37:53','2019/05/02 00:00:00',2130,'0','HDO/0810/017068/2019   COMP'),(50,'04/03/2019','1','2019-04-03 11:05:39','1','2019-04-03 09:05:43','2019/05/02 00:00:00',2132,'0','HDO/0810/017068/2019   COMP'),(51,'04/04/2019','1','2019-04-03 12:09:44','1','2019-04-03 10:09:51','2019/05/03 00:00:00',2074,'0','HDO/0810/017068/2019   COMP'),(52,'04/04/2019','1','2019-04-03 14:13:38','1','2019-04-03 12:13:44','2019/05/03 00:00:00',2042,'0','HDO/0810/017068/2019   COMP'),(53,'04/04/2019','1','2019-04-04 11:03:27','1','2019-04-04 09:03:31','2019/05/03 00:00:00',2135,'0','HDO/0810/017068/2019   COMP'),(54,'04/05/2019','1','2019-04-04 11:42:40','1','2019-04-04 09:43:43','2019/05/04 00:00:00',2133,'0','HDO/0810/017068/2019   COMP'),(55,'04/04/2019','1','2019-04-04 15:03:58','1','2019-04-04 13:04:05','2019/05/03 00:00:00',2116,'0','HDO/0810/017068/2019   COMP'),(56,'04/05/2019','1','2019-04-04 16:11:46','1','2019-04-04 14:11:51','2019/05/04 00:00:00',2133,'0','HDO/0810/017068/2019   COMP'),(57,'04/06/2019','1','2019-04-05 09:12:05','1','2019-04-05 07:12:08','2019/05/05 00:00:00',2136,'0','HDO/0810/017068/2019    TPO'),(58,'04/06/2019','1','2019-04-05 14:40:04','1','2019-04-05 12:48:38','2019/05/05 00:00:00',2137,'0','HDO/0810/017068/2019    TPO'),(59,'04/06/2019','1','2019-04-05 14:48:31','1','2019-04-08 09:00:34','2019/05/05 00:00:00',2137,'0','HDO/0810/017068/2019    TPO'),(61,'04/08/2019','1','2019-04-08 09:55:06','1','2019-04-08 07:55:45','2019/05/10 00:00:00',2038,'0','HDO/0810/017068/2019   COMP'),(62,'04/08/2019','10','2019-04-08 10:48:01','1','2019-04-08 08:48:05','2020/02/07 00:00:00',2072,'0','HDO/0810/017068/2019 - COMP'),(63,'04/08/2019','1','2019-04-08 10:52:39','1','2019-04-08 08:52:50','2019/05/07 00:00:00',2038,'0','HDO/0810/017068/2019 - COMP'),(66,'04/09/2019','1','2019-04-08 15:57:11','1','2019-04-08 13:57:20','2019/05/08 00:00:00',2138,'0','HDO/0810/017068/2019   COMP'),(67,'04/09/2019','1','2019-04-08 16:11:08','1','2019-04-08 14:11:11','2019/05/08 00:00:00',2139,'0','HDO/0810/017068/2019 - COMP'),(68,'04/09/2019','1','2019-04-09 15:10:44','1','2019-04-09 13:10:46','2019/05/08 00:00:00',2051,'0','HDO/0810/017068/2019 - COMP'),(69,'04/09/2019','1','2019-04-09 15:24:07','1','2019-04-09 13:24:14','2019/05/08 00:00:00',2110,'0','HDO/0810/017068/2019 - COMP'),(70,'04/10/2019','1','2019-04-10 08:37:26','1','2019-04-10 06:37:29','2019/05/09 00:00:00',2142,'0','HDO/0810/017068/2019 - COMP'),(71,'04/12/2019','1','2019-04-11 12:05:55','1','2019-04-11 10:08:26','2019/05/11 00:00:00',2141,'0','HDO/0810/017068/2019 - COMP'),(72,'04/12/2019','6','2019-04-11 15:12:04','1','2019-04-11 13:12:08','2019/10/11 00:00:00',615,'0','HDO/0810/017068/2019 - TPO'),(73,'04/11/2019','6','2019-04-11 15:38:19','1','2019-04-11 13:38:23','2019/10/10 00:00:00',615,'0','HDO/0810/010763/2018 - COMP'),(75,'04/17/2019','1','2019-04-15 09:59:50','1','2019-04-15 08:08:18','2019/05/16 00:00:00',2144,'0','HDO/0810/017068/2019 - COMP'),(76,'04/16/2019','1','2019-04-15 11:58:41','1','2019-04-15 09:58:43','2019/05/15 00:00:00',2145,'0','HDO/0810/017068/2019 - COMP'),(77,'04/16/2019','1','2019-04-15 15:30:15','1','2019-04-15 13:30:25','2019/05/15 00:00:00',2143,'0','HDO/0810/017068/2019 - COMP'),(78,'04/16/2019','1','2019-04-15 15:33:44','1','2019-04-15 13:33:49','2019/05/15 00:00:00',2143,'0','HDO/0810/017068/2019 - COMP'),(79,'04/17/2019','1','2019-04-16 15:54:11','1','2019-04-16 13:54:20','2019/05/16 00:00:00',2080,'0','HDO/0810/017068/2019 - COMP'),(81,'04/19/2019','1','2019-04-18 06:06:05','1','2019-04-18 04:06:21','2019/05/18 00:00:00',2080,'0','HDO/0810/017068/2019 - COMP'),(82,'04/19/2019','1','2019-04-18 06:09:11','1','2019-04-18 04:09:13','2019/05/18 00:00:00',2065,'0','HDO/0810/017068/2019 - COMP'),(83,'04/19/2019','1','2019-04-18 16:57:33','1','2019-04-18 14:57:35','2019/05/18 00:00:00',2146,'0','HDO/0810/017068/2019 - COMP'),(84,'04/25/2019','1','2019-04-24 12:51:05','1','2019-04-24 10:51:07','2019/05/24 00:00:00',2147,'0','HDO/0810/017068/2019 - COMP'),(86,'04/27/2019','271','2019-04-27 11:58:13','1','2019-04-27 09:58:16','2041/11/26 00:00:00',2036,'0','HDO/0810/017068/2019 - TPO'),(87,'04/29/2019','1','2019-04-29 10:19:01','0','2019-04-29 08:19:01','2019/05/28 00:00:00',2132,'0','HDO/0810/017068/2019 - COMP'),(88,'04/30/2019','1','2019-04-29 10:46:43','1','2019-04-29 08:46:52','2019/05/29 00:00:00',2150,'0','HDO/0810/017068/2019 - COMP'),(89,'04/29/2019','1','2019-04-29 11:03:35','1','2019-04-29 09:03:46','2019/05/28 00:00:00',2132,'0','HDO/0810/017068/2019 - COMP'),(90,'04/29/2019','1','2019-04-29 11:35:13','1','2019-04-29 09:35:17','2019/05/28 00:00:00',2105,'0','HDO/0810/017068/2019 - COMP'),(94,'05/04/2019','10','2019-04-29 13:44:15','1','2019-04-29 11:44:22','2020/03/03 00:00:00',2042,'0','HDO/0810/017068/2019 - COMP'),(95,'04/30/2019','1','2019-04-29 16:23:52','0','2019-04-29 14:23:52','2019/05/29 00:00:00',2149,'0','HDO/0810/017068/2019 - COMP'),(96,'04/30/2019','1','2019-04-29 16:26:33','1','2019-04-29 14:26:51','2019/05/29 00:00:00',2149,'0','HDO/0810/017068/2019 - COMP'),(100,'04/30/2019','1','2019-04-29 16:53:52','1','2019-04-29 14:53:59','2019/05/29 00:00:00',2148,'0','HDO/0810/017068/2019 - TPO'),(101,'04/29/2019','9','2019-04-29 16:57:45','0','2019-04-29 14:57:45','2020/01/28 00:00:00',2076,'0','HDO/0810/017068/2019 - COMP'),(102,'04/30/2019','1','2019-04-29 17:00:15','0','2019-04-29 15:00:15','2019/05/29 00:00:00',2121,'0','HDO/0810/017068/2019 - TPO'),(103,'04/30/2019','10','2019-04-30 12:52:25','0','2019-04-30 10:52:25','2020/02/29 00:00:00',2076,'0','HDO/0810/017068/2019 - COMP'),(104,'04/30/2019','10','2019-04-30 12:53:27','1','2019-04-30 10:53:37','2020/02/29 00:00:00',2076,'0','HDO/0810/017068/2019 - COMP'),(105,'04/30/2019','12','0000-00-00 00:00:00','1','2019-05-01 11:22:21','2020/04/29 00:00:00',2121,'0','HDO/0810/017068/2019 - TPO'),(107,'04/30/2019','1','2019-04-30 14:21:55','1','2019-04-30 12:25:55','2019/05/29 00:00:00',2101,'0','HDO/0810/017068/2019 - COMP'),(108,'04/30/2019','1','2019-04-30 14:31:48','1','2019-04-30 12:31:56','2019/05/29 00:00:00',2113,'0','HDO/0810/017068/2019 - COMP'),(109,'04/30/2019','1','2019-04-30 14:33:46','1','2019-04-30 12:33:55','2019/05/29 00:00:00',2114,'0','HDO/0810/017068/2019 - COMP'),(110,'04/30/2019','1','2019-04-30 14:45:11','1','2019-04-30 12:45:19','2019/05/29 00:00:00',2115,'0','HDO/0810/017068/2019 - COMP'),(111,'04/30/2019','1','2019-04-30 15:11:52','1','2019-04-30 13:11:59','2019/05/29 00:00:00',2123,'0','HDO/0810/017068/2019'),(112,'04/30/2019','1','2019-04-30 15:19:19','1','2019-04-30 13:19:31','2019/05/29 00:00:00',2116,'0','HDO/0810/017068/2019 - TPO'),(113,'05/01/2019','1','2019-04-30 16:26:29','1','2019-04-30 14:26:35','2019/05/31 00:00:00',2151,'0','HDO/0810/017068/2019 - TPO'),(114,'04/02/2019','1','2019-04-30 16:47:08','1','2019-04-30 14:50:00','2019/05/01 00:00:00',2152,'0','HDO/0810/017068/2019 - COMP');
/*!40000 ALTER TABLE `client_insurance_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duplicate_loan`
--

DROP TABLE IF EXISTS `duplicate_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `cityLoanId` varchar(100) DEFAULT NULL,
  `clientLoanId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_id` (`loan_id`),
  CONSTRAINT `fk_duplicate_loan_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duplicate_loan`
--

LOCK TABLES `duplicate_loan` WRITE;
/*!40000 ALTER TABLE `duplicate_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `duplicate_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_service`
--

DROP TABLE IF EXISTS `email_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attachment` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `to_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_service`
--

LOCK TABLES `email_service` WRITE;
/*!40000 ALTER TABLE `email_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `cron_expression` varchar(20) CHARACTER SET latin1 NOT NULL,
  `create_time` datetime NOT NULL,
  `task_priority` smallint(6) NOT NULL DEFAULT '5',
  `group_name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `previous_run_start_time` datetime DEFAULT NULL,
  `next_run_time` datetime DEFAULT NULL,
  `job_key` varchar(500) DEFAULT NULL,
  `initializing_errorlog` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `currently_running` tinyint(1) NOT NULL DEFAULT '0',
  `updates_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `scheduler_group` smallint(2) NOT NULL DEFAULT '0',
  `is_misfired` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,'Update loan Summary','Update loan Summary','0 0 22 1/1 * ? *','2019-04-04 14:20:11',5,NULL,'2019-05-08 19:35:15','2019-05-09 19:30:00','Update loan SummaryJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(2,'Update Loan Arrears Ageing','Update Loan Arrears Ageing','0 1 0 1/1 * ? *','2019-04-04 14:20:11',5,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Update Loan Arrears AgeingJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(3,'Update Loan Paid In Advance','Update Loan Paid In Advance','0 5 0 1/1 * ? *','2019-04-04 14:20:11',5,NULL,'2019-05-08 21:35:00','2019-05-09 21:35:00','Update Loan Paid In AdvanceJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(4,'Apply Annual Fee For Savings','Apply Annual Fee For Savings','0 20 22 1/1 * ? *','2019-04-04 14:20:11',5,NULL,'2019-05-08 19:58:18','2019-05-09 19:50:00','Apply Annual Fee For SavingsJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(5,'Apply Holidays To Loans','Apply Holidays To Loans','0 0 12 * * ?','2019-04-04 14:20:11',5,NULL,'2019-04-30 09:30:00','2019-05-09 09:30:00','Apply Holidays To LoansJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(6,'Post Interest For Savings','Post Interest For Savings','0 0 0 1/1 * ? *','2019-04-04 14:20:14',5,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Post Interest For SavingsJobDetail1 _ DEFAULT',NULL,1,0,1,1,0),(7,'Transfer Fee For Loans From Savings','Transfer Fee For Loans From Savings','0 1 0 1/1 * ? *','2019-04-04 14:20:19',5,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Transfer Fee For Loans From SavingsJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(8,'Pay Due Savings Charges','Pay Due Savings Charges','0 0 12 * * ?','2013-09-23 00:00:00',5,NULL,'2019-04-30 09:30:00','2019-05-09 09:30:00','Pay Due Savings ChargesJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(9,'Update Accounting Running Balances','Update Accounting Running Balances','0 1 0 1/1 * ? *','2019-04-04 14:20:21',5,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Update Accounting Running BalancesJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(10,'Execute Standing Instruction','Execute Standing Instruction','0 0 0 1/1 * ? *','2019-04-04 14:20:29',5,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Execute Standing InstructionJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(11,'Add Accrual Transactions','Add Accrual Transactions','0 1 0 1/1 * ? *','2019-04-04 14:20:30',3,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Add Accrual TransactionsJobDetail1 _ DEFAULT',NULL,1,0,1,3,0),(12,'Apply penalty to overdue loans','Apply penalty to overdue loans','0 0 0 1/1 * ? *','2019-04-04 14:20:30',5,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Apply penalty to overdue loansJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(13,'Update Non Performing Assets','Update Non Performing Assets','0 0 0 1/1 * ? *','2019-04-04 14:20:30',6,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Update Non Performing AssetsJobDetail1 _ DEFAULT',NULL,1,0,1,3,0),(14,'Transfer Interest To Savings','Transfer Interest To Savings','0 2 0 1/1 * ? *','2019-04-04 14:20:32',4,NULL,'2019-05-08 21:32:00','2019-05-09 21:32:00','Transfer Interest To SavingsJobDetail1 _ DEFAULT',NULL,1,0,1,1,0),(15,'Update Deposit Accounts Maturity details','Update Deposit Accounts Maturity details','0 0 0 1/1 * ? *','2019-04-04 14:20:32',5,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Update Deposit Accounts Maturity detailsJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(16,'Add Periodic Accrual Transactions','Add Periodic Accrual Transactions','0 2 0 1/1 * ? *','2019-04-04 14:20:36',2,NULL,'2019-05-08 21:32:00','2019-05-09 21:32:00','Add Periodic Accrual TransactionsJobDetail1 _ DEFAULT',NULL,1,0,1,3,0),(17,'Recalculate Interest For Loans','Recalculate Interest For Loans','0 1 0 1/1 * ? *','2019-04-04 14:20:37',4,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Recalculate Interest For LoansJobDetail1 _ DEFAULT',NULL,1,0,1,3,0),(18,'Generate Mandatory Savings Schedule','Generate Mandatory Savings Schedule','0 5 0 1/1 * ? *','2019-04-04 14:20:53',5,NULL,'2019-05-08 21:35:00','2019-05-09 21:35:00','Generate Mandatory Savings ScheduleJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(19,'Generate Loan Loss Provisioning','Generate Loan Loss Provisioning','0 0 0 1/1 * ? *','2019-04-04 14:20:59',5,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Generate Loan Loss ProvisioningJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(20,'Post Dividends For Shares','Post Dividends For Shares','0 0 0 1/1 * ? *','2019-04-04 14:21:05',5,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Post Dividends For SharesJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(21,'Update Savings Dormant Accounts','Update Savings Dormant Accounts','0 0 0 1/1 * ? *','2019-04-04 14:21:06',3,NULL,'2019-05-08 21:30:00','2019-05-09 21:30:00','Update Savings Dormant AccountsJobDetail1 _ DEFAULT',NULL,1,0,1,1,0),(22,'Add Accrual Transactions For Loans With Income Posted As Transactions','Add Accrual Transactions For Loans With Income Posted As Transactions','0 1 0 1/1 * ? *','2019-04-04 14:21:07',5,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Add Accrual Transactions For Loans With Income Posted As TransactionsJobDetail1 _ DEFAULT',NULL,1,0,1,3,0),(23,'Execute Report Mailing Jobs','Execute Report Mailing Jobs','0 0/15 * * * ?','2019-04-04 14:21:10',5,NULL,'2019-05-08 23:15:00','2019-05-08 23:30:00','Execute Report Mailing JobsJobDetail1 _ DEFAULT',NULL,1,1,1,0,0),(24,'Update SMS Outbound with Campaign Message','Update SMS Outbound with Campaign Message','0 0 5 1/1 * ? *','2019-04-04 14:21:11',3,NULL,'2019-04-30 08:58:23','2019-05-09 02:30:00','Update SMS Outbound with Campaign MessageJobDetail1 _ DEFAULT',NULL,1,0,1,4,0),(25,'Send Messages to SMS Gateway','Send Messages to SMS Gateway','0 0 5 1/1 * ? *','2019-04-04 14:21:11',2,NULL,'2019-04-30 08:58:35','2019-05-09 02:30:00','Send Messages to SMS GatewayJobDetail1 _ DEFAULT',NULL,1,0,1,4,0),(26,'Get Delivery Reports from SMS Gateway','Get Delivery Reports from SMS Gateway','0 0 5 1/1 * ? *','2019-04-04 14:21:11',1,NULL,'2019-04-30 08:58:35','2019-05-09 02:30:00','Get Delivery Reports from SMS GatewayJobDetail1 _ DEFAULT',NULL,1,0,1,4,0),(27,'Execute Email','Execute Email','0 0/10 * * * ?','2019-04-04 14:21:12',5,NULL,'2019-05-08 23:20:00','2019-05-08 23:30:00','Execute EmailJobDetail1 _ DEFAULT',NULL,1,1,1,0,0),(28,'Update Email Outbound with campaign message','Update Email Outbound with campaign message','0 0/15 * * * ?','2019-04-04 14:21:12',5,NULL,'2019-05-08 23:15:00','2019-05-08 23:30:00','Update Email Outbound with campaign messageJobDetail1 _ DEFAULT',NULL,1,1,1,0,0),(29,'Generate AdhocClient Schedule','Generate AdhocClient Schedule','0 0 12 1/1 * ? *','2019-04-04 14:21:14',5,NULL,'2019-04-12 09:30:00','2019-05-09 09:30:00','Generate AdhocClient ScheduleJobDetail1 _ DEFAULT',NULL,1,0,1,0,0),(30,'Update Trial Balance Details','Update Trial Balance Details','0 1 0 1/1 * ? *','2019-04-11 11:46:05',5,NULL,'2019-05-08 21:31:00','2019-05-09 21:31:00','Update Trial Balance DetailsJobDetail1 _ DEFAULT',NULL,1,0,1,0,0);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_run_history`
--

DROP TABLE IF EXISTS `job_run_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_run_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` varchar(10) CHARACTER SET latin1 NOT NULL,
  `error_message` text,
  `trigger_type` varchar(25) NOT NULL,
  `error_log` text,
  PRIMARY KEY (`id`),
  KEY `scheduledjobsFK` (`job_id`),
  CONSTRAINT `scheduledjobsFK` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=630 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_run_history`
--

LOCK TABLES `job_run_history` WRITE;
/*!40000 ALTER TABLE `job_run_history` DISABLE KEYS */;
INSERT INTO `job_run_history` VALUES (1,28,1,'2019-04-04 14:30:02','2019-04-04 14:30:04','success',NULL,'cron',NULL),(2,23,1,'2019-04-04 14:30:02','2019-04-04 14:30:04','success',NULL,'cron',NULL),(3,27,1,'2019-04-04 14:30:02','2019-04-04 14:30:04','success',NULL,'cron',NULL),(4,27,2,'2019-04-04 14:40:00','2019-04-04 14:40:00','success',NULL,'cron',NULL),(5,23,2,'2019-04-04 14:45:00','2019-04-04 14:45:00','success',NULL,'cron',NULL),(6,28,2,'2019-04-04 14:45:00','2019-04-04 14:45:00','success',NULL,'cron',NULL),(7,27,3,'2019-04-04 14:50:00','2019-04-04 14:50:00','success',NULL,'cron',NULL),(8,28,3,'2019-04-04 15:00:00','2019-04-04 15:00:01','success',NULL,'cron',NULL),(9,27,4,'2019-04-04 15:00:00','2019-04-04 15:00:01','success',NULL,'cron',NULL),(10,23,3,'2019-04-04 15:00:00','2019-04-04 15:00:01','success',NULL,'cron',NULL),(11,27,5,'2019-04-04 15:10:00','2019-04-04 15:10:00','success',NULL,'cron',NULL),(12,23,4,'2019-04-04 15:15:00','2019-04-04 15:15:01','success',NULL,'cron',NULL),(13,28,4,'2019-04-04 15:15:00','2019-04-04 15:15:01','success',NULL,'cron',NULL),(14,27,6,'2019-04-04 15:20:00','2019-04-04 15:20:00','success',NULL,'cron',NULL),(15,27,7,'2019-04-04 15:30:00','2019-04-04 15:30:00','success',NULL,'cron',NULL),(16,23,5,'2019-04-04 15:30:00','2019-04-04 15:30:00','success',NULL,'cron',NULL),(17,28,5,'2019-04-04 15:30:00','2019-04-04 15:30:00','success',NULL,'cron',NULL),(18,27,8,'2019-04-04 15:40:00','2019-04-04 15:40:00','success',NULL,'cron',NULL),(19,23,6,'2019-04-04 15:45:00','2019-04-04 15:45:00','success',NULL,'cron',NULL),(20,28,6,'2019-04-04 15:45:00','2019-04-04 15:45:00','success',NULL,'cron',NULL),(21,27,9,'2019-04-04 15:50:00','2019-04-04 15:50:00','success',NULL,'cron',NULL),(22,27,10,'2019-04-04 16:00:00','2019-04-04 16:00:00','success',NULL,'cron',NULL),(23,23,7,'2019-04-04 16:00:00','2019-04-04 16:00:00','success',NULL,'cron',NULL),(24,28,7,'2019-04-04 16:00:00','2019-04-04 16:00:00','success',NULL,'cron',NULL),(25,27,11,'2019-04-04 16:10:00','2019-04-04 16:10:00','success',NULL,'cron',NULL),(26,23,8,'2019-04-04 16:15:00','2019-04-04 16:15:00','success',NULL,'cron',NULL),(27,28,8,'2019-04-04 16:15:00','2019-04-04 16:15:00','success',NULL,'cron',NULL),(28,27,12,'2019-04-04 16:20:00','2019-04-04 16:20:00','success',NULL,'cron',NULL),(29,28,9,'2019-04-04 16:30:00','2019-04-04 16:30:00','success',NULL,'cron',NULL),(30,23,9,'2019-04-04 16:30:00','2019-04-04 16:30:00','success',NULL,'cron',NULL),(31,27,13,'2019-04-04 16:30:00','2019-04-04 16:30:00','success',NULL,'cron',NULL),(32,27,14,'2019-04-04 16:40:00','2019-04-04 16:40:00','success',NULL,'cron',NULL),(33,28,10,'2019-04-04 16:45:02','2019-04-04 16:45:12','success',NULL,'cron',NULL),(34,23,10,'2019-04-04 16:45:01','2019-04-04 16:45:12','success',NULL,'cron',NULL),(35,27,15,'2019-04-04 16:50:00','2019-04-04 16:50:00','success',NULL,'cron',NULL),(36,23,11,'2019-04-04 17:00:00','2019-04-04 17:00:00','success',NULL,'cron',NULL),(37,28,11,'2019-04-04 17:00:00','2019-04-04 17:00:00','success',NULL,'cron',NULL),(38,27,16,'2019-04-04 17:00:00','2019-04-04 17:00:00','success',NULL,'cron',NULL),(39,27,17,'2019-04-08 14:10:00','2019-04-08 14:10:00','success',NULL,'cron',NULL),(40,23,12,'2019-04-08 14:15:00','2019-04-08 14:15:00','success',NULL,'cron',NULL),(41,28,12,'2019-04-08 14:15:00','2019-04-08 14:15:00','success',NULL,'cron',NULL),(42,27,18,'2019-04-08 14:20:00','2019-04-08 14:20:00','success',NULL,'cron',NULL),(43,23,13,'2019-04-08 14:30:00','2019-04-08 14:30:00','success',NULL,'cron',NULL),(44,27,19,'2019-04-08 14:30:00','2019-04-08 14:30:00','success',NULL,'cron',NULL),(45,28,13,'2019-04-08 14:30:00','2019-04-08 14:30:00','success',NULL,'cron',NULL),(46,27,20,'2019-04-08 14:40:00','2019-04-08 14:40:00','success',NULL,'cron',NULL),(47,28,14,'2019-04-08 14:45:00','2019-04-08 14:45:00','success',NULL,'cron',NULL),(48,23,14,'2019-04-08 14:45:00','2019-04-08 14:45:00','success',NULL,'cron',NULL),(49,27,21,'2019-04-08 14:50:00','2019-04-08 14:50:00','success',NULL,'cron',NULL),(50,28,15,'2019-04-08 15:00:00','2019-04-08 15:00:00','success',NULL,'cron',NULL),(51,23,15,'2019-04-08 15:00:00','2019-04-08 15:00:00','success',NULL,'cron',NULL),(52,27,22,'2019-04-08 15:00:00','2019-04-08 15:00:00','success',NULL,'cron',NULL),(53,27,23,'2019-04-08 15:10:00','2019-04-08 15:10:00','success',NULL,'cron',NULL),(54,28,16,'2019-04-08 15:15:00','2019-04-08 15:15:00','success',NULL,'cron',NULL),(55,23,16,'2019-04-08 15:15:00','2019-04-08 15:15:00','success',NULL,'cron',NULL),(56,27,24,'2019-04-08 15:20:00','2019-04-08 15:20:00','success',NULL,'cron',NULL),(58,27,25,'2019-04-09 10:20:00','2019-04-09 10:20:00','success',NULL,'cron',NULL),(59,27,26,'2019-04-09 10:30:00','2019-04-09 10:30:00','success',NULL,'cron',NULL),(60,28,17,'2019-04-09 10:30:00','2019-04-09 10:30:00','success',NULL,'cron',NULL),(61,23,17,'2019-04-09 10:30:00','2019-04-09 10:30:00','success',NULL,'cron',NULL),(62,27,27,'2019-04-09 10:40:00','2019-04-09 10:40:00','success',NULL,'cron',NULL),(63,28,18,'2019-04-09 10:45:00','2019-04-09 10:45:00','success',NULL,'cron',NULL),(64,23,18,'2019-04-09 10:45:00','2019-04-09 10:45:00','success',NULL,'cron',NULL),(65,27,28,'2019-04-09 10:50:00','2019-04-09 10:50:00','success',NULL,'cron',NULL),(66,28,19,'2019-04-09 11:00:01','2019-04-09 11:00:01','success',NULL,'cron',NULL),(67,23,19,'2019-04-09 11:00:01','2019-04-09 11:00:01','success',NULL,'cron',NULL),(68,27,29,'2019-04-09 11:00:00','2019-04-09 11:00:01','success',NULL,'cron',NULL),(69,27,30,'2019-04-09 11:10:00','2019-04-09 11:10:00','success',NULL,'cron',NULL),(70,28,20,'2019-04-09 11:15:00','2019-04-09 11:15:00','success',NULL,'cron',NULL),(71,23,20,'2019-04-09 11:15:00','2019-04-09 11:15:00','success',NULL,'cron',NULL),(72,27,31,'2019-04-09 11:20:00','2019-04-09 11:20:00','success',NULL,'cron',NULL),(73,28,21,'2019-04-09 11:30:00','2019-04-09 11:30:00','success',NULL,'cron',NULL),(74,27,32,'2019-04-09 11:30:00','2019-04-09 11:30:00','success',NULL,'cron',NULL),(75,23,21,'2019-04-09 11:30:00','2019-04-09 11:30:00','success',NULL,'cron',NULL),(76,27,33,'2019-04-09 11:40:00','2019-04-09 11:40:00','success',NULL,'cron',NULL),(77,23,22,'2019-04-09 11:45:00','2019-04-09 11:45:24','success',NULL,'cron',NULL),(78,28,22,'2019-04-09 11:45:00','2019-04-09 11:45:24','success',NULL,'cron',NULL),(79,27,34,'2019-04-09 11:50:00','2019-04-09 11:50:00','success',NULL,'cron',NULL),(80,28,23,'2019-04-09 12:00:00','2019-04-09 12:00:00','success',NULL,'cron',NULL),(81,27,35,'2019-04-09 12:00:00','2019-04-09 12:00:00','success',NULL,'cron',NULL),(82,23,23,'2019-04-09 12:00:00','2019-04-09 12:00:00','success',NULL,'cron',NULL),(83,27,36,'2019-04-09 12:10:00','2019-04-09 12:10:00','success',NULL,'cron',NULL),(84,28,24,'2019-04-09 12:15:00','2019-04-09 12:15:01','success',NULL,'cron',NULL),(85,23,24,'2019-04-09 12:15:00','2019-04-09 12:15:01','success',NULL,'cron',NULL),(86,27,37,'2019-04-09 12:20:00','2019-04-09 12:20:00','success',NULL,'cron',NULL),(87,28,25,'2019-04-09 12:30:00','2019-04-09 12:30:00','success',NULL,'cron',NULL),(88,23,25,'2019-04-09 12:30:00','2019-04-09 12:30:00','success',NULL,'cron',NULL),(89,27,38,'2019-04-09 12:30:00','2019-04-09 12:30:00','success',NULL,'cron',NULL),(90,27,39,'2019-04-09 12:40:00','2019-04-09 12:40:00','success',NULL,'cron',NULL),(91,28,26,'2019-04-09 12:45:00','2019-04-09 12:45:00','success',NULL,'cron',NULL),(92,23,26,'2019-04-09 12:45:00','2019-04-09 12:45:00','success',NULL,'cron',NULL),(93,27,40,'2019-04-09 12:50:00','2019-04-09 12:50:00','success',NULL,'cron',NULL),(94,28,27,'2019-04-09 13:00:00','2019-04-09 13:00:00','success',NULL,'cron',NULL),(95,23,27,'2019-04-09 13:00:00','2019-04-09 13:00:00','success',NULL,'cron',NULL),(96,27,41,'2019-04-09 13:00:00','2019-04-09 13:00:00','success',NULL,'cron',NULL),(97,27,42,'2019-04-09 13:10:00','2019-04-09 13:10:00','success',NULL,'cron',NULL),(98,23,28,'2019-04-09 13:15:00','2019-04-09 13:15:00','success',NULL,'cron',NULL),(99,28,28,'2019-04-09 13:15:00','2019-04-09 13:15:00','success',NULL,'cron',NULL),(100,27,43,'2019-04-09 13:20:00','2019-04-09 13:20:00','success',NULL,'cron',NULL),(101,23,29,'2019-04-09 13:30:00','2019-04-09 13:30:00','success',NULL,'cron',NULL),(102,28,29,'2019-04-09 13:30:00','2019-04-09 13:30:00','success',NULL,'cron',NULL),(103,27,44,'2019-04-09 13:30:00','2019-04-09 13:30:00','success',NULL,'cron',NULL),(104,27,45,'2019-04-09 13:40:00','2019-04-09 13:40:00','success',NULL,'cron',NULL),(105,23,30,'2019-04-09 13:45:00','2019-04-09 13:45:01','success',NULL,'cron',NULL),(106,28,30,'2019-04-09 13:45:00','2019-04-09 13:45:01','success',NULL,'cron',NULL),(107,27,46,'2019-04-09 13:50:00','2019-04-09 13:50:00','success',NULL,'cron',NULL),(108,28,31,'2019-04-09 14:00:00','2019-04-09 14:00:00','success',NULL,'cron',NULL),(109,23,31,'2019-04-09 14:00:00','2019-04-09 14:00:00','success',NULL,'cron',NULL),(110,27,47,'2019-04-09 14:00:00','2019-04-09 14:00:00','success',NULL,'cron',NULL),(111,27,48,'2019-04-09 14:10:00','2019-04-09 14:10:00','success',NULL,'cron',NULL),(112,23,32,'2019-04-09 14:15:00','2019-04-09 14:15:00','success',NULL,'cron',NULL),(113,28,32,'2019-04-09 14:15:00','2019-04-09 14:15:00','success',NULL,'cron',NULL),(114,27,49,'2019-04-09 14:20:00','2019-04-09 14:20:00','success',NULL,'cron',NULL),(115,27,50,'2019-04-09 14:30:00','2019-04-09 14:30:00','success',NULL,'cron',NULL),(116,28,33,'2019-04-09 14:30:00','2019-04-09 14:30:00','success',NULL,'cron',NULL),(117,23,33,'2019-04-09 14:30:00','2019-04-09 14:30:00','success',NULL,'cron',NULL),(118,27,51,'2019-04-09 14:40:00','2019-04-09 14:40:00','success',NULL,'cron',NULL),(119,28,34,'2019-04-09 14:45:00','2019-04-09 14:45:00','success',NULL,'cron',NULL),(120,23,34,'2019-04-09 14:45:00','2019-04-09 14:45:00','success',NULL,'cron',NULL),(121,27,52,'2019-04-09 14:50:00','2019-04-09 14:50:00','success',NULL,'cron',NULL),(122,28,35,'2019-04-09 15:00:00','2019-04-09 15:00:00','success',NULL,'cron',NULL),(123,23,35,'2019-04-09 15:00:00','2019-04-09 15:00:00','success',NULL,'cron',NULL),(124,27,53,'2019-04-09 15:00:00','2019-04-09 15:00:00','success',NULL,'cron',NULL),(125,27,54,'2019-04-09 15:10:00','2019-04-09 15:10:00','success',NULL,'cron',NULL),(126,28,36,'2019-04-09 15:15:00','2019-04-09 15:15:00','success',NULL,'cron',NULL),(127,23,36,'2019-04-09 15:15:00','2019-04-09 15:15:00','success',NULL,'cron',NULL),(128,27,55,'2019-04-09 15:20:00','2019-04-09 15:20:00','success',NULL,'cron',NULL),(129,23,37,'2019-04-09 15:30:00','2019-04-09 15:30:00','success',NULL,'cron',NULL),(130,27,56,'2019-04-09 15:30:00','2019-04-09 15:30:00','success',NULL,'cron',NULL),(131,28,37,'2019-04-09 15:30:00','2019-04-09 15:30:00','success',NULL,'cron',NULL),(132,27,57,'2019-04-09 15:40:00','2019-04-09 15:40:00','success',NULL,'cron',NULL),(133,28,38,'2019-04-09 15:45:00','2019-04-09 15:45:00','success',NULL,'cron',NULL),(134,23,38,'2019-04-09 15:45:00','2019-04-09 15:45:00','success',NULL,'cron',NULL),(135,27,58,'2019-04-09 15:50:00','2019-04-09 15:50:00','success',NULL,'cron',NULL),(136,27,59,'2019-04-09 16:00:00','2019-04-09 16:00:00','success',NULL,'cron',NULL),(137,23,39,'2019-04-09 16:00:00','2019-04-09 16:00:00','success',NULL,'cron',NULL),(138,28,39,'2019-04-09 16:00:00','2019-04-09 16:00:00','success',NULL,'cron',NULL),(139,27,60,'2019-04-09 16:10:00','2019-04-09 16:10:00','success',NULL,'cron',NULL),(140,28,40,'2019-04-09 16:15:00','2019-04-09 16:15:01','success',NULL,'cron',NULL),(141,23,40,'2019-04-09 16:15:00','2019-04-09 16:15:02','success',NULL,'cron',NULL),(142,27,61,'2019-04-09 16:20:00','2019-04-09 16:20:00','success',NULL,'cron',NULL),(143,27,62,'2019-04-09 16:30:00','2019-04-09 16:30:00','success',NULL,'cron',NULL),(144,23,41,'2019-04-09 16:30:00','2019-04-09 16:30:00','success',NULL,'cron',NULL),(145,28,41,'2019-04-09 16:30:00','2019-04-09 16:30:00','success',NULL,'cron',NULL),(146,27,63,'2019-04-09 16:40:00','2019-04-09 16:40:00','success',NULL,'cron',NULL),(147,28,42,'2019-04-09 16:45:00','2019-04-09 16:45:00','success',NULL,'cron',NULL),(148,23,42,'2019-04-09 16:45:00','2019-04-09 16:45:00','success',NULL,'cron',NULL),(149,27,64,'2019-04-09 16:50:00','2019-04-09 16:50:00','success',NULL,'cron',NULL),(150,27,65,'2019-04-09 17:00:00','2019-04-09 17:00:00','success',NULL,'cron',NULL),(151,28,43,'2019-04-09 17:00:00','2019-04-09 17:00:00','success',NULL,'cron',NULL),(152,23,43,'2019-04-09 17:00:00','2019-04-09 17:00:00','success',NULL,'cron',NULL),(153,27,66,'2019-04-09 17:10:00','2019-04-09 17:10:00','success',NULL,'cron',NULL),(154,28,44,'2019-04-09 17:15:00','2019-04-09 17:15:00','success',NULL,'cron',NULL),(155,23,44,'2019-04-09 17:15:00','2019-04-09 17:15:00','success',NULL,'cron',NULL),(156,27,67,'2019-04-09 17:20:00','2019-04-09 17:20:00','success',NULL,'cron',NULL),(157,23,45,'2019-04-09 17:30:00','2019-04-09 17:30:00','success',NULL,'cron',NULL),(158,27,68,'2019-04-09 17:30:00','2019-04-09 17:30:00','success',NULL,'cron',NULL),(159,28,45,'2019-04-09 17:30:00','2019-04-09 17:30:00','success',NULL,'cron',NULL),(160,27,69,'2019-04-09 17:40:00','2019-04-09 17:40:00','success',NULL,'cron',NULL),(161,23,46,'2019-04-09 20:41:09','2019-04-09 20:41:10','success',NULL,'cron',NULL),(162,27,70,'2019-04-09 20:41:09','2019-04-09 20:41:10','success',NULL,'cron',NULL),(163,28,46,'2019-04-09 20:41:09','2019-04-09 20:41:10','success',NULL,'cron',NULL),(164,28,47,'2019-04-10 08:42:09','2019-04-10 08:42:33','success',NULL,'cron',NULL),(165,4,1,'2019-04-09 20:41:09','2019-04-10 08:42:33','success',NULL,'cron',NULL),(166,23,47,'2019-04-10 08:42:09','2019-04-10 08:42:34','success',NULL,'cron',NULL),(167,27,71,'2019-04-10 08:42:09','2019-04-10 08:42:34','success',NULL,'cron',NULL),(168,13,1,'2019-04-10 08:41:52','2019-04-10 08:42:35','success',NULL,'cron',NULL),(169,12,1,'2019-04-10 08:42:09','2019-04-10 08:42:35','success',NULL,'cron',NULL),(170,1,1,'2019-04-09 20:41:09','2019-04-10 08:42:35','success',NULL,'cron',NULL),(171,10,1,'2019-04-10 08:42:09','2019-04-10 08:42:35','success',NULL,'cron',NULL),(172,24,1,'2019-04-10 08:42:03','2019-04-10 08:42:35','success',NULL,'cron',NULL),(173,20,1,'2019-04-10 08:42:34','2019-04-10 08:42:36','success',NULL,'cron',NULL),(174,7,1,'2019-04-10 08:42:34','2019-04-10 08:42:39','success',NULL,'cron',NULL),(175,22,1,'2019-04-10 08:42:35','2019-04-10 08:42:39','success',NULL,'cron',NULL),(176,18,1,'2019-04-10 08:42:34','2019-04-10 08:42:39','success',NULL,'cron',NULL),(177,9,1,'2019-04-10 08:42:35','2019-04-10 08:42:39','success',NULL,'cron',NULL),(178,6,1,'2019-04-10 08:42:08','2019-04-10 08:42:39','success',NULL,'cron',NULL),(179,2,1,'2019-04-10 08:42:35','2019-04-10 08:42:39','success',NULL,'cron',NULL),(180,25,1,'2019-04-10 08:42:35','2019-04-10 08:42:40','success',NULL,'cron',NULL),(181,3,1,'2019-04-10 08:42:36','2019-04-10 08:42:40','success',NULL,'cron',NULL),(182,26,1,'2019-04-10 08:42:40','2019-04-10 08:42:40','success',NULL,'cron',NULL),(183,14,1,'2019-04-10 08:42:39','2019-04-10 08:42:40','success',NULL,'cron',NULL),(184,21,1,'2019-04-10 08:42:40','2019-04-10 08:42:41','success',NULL,'cron',NULL),(185,15,1,'2019-04-10 08:42:35','2019-04-10 08:42:42','success',NULL,'cron',NULL),(186,17,1,'2019-04-10 08:42:39','2019-04-10 08:42:42','success',NULL,'cron',NULL),(187,11,1,'2019-04-10 08:42:42','2019-04-10 08:42:42','success',NULL,'cron',NULL),(188,16,1,'2019-04-10 08:42:42','2019-04-10 08:42:42','success',NULL,'cron',NULL),(189,19,1,'2019-04-10 08:42:34','2019-04-10 08:42:42','success',NULL,'cron',NULL),(190,23,48,'2019-04-10 08:45:00','2019-04-10 08:45:00','success',NULL,'cron',NULL),(191,28,48,'2019-04-10 08:45:00','2019-04-10 08:45:00','success',NULL,'cron',NULL),(192,27,72,'2019-04-10 08:50:00','2019-04-10 08:50:00','success',NULL,'cron',NULL),(193,23,49,'2019-04-10 09:00:00','2019-04-10 09:00:00','success',NULL,'cron',NULL),(194,28,49,'2019-04-10 09:00:00','2019-04-10 09:00:00','success',NULL,'cron',NULL),(195,27,73,'2019-04-10 09:00:00','2019-04-10 09:00:00','success',NULL,'cron',NULL),(196,27,74,'2019-04-10 09:10:00','2019-04-10 09:10:00','success',NULL,'cron',NULL),(197,28,50,'2019-04-10 09:15:00','2019-04-10 09:15:00','success',NULL,'cron',NULL),(198,23,50,'2019-04-10 09:15:00','2019-04-10 09:15:00','success',NULL,'cron',NULL),(199,27,75,'2019-04-10 09:20:00','2019-04-10 09:20:00','success',NULL,'cron',NULL),(200,28,51,'2019-04-10 09:30:00','2019-04-10 09:30:01','success',NULL,'cron',NULL),(201,23,51,'2019-04-10 09:30:00','2019-04-10 09:30:01','success',NULL,'cron',NULL),(202,27,76,'2019-04-10 09:30:00','2019-04-10 09:30:01','success',NULL,'cron',NULL),(203,29,1,'2019-04-10 09:30:00','2019-04-10 09:30:01','success',NULL,'cron',NULL),(204,8,1,'2019-04-10 09:30:00','2019-04-10 09:30:02','success',NULL,'cron',NULL),(205,5,1,'2019-04-10 09:30:00','2019-04-10 09:30:02','success',NULL,'cron',NULL),(206,27,77,'2019-04-10 09:40:00','2019-04-10 09:40:00','success',NULL,'cron',NULL),(207,23,52,'2019-04-10 09:45:00','2019-04-10 09:45:00','success',NULL,'cron',NULL),(208,28,52,'2019-04-10 09:45:00','2019-04-10 09:45:00','success',NULL,'cron',NULL),(209,27,78,'2019-04-10 09:50:00','2019-04-10 09:50:00','success',NULL,'cron',NULL),(210,28,53,'2019-04-10 10:00:00','2019-04-10 10:00:01','success',NULL,'cron',NULL),(211,23,53,'2019-04-10 10:00:00','2019-04-10 10:00:01','success',NULL,'cron',NULL),(212,27,79,'2019-04-10 10:00:00','2019-04-10 10:00:01','success',NULL,'cron',NULL),(213,27,80,'2019-04-10 10:10:00','2019-04-10 10:10:00','success',NULL,'cron',NULL),(214,23,54,'2019-04-10 10:15:00','2019-04-10 10:15:00','success',NULL,'cron',NULL),(215,28,54,'2019-04-10 10:15:00','2019-04-10 10:15:00','success',NULL,'cron',NULL),(216,27,81,'2019-04-10 10:20:00','2019-04-10 10:20:00','success',NULL,'cron',NULL),(217,23,55,'2019-04-10 10:30:00','2019-04-10 10:30:00','success',NULL,'cron',NULL),(218,28,55,'2019-04-10 10:30:00','2019-04-10 10:30:00','success',NULL,'cron',NULL),(219,27,82,'2019-04-10 10:30:00','2019-04-10 10:30:00','success',NULL,'cron',NULL),(220,27,83,'2019-04-10 10:40:00','2019-04-10 10:40:00','success',NULL,'cron',NULL),(221,28,56,'2019-04-10 10:45:00','2019-04-10 10:45:00','success',NULL,'cron',NULL),(222,23,56,'2019-04-10 10:45:00','2019-04-10 10:45:00','success',NULL,'cron',NULL),(223,27,84,'2019-04-10 10:50:00','2019-04-10 10:50:00','success',NULL,'cron',NULL),(224,28,57,'2019-04-10 11:00:00','2019-04-10 11:00:00','success',NULL,'cron',NULL),(225,27,85,'2019-04-10 11:00:00','2019-04-10 11:00:00','success',NULL,'cron',NULL),(226,23,57,'2019-04-10 11:00:00','2019-04-10 11:00:00','success',NULL,'cron',NULL),(227,27,86,'2019-04-10 11:10:00','2019-04-10 11:10:00','success',NULL,'cron',NULL),(228,28,58,'2019-04-10 11:15:00','2019-04-10 11:15:00','success',NULL,'cron',NULL),(229,23,58,'2019-04-10 11:15:00','2019-04-10 11:15:00','success',NULL,'cron',NULL),(230,27,87,'2019-04-10 11:20:00','2019-04-10 11:20:00','success',NULL,'cron',NULL),(231,28,59,'2019-04-10 11:30:00','2019-04-10 11:30:00','success',NULL,'cron',NULL),(232,23,59,'2019-04-10 11:30:00','2019-04-10 11:30:00','success',NULL,'cron',NULL),(233,27,88,'2019-04-10 11:30:00','2019-04-10 11:30:00','success',NULL,'cron',NULL),(234,27,89,'2019-04-10 11:40:00','2019-04-10 11:40:00','success',NULL,'cron',NULL),(235,23,60,'2019-04-10 11:45:00','2019-04-10 11:45:00','success',NULL,'cron',NULL),(236,28,60,'2019-04-10 11:45:00','2019-04-10 11:45:00','success',NULL,'cron',NULL),(237,27,90,'2019-04-10 11:50:00','2019-04-10 11:50:00','success',NULL,'cron',NULL),(238,23,61,'2019-04-11 09:15:00','2019-04-11 09:15:00','success',NULL,'cron',NULL),(239,28,61,'2019-04-11 09:15:00','2019-04-11 09:15:00','success',NULL,'cron',NULL),(240,27,91,'2019-04-11 09:20:00','2019-04-11 09:20:00','success',NULL,'cron',NULL),(241,28,62,'2019-04-11 09:30:00','2019-04-11 09:30:00','success',NULL,'cron',NULL),(242,27,92,'2019-04-11 09:30:00','2019-04-11 09:30:00','success',NULL,'cron',NULL),(243,23,62,'2019-04-11 09:30:00','2019-04-11 09:30:00','success',NULL,'cron',NULL),(244,29,2,'2019-04-11 09:30:00','2019-04-11 09:30:00','success',NULL,'cron',NULL),(245,5,2,'2019-04-11 09:30:00','2019-04-11 09:30:00','success',NULL,'cron',NULL),(246,8,2,'2019-04-11 09:30:00','2019-04-11 09:30:00','success',NULL,'cron',NULL),(247,27,93,'2019-04-11 09:40:00','2019-04-11 09:40:00','success',NULL,'cron',NULL),(248,28,63,'2019-04-11 09:45:00','2019-04-11 09:45:00','success',NULL,'cron',NULL),(249,23,63,'2019-04-11 09:45:00','2019-04-11 09:45:00','success',NULL,'cron',NULL),(250,27,94,'2019-04-11 09:50:00','2019-04-11 09:50:00','success',NULL,'cron',NULL),(251,28,64,'2019-04-11 10:00:00','2019-04-11 10:00:00','success',NULL,'cron',NULL),(252,27,95,'2019-04-11 10:00:00','2019-04-11 10:00:00','success',NULL,'cron',NULL),(253,23,64,'2019-04-11 10:00:00','2019-04-11 10:00:00','success',NULL,'cron',NULL),(254,27,96,'2019-04-11 10:10:00','2019-04-11 10:10:00','success',NULL,'cron',NULL),(255,28,65,'2019-04-11 10:15:00','2019-04-11 10:15:00','success',NULL,'cron',NULL),(256,23,65,'2019-04-11 10:15:00','2019-04-11 10:15:00','success',NULL,'cron',NULL),(257,27,97,'2019-04-11 10:20:00','2019-04-11 10:20:00','success',NULL,'cron',NULL),(258,28,66,'2019-04-11 11:00:00','2019-04-11 11:00:00','success',NULL,'cron',NULL),(259,23,66,'2019-04-11 11:00:00','2019-04-11 11:00:00','success',NULL,'cron',NULL),(260,27,98,'2019-04-11 11:00:00','2019-04-11 11:00:00','success',NULL,'cron',NULL),(261,27,99,'2019-04-11 11:50:00','2019-04-11 11:50:00','success',NULL,'cron',NULL),(262,23,67,'2019-04-11 12:00:00','2019-04-11 12:00:23','success',NULL,'cron',NULL),(263,28,67,'2019-04-11 12:00:00','2019-04-11 12:00:23','success',NULL,'cron',NULL),(264,27,100,'2019-04-11 12:00:00','2019-04-11 12:00:23','success',NULL,'cron',NULL),(265,27,101,'2019-04-11 12:10:00','2019-04-11 12:10:01','success',NULL,'cron',NULL),(266,28,68,'2019-04-11 12:15:00','2019-04-11 12:15:00','success',NULL,'cron',NULL),(267,23,68,'2019-04-11 12:15:00','2019-04-11 12:15:00','success',NULL,'cron',NULL),(268,27,102,'2019-04-11 12:20:00','2019-04-11 12:20:00','success',NULL,'cron',NULL),(269,23,69,'2019-04-11 12:30:00','2019-04-11 12:30:00','success',NULL,'cron',NULL),(270,27,103,'2019-04-11 12:30:00','2019-04-11 12:30:00','success',NULL,'cron',NULL),(271,28,69,'2019-04-11 12:30:00','2019-04-11 12:30:00','success',NULL,'cron',NULL),(272,27,104,'2019-04-11 12:40:00','2019-04-11 12:40:00','success',NULL,'cron',NULL),(273,28,70,'2019-04-11 12:45:00','2019-04-11 12:45:00','success',NULL,'cron',NULL),(274,23,70,'2019-04-11 12:45:00','2019-04-11 12:45:00','success',NULL,'cron',NULL),(275,27,105,'2019-04-11 12:50:00','2019-04-11 12:50:00','success',NULL,'cron',NULL),(276,23,71,'2019-04-11 13:00:00','2019-04-11 13:00:00','success',NULL,'cron',NULL),(277,27,106,'2019-04-11 13:00:00','2019-04-11 13:00:00','success',NULL,'cron',NULL),(278,28,71,'2019-04-11 13:00:00','2019-04-11 13:00:00','success',NULL,'cron',NULL),(279,27,107,'2019-04-11 13:50:00','2019-04-11 13:50:00','success',NULL,'cron',NULL),(280,23,72,'2019-04-11 14:00:00','2019-04-11 14:00:35','success',NULL,'cron',NULL),(281,27,108,'2019-04-11 14:00:00','2019-04-11 14:00:35','success',NULL,'cron',NULL),(282,28,72,'2019-04-11 14:00:00','2019-04-11 14:00:35','success',NULL,'cron',NULL),(283,27,109,'2019-04-11 14:10:00','2019-04-11 14:10:00','success',NULL,'cron',NULL),(284,28,73,'2019-04-11 14:15:00','2019-04-11 14:15:00','success',NULL,'cron',NULL),(285,23,73,'2019-04-11 14:15:00','2019-04-11 14:15:00','success',NULL,'cron',NULL),(286,27,110,'2019-04-11 14:20:00','2019-04-11 14:20:00','success',NULL,'cron',NULL),(287,27,111,'2019-04-11 14:30:00','2019-04-11 14:30:00','success',NULL,'cron',NULL),(288,23,74,'2019-04-11 14:30:00','2019-04-11 14:30:00','success',NULL,'cron',NULL),(289,28,74,'2019-04-11 14:30:00','2019-04-11 14:30:00','success',NULL,'cron',NULL),(290,27,112,'2019-04-11 14:40:00','2019-04-11 14:40:00','success',NULL,'cron',NULL),(291,28,75,'2019-04-11 14:45:00','2019-04-11 14:45:00','success',NULL,'cron',NULL),(292,23,75,'2019-04-11 14:45:00','2019-04-11 14:45:00','success',NULL,'cron',NULL),(293,27,113,'2019-04-11 14:50:00','2019-04-11 14:50:00','success',NULL,'cron',NULL),(294,28,76,'2019-04-11 15:00:00','2019-04-11 15:00:00','success',NULL,'cron',NULL),(295,23,76,'2019-04-11 15:00:00','2019-04-11 15:00:00','success',NULL,'cron',NULL),(296,27,114,'2019-04-11 15:00:00','2019-04-11 15:00:00','success',NULL,'cron',NULL),(297,27,115,'2019-04-11 15:10:00','2019-04-11 15:10:00','success',NULL,'cron',NULL),(298,28,77,'2019-04-11 15:15:00','2019-04-11 15:15:01','success',NULL,'cron',NULL),(299,23,77,'2019-04-11 15:15:00','2019-04-11 15:15:01','success',NULL,'cron',NULL),(300,27,116,'2019-04-11 15:20:00','2019-04-11 15:20:00','success',NULL,'cron',NULL),(301,28,78,'2019-04-11 15:30:00','2019-04-11 15:30:00','success',NULL,'cron',NULL),(302,27,117,'2019-04-11 15:30:00','2019-04-11 15:30:00','success',NULL,'cron',NULL),(303,23,78,'2019-04-11 15:30:00','2019-04-11 15:30:00','success',NULL,'cron',NULL),(304,27,118,'2019-04-11 15:40:00','2019-04-11 15:40:01','success',NULL,'cron',NULL),(305,28,79,'2019-04-11 15:45:00','2019-04-11 15:45:00','success',NULL,'cron',NULL),(306,23,79,'2019-04-11 15:45:00','2019-04-11 15:45:00','success',NULL,'cron',NULL),(307,27,119,'2019-04-11 15:50:00','2019-04-11 15:50:00','success',NULL,'cron',NULL),(308,27,120,'2019-04-11 16:00:00','2019-04-11 16:00:00','success',NULL,'cron',NULL),(309,28,80,'2019-04-11 16:00:00','2019-04-11 16:00:00','success',NULL,'cron',NULL),(310,23,80,'2019-04-11 16:00:00','2019-04-11 16:00:00','success',NULL,'cron',NULL),(311,27,121,'2019-04-11 16:10:00','2019-04-11 16:10:00','success',NULL,'cron',NULL),(312,23,81,'2019-04-11 16:15:00','2019-04-11 16:15:00','success',NULL,'cron',NULL),(313,28,81,'2019-04-11 16:15:00','2019-04-11 16:15:00','success',NULL,'cron',NULL),(314,27,122,'2019-04-11 16:20:00','2019-04-11 16:20:00','success',NULL,'cron',NULL),(315,27,123,'2019-04-11 16:30:00','2019-04-11 16:30:00','success',NULL,'cron',NULL),(316,28,82,'2019-04-11 16:30:00','2019-04-11 16:30:00','success',NULL,'cron',NULL),(317,23,82,'2019-04-11 16:30:00','2019-04-11 16:30:00','success',NULL,'cron',NULL),(318,27,124,'2019-04-11 16:40:00','2019-04-11 16:40:00','success',NULL,'cron',NULL),(319,28,83,'2019-04-11 16:45:00','2019-04-11 16:45:00','success',NULL,'cron',NULL),(320,23,83,'2019-04-11 16:45:00','2019-04-11 16:45:00','success',NULL,'cron',NULL),(321,27,125,'2019-04-11 16:50:00','2019-04-11 16:50:00','success',NULL,'cron',NULL),(322,27,126,'2019-04-11 17:00:00','2019-04-11 17:00:00','success',NULL,'cron',NULL),(323,28,84,'2019-04-11 17:00:00','2019-04-11 17:00:00','success',NULL,'cron',NULL),(324,23,84,'2019-04-11 17:00:00','2019-04-11 17:00:00','success',NULL,'cron',NULL),(325,27,127,'2019-04-11 17:10:00','2019-04-11 17:10:00','success',NULL,'cron',NULL),(326,28,85,'2019-04-11 17:15:00','2019-04-11 17:15:00','success',NULL,'cron',NULL),(327,23,85,'2019-04-11 17:15:00','2019-04-11 17:15:00','success',NULL,'cron',NULL),(328,27,128,'2019-04-11 17:20:00','2019-04-11 17:20:00','success',NULL,'cron',NULL),(329,23,86,'2019-04-11 17:30:00','2019-04-11 17:30:00','success',NULL,'cron',NULL),(330,27,129,'2019-04-11 17:30:00','2019-04-11 17:30:00','success',NULL,'cron',NULL),(331,28,86,'2019-04-11 17:30:00','2019-04-11 17:30:00','success',NULL,'cron',NULL),(332,27,130,'2019-04-11 17:40:00','2019-04-11 17:40:00','success',NULL,'cron',NULL),(333,28,87,'2019-04-11 17:45:00','2019-04-11 17:45:00','success',NULL,'cron',NULL),(334,23,87,'2019-04-11 17:45:00','2019-04-11 17:45:00','success',NULL,'cron',NULL),(335,27,131,'2019-04-11 17:50:00','2019-04-11 17:50:00','success',NULL,'cron',NULL),(336,27,132,'2019-04-11 18:00:00','2019-04-11 18:00:00','success',NULL,'cron',NULL),(337,23,88,'2019-04-11 18:00:00','2019-04-11 18:00:00','success',NULL,'cron',NULL),(338,28,88,'2019-04-11 18:00:00','2019-04-11 18:00:00','success',NULL,'cron',NULL),(339,27,133,'2019-04-11 18:10:00','2019-04-11 18:10:00','success',NULL,'cron',NULL),(340,28,89,'2019-04-11 18:15:00','2019-04-11 18:15:00','success',NULL,'cron',NULL),(341,23,89,'2019-04-11 18:15:00','2019-04-11 18:15:00','success',NULL,'cron',NULL),(342,27,134,'2019-04-11 18:20:00','2019-04-11 18:20:00','success',NULL,'cron',NULL),(343,28,90,'2019-04-12 08:40:25','2019-04-12 08:41:28','success',NULL,'cron',NULL),(344,23,90,'2019-04-12 08:40:25','2019-04-12 08:41:28','success',NULL,'cron',NULL),(345,4,2,'2019-04-12 08:40:25','2019-04-12 08:41:28','success',NULL,'cron',NULL),(346,13,2,'2019-04-12 08:40:13','2019-04-12 08:41:28','success',NULL,'cron',NULL),(347,12,2,'2019-04-12 08:40:25','2019-04-12 08:41:28','success',NULL,'cron',NULL),(348,10,2,'2019-04-12 08:40:25','2019-04-12 08:41:28','success',NULL,'cron',NULL),(349,1,2,'2019-04-12 08:40:25','2019-04-12 08:41:28','success',NULL,'cron',NULL),(350,27,135,'2019-04-12 08:40:25','2019-04-12 08:41:29','success',NULL,'cron',NULL),(351,24,2,'2019-04-12 08:40:28','2019-04-12 08:41:29','success',NULL,'cron',NULL),(352,19,2,'2019-04-12 08:41:28','2019-04-12 08:41:29','success',NULL,'cron',NULL),(353,22,2,'2019-04-12 08:41:28','2019-04-12 08:41:29','success',NULL,'cron',NULL),(354,9,2,'2019-04-12 08:41:29','2019-04-12 08:41:29','success',NULL,'cron',NULL),(355,15,2,'2019-04-12 08:41:29','2019-04-12 08:41:29','success',NULL,'cron',NULL),(356,6,2,'2019-04-12 08:40:15','2019-04-12 08:41:29','success',NULL,'cron',NULL),(357,20,2,'2019-04-12 08:41:28','2019-04-12 08:41:31','success',NULL,'cron',NULL),(358,7,2,'2019-04-12 08:41:28','2019-04-12 08:41:32','success',NULL,'cron',NULL),(359,18,2,'2019-04-12 08:41:28','2019-04-12 08:41:32','success',NULL,'cron',NULL),(360,2,2,'2019-04-12 08:41:29','2019-04-12 08:41:34','success',NULL,'cron',NULL),(361,17,2,'2019-04-12 08:41:32','2019-04-12 08:41:35','success',NULL,'cron',NULL),(362,3,2,'2019-04-12 08:41:29','2019-04-12 08:41:35','success',NULL,'cron',NULL),(363,21,2,'2019-04-12 08:41:33','2019-04-12 08:41:35','success',NULL,'cron',NULL),(364,14,2,'2019-04-12 08:41:35','2019-04-12 08:41:35','success',NULL,'cron',NULL),(365,11,2,'2019-04-12 08:41:35','2019-04-12 08:41:35','success',NULL,'cron',NULL),(366,16,2,'2019-04-12 08:41:35','2019-04-12 08:41:35','success',NULL,'cron',NULL),(367,25,2,'2019-04-12 08:41:29','2019-04-12 08:41:35','success',NULL,'cron',NULL),(368,26,2,'2019-04-12 08:41:35','2019-04-12 08:41:35','success',NULL,'cron',NULL),(369,23,91,'2019-04-12 08:45:00','2019-04-12 08:45:00','success',NULL,'cron',NULL),(370,28,91,'2019-04-12 08:45:00','2019-04-12 08:45:00','success',NULL,'cron',NULL),(371,27,136,'2019-04-12 08:50:00','2019-04-12 08:50:00','success',NULL,'cron',NULL),(372,27,137,'2019-04-12 09:00:00','2019-04-12 09:00:00','success',NULL,'cron',NULL),(373,28,92,'2019-04-12 09:00:00','2019-04-12 09:00:00','success',NULL,'cron',NULL),(374,23,92,'2019-04-12 09:00:00','2019-04-12 09:00:00','success',NULL,'cron',NULL),(375,27,138,'2019-04-12 09:10:00','2019-04-12 09:10:00','success',NULL,'cron',NULL),(376,23,93,'2019-04-12 09:15:00','2019-04-12 09:15:00','success',NULL,'cron',NULL),(377,28,93,'2019-04-12 09:15:00','2019-04-12 09:15:00','success',NULL,'cron',NULL),(378,27,139,'2019-04-12 09:20:00','2019-04-12 09:20:00','success',NULL,'cron',NULL),(379,23,94,'2019-04-12 09:30:00','2019-04-12 09:30:00','success',NULL,'cron',NULL),(380,29,3,'2019-04-12 09:30:00','2019-04-12 09:30:00','success',NULL,'cron',NULL),(381,28,94,'2019-04-12 09:30:00','2019-04-12 09:30:00','success',NULL,'cron',NULL),(382,27,140,'2019-04-12 09:30:00','2019-04-12 09:30:00','success',NULL,'cron',NULL),(383,8,3,'2019-04-12 09:30:00','2019-04-12 09:30:00','success',NULL,'cron',NULL),(384,5,3,'2019-04-12 09:30:00','2019-04-12 09:30:02','success',NULL,'cron',NULL),(385,27,141,'2019-04-12 09:40:00','2019-04-12 09:40:00','success',NULL,'cron',NULL),(386,28,95,'2019-04-12 09:45:00','2019-04-12 09:45:00','success',NULL,'cron',NULL),(387,23,95,'2019-04-12 09:45:00','2019-04-12 09:45:00','success',NULL,'cron',NULL),(388,27,142,'2019-04-12 09:50:00','2019-04-12 09:50:00','success',NULL,'cron',NULL),(389,27,143,'2019-04-12 10:00:00','2019-04-12 10:00:01','success',NULL,'cron',NULL),(390,28,96,'2019-04-12 10:00:00','2019-04-12 10:00:01','success',NULL,'cron',NULL),(391,23,96,'2019-04-12 10:00:00','2019-04-12 10:00:01','success',NULL,'cron',NULL),(392,27,144,'2019-04-12 10:10:00','2019-04-12 10:10:00','success',NULL,'cron',NULL),(393,28,97,'2019-04-12 10:15:00','2019-04-12 10:15:00','success',NULL,'cron',NULL),(394,23,97,'2019-04-12 10:15:00','2019-04-12 10:15:00','success',NULL,'cron',NULL),(395,27,145,'2019-04-12 10:20:00','2019-04-12 10:20:00','success',NULL,'cron',NULL),(396,28,98,'2019-04-12 10:30:00','2019-04-12 10:30:00','success',NULL,'cron',NULL),(397,23,98,'2019-04-12 10:30:00','2019-04-12 10:30:00','success',NULL,'cron',NULL),(398,27,146,'2019-04-12 10:30:00','2019-04-12 10:30:00','success',NULL,'cron',NULL),(399,27,147,'2019-04-12 10:40:00','2019-04-12 10:40:00','success',NULL,'cron',NULL),(400,28,99,'2019-04-12 10:45:00','2019-04-12 10:45:01','success',NULL,'cron',NULL),(401,23,99,'2019-04-12 10:45:00','2019-04-12 10:45:01','success',NULL,'cron',NULL),(402,27,148,'2019-04-12 10:50:00','2019-04-12 10:50:00','success',NULL,'cron',NULL),(403,23,100,'2019-04-12 11:00:00','2019-04-12 11:00:00','success',NULL,'cron',NULL),(404,28,100,'2019-04-12 11:00:00','2019-04-12 11:00:00','success',NULL,'cron',NULL),(405,27,149,'2019-04-12 11:00:00','2019-04-12 11:00:00','success',NULL,'cron',NULL),(406,27,150,'2019-04-12 11:10:00','2019-04-12 11:10:00','success',NULL,'cron',NULL),(407,23,101,'2019-04-12 11:15:00','2019-04-12 11:15:00','success',NULL,'cron',NULL),(408,28,101,'2019-04-12 11:15:00','2019-04-12 11:15:00','success',NULL,'cron',NULL),(409,27,151,'2019-04-12 11:20:00','2019-04-12 11:20:00','success',NULL,'cron',NULL),(410,28,102,'2019-04-12 11:30:00','2019-04-12 11:30:00','success',NULL,'cron',NULL),(411,23,102,'2019-04-12 11:30:00','2019-04-12 11:30:00','success',NULL,'cron',NULL),(412,27,152,'2019-04-12 11:30:00','2019-04-12 11:30:01','success',NULL,'cron',NULL),(413,23,103,'2019-04-15 11:00:00','2019-04-15 11:00:00','success',NULL,'cron',NULL),(414,23,104,'2019-04-15 11:15:00','2019-04-15 11:15:00','success',NULL,'cron',NULL),(415,23,105,'2019-04-15 11:30:00','2019-04-15 11:30:00','success',NULL,'cron',NULL),(416,23,106,'2019-04-15 11:45:00','2019-04-15 11:45:00','success',NULL,'cron',NULL),(417,23,107,'2019-04-15 12:00:00','2019-04-15 12:00:00','success',NULL,'cron',NULL),(418,23,108,'2019-04-15 12:15:00','2019-04-15 12:15:00','success',NULL,'cron',NULL),(419,23,109,'2019-04-15 12:30:00','2019-04-15 12:30:03','success',NULL,'cron',NULL),(420,23,110,'2019-04-15 12:45:00','2019-04-15 12:45:00','success',NULL,'cron',NULL),(421,23,111,'2019-04-15 13:00:00','2019-04-15 13:00:00','success',NULL,'cron',NULL),(422,23,112,'2019-04-15 13:15:00','2019-04-15 13:15:00','success',NULL,'cron',NULL),(423,23,113,'2019-04-15 13:30:00','2019-04-15 13:30:00','success',NULL,'cron',NULL),(424,23,114,'2019-04-15 13:45:00','2019-04-15 13:45:00','success',NULL,'cron',NULL),(425,23,115,'2019-04-15 14:00:00','2019-04-15 14:00:00','success',NULL,'cron',NULL),(426,23,116,'2019-04-15 14:15:00','2019-04-15 14:15:00','success',NULL,'cron',NULL),(427,23,117,'2019-04-15 14:30:00','2019-04-15 14:30:00','success',NULL,'cron',NULL),(428,23,118,'2019-04-15 14:45:00','2019-04-15 14:45:00','success',NULL,'cron',NULL),(429,23,119,'2019-04-15 15:00:00','2019-04-15 15:00:00','success',NULL,'cron',NULL),(430,23,120,'2019-04-15 15:15:00','2019-04-15 15:15:00','success',NULL,'cron',NULL),(431,23,121,'2019-04-15 15:30:00','2019-04-15 15:30:00','success',NULL,'cron',NULL),(432,23,122,'2019-04-15 15:45:00','2019-04-15 15:45:00','success',NULL,'cron',NULL),(433,23,123,'2019-04-15 16:00:00','2019-04-15 16:00:00','success',NULL,'cron',NULL),(434,23,124,'2019-04-15 16:15:00','2019-04-15 16:15:00','success',NULL,'cron',NULL),(435,23,125,'2019-04-15 16:30:00','2019-04-15 16:30:00','success',NULL,'cron',NULL),(436,23,126,'2019-04-15 16:45:00','2019-04-15 16:45:02','success',NULL,'cron',NULL),(437,23,127,'2019-04-15 17:00:00','2019-04-15 17:00:01','success',NULL,'cron',NULL),(438,23,128,'2019-04-26 16:30:05','2019-04-26 16:30:07','success',NULL,'cron',NULL),(439,23,129,'2019-04-26 16:45:00','2019-04-26 16:45:00','success',NULL,'cron',NULL),(440,23,130,'2019-04-29 09:45:00','2019-04-29 09:45:00','success',NULL,'cron',NULL),(441,23,131,'2019-04-29 10:00:00','2019-04-29 10:00:00','success',NULL,'cron',NULL),(442,23,132,'2019-04-29 10:15:00','2019-04-29 10:15:00','success',NULL,'cron',NULL),(443,23,133,'2019-04-29 10:30:00','2019-04-29 10:30:00','success',NULL,'cron',NULL),(444,23,134,'2019-04-29 10:45:00','2019-04-29 10:45:00','success',NULL,'cron',NULL),(445,23,135,'2019-04-29 11:00:00','2019-04-29 11:00:00','success',NULL,'cron',NULL),(446,23,136,'2019-04-29 11:15:00','2019-04-29 11:15:00','success',NULL,'cron',NULL),(447,23,137,'2019-04-29 11:30:00','2019-04-29 11:30:00','success',NULL,'cron',NULL),(448,23,138,'2019-04-29 11:45:00','2019-04-29 11:45:00','success',NULL,'cron',NULL),(449,23,139,'2019-04-29 12:00:00','2019-04-29 12:00:00','success',NULL,'cron',NULL),(450,23,140,'2019-04-29 12:15:00','2019-04-29 12:15:00','success',NULL,'cron',NULL),(451,23,141,'2019-04-29 12:30:00','2019-04-29 12:30:00','success',NULL,'cron',NULL),(452,23,142,'2019-04-29 12:45:00','2019-04-29 12:45:00','success',NULL,'cron',NULL),(453,23,143,'2019-04-29 13:00:00','2019-04-29 13:00:00','success',NULL,'cron',NULL),(454,23,144,'2019-04-29 13:15:00','2019-04-29 13:15:00','success',NULL,'cron',NULL),(455,23,145,'2019-04-29 13:30:00','2019-04-29 13:30:00','success',NULL,'cron',NULL),(456,23,146,'2019-04-29 13:45:00','2019-04-29 13:45:00','success',NULL,'cron',NULL),(457,23,147,'2019-04-29 14:00:00','2019-04-29 14:00:00','success',NULL,'cron',NULL),(458,23,148,'2019-04-29 17:10:26','2019-04-29 17:10:26','success',NULL,'cron',NULL),(459,23,149,'2019-04-29 17:15:00','2019-04-29 17:15:00','success',NULL,'cron',NULL),(460,19,3,'2019-04-30 08:58:29','2019-04-30 08:58:34','success',NULL,'cron',NULL),(461,23,150,'2019-04-30 08:58:29','2019-04-30 08:58:34','success',NULL,'cron',NULL),(462,1,3,'2019-04-30 08:58:29','2019-04-30 08:58:34','success',NULL,'cron',NULL),(463,13,3,'2019-04-30 08:58:18','2019-04-30 08:58:34','success',NULL,'cron',NULL),(464,20,3,'2019-04-30 08:58:29','2019-04-30 08:58:34','success',NULL,'cron',NULL),(465,10,3,'2019-04-30 08:58:29','2019-04-30 08:58:35','success',NULL,'cron',NULL),(466,4,3,'2019-04-30 08:58:29','2019-04-30 08:58:34','success',NULL,'cron',NULL),(467,12,3,'2019-04-30 08:58:29','2019-04-30 08:58:35','success',NULL,'cron',NULL),(468,24,3,'2019-04-30 08:58:23','2019-04-30 08:58:35','success',NULL,'cron',NULL),(469,6,3,'2019-04-30 08:58:20','2019-04-30 08:58:35','success',NULL,'cron',NULL),(470,3,3,'2019-04-30 08:58:35','2019-04-30 08:58:35','success',NULL,'cron',NULL),(471,22,3,'2019-04-30 08:58:35','2019-04-30 08:58:35','success',NULL,'cron',NULL),(472,14,3,'2019-04-30 08:58:35','2019-04-30 08:58:35','success',NULL,'cron',NULL),(473,25,3,'2019-04-30 08:58:35','2019-04-30 08:58:35','success',NULL,'cron',NULL),(474,2,3,'2019-04-30 08:58:35','2019-04-30 08:58:36','success',NULL,'cron',NULL),(475,26,3,'2019-04-30 08:58:35','2019-04-30 08:58:36','success',NULL,'cron',NULL),(476,17,3,'2019-04-30 08:58:35','2019-04-30 08:58:36','success',NULL,'cron',NULL),(477,21,3,'2019-04-30 08:58:35','2019-04-30 08:58:36','success',NULL,'cron',NULL),(478,11,3,'2019-04-30 08:58:36','2019-04-30 08:58:36','success',NULL,'cron',NULL),(479,16,3,'2019-04-30 08:58:36','2019-04-30 08:58:36','success',NULL,'cron',NULL),(480,9,3,'2019-04-30 08:58:35','2019-04-30 08:58:37','success',NULL,'cron',NULL),(481,18,3,'2019-04-30 08:58:34','2019-04-30 08:58:38','success',NULL,'cron',NULL),(482,7,3,'2019-04-30 08:58:34','2019-04-30 08:58:38','success',NULL,'cron',NULL),(483,15,3,'2019-04-30 08:58:35','2019-04-30 08:58:38','success',NULL,'cron',NULL),(484,23,151,'2019-04-30 09:00:00','2019-04-30 09:00:00','success',NULL,'cron',NULL),(485,23,152,'2019-04-30 09:15:00','2019-04-30 09:15:00','success',NULL,'cron',NULL),(486,5,4,'2019-04-30 09:30:00','2019-04-30 09:30:00','success',NULL,'cron',NULL),(487,23,153,'2019-04-30 09:30:00','2019-04-30 09:30:00','success',NULL,'cron',NULL),(488,8,4,'2019-04-30 09:30:00','2019-04-30 09:30:00','success',NULL,'cron',NULL),(489,23,154,'2019-04-30 09:45:00','2019-04-30 09:45:00','success',NULL,'cron',NULL),(490,23,155,'2019-04-30 10:00:00','2019-04-30 10:00:00','success',NULL,'cron',NULL),(491,23,156,'2019-04-30 10:15:00','2019-04-30 10:15:00','success',NULL,'cron',NULL),(492,23,157,'2019-04-30 10:30:00','2019-04-30 10:30:01','success',NULL,'cron',NULL),(493,23,158,'2019-04-30 10:45:00','2019-04-30 10:45:00','success',NULL,'cron',NULL),(494,23,159,'2019-04-30 11:00:00','2019-04-30 11:00:00','success',NULL,'cron',NULL),(495,23,160,'2019-04-30 11:15:00','2019-04-30 11:15:00','success',NULL,'cron',NULL),(496,23,161,'2019-04-30 11:30:00','2019-04-30 11:30:00','success',NULL,'cron',NULL),(497,23,162,'2019-04-30 11:45:00','2019-04-30 11:45:00','success',NULL,'cron',NULL),(498,23,163,'2019-04-30 12:00:00','2019-04-30 12:00:00','success',NULL,'cron',NULL),(499,23,164,'2019-04-30 12:15:00','2019-04-30 12:15:00','success',NULL,'cron',NULL),(500,23,165,'2019-04-30 12:30:00','2019-04-30 12:30:00','success',NULL,'cron',NULL),(501,23,166,'2019-04-30 12:45:00','2019-04-30 12:45:00','success',NULL,'cron',NULL),(502,23,167,'2019-04-30 13:00:00','2019-04-30 13:00:00','success',NULL,'cron',NULL),(503,23,168,'2019-04-30 13:15:00','2019-04-30 13:15:00','success',NULL,'cron',NULL),(504,23,169,'2019-04-30 13:30:00','2019-04-30 13:30:00','success',NULL,'cron',NULL),(505,23,170,'2019-04-30 13:45:00','2019-04-30 13:45:00','success',NULL,'cron',NULL),(506,23,171,'2019-05-07 09:45:00','2019-05-07 09:45:00','success',NULL,'cron',NULL),(507,23,172,'2019-05-07 10:00:00','2019-05-07 10:00:00','success',NULL,'cron',NULL),(508,23,173,'2019-05-07 10:15:00','2019-05-07 10:15:00','success',NULL,'cron',NULL),(509,23,174,'2019-05-07 10:30:00','2019-05-07 10:30:00','success',NULL,'cron',NULL),(510,23,175,'2019-05-07 10:45:00','2019-05-07 10:45:00','success',NULL,'cron',NULL),(511,23,176,'2019-05-07 11:00:00','2019-05-07 11:00:00','success',NULL,'cron',NULL),(512,23,177,'2019-05-07 11:15:00','2019-05-07 11:15:00','success',NULL,'cron',NULL),(513,23,178,'2019-05-07 11:30:00','2019-05-07 11:30:00','success',NULL,'cron',NULL),(514,23,179,'2019-05-07 11:45:00','2019-05-07 11:45:00','success',NULL,'cron',NULL),(515,23,180,'2019-05-07 12:00:00','2019-05-07 12:00:00','success',NULL,'cron',NULL),(516,23,181,'2019-05-07 12:15:00','2019-05-07 12:15:00','success',NULL,'cron',NULL),(517,23,182,'2019-05-07 12:30:00','2019-05-07 12:30:00','success',NULL,'cron',NULL),(518,23,183,'2019-05-07 12:45:00','2019-05-07 12:45:00','success',NULL,'cron',NULL),(519,23,184,'2019-05-07 13:00:00','2019-05-07 13:00:00','success',NULL,'cron',NULL),(520,23,185,'2019-05-07 13:15:00','2019-05-07 13:15:00','success',NULL,'cron',NULL),(521,23,186,'2019-05-07 13:30:00','2019-05-07 13:30:00','success',NULL,'cron',NULL),(522,23,187,'2019-05-07 13:45:00','2019-05-07 13:45:00','success',NULL,'cron',NULL),(523,23,188,'2019-05-07 14:00:00','2019-05-07 14:00:00','success',NULL,'cron',NULL),(524,23,189,'2019-05-08 17:00:00','2019-05-08 17:00:01','success',NULL,'cron',NULL),(525,28,103,'2019-05-08 17:00:00','2019-05-08 17:00:01','success',NULL,'cron',NULL),(526,27,153,'2019-05-08 17:00:00','2019-05-08 17:00:01','success',NULL,'cron',NULL),(527,27,154,'2019-05-08 17:10:00','2019-05-08 17:10:02','success',NULL,'cron',NULL),(528,23,190,'2019-05-08 17:15:00','2019-05-08 17:15:00','success',NULL,'cron',NULL),(529,28,104,'2019-05-08 17:15:00','2019-05-08 17:15:00','success',NULL,'cron',NULL),(530,27,155,'2019-05-08 17:20:00','2019-05-08 17:20:00','success',NULL,'cron',NULL),(531,28,105,'2019-05-08 17:30:00','2019-05-08 17:30:00','success',NULL,'cron',NULL),(532,27,156,'2019-05-08 17:30:00','2019-05-08 17:30:00','success',NULL,'cron',NULL),(533,23,191,'2019-05-08 17:30:00','2019-05-08 17:30:00','success',NULL,'cron',NULL),(534,27,157,'2019-05-08 17:40:00','2019-05-08 17:40:00','success',NULL,'cron',NULL),(535,28,106,'2019-05-08 17:45:00','2019-05-08 17:45:00','success',NULL,'cron',NULL),(536,23,192,'2019-05-08 17:45:00','2019-05-08 17:45:00','success',NULL,'cron',NULL),(537,27,158,'2019-05-08 18:00:00','2019-05-08 18:00:00','success',NULL,'cron',NULL),(538,23,193,'2019-05-08 18:00:00','2019-05-08 18:00:00','success',NULL,'cron',NULL),(539,28,107,'2019-05-08 18:00:00','2019-05-08 18:00:00','success',NULL,'cron',NULL),(540,27,159,'2019-05-08 18:10:00','2019-05-08 18:10:00','success',NULL,'cron',NULL),(541,28,108,'2019-05-08 18:15:00','2019-05-08 18:15:00','success',NULL,'cron',NULL),(542,23,194,'2019-05-08 18:15:00','2019-05-08 18:15:00','success',NULL,'cron',NULL),(543,27,160,'2019-05-08 18:20:00','2019-05-08 18:20:00','success',NULL,'cron',NULL),(544,23,195,'2019-05-08 18:30:00','2019-05-08 18:30:00','success',NULL,'cron',NULL),(545,27,161,'2019-05-08 18:30:00','2019-05-08 18:30:00','success',NULL,'cron',NULL),(546,28,109,'2019-05-08 18:30:00','2019-05-08 18:30:00','success',NULL,'cron',NULL),(547,27,162,'2019-05-08 18:40:00','2019-05-08 18:40:00','success',NULL,'cron',NULL),(548,23,196,'2019-05-08 18:45:00','2019-05-08 18:45:00','success',NULL,'cron',NULL),(549,28,110,'2019-05-08 18:45:00','2019-05-08 18:45:00','success',NULL,'cron',NULL),(550,28,111,'2019-05-08 19:17:47','2019-05-08 19:17:47','success',NULL,'cron',NULL),(551,23,197,'2019-05-08 19:17:47','2019-05-08 19:17:47','success',NULL,'cron',NULL),(552,27,163,'2019-05-08 19:17:47','2019-05-08 19:17:47','success',NULL,'cron',NULL),(553,27,164,'2019-05-08 19:20:00','2019-05-08 19:20:00','success',NULL,'cron',NULL),(554,23,198,'2019-05-08 19:35:15','2019-05-08 19:35:15','success',NULL,'cron',NULL),(555,28,112,'2019-05-08 19:35:15','2019-05-08 19:35:15','success',NULL,'cron',NULL),(556,27,165,'2019-05-08 19:35:15','2019-05-08 19:35:15','success',NULL,'cron',NULL),(557,1,4,'2019-05-08 19:35:15','2019-05-08 19:35:15','success',NULL,'cron',NULL),(558,27,166,'2019-05-08 19:58:18','2019-05-08 19:58:18','success',NULL,'cron',NULL),(559,28,113,'2019-05-08 19:58:18','2019-05-08 19:58:18','success',NULL,'cron',NULL),(560,23,199,'2019-05-08 19:58:18','2019-05-08 19:58:18','success',NULL,'cron',NULL),(561,4,4,'2019-05-08 19:58:18','2019-05-08 19:58:18','success',NULL,'cron',NULL),(562,27,167,'2019-05-08 20:00:00','2019-05-08 20:00:00','success',NULL,'cron',NULL),(563,23,200,'2019-05-08 20:00:00','2019-05-08 20:00:00','success',NULL,'cron',NULL),(564,28,114,'2019-05-08 20:00:00','2019-05-08 20:00:00','success',NULL,'cron',NULL),(565,27,168,'2019-05-08 20:10:00','2019-05-08 20:10:00','success',NULL,'cron',NULL),(566,28,115,'2019-05-08 20:15:00','2019-05-08 20:15:00','success',NULL,'cron',NULL),(567,23,201,'2019-05-08 20:15:00','2019-05-08 20:15:00','success',NULL,'cron',NULL),(568,27,169,'2019-05-08 20:20:00','2019-05-08 20:20:00','success',NULL,'cron',NULL),(569,28,116,'2019-05-08 20:30:00','2019-05-08 20:30:00','success',NULL,'cron',NULL),(570,23,202,'2019-05-08 20:30:00','2019-05-08 20:30:00','success',NULL,'cron',NULL),(571,27,170,'2019-05-08 20:30:00','2019-05-08 20:30:00','success',NULL,'cron',NULL),(572,27,171,'2019-05-08 20:40:00','2019-05-08 20:40:00','success',NULL,'cron',NULL),(573,28,117,'2019-05-08 20:45:00','2019-05-08 20:45:00','success',NULL,'cron',NULL),(574,23,203,'2019-05-08 20:45:00','2019-05-08 20:45:00','success',NULL,'cron',NULL),(575,27,172,'2019-05-08 20:50:00','2019-05-08 20:50:00','success',NULL,'cron',NULL),(576,27,173,'2019-05-08 21:00:00','2019-05-08 21:00:00','success',NULL,'cron',NULL),(577,23,204,'2019-05-08 21:00:00','2019-05-08 21:00:00','success',NULL,'cron',NULL),(578,28,118,'2019-05-08 21:00:00','2019-05-08 21:00:00','success',NULL,'cron',NULL),(579,27,174,'2019-05-08 21:10:00','2019-05-08 21:10:00','success',NULL,'cron',NULL),(580,23,205,'2019-05-08 21:15:00','2019-05-08 21:15:00','success',NULL,'cron',NULL),(581,28,119,'2019-05-08 21:15:00','2019-05-08 21:15:00','success',NULL,'cron',NULL),(582,27,175,'2019-05-08 21:20:00','2019-05-08 21:20:00','success',NULL,'cron',NULL),(583,27,176,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(584,23,206,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(585,28,120,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(586,13,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(587,12,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(588,10,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(589,20,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(590,6,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(591,15,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(592,21,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(593,19,4,'2019-05-08 21:30:00','2019-05-08 21:30:00','success',NULL,'cron',NULL),(594,22,4,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(595,7,4,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(596,30,1,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(597,9,4,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(598,2,4,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(599,17,4,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(600,11,4,'2019-05-08 21:31:00','2019-05-08 21:31:00','success',NULL,'cron',NULL),(601,14,4,'2019-05-08 21:32:00','2019-05-08 21:32:00','success',NULL,'cron',NULL),(602,16,4,'2019-05-08 21:32:00','2019-05-08 21:32:00','success',NULL,'cron',NULL),(603,3,4,'2019-05-08 21:35:00','2019-05-08 21:35:00','success',NULL,'cron',NULL),(604,18,4,'2019-05-08 21:35:00','2019-05-08 21:35:00','success',NULL,'cron',NULL),(605,27,177,'2019-05-08 21:40:00','2019-05-08 21:40:00','success',NULL,'cron',NULL),(606,23,207,'2019-05-08 21:45:00','2019-05-08 21:45:00','success',NULL,'cron',NULL),(607,28,121,'2019-05-08 21:45:00','2019-05-08 21:45:00','success',NULL,'cron',NULL),(608,27,178,'2019-05-08 21:50:00','2019-05-08 21:50:00','success',NULL,'cron',NULL),(609,23,208,'2019-05-08 22:00:00','2019-05-08 22:00:00','success',NULL,'cron',NULL),(610,27,179,'2019-05-08 22:00:00','2019-05-08 22:00:00','success',NULL,'cron',NULL),(611,28,122,'2019-05-08 22:00:00','2019-05-08 22:00:00','success',NULL,'cron',NULL),(612,27,180,'2019-05-08 22:10:00','2019-05-08 22:10:00','success',NULL,'cron',NULL),(613,28,123,'2019-05-08 22:15:00','2019-05-08 22:15:00','success',NULL,'cron',NULL),(614,23,209,'2019-05-08 22:15:00','2019-05-08 22:15:00','success',NULL,'cron',NULL),(615,27,181,'2019-05-08 22:20:00','2019-05-08 22:20:00','success',NULL,'cron',NULL),(616,28,124,'2019-05-08 22:30:00','2019-05-08 22:30:00','success',NULL,'cron',NULL),(617,27,182,'2019-05-08 22:30:00','2019-05-08 22:30:00','success',NULL,'cron',NULL),(618,23,210,'2019-05-08 22:30:00','2019-05-08 22:30:00','success',NULL,'cron',NULL),(619,27,183,'2019-05-08 22:40:00','2019-05-08 22:40:00','success',NULL,'cron',NULL),(620,28,125,'2019-05-08 22:45:00','2019-05-08 22:45:00','success',NULL,'cron',NULL),(621,23,211,'2019-05-08 22:45:00','2019-05-08 22:45:00','success',NULL,'cron',NULL),(622,27,184,'2019-05-08 22:50:00','2019-05-08 22:50:00','success',NULL,'cron',NULL),(623,23,212,'2019-05-08 23:00:00','2019-05-08 23:00:00','success',NULL,'cron',NULL),(624,27,185,'2019-05-08 23:00:00','2019-05-08 23:00:00','success',NULL,'cron',NULL),(625,28,126,'2019-05-08 23:00:00','2019-05-08 23:00:00','success',NULL,'cron',NULL),(626,27,186,'2019-05-08 23:10:00','2019-05-08 23:10:00','success',NULL,'cron',NULL),(627,23,213,'2019-05-08 23:15:00','2019-05-08 23:15:00','success',NULL,'cron',NULL),(628,28,127,'2019-05-08 23:15:00','2019-05-08 23:15:00','success',NULL,'cron',NULL),(629,27,187,'2019-05-08 23:20:00','2019-05-08 23:20:00','success',NULL,'cron',NULL);
/*!40000 ALTER TABLE `job_run_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_details`
--

DROP TABLE IF EXISTS `m_account_transfer_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) NOT NULL,
  `to_office_id` bigint(20) NOT NULL,
  `from_client_id` bigint(20) DEFAULT NULL,
  `to_client_id` bigint(20) DEFAULT NULL,
  `from_savings_account_id` bigint(20) DEFAULT NULL,
  `to_savings_account_id` bigint(20) DEFAULT NULL,
  `from_loan_account_id` bigint(20) DEFAULT NULL,
  `to_loan_account_id` bigint(20) DEFAULT NULL,
  `transfer_type` smallint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_account_transfer_details_from_office` (`from_office_id`),
  KEY `FK_m_account_transfer_details_to_office` (`to_office_id`),
  KEY `FK_m_account_transfer_details_from_client` (`from_client_id`),
  KEY `FK_m_account_transfer_details_to_client` (`to_client_id`),
  KEY `FK_m_account_transfer_details_from_savings_account` (`from_savings_account_id`),
  KEY `FK_m_account_transfer_details_to_savings_account` (`to_savings_account_id`),
  KEY `FK_m_account_transfer_details_from_loan_account` (`from_loan_account_id`),
  KEY `FK_m_account_transfer_details_to_loan_account` (`to_loan_account_id`),
  CONSTRAINT `FK_m_account_transfer_details_from_client` FOREIGN KEY (`from_client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_from_loan_account` FOREIGN KEY (`from_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_from_office` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_from_savings_account` FOREIGN KEY (`from_savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_client` FOREIGN KEY (`to_client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_loan_account` FOREIGN KEY (`to_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_office` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_savings_account` FOREIGN KEY (`to_savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_details`
--

LOCK TABLES `m_account_transfer_details` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_standing_instructions`
--

DROP TABLE IF EXISTS `m_account_transfer_standing_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_standing_instructions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `account_transfer_details_id` bigint(20) NOT NULL,
  `priority` tinyint(2) NOT NULL,
  `status` tinyint(2) NOT NULL,
  `instruction_type` tinyint(2) NOT NULL,
  `amount` decimal(19,6) DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date DEFAULT NULL,
  `recurrence_type` tinyint(1) NOT NULL,
  `recurrence_frequency` smallint(5) DEFAULT NULL,
  `recurrence_interval` smallint(5) DEFAULT NULL,
  `recurrence_on_day` smallint(2) DEFAULT NULL,
  `recurrence_on_month` smallint(2) DEFAULT NULL,
  `last_run_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_m_standing_instructions_account_transfer_details` (`account_transfer_details_id`),
  CONSTRAINT `FK_m_standing_instructions_account_transfer_details` FOREIGN KEY (`account_transfer_details_id`) REFERENCES `m_account_transfer_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_standing_instructions`
--

LOCK TABLES `m_account_transfer_standing_instructions` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_standing_instructions_history`
--

DROP TABLE IF EXISTS `m_account_transfer_standing_instructions_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_standing_instructions_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `standing_instruction_id` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `execution_time` datetime NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `error_log` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_account_transfer_standing_instructions_history` (`standing_instruction_id`),
  CONSTRAINT `FK_m_account_transfer_standing_instructions_m_history` FOREIGN KEY (`standing_instruction_id`) REFERENCES `m_account_transfer_standing_instructions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_standing_instructions_history`
--

LOCK TABLES `m_account_transfer_standing_instructions_history` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_transaction`
--

DROP TABLE IF EXISTS `m_account_transfer_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_transfer_details_id` bigint(20) NOT NULL,
  `from_savings_transaction_id` bigint(20) DEFAULT NULL,
  `from_loan_transaction_id` bigint(20) DEFAULT NULL,
  `to_savings_transaction_id` bigint(20) DEFAULT NULL,
  `to_loan_transaction_id` bigint(20) DEFAULT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `transaction_date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_account_transfer_transaction_from_m_savings_transaction` (`from_savings_transaction_id`),
  KEY `FK_m_account_transfer_transaction_to_m_savings_transaction` (`to_savings_transaction_id`),
  KEY `FK_m_account_transfer_transaction_to_m_loan_transaction` (`to_loan_transaction_id`),
  KEY `FK_m_account_transfer_transaction_from_m_loan_transaction` (`from_loan_transaction_id`),
  KEY `FK_m_account_transfer_transaction_account_detail` (`account_transfer_details_id`),
  CONSTRAINT `FK_m_account_transfer_transaction_account_detail` FOREIGN KEY (`account_transfer_details_id`) REFERENCES `m_account_transfer_details` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_from_m_loan_transaction` FOREIGN KEY (`from_loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_from_m_savings_transaction` FOREIGN KEY (`from_savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_to_m_loan_transaction` FOREIGN KEY (`to_loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_to_m_savings_transaction` FOREIGN KEY (`to_savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_transaction`
--

LOCK TABLES `m_account_transfer_transaction` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_address`
--

DROP TABLE IF EXISTS `m_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `street` varchar(100) DEFAULT NULL,
  `address_line_1` varchar(100) DEFAULT NULL,
  `address_line_2` varchar(100) DEFAULT NULL,
  `address_line_3` varchar(100) DEFAULT NULL,
  `town_village` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `county_district` varchar(100) DEFAULT NULL,
  `state_province_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `latitude` decimal(10,8) unsigned DEFAULT '0.00000000',
  `longitude` decimal(10,8) unsigned DEFAULT '0.00000000',
  `created_by` varchar(100) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_fields_codefk1` (`state_province_id`),
  KEY `address_fields_codefk2` (`country_id`),
  CONSTRAINT `address_fields_codefk1` FOREIGN KEY (`state_province_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `address_fields_codefk2` FOREIGN KEY (`country_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_address`
--

LOCK TABLES `m_address` WRITE;
/*!40000 ALTER TABLE `m_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_adhoc`
--

DROP TABLE IF EXISTS `m_adhoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_adhoc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `query` varchar(2000) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `table_fields` varchar(1000) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `report_run_frequency_code` int(11) DEFAULT NULL,
  `report_run_every` int(11) DEFAULT NULL,
  `last_run` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `createdby_id` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `lastmodifiedby_id` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_adhoc`
--

LOCK TABLES `m_adhoc` WRITE;
/*!40000 ALTER TABLE `m_adhoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_adhoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser`
--

DROP TABLE IF EXISTS `m_appuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `firsttime_login_remaining` bit(1) NOT NULL,
  `nonexpired` bit(1) NOT NULL,
  `nonlocked` bit(1) NOT NULL,
  `nonexpired_credentials` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `last_time_password_updated` date NOT NULL DEFAULT '1970-01-01',
  `password_never_expires` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'define if the password, should be check for validity period or not',
  `is_self_service_user` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_org` (`username`),
  KEY `FKB3D587CE0DD567A` (`office_id`),
  KEY `fk_m_appuser_002x` (`staff_id`),
  KEY `last_time_password_updated` (`last_time_password_updated`),
  CONSTRAINT `FKB3D587CE0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `fk_m_appuser_002` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser`
--

LOCK TABLES `m_appuser` WRITE;
/*!40000 ALTER TABLE `m_appuser` DISABLE KEYS */;
INSERT INTO `m_appuser` VALUES (1,0,1,NULL,'mifos','App','Administrator','5787039480429368bf94732aacc771cd0a3ea02bcf504ffe1185ab94213bc63a','demomfi@mifos.org','\0','','','','','2019-04-04',0,'\0'),(2,0,1,NULL,'system','system','system','5787039480429368bf94732aacc771cd0a3ea02bcf504ffe1185ab94213bc63a','demomfi@mifos.org','\0','','','','','2014-03-07',0,'\0');
/*!40000 ALTER TABLE `m_appuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser_previous_password`
--

DROP TABLE IF EXISTS `m_appuser_previous_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser_previous_password` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `removal_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `m_appuser_previous_password_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser_previous_password`
--

LOCK TABLES `m_appuser_previous_password` WRITE;
/*!40000 ALTER TABLE `m_appuser_previous_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_appuser_previous_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser_role`
--

DROP TABLE IF EXISTS `m_appuser_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser_role` (
  `appuser_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`appuser_id`,`role_id`),
  KEY `FK7662CE59B4100309` (`appuser_id`),
  KEY `FK7662CE5915CEC7AB` (`role_id`),
  CONSTRAINT `FK7662CE5915CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`),
  CONSTRAINT `FK7662CE59B4100309` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser_role`
--

LOCK TABLES `m_appuser_role` WRITE;
/*!40000 ALTER TABLE `m_appuser_role` DISABLE KEYS */;
INSERT INTO `m_appuser_role` VALUES (1,1);
/*!40000 ALTER TABLE `m_appuser_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_calendar`
--

DROP TABLE IF EXISTS `m_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_calendar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration` smallint(6) DEFAULT NULL,
  `calendar_type_enum` smallint(5) NOT NULL,
  `repeating` tinyint(1) NOT NULL DEFAULT '0',
  `recurrence` varchar(100) DEFAULT NULL,
  `remind_by_enum` smallint(5) DEFAULT NULL,
  `first_reminder` smallint(11) DEFAULT NULL,
  `second_reminder` smallint(11) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `meeting_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_calendar`
--

LOCK TABLES `m_calendar` WRITE;
/*!40000 ALTER TABLE `m_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_calendar_history`
--

DROP TABLE IF EXISTS `m_calendar_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_calendar_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `title` varchar(70) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration` smallint(6) DEFAULT NULL,
  `calendar_type_enum` smallint(5) NOT NULL,
  `repeating` tinyint(1) NOT NULL DEFAULT '0',
  `recurrence` varchar(100) DEFAULT NULL,
  `remind_by_enum` smallint(5) DEFAULT NULL,
  `first_reminder` smallint(11) DEFAULT NULL,
  `second_reminder` smallint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_calendar_m_calendar_history` (`calendar_id`),
  CONSTRAINT `FK_m_calendar_m_calendar_history` FOREIGN KEY (`calendar_id`) REFERENCES `m_calendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_calendar_history`
--

LOCK TABLES `m_calendar_history` WRITE;
/*!40000 ALTER TABLE `m_calendar_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_calendar_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_calendar_instance`
--

DROP TABLE IF EXISTS `m_calendar_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_calendar_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `entity_id` bigint(20) NOT NULL,
  `entity_type_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_calendar_m_calendar_instance` (`calendar_id`),
  CONSTRAINT `FK_m_calendar_m_calendar_instance` FOREIGN KEY (`calendar_id`) REFERENCES `m_calendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_calendar_instance`
--

LOCK TABLES `m_calendar_instance` WRITE;
/*!40000 ALTER TABLE `m_calendar_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_calendar_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_cashier_transactions`
--

DROP TABLE IF EXISTS `m_cashier_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_cashier_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cashier_id` bigint(20) NOT NULL,
  `txn_type` smallint(5) NOT NULL,
  `txn_amount` decimal(19,6) NOT NULL,
  `txn_date` date NOT NULL,
  `created_date` datetime NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `txn_note` varchar(200) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IK_m_teller_transactions_m_cashier` (`cashier_id`),
  CONSTRAINT `FK_m_teller_transactions_m_cashiers` FOREIGN KEY (`cashier_id`) REFERENCES `m_cashiers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_cashier_transactions`
--

LOCK TABLES `m_cashier_transactions` WRITE;
/*!40000 ALTER TABLE `m_cashier_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_cashier_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_cashiers`
--

DROP TABLE IF EXISTS `m_cashiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_cashiers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `staff_id` bigint(20) DEFAULT NULL,
  `teller_id` bigint(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` varchar(10) DEFAULT NULL,
  `end_time` varchar(10) DEFAULT NULL,
  `full_day` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IK_m_cashiers_m_staff` (`staff_id`),
  KEY `IK_m_cashiers_m_teller` (`teller_id`),
  CONSTRAINT `FK_m_cashiers_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_m_cashiers_m_teller` FOREIGN KEY (`teller_id`) REFERENCES `m_tellers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_cashiers`
--

LOCK TABLES `m_cashiers` WRITE;
/*!40000 ALTER TABLE `m_cashiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_cashiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_charge`
--

DROP TABLE IF EXISTS `m_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `charge_applies_to_enum` smallint(5) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `charge_payment_mode_enum` smallint(5) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `fee_on_day` smallint(5) DEFAULT NULL,
  `fee_interval` smallint(5) DEFAULT NULL,
  `fee_on_month` smallint(5) DEFAULT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `min_cap` decimal(19,6) DEFAULT NULL,
  `max_cap` decimal(19,6) DEFAULT NULL,
  `fee_frequency` smallint(5) DEFAULT NULL,
  `income_or_liability_account_id` bigint(20) DEFAULT NULL,
  `tax_group_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_m_charge_acc_gl_account` (`income_or_liability_account_id`),
  KEY `FK_m_charge_m_tax_group` (`tax_group_id`),
  CONSTRAINT `FK_m_charge_acc_gl_account` FOREIGN KEY (`income_or_liability_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_m_charge_m_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_charge`
--

LOCK TABLES `m_charge` WRITE;
/*!40000 ALTER TABLE `m_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client`
--

DROP TABLE IF EXISTS `m_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '300',
  `sub_status` int(11) DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `office_joining_date` date DEFAULT NULL,
  `office_id` bigint(20) NOT NULL,
  `transfer_to_office_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  `mobile_no` varchar(50) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL DEFAULT '0',
  `gender_cv_id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `closure_reason_cv_id` int(11) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_on` date DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `default_savings_product` bigint(20) DEFAULT NULL,
  `default_savings_account` bigint(20) DEFAULT NULL,
  `client_type_cv_id` int(11) DEFAULT NULL,
  `client_classification_cv_id` int(11) DEFAULT NULL,
  `reject_reason_cv_id` int(11) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdraw_reason_cv_id` int(11) DEFAULT NULL,
  `withdrawn_on_date` date DEFAULT NULL,
  `withdraw_on_userid` bigint(20) DEFAULT NULL,
  `reactivated_on_date` date DEFAULT NULL,
  `reactivated_on_userid` bigint(20) DEFAULT NULL,
  `legal_form_enum` int(5) DEFAULT NULL,
  `reopened_on_date` date DEFAULT NULL,
  `reopened_by_userid` bigint(20) DEFAULT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  `proposed_transfer_date` date DEFAULT NULL,
  `number_plate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `external_id` (`external_id`),
  UNIQUE KEY `mobile_no_UNIQUE` (`mobile_no`),
  KEY `FKCE00CAB3E0DD567A` (`office_id`),
  KEY `FK_m_client_m_image` (`image_id`),
  KEY `client_staff_id` (`staff_id`),
  KEY `FK_m_client_m_code` (`closure_reason_cv_id`),
  KEY `FK_m_client_m_office` (`transfer_to_office_id`),
  KEY `FK_m_client_m_savings_product` (`default_savings_product`),
  KEY `FK_m_client_m_savings_account` (`default_savings_account`),
  KEY `FK_m_client_type_m_code_value` (`client_type_cv_id`),
  KEY `FK_m_client_classification_m_code_value` (`client_classification_cv_id`),
  KEY `FK1_m_client_gender_m_code_value` (`gender_cv_id`),
  KEY `FK_m_client_substatus_m_code_value` (`sub_status`),
  KEY `FK_m_client_type_mcode_value_reject` (`reject_reason_cv_id`),
  KEY `FK_m_client_type_m_code_value_withdraw` (`withdraw_reason_cv_id`),
  CONSTRAINT `FK1_m_client_gender_m_code_value` FOREIGN KEY (`gender_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FKCE00CAB3E0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_client_classification_m_code_value` FOREIGN KEY (`client_classification_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_m_code` FOREIGN KEY (`closure_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_m_image` FOREIGN KEY (`image_id`) REFERENCES `m_image` (`id`),
  CONSTRAINT `FK_m_client_m_office` FOREIGN KEY (`transfer_to_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_client_m_savings_product` FOREIGN KEY (`default_savings_product`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FK_m_client_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_m_client_substatus_m_code_value` FOREIGN KEY (`sub_status`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_type_mcode_value_reject` FOREIGN KEY (`reject_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_type_m_code_value` FOREIGN KEY (`client_type_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_type_m_code_value_withdraw` FOREIGN KEY (`withdraw_reason_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client`
--

LOCK TABLES `m_client` WRITE;
/*!40000 ALTER TABLE `m_client` DISABLE KEYS */;
INSERT INTO `m_client` VALUES (1,'000000001',NULL,300,NULL,'2019-04-04','2019-04-04',1,NULL,NULL,'Test',NULL,'Test',NULL,'Test Test',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-04',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2,'000000002',NULL,300,NULL,'2019-04-04','2019-04-04',1,NULL,NULL,'Clifford',NULL,'Masi',NULL,'Clifford Masi',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-04',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(14,'MBA00042',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'SAMUEL MATHEKA','','',NULL,'SAMUEL MATHEKA','254706858392',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH029X'),(15,'MBA00043',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PAUL KIMANI','','',NULL,'PAUL KIMANI','254797365227',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH011X'),(16,'MBA00044',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'MISHACK KIOKO','','MUTUKU',NULL,'MISHACK KIOKO MUTUKU','254742353437',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG990J'),(17,'MBA00046',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'JOHNSON MWANGI','','',NULL,'JOHNSON MWANGI','254727207077',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH883Z'),(18,'MBA00047',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'HUMPREY ODIMA','','',NULL,'HUMPREY ODIMA','254708807388',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH888Z'),(19,'MBA00049',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'AMOS KIANO','','',NULL,'AMOS KIANO','254704455282',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH018X'),(20,'MBA00050',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'RAPHAEL KINGORI','','',NULL,'RAPHAEL KINGORI','254722630854',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH472S'),(21,'MBA00051',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'MOSES','','KINYUA',NULL,'MOSES KINYUA','254710929664',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH494N'),(22,'MBA00052',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'GABRIEL GAKULA','','',NULL,'GABRIEL GAKULA','254723345489',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH490H'),(23,'MBA00053',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'DEKEN MUGENDI PETER','','',NULL,'DEKEN MUGENDI PETER','254797651424',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH491N'),(24,'MBA00054',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'LINA LILIAN WANJIRU','','',NULL,'LINA LILIAN WANJIRU','254717852750',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH009T'),(25,'MBA00055',NULL,300,NULL,'2017-01-02','2017-01-01',2,NULL,NULL,'BENARD KIPRUTO','','',NULL,'BENARD KIPRUTO','254717152589',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH006V'),(26,'MBA00056',NULL,300,NULL,'2017-01-02','2017-01-01',45,NULL,NULL,'GEOFREY LESAILO MSHIGHATI','','',NULL,'GEOFREY LESAILO MSHIGHATI','254724915150',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ886A'),(27,'MBA00057',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'BENEDICT ODHIAMBO','','',NULL,'BENEDICT ODHIAMBO','254792153611',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ683A'),(28,'MBA00062',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'FLORENCE MOKIERA ACHOCHI','','',NULL,'FLORENCE MOKIERA ACHOCHI','254702049151',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ480M'),(29,'MBA00064',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'RICHARD RIYIES WITRAI','','',NULL,'RICHARD RIYIES WITRAI','254792036333',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ491M'),(30,'MBA00066',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'BENSON KHAMALISHI ALISWA','','',NULL,'BENSON KHAMALISHI ALISWA','254712649837',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 908Q'),(31,'MBA00067',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'SIMON MASILA MUNGUTI','','',NULL,'SIMON MASILA MUNGUTI','254714252896',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ851Q'),(32,'MBA00068',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'KANTAMPE MARASWA NASIEKU','','',NULL,'KANTAMPE MARASWA NASIEKU','254725614963',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ857Q'),(33,'MBA00069',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'GEOFREY MAINA KAMAU','','',NULL,'GEOFREY MAINA KAMAU','254710257428',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 104X'),(34,'MBA00070',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PETER KIMANI MUTHONI','','',NULL,'PETER KIMANI MUTHONI','254710157864',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH934M'),(35,'MBA00071',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'VINCENT OMWENGA MAKWORO','','',NULL,'VINCENT OMWENGA MAKWORO','254728369952',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ946Q'),(36,'MBA00073',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'KETIKAI OLE TOBIKO','','',NULL,'KETIKAI OLE TOBIKO','254728011029',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ908Q'),(37,'MBA00074',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'KIMPITIE ENE SIMINTIE','','',NULL,'KIMPITIE ENE SIMINTIE','254796811230',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ149Q'),(38,'MBA00075',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PARSOKONTE OLE KIJUKO','','',NULL,'PARSOKONTE OLE KIJUKO','254701747919',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ852Q'),(39,'MBA00076',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'TAIRUS OKELLO KIBISU','','',NULL,'TAIRUS OKELLO KIBISU','254725575906',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ848Q'),(40,'MBA00077',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PARKIRE MURE ROTLIRO','','',NULL,'PARKIRE MURE ROTLIRO','254717064132',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ866Q'),(41,'MBA00078',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'SAMUEL NJOGO WAMBUI','','',NULL,'SAMUEL NJOGO WAMBUI','254743830897',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH535U'),(42,'MBA00082',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MOSES','MAKENZI','BULIMO',NULL,'MOSES MAKENZI BULIMO','254704359910',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ024N'),(43,'MBA00085',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JOHN NJOROGE MUIGAI','','',NULL,'JOHN NJOROGE MUIGAI','254723493463',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 450X'),(44,'MBA00087',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'JOSEPH PARIT KARINO','','',NULL,'JOSEPH PARIT KARINO','254728914529',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ471X'),(45,'MBA00088',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'*JOHN TANANGO','','',NULL,'*JOHN TANANGO','254712797567',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ495X'),(46,'MBA00009',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'KEN MUNYWA NGANDU','','',NULL,'KEN MUNYWA NGANDU','254703721140',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(47,'MBA00090',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'NDAMBUKI SAMMY MLEVE','','',NULL,'NDAMBUKI SAMMY MLEVE','254726309971',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ500X'),(48,'MBA00091',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'ARON MUSYOKA','','',NULL,'ARON MUSYOKA','254720654565',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH267P'),(49,'MBA00014',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'ISAIAH KIMATHI','','',NULL,'ISAIAH KIMATHI','254705317631',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(50,'MBA00022',NULL,300,NULL,'2017-01-02','2017-01-01',39,NULL,NULL,'BRENDER INYOLO CHITILA','','',NULL,'BRENDER INYOLO CHITILA','254707651420',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG335M'),(51,'MBA00023',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'JOSHUA MULLELU KILONZO','','',NULL,'JOSHUA MULLELU KILONZO','254719276755',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMDZ371M'),(52,'MBA00079',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'TERER ALFRED','','',NULL,'TERER ALFRED','254724656086',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ142D'),(53,'MBA00080',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WESLEY BETT KIPNGENO','','',NULL,'WESLEY BETT KIPNGENO','254795825674',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ128C'),(54,'MBA00084',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'IBRAHIM KANE MUIRURI','','',NULL,'IBRAHIM KANE MUIRURI','254721972093',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ477X'),(55,'MBA00086',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'ATETI OLE PARTARI','','',NULL,'ATETI OLE PARTARI','254713696021',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ467X'),(56,'MBA00016',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'BETH NJOROGE','','',NULL,'BETH NJOROGE','254713918999',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(57,'MBA00017',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'MUTHETHIA PHINEAS','','',NULL,'MUTHETHIA PHINEAS','254706157001',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(58,'MBA00018',NULL,300,NULL,'2017-01-02','2017-01-01',25,NULL,NULL,'HENRY MWONGELA MBURARIA','','',NULL,'HENRY MWONGELA MBURARIA','254703985410',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(59,'MBA00019',NULL,300,NULL,'2017-01-02','2017-01-01',32,NULL,NULL,'EDWIN GAKUYA NJUNJI','','',NULL,'EDWIN GAKUYA NJUNJI','254791082475',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(60,'MBA00092',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'OBADIA NYAMBANE','','',NULL,'OBADIA NYAMBANE','254723552919',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ442X'),(61,'MBA00093',NULL,300,NULL,'2017-01-02','2017-01-01',18,NULL,NULL,'REUBEN NGUYO','','',NULL,'REUBEN NGUYO','254702633393',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK680E'),(62,'MBA00094',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PETER KINUTHIA','','',NULL,'PETER KINUTHIA','254798797388',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK077E'),(63,'MBA00095',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'DAVID KAZUNGU CHARO','','',NULL,'DAVID KAZUNGU CHARO','254712484610',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ427K'),(64,'MBA00096',NULL,300,NULL,'2017-01-02','2017-01-01',2,NULL,NULL,'JOSHUA CHEMUTAI','','',NULL,'JOSHUA CHEMUTAI','254723287937',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK082B'),(65,'MBA00097',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'PAUL GICHERU MWANGI','','',NULL,'PAUL GICHERU MWANGI','254712549424',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK083B'),(66,'MBA00099',NULL,300,NULL,'2017-01-02','2017-01-01',18,NULL,NULL,'HENRY SILVANO','','',NULL,'HENRY SILVANO','254713957189',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK265C'),(67,'MBA00100',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'FANCY CHEPKEMOI','','',NULL,'FANCY CHEPKEMOI','254726662472',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK151C'),(68,'MBA00101',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'AMOS KIBET MUTAI','','',NULL,'AMOS KIBET MUTAI','254727139365',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ350T'),(69,'MBA00102',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'CHRISTOPHER RONO','','',NULL,'CHRISTOPHER RONO','254701517198',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 143U'),(70,'MBA00103',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'STANLEY MUTAI','','',NULL,'STANLEY MUTAI','254701496917',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ261R'),(71,'MBA00104',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'FRANCIS OTIENO','','',NULL,'FRANCIS OTIENO','254700422619',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK594H'),(72,'MBA00105',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'PETER MUTUKU KIOKO','','',NULL,'PETER MUTUKU KIOKO','254717281146',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 839X'),(73,'MBA00106',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'BEN ONYANGO NUNDU','','',NULL,'BEN ONYANGO NUNDU','254705773675',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK102C'),(74,'MBA00107',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'JACKSON ODHIAMBO OYOO','','',NULL,'JACKSON ODHIAMBO OYOO','254799785729',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK378C'),(75,'MBA00108',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'CATHERINE MWIKALI','','KIILU',NULL,'CATHERINE MWIKALI KIILU','254704334649',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 801X'),(76,'MBA00109',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'GABRIEL OWINO ABIERO','','',NULL,'GABRIEL OWINO ABIERO','254710278800',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK643R'),(77,'MBA00110',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'MARK ERNG','','',NULL,'MARK ERNG','254719495934',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK097E'),(78,'MBA00112',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'GODFREY NYONGESA ODERO','','',NULL,'GODFREY NYONGESA ODERO','254715808412',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK720T'),(79,'MBA00113',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'WAMBUA KIMUNZU','','',NULL,'WAMBUA KIMUNZU','254724888149',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK838T'),(80,'MBA00114',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'OLETETIA OLE NENA','','',NULL,'OLETETIA OLE NENA','254703894926',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK967T'),(81,'MBA00115',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'KOONE OLE PARMUAT','','',NULL,'KOONE OLE PARMUAT','254796272528',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK981T'),(82,'MBA00116',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DAVID OSODO DULO','','',NULL,'DAVID OSODO DULO','254702196485',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG655Z'),(83,'MBA00119',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'ERICK OCHIENG OCHIENG','','',NULL,'ERICK OCHIENG OCHIENG','254710582925',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK408D'),(84,'MBA00120',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JOHNSTONE OBUNAKA MAZEMBE','','',NULL,'JOHNSTONE OBUNAKA MAZEMBE','254727434359',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK 756L'),(85,'MBA00121',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'PAUL OTIENO OTINGO','','',NULL,'PAUL OTIENO OTINGO','254799975622',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ062W'),(86,'MBA00122',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'DANSON MUTUATHA','','',NULL,'DANSON MUTUATHA','254714049310',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK900S'),(87,'MBA00123',NULL,300,NULL,'2017-01-02','2017-01-01',11,NULL,NULL,'MERCY PATRICIA','','ALOO',NULL,'MERCY PATRICIA ALOO','254718241286',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK054P'),(88,'MBA00124',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'BENARD OUMA ONDEGO','','',NULL,'BENARD OUMA ONDEGO','254708743261',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK940J'),(89,'MBA00125',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'EPHANTUS MWANGI','','',NULL,'EPHANTUS MWANGI','254706743059',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK987T'),(90,'MBA00126',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'OTUMA OLE MERIA','','',NULL,'OTUMA OLE MERIA','254727157501',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK704W'),(91,'MBA00127',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'MARTIN MUTHAURA KAUMBUTHU','','',NULL,'MARTIN MUTHAURA KAUMBUTHU','254727421305',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK779W'),(92,'MBA00128',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JOSPHAT SOKOBE NYAMBENE','','',NULL,'JOSPHAT SOKOBE NYAMBENE','254713453887',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK339P'),(93,'MBA00129',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JOSEPH OYAMO CHANJI','','',NULL,'JOSEPH OYAMO CHANJI','254727799665',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEF 767K'),(94,'MBA00130',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'SAFARI KARISA','','',NULL,'SAFARI KARISA','254710435171',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK167N'),(95,'MBA00133',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'MEMUSI KINDI PETER','','',NULL,'MEMUSI KINDI PETER','254724478604',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG539M'),(96,'MBA00142',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'SYLUS KIPLAGAT KIPKWE','','',NULL,'SYLUS KIPLAGAT KIPKWE','254726621179',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ143U'),(97,'MBA00143',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DONALD ODINGA ONDONDO','','',NULL,'DONALD ODINGA ONDONDO','254799953029',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK665Z'),(98,'MBA00144',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'DOUGLAS MOTURI NYABUTI','','',NULL,'DOUGLAS MOTURI NYABUTI','254715370859',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ107W'),(99,'MBA00145',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'EDWIN OCHIENG OPANY','','',NULL,'EDWIN OCHIENG OPANY','254720268663',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ060W'),(100,'MBA00146',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'SAMSON OROKO OICHOE','','',NULL,'SAMSON OROKO OICHOE','0719582521',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ061W'),(101,'MBA00147',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'MUNKE OLE','','SAITOTI',NULL,'MUNKE OLE SAITOTI','254727849205',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK741W'),(102,'MBA00148',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'RICHARD ONSERIO ','','',NULL,'RICHARD ONSERIO ','0723572545',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ108W'),(103,'MBA00149',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'CALEB ODHIAMBO','','',NULL,'CALEB ODHIAMBO','0704285322',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK823L'),(104,'MBA00150',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'ONESMUS MWATUA','','MKUNA',NULL,'ONESMUS MWATUA MKUNA','254717064623',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ337E'),(105,'MBA00151',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'EDWARD RONO','','',NULL,'EDWARD RONO','0701002347',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK 125U'),(106,'MBA00152',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'AUGUSTUS CHARO','','',NULL,'AUGUSTUS CHARO','0706311224',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ598X'),(107,'MBA00153',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'JANEPHER MORAA ONDIEKI','','',NULL,'JANEPHER MORAA ONDIEKI','0728384357',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK890U'),(108,'MBA00154',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'WALTER MUONI ODINYA','','',NULL,'WALTER MUONI ODINYA','0715119537',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK 628K'),(109,'MBA00155',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'OMAR WAYU AWADHI','','',NULL,'OMAR WAYU AWADHI','0716620464',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ932W'),(110,'MBA00156',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'BILLY HUMPREY OUMA','','',NULL,'BILLY HUMPREY OUMA','0705344039',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL980E'),(111,'MBA00157',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KELVIN OLANG\'O','','ONYANGO',NULL,'KELVIN OLANG\'O ONYANGO','254701337528',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL987D'),(112,'MBA00159',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'RONALD JUMA WANYONYI','','',NULL,'RONALD JUMA WANYONYI','0728720353',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK816T'),(113,'MBA00161',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'MILDRED NASAMBU','','SOITA',NULL,'MILDRED NASAMBU SOITA','254707673961',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK705L'),(114,'MBA00162',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MAURICE ALOO','','ONYANGO',NULL,'MAURICE ALOO ONYANGO','254704657651',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMK948J'),(115,'MBA00163',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'DOUGLAS CHEU','','ZIRO',NULL,'DOUGLAS CHEU ZIRO','254706425134',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK435Y'),(116,'MBA00165',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'SYLVESTER ODHIAMBO OMOLLO','','',NULL,'SYLVESTER ODHIAMBO OMOLLO','0743661410',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK245J'),(117,'MBA00166',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'MUNIRI','','ABDALA',NULL,'MUNIRI ABDALA','254717589556',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ864M'),(118,'MBA00167',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'MARGARET CHEROTICH LABOSO','','',NULL,'MARGARET CHEROTICH LABOSO','0700138198',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(119,'MBA00168',NULL,300,NULL,'2017-01-02','2017-01-01',13,NULL,NULL,'BENSON','NYINGE','TSUMA',NULL,'BENSON NYINGE TSUMA','0700315207',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK908T'),(120,'MBA00169',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'LAWRENCE OTIENO','','OTIENO',NULL,'LAWRENCE OTIENO OTIENO','254725296660',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK736L'),(121,'MBA00171',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'WILFRED ACHUTI','','',NULL,'WILFRED ACHUTI','0714043916',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK424D'),(122,'MBA00172',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'IKAAL LOMOKWAN','','',NULL,'IKAAL LOMOKWAN','0701104052',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK485T'),(123,'MBA00173',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DOMINIC OCHIENG','','KUIRE',NULL,'DOMINIC OCHIENG KUIRE','254728169459',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL665G'),(124,'MBA00174',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'LEONARD AMOTH','','OCHIENG',NULL,'LEONARD AMOTH OCHIENG','254705770522',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK453Y'),(125,'MBA00175',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DANIEL OSIR','','OTIENO',NULL,'DANIEL OSIR OTIENO','254790812425',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL697G'),(126,'MBA00176',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'EVANS MICHAEL','','OUMA',NULL,'EVANS MICHAEL OUMA','254742521187',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL975D'),(127,'MBA00177',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'HEBERT KAKAI','','',NULL,'HEBERT KAKAI','0713298092',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK697W'),(128,'MBA00178',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'VICTOR ONYANGO OGUTU','','',NULL,'VICTOR ONYANGO OGUTU','0741392766',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMED813P'),(129,'MBA00180',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'DAN MILLER MBOYA','','',NULL,'DAN MILLER MBOYA','0718447882',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK941Y'),(130,'MBA00181',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JAMES ODONGO OPIYO','','',NULL,'JAMES ODONGO OPIYO','0727217204',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL713G'),(131,'MBA00182',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'HENRY','ODHIABO','OMONDI',NULL,'HENRY ODHIABO OMONDI','254727612747',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL676G'),(132,'MBA00185',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'JOHN MABETA','','',NULL,'JOHN MABETA','0721692149',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK889R'),(133,'MBA00186',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WELDON KIBET KIRUI','','',NULL,'WELDON KIBET KIRUI','0716159560',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK503Y'),(134,'MBA00189',NULL,300,NULL,'2017-01-02','2017-01-01',28,NULL,NULL,'MOSES KIPCHIRCHIR BIWOT','','',NULL,'MOSES KIPCHIRCHIR BIWOT','0728461257',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK 144U'),(135,'MBA00190',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'EVANS WANYAMA','','WANDAKI',NULL,'EVANS WANYAMA WANDAKI','254720835025',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KME274E'),(136,'MBA00191',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'ALFERD','NYASOKO','OMBATI',NULL,'ALFERD NYASOKO OMBATI','254725544557',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK421D'),(137,'MBA00192',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PETER NJOROGE MUIGAI','','',NULL,'PETER NJOROGE MUIGAI','0714767719',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL573G'),(138,'MBA00193',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'GLADYS BRUTSU','','MOMANYI',NULL,'GLADYS BRUTSU MOMANYI','254728497620',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ084W'),(139,'MBA00195',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'PATRICK KIPKEMBOI','','',NULL,'PATRICK KIPKEMBOI','0705725168',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL373B'),(140,'MBA00197',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'LUGU RABUA','','SAMUEL',NULL,'LUGU RABUA SAMUEL','254719462243',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL239B'),(141,'MBA00198',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'MOHAMED HIRIBAE','','SALIM',NULL,'MOHAMED HIRIBAE SALIM','254711108211',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 182B'),(142,'MBA00199',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'EMMANUEL MRIANA','','NYAKUNDI',NULL,'EMMANUEL MRIANA NYAKUNDI','254714674970',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEA 649L'),(143,'MBA00200',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'EBEI','','KAMURAGE',NULL,'EBEI KAMURAGE','254728263480',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 676M'),(144,'MBA00201',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'WILFRED ONYANGO JUMA','','',NULL,'WILFRED ONYANGO JUMA','0705440609',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK957Y'),(145,'MBA00202',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'CHRISTOPHER KIHOZI MAGOMERE','','',NULL,'CHRISTOPHER KIHOZI MAGOMERE','0721239900',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG683Z'),(146,'MBA00203',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ABRAHAM KEMEI','','',NULL,'ABRAHAM KEMEI','0729039194',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEF537P'),(148,'MBA00205',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'DAVIES GICHANE','','NJOROGE',NULL,'DAVIES GICHANE NJOROGE','254714354041',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK589T'),(149,'MBA00206',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'GREGORY OTIENO','','MBA00206',NULL,'GREGORY OTIENO MBA00206','254711844789',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL314E'),(150,'MBA00207',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ALICE  CHEPNGETICH','','LUKWOP',NULL,'ALICE  CHEPNGETICH LUKWOP','254728750589',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL377B'),(151,'MBA00208',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'CHEPNGETICH WINNY','','',NULL,'CHEPNGETICH WINNY','0708051377',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL307A'),(152,'MBA00209',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'PAUL KIBET','','RONO',NULL,'PAUL KIBET RONO','254702447343',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK370L'),(153,'MBA00210',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'SALINA AKIRU ITAKIEKEI','','',NULL,'SALINA AKIRU ITAKIEKEI','0716766878',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK584T'),(154,'MBA00211',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'JAMES OJWANG','','',NULL,'JAMES OJWANG','0716875788',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ857H'),(155,'MBA00212',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'KEVIN OCHIENG ANYONA','','',NULL,'KEVIN OCHIENG ANYONA','0797858097',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ854J'),(156,'MBA00213',NULL,300,NULL,'2017-01-02','2017-01-01',37,NULL,NULL,'ERICK NDOLO','','NZIOKI',NULL,'ERICK NDOLO NZIOKI','254704212790',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'LF3PCK704JB005460'),(157,'MBA00214',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,' PURITY WAYUA/JAMES MUTISYA KINGOO','','',NULL,' PURITY WAYUA/JAMES MUTISYA KINGOO','0712647793',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG826V'),(158,'MBA00215',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'ESAU','','KASITOLA',NULL,'ESAU KASITOLA','254714251625',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEA499B'),(159,'MBA00216',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'ZACHARIA MUSYIMI NZOKA','','',NULL,'ZACHARIA MUSYIMI NZOKA','0707647170',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 456M'),(160,'MBA00217',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'JOHN KILONZO KIVINDYO','','',NULL,'JOHN KILONZO KIVINDYO','0708053097',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'LF3PCK703JB005420'),(161,'MBA00218',NULL,300,NULL,'2017-01-02','2017-01-01',37,NULL,NULL,'BENARD MUKONZO ','','',NULL,'BENARD MUKONZO ','0703451294',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL817A'),(162,'MBA00220',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'DOMINIC BOSIRE','','MOKUA',NULL,'DOMINIC BOSIRE MOKUA','254790094934',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK112T'),(163,'MBA00222',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'NYABICHA SAMUEL MOGAKA 2','','',NULL,'NYABICHA SAMUEL MOGAKA 2','0719395016',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK 123T'),(164,'MBA00223',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'JOHN MAIKO OMIKO','','',NULL,'JOHN MAIKO OMIKO','0719303673',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ 565X'),(165,'MBA00224',NULL,300,NULL,'2017-01-02','2017-01-01',46,NULL,NULL,'MARTIN MWIATHI','','MBUBA',NULL,'MARTIN MWIATHI MBUBA','254705168952',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK499R'),(166,'MBA00226',NULL,300,NULL,'2017-01-02','2017-01-01',8,NULL,NULL,'MOPEL OLE','','SHAPARA',NULL,'MOPEL OLE SHAPARA','254701699985',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL625G'),(167,'MBA00227',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'EIBACH','','ARUOTO',NULL,'EIBACH ARUOTO','254713928541',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL434P'),(168,'MBA00228',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'ANGELINE ERENG','','',NULL,'ANGELINE ERENG','0723710652',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL575R'),(169,'MBA00229',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'EWESIT MANANGIT','','',NULL,'EWESIT MANANGIT','0741671597',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL772D'),(170,'MBA00230',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'NANGIRO EBEI','','',NULL,'NANGIRO EBEI','0728816603',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL937P'),(171,'MBA00231',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'JAMES MBOGO','','',NULL,'JAMES MBOGO','0723819517',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL153F'),(172,'MBA00232',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'JULIUS RIOBA MAROA','','',NULL,'JULIUS RIOBA MAROA','0740867212',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL804L'),(173,'MBA00233',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'MWITA MAURICE','','HOURA',NULL,'MWITA MAURICE HOURA','254740305407',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL659D'),(174,'MBA00235',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'RAPHAEL KWAHU CHACHA','','',NULL,'RAPHAEL KWAHU CHACHA','0705132277',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL806L'),(175,'MBA00236',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'ZACHARIA MARENGO MAROA','','',NULL,'ZACHARIA MARENGO MAROA','0701805201',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL494R'),(176,'MBA00237',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'PHERIS MAROA','','',NULL,'PHERIS MAROA','0710872669',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL807L'),(177,'MBA00238',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'NYAHIRI JOSAYA','','MWITA',NULL,'NYAHIRI JOSAYA MWITA','254720127132',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL802L'),(178,'MBA00239',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'JOSEPH ROBI MWITA','','',NULL,'JOSEPH ROBI MWITA','0712473780',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL809L'),(179,'MBA00240',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'DAVID NCHAMA','','SENSO',NULL,'DAVID NCHAMA SENSO','254728364475',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL813L'),(180,'MBA00241',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'FADHILI','SAID','BADHI',NULL,'FADHILI SAID BADHI','254724065601',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK815R'),(181,'MBA00242',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'WYCLIFE WAFULA MASINDANO','','',NULL,'WYCLIFE WAFULA MASINDANO','0707754606',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL413P'),(182,'MBA00243',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MATIA VUZIGU LUMIRE','','',NULL,'MATIA VUZIGU LUMIRE','0723626001',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL817L'),(183,'MBA00246',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ABRAHAM OTIBO WAFULA','','',NULL,'ABRAHAM OTIBO WAFULA','0799101130',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL117D'),(184,'MBA00247',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'JAVAN OCHIENG OCHECHE','','',NULL,'JAVAN OCHIENG OCHECHE','0715129689',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL666G'),(185,'CMT00001',NULL,300,NULL,'2017-01-02','2017-01-01',37,NULL,NULL,'DORCAS MWIKALI KITETA','','',NULL,'DORCAS MWIKALI KITETA','0723708856',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(186,'MRNA0001',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MICHAEL OTIENO','','OJWANG',NULL,'MICHAEL OTIENO OJWANG','254715434969',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(187,'MBAK00141',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KALOLENI  A','','',NULL,'KALOLENI  A','0703481856',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,''),(188,'MBBK00141',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KALOLENI B','','TYRUS NDEGE',NULL,'KALOLENI B TYRUS NDEGE','0703481857',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK622M'),(189,'MBA00098',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'JOSEPH WAWERU','','',NULL,'JOSEPH WAWERU','0702354297',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ104S'),(190,'MBA00060',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'MOSES NEKINI','','TINGISHA',NULL,'MOSES NEKINI TINGISHA','254723205516',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ433M'),(191,'MBA00225',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'FESTUS','OBUYA','OWUOR',NULL,'FESTUS OBUYA OWUOR','254722576096',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK023R'),(192,'MBA00111',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ZACCHAEUS OKOTH MUGA','','',NULL,'ZACCHAEUS OKOTH MUGA','0725828582',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK211H'),(193,'MBA00249',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'IKA','OLE','LEPOSO',NULL,'IKA OLE LEPOSO','254729547505',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL656A'),(194,'MBA00250',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'NICHOLAS','','NJERI',NULL,'NICHOLAS NJERI','254729807852',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL909G'),(195,'MBA00251',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'LEGOYIA KETUI','','LOLURAPI',NULL,'LEGOYIA KETUI LOLURAPI','254727881344',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL683G'),(196,'MBA00252',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'JOSEPH ONGAGA NYAKUNDI','','',NULL,'JOSEPH ONGAGA NYAKUNDI','710855660',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL796L'),(197,'MBA00253',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'CAROLYN NAMESO WEKESA','','',NULL,'CAROLYN NAMESO WEKESA','724493516',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL855L'),(198,'MBA00254',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'SPOLINE WAMBUI ','','',NULL,'SPOLINE WAMBUI ','726611155',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL667M'),(199,'MBA00255',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'CATHERINE KWAMBOKA','','',NULL,'CATHERINE KWAMBOKA','704947745',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL636M'),(200,'MBA00256',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'PETER MWANGI KINYUA','','',NULL,'PETER MWANGI KINYUA','728504851',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH125B'),(201,'MBA00257',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'BONIFACE CHERUIYOT','','',NULL,'BONIFACE CHERUIYOT','701359801',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL405R'),(202,'MBA00258',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ISAIAH','KIPROTICH','MUTAI',NULL,'ISAIAH KIPROTICH MUTAI','254725143762',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL283G'),(203,'MBA00259',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'MATHEW KIPLAGAT YEGON','','',NULL,'MATHEW KIPLAGAT YEGON','725754059',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK273R'),(204,'MBA00260',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'NORBAT','','KEMBOI',NULL,'NORBAT KEMBOI','254704474551',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL338C'),(205,'MBA00261',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'EDWARD OTIENO','','OTIENO',NULL,'EDWARD OTIENO OTIENO','254702782401',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL837L'),(206,'MBA00262',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'CHERUIYOT TONUI','','',NULL,'CHERUIYOT TONUI','791947467',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL144R'),(207,'MBA00263',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'SAMUEL CHEGE','','',NULL,'SAMUEL CHEGE','799166919',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL470D'),(208,'MBA00264',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'JOHN KIOIGI MBURU','','',NULL,'JOHN KIOIGI MBURU','717558148',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL408S'),(209,'MBA00265',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'CALEPH KIPKORIR SIELE','','',NULL,'CALEPH KIPKORIR SIELE','726119670',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL426D'),(210,'MBA00266',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'DAVID OTTIENO','','RAWER',NULL,'DAVID OTTIENO RAWER','254714830289',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL574P'),(211,'MBA00267',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'ELIUD KIBET','','LIMO',NULL,'ELIUD KIBET LIMO','254727331217',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL132Y'),(212,'MBA00268',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'WILSON KIMARU','','KOGO',NULL,'WILSON KIMARU KOGO','254791515701',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL836D'),(213,'MBA00269',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JOAKIM NYAMBATI','','',NULL,'JOAKIM NYAMBATI','714015817',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL685G'),(214,'MBA00270',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'COTYLDA WANJALA WEKESA','','',NULL,'COTYLDA WANJALA WEKESA','700407011',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL021B'),(215,'MBA00271',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'DENNIS NYONGESA CHITLA','','',NULL,'DENNIS NYONGESA CHITLA','720478728',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL928R'),(216,'MBA00272',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'SAMUEL OTIENO OMOLLO','','',NULL,'SAMUEL OTIENO OMOLLO','721295813',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL888X'),(217,'MBA00273',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'EDWARD','','OKINYI',NULL,'EDWARD OKINYI','254707471152',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 956X'),(218,'MBA00274',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'TUMAGE NKAMASIA','','',NULL,'TUMAGE NKAMASIA','728497233',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL858L'),(219,'MBA00275',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'BONFACE GITHIGIA NJOGUNA','','',NULL,'BONFACE GITHIGIA NJOGUNA','728997277',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL301Q'),(220,'MBA00276',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'ANTONY NGUGI NDWARU','','NDWARU',NULL,'ANTONY NGUGI NDWARU NDWARU','254726503114',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL382P'),(221,'MBA00277',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'HEZRON','NAMWANDU','KATASI',NULL,'HEZRON NAMWANDU KATASI','254711723344',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL790Z'),(222,'MBA00278',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'TITUS WANYONYI KAIKAI','','',NULL,'TITUS WANYONYI KAIKAI','700516743',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL724F'),(223,'MBA00279',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'KENNEDY BARSA  SIKUKU','','',NULL,'KENNEDY BARSA  SIKUKU','711762619',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL953R'),(224,'MBA00280',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'JONATHAN NGENGO SALIM','','',NULL,'JONATHAN NGENGO SALIM','724448641',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 253U'),(225,'MBA00281',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'MOSES MURANGIRI','','',NULL,'MOSES MURANGIRI','727728623',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMMEL247U'),(226,'MBA00282',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'SILYVESTER','','OCHANDA',NULL,'SILYVESTER OCHANDA','254702848280',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL297U'),(227,'MBA00284',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'TOBIAS','','MASINDE WALUMBE',NULL,'TOBIAS MASINDE WALUMBE','254716872543',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL835S'),(228,'MBA00285',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'BENARD','','OWUOR NYAGOL',NULL,'BENARD OWUOR NYAGOL','254704650340',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL627S'),(229,'MBA00286',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'HEZRON AMOLLO/WELLINGTONE','','',NULL,'HEZRON AMOLLO/WELLINGTONE','712102654',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL569Y'),(230,'MBA00287',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KENNEDY OKETCH OUMA','','',NULL,'KENNEDY OKETCH OUMA','706387679',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL867D'),(231,'MBA00288',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MOSES ODHIAMBO','','ORWA',NULL,'MOSES ODHIAMBO ORWA','254720063099',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL796Z'),(232,'MBA00289',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JACK OTIENO AKUNGO','','',NULL,'JACK OTIENO AKUNGO','726926882',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL630S'),(233,'MBA00290',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'FREDRICK','OTIENO','OYUOYA',NULL,'FREDRICK OTIENO OYUOYA','722875304',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL827D'),(234,'MBA00291',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JACKLINE ADHIAMBO ABONYO','','',NULL,'JACKLINE ADHIAMBO ABONYO','710100735',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL942Z'),(235,'MBA00292',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'SAMUEL OCHIENG ONYANGO','','',NULL,'SAMUEL OCHIENG ONYANGO','718417161',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL661S'),(236,'MBA00293',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'FREDRICK OTIENO ANGANDO','','',NULL,'FREDRICK OTIENO ANGANDO','710307334',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL754N'),(237,'MBA00294',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ELIAKIM ODHIAMBO OLOO','','',NULL,'ELIAKIM ODHIAMBO OLOO','748152138',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL832C'),(238,'MBA00296',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'CHARLES OMONDI RUONG\'O','','',NULL,'CHARLES OMONDI RUONG\'O','725322335',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL824D'),(239,'MBA00297',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'STEPHEN JUMA','','ARODI',NULL,'STEPHEN JUMA ARODI','254717982927',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL152Q'),(240,'MBA00298',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'HENRY ODHIAMBO','','',NULL,'HENRY ODHIAMBO','727612747',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL841L'),(241,'MBA00299',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'PETER EKWON','','',NULL,'PETER EKWON','729302072',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 949L'),(242,'MBA00300',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'AMOS','ONYANGO','OJWANG',NULL,'AMOS ONYANGO OJWANG','254715942368',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL852Z'),(243,'MBA00301',NULL,300,NULL,'2017-01-02','2017-01-01',41,NULL,NULL,'JULIUS OKOTH OUMA','','',NULL,'JULIUS OKOTH OUMA','728522947',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL955U'),(244,'MBA00302',NULL,300,NULL,'2017-01-02','2017-01-01',6,NULL,NULL,'JOSPHAT CHEGE KAMAU','','',NULL,'JOSPHAT CHEGE KAMAU','703393125',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ801U'),(245,'MBA00303',NULL,300,NULL,'2017-01-02','2017-01-01',6,NULL,NULL,'SYLVIA AMOIT','','',NULL,'SYLVIA AMOIT','724765425',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KEL710P'),(246,'MBA00304',NULL,300,NULL,'2017-01-02','2017-01-01',6,NULL,NULL,'SAMSON MUSUNGU MWARO','','',NULL,'SAMSON MUSUNGU MWARO','728074422',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL799G'),(247,'MBA00305',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'GEORGE','OCHIENG','ODUOR',NULL,'GEORGE OCHIENG ODUOR','254700773736',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 449N'),(248,'MBA00306',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ISAAC JUMA MASINDE','','',NULL,'ISAAC JUMA MASINDE','728792579',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL952S'),(250,'MBA00308',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'MOSES ODHIAMBO','','SINOGO',NULL,'MOSES ODHIAMBO SINOGO','254705807021',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM757G'),(251,'MBA00309',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'PETER SIMON OLOO','','',NULL,'PETER SIMON OLOO','706586870',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMM947F'),(252,'MBA00310',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'MILLICENT OGWE','','OUMA',NULL,'MILLICENT OGWE OUMA','254726152485',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL713P'),(253,'MBA00312',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'DOMINIC SIGANA','','DUWA',NULL,'DOMINIC SIGANA DUWA','254721985050',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL709S'),(254,'MBA00313',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'LUCAS OTIENO','','OBIERO',NULL,'LUCAS OTIENO OBIERO','254701498963',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL611S'),(255,'MBA00314',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'DERICK OTIENO','','OOKO',NULL,'DERICK OTIENO OOKO','254725494867',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL965R'),(256,'MBA00315',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MOSES OTIENO','','OMOLLO',NULL,'MOSES OTIENO OMOLLO','254704443255',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM858C'),(257,'MBA00316',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'DORINE ATIENO','','OTIENO',NULL,'DORINE ATIENO OTIENO','254713733983',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM868C'),(258,'MBA00317',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'SYLVESTER OLONGO ONYANGO','','',NULL,'SYLVESTER OLONGO ONYANGO','724811925',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM765G'),(259,'MBA00318',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'CHARLES ONYANGO','','',NULL,'CHARLES ONYANGO','721790436',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL918R'),(260,'MBA00321',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'PETER','ONYANGO','OBALLA',NULL,'PETER ONYANGO OBALLA','254799442391',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL121W'),(261,'MBA00327',NULL,300,NULL,'2017-01-02','2017-01-01',20,NULL,NULL,'NOAH SOITA WANYONYI','','',NULL,'NOAH SOITA WANYONYI','792721944',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL623G'),(262,'MBA00342',NULL,300,NULL,'2017-01-02','2017-01-01',20,NULL,NULL,'ALBERT WANJALA','','',NULL,'ALBERT WANJALA','707698199',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL061B'),(263,'MBA00343',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'AUGUSTINE OMUKOLE PAPA','','',NULL,'AUGUSTINE OMUKOLE PAPA','791931790',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN645J'),(264,'MBA00344',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'HENRY WANYAMA SAISI','','',NULL,'HENRY WANYAMA SAISI','710466408',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM014G'),(265,'MBA00345',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'GIBSON','WESONGA','KHAEMBA',NULL,'GIBSON WESONGA KHAEMBA','254706704209',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL651P'),(266,'MBA00346',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'SIMON KAGURI AIHEA','','',NULL,'SIMON KAGURI AIHEA','795767668',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL954J'),(267,'MBA00347',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'JOAN NASAMBU SIKUKU','','',NULL,'JOAN NASAMBU SIKUKU','727292318',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM707G'),(268,'MBA00348',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'SAMSON KAPELO MUKEYANG','','',NULL,'SAMSON KAPELO MUKEYANG','718064797',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(269,'MBA00349',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'JOHN MOKAYA ONYANGORE','','',NULL,'JOHN MOKAYA ONYANGORE','726800032',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 729E'),(270,'MBA00350',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'AGGREY BARASA WASWA','','',NULL,'AGGREY BARASA WASWA','791526259',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL714J'),(271,'MBA00351',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'DISMAS','WANZALA','NAMBALE',NULL,'DISMAS WANZALA NAMBALE','254725995044',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM912A'),(272,'MBA00352',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'DICK','','KIKULO',NULL,'DICK KIKULO','254700156693',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL665S'),(273,'MBA00353',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'VICTOR KIMUTAI','','',NULL,'VICTOR KIMUTAI','702815357',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL952L'),(274,'MBA00354',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'DOMINIC SIMIYU','','MAKOKHA',NULL,'DOMINIC SIMIYU MAKOKHA','254710199118',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL880R'),(275,'MBA00355',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'SIMON ECHUKULE ERIKA','','',NULL,'SIMON ECHUKULE ERIKA','707829291',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM952F'),(276,'MBA00356',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'AMINA ABUBAKAR ABDULKADIR','','',NULL,'AMINA ABUBAKAR ABDULKADIR','728011735',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL925B'),(277,'MBA00357',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'HALAN','AHMED','ALI',NULL,'HALAN AHMED ALI','254705273082',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ892J'),(278,'MBA00358',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'ZAINAB ABDALA','','',NULL,'ZAINAB ABDALA','795452361',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK884T'),(279,'MBA00359',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'KENNEDY OTIENO OHURU','','',NULL,'KENNEDY OTIENO OHURU','728688007',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL915B'),(280,'MBA00360',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'OTIENO CHARLES OCHIENG','','',NULL,'OTIENO CHARLES OCHIENG','722544502',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM819H'),(281,'MBA00361',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'JAMES KINGORI MBURU','','',NULL,'JAMES KINGORI MBURU','708432739',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 986L'),(282,'MBA00362',NULL,300,NULL,'2017-01-02','2017-01-01',40,NULL,NULL,'JOSEPH MURIUKI GITHAIGA','','',NULL,'JOSEPH MURIUKI GITHAIGA','713822356',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 221T'),(283,'MBA00363',NULL,300,NULL,'2017-01-02','2017-01-01',20,NULL,NULL,'IBRAHIM','WEKESA','WANYAMA',NULL,'IBRAHIM WEKESA WANYAMA','254719322694',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL085B'),(284,'MBA00364',NULL,300,NULL,'2017-01-02','2017-01-01',29,NULL,NULL,'JAMES MENZA KENGA','','',NULL,'JAMES MENZA KENGA','742912638',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMDL070X'),(285,'MBA00365',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'ABDINASIR BISHAR MAALIM','','',NULL,'ABDINASIR BISHAR MAALIM','720013438',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK753T'),(286,'MBA00366',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JOSEPH MAINA GITHAE','','',NULL,'JOSEPH MAINA GITHAE','720872312',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL710Y'),(287,'MBA00367',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'ALVIN MWANGI NDUNGU','','',NULL,'ALVIN MWANGI NDUNGU','724903883',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 857C'),(288,'MBA00368',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'ANTONY NDUNGU KAHINDI','','',NULL,'ANTONY NDUNGU KAHINDI','704843825',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM828C'),(289,'MBA00369',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'ELIJAH LESIRI','','ROKOI',NULL,'ELIJAH LESIRI ROKOI','254798468973',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM734C'),(290,'MBA00370',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'SIMON OBIKI OLE TEEKA','','',NULL,'SIMON OBIKI OLE TEEKA','729731772',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 749C'),(291,'MBA00371',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'PAUL KAMAU  GOKO','','',NULL,'PAUL KAMAU  GOKO','722555331',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 718C'),(292,'MBA00372',NULL,300,NULL,'2017-01-02','2017-01-01',20,NULL,NULL,'JOSHUA LUSWETI','','',NULL,'JOSHUA LUSWETI','742006565',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL034D'),(293,'MBA00373',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'MICHAEL MWANGI KIMANI','','',NULL,'MICHAEL MWANGI KIMANI','714524589',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL336T'),(294,'MBA00374',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'FABIAN SHINAMWOYO','','MUTACHI',NULL,'FABIAN SHINAMWOYO MUTACHI','254763656237',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL399S'),(295,'MBA00375',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'WILLKISTER KHAVAKALI WILERA','','',NULL,'WILLKISTER KHAVAKALI WILERA','721921953',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 094U'),(296,'MBA00376',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'MALACK CHWEYA','','OGERO',NULL,'MALACK CHWEYA OGERO','254721112050',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL087F'),(297,'MBA00377',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'ALBERT OMARI MARUBE','','',NULL,'ALBERT OMARI MARUBE','728755823',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK712H'),(298,'MBA00378',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'COLLINS ODUOR OPIYO','','',NULL,'COLLINS ODUOR OPIYO','725501688',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK891R'),(299,'MBA00379',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'GODFERY','MASIKA','JUMA',NULL,'GODFERY MASIKA JUMA','254719133646',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL687Q'),(300,'MBA00380',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'DANIEL SUNGU','','HARRY',NULL,'DANIEL SUNGU HARRY','254716094590',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM909J'),(301,'MBA00381',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'THOMAS MUSYOKI/','','DOROTHY MUSYOKI',NULL,'THOMAS MUSYOKI/ DOROTHY MUSYOKI','254791039146',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM885D'),(302,'MBA00382',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'MARITIM','','MATHEW',NULL,'MARITIM MATHEW','254714114344',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM146M'),(303,'MBA00383',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'LEONARD K','','NGENO',NULL,'LEONARD K NGENO','254701809247',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM070B'),(304,'MBA00384',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'PETER KIPRONO TOWETT','','',NULL,'PETER KIPRONO TOWETT','716206398',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM213M'),(305,'MBA00385',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WESLEY KIPNGETICH BETT','','',NULL,'WESLEY KIPNGETICH BETT','706344926',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM077B'),(307,'MBA00387',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'DAVID KIPRONO','','NGENO',NULL,'DAVID KIPRONO NGENO','254704782498',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEEL367Q'),(308,'MBA00388',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'LANGAT GEOFREY ','','',NULL,'LANGAT GEOFREY ','715146296',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM347A'),(309,'MBA00389',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'COLLINS KIPKOECH','HELLEN','LANGAT*2',NULL,'COLLINS KIPKOECH HELLEN LANGAT*2','254700809342',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM139M'),(310,'MBA00390',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WESLEY','','LELEI',NULL,'WESLEY LELEI','254727736737',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM086B'),(311,'MBA00391',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KIPYEGON S NGENO','','',NULL,'KIPYEGON S NGENO','716520373',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM073B'),(312,'MBA00392',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JACKSON KIPKOECH SIGEI','','',NULL,'JACKSON KIPKOECH SIGEI','715314032',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL374Q'),(313,'MBA00393',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'MERCY CHEMUTAI RONOH','','',NULL,'MERCY CHEMUTAI RONOH','705084092',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM366A'),(314,'MBA00394',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ERICK KIPKOECH','','CHEPKWONY',NULL,'ERICK KIPKOECH CHEPKWONY','254797595957',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM239M'),(315,'MBA00395',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ROBERT KIPKORIR KOSKEI','','',NULL,'ROBERT KIPKORIR KOSKEI','729165885',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL387T'),(316,'MBA00396',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KIPLUMTAGEI LANGAT','','',NULL,'KIPLUMTAGEI LANGAT','728673807',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM132M'),(317,'MBA00397',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ELVIS NYONGESA','','BARASA',NULL,'ELVIS NYONGESA BARASA','254713162008',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM903K'),(318,'MBA00398',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'PROTUS JOEL ONYANGO','','',NULL,'PROTUS JOEL ONYANGO','706961616',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM206M'),(319,'MBA00399',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'DORCAS WANZA MUTUA','','',NULL,'DORCAS WANZA MUTUA','707464766',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM240N'),(320,'MBA00400',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'SAMUEL MUTUA MUNYAO','','',NULL,'SAMUEL MUTUA MUNYAO','790226140',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG020K'),(321,'MBA00401',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'GEORGE','MUTISO','MWOLOLO',NULL,'GEORGE MUTISO MWOLOLO','254729016352',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 893D'),(322,'MBA00402',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'TITUS NZIOKI MUE','','',NULL,'TITUS NZIOKI MUE','720871440',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM852D'),(323,'MBA00403',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'BONFACE MUTINDA','','',NULL,'BONFACE MUTINDA','706015314',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 836D'),(324,'MBA00404',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ERICK OTIENO','','AMBASA',NULL,'ERICK OTIENO AMBASA','254712355335',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK 408D'),(325,'MBA00405',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'SAADA RAMADHANI MUSA','','',NULL,'SAADA RAMADHANI MUSA','724464466',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 162F'),(326,'MBA00406',NULL,300,NULL,'2017-01-02','2017-01-01',30,NULL,NULL,'BENARD GICHIRA MUTUGI','','',NULL,'BENARD GICHIRA MUTUGI','701291688',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH036F'),(327,'MBA00407',NULL,300,NULL,'2017-01-02','2017-01-01',30,NULL,NULL,'RICHARD KARUOYA MWANGI','','',NULL,'RICHARD KARUOYA MWANGI','706223555',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK945G'),(328,'MBA00408',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ERNEST JUMA','','WERENGAI',NULL,'ERNEST JUMA WERENGAI','254717419180',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM871J'),(329,'MBA00409',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SHEM MAJUNE ELUNGAT','','',NULL,'SHEM MAJUNE ELUNGAT','710954229',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL699Q'),(330,'MBA00410',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'BARASA ZADOCK','','',NULL,'BARASA ZADOCK','725845076',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL575Y'),(331,'MBA00411',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SYLVESTER OTUNDO','','',NULL,'SYLVESTER OTUNDO','795769425',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM783J'),(332,'MBA00412',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SHABAN JUMA MAKOKHA','','',NULL,'SHABAN JUMA MAKOKHA','719597466',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM805J'),(333,'MBA00413',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'LIVINGSTONE WASHIALI','','EMIKOPO',NULL,'LIVINGSTONE WASHIALI EMIKOPO','254717480573',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM923J'),(334,'MBA00414',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'FARIDA','','OSIDE',NULL,'FARIDA OSIDE','254792602211',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM773N'),(335,'MBA00415',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'ADUL MAJID DINGIRI','','',NULL,'ADUL MAJID DINGIRI','720578954',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM994F'),(336,'MBA00416',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'LYDIA WAITHERA','','GITAU',NULL,'LYDIA WAITHERA GITAU','254710959890',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM845H'),(337,'MBA00417',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'ELIUD KIPLAGAT','','NGETICH',NULL,'ELIUD KIPLAGAT NGETICH','254716539235',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM796H'),(338,'MBA00418',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'DIANA NAMANYA','','MATASI',NULL,'DIANA NAMANYA MATASI','254799025296',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM747A'),(339,'MBA00419',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BONIFACE OWINO SHIKUKU','','',NULL,'BONIFACE OWINO SHIKUKU','716348900',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL451K'),(340,'MBA00420',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'VICTOR ODHIAMBO OORO','','',NULL,'VICTOR ODHIAMBO OORO','792102780',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM785J'),(341,'MBA00421',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'ALFRED ONYANGO ODONGO','','',NULL,'ALFRED ONYANGO ODONGO','790136797',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK044E'),(342,'MBA00422',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'SETH ATIENO AJIGO','','',NULL,'SETH ATIENO AJIGO','706233566',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM904E'),(343,'MBA00423',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'GEOFREY MAKAU MASAKU','','',NULL,'GEOFREY MAKAU MASAKU','702970443',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL 467M'),(344,'MBA00424',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'ARSON OTIENO MWAI','','',NULL,'ARSON OTIENO MWAI','706662622',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 882J'),(345,'MBA00425',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'FREDRICK','OTIENO','NONDI',NULL,'FREDRICK OTIENO NONDI','254704251270',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM697G'),(346,'MBA00426',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'ROBI CHURICHI MACHERA','','',NULL,'ROBI CHURICHI MACHERA','718637936',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL949U'),(347,'MBA00427',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'JOHN MAISORI','','',NULL,'JOHN MAISORI','743459576',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM636K'),(348,'MBA00428',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'DANIEL CHACHA','','NYAKIOMA',NULL,'DANIEL CHACHA NYAKIOMA','254717157518',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM585K'),(349,'MBA00429',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'JACKSON CHACHA JAMES','','',NULL,'JACKSON CHACHA JAMES','718100551',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL194D'),(350,'MBA00430',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'AKONGO BENARD OTIENO','','',NULL,'AKONGO BENARD OTIENO','707646068',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM743N'),(351,'MBA00431',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'JOHN MONANKA NYAISUNGA','','',NULL,'JOHN MONANKA NYAISUNGA','746523141',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL620J'),(352,'MBA00432',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'ERICK OMONDI','','MATIKU',NULL,'ERICK OMONDI MATIKU','254798188028',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM556K'),(353,'MBA00433',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'AUGUSTINE NYANOKWE NYANG\'ONDI','','',NULL,'AUGUSTINE NYANOKWE NYANG\'ONDI','711514457',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM571K'),(354,'MBA00434',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'CHARLES MULATTI WAFULA','','',NULL,'CHARLES MULATTI WAFULA','723091925',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM888E'),(355,'MBA00435',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BENSON WANENGELELE KULOBA','','',NULL,'BENSON WANENGELELE KULOBA','714611049',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM734E'),(356,'MBA00436',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'MILDRED ASIGE ODARI/ JACKSON WEKESA','','',NULL,'MILDRED ASIGE ODARI/ JACKSON WEKESA','796422144',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(357,'MBA00437',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'JAFETH SAKWA LUYALI','','',NULL,'JAFETH SAKWA LUYALI','703158730',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM806E'),(358,'MBA00438',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'EDWIN ISAIAH','','WANYAMA',NULL,'EDWIN ISAIAH WANYAMA','254792079972',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL748L'),(359,'MBA00439',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ESTHER NAMAWAYA WANYONYI','','',NULL,'ESTHER NAMAWAYA WANYONYI','704056791',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM4288J'),(360,'MBA00440',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ANNE WANJIKU MWIGAI','','',NULL,'ANNE WANJIKU MWIGAI','725921444',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL685Q'),(361,'MBA00441',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'DAVID WANJALA','','NYONGESA',NULL,'DAVID WANJALA NYONGESA','254719337153',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM797E'),(362,'MBA00442',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'DANIEL WANJALA WANYONYI','','',NULL,'DANIEL WANJALA WANYONYI','725508195',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM490J'),(363,'MBA00443',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'PHILIS ATIENO OTIATO','','',NULL,'PHILIS ATIENO OTIATO','711197250',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL772Q'),(364,'MBA00444',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'JOHN PAPA WANYAMA','','',NULL,'JOHN PAPA WANYAMA','705412690',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM861J'),(365,'MBA00445',NULL,300,NULL,'2017-01-02','2017-01-01',12,NULL,NULL,'ANTONY NJOROGE WANJAGI','','',NULL,'ANTONY NJOROGE WANJAGI','717700930',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM864J'),(366,'MBA00446',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SHADRACK','','ELIMA',NULL,'SHADRACK ELIMA','254700820037',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM765J'),(367,'MBA00447',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'JACKLINE MCHUMA KHAEMBA','','',NULL,'JACKLINE MCHUMA KHAEMBA','701439959',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM677A'),(368,'MBA00448',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'MICHAEL WAHOME','','CHEGE',NULL,'MICHAEL WAHOME CHEGE','254722109557',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM584K'),(369,'MBA00449',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ROSELYNE AUMA OKWARO','','',NULL,'ROSELYNE AUMA OKWARO','727047668',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL241N'),(370,'MBA00450',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'VALENTINE MAGOMERE KALENDA','','',NULL,'VALENTINE MAGOMERE KALENDA','724500724',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM327M'),(371,'MBA00451',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SILAS SIMIYU WATANGWA','','',NULL,'SILAS SIMIYU WATANGWA','727779323',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL708J'),(372,'MBA00452',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KALOLELI GROUP4','','',NULL,'KALOLELI GROUP4','703481856',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'GROUP'),(373,'MBA00453',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'PAUL KIPKIRUI SIELE','','',NULL,'PAUL KIPKIRUI SIELE','727306154',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL252K'),(374,'MBA00454',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'ISAAC MAYAKA NYAKANGI','','',NULL,'ISAAC MAYAKA NYAKANGI','703109908',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL410H'),(375,'MBA00455',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'ESTHER MASAKI','','MOKEIRA',NULL,'ESTHER MASAKI MOKEIRA','254729582744',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL400N'),(376,'MBA00456',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'VINCENT CHERUTICH KIGEN','','',NULL,'VINCENT CHERUTICH KIGEN','723116659',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM297E'),(377,'MBA00457',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'THOMAS MOYWAYA OTOKI','','',NULL,'THOMAS MOYWAYA OTOKI','726234526',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 885D'),(378,'MBA00458',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'JUDITH MBITHE WAMBUA','','',NULL,'JUDITH MBITHE WAMBUA','720764275',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 579K'),(379,'MBA00459',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'FRANCIS','KITETA','MUSYOKI',NULL,'FRANCIS KITETA MUSYOKI','254723849441',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(380,'MBA00460',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'ROBERT','GACHUHI','WANGARI',NULL,'ROBERT GACHUHI WANGARI','712790213',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(381,'MBA00461',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'DANIEL OTIENO ORIMA','','',NULL,'DANIEL OTIENO ORIMA','729881285',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM704E'),(382,'MBA00340',NULL,300,NULL,'2017-01-02','2017-01-01',20,NULL,NULL,'RICHARD WEFWAFWA KHAUKHA','','',NULL,'RICHARD WEFWAFWA KHAUKHA','718872700',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK060Z'),(383,'TUKK00001',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'RASHID CHOME MUMBA ','','',NULL,'RASHID CHOME MUMBA ','796163038',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(384,'TUKK00002',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'LEONARD AYODO','','NAPA',NULL,'LEONARD AYODO NAPA','254724811070',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(385,'TUKK00003',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'BENARD','','JAOKO AKELLO',NULL,'BENARD JAOKO AKELLO','254725237872',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(386,'TUKK00004',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MERCY OKINYO OGUTU','','',NULL,'MERCY OKINYO OGUTU','716793810',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(387,'MBA00462',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'TURPESIO KOIDONYO LETUYA','','',NULL,'TURPESIO KOIDONYO LETUYA','707510422',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 509P'),(388,'MBA00463',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'NICKSON MAJIMBO','','HINZANO',NULL,'NICKSON MAJIMBO HINZANO','254716839113',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,' KMEM201D '),(389,'MBA00464',NULL,300,NULL,'2017-01-02','2017-01-01',13,NULL,NULL,'ALI AHMED MOHAMED','','',NULL,'ALI AHMED MOHAMED','713591845',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM135L'),(390,'MBA00465',NULL,300,NULL,'2017-01-02','2017-01-01',34,NULL,NULL,'ROBERT CHERUIYOT KEMBOI','','',NULL,'ROBERT CHERUIYOT KEMBOI','704922809',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL338C'),(391,'MBA00466',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'LUCY AKINYI ONYANGO','','',NULL,'LUCY AKINYI ONYANGO','700199058',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM299U'),(392,'MBA00467',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'CHARLES OOKO ALUOCH','','',NULL,'CHARLES OOKO ALUOCH','718183261',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM335T'),(393,'MBA00468',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'MOSES OMOLLO','','AUKA',NULL,'MOSES OMOLLO AUKA','254702633833',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL637Q'),(394,'MBA00469',NULL,300,NULL,'2017-01-02','2017-01-01',29,NULL,NULL,'ALEXANDER OBINO MAUGO','','',NULL,'ALEXANDER OBINO MAUGO','710428714',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL774Y'),(395,'MBA00470',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'FRANCIS','CHEGE','KIMANI',NULL,'FRANCIS CHEGE KIMANI','254722736808',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL612U'),(396,'MBA00471',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'BATHLOMEO','','MUDWASI ONYANGO',NULL,'BATHLOMEO MUDWASI ONYANGO','254724026462',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL800Q'),(397,'MBA00473',NULL,300,NULL,'2017-01-02','2017-01-01',20,NULL,NULL,'MAURICE','','MWANDIKI',NULL,'MAURICE MWANDIKI','254797881270',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL644G'),(398,'MBA00475',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ALEX DEMBWA PANYAKO','','',NULL,'ALEX DEMBWA PANYAKO','729252437',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(399,'MBA00476',NULL,300,NULL,'2017-01-02','2017-01-01',6,NULL,NULL,'SYPROSE ATIENO OCHIENG','','',NULL,'SYPROSE ATIENO OCHIENG','746464000',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM099X'),(400,'MBA00477',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'TITUS ODUOR OPONDO','','',NULL,'TITUS ODUOR OPONDO','711925024',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 716E'),(401,'MBA00478',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'GRACE NJOKI NJENGA','','',NULL,'GRACE NJOKI NJENGA','725240379',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM595S'),(402,'MBA00479',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'FRANCIS','GITONGA','MAGUU',NULL,'FRANCIS GITONGA MAGUU','254723300692',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL986Z'),(403,'MBA00480',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'VIOLET KADENGE AHORA','','',NULL,'VIOLET KADENGE AHORA','720925491',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM002H'),(404,'MBA00481',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'FREDRICK','OWINO','OLWENYA',NULL,'FREDRICK OWINO OLWENYA','254710232131',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM342M'),(405,'MBA00482',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KEVIN OMONDI ONYOR','','',NULL,'KEVIN OMONDI ONYOR','702722211',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM970U'),(406,'MBA00483',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'EDITH MUTHEU','','WEYIMI',NULL,'EDITH MUTHEU WEYIMI','254723895020',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM348M'),(407,'MBA00484',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'GEORGE','MUTACHI','WATHITWA',NULL,'GEORGE MUTACHI WATHITWA','254741462308',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM346M'),(408,'MBA00485',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'REHEMA MAPESA ANEKEYA','','',NULL,'REHEMA MAPESA ANEKEYA','701494548',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM332M'),(409,'MBA00486',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'DEVIS OMUKONY KEYA','','',NULL,'DEVIS OMUKONY KEYA','746676179',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM324M'),(410,'MBA00487',NULL,300,NULL,'2017-01-02','2017-01-01',35,NULL,NULL,'TENKE KILLA','','',NULL,'TENKE KILLA','742069769',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 813L'),(411,'MBA00488',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'LABAN GULENYA','','SILAS',NULL,'LABAN GULENYA SILAS','254720004522',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL864U'),(412,'MBA00489',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'GABRIEL WABUKO','','CHITECHI',NULL,'GABRIEL WABUKO CHITECHI','254795848653',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL869U'),(414,'MBA00491',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'DOMINIC MIGOSI/KWAMBOKA MOMANYI','','',NULL,'DOMINIC MIGOSI/KWAMBOKA MOMANYI','743646595',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM569S'),(415,'MBA00492',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JOHN MWANGI NJOROGE','','',NULL,'JOHN MWANGI NJOROGE','700179845',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ450X'),(416,'MBA00493',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'TOM MWANGI WANJIKU','','',NULL,'TOM MWANGI WANJIKU','718104026',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM669S'),(417,'MBA00494',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'MARY GITHINJI','','',NULL,'MARY GITHINJI','715945302',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM967M'),(418,'MBA00495',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JAMES KAMAU MBUGUA','','',NULL,'JAMES KAMAU MBUGUA','797156186',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 592S'),(419,'MBA00496',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'DOMINIC KIMUTAI','','KECH',NULL,'DOMINIC KIMUTAI KECH','254724815375',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM555P'),(420,'MBA00497',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'NYAGEKENE GESIMBA DAN','','',NULL,'NYAGEKENE GESIMBA DAN','712703705',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL423R'),(421,'MBA00498',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JOSPHAT','KIPNGENO','BETT',NULL,'JOSPHAT KIPNGENO BETT','254728408250',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM381Y'),(422,'MBA00499',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'HILLARY KIPKIRUI KORIR','','',NULL,'HILLARY KIPKIRUI KORIR','727007962',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM092X'),(423,'MBA00500',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'GLADYS CHEPKEMOI','','',NULL,'GLADYS CHEPKEMOI','743581696',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM399W'),(424,'MBA00501',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'LEONARD KIBET','','KEIYO',NULL,'LEONARD KIBET KEIYO','254729523849',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM056X'),(425,'MBA00502',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'BENARD KIPNGENO LANGAT','','',NULL,'BENARD KIPNGENO LANGAT','728337383',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM046X'),(426,'MBA00503',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JOHN KIPCHUMBA ROTICH','','',NULL,'JOHN KIPCHUMBA ROTICH','710810887',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM368W'),(427,'MBA00504',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KIPANGAT YEGON COSMAS','','',NULL,'KIPANGAT YEGON COSMAS','724853914',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM225W'),(428,'MBA00505',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'DANIEL KIPNGETICH','','CHELOGOI',NULL,'DANIEL KIPNGETICH CHELOGOI','254702499848',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM843Y'),(429,'MBA00506',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'MARY','','CHEROTICH',NULL,'MARY CHEROTICH','254726469250',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM079X'),(430,'MBA00507',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'FESTUS KIPYEGON KIRUI','','',NULL,'FESTUS KIPYEGON KIRUI','707278878',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM030X'),(431,'MBA00508',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JOHN OWINO OMEDO','','',NULL,'JOHN OWINO OMEDO','715583394',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL022H'),(432,'MBA00509',NULL,300,NULL,'2017-01-02','2017-01-01',13,NULL,NULL,'KIBWANA NGONYO HHINZANO','','',NULL,'KIBWANA NGONYO HHINZANO','716134346',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM281S'),(433,'MBA00510',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,' BONIFACE OUMA OGANYO','','',NULL,' BONIFACE OUMA OGANYO','724296096',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM989N'),(434,'MBA00511',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'JOHNSON EKALALE ALEPER','','',NULL,'JOHNSON EKALALE ALEPER','729112121',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN942C'),(435,'MBA00512',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'STEPHEN ERUKUDI LOYOKON','','',NULL,'STEPHEN ERUKUDI LOYOKON','790827251',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN973C'),(436,'MBA00513',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'ELISHA KIPROTICH','','MAIYO',NULL,'ELISHA KIPROTICH MAIYO','254729621710',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM672P'),(437,'MBA00514',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BENSON NABHISWA WAFULA','','',NULL,'BENSON NABHISWA WAFULA','727558310',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN910C'),(438,'MBA00515',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'JOEL MASINDE MUKHWANA','','',NULL,'JOEL MASINDE MUKHWANA','723234509',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM944C'),(439,'MBA00516',NULL,300,NULL,'2017-01-02','2017-01-01',43,NULL,NULL,'STEPHEN KABUI GACHERU','','',NULL,'STEPHEN KABUI GACHERU','722352507',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM651C'),(440,'MBA00517',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'RICHARD ONYIEGO','','OMERU',NULL,'RICHARD ONYIEGO OMERU','254710451321',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN227B'),(441,'MBA00518',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ABEL WASILWA WABWOBA ','','',NULL,'ABEL WASILWA WABWOBA ','796898008',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN998C'),(442,'MBA00519',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'WILFERED OPUMBI SANGOLO','','',NULL,'WILFERED OPUMBI SANGOLO','742238575',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL956X'),(443,'MBA00520',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'JOSEPHAT ONYACHI OWINO','','',NULL,'JOSEPHAT ONYACHI OWINO','729524399',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN663D'),(444,'MBA00521',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'ESTHER AROT','','NGITWAN',NULL,'ESTHER AROT NGITWAN','254705943895',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM 642X'),(445,'MBA00522',NULL,300,NULL,'2017-01-02','2017-01-01',22,NULL,NULL,'SAMSON EIYAN KIYONGA','','',NULL,'SAMSON EIYAN KIYONGA','705394783',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM583X'),(446,'MBA00523',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'MICHAEL NYORO','','WANJIKU',NULL,'MICHAEL NYORO WANJIKU','254704009337',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM664X'),(447,'MBA00524',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'DAVID KIPKIRUI LANGAT','','',NULL,'DAVID KIPKIRUI LANGAT','724885749',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN089H'),(448,'MBA00525',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ROBERT KIPRONO NGETICH/CAREN CHEBET','','',NULL,'ROBERT KIPRONO NGETICH/CAREN CHEBET','726297854',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN137H'),(450,'MBA00527',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'AMOS WANYONYI NYONGESA','','',NULL,'AMOS WANYONYI NYONGESA','705448155',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN319'),(451,'MBA00528',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JOAN CHELANGAT','','',NULL,'JOAN CHELANGAT','718168262',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN013H'),(452,'MBA00529',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ALFRED KIPRONO BET','','',NULL,'ALFRED KIPRONO BET','721607485',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN054H'),(453,'MBA00530',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'NICHOLAS KIPLANGAT KIRUI','','',NULL,'NICHOLAS KIPLANGAT KIRUI','715245285',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN017H'),(454,'MBA00531',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'EMMANUEL','','KIPLANGAT',NULL,'EMMANUEL KIPLANGAT','254706444681',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN042H'),(455,'MBA00532',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JOSEAH','KIPLANGAT','KOECH',NULL,'JOSEAH KIPLANGAT KOECH','254711242528',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN048H'),(456,'MBA00533',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'AMBROSE KIPLANGAT MOLEL','','',NULL,'AMBROSE KIPLANGAT MOLEL','740952544',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN123H'),(457,'MBA00534',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'NICKSON LANGAT','','',NULL,'NICKSON LANGAT','707095124',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN394G'),(458,'MBA00535',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'SHARON CHESANG','','',NULL,'SHARON CHESANG','727809744',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN070H'),(459,'MBA00536',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ERICK KIMUTAI KIRUI','','',NULL,'ERICK KIMUTAI KIRUI','728791406',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN130H'),(460,'MBA00537',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KENNETH LANGAT','','',NULL,'KENNETH LANGAT','713264382',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN132H'),(461,'MBA00538',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'PAUL KIPKIRUI KURGAT','','',NULL,'PAUL KIPKIRUI KURGAT','722545432',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM540K'),(462,'MBA00540',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'EDWIN KIPKIRUI RUTO','','',NULL,'EDWIN KIPKIRUI RUTO','712873953',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL608U'),(463,'MBA00541',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'SAMUEL INKIYA NYAUNDI','','',NULL,'SAMUEL INKIYA NYAUNDI','727802108',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN122H'),(464,'MBA00542',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WILIAM CHELULE','','',NULL,'WILIAM CHELULE','702057379',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN050H'),(465,'MBA00543',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'EMMANUEL NABISWA','','',NULL,'EMMANUEL NABISWA','723591830',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM846V'),(466,'MBA00544',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'CHRISTOPHER WAFULA MALEMO','','',NULL,'CHRISTOPHER WAFULA MALEMO','721864230',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM597X'),(467,'MBA00545',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'MESHACK MWANGATIA','','MWAKALE',NULL,'MESHACK MWANGATIA MWAKALE','254798378343',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN293C'),(468,'MBA00546',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'SAMUEL OOKO ONINGA','','',NULL,'SAMUEL OOKO ONINGA','724636380',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN104R'),(469,'MBA00547',NULL,300,NULL,'2017-01-02','2017-01-01',29,NULL,NULL,'CATHERINE WANZA WAITA/CHRISTOPHER AVULALA SABWA','','',NULL,'CATHERINE WANZA WAITA/CHRISTOPHER AVULALA SABWA','714848289',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEE817A'),(470,'MBA00548',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SOLOMON NANDALI KANYAMA','','',NULL,'SOLOMON NANDALI KANYAMA','719502174',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN627D'),(471,'MBA00549',NULL,300,NULL,'2017-01-02','2017-01-01',48,NULL,NULL,'ALEX MWATEE MAFTAI','','',NULL,'ALEX MWATEE MAFTAI','700275263',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN892B'),(472,'MBA00550',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BENARD OUMA OWUOR','','',NULL,'BENARD OUMA OWUOR','721408123',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN814C'),(473,'MBA00551',NULL,300,NULL,'2017-01-02','2017-01-01',48,NULL,NULL,'FATMA','DOUGLAS','MOHAMED',NULL,'FATMA DOUGLAS MOHAMED','254724611374',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL567W'),(474,'MBA00552',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'EZEKIEL','','KIPRATUS',NULL,'EZEKIEL KIPRATUS','254712204204',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM914F'),(475,'MBA00553',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BEN SIMIYU BARASA','','',NULL,'BEN SIMIYU BARASA','725521254',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN854B'),(476,'MBA00554',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BEATRICE NEKESA MASINDANO','','',NULL,'BEATRICE NEKESA MASINDANO','713191881',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM551P'),(477,'MBA00555',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'DANIEL KIPTANUI','','BITOK',NULL,'DANIEL KIPTANUI BITOK','254705357717',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN973A'),(478,'MBA00556',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'ASTONE WANYONYI','','',NULL,'ASTONE WANYONYI','711832294',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM727F'),(479,'MBA00557',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'RICHARD MULUPI SOITA/','','DAVID BARASA',NULL,'RICHARD MULUPI SOITA/ DAVID BARASA','254728723818',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM903E'),(480,'MBA00558',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'HANNA','WANJIRU','KUNGU',NULL,'HANNA WANJIRU KUNGU','254799613841',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM540W'),(481,'MBA00559',NULL,300,NULL,'2017-01-02','2017-01-01',43,NULL,NULL,'PRISCILLAH GRACE OPUMBI','','',NULL,'PRISCILLAH GRACE OPUMBI','715300274',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG897R'),(482,'MBA00560',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'GABRIEL','WAMALWA','WANJALA',NULL,'GABRIEL WAMALWA WANJALA','254725630441',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN958S'),(483,'MBA00561',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'MERINE NALIAKA','','WAFULA',NULL,'MERINE NALIAKA WAFULA','254706800715',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN834S'),(484,'MBA00562',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'GODFREY','','WANGILA',NULL,'GODFREY WANGILA','254728387600',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN936S'),(485,'MBA00563',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ROSE LUTOMIA OKUMU','','',NULL,'ROSE LUTOMIA OKUMU','725697212',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN963S'),(486,'MBA00564',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'RUTH WAMUYU KAMAU/ALEXANDER KIMOTHO','','',NULL,'RUTH WAMUYU KAMAU/ALEXANDER KIMOTHO','798195013',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM634K'),(487,'MBA00565',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'SAMWEL ONDIGO OMENTA','','',NULL,'SAMWEL ONDIGO OMENTA','708577136',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM746C'),(488,'MBA00566',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'JOSEPH LUSWETI KAWA','','',NULL,'JOSEPH LUSWETI KAWA','724039710',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN495T'),(489,'MBA00567',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'KEVIN KIPRONO','','',NULL,'KEVIN KIPRONO','719486245',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN508T'),(490,'MBA00568',NULL,300,NULL,'2017-01-02','2017-01-01',7,NULL,NULL,'EUNICE CHEPCHOGE','','MWELI',NULL,'EUNICE CHEPCHOGE MWELI','254710816024',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM467B'),(491,'MBA00569',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'WILSON KINUTHIA NG\'ETHE','','',NULL,'WILSON KINUTHIA NG\'ETHE','713352029',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM665X'),(492,'MBA00570',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'RIOBA DANIEL MWITA','','',NULL,'RIOBA DANIEL MWITA','707971062',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN523T'),(493,'MBA00571',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ADAMS MARANGA ','','',NULL,'ADAMS MARANGA ','703264214',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM646X'),(494,'MBA00572',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'PATRICK KAMENJE','','',NULL,'PATRICK KAMENJE','791974573',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN824S'),(495,'MBA00573',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'JOSHUA','ANYANGA','OMUHAKA',NULL,'JOSHUA ANYANGA OMUHAKA','254748469873',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN756S'),(496,'MBA00574',NULL,300,NULL,'2017-01-02','2017-01-01',31,NULL,NULL,'GREGORY','AMBETSA','ANDOGO',NULL,'GREGORY AMBETSA ANDOGO','254713313612',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN758S'),(497,'MBA00575',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'MELAP NEKESA','','WAFULA',NULL,'MELAP NEKESA WAFULA','254708384639',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN997C'),(498,'MBA00576',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'TOBIAS SIMIYU','','JUMA',NULL,'TOBIAS SIMIYU JUMA','254713234281',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL483W'),(499,'MBA00577',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'HAMISI MWAKA NYAURUKU','','',NULL,'HAMISI MWAKA NYAURUKU','728172982',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL387W'),(500,'MBA00578',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'PRISTON NYONGESA SIKUKU','','',NULL,'PRISTON NYONGESA SIKUKU','707749498',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL574U'),(501,'MBA00579',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'GERALD','SIFUNA','MASINDE',NULL,'GERALD SIFUNA MASINDE','254715183747',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN967S'),(502,'MBA00580',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'JUVEN WAFULA WANGULA','','',NULL,'JUVEN WAFULA WANGULA','791433002',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN944S'),(503,'MBA00581',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'GLADYS','NALIAKA','JUMA',NULL,'GLADYS NALIAKA JUMA','254719828394',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM648X'),(504,'MBA00582',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'SAMWEL NYONGESA','','MUNYEFU',NULL,'SAMWEL NYONGESA MUNYEFU','254706082535',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN006T'),(505,'MBA00583',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'DOUGLAS AVUYALI KEYA','','',NULL,'DOUGLAS AVUYALI KEYA','720397639',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL035V'),(506,'MBA00584',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'GREGORY KHAMINWA MUKAISI','','',NULL,'GREGORY KHAMINWA MUKAISI','721334796',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN991S'),(507,'MBA00585',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'CHARLES OGUNDE ODHOCH','','',NULL,'CHARLES OGUNDE ODHOCH','712264073',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN850S'),(508,'MBA00586',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'JOHN ABIERO ORIDO','','',NULL,'JOHN ABIERO ORIDO','729644874',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM478W'),(509,'MBA00587',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'JUNIOR','THOMAS','DIMBA',NULL,'JUNIOR THOMAS DIMBA','254727337657',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN940S'),(510,'MBA00588',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'CONSOLATER ADOGO OCHIENG','','',NULL,'CONSOLATER ADOGO OCHIENG','706837861',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN737S'),(511,'MBA00589',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'MODESTA MUSAVI','','IKHOKORO',NULL,'MODESTA MUSAVI IKHOKORO','254723752235',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN012T'),(512,'MBA00590',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'FREDRICK','OGUTU','OBURA',NULL,'FREDRICK OGUTU OBURA','254713546494',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN931S'),(513,'MBA00591',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'KENNEDY ODUOR','','WALORI',NULL,'KENNEDY ODUOR WALORI','254718527155',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM158B'),(514,'MBA00592',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'EDGAR ONG\'ANYA','','NYAWARE',NULL,'EDGAR ONG\'ANYA NYAWARE','254713514841',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM463W'),(515,'MBA00593',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'SILPER ADHIAMBO MWATA','','',NULL,'SILPER ADHIAMBO MWATA','743883065',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL614Q'),(516,'MBA00594',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'ALBERT ADUR ALOGO','','',NULL,'ALBERT ADUR ALOGO','728122290',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL519U'),(517,'MBA00595',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'ERICK OUMA','','OWUOR',NULL,'ERICK OUMA OWUOR','254700476308',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL973B'),(518,'MBA00596',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DAVID WABWIRE','','MULONGO',NULL,'DAVID WABWIRE MULONGO','254791887934',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL986Z'),(519,'MBA00597',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'PETERSON KIBETI NYANGARESI','','',NULL,'PETERSON KIBETI NYANGARESI','725820836',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN934B'),(520,'MBA00598',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'DAVID AMUNGA','','OBARA',NULL,'DAVID AMUNGA OBARA','254706223985',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN843C'),(521,'MBA00599',NULL,300,NULL,'2017-01-02','2017-01-01',14,NULL,NULL,'KINKIRRI OLE NGOSSOR','','',NULL,'KINKIRRI OLE NGOSSOR','719486662',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM643W'),(522,'MBA00600',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'DAVID NATEMBEA','','',NULL,'DAVID NATEMBEA','795484591',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM936F'),(523,'MBA00601',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'CLARE','KHAIMBA','LUHOMBO',NULL,'CLARE KHAIMBA LUHOMBO','254708774710',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM646F'),(524,'MBA00602',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'PETER OMUTSOTSI OKUTOYI','','',NULL,'PETER OMUTSOTSI OKUTOYI','713278573',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN479K'),(525,'MBA00603',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'VICTOR ODHIAMBO ATUDO','','',NULL,'VICTOR ODHIAMBO ATUDO','796574412',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN977S'),(526,'MBA00604',NULL,300,NULL,'2017-01-02','2017-01-01',15,NULL,NULL,'ABDALLA TETEMU MWITA','','',NULL,'ABDALLA TETEMU MWITA','706956404',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN780S'),(527,'MBA00605',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'PAULINE','','NAFULA',NULL,'PAULINE NAFULA','254720491615',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM729F'),(528,'MBA00606',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'MOSES SIMIYU','','WAMALWA',NULL,'MOSES SIMIYU WAMALWA','254715256906',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN744G'),(529,'MBA00607',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'JAMES MWANGI GITAU','','',NULL,'JAMES MWANGI GITAU','723811917',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN434K'),(530,'MBA00608',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ELPHAS','','SIMIYU',NULL,'ELPHAS SIMIYU','254707897083',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM771F'),(531,'MBA00609',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'SUSAN ATIENO OCHIENG','','',NULL,'SUSAN ATIENO OCHIENG','727550254',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN949S'),(532,'MBA00610',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'EJEIZA ANGELINE SIKINYI','','',NULL,'EJEIZA ANGELINE SIKINYI','795683302',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP261G'),(533,'MBA00611',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'VICTOR OCHIENG ORINDA','','',NULL,'VICTOR OCHIENG ORINDA','704285322',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN862S'),(534,'MBA00612',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ROBERT KHAEMBA MALABA','','',NULL,'ROBERT KHAEMBA MALABA','710491816',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN974E'),(535,'MBA00613',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JUDITH ADHIAMBO ODUOR','','',NULL,'JUDITH ADHIAMBO ODUOR','706464735',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN873J'),(536,'MBA00614',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'VICTOR OTIENO OUMA','','',NULL,'VICTOR OTIENO OUMA','790337031',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN852J'),(537,'MBA00615',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JAMES MANANE OSEBE','','',NULL,'JAMES MANANE OSEBE','742307604',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN633E'),(538,'MBA00616',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'KRISTOFA ONDIEKI NYADI','','',NULL,'KRISTOFA ONDIEKI NYADI','721127213',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN471W'),(539,'MBA00617',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DENNIS OTIENO','','ODUOR',NULL,'DENNIS OTIENO ODUOR','254798136071',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN531M'),(540,'MBA00618',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'EDWARD OCHIENG ABONA','','',NULL,'EDWARD OCHIENG ABONA','725219697',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN957E'),(541,'MBA00619',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'BENARD OMONDI OTIENO/ROY OCHECHE','','',NULL,'BENARD OMONDI OTIENO/ROY OCHECHE','796489795',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM530M'),(542,'MBA00620',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ESTHER ACHIENG OGINGA','','',NULL,'ESTHER ACHIENG OGINGA','714094233',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN895S'),(543,'MBA00621',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'GODFREY WASIKE WABWILE','','',NULL,'GODFREY WASIKE WABWILE','728454853',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP423E'),(544,'MBA00622',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'DANIEL WASWA','','KHMALA',NULL,'DANIEL WASWA KHMALA','254708439758',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM789F'),(545,'MBA00623',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'FELIX','ODHIAAMBO','OIGO',NULL,'FELIX ODHIAAMBO OIGO','254711777560',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP679H'),(546,'MBA00624',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'HILLARY','KIPKIRUI','LABOSO',NULL,'HILLARY KIPKIRUI LABOSO','254708235202',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP279J'),(547,'MBA00626',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ROBERT KIPLANGAT CHEPKWONY','','',NULL,'ROBERT KIPLANGAT CHEPKWONY','712313966',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP187E'),(548,'MBA00627',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'MATHEW KIPRONO','','MUTAI',NULL,'MATHEW KIPRONO MUTAI','254729949466',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP206E'),(549,'MBA00628',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'NICHOLAS KIPROTICH KORIR','','',NULL,'NICHOLAS KIPROTICH KORIR','726403580',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP343J'),(550,'MBA00629',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'CHEPKORIR FAITH','','',NULL,'CHEPKORIR FAITH','702813051',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP117H'),(551,'MBA00630',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JOHN KIPLANGAT TONUI','','',NULL,'JOHN KIPLANGAT TONUI','721653456',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP142K'),(552,'MBA00631',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ROBINSON KIPNGETICH KORIR','','',NULL,'ROBINSON KIPNGETICH KORIR','791304665',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP119K'),(553,'MBA00632',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WESLEY KIPNGETICH CHERUIYOT','','',NULL,'WESLEY KIPNGETICH CHERUIYOT','724508321',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP282E'),(554,'MBA00633',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KIBET NGETICH','','',NULL,'KIBET NGETICH','703771874',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP355J'),(555,'MBA00634',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'CHERUIYOT KIPKOECH','','EVANS',NULL,'CHERUIYOT KIPKOECH EVANS','254799256051',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP329J'),(556,'MBA00635',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'DOMINIC LANGAT ROTICH','','',NULL,'DOMINIC LANGAT ROTICH','726113858',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP061M'),(557,'MBA00636',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'DOMINIC KIMUTAI','','LANGAT',NULL,'DOMINIC KIMUTAI LANGAT','254745047382',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP310E'),(558,'MBA00637',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ELIJAH MUTAI','','',NULL,'ELIJAH MUTAI','703639377',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP277J'),(559,'MBA00638',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'DENNIS KIPKOECH','','SANG',NULL,'DENNIS KIPKOECH SANG','254708032117',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP390J'),(560,'MBA00639',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KIPNGENO KENETH','','',NULL,'KIPNGENO KENETH','711508501',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP072G'),(561,'MBA00640',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'BETTY','','CHEPNGETICH',NULL,'BETTY CHEPNGETICH','254729065766',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP110M'),(562,'MBA00641',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'NOAH','CHERUIYOT','SIELE',NULL,'NOAH CHERUIYOT SIELE','254790073004',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP008M'),(563,'MBA00642',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'JOSPHAT KIPRONO KURGAT','','',NULL,'JOSPHAT KIPRONO KURGAT','727441739',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP024K'),(564,'MBA00643',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'NANCY CHEOKIRUI','','SIELE',NULL,'NANCY CHEOKIRUI SIELE','254702672628',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP058J'),(565,'MBA00644',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'WELDON KIPRONO KIRUI','','',NULL,'WELDON KIPRONO KIRUI','703167758',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP024M'),(566,'MBA00645',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'GILBERT KIBET LANGAT','','',NULL,'GILBERT KIBET LANGAT','702447987',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP080G'),(567,'MBA00646',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'AMOS KIPKEMOI KEITANY','','',NULL,'AMOS KIPKEMOI KEITANY','711284764',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP088M'),(568,'MBA00647',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'ENOCK KIPROTICH','','LANGAT',NULL,'ENOCK KIPROTICH LANGAT','254722966773',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP097M'),(569,'MBA00648',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'SAMUEL CHANDOEK KIPLANGAT','','',NULL,'SAMUEL CHANDOEK KIPLANGAT','728729463',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP117M'),(570,'MBA00649',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'RONO ARON ','','',NULL,'RONO ARON ','728265222',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP076G'),(571,'MBA00650',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'BENARD KIPKIRUI','','LANGAT',NULL,'BENARD KIPKIRUI LANGAT','254728767347',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP602C'),(572,'MBA00651',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'EDMON KIPSEROI','','CHESIGEI',NULL,'EDMON KIPSEROI CHESIGEI','254720501885',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP136K'),(573,'MBA00652',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'KIPKIRUI TERER','','',NULL,'KIPKIRUI TERER','796583448',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP155K'),(575,'MBA00654',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'LEONARD KIPKOECH KETER','','',NULL,'LEONARD KIPKOECH KETER','715162719',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP399J'),(576,'MBA00655',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'SIMON NGIGE','','',NULL,'SIMON NGIGE','729806943',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP112G'),(577,'MBA00656',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'BONIFACE MUKWATE KATULA','','',NULL,'BONIFACE MUKWATE KATULA','721668981',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP338N'),(578,'MBA00657',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'ELIJAH KAGORI','','WAIRIMU',NULL,'ELIJAH KAGORI WAIRIMU','254714787320',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP310D'),(579,'MBA00658',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'JANE ROSE TOTO','','',NULL,'JANE ROSE TOTO','710940203',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP330K'),(580,'MBA00659',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'CATHERINE AUMA OMOLO','','',NULL,'CATHERINE AUMA OMOLO','700281260',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP187K'),(581,'MBA00660',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'CAROLYNE ATIENO OTIENO','','',NULL,'CAROLYNE ATIENO OTIENO','727367392',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN973A'),(582,'MBA00661',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'EVERLINE NELIMA','','WAAKHISI',NULL,'EVERLINE NELIMA WAAKHISI','254704179196',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP332G'),(583,'MBA00662',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'ESTHER AUMA','','JUMA',NULL,'ESTHER AUMA JUMA','254704522749',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP778H'),(584,'MBA00663',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'WYCLIFFE MAKOKHA','','OKWOMI',NULL,'WYCLIFFE MAKOKHA OKWOMI','254704405125',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM643X'),(585,'MBA00664',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'LILLYANNE ACHIENG','','OMOLLO',NULL,'LILLYANNE ACHIENG OMOLLO','254707754505',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM674X'),(586,'MBA00665',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DANIEL OTIENO','','AUMA',NULL,'DANIEL OTIENO AUMA','254726109625',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN696M'),(587,'MBA00666',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'JAMES KARIUKI THIONGO','','',NULL,'JAMES KARIUKI THIONGO','712438478',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,''),(588,'MBA00667',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'FREDRICK','OLUOCH','OTIENO',NULL,'FREDRICK OLUOCH OTIENO','254720568355',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN590E'),(589,'MBA00668',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'JOSEPH OKOTH OJALA','','',NULL,'JOSEPH OKOTH OJALA','707614864',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL562W'),(590,'MBA00669',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'VICTOR OCHIENG OCHAM','','',NULL,'VICTOR OCHIENG OCHAM','795829061',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP232K'),(591,'MBA00670',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'CHARLES OWINO OGAWO','','',NULL,'CHARLES OWINO OGAWO','726114059',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN475T'),(592,'MBA00671',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'FREDRICK','SUNYA','OUMA',NULL,'FREDRICK SUNYA OUMA','254717137644',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN674D'),(593,'MBA00672',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'IBRAHIM','ALUKHAMBA','ANDERE',NULL,'IBRAHIM ALUKHAMBA ANDERE','254715204242',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEL489U'),(594,'MBA00673',NULL,300,NULL,'2017-01-02','2017-01-01',12,NULL,NULL,'JAMES KAMURWA MWANIKI','','',NULL,'JAMES KAMURWA MWANIKI','739499242',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN574U'),(595,'MBA00674',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'WALTER ONYANNGO AWIMBO','','',NULL,'WALTER ONYANNGO AWIMBO','799885244',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP434E'),(596,'MBA00675',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'JACOB MBITHI NZIOKA','','',NULL,'JACOB MBITHI NZIOKA','799819330',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP879M'),(597,'MBA00676',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'DANIEL KAUSO','','JOSHUA',NULL,'DANIEL KAUSO JOSHUA','254715056546',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN803W'),(598,'MBA00677',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'FRANCIS ONYANGO OTIENO','','',NULL,'FRANCIS ONYANGO OTIENO','796437796',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP131M'),(599,'MBA00678',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'DAVID ODHIAMBO','','ONDIEK',NULL,'DAVID ODHIAMBO ONDIEK','254740631312',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP164M'),(600,'MBA00679',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'STEPHEN OTIENO  OLOO','','',NULL,'STEPHEN OTIENO  OLOO','704638398',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP370M'),(601,'MBA00680',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'DENIS OCHIENG','','ODHIAMBO',NULL,'DENIS OCHIENG ODHIAMBO','254791529175',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP321M'),(602,'MBA00681',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'WILFRED OMONDI ONDONG','','',NULL,'WILFRED OMONDI ONDONG','726296568',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP157M'),(603,'MBA00682',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'AGGREY ODHIAMBO SIJENYI','','',NULL,'AGGREY ODHIAMBO SIJENYI','726417635',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP144M'),(604,'MBA00683',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'EVANCE ODHIAMBO','','AEJE',NULL,'EVANCE ODHIAMBO AEJE','254715523169',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP500E'),(605,'MBA00684',NULL,300,NULL,'2017-01-02','2017-01-01',38,NULL,NULL,'ROINE OLE MOKOONKI','','',NULL,'ROINE OLE MOKOONKI','702519481',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN569U'),(606,'MBA00685',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'DAVID CHOCHO','','OTIENO',NULL,'DAVID CHOCHO OTIENO','254705866347',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN674D'),(607,'MBA00686',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'MATHEW KENNEDY','','OKOTH',NULL,'MATHEW KENNEDY OKOTH','254721519548',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN572X'),(608,'MBA00687',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'FREDRICK ODHIAMBO ODIPO','','',NULL,'FREDRICK ODHIAMBO ODIPO','727203212',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN739S'),(609,'MBA00688',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'JAMES MIDHAI MIDHAI','','',NULL,'JAMES MIDHAI MIDHAI','792673692',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP130M'),(610,'MBA00689',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'SAMWEL GATI MWITA','','',NULL,'SAMWEL GATI MWITA','710501444',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP435E'),(611,'MBA00690',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'MICHAEL NGUGI WANYOIKE','','',NULL,'MICHAEL NGUGI WANYOIKE','721769536',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN576U'),(612,'MBA00691',NULL,300,NULL,'2017-01-02','2017-01-01',26,NULL,NULL,'PETER BOKE SAITERA','','',NULL,'PETER BOKE SAITERA','724115365',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP473E'),(613,'MBA00692',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'MICHAEL MALILE KALOKI','','',NULL,'MICHAEL MALILE KALOKI','712282111',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP322K'),(614,'MBA00693',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JOSHUA OKWACH OOKO','','',NULL,'JOSHUA OKWACH OOKO','724682814',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP317K'),(615,'MBA00694',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'DAVID OCHIENG ORIEYO','','',NULL,'DAVID OCHIENG ORIEYO','712823733',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP318Z'),(616,'MBA00695',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'BARTHOLOMEUS OWINO OGEDA','','',NULL,'BARTHOLOMEUS OWINO OGEDA','721122283',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP954F'),(617,'MBA00696',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'STEPHEN WAMBUA/RACHEAL NZAKU','','',NULL,'STEPHEN WAMBUA/RACHEAL NZAKU','702636248',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN779Z'),(618,'MBA00697',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'DAVID','','MBATHA',NULL,'DAVID MBATHA','254711788456',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN729Z'),(619,'MBA00698',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'PAUL NZIOKI MUSYOKA','','',NULL,'PAUL NZIOKI MUSYOKA','795283553',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP603A'),(620,'MBA00699',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'FRANCIS','MUTHAMA','KIOKO',NULL,'FRANCIS MUTHAMA KIOKO','254740888542',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN749Z'),(621,'MBA00700',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'THOMAS MUTINDA MUTUA','','',NULL,'THOMAS MUTINDA MUTUA','792852969',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEN779Z'),(622,'MBA00701',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'GEOFREY','NZIOKI','MAVEKE',NULL,'GEOFREY NZIOKI MAVEKE','254726089223',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEM695Y'),(623,'MBA00702',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'PETER MUNYENZE MUTUA','','',NULL,'PETER MUNYENZE MUTUA','720149720',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP549A'),(624,'MBA00703',NULL,300,NULL,'2017-01-02','2017-01-01',10,NULL,NULL,'SAMUE SILA NZIOKI','','',NULL,'SAMUE SILA NZIOKI','790766222',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMER928K'),(625,'MBA00704',NULL,300,NULL,'2017-01-02','2017-01-01',10,NULL,NULL,'BENARD KAMANDI','','',NULL,'BENARD KAMANDI','712000754',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMER927K'),(626,'MBA00705',NULL,300,NULL,'2017-01-02','2017-01-01',10,NULL,NULL,'ERICK BAHATI','','MUSILA',NULL,'ERICK BAHATI MUSILA','254720104054',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEA410B'),(627,'MBA00706',NULL,300,NULL,'2017-01-02','2017-01-01',4,NULL,NULL,'JOANES OJODE','','',NULL,'JOANES OJODE','746770615',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,''),(628,'MBA00707',NULL,300,NULL,'2017-01-02','2017-01-01',36,NULL,NULL,'RAPHAEL WABWIRE OSIEKO','','',NULL,'RAPHAEL WABWIRE OSIEKO','714470063',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEG243D'),(629,'MBA00708',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'FREDRICK','OCHIENG','ONYANGO',NULL,'FREDRICK OCHIENG ONYANGO','254752150708',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ204K'),(631,'MBA00710',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'PATRICK MUTETI KASIMU','','',NULL,'PATRICK MUTETI KASIMU','705764377',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ186J'),(632,'MBA00711',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'MUSYOKI DOMINIC','','',NULL,'MUSYOKI DOMINIC','720346017',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ222G'),(633,'MBA00712',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'ADHAM IBRAHIM MOHAMED ','','',NULL,'ADHAM IBRAHIM MOHAMED ','702452026',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ244G'),(634,'MBA00713',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'FARA','ROVA','ELEMA',NULL,'FARA ROVA ELEMA','254790292025',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ320L'),(635,'MBA00714',NULL,300,NULL,'2017-01-02','2017-01-01',9,NULL,NULL,'JACKSON BONAYA  ABIO','','',NULL,'JACKSON BONAYA  ABIO','702695213',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ210L'),(636,'MBA00715',NULL,300,NULL,'2017-01-02','2017-01-01',24,NULL,NULL,'KHALID THOYA JUMAA','','',NULL,'KHALID THOYA JUMAA','796534272',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ386M'),(637,'MBA00716',NULL,300,NULL,'2017-01-02','2017-01-01',21,NULL,NULL,'EVALINE AKINYI','','OUMA',NULL,'EVALINE AKINYI OUMA','254703482288',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ120G'),(638,'MBA00717',NULL,300,NULL,'2017-01-02','2017-01-01',47,NULL,NULL,'EVANS MWELESA','','ENDIAZI',NULL,'EVANS MWELESA ENDIAZI','254728029888',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ193J'),(639,'MBA00718',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'RODGERS SIKUKU NABIIMBA','','',NULL,'RODGERS SIKUKU NABIIMBA','710152780',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ262L'),(640,'MBA00719',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'BENARD SIMIYU WANYONYI','','',NULL,'BENARD SIMIYU WANYONYI','713831737',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ336S'),(641,'MBA00720',NULL,300,NULL,'2017-01-02','2017-01-01',19,NULL,NULL,'ABRAHAM WAFULA WEKESA','','',NULL,'ABRAHAM WAFULA WEKESA','707633349',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ094S'),(642,'MBA00721',NULL,300,NULL,'2017-01-02','2017-01-01',44,NULL,NULL,'KENNEDY OTIENO OPUK','','',NULL,'KENNEDY OTIENO OPUK','710868727',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ314L'),(643,'MBA00722',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'PATRICK ODHIAMBO OTIENO','','',NULL,'PATRICK ODHIAMBO OTIENO','729833817',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ228L'),(644,'MBA00723',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JUDITH AWUOR ACHAYO','','',NULL,'JUDITH AWUOR ACHAYO','725643613',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ325L'),(645,'MBA00724',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'STEPHEN OUMA HAYO','','',NULL,'STEPHEN OUMA HAYO','792617321',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ174J'),(646,'MBA00725',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JOSIAH ALUKO LUKOYE','','',NULL,'JOSIAH ALUKO LUKOYE','714905849',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ375C'),(647,'MBA00726',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ELIUD MOYUNDO','','KIMOKOTI',NULL,'ELIUD MOYUNDO KIMOKOTI','254720897481',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP185V'),(648,'MBA00727',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'CORNELIUS KHAEMBA WESONGA ','','',NULL,'CORNELIUS KHAEMBA WESONGA ','707726058',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP228V'),(649,'MBA00728',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'PETER WANYONYI WEKESA','','',NULL,'PETER WANYONYI WEKESA','717796428',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ206L'),(650,'MBA00729',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'JOASH WEKESA NYONGESA','','',NULL,'JOASH WEKESA NYONGESA','741556111',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ280L'),(651,'MBA00730',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ANTONY WAWIRE AUGUSTINE','','',NULL,'ANTONY WAWIRE AUGUSTINE','703555085',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ345'),(652,'MBA00731',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ROMANS','WAFULA','MAKHANU',NULL,'ROMANS WAFULA MAKHANU','254715688976',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEQ202L'),(653,'MBA00732',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'FLORENCE','ADHIAMBO','OWUOR',NULL,'FLORENCE ADHIAMBO OWUOR','2547100141890',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEP225K'),(654,'TUKK00005',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'MOSES WANYOIKE','','WACHIRA',NULL,'MOSES WANYOIKE WACHIRA','254724261710',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(655,'TUKK00006',NULL,300,NULL,'2017-01-02','2017-01-01',1,NULL,NULL,'MARGARET WANJIRU','','',NULL,'MARGARET WANJIRU','726982725',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(656,'TUKK00007',NULL,300,NULL,'2017-01-02','2017-01-01',5,NULL,NULL,'ROSE KWAMBOKA','','',NULL,'ROSE KWAMBOKA','727382247',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(657,'TUKK00008',NULL,300,NULL,'2017-01-02','2017-01-01',48,NULL,NULL,'CHARLES OSEKO ONTEGI','','',NULL,'CHARLES OSEKO ONTEGI','728434464',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(658,'TUKK00009',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'NICHOLAS ODHIAMBO','','OCHIENG',NULL,'NICHOLAS ODHIAMBO OCHIENG','254714647864',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(659,'TUKK00010',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JOSEPH SAMBA SEDA','','',NULL,'JOSEPH SAMBA SEDA','799345059',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(660,'MBA00033',NULL,300,NULL,'2017-01-02','2017-01-01',27,NULL,NULL,'FRANCIS NDETI','','KIVUA',NULL,'FRANCIS NDETI KIVUA','254715419285',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH747K'),(661,'MBA00037',NULL,300,NULL,'2017-01-02','2017-01-01',23,NULL,NULL,'MICAHAEL WAEMA','','ZAKAYO',NULL,'MICAHAEL WAEMA ZAKAYO','254792865650',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEH317S'),(662,'MBA00081',NULL,300,NULL,'2017-01-02','2017-01-01',16,NULL,NULL,'JASON SEKA IMBAYA','','',NULL,'JASON SEKA IMBAYA','0715684673',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEJ112K'),(663,'MBA00118',NULL,300,NULL,'2017-01-02','2017-01-01',3,NULL,NULL,'CHEROTICH NANCY ','','',NULL,'CHEROTICH NANCY ','0715282553',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMEK220H'),(666,'000000666',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'JACKSON MUULINGE NDETI',NULL,'.',NULL,'JACKSON MUULINGE NDETI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(667,'000000667',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'JOSEPH WACHIRA',NULL,'.',NULL,'JOSEPH WACHIRA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(668,'000000668',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'ELIIUD KAMANJA',NULL,'.',NULL,'ELIIUD KAMANJA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(669,'000000669',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'DANIEL MWANGANGI KILONZI',NULL,'.',NULL,'DANIEL MWANGANGI KILONZI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(670,'000000670',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'ALEX MBITHI',NULL,'.',NULL,'ALEX MBITHI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(671,'000000671',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'WYCLIFF MANYARA NDAMA',NULL,'.',NULL,'WYCLIFF MANYARA NDAMA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(672,'000000672',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'FURAHA KATANA',NULL,'.',NULL,'FURAHA KATANA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(673,'000000673',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'ROSE WANJIRU LEGERICHO',NULL,'.',NULL,'ROSE WANJIRU LEGERICHO .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(674,'000000674',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'JOHN MWANGI',NULL,'.',NULL,'JOHN MWANGI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(675,'000000675',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'OMARI MAGWA',NULL,'.',NULL,'OMARI MAGWA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(676,'000000676',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'SAMSON BARAKA',NULL,'.',NULL,'SAMSON BARAKA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(677,'000000677',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'SAITOTI KITASHI',NULL,'.',NULL,'SAITOTI KITASHI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(678,'000000678',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'GODFREY MUGO',NULL,'.',NULL,'GODFREY MUGO .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(679,'000000679',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'MUTHUI GITONGA',NULL,'.',NULL,'MUTHUI GITONGA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(680,'000000680',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'RAPHAEL KATANA',NULL,'.',NULL,'RAPHAEL KATANA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(681,'000000681',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'JOSEPH NGUGI',NULL,'.',NULL,'JOSEPH NGUGI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(682,'000000682',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'DANIEL KAMAU',NULL,'.',NULL,'DANIEL KAMAU .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(683,'000000683',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'CRISPUS BARASA',NULL,'.',NULL,'CRISPUS BARASA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(684,'000000684',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'MWANZIA MULI',NULL,'.',NULL,'MWANZIA MULI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(685,'000000685',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'RICHARD KARISA',NULL,'.',NULL,'RICHARD KARISA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(686,'000000686',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'SALIM NZOMBO',NULL,'.',NULL,'SALIM NZOMBO .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(687,'000000687',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'EVANS WANJIRU',NULL,'.',NULL,'EVANS WANJIRU .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(688,'000000688',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'PETER MBUGUA',NULL,'.',NULL,'PETER MBUGUA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(689,'000000689',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'RAPHAEL KAPTUM',NULL,'.',NULL,'RAPHAEL KAPTUM .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(690,'000000690',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'JORAM NJERI',NULL,'.',NULL,'JORAM NJERI .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(691,'000000691',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'WILLIAM MUTUA',NULL,'.',NULL,'WILLIAM MUTUA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(692,'000000692',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'EDWIN SIMIYU MASINDE',NULL,'.',NULL,'EDWIN SIMIYU MASINDE .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(693,'000000693',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'ABUSHIRI ODHA',NULL,'.',NULL,'ABUSHIRI ODHA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(694,'000000694',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'MWERO JAWA',NULL,'.',NULL,'MWERO JAWA .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(695,'000000695',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'NICKSON BOSIKO',NULL,'.',NULL,'NICKSON BOSIKO .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(696,'000000696',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'AGNES TARAIYA Soila',NULL,'.',NULL,'AGNES TARAIYA Soila .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(697,'000000697',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Railways Group',NULL,'.',NULL,'Railways Group .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(698,'000000698',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Joseph Kinuthia',NULL,'.',NULL,'Joseph Kinuthia .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(699,'000000699',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Emmanuel Makanda',NULL,'.',NULL,'Emmanuel Makanda .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(700,'000000700',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'David Siakilo',NULL,'.',NULL,'David Siakilo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(701,'000000701',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Mercy Naliaka Wanjala',NULL,'.',NULL,'Mercy Naliaka Wanjala .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(702,'000000702',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Merciline Wanjala',NULL,'.',NULL,'Merciline Wanjala .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(703,'000000703',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Metrine Siminyu',NULL,'.',NULL,'Metrine Siminyu .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(704,'000000704',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Lucy Wasike',NULL,'.',NULL,'Lucy Wasike .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(705,'000000705',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Sichangi Benard',NULL,'.',NULL,'Sichangi Benard .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(706,'000000706',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Ezra Wanyonyi',NULL,'.',NULL,'Ezra Wanyonyi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(707,'000000707',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Martin Marani',NULL,'.',NULL,'Martin Marani .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(708,'000000708',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Dennis Echiki',NULL,'.',NULL,'Dennis Echiki .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(709,'000000709',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Catherine Chetambe',NULL,'.',NULL,'Catherine Chetambe .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(710,'000000710',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Gentrix Wanyonyi',NULL,'.',NULL,'Gentrix Wanyonyi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(711,'000000711',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Albert Momanyi',NULL,'.',NULL,'Albert Momanyi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(712,'000000712',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'John','Mogaka','Ontonyi',NULL,'John Mogaka Ontonyi','254700831112',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(713,'000000713',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Erick Omollo Sawe',NULL,'.',NULL,'Erick Omollo Sawe .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(714,'000000714',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Antony Mburu Maina',NULL,'.',NULL,'Antony Mburu Maina .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(715,'000000715',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Mary Kemunto Mukua',NULL,'.',NULL,'Mary Kemunto Mukua .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(716,'000000716',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Jared Abuya Isaiah',NULL,'.',NULL,'Jared Abuya Isaiah .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(717,'000000717',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Kasmil Onganga Onyiego',NULL,'.',NULL,'Kasmil Onganga Onyiego .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(718,'000000718',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Jared Mogambi Mose',NULL,'.',NULL,'Jared Mogambi Mose .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(719,'000000719',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Lewis Waweru',NULL,'.',NULL,'Lewis Waweru .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(720,'000000720',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Jacob Mauti Morema',NULL,'.',NULL,'Jacob Mauti Morema .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(721,'000000721',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Willmond Masiga',NULL,'.',NULL,'Willmond Masiga .',NULL,0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(722,'000000722',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Rael Kerubo Nyangau',NULL,'.',NULL,'Rael Kerubo Nyangau .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(723,'000000723',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'James Otieno Osir',NULL,'.',NULL,'James Otieno Osir .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(724,'000000724',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Evans Atandi',NULL,'.',NULL,'Evans Atandi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(725,'000000725',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Lavington Kibiba',NULL,'.',NULL,'Lavington Kibiba .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(726,'000000726',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Hilary Itela',NULL,'.',NULL,'Hilary Itela .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(727,'000000727',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Oscar Odhiambo(Vipul Patel)',NULL,'.',NULL,'Oscar Odhiambo(Vipul Patel) .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(728,'000000728',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Joel Omondi Amolo',NULL,'.',NULL,'Joel Omondi Amolo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(729,'000000729',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'David Omwenga Momanyi',NULL,'.',NULL,'David Omwenga Momanyi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(730,'000000730',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Jennifer Waigwa',NULL,'.',NULL,'Jennifer Waigwa .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(731,'000000731',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Antony Ruto Langat',NULL,'.',NULL,'Antony Ruto Langat .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(732,'000000732',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Benard Kibett Ngeno',NULL,'.',NULL,'Benard Kibett Ngeno .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(733,'000000733',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Benjamin Onsongo Montonu',NULL,'.',NULL,'Benjamin Onsongo Montonu .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(734,'000000734',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Jackson Sankare Mwatuni',NULL,'.',NULL,'Jackson Sankare Mwatuni .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(735,'000000735',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Clifford Mutuma',NULL,'.',NULL,'Clifford Mutuma .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(736,'000000736',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Alloyce Mwatela',NULL,'.',NULL,'Alloyce Mwatela .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(737,'000000737',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Lawrence Omondi',NULL,'.',NULL,'Lawrence Omondi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(738,'000000738',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Fredrick Angira',NULL,'.',NULL,'Fredrick Angira .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(739,'000000739',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'George Orege',NULL,'.',NULL,'George Orege .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(740,'000000740',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Peter Mwangi',NULL,'.',NULL,'Peter Mwangi .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(741,'000000741',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Edwin Odhiambo',NULL,'.',NULL,'Edwin Odhiambo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(742,'000000742',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Scholastica Waithera Gaitho',NULL,'.',NULL,'Scholastica Waithera Gaitho .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(743,'000000743',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Peter','Muthoni','.Njoroge',NULL,'Peter Muthoni .Njoroge','254721837919',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(744,'000000744',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Felix Wambogo',NULL,'.',NULL,'Felix Wambogo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(745,'000000745',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Samuel Onyancha',NULL,'.',NULL,'Samuel Onyancha .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(746,'000000746',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Erick Omondi Omollo',NULL,'.',NULL,'Erick Omondi Omollo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(747,'000000747',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Charles Githinji',NULL,'.',NULL,'Charles Githinji .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(748,'000000748',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Brian Owuor',NULL,'.',NULL,'Brian Owuor .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(749,'000000749',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Patrick M.Bakel Pena',NULL,'.',NULL,'Patrick M.Bakel Pena .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(750,'000000750',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Mercy Chepkirui',NULL,'.',NULL,'Mercy Chepkirui .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(751,'000000751',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Thomas','Onyach','Nyapondo',NULL,'Thomas Onyach Nyapondo','254791584177',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(752,'000000752',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Kevin',NULL,'Orinda',NULL,'Kevin Orinda','254714378803',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(753,'000000753',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'George',NULL,'Obunga',NULL,'George Obunga','254715282202',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(754,'000000754',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Bonface Okingo',NULL,'.',NULL,'Bonface Okingo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(755,'000000755',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Kennedy Ogalo',NULL,'.',NULL,'Kennedy Ogalo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(756,'000000756',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'John Ogero',NULL,'.',NULL,'John Ogero .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(757,'000000757',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Stephen Aloo',NULL,'.',NULL,'Stephen Aloo .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(758,'000000758',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Paul Otieno',NULL,'.',NULL,'Paul Otieno .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(759,'000000759',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Shadrack Orowe',NULL,'.',NULL,'Shadrack Orowe .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(760,'000000760',NULL,300,NULL,'2009-01-01','2009-01-01',1,NULL,1,'Patrick Shitanda',NULL,'.',NULL,'Patrick Shitanda .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(777,'000000777','0987654',600,NULL,'2019-03-22','2019-03-22',1,NULL,NULL,'test',NULL,'account',NULL,'test account','254713205648',0,NULL,NULL,NULL,18,'2019-03-28',1,'2019-03-22','2018-12-13',1,1,1,NULL,733,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-22',1,NULL,NULL,NULL,NULL,NULL,NULL),(778,'000000778','2125122366',300,NULL,'2018-12-13','2018-12-13',1,NULL,NULL,'Felgonah',NULL,'Oyuga',NULL,'Felgonah Oyuga','254727738347',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-12-13',1,1,NULL,NULL,734,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(782,'000000782',NULL,300,NULL,'2010-01-17','2018-12-18',49,NULL,NULL,'City',NULL,'Corporation',NULL,'City Corporation','723692961',0,17,'2017-01-01',NULL,NULL,NULL,NULL,NULL,'2010-01-17',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(785,'000000785',NULL,300,NULL,'2018-01-01','2018-01-01',3,NULL,NULL,'ONESMUS','CHERUYOIT','CHUMBA',NULL,'ONESMUS CHERUYOIT CHUMBA','254718064797',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(786,'000000786',NULL,300,NULL,'2018-01-01','2018-01-01',3,NULL,NULL,'DENIS',NULL,'CHEPKWONY',NULL,'DENIS CHEPKWONY','254712102654',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1815,'000001815',NULL,300,NULL,'2017-01-01','2017-01-01',1,NULL,1,'NYABICHA','SAMUEL','MOGAKA 1',NULL,'NYABICHA SAMUEL MOGAKA 1','254719395016',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1822,'000001822','MBA00340',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'LINET NAOMI',NULL,'.KUNDU',NULL,'LINET NAOMI .KUNDU','254702842016',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1414,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK060Z'),(1823,'000001823','MBA00170',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'JANE NJOKI GITAU',NULL,'.',NULL,'JANE NJOKI GITAU .','254728933557',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1415,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK 719W'),(1824,'000001824','MBA0002',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'ROBIN GICHINGA WANJIRU',NULL,'.',NULL,'ROBIN GICHINGA WANJIRU .','254795326014',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1416,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEE465A'),(1825,'000001825','MBA0004',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'MOSES MAINA',NULL,'.MUIRU',NULL,'MOSES MAINA .MUIRU','254723552745',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1417,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEE690M'),(1826,'000001826','MBA0005',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'FRANCIS',NULL,'ICHIMA',NULL,'FRANCIS ICHIMA','254707051879',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1418,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEF745S'),(1827,'000001827','MBA0006',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'Fredrick Muga',NULL,'.',NULL,'Fredrick Muga .','254706963158',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1419,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEF692S'),(1828,'000001828','MBA0007',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'PETER MUSEMBI MBINDA',NULL,'.',NULL,'PETER MUSEMBI MBINDA .','254705745000',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1420,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEE052Q'),(1829,'000001829','MBA0008',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'MICHAEL KAHORO',NULL,'.NJOROGE',NULL,'MICHAEL KAHORO .NJOROGE','254727561048',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1421,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEF092C'),(1830,'000001830','MBA0010',300,NULL,'2017-01-01','2017-01-01',23,NULL,NULL,'MWANGANGI',NULL,'MWOLOLO',NULL,'MWANGANGI MWOLOLO','254726904975',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1422,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEF216R'),(1831,'000001831','MBA0011',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'STEPHEN MBUGUA KAGWANJA',NULL,'.',NULL,'STEPHEN MBUGUA KAGWANJA .','254795869298',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1423,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEF690Y'),(1832,'000001832','MBA0012',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'TIMOTHY MWANGI NJOGU',NULL,'.',NULL,'TIMOTHY MWANGI NJOGU .','254716715552',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1424,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEE565W'),(1833,'000001833','MBA0013',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'JOSEPH KARONJI KINGORI',NULL,'.',NULL,'JOSEPH KARONJI KINGORI .','254728062132',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1425,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LRYPCK108HOA09741'),(1834,'000001834','MBA0015',300,NULL,'2017-01-01','2017-01-01',25,NULL,NULL,'AGNES WANJIKU MAINA',NULL,'.',NULL,'AGNES WANJIKU MAINA .','254728062177',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1426,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEG413R'),(1835,'000001835','MBA00025',300,NULL,'2017-01-01','2017-01-01',39,NULL,NULL,'JUSTUS','WANYAMA','.WANDAKI',NULL,'JUSTUS WANYAMA .WANDAKI','254702115399',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1427,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEG390N'),(1836,'000001836','MBA00026',300,NULL,'2017-01-01','2017-01-01',7,NULL,NULL,'0L00 PETER DANCUN',NULL,'.',NULL,'0L00 PETER DANCUN .','254718084999',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1428,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEH598M'),(1837,'000001837','MBA00028',300,NULL,'2017-01-01','2017-01-01',8,NULL,NULL,'ALEX MURE PATEL',NULL,'.',NULL,'ALEX MURE PATEL .','254721935080',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1429,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEH217S'),(1838,'000001838','MBA00030',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'STEPHEN','SALASH','KINARO',NULL,'STEPHEN SALASH KINARO','254717953447',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1430,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEH240B'),(1839,'000001839','MBA00032',300,NULL,'2017-01-01','2017-01-01',23,NULL,NULL,'JACQUILINE PETER',NULL,'.',NULL,'JACQUILINE PETER .','254728062123',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1431,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEH752K'),(1840,'000001840','MBA00034',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'JOSEPH MWANGI KIMANI',NULL,'.',NULL,'JOSEPH MWANGI KIMANI .','254719786193',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1432,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEH161S'),(1841,'000001841','MBA00035',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'JANE KINYUA',NULL,'.',NULL,'JANE KINYUA .','254724042359',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1433,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEM126H'),(1842,'000001842','MBA00036',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'DAVID NG\'ANG\'A GACHOHI',NULL,'.',NULL,'DAVID NG\'ANG\'A GACHOHI .','254728062111',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1434,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1843,'000001843','MBA00048',300,NULL,'2017-01-01','2017-01-01',8,NULL,NULL,'ISAIAH','SANDAMO','RIANTO.',NULL,'ISAIAH SANDAMO RIANTO.','254717555080',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1435,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEH891Z'),(1844,'000001844','MBA00058',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'ERICK KARIUKI MUTURIA',NULL,'.',NULL,'ERICK KARIUKI MUTURIA .','254717157363',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1436,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ691A'),(1845,'000001845','MBA00059',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'ISAAC MUGO',NULL,'.',NULL,'ISAAC MUGO .','254717413906',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1437,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ068E'),(1846,'000001846','MBA00065',300,NULL,'2017-01-01','2017-01-01',27,NULL,NULL,'MONICA MWENDE',NULL,'NZIVO',NULL,'MONICA MWENDE NZIVO','254715828800',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1438,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMDY925N'),(1847,'000001847','MBA00061',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'SAMUEL KAGIA NDUNGU',NULL,'.',NULL,'SAMUEL KAGIA NDUNGU .','254728062879',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1439,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ485M'),(1848,'000001848','MBA00063',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'DENNIS TIPAYA',NULL,'.MOSITE',NULL,'DENNIS TIPAYA .MOSITE','254726926517',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1440,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ221L'),(1849,'000001849','MBA00072',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'EZEKIEL SERPEPI LEISANKA',NULL,'.',NULL,'EZEKIEL SERPEPI LEISANKA .','2547180848878',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1441,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ922Q'),(1850,'000001850','MBA00089',300,NULL,'2017-01-01','2017-01-01',8,NULL,NULL,'PETER TUMPES OSEUR',NULL,'.',NULL,'PETER TUMPES OSEUR .','254728062099',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1442,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ464X'),(1851,'000001851','MBA00188',300,NULL,'2017-01-01','2017-01-01',1,NULL,NULL,'NYABICHA SAMUEL MOGAKA 1',NULL,'.',NULL,'NYABICHA SAMUEL MOGAKA 1 .','254728062011',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1443,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL477D'),(1852,'000001852','MBA00117',300,NULL,'2017-01-01','2017-01-01',27,NULL,NULL,'MARY KIILOKO KITAVI',NULL,'.',NULL,'MARY KIILOKO KITAVI .','254713521323',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1444,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ782X'),(1853,'000001853','MBA00131',300,NULL,'2017-01-01','2017-01-01',24,NULL,NULL,'RASHID KOMBO',NULL,'.',NULL,'RASHID KOMBO .','254722468591',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1445,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK284D'),(1854,'000001854','MBA00132',300,NULL,'2017-01-01','2017-01-01',16,NULL,NULL,'SAMSON ONYANGO',NULL,'.',NULL,'SAMSON ONYANGO .','254728062055',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1446,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK781R'),(1855,'000001855','MBA00158',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'ANN RUTH MUTHONI NJORO',NULL,'.',NULL,'ANN RUTH MUTHONI NJORO .','254728062059',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1447,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK834T'),(1856,'000001856','MBA00164',300,NULL,'2017-01-01','2017-01-01',15,NULL,NULL,'LYNETT AGLLA MANASI',NULL,'.',NULL,'LYNETT AGLLA MANASI .','254728062000',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1448,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ 499X'),(1857,'000001857','MBA00179',300,NULL,'2017-01-01','2017-01-01',16,NULL,NULL,'ELLY OKOTH OKUTA',NULL,'.',NULL,'ELLY OKOTH OKUTA .','254728062098',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1449,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL669G'),(1858,'000001858','MBA00183',300,NULL,'2017-01-01','2017-01-01',15,NULL,NULL,'WLIFRED SAGWE MORANGA',NULL,'.',NULL,'WLIFRED SAGWE MORANGA .','254728062058',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1450,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEA 715C'),(1859,'000001859','MBA00184',300,NULL,'2017-01-01','2017-01-01',16,NULL,NULL,'JANES OMONDI ODUOR',NULL,'.',NULL,'JANES OMONDI ODUOR .','254728062077',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1451,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK044E'),(1860,'000001860','MBA00187',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'JULIUS RUKOI OLE PARKIRE',NULL,'.',NULL,'JULIUS RUKOI OLE PARKIRE .','254728062067',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1452,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK691W'),(1861,'000001861','MBA00194',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'JOSHUA NYAGAKA',NULL,'.',NULL,'JOSHUA NYAGAKA .','254718084887',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1453,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK 457T'),(1862,'000001862','MBA00196',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'JOSEPH NYAKUNDI OKUNDI',NULL,'.',NULL,'JOSEPH NYAKUNDI OKUNDI .','254728062097',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1454,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK135T'),(1863,'000001863','MBA00204',300,NULL,'2017-01-01','2017-01-01',19,NULL,NULL,'RASHID WAFULA MULUPI',NULL,'.',NULL,'RASHID WAFULA MULUPI .','254728062080',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1455,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL566G'),(1864,'000001864','MBA00219',300,NULL,'2017-01-01','2017-01-01',37,NULL,NULL,'JANE KANINI MAINGI',NULL,'.',NULL,'JANE KANINI MAINGI .','254718084800',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1456,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEA410B'),(1865,'000001865','MBA00221',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'JOSEPH',NULL,'.CHACHA',NULL,'JOSEPH .CHACHA','254711950885',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1457,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK166T'),(1866,'000001866','MBA00234',300,NULL,'2017-01-01','2017-01-01',26,NULL,NULL,'EMANUEL MWITA MWITA',NULL,'.',NULL,'EMANUEL MWITA MWITA .','254712164416',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1458,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL731D'),(1867,'000001867','MBA00244',300,NULL,'2017-01-01','2017-01-01',16,NULL,NULL,'PETER ONGAA',NULL,'.',NULL,'PETER ONGAA .','254718084822',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1459,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL 032C'),(1868,'000001868','MBA00245',300,NULL,'2017-01-01','2017-01-01',6,NULL,NULL,'ROBERT OGLA BARSA',NULL,'.',NULL,'ROBERT OGLA BARSA .','254728062044',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1460,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL677M'),(1869,'000001869','MBA00248',300,NULL,'2017-01-01','2017-01-01',19,NULL,NULL,'MARK NAFUSI',NULL,'.',NULL,'MARK NAFUSI .','254728062045',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1461,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1870,'000001870','MBA00283',300,NULL,'2017-01-01','2017-01-01',19,NULL,NULL,'PROTUS BARASA NYONGESA',NULL,'.',NULL,'PROTUS BARASA NYONGESA .','254728062053',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1462,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL762S'),(1871,'000001871','MBA00295',300,NULL,'2017-01-01','2017-01-01',16,NULL,NULL,'PAUL OTIENO OSEWE',NULL,'.',NULL,'PAUL OTIENO OSEWE .','254728062068',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1463,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEJ 062W'),(1872,'000001872','MBA00311',300,NULL,'2017-01-01','2017-01-01',44,NULL,NULL,'BEATRICE AKINYI OMONDI',NULL,'.',NULL,'BEATRICE AKINYI OMONDI .','254718084848',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1464,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL944U'),(1873,'000001873','MBA00319',300,NULL,'2017-01-01','2017-01-01',14,NULL,NULL,'MOLINE AKINYI',NULL,'.ODHIAMBO',NULL,'MOLINE AKINYI .ODHIAMBO','254723720214',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1465,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL870R'),(1874,'000001874','MBA00320',300,NULL,'2017-01-01','2017-01-01',6,NULL,NULL,'CLIFF OCHIENG MILOWA',NULL,'.',NULL,'CLIFF OCHIENG MILOWA .','254728062065',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1466,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL 501J'),(1875,'000001875','MBA00322',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'KENNEDY WATULO NYONGESA',NULL,'.',NULL,'KENNEDY WATULO NYONGESA .','254718084885',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1467,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL899C'),(1876,'000001876','MBA00323',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'ANTONY SANGURA WANJALA',NULL,'.',NULL,'ANTONY SANGURA WANJALA .','254728062017',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1468,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL060D'),(1877,'000001877','MBA00324',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'JENTRIX NABWILE MUSERU',NULL,'.',NULL,'JENTRIX NABWILE MUSERU .','254718084829',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1469,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL072B'),(1878,'000001878','MBA00325',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'BENSON NANMANDU NAMWOSO',NULL,'.',NULL,'BENSON NANMANDU NAMWOSO .','254728062078',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1470,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL907G'),(1879,'000001879','MBA00328',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'DAVID MANYONGE',NULL,'.WESUTILA',NULL,'DAVID MANYONGE .WESUTILA','254701603119',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1471,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL082B'),(1880,'000001880','MBA00329',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'JARED WAMUCHWA',NULL,'MWASAME',NULL,'JARED WAMUCHWA MWASAME','254720459281',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1472,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL023B'),(1881,'000001881','MBA00330',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'RAMADHAN AMBONGO MAKOKHA',NULL,'.',NULL,'RAMADHAN AMBONGO MAKOKHA .','254728062088',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1473,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL072B'),(1882,'000001882','MBA00332',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'MARY NANYAMA WANAMBUKO',NULL,'.',NULL,'MARY NANYAMA WANAMBUKO .','254728062031',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1474,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL078B'),(1883,'000001883','MBA00333',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'TOBIAS MUKHWANA WANJALA',NULL,'.',NULL,'TOBIAS MUKHWANA WANJALA .','254718084879',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1475,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK980Y'),(1884,'000001884','MBA00334',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'OLIVER SHIDODE ANDEMBE',NULL,'.',NULL,'OLIVER SHIDODE ANDEMBE .','254718084882',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1476,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL047B'),(1885,'000001885','MBA00335',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'CLARE NEKESA SITATI',NULL,'.',NULL,'CLARE NEKESA SITATI .','254728062056',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1477,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL901G'),(1886,'000001886','MBA00336',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'LEAH NELIMA KUNDU',NULL,'.',NULL,'LEAH NELIMA KUNDU .','254728062095',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1478,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK060Z'),(1887,'000001887','MBA00337',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'ABRAHAM KHISA MAKOKHA',NULL,'.',NULL,'ABRAHAM KHISA MAKOKHA .','254728062027',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1479,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL089B'),(1888,'000001888','MBA00338',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'PETER WANABBUKO WEKESA',NULL,'.',NULL,'PETER WANABBUKO WEKESA .','254728062018',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1480,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL640G'),(1889,'000001889','MBA00472',300,NULL,'2017-01-01','2017-01-01',34,NULL,NULL,'MAGRET WAITHIRA MAZENGO',NULL,'.',NULL,'MAGRET WAITHIRA MAZENGO .','254728062043',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1481,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL275P'),(1890,'000001890','MBA00474',300,NULL,'2017-01-01','2017-01-01',5,NULL,NULL,'RAEL LUBANGO',NULL,'.',NULL,'RAEL LUBANGO .','254728062019',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1482,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL026D'),(1891,'000001891','MBA00539',300,NULL,'2017-01-01','2017-01-01',3,NULL,NULL,'WILSON CHEPKWONY SEGEM',NULL,'.',NULL,'WILSON CHEPKWONY SEGEM .','254728062026',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1483,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEM767J'),(1892,'000001892','MBA00625',300,NULL,'2017-01-01','2017-01-01',3,NULL,NULL,'KENNETH KIPKOECH KORIR',NULL,'.',NULL,'KENNETH KIPKOECH KORIR .','254718084891',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1484,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEP009M'),(1893,'000001893','MBA00733',300,NULL,'2017-01-01','2017-01-01',38,NULL,NULL,'FRANCIS','KINUTHIA','MWENDWA',NULL,'FRANCIS KINUTHIA MWENDWA','254791425150',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1485,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEP756X'),(1894,'000001894','MBA00741',300,NULL,'2017-01-01','2017-01-01',13,NULL,NULL,'BRITON SAFARI KATANA',NULL,'.',NULL,'BRITON SAFARI KATANA .','2546572386',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1486,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEN137S'),(1895,'000001895','MBA00742',300,NULL,'2017-01-01','2017-01-01',13,NULL,NULL,'REBECCA MNYAZI NGALE',NULL,'.',NULL,'REBECCA MNYAZI NGALE .','254728062025',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-01',1,1,NULL,NULL,1487,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,' KMEN007Y '),(1896,'000001896','MBS00735',300,NULL,'2018-01-01','2018-01-01',16,NULL,NULL,'KENNEDY OMONDI',NULL,'.',NULL,'KENNEDY OMONDI .','254728062020',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1488,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK781R'),(1897,'000001897','MBS00736',300,NULL,'2018-01-01','2018-01-01',16,NULL,NULL,'KEVIN ONYANGO',NULL,'.',NULL,'KEVIN ONYANGO .','254728062024',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1489,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEP310D'),(1898,'000001898','MBS00737',300,NULL,'2018-01-01','2018-01-01',16,NULL,NULL,'BONFAS OKINYI',NULL,'.',NULL,'BONFAS OKINYI .','254718084895',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1490,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEN576U'),(1899,'000001899','MBS00738',300,NULL,'2018-01-01','2018-01-01',16,NULL,NULL,'STEPHEN ALOO',NULL,'.',NULL,'STEPHEN ALOO .','254728062023',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1491,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK457T'),(1900,'000001900','MBS00739',300,NULL,'2018-01-01','2018-01-01',16,NULL,NULL,'THOMAS ONYACH',NULL,'.',NULL,'THOMAS ONYACH .','254728062021',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1492,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL944U'),(1901,'000001901','MBS00740',300,NULL,'2018-01-01','2018-01-01',16,NULL,NULL,'JOHN OGERO',NULL,'.',NULL,'JOHN OGERO .','254718084841',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1493,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL677M'),(1902,'000001902','MBS00743',300,NULL,'2018-01-01','2018-01-01',5,NULL,NULL,'KAREMA KAZUNGU KITSAO',NULL,'.',NULL,'KAREMA KAZUNGU KITSAO .','254718084889',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK815R'),(1903,'000001903','MBS00744',300,NULL,'2018-01-01','2018-01-01',3,NULL,NULL,'KEVIN NAMANGALA SIMIYU',NULL,'.',NULL,'KEVIN NAMANGALA SIMIYU .','254718084899',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1495,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL082B'),(1904,'000001904','MBS00745',300,NULL,'2018-01-01','2018-01-01',19,NULL,NULL,'GEOFFREY','KIPKOECH','.MUTAI',NULL,'GEOFFREY KIPKOECH .MUTAI','254711931450',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1496,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEM366A'),(1905,'000001905','MBS00746',300,NULL,'2018-01-01','2018-01-01',19,NULL,NULL,'PETER WASWA',NULL,'.',NULL,'PETER WASWA .','254718084898',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1497,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL835S'),(1906,'000001906','MBS00747',300,NULL,'2018-01-01','2018-01-01',19,NULL,NULL,'FRED','WEKESA','MUTONYI',NULL,'FRED WEKESA MUTONYI','254703258669',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1498,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL451K'),(1907,'000001907','MBS00748',300,NULL,'2018-01-01','2018-01-01',19,NULL,NULL,'JANET MULONGO',NULL,'.',NULL,'JANET MULONGO .',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1499,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEK987Y'),(1908,'000001908','MBS00749',300,NULL,'2018-01-01','2018-01-01',19,NULL,NULL,'ANNE MBONE',NULL,'.',NULL,'ANNE MBONE .','2547280620156',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL117D'),(1909,'000001909','MBS00750',300,NULL,'2018-01-01','2018-01-01',27,NULL,NULL,'KENNEDY NDHISI MAKAU',NULL,'.',NULL,'KENNEDY NDHISI MAKAU .','254728062022',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-01',1,1,NULL,NULL,1501,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KMEL566G'),(1915,'000001915','13688750',300,NULL,'2018-12-21','2018-12-21',1,NULL,NULL,'JANE',NULL,'.',NULL,'JANE .','254720662578',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-12-21',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1917,'000001917',NULL,300,NULL,'2019-01-04','2019-01-04',1,NULL,NULL,'FaithGichuru',NULL,'.',NULL,'FaithGichuru .','254728308658',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-04',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1918,'000001918',NULL,300,NULL,'2019-01-04','2019-01-04',1,NULL,NULL,'LoiseWachira',NULL,'.',NULL,'LoiseWachira .','254725769551',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-04',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1919,'000001919',NULL,300,NULL,'2019-01-04','2019-01-04',1,NULL,NULL,'Barnabaskahiu29346695',NULL,'.',NULL,'Barnabaskahiu29346695 .','254720324691',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-04',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1920,'000001920','78762',600,NULL,'2019-01-04','2019-01-04',1,NULL,NULL,'James','titus','waweru',NULL,'James titus waweru','07123065',0,16,'2018-12-31',NULL,18,'2019-01-04',NULL,NULL,'2019-01-04',1,1,1,NULL,1503,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1921,'000001921',NULL,300,NULL,'2019-01-04','2019-01-04',1,NULL,NULL,'REUBEN\nKIMANI',NULL,'.',NULL,'REUBEN\nKIMANI .','254722659426',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-04',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1923,'000001923',NULL,600,NULL,'2019-01-07','2019-01-07',1,NULL,NULL,'Test','Oryosa','Account',NULL,'Test Oryosa Account','254724379003',0,16,NULL,NULL,18,'2019-02-09',NULL,NULL,'2019-01-07',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1936,'000001936',NULL,300,NULL,'2019-03-05','2019-03-05',1,NULL,NULL,'Fred',NULL,'Test',NULL,'Fred Test','254722537798',0,NULL,NULL,NULL,NULL,NULL,1,'2019-03-05','2019-01-11',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-05',1,1,NULL,NULL,NULL,NULL,NULL),(1937,'000001937',NULL,300,NULL,'2019-01-11','2019-01-11',1,NULL,NULL,'Joseph','mbugua','karanja',NULL,'Joseph mbugua karanja','254721654125',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-11',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1938,'000001938',NULL,300,NULL,'2018-01-31','2018-01-31',1,NULL,NULL,'christine','naiputa','pose',NULL,'christine naiputa pose','254724234043',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-01-12',5,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1939,'000001939',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'samuel','murimi','murimi',NULL,'samuel murimi murimi','254705719080',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1940,'000001940',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'khadija','Rajab','rajab',NULL,'khadija Rajab rajab',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1941,'000001941',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'Benard','Rono','Rono',NULL,'Benard Rono Rono',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1942,'000001942',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'christopher',NULL,'walumbe',NULL,'christopher walumbe','254726548600',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1943,'000001943',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'ann',NULL,'kwena',NULL,'ann kwena','254741629540',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1944,'000001944',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'salesio',NULL,'njeru',NULL,'salesio njeru','254726425030',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1945,'000001945',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'norman',NULL,'macharia',NULL,'norman macharia','254726515362',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1946,'000001946',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'grace',NULL,'mwea',NULL,'grace mwea','254721730253',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1947,'000001947',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'stephen',NULL,'willy',NULL,'stephen willy','254796694074',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1948,'000001948',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'Joseph',NULL,'kingori',NULL,'Joseph kingori','254715484060',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1951,'000001951',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'gladys',NULL,'wanja',NULL,'gladys wanja','254791046165',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1952,'000001952',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'peter',NULL,'maina',NULL,'peter maina','254714849071',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1953,'000001953',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'alex',NULL,'nzyoki',NULL,'alex nzyoki','254717638977',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1954,'000001954',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'patrick',NULL,'kamau',NULL,'patrick kamau','254729474924',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1956,'000001956',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'moses',NULL,'mwangi',NULL,'moses mwangi','254715123048',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1957,'000001957',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'stephen',NULL,'karanja',NULL,'stephen karanja','254706404536',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1958,'000001958',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'peter',NULL,'mbinda',NULL,'peter mbinda','254718865827',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1959,'000001959',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'teresia',NULL,'wangai',NULL,'teresia wangai','254727872884',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1960,'000001960',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'marry',NULL,'wanjohi',NULL,'marry wanjohi','254799205919',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1961,'000001961',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'alice',NULL,'wangui',NULL,'alice wangui','254728262333',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1962,'000001962',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'justine',NULL,'ondieki',NULL,'justine ondieki','254729917966',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1964,'000001964',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'christopher',NULL,'gohole',NULL,'christopher gohole','254721885484',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1965,'000001965',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'jackson',NULL,'wote',NULL,'jackson wote','254721313962',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1966,'000001966',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'jane',NULL,'munyanbu',NULL,'jane munyanbu','254795777141',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1967,'000001967',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'nelson','kipkurui','koskei',NULL,'nelson kipkurui koskei','254722788216',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1968,'000001968',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'jacqueline',NULL,'peter',NULL,'jacqueline peter','254726123226',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1969,'000001969',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'evah',NULL,'kariuki',NULL,'evah kariuki','254716483885',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1970,'000001970',NULL,300,NULL,'2019-01-12','2019-01-12',1,NULL,NULL,'ruth',NULL,'mukima',NULL,'ruth mukima','254711464761',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-12',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1974,'000001974',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'anne',NULL,'wepukhulu',NULL,'anne wepukhulu','254796211143',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1975,'000001975',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'kennedy',NULL,'nyongesa',NULL,'kennedy nyongesa','254718362870',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1976,'000001976',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'isack','kibet','chirchir',NULL,'isack kibet chirchir','0708607433',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1977,'000001977',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'peter',NULL,'lekoris',NULL,'peter lekoris','254729302078',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1978,'000001978',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'vincent','cheruiyot','koech',NULL,'vincent cheruiyot koech','254716816782',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1979,'000001979',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'gideon',NULL,'nambasi',NULL,'gideon nambasi','254715350819',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1980,'000001980',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'jason',NULL,'okwema',NULL,'jason okwema','254716817471',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1981,'000001981',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'gilbert',NULL,'kirui',NULL,'gilbert kirui','254723408113',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1982,'000001982',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'boniface',NULL,'kingoo',NULL,'boniface kingoo','254706015314',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1983,'000001983',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'dancan','njuguna','mwangi',NULL,'dancan njuguna mwangi','0741882968',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1984,'000001984',NULL,100,NULL,NULL,NULL,1,NULL,NULL,'jacinta','mwende','john',NULL,'jacinta mwende john','254710940203',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1985,'000001985',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'francis',NULL,'omeno',NULL,'francis omeno','254796713829',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1986,'000001986',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'joyle',NULL,'nanyama',NULL,'joyle nanyama','254713251846',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1987,'000001987',NULL,100,NULL,NULL,NULL,1,NULL,NULL,'amos',NULL,'kiprotivh',NULL,'amos kiprotivh',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1988,'000001988',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'amos',NULL,'kiprotich',NULL,'amos kiprotich','254715873401',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1990,'000001990',NULL,600,NULL,NULL,NULL,1,NULL,NULL,'kipkorir','josphat','mutai',NULL,'kipkorir josphat mutai',NULL,0,NULL,NULL,NULL,18,'2019-01-22',NULL,NULL,'2019-01-14',5,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1991,'000001991',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'kipkorir','josphat','mutai',NULL,'kipkorir josphat mutai','254790635024',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1992,'000001992',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'nicholus','kipngetich','kirui',NULL,'nicholus kipngetich kirui','0797276576',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1993,'000001993',NULL,300,NULL,'2019-01-14','2019-01-14',1,NULL,NULL,'anthony',NULL,'mutisya',NULL,'anthony mutisya','254724009198',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-14',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1994,'000001994',NULL,300,NULL,'2019-01-15','2019-01-15',1,NULL,NULL,'ronald','nasuba','wanjala',NULL,'ronald nasuba wanjala','254721607485',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-15',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1995,'000001995',NULL,300,NULL,'2019-01-15','2019-01-15',1,NULL,NULL,'james',NULL,'matanta',NULL,'james matanta','254701890275',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-15',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1996,'000001996',NULL,300,NULL,'2019-01-15','2019-01-15',1,NULL,NULL,'magdaline',NULL,'ngeno',NULL,'magdaline ngeno','254724116374',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-15',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1997,'000001997',NULL,300,NULL,'2019-01-15','2019-01-15',1,NULL,NULL,'elixabeth',NULL,'gulenywa',NULL,'elixabeth gulenywa','254723051817',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-15',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2003,'000002003','27259261',600,NULL,NULL,NULL,1,NULL,NULL,'fredk',NULL,'.',NULL,'fredk .','254722537795',0,NULL,NULL,NULL,18,'2019-02-09',1,'2019-02-09','2009-03-04',1,NULL,1,1,NULL,NULL,NULL,15,'2019-02-09',1,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-09',1,NULL,NULL,NULL),(2005,'000002005','27259262',600,NULL,NULL,NULL,1,NULL,NULL,'Test Account',NULL,'Fred',NULL,'Test Account Fred','254722537793',0,NULL,NULL,NULL,18,'2019-02-09',NULL,NULL,'2009-03-04',1,NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2012,'000002012',NULL,100,NULL,NULL,NULL,1,NULL,NULL,'faidakaviha30017489',NULL,'.',NULL,'faidakaviha30017489 .','254711109136',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-24',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2013,'000002013',NULL,300,NULL,'2019-01-28','2019-01-28',1,NULL,NULL,'RASHIDBARISSA',NULL,'.',NULL,'RASHIDBARISSA .','254723283735',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-28',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2024,'000002024',NULL,600,NULL,'2019-03-26','2019-03-26',1,NULL,NULL,'CLIFFORD',NULL,'MASI',NULL,'CLIFFORD MASI','25471140111111111',0,NULL,NULL,NULL,18,'2019-03-28',1,'2019-03-26','2019-01-31',1,1,1,NULL,1536,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-26',1,NULL,NULL,NULL,NULL,NULL,NULL),(2030,'000002030',NULL,600,NULL,'2019-02-01','2019-02-01',50,NULL,NULL,'SAMMY',NULL,'KIMANI',NULL,'SAMMY KIMANI','254790511597',0,NULL,NULL,NULL,18,'2019-02-09',NULL,NULL,'2019-02-01',1,1,1,NULL,1539,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2031,'000002031',NULL,600,NULL,'2019-02-01','2019-02-01',50,NULL,NULL,'PETERSON',NULL,'IRERI',NULL,'PETERSON IRERI','254708529798',0,NULL,NULL,NULL,18,'2019-02-09',NULL,NULL,'2019-02-01',1,1,1,NULL,1540,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2032,'000002032','239115926',300,NULL,'2019-02-05','2019-02-05',1,NULL,NULL,'paul','kinyanjui','Gitau',NULL,'paul kinyanjui Gitau','0721443183',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-04',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2033,'000002033',NULL,300,NULL,'2019-02-05','2019-02-05',1,NULL,NULL,'Anthony',NULL,'Sikuku',NULL,'Anthony Sikuku','0706805602',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-04',5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2034,'000002034','11111111',600,NULL,'2019-02-05','2019-02-05',1,NULL,NULL,'Joshua',NULL,'Musembi',NULL,'Joshua Musembi','245700940111',0,16,NULL,NULL,18,'2019-02-09',NULL,NULL,'2019-02-05',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2036,'000002036',NULL,300,NULL,'2019-01-24','2019-01-24',50,NULL,NULL,'GEOFFREY',NULL,'MWALO OKWARO',NULL,'GEOFFREY MWALO OKWARO','254729059662',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-24',1,1,NULL,NULL,1541,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2037,'000002037',NULL,300,NULL,'2019-02-06','2019-02-06',50,NULL,NULL,'JAMES','MWAURA','NDICHU',NULL,'JAMES MWAURA NDICHU','254707181015',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-06',1,1,NULL,NULL,1542,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2038,'000002038',NULL,300,NULL,'2019-02-06','2019-02-06',50,NULL,5,'PAIMTO','MORE','MOTWILIN',NULL,'PAIMTO MORE MOTWILIN','254724347128',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-06',1,1,NULL,NULL,1543,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2039,'000002039',NULL,300,NULL,'2019-02-06','2019-02-06',50,NULL,NULL,'ANTONY',NULL,'WANYONYI',NULL,'ANTONY WANYONYI','254702693464',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-06',1,1,NULL,NULL,1544,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2040,'000002040',NULL,300,NULL,'2019-02-06','2019-02-06',50,NULL,NULL,'SAMUEL','KIFUE','WANJIKU',NULL,'SAMUEL KIFUE WANJIKU','254719261282',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-06',1,1,NULL,NULL,1545,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2041,'000002041',NULL,300,NULL,'2019-02-06','2019-02-06',50,NULL,NULL,'John',NULL,'Wangai',NULL,'John Wangai','254746328819',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-06',1,1,NULL,NULL,1546,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2042,'000002042',NULL,300,NULL,'2019-02-07','2019-02-07',50,NULL,NULL,'PAUL','KIMEU','MUTIA',NULL,'PAUL KIMEU MUTIA','254792696402',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-07',1,1,NULL,NULL,1547,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'KMED627T'),(2043,'000002043',NULL,300,NULL,'2019-02-08','2019-02-08',50,NULL,NULL,'THOMAS','MAINA','MUTHEU',NULL,'THOMAS MAINA MUTHEU','254714199571',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-08',1,1,NULL,NULL,1548,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2044,'000002044',NULL,300,NULL,'2019-02-08','2019-02-08',50,NULL,NULL,'PHILIP','OKOTH','WANDERA',NULL,'PHILIP OKOTH WANDERA','254795554696',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-08',1,1,NULL,NULL,1549,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2045,'000002045','786YYH7',100,NULL,NULL,NULL,1,NULL,NULL,'Petra',NULL,'Yton',NULL,'Petra Yton','0708529798',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-08',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2051,'000002051',NULL,300,NULL,'2019-02-08','2019-02-08',50,NULL,NULL,'JACKSON',NULL,'IRUNGU',NULL,'JACKSON IRUNGU','254728863570',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-08',1,1,NULL,NULL,1550,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2056,'000002056','30001185',600,NULL,NULL,NULL,1,NULL,NULL,'Peterson',NULL,'munene',NULL,'Peterson munene','0708520098',0,NULL,NULL,NULL,18,'2019-02-09',NULL,NULL,'2019-02-08',1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2060,'000002060',NULL,300,NULL,'2019-02-09','2019-02-09',50,NULL,NULL,'PIUS','MUTURI','MACHARIA',NULL,'PIUS MUTURI MACHARIA','254710305309',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-09',1,1,NULL,NULL,1551,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2061,'000002061',NULL,300,NULL,'2019-02-09','2019-02-09',50,NULL,NULL,'PETER','KARIUKI','MUTHONI',NULL,'PETER KARIUKI MUTHONI','254719165237',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-09',1,1,NULL,NULL,1552,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2062,'000002062',NULL,600,NULL,'2019-02-09','2019-02-09',1,NULL,NULL,'BENSON','KANGANGI','MBIRIRI',NULL,'BENSON KANGANGI MBIRIRI',NULL,0,16,NULL,NULL,18,'2019-02-12',NULL,NULL,'2019-02-09',10,10,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2064,'000002064',NULL,600,NULL,'2019-02-09','2019-02-09',1,NULL,NULL,'GEOFFREY','MWALO','OKWARO',NULL,'GEOFFREY MWALO OKWARO','0729059662',0,16,NULL,NULL,18,'2019-02-12',NULL,NULL,'2019-02-09',10,10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2065,'000002065',NULL,300,NULL,'2019-02-11','2019-02-11',50,NULL,NULL,'WILLIAM','NGUNJIRI','MUTHONI',NULL,'WILLIAM NGUNJIRI MUTHONI','254712846754',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-11',1,1,NULL,NULL,1553,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2066,'000002066',NULL,600,NULL,'2019-02-11','2019-02-11',1,NULL,NULL,'PETER','MWAMBORA','CHEGE',NULL,'PETER MWAMBORA CHEGE','0702736120',0,16,NULL,NULL,18,'2019-02-11',NULL,NULL,'2019-02-11',10,10,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2070,'000002070',NULL,300,NULL,'2019-04-12','2019-04-12',50,NULL,NULL,'CLIFFORD',NULL,'MASI',NULL,'CLIFFORD MASI','254711401187',0,NULL,NULL,NULL,NULL,NULL,1,'2019-04-12','2019-02-12',1,1,NULL,NULL,1554,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-12',1,NULL,NULL,NULL,NULL,NULL,NULL),(2071,'000002071',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,8,'ROBERT','OKONYO','JAORO',NULL,'ROBERT OKONYO JAORO','0799765320',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2072,'000002072',NULL,300,NULL,'2019-02-06','2019-02-06',50,NULL,5,'ANTHONY',NULL,'WANJALA',NULL,'ANTHONY WANJALA','0702693464',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-06',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2073,'000002073',NULL,600,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'PAUL','KIMEU','MUTIA',NULL,'PAUL KIMEU MUTIA','0792696402',0,16,NULL,NULL,18,'2019-02-12',NULL,NULL,'2019-02-12',10,10,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2074,'000002074',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'NOBERT','ODUORI','OPIYO',NULL,'NOBERT ODUORI OPIYO','0706583337',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2075,'000002075',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'PAUL','MUNIKA','LUSEKA',NULL,'PAUL MUNIKA LUSEKA','0795223279',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2076,'000002076',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'MBIRIRI','BENSON','KANGANGI',NULL,'MBIRIRI BENSON KANGANGI','0721588126',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2077,'000002077',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'NDAVI',NULL,'JOHN',NULL,'NDAVI JOHN','0703845192',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2078,'000002078',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'PETER','KAGIA','JORAM',NULL,'PETER KAGIA JORAM','0722983163',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2079,'000002079',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'PITALIS',NULL,'NYONGEZA',NULL,'PITALIS NYONGEZA','0727923814',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2080,'000002080',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'NICO',NULL,'WANYAMA',NULL,'NICO WANYAMA','254728752823',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',1,1,NULL,NULL,1555,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2081,'000002081',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'ERICK',NULL,'ABWAO',NULL,'ERICK ABWAO','254713815774',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',1,1,NULL,NULL,1556,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2082,'000002082',NULL,300,NULL,'2019-02-12','2019-02-12',50,NULL,NULL,'NAHASHON',NULL,'MWANGI',NULL,'NAHASHON MWANGI','254715218053',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-12',1,1,NULL,NULL,1557,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2083,'000002083',NULL,300,NULL,'2019-02-13','2019-02-13',50,NULL,NULL,'MOSES','NDERITU','GITONGA',NULL,'MOSES NDERITU GITONGA','0723703586',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-13',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2085,'000002085',NULL,600,NULL,'2019-02-13','2019-02-13',50,NULL,NULL,'BRENDA',NULL,'CHERAISI',NULL,'BRENDA CHERAISI','254717523866',0,NULL,NULL,NULL,18,'2019-02-14',NULL,NULL,'2019-02-13',1,1,10,NULL,1559,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2086,'000002086',NULL,300,NULL,'2019-02-13','2019-02-13',50,NULL,NULL,'FELIX','OWINO','OTIENO',NULL,'FELIX OWINO OTIENO','254710539622',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-13',1,1,NULL,NULL,1560,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2087,'000002087',NULL,300,NULL,'2019-02-13','2019-02-13',50,NULL,NULL,'PIUS',NULL,'NYOIKE NJOROGE',NULL,'PIUS NYOIKE NJOROGE','254721412891',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-13',1,1,NULL,NULL,1561,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2088,'000002088',NULL,300,NULL,'2019-02-13','2019-02-13',50,NULL,NULL,'JAMES','KIMANI','MWITHI',NULL,'JAMES KIMANI MWITHI','254724476268',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-13',1,1,NULL,NULL,1562,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2089,'000002089',NULL,300,NULL,'2019-02-14','2019-02-14',50,NULL,NULL,'DOMINIC','MUSYOKA','MUTUA',NULL,'DOMINIC MUSYOKA MUTUA','254713772551',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-14',1,1,NULL,NULL,1563,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2090,'000002090',NULL,300,NULL,'2019-02-15','2019-02-15',50,NULL,NULL,'BENJAMIN','KYALO','MUNYAO',NULL,'BENJAMIN KYALO MUNYAO','0741769831',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-15',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2091,'000002091',NULL,300,NULL,'2019-02-15','2019-02-15',50,NULL,NULL,'ANDRIANO',NULL,'MUTURI',NULL,'ANDRIANO MUTURI','254726909262',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-15',1,1,NULL,NULL,1565,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2092,'000002092',NULL,300,NULL,'2019-02-15','2019-02-15',50,NULL,NULL,'JOHN',NULL,'KIROGI',NULL,'JOHN KIROGI','254721477141',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-15',1,1,NULL,NULL,1567,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2093,'000002093',NULL,300,NULL,'2019-02-17','2019-02-17',50,NULL,NULL,'OMOSA',NULL,'MIRONGA',NULL,'OMOSA MIRONGA','254719387255',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-17',1,1,NULL,NULL,1568,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2094,'000002094',NULL,300,NULL,'2019-02-18','2019-02-18',50,NULL,NULL,'SAMUEL',NULL,'MAINA',NULL,'SAMUEL MAINA','254703489964',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-18',1,1,NULL,NULL,1569,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2095,'000002095',NULL,300,NULL,'2019-02-19','2019-02-19',50,NULL,5,'BRIAN','OTIENO','OUMA',NULL,'BRIAN OTIENO OUMA','254714776462',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-19',1,1,NULL,NULL,1570,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2096,'000002096',NULL,300,NULL,'2019-02-19','2019-02-19',50,NULL,NULL,'SAMSON',NULL,'KING\'EE',NULL,'SAMSON KING\'EE','254708920059',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-19',1,1,NULL,NULL,1571,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2097,'000002097',NULL,300,NULL,'2019-02-20','2019-02-20',1,NULL,NULL,'HillaryArina',NULL,'.',NULL,'HillaryArina .','254724705729',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-20',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2098,'000002098',NULL,300,NULL,'2019-02-21','2019-02-21',50,NULL,NULL,'NICODEMUS','KAMANJA','KIMANI',NULL,'NICODEMUS KAMANJA KIMANI','0713593477',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-01-24',10,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2099,'000002099',NULL,300,NULL,'2019-02-26','2019-02-26',50,NULL,5,'SAMSON','KARAU','KING\'EE',NULL,'SAMSON KARAU KING\'EE','0708920059',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-26',10,10,NULL,NULL,1577,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2100,'000002100',NULL,300,NULL,'2019-03-04','2019-03-04',50,NULL,NULL,'PETER',NULL,'MUTHONI',NULL,'PETER MUTHONI','254705017187',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-04',1,1,NULL,NULL,1578,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2101,'000002101',NULL,300,NULL,'2019-03-04','2019-03-04',50,NULL,NULL,'PETER',NULL,'NDICHU KAMAU',NULL,'PETER NDICHU KAMAU','254723569129',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-04',1,1,NULL,NULL,1579,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2102,'000002102',NULL,100,NULL,NULL,NULL,1,NULL,NULL,'JohnDoe',NULL,'.',NULL,'JohnDoe .','254722537792',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-05',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2103,'000002103',NULL,300,NULL,'2019-03-06','2019-03-06',1,NULL,NULL,'CharlesIreri',NULL,'.',NULL,'CharlesIreri .','254713615568',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-06',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2104,'000002104',NULL,300,NULL,'2019-03-07','2019-03-07',50,NULL,NULL,'BENEDICT',NULL,'KABIRU',NULL,'BENEDICT KABIRU','254710596137',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-07',1,1,NULL,NULL,1581,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2105,'000002105',NULL,300,NULL,'2019-03-09','2019-03-09',50,NULL,NULL,'FRANCIS',NULL,'ANDANJE',NULL,'FRANCIS ANDANJE','254726125431',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-09',1,1,NULL,NULL,1582,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2106,'000002106',NULL,300,NULL,'2019-03-16','2019-03-16',50,NULL,NULL,'NAHASON',NULL,'MWANGI',NULL,'NAHASON MWANGI','254726368217',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-16',1,1,NULL,NULL,1583,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2108,'000002108',NULL,300,NULL,'2019-03-19','2019-03-19',50,NULL,7,'DENNIS','WANJALA','BARASA',NULL,'DENNIS WANJALA BARASA','0711694225',0,16,'1970-01-01',NULL,NULL,NULL,NULL,NULL,'2019-03-19',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2109,'000002109',NULL,300,NULL,'2019-03-21','2019-03-21',50,NULL,NULL,'BENEDICT','MUTUIKE','KABIRU',NULL,'BENEDICT MUTUIKE KABIRU','0710596137',0,16,'1986-07-06',NULL,NULL,NULL,NULL,NULL,'2019-03-21',1,1,NULL,NULL,1585,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2110,'000002110',NULL,300,NULL,'2019-03-22','2019-03-22',50,NULL,7,'MICHAEL','OUMA','OPONDO',NULL,'MICHAEL OUMA OPONDO','254790173843',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-22',1,1,NULL,NULL,1586,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2113,'000002113',NULL,300,NULL,'2019-03-26','2019-03-26',50,NULL,NULL,'ANTHONY',NULL,'MAINA',NULL,'ANTHONY MAINA','254726790378',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-26',1,1,NULL,NULL,1587,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2114,'000002114',NULL,300,NULL,'2019-03-27','2019-03-27',50,NULL,8,'DANIEL','WAMATHAI','MUKAMI',NULL,'DANIEL WAMATHAI MUKAMI','254720750247',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-27',1,1,NULL,NULL,1589,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2115,'000002115',NULL,300,NULL,'2019-03-27','2019-03-27',50,NULL,8,'MOSES','MWANGI','NJUGUNA',NULL,'MOSES MWANGI NJUGUNA','254796764302',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-27',1,1,NULL,NULL,1590,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2116,'000002116',NULL,300,NULL,'2019-02-26','2019-02-26',50,NULL,8,'ISAIAH','GAKINYA','NGANGA',NULL,'ISAIAH GAKINYA NGANGA','254722281235',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-02-26',1,1,NULL,NULL,1591,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2117,'000002117',NULL,100,NULL,NULL,NULL,1,NULL,NULL,'john','mureithi','njoroge',NULL,'john mureithi njoroge',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-27',23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2118,'000002118',NULL,600,NULL,'2019-03-28','2019-03-28',50,NULL,NULL,'SAMMY',NULL,'KIMANI',NULL,'SAMMY KIMANI','254798362540',0,NULL,NULL,NULL,18,'2019-03-28',NULL,NULL,'2019-03-28',1,1,1,NULL,1592,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2119,'000002119',NULL,300,NULL,'2019-03-28','2019-03-28',50,NULL,NULL,'PITALIS',NULL,'NYONGESA',NULL,'PITALIS NYONGESA','254724923814',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-28',1,1,NULL,NULL,1593,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2120,'000002120',NULL,300,NULL,'2019-03-28','2019-03-28',50,NULL,NULL,'PATRICK',NULL,'KINYANJUI',NULL,'PATRICK KINYANJUI','254725268585',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-28',1,1,NULL,NULL,1594,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2121,'000002121',NULL,300,NULL,'2019-03-28','2019-03-28',50,NULL,6,'BENARD','OMBOGO','ONDERI',NULL,'BENARD OMBOGO ONDERI','254727654961',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-28',1,1,NULL,NULL,1595,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2122,'000002122',NULL,300,NULL,'2019-03-28','2019-03-28',50,NULL,6,'EUGENES','MARTIN','BARASA',NULL,'EUGENES MARTIN BARASA','712864798',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-28',5,5,NULL,NULL,1596,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2123,'000002123',NULL,300,NULL,'2019-03-28','2019-03-28',50,NULL,NULL,'KURIA',NULL,'MWANGI',NULL,'KURIA MWANGI','254714443843',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-28',1,1,NULL,NULL,1597,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2124,'000002124',NULL,300,NULL,'2019-03-28','2019-03-28',50,NULL,NULL,'Duncan',NULL,'Muriithi',NULL,'Duncan Muriithi','254758379866',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-28',1,1,NULL,NULL,1598,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2125,'000002125',NULL,100,NULL,NULL,NULL,1,NULL,NULL,'GladysWamaitha',NULL,'25114876',NULL,'GladysWamaitha 25114876','254729517093',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-29',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2126,'000002126',NULL,300,NULL,'2019-03-29','2019-03-29',1,NULL,NULL,'Gladyswamaitha',NULL,'25114876',NULL,'Gladyswamaitha 25114876','254721570568',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-29',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2127,'000002127',NULL,300,NULL,'2019-03-29','2019-03-29',50,NULL,NULL,'CHARLES','KINYUA','NJOKI',NULL,'CHARLES KINYUA NJOKI','254742440114',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-29',1,1,NULL,NULL,1600,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2128,'000002128',NULL,300,NULL,'2019-04-01','2019-04-01',50,NULL,NULL,'Oscar',NULL,'MUGAMI',NULL,'Oscar MUGAMI','254719704494',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-01',1,1,NULL,NULL,1601,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2129,'000002129',NULL,300,NULL,'2019-04-02','2019-04-02',50,NULL,6,'ELPHAS','SAZIRU','MUTANGE',NULL,'ELPHAS SAZIRU MUTANGE','0728052270',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-02',5,5,NULL,NULL,1602,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2130,'000002130',NULL,300,NULL,'2019-04-02','2019-04-02',50,NULL,6,'KEVIN','HAGAI','OUNDU',NULL,'KEVIN HAGAI OUNDU','254707079719',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-02',1,1,NULL,NULL,1603,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2131,'000002131',NULL,300,NULL,'2019-04-03','2019-04-03',50,NULL,NULL,'SIMON',NULL,'NGONYO',NULL,'SIMON NGONYO','254710112304',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-03',1,1,NULL,NULL,1604,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2132,'000002132',NULL,300,NULL,'2019-04-03','2019-04-03',50,NULL,NULL,'PATRICE',NULL,'NKURUNZIZA',NULL,'PATRICE NKURUNZIZA','254704915647',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-03',1,1,NULL,NULL,1605,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2133,'000002133',NULL,300,NULL,'2019-04-03','2019-04-03',50,NULL,6,'SILAS','OLUMBE','OLUOCH',NULL,'SILAS OLUMBE OLUOCH','254707663274',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-03',1,1,NULL,NULL,1606,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2134,'000002134',NULL,100,NULL,NULL,NULL,49,NULL,NULL,'jacob','zuma','zuma',NULL,'jacob zuma zuma','0720035090',0,16,'2019-02-25',NULL,NULL,NULL,NULL,NULL,'2019-04-04',18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2135,'000002135',NULL,300,NULL,'2019-04-04','2019-04-04',50,NULL,NULL,'MWANIKI',NULL,'KARURU',NULL,'MWANIKI KARURU','254711740263',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-04',1,1,NULL,NULL,1607,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2136,'000002136',NULL,300,NULL,'2019-04-04','2019-04-04',50,NULL,NULL,'EVANS',NULL,'MUSUNGU',NULL,'EVANS MUSUNGU','254729931505',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-04',1,1,NULL,NULL,1608,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2137,'000002137',NULL,300,NULL,'2019-04-05','2019-04-05',50,NULL,NULL,'JOHN',NULL,'OTWAL OTIENO',NULL,'JOHN OTWAL OTIENO','254729374688',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-05',1,1,NULL,NULL,1609,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2138,'000002138',NULL,300,NULL,'2019-04-07','2019-04-07',50,NULL,NULL,'EDWIN',NULL,'MATEKWA',NULL,'EDWIN MATEKWA','254725921753',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-07',1,1,NULL,NULL,1610,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2139,'000002139',NULL,300,NULL,'2019-04-08','2019-04-08',50,NULL,NULL,'KIRAINI',NULL,'LIPWAMA',NULL,'KIRAINI LIPWAMA','254729304411',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-08',1,1,NULL,NULL,1611,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2140,'000002140',NULL,300,NULL,'2019-04-08','2019-04-08',50,NULL,NULL,'SIMON',NULL,'NJUGUNA',NULL,'SIMON NJUGUNA','254721362046',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-08',1,1,NULL,NULL,1612,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2141,'000002141',NULL,300,NULL,'2019-04-09','2019-04-09',50,NULL,NULL,'BOAZ',NULL,'SIFUMA',NULL,'BOAZ SIFUMA','254723428223',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-09',1,1,NULL,NULL,1613,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2142,'000002142',NULL,300,NULL,'2019-04-09','2019-04-09',50,NULL,7,'PAUL','MUSAMBAI','LUSIOLA',NULL,'PAUL MUSAMBAI LUSIOLA','254707131558',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-09',1,1,NULL,NULL,1614,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2143,'000002143',NULL,300,NULL,'2019-04-10','2019-04-10',50,NULL,6,'PHILIP','ROMORU','HAYILA',NULL,'PHILIP ROMORU HAYILA','254723150373',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-10',1,1,NULL,NULL,1615,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2144,'000002144',NULL,300,NULL,'2019-04-12','2019-04-12',50,NULL,NULL,'JULIUS',NULL,'WANJIKU',NULL,'JULIUS WANJIKU','254710968293',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-12',1,1,NULL,NULL,1616,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2145,'000002145',NULL,300,NULL,'2019-04-15','2019-04-15',50,NULL,6,'ELIAS','SANANA','MOLLEL',NULL,'ELIAS SANANA MOLLEL','254722909941',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-15',1,1,NULL,NULL,1617,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2146,'000002146',NULL,300,NULL,'2019-04-18','2019-04-18',50,NULL,NULL,'OLIVER','KAMASI','KABENYI',NULL,'OLIVER KAMASI KABENYI','254724563150',0,16,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-18',1,1,NULL,NULL,1618,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(2147,'000002147',NULL,300,NULL,'2019-04-18','2019-04-18',50,NULL,NULL,'JOSEPH',NULL,'MAYUSI WASIKE',NULL,'JOSEPH MAYUSI WASIKE','254721218261',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-18',1,1,NULL,NULL,1619,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2148,'000002148',NULL,300,NULL,'2019-04-26','2019-04-26',50,NULL,NULL,'KENNETH',NULL,'MWANGI',NULL,'KENNETH MWANGI','254717376151',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-26',1,1,NULL,NULL,1621,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2149,'000002149',NULL,300,NULL,'2019-04-28','2019-04-28',50,NULL,NULL,'SIMON',NULL,'OBULUKU',NULL,'SIMON OBULUKU','254700202015',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-28',1,1,NULL,NULL,1622,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2150,'000002150',NULL,300,NULL,'2019-04-29','2019-04-29',50,NULL,NULL,'ESTHER',NULL,'UWAMAHORO',NULL,'ESTHER UWAMAHORO','254714115274',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-29',1,1,NULL,NULL,1623,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2151,'000002151',NULL,300,NULL,'2019-04-30','2019-04-30',50,NULL,NULL,'DOUGLAS',NULL,'OSORO',NULL,'DOUGLAS OSORO','254721338422',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-30',1,1,NULL,NULL,1626,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2152,'000002152',NULL,300,NULL,'2019-04-30','2019-04-30',50,NULL,NULL,'JOHN',NULL,'MWANGI',NULL,'JOHN MWANGI','254740808077',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-04-30',1,1,NULL,NULL,1627,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_address`
--

DROP TABLE IF EXISTS `m_client_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL DEFAULT '0',
  `address_id` bigint(20) NOT NULL DEFAULT '0',
  `address_type_id` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `addressIdFk` (`address_id`),
  KEY `address_codefk` (`address_type_id`),
  KEY `clientaddressfk` (`client_id`),
  CONSTRAINT `address_codefk` FOREIGN KEY (`address_type_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `clientaddressfk` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_address`
--

LOCK TABLES `m_client_address` WRITE;
/*!40000 ALTER TABLE `m_client_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_attendance`
--

DROP TABLE IF EXISTS `m_client_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_attendance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL DEFAULT '0',
  `meeting_id` bigint(20) NOT NULL,
  `attendance_type_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_client_meeting_attendance` (`client_id`,`meeting_id`),
  KEY `FK_m_meeting_m_client_attendance` (`meeting_id`),
  CONSTRAINT `FK_m_client_m_client_attendance` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_meeting_m_client_attendance` FOREIGN KEY (`meeting_id`) REFERENCES `m_meeting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_attendance`
--

LOCK TABLES `m_client_attendance` WRITE;
/*!40000 ALTER TABLE `m_client_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_charge`
--

DROP TABLE IF EXISTS `m_client_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_due_date` date DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL,
  `is_paid_derived` tinyint(1) DEFAULT NULL,
  `waived` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `inactivated_on_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_client_charge_m_client` (`client_id`),
  KEY `FK_m_client_charge_m_charge` (`charge_id`),
  CONSTRAINT `FK_m_client_charge_m_charge` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `FK_m_client_charge_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_charge`
--

LOCK TABLES `m_client_charge` WRITE;
/*!40000 ALTER TABLE `m_client_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_charge_paid_by`
--

DROP TABLE IF EXISTS `m_client_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_transaction_id` bigint(20) NOT NULL,
  `client_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_client_charge_paid_by_m_client_transaction` (`client_transaction_id`),
  KEY `FK_m_client_charge_paid_by_m_client_charge` (`client_charge_id`),
  CONSTRAINT `FK_m_client_charge_paid_by_m_client_charge` FOREIGN KEY (`client_charge_id`) REFERENCES `m_client_charge` (`id`),
  CONSTRAINT `FK_m_client_charge_paid_by_m_client_transaction` FOREIGN KEY (`client_transaction_id`) REFERENCES `m_client_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_charge_paid_by`
--

LOCK TABLES `m_client_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_client_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_identifier`
--

DROP TABLE IF EXISTS `m_client_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `document_key` varchar(50) NOT NULL,
  `status` int(5) NOT NULL DEFAULT '300',
  `active` int(5) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_identifier_key` (`document_type_id`,`document_key`),
  UNIQUE KEY `unique_active_client_identifier` (`client_id`,`document_type_id`,`active`),
  KEY `FK_m_client_document_m_client` (`client_id`),
  KEY `FK_m_client_document_m_code_value` (`document_type_id`),
  CONSTRAINT `FK_m_client_document_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_client_document_m_code_value` FOREIGN KEY (`document_type_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_identifier`
--

LOCK TABLES `m_client_identifier` WRITE;
/*!40000 ALTER TABLE `m_client_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_non_person`
--

DROP TABLE IF EXISTS `m_client_non_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_non_person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `constitution_cv_id` int(11) NOT NULL,
  `incorp_no` varchar(50) DEFAULT NULL,
  `incorp_validity_till` datetime DEFAULT NULL,
  `main_business_line_cv_id` int(11) DEFAULT NULL,
  `remarks` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_non_person`
--

LOCK TABLES `m_client_non_person` WRITE;
/*!40000 ALTER TABLE `m_client_non_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_non_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_transaction`
--

DROP TABLE IF EXISTS `m_client_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `external_id` varchar(50) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `created_date` datetime NOT NULL,
  `appuser_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `FK_m_client_transaction_m_client` (`client_id`),
  KEY `FK_m_client_transaction_m_appuser` (`appuser_id`),
  CONSTRAINT `FK_m_client_transaction_m_appuser` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_client_transaction_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_transaction`
--

LOCK TABLES `m_client_transaction` WRITE;
/*!40000 ALTER TABLE `m_client_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_transfer_details`
--

DROP TABLE IF EXISTS `m_client_transfer_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_transfer_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `from_office_id` bigint(20) NOT NULL,
  `to_office_id` bigint(20) NOT NULL,
  `proposed_transfer_date` date DEFAULT NULL,
  `transfer_type` tinyint(2) NOT NULL,
  `submitted_on` date NOT NULL,
  `submitted_by` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_client_transfer_details_m_client` (`client_id`),
  KEY `FK_m_client_transfer_details_m_office` (`from_office_id`),
  KEY `FK_m_client_transfer_details_m_office_2` (`to_office_id`),
  KEY `FK_m_client_transfer_details_m_appuser` (`submitted_by`),
  CONSTRAINT `FK_m_client_transfer_details_m_appuser` FOREIGN KEY (`submitted_by`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_client_transfer_details_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_client_transfer_details_m_office` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_client_transfer_details_m_office_2` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_transfer_details`
--

LOCK TABLES `m_client_transfer_details` WRITE;
/*!40000 ALTER TABLE `m_client_transfer_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_transfer_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code`
--

DROP TABLE IF EXISTS `m_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(100) DEFAULT NULL,
  `is_system_defined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_name` (`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code`
--

LOCK TABLES `m_code` WRITE;
/*!40000 ALTER TABLE `m_code` DISABLE KEYS */;
INSERT INTO `m_code` VALUES (1,'Customer Identifier',1),(2,'LoanCollateral',1),(3,'LoanPurpose',1),(4,'Gender',1),(5,'YesNo',1),(6,'GuarantorRelationship',1),(7,'AssetAccountTags',1),(8,'LiabilityAccountTags',1),(9,'EquityAccountTags',1),(10,'IncomeAccountTags',1),(11,'ExpenseAccountTags',1),(13,'GROUPROLE',1),(14,'ClientClosureReason',1),(15,'GroupClosureReason',1),(16,'ClientType',1),(17,'ClientClassification',1),(18,'ClientSubStatus',1),(19,'ClientRejectReason',1),(20,'ClientWithdrawReason',1),(21,'Entity to Entity Access Types',1),(22,'CenterClosureReason',1),(23,'LoanRescheduleReason',1),(24,'Constitution',1),(25,'Main Business Line',1),(26,'WriteOffReasons',1),(27,'STATE',1),(28,'COUNTRY',1),(29,'ADDRESS_TYPE',1),(30,'MARITAL STATUS',1),(31,'RELATIONSHIP',1),(32,'PROFESSION',1);
/*!40000 ALTER TABLE `m_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code_value`
--

DROP TABLE IF EXISTS `m_code_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL,
  `code_value` varchar(100) DEFAULT NULL,
  `code_description` varchar(500) DEFAULT NULL,
  `order_position` int(11) NOT NULL DEFAULT '0',
  `code_score` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_mandatory` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_value` (`code_id`,`code_value`),
  KEY `FKCFCEA42640BE071Z` (`code_id`),
  CONSTRAINT `FKCFCEA42640BE071Z` FOREIGN KEY (`code_id`) REFERENCES `m_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code_value`
--

LOCK TABLES `m_code_value` WRITE;
/*!40000 ALTER TABLE `m_code_value` DISABLE KEYS */;
INSERT INTO `m_code_value` VALUES (1,1,'Passport',NULL,1,NULL,1,0),(2,1,'Id',NULL,2,NULL,1,0),(3,1,'Drivers License',NULL,3,NULL,1,0),(4,1,'Any Other Id Type',NULL,4,NULL,1,0),(5,6,'Spouse',NULL,0,NULL,1,0),(6,6,'Parent',NULL,0,NULL,1,0),(7,6,'Sibling',NULL,0,NULL,1,0),(8,6,'Business Associate',NULL,0,NULL,1,0),(9,6,'Other',NULL,0,NULL,1,0),(10,21,'Office Access to Loan Products',NULL,0,NULL,1,0),(11,21,'Office Access to Savings Products',NULL,0,NULL,1,0),(12,21,'Office Access to Fees/Charges',NULL,0,NULL,1,0),(13,13,'Leader','Group Leader Role',1,NULL,1,0),(14,20,'I2I','',0,NULL,1,0),(15,19,'75A','',0,NULL,1,0),(16,4,'male','MALE',1,NULL,1,0),(17,4,'female','FEMALE',2,NULL,1,0),(18,14,'Wrong Client Details','',1,NULL,1,0),(19,14,'Withdrawal','',2,NULL,1,0),(21,17,'Married','Married',1,NULL,1,0),(22,17,'Single','Single',3,NULL,1,0),(23,17,'Others','Others',2,NULL,1,0),(24,16,'Citizen','Citizen',1,NULL,1,0),(25,16,'Foreigner','Foreigner',2,NULL,1,0);
/*!40000 ALTER TABLE `m_code_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_creditbureau`
--

DROP TABLE IF EXISTS `m_creditbureau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_creditbureau` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `product` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `implementationKey` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique impl` (`name`,`product`,`country`,`implementationKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_creditbureau`
--

LOCK TABLES `m_creditbureau` WRITE;
/*!40000 ALTER TABLE `m_creditbureau` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_creditbureau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_creditbureau_configuration`
--

DROP TABLE IF EXISTS `m_creditbureau_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_creditbureau_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `configkey` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `organisation_creditbureau_id` bigint(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mcbconfig` (`configkey`,`organisation_creditbureau_id`),
  KEY `cbConfigfk1` (`organisation_creditbureau_id`),
  CONSTRAINT `cbConfigfk1` FOREIGN KEY (`organisation_creditbureau_id`) REFERENCES `m_organisation_creditbureau` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_creditbureau_configuration`
--

LOCK TABLES `m_creditbureau_configuration` WRITE;
/*!40000 ALTER TABLE `m_creditbureau_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_creditbureau_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_creditbureau_loanproduct_mapping`
--

DROP TABLE IF EXISTS `m_creditbureau_loanproduct_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_creditbureau_loanproduct_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organisation_creditbureau_id` bigint(20) NOT NULL,
  `loan_product_id` bigint(20) NOT NULL,
  `is_creditcheck_mandatory` tinyint(1) DEFAULT NULL,
  `skip_creditcheck_in_failure` tinyint(1) DEFAULT NULL,
  `stale_period` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cblpunique_key` (`organisation_creditbureau_id`,`loan_product_id`),
  KEY `fk_cb_lp2` (`loan_product_id`),
  CONSTRAINT `cblpfk2` FOREIGN KEY (`organisation_creditbureau_id`) REFERENCES `m_organisation_creditbureau` (`id`),
  CONSTRAINT `fk_cb_lp2` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_creditbureau_loanproduct_mapping`
--

LOCK TABLES `m_creditbureau_loanproduct_mapping` WRITE;
/*!40000 ALTER TABLE `m_creditbureau_loanproduct_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_creditbureau_loanproduct_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_currency`
--

DROP TABLE IF EXISTS `m_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_currency`
--

LOCK TABLES `m_currency` WRITE;
/*!40000 ALTER TABLE `m_currency` DISABLE KEYS */;
INSERT INTO `m_currency` VALUES (1,'AED',2,NULL,NULL,'UAE Dirham','currency.AED'),(2,'AFN',2,NULL,NULL,'Afghanistan Afghani','currency.AFN'),(3,'ALL',2,NULL,NULL,'Albanian Lek','currency.ALL'),(4,'AMD',2,NULL,NULL,'Armenian Dram','currency.AMD'),(5,'ANG',2,NULL,NULL,'Netherlands Antillian Guilder','currency.ANG'),(6,'AOA',2,NULL,NULL,'Angolan Kwanza','currency.AOA'),(7,'ARS',2,NULL,'$','Argentine Peso','currency.ARS'),(8,'AUD',2,NULL,'A$','Australian Dollar','currency.AUD'),(9,'AWG',2,NULL,NULL,'Aruban Guilder','currency.AWG'),(10,'AZM',2,NULL,NULL,'Azerbaijanian Manat','currency.AZM'),(11,'BAM',2,NULL,NULL,'Bosnia and Herzegovina Convertible Marks','currency.BAM'),(12,'BBD',2,NULL,NULL,'Barbados Dollar','currency.BBD'),(13,'BDT',2,NULL,NULL,'Bangladesh Taka','currency.BDT'),(14,'BGN',2,NULL,NULL,'Bulgarian Lev','currency.BGN'),(15,'BHD',3,NULL,NULL,'Bahraini Dinar','currency.BHD'),(16,'BIF',0,NULL,NULL,'Burundi Franc','currency.BIF'),(17,'BMD',2,NULL,NULL,'Bermudian Dollar','currency.BMD'),(18,'BND',2,NULL,'B$','Brunei Dollar','currency.BND'),(19,'BOB',2,NULL,'Bs.','Bolivian Boliviano','currency.BOB'),(20,'BRL',2,NULL,'R$','Brazilian Real','currency.BRL'),(21,'BSD',2,NULL,NULL,'Bahamian Dollar','currency.BSD'),(22,'BTN',2,NULL,NULL,'Bhutan Ngultrum','currency.BTN'),(23,'BWP',2,NULL,NULL,'Botswana Pula','currency.BWP'),(24,'BYR',0,NULL,NULL,'Belarussian Ruble','currency.BYR'),(25,'BZD',2,NULL,'BZ$','Belize Dollar','currency.BZD'),(26,'CAD',2,NULL,NULL,'Canadian Dollar','currency.CAD'),(27,'CDF',2,NULL,NULL,'Franc Congolais','currency.CDF'),(28,'CHF',2,NULL,NULL,'Swiss Franc','currency.CHF'),(29,'CLP',0,NULL,'$','Chilean Peso','currency.CLP'),(30,'CNY',2,NULL,NULL,'Chinese Yuan Renminbi','currency.CNY'),(31,'COP',2,NULL,'$','Colombian Peso','currency.COP'),(32,'CRC',2,NULL,'₡','Costa Rican Colon','currency.CRC'),(33,'CSD',2,NULL,NULL,'Serbian Dinar','currency.CSD'),(34,'CUP',2,NULL,'$MN','Cuban Peso','currency.CUP'),(35,'CVE',2,NULL,NULL,'Cape Verde Escudo','currency.CVE'),(36,'CYP',2,NULL,NULL,'Cyprus Pound','currency.CYP'),(37,'CZK',2,NULL,NULL,'Czech Koruna','currency.CZK'),(38,'DJF',0,NULL,NULL,'Djibouti Franc','currency.DJF'),(39,'DKK',2,NULL,NULL,'Danish Krone','currency.DKK'),(40,'DOP',2,NULL,'RD$','Dominican Peso','currency.DOP'),(41,'DZD',2,NULL,NULL,'Algerian Dinar','currency.DZD'),(42,'EEK',2,NULL,NULL,'Estonian Kroon','currency.EEK'),(43,'EGP',2,NULL,NULL,'Egyptian Pound','currency.EGP'),(44,'ERN',2,NULL,NULL,'Eritrea Nafka','currency.ERN'),(45,'ETB',2,NULL,NULL,'Ethiopian Birr','currency.ETB'),(46,'EUR',2,NULL,'€','Euro','currency.EUR'),(47,'FJD',2,NULL,NULL,'Fiji Dollar','currency.FJD'),(48,'FKP',2,NULL,NULL,'Falkland Islands Pound','currency.FKP'),(49,'GBP',2,NULL,NULL,'Pound Sterling','currency.GBP'),(50,'GEL',2,NULL,NULL,'Georgian Lari','currency.GEL'),(51,'GHC',2,NULL,'GHc','Ghana Cedi','currency.GHC'),(52,'GIP',2,NULL,NULL,'Gibraltar Pound','currency.GIP'),(53,'GMD',2,NULL,NULL,'Gambian Dalasi','currency.GMD'),(54,'GNF',0,NULL,NULL,'Guinea Franc','currency.GNF'),(55,'GTQ',2,NULL,'Q','Guatemala Quetzal','currency.GTQ'),(56,'GYD',2,NULL,NULL,'Guyana Dollar','currency.GYD'),(57,'HKD',2,NULL,NULL,'Hong Kong Dollar','currency.HKD'),(58,'HNL',2,NULL,'L','Honduras Lempira','currency.HNL'),(59,'HRK',2,NULL,NULL,'Croatian Kuna','currency.HRK'),(60,'HTG',2,NULL,'G','Haiti Gourde','currency.HTG'),(61,'HUF',2,NULL,NULL,'Hungarian Forint','currency.HUF'),(62,'IDR',2,NULL,NULL,'Indonesian Rupiah','currency.IDR'),(63,'ILS',2,NULL,NULL,'New Israeli Shekel','currency.ILS'),(64,'INR',2,NULL,'₹','Indian Rupee','currency.INR'),(65,'IQD',3,NULL,NULL,'Iraqi Dinar','currency.IQD'),(66,'IRR',2,NULL,NULL,'Iranian Rial','currency.IRR'),(67,'ISK',0,NULL,NULL,'Iceland Krona','currency.ISK'),(68,'JMD',2,NULL,NULL,'Jamaican Dollar','currency.JMD'),(69,'JOD',3,NULL,NULL,'Jordanian Dinar','currency.JOD'),(70,'JPY',0,NULL,NULL,'Japanese Yen','currency.JPY'),(71,'KES',2,NULL,'KSh','Kenyan Shilling','currency.KES'),(72,'KGS',2,NULL,NULL,'Kyrgyzstan Som','currency.KGS'),(73,'KHR',2,NULL,NULL,'Cambodia Riel','currency.KHR'),(74,'KMF',0,NULL,NULL,'Comoro Franc','currency.KMF'),(75,'KPW',2,NULL,NULL,'North Korean Won','currency.KPW'),(76,'KRW',0,NULL,NULL,'Korean Won','currency.KRW'),(77,'KWD',3,NULL,NULL,'Kuwaiti Dinar','currency.KWD'),(78,'KYD',2,NULL,NULL,'Cayman Islands Dollar','currency.KYD'),(79,'KZT',2,NULL,NULL,'Kazakhstan Tenge','currency.KZT'),(80,'LAK',2,NULL,NULL,'Lao Kip','currency.LAK'),(81,'LBP',2,NULL,'L£','Lebanese Pound','currency.LBP'),(82,'LKR',2,NULL,NULL,'Sri Lanka Rupee','currency.LKR'),(83,'LRD',2,NULL,NULL,'Liberian Dollar','currency.LRD'),(84,'LSL',2,NULL,NULL,'Lesotho Loti','currency.LSL'),(85,'LTL',2,NULL,NULL,'Lithuanian Litas','currency.LTL'),(86,'LVL',2,NULL,NULL,'Latvian Lats','currency.LVL'),(87,'LYD',3,NULL,NULL,'Libyan Dinar','currency.LYD'),(88,'MAD',2,NULL,NULL,'Moroccan Dirham','currency.MAD'),(89,'MDL',2,NULL,NULL,'Moldovan Leu','currency.MDL'),(90,'MGA',2,NULL,NULL,'Malagasy Ariary','currency.MGA'),(91,'MKD',2,NULL,NULL,'Macedonian Denar','currency.MKD'),(92,'MMK',2,NULL,'K','Myanmar Kyat','currency.MMK'),(93,'MNT',2,NULL,NULL,'Mongolian Tugrik','currency.MNT'),(94,'MOP',2,NULL,NULL,'Macau Pataca','currency.MOP'),(95,'MRO',2,NULL,NULL,'Mauritania Ouguiya','currency.MRO'),(96,'MTL',2,NULL,NULL,'Maltese Lira','currency.MTL'),(97,'MUR',2,NULL,NULL,'Mauritius Rupee','currency.MUR'),(98,'MVR',2,NULL,NULL,'Maldives Rufiyaa','currency.MVR'),(99,'MWK',2,NULL,NULL,'Malawi Kwacha','currency.MWK'),(100,'MXN',2,NULL,'$','Mexican Peso','currency.MXN'),(101,'MYR',2,NULL,NULL,'Malaysian Ringgit','currency.MYR'),(102,'MZM',2,NULL,NULL,'Mozambique Metical','currency.MZM'),(103,'NAD',2,NULL,NULL,'Namibia Dollar','currency.NAD'),(104,'NGN',2,NULL,NULL,'Nigerian Naira','currency.NGN'),(105,'NIO',2,NULL,'C$','Nicaragua Cordoba Oro','currency.NIO'),(106,'NOK',2,NULL,NULL,'Norwegian Krone','currency.NOK'),(107,'NPR',2,NULL,NULL,'Nepalese Rupee','currency.NPR'),(108,'NZD',2,NULL,NULL,'New Zealand Dollar','currency.NZD'),(109,'OMR',3,NULL,NULL,'Rial Omani','currency.OMR'),(110,'PAB',2,NULL,'B/.','Panama Balboa','currency.PAB'),(111,'PEN',2,NULL,'S/.','Peruvian Nuevo Sol','currency.PEN'),(112,'PGK',2,NULL,NULL,'Papua New Guinea Kina','currency.PGK'),(113,'PHP',2,NULL,NULL,'Philippine Peso','currency.PHP'),(114,'PKR',2,NULL,NULL,'Pakistan Rupee','currency.PKR'),(115,'PLN',2,NULL,NULL,'Polish Zloty','currency.PLN'),(116,'PYG',0,NULL,'₲','Paraguayan Guarani','currency.PYG'),(117,'QAR',2,NULL,NULL,'Qatari Rial','currency.QAR'),(118,'RON',2,NULL,NULL,'Romanian Leu','currency.RON'),(119,'RUB',2,NULL,NULL,'Russian Ruble','currency.RUB'),(120,'RWF',0,NULL,NULL,'Rwanda Franc','currency.RWF'),(121,'SAR',2,NULL,NULL,'Saudi Riyal','currency.SAR'),(122,'SBD',2,NULL,NULL,'Solomon Islands Dollar','currency.SBD'),(123,'SCR',2,NULL,NULL,'Seychelles Rupee','currency.SCR'),(124,'SDD',2,NULL,NULL,'Sudanese Dinar','currency.SDD'),(125,'SEK',2,NULL,NULL,'Swedish Krona','currency.SEK'),(126,'SGD',2,NULL,NULL,'Singapore Dollar','currency.SGD'),(127,'SHP',2,NULL,NULL,'St Helena Pound','currency.SHP'),(128,'SIT',2,NULL,NULL,'Slovenian Tolar','currency.SIT'),(129,'SKK',2,NULL,NULL,'Slovak Koruna','currency.SKK'),(130,'SLL',2,NULL,NULL,'Sierra Leone Leone','currency.SLL'),(131,'SOS',2,NULL,NULL,'Somali Shilling','currency.SOS'),(132,'SRD',2,NULL,NULL,'Surinam Dollar','currency.SRD'),(133,'STD',2,NULL,NULL,'Sao Tome and Principe Dobra','currency.STD'),(134,'SVC',2,NULL,NULL,'El Salvador Colon','currency.SVC'),(135,'SYP',2,NULL,NULL,'Syrian Pound','currency.SYP'),(136,'SZL',2,NULL,NULL,'Swaziland Lilangeni','currency.SZL'),(137,'THB',2,NULL,NULL,'Thai Baht','currency.THB'),(138,'TJS',2,NULL,NULL,'Tajik Somoni','currency.TJS'),(139,'TMM',2,NULL,NULL,'Turkmenistan Manat','currency.TMM'),(140,'TND',3,NULL,'DT','Tunisian Dinar','currency.TND'),(141,'TOP',2,NULL,NULL,'Tonga Pa\'anga','currency.TOP'),(142,'TRY',2,NULL,NULL,'Turkish Lira','currency.TRY'),(143,'TTD',2,NULL,NULL,'Trinidad and Tobago Dollar','currency.TTD'),(144,'TWD',2,NULL,NULL,'New Taiwan Dollar','currency.TWD'),(145,'TZS',2,NULL,NULL,'Tanzanian Shilling','currency.TZS'),(146,'UAH',2,NULL,NULL,'Ukraine Hryvnia','currency.UAH'),(147,'UGX',2,NULL,'USh','Uganda Shilling','currency.UGX'),(148,'USD',2,NULL,'$','US Dollar','currency.USD'),(149,'UYU',2,NULL,'$U','Peso Uruguayo','currency.UYU'),(150,'UZS',2,NULL,NULL,'Uzbekistan Sum','currency.UZS'),(151,'VEB',2,NULL,'Bs.F.','Venezuelan Bolivar','currency.VEB'),(152,'VND',2,NULL,NULL,'Vietnamese Dong','currency.VND'),(153,'VUV',0,NULL,NULL,'Vanuatu Vatu','currency.VUV'),(154,'WST',2,NULL,NULL,'Samoa Tala','currency.WST'),(155,'XAF',0,NULL,NULL,'CFA Franc BEAC','currency.XAF'),(156,'XCD',2,NULL,NULL,'East Caribbean Dollar','currency.XCD'),(157,'XDR',5,NULL,NULL,'SDR (Special Drawing Rights)','currency.XDR'),(158,'XOF',0,NULL,'CFA','CFA Franc BCEAO','currency.XOF'),(159,'XPF',0,NULL,NULL,'CFP Franc','currency.XPF'),(160,'YER',2,NULL,NULL,'Yemeni Rial','currency.YER'),(161,'ZAR',2,NULL,'R','South African Rand','currency.ZAR'),(162,'ZMK',2,NULL,NULL,'Zambian Kwacha','currency.ZMK'),(163,'ZWD',2,NULL,NULL,'Zimbabwe Dollar','currency.ZWD');
/*!40000 ALTER TABLE `m_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_on_hold_transaction`
--

DROP TABLE IF EXISTS `m_deposit_account_on_hold_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_on_hold_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `transaction_type_enum` smallint(1) NOT NULL,
  `transaction_date` date NOT NULL,
  `is_reversed` tinyint(1) NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_deposit_on_hold_transaction_m_savings_account` (`savings_account_id`),
  CONSTRAINT `FK_deposit_on_hold_transaction_m_savings_account` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_on_hold_transaction`
--

LOCK TABLES `m_deposit_account_on_hold_transaction` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_on_hold_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_on_hold_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_recurring_detail`
--

DROP TABLE IF EXISTS `m_deposit_account_recurring_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_recurring_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL DEFAULT '0',
  `mandatory_recommended_deposit_amount` decimal(19,6) DEFAULT NULL,
  `is_mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `allow_withdrawal` tinyint(4) NOT NULL DEFAULT '0',
  `adjust_advance_towards_future_payments` tinyint(4) NOT NULL DEFAULT '1',
  `is_calendar_inherited` tinyint(4) NOT NULL DEFAULT '0',
  `total_overdue_amount` decimal(19,6) DEFAULT NULL,
  `no_of_overdue_installments` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDARD00000000000001` (`savings_account_id`),
  CONSTRAINT `FKDARD00000000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_recurring_detail`
--

LOCK TABLES `m_deposit_account_recurring_detail` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_recurring_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_recurring_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_term_and_preclosure`
--

DROP TABLE IF EXISTS `m_deposit_account_term_and_preclosure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_term_and_preclosure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL DEFAULT '0',
  `min_deposit_term` int(11) DEFAULT NULL,
  `max_deposit_term` int(11) DEFAULT NULL,
  `min_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `max_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `in_multiples_of_deposit_term` int(11) DEFAULT NULL,
  `in_multiples_of_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `pre_closure_penal_applicable` smallint(5) DEFAULT NULL,
  `pre_closure_penal_interest` decimal(19,6) DEFAULT NULL,
  `pre_closure_penal_interest_on_enum` smallint(5) DEFAULT NULL,
  `deposit_period` int(11) DEFAULT NULL,
  `deposit_period_frequency_enum` smallint(5) DEFAULT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  `maturity_amount` decimal(19,6) DEFAULT NULL,
  `maturity_date` date DEFAULT NULL,
  `on_account_closure_enum` smallint(5) DEFAULT NULL,
  `expected_firstdepositon_date` date DEFAULT NULL,
  `transfer_interest_to_linked_account` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKDATP00000000000001` (`savings_account_id`),
  CONSTRAINT `FKDATP00000000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_term_and_preclosure`
--

LOCK TABLES `m_deposit_account_term_and_preclosure` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_term_and_preclosure` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_term_and_preclosure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_product_interest_rate_chart`
--

DROP TABLE IF EXISTS `m_deposit_product_interest_rate_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_product_interest_rate_chart` (
  `deposit_product_id` bigint(20) NOT NULL,
  `interest_rate_chart_id` bigint(20) NOT NULL,
  UNIQUE KEY `deposit_product_id_interest_rate_chart_id` (`deposit_product_id`,`interest_rate_chart_id`),
  KEY `FKDPIRC00000000000002` (`interest_rate_chart_id`),
  CONSTRAINT `FKDPIRC00000000000001` FOREIGN KEY (`deposit_product_id`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FKDPIRC00000000000002` FOREIGN KEY (`interest_rate_chart_id`) REFERENCES `m_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_product_interest_rate_chart`
--

LOCK TABLES `m_deposit_product_interest_rate_chart` WRITE;
/*!40000 ALTER TABLE `m_deposit_product_interest_rate_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_product_interest_rate_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_product_recurring_detail`
--

DROP TABLE IF EXISTS `m_deposit_product_recurring_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_product_recurring_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_product_id` bigint(20) NOT NULL DEFAULT '0',
  `is_mandatory` tinyint(1) NOT NULL DEFAULT '1',
  `allow_withdrawal` tinyint(1) NOT NULL DEFAULT '0',
  `adjust_advance_towards_future_payments` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FKDPRD00000000000001` (`savings_product_id`),
  CONSTRAINT `FKDPRD00000000000001` FOREIGN KEY (`savings_product_id`) REFERENCES `m_savings_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_product_recurring_detail`
--

LOCK TABLES `m_deposit_product_recurring_detail` WRITE;
/*!40000 ALTER TABLE `m_deposit_product_recurring_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_product_recurring_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_product_term_and_preclosure`
--

DROP TABLE IF EXISTS `m_deposit_product_term_and_preclosure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_product_term_and_preclosure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_product_id` bigint(20) NOT NULL DEFAULT '0',
  `min_deposit_term` int(11) DEFAULT NULL,
  `max_deposit_term` int(11) DEFAULT NULL,
  `min_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `max_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `in_multiples_of_deposit_term` int(11) DEFAULT NULL,
  `in_multiples_of_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `pre_closure_penal_applicable` smallint(5) DEFAULT NULL,
  `pre_closure_penal_interest` decimal(19,6) DEFAULT NULL,
  `pre_closure_penal_interest_on_enum` smallint(5) DEFAULT NULL,
  `min_deposit_amount` decimal(19,6) DEFAULT NULL,
  `max_deposit_amount` decimal(19,6) DEFAULT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDPTP00000000000001` (`savings_product_id`),
  CONSTRAINT `FKDPTP00000000000001` FOREIGN KEY (`savings_product_id`) REFERENCES `m_savings_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_product_term_and_preclosure`
--

LOCK TABLES `m_deposit_product_term_and_preclosure` WRITE;
/*!40000 ALTER TABLE `m_deposit_product_term_and_preclosure` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_product_term_and_preclosure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_document`
--

DROP TABLE IF EXISTS `m_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_document` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `parent_entity_type` varchar(50) NOT NULL,
  `parent_entity_id` int(20) NOT NULL DEFAULT '0',
  `name` varchar(250) NOT NULL,
  `file_name` varchar(250) NOT NULL,
  `size` int(20) DEFAULT '0',
  `type` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `location` varchar(500) NOT NULL DEFAULT '0',
  `storage_type_enum` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_document`
--

LOCK TABLES `m_document` WRITE;
/*!40000 ALTER TABLE `m_document` DISABLE KEYS */;
INSERT INTO `m_document` VALUES (1,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\agl9u925nc1kh2\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(2,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\yeplw3wxp9tec\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(3,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\wjdthggsbeufk7s\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(4,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\hkbkbrtw9o\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(5,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\bs599hy\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(6,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\27e9hia9\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(7,'IMPORT',1,'Copy of CLIENTS_PERSON2019-04-04.xls','Copy of CLIENTS_PERSON2019-04-04.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\CLIENTS_PERSON\\null\\b96kmc\\Copy of CLIENTS_PERSON2019-04-04.xls',1),(8,'IMPORT',1,'CLIENTS_PERSON2019-04-04-1.xls','CLIENTS_PERSON2019-04-04-1.xls',NULL,NULL,NULL,'C:\\Users\\user\\.fineract\\DefaultDemoTenant\\documents\\IMPORT\\1\\fkbuyh\\CLIENTS_PERSON2019-04-04-1.xls',1);
/*!40000 ALTER TABLE `m_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_datatable_check`
--

DROP TABLE IF EXISTS `m_entity_datatable_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_datatable_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_table_name` varchar(200) NOT NULL,
  `x_registered_table_name` varchar(50) NOT NULL,
  `status_enum` int(11) NOT NULL,
  `system_defined` tinyint(4) NOT NULL DEFAULT '0',
  `product_id` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_check` (`application_table_name`,`x_registered_table_name`,`status_enum`,`product_id`),
  KEY `x_registered_table_name` (`x_registered_table_name`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `m_entity_datatable_check_ibfk_1` FOREIGN KEY (`x_registered_table_name`) REFERENCES `x_registered_table` (`registered_table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_datatable_check`
--

LOCK TABLES `m_entity_datatable_check` WRITE;
/*!40000 ALTER TABLE `m_entity_datatable_check` DISABLE KEYS */;
INSERT INTO `m_entity_datatable_check` VALUES (1,'m_client','More Client Details',100,0,NULL);
/*!40000 ALTER TABLE `m_entity_datatable_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_relation`
--

DROP TABLE IF EXISTS `m_entity_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_entity_type` int(10) NOT NULL,
  `to_entity_type` int(10) NOT NULL,
  `code_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `from_entity_type_to_entity_type_code_name` (`from_entity_type`,`to_entity_type`,`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_relation`
--

LOCK TABLES `m_entity_relation` WRITE;
/*!40000 ALTER TABLE `m_entity_relation` DISABLE KEYS */;
INSERT INTO `m_entity_relation` VALUES (1,1,2,'office_access_to_loan_products'),(2,1,3,'office_access_to_savings_products'),(3,1,4,'office_access_to_fees/charges'),(4,5,2,'role_access_to_loan_products'),(5,5,3,'role_access_to_savings_products');
/*!40000 ALTER TABLE `m_entity_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_to_entity_access`
--

DROP TABLE IF EXISTS `m_entity_to_entity_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_to_entity_access` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` bigint(20) NOT NULL,
  `access_type_code_value_id` int(11) NOT NULL,
  `second_entity_type` varchar(50) NOT NULL,
  `second_entity_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_uniq_m_entity_to_entity_access` (`entity_type`,`entity_id`,`access_type_code_value_id`,`second_entity_type`,`second_entity_id`),
  KEY `IDX_OFFICE` (`entity_type`,`entity_id`),
  KEY `FK_access_type_code_m_code_value` (`access_type_code_value_id`),
  CONSTRAINT `FK_access_type_code_m_code_value` FOREIGN KEY (`access_type_code_value_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_to_entity_access`
--

LOCK TABLES `m_entity_to_entity_access` WRITE;
/*!40000 ALTER TABLE `m_entity_to_entity_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_entity_to_entity_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_to_entity_mapping`
--

DROP TABLE IF EXISTS `m_entity_to_entity_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_to_entity_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rel_id` bigint(20) NOT NULL DEFAULT '0',
  `from_id` bigint(20) NOT NULL DEFAULT '0',
  `to_id` bigint(20) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rel_id_from_id_to_id` (`rel_id`,`from_id`,`to_id`),
  CONSTRAINT `FK__rel_id_m_entity_relation_id` FOREIGN KEY (`rel_id`) REFERENCES `m_entity_relation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_to_entity_mapping`
--

LOCK TABLES `m_entity_to_entity_mapping` WRITE;
/*!40000 ALTER TABLE `m_entity_to_entity_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_entity_to_entity_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_family_members`
--

DROP TABLE IF EXISTS `m_family_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_family_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `relationship_cv_id` int(11) NOT NULL,
  `marital_status_cv_id` int(11) DEFAULT NULL,
  `gender_cv_id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `profession_cv_id` int(11) DEFAULT NULL,
  `mobile_number` varchar(50) DEFAULT NULL,
  `is_dependent` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_family_members_client_id_m_client` (`client_id`),
  KEY `FK_m_family_members_relationship_m_code_value` (`relationship_cv_id`),
  KEY `FK_m_family_members_marital_status_m_code_value` (`marital_status_cv_id`),
  KEY `FK_m_family_members_gender_m_code_value` (`gender_cv_id`),
  KEY `FK_m_family_members_profession_m_code_value` (`profession_cv_id`),
  CONSTRAINT `FK_m_family_members_client_id_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_family_members_gender_m_code_value` FOREIGN KEY (`gender_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_family_members_marital_status_m_code_value` FOREIGN KEY (`marital_status_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_family_members_profession_m_code_value` FOREIGN KEY (`profession_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_family_members_relationship_m_code_value` FOREIGN KEY (`relationship_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_family_members`
--

LOCK TABLES `m_family_members` WRITE;
/*!40000 ALTER TABLE `m_family_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_family_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_field_configuration`
--

DROP TABLE IF EXISTS `m_field_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_field_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity` varchar(100) NOT NULL,
  `subentity` varchar(100) NOT NULL,
  `field` varchar(100) NOT NULL,
  `is_enabled` tinyint(4) NOT NULL,
  `is_mandatory` tinyint(4) NOT NULL,
  `validation_regex` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_field_configuration`
--

LOCK TABLES `m_field_configuration` WRITE;
/*!40000 ALTER TABLE `m_field_configuration` DISABLE KEYS */;
INSERT INTO `m_field_configuration` VALUES (1,'ADDRESS','CLIENT','addressType',1,0,''),(2,'ADDRESS','CLIENT','street',1,1,''),(3,'ADDRESS','CLIENT','addressLine1',1,0,''),(4,'ADDRESS','CLIENT','addressLine2',1,0,''),(5,'ADDRESS','CLIENT','addressLine3',1,0,''),(6,'ADDRESS','CLIENT','townVillage',0,0,''),(7,'ADDRESS','CLIENT','city',1,0,''),(8,'ADDRESS','CLIENT','countyDistrict',0,0,''),(9,'ADDRESS','CLIENT','stateProvinceId',1,0,''),(10,'ADDRESS','CLIENT','countryId',1,0,''),(11,'ADDRESS','CLIENT','postalCode',1,0,''),(12,'ADDRESS','CLIENT','latitude',0,0,''),(13,'ADDRESS','CLIENT','longitude',0,0,''),(14,'ADDRESS','CLIENT','createdBy',1,0,''),(15,'ADDRESS','CLIENT','createdOn',1,0,''),(16,'ADDRESS','CLIENT','updatedBy',1,0,''),(17,'ADDRESS','CLIENT','updatedOn',1,0,''),(18,'ADDRESS','CLIENT','isActive',1,0,'');
/*!40000 ALTER TABLE `m_field_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_floating_rates`
--

DROP TABLE IF EXISTS `m_floating_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_floating_rates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `is_base_lending_rate` bit(1) NOT NULL DEFAULT b'0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_floating_rates`
--

LOCK TABLES `m_floating_rates` WRITE;
/*!40000 ALTER TABLE `m_floating_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_floating_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_floating_rates_periods`
--

DROP TABLE IF EXISTS `m_floating_rates_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_floating_rates_periods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `floating_rates_id` bigint(20) NOT NULL,
  `from_date` datetime NOT NULL,
  `interest_rate` decimal(19,6) NOT NULL,
  `is_differential_to_base_lending_rate` bit(1) NOT NULL DEFAULT b'0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_floating_rates` (`floating_rates_id`),
  CONSTRAINT `FK_mappings_m_floating_rates` FOREIGN KEY (`floating_rates_id`) REFERENCES `m_floating_rates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_floating_rates_periods`
--

LOCK TABLES `m_floating_rates_periods` WRITE;
/*!40000 ALTER TABLE `m_floating_rates_periods` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_floating_rates_periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_fund`
--

DROP TABLE IF EXISTS `m_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_fund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_name_org` (`name`),
  UNIQUE KEY `fund_externalid_org` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_fund`
--

LOCK TABLES `m_fund` WRITE;
/*!40000 ALTER TABLE `m_fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group`
--

DROP TABLE IF EXISTS `m_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '300',
  `activation_date` date DEFAULT NULL,
  `office_id` bigint(20) NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `level_id` int(11) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `closure_reason_cv_id` int(11) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `account_no` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`display_name`,`level_id`),
  UNIQUE KEY `external_id` (`external_id`,`level_id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `office_id` (`office_id`),
  KEY `staff_id` (`staff_id`),
  KEY `Parent_Id_reference` (`parent_id`),
  KEY `FK_m_group_level` (`level_id`),
  KEY `FK_m_group_m_code` (`closure_reason_cv_id`),
  CONSTRAINT `FK_m_group_level` FOREIGN KEY (`level_id`) REFERENCES `m_group_level` (`id`),
  CONSTRAINT `FK_m_group_m_code` FOREIGN KEY (`closure_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_group_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `m_group_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `Parent_Id_reference` FOREIGN KEY (`parent_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group`
--

LOCK TABLES `m_group` WRITE;
/*!40000 ALTER TABLE `m_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_client`
--

DROP TABLE IF EXISTS `m_group_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_client` (
  `group_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`client_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `m_group_client_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `m_group_client_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_client`
--

LOCK TABLES `m_group_client` WRITE;
/*!40000 ALTER TABLE `m_group_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_level`
--

DROP TABLE IF EXISTS `m_group_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `super_parent` tinyint(1) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `recursable` tinyint(1) NOT NULL,
  `can_have_clients` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Parent_levelId_reference` (`parent_id`),
  CONSTRAINT `Parent_levelId_reference` FOREIGN KEY (`parent_id`) REFERENCES `m_group_level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_level`
--

LOCK TABLES `m_group_level` WRITE;
/*!40000 ALTER TABLE `m_group_level` DISABLE KEYS */;
INSERT INTO `m_group_level` VALUES (1,NULL,1,'Center',1,0),(2,1,0,'Group',0,1);
/*!40000 ALTER TABLE `m_group_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_roles`
--

DROP TABLE IF EXISTS `m_group_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `role_cv_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_GROUP_ROLES` (`client_id`,`group_id`,`role_cv_id`),
  KEY `FKGroupRoleClientId` (`client_id`),
  KEY `FKGroupRoleGroupId` (`group_id`),
  KEY `FK_grouprole_m_codevalue` (`role_cv_id`),
  CONSTRAINT `FKGroupRoleClientId` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKGroupRoleGroupId` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_grouprole_m_codevalue` FOREIGN KEY (`role_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_roles`
--

LOCK TABLES `m_group_roles` WRITE;
/*!40000 ALTER TABLE `m_group_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor`
--

DROP TABLE IF EXISTS `m_guarantor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `client_reln_cv_id` int(11) DEFAULT NULL,
  `type_enum` smallint(5) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address_line_1` varchar(500) DEFAULT NULL,
  `address_line_2` varchar(500) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `house_phone_number` varchar(20) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_m_guarantor_m_loan` (`loan_id`),
  KEY `FK_m_guarantor_m_code_value` (`client_reln_cv_id`),
  CONSTRAINT `FK_m_guarantor_m_code_value` FOREIGN KEY (`client_reln_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_guarantor_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor`
--

LOCK TABLES `m_guarantor` WRITE;
/*!40000 ALTER TABLE `m_guarantor` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor_funding_details`
--

DROP TABLE IF EXISTS `m_guarantor_funding_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor_funding_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guarantor_id` bigint(20) NOT NULL,
  `account_associations_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_released_derived` decimal(19,6) DEFAULT NULL,
  `amount_remaining_derived` decimal(19,6) DEFAULT NULL,
  `amount_transfered_derived` decimal(19,6) DEFAULT NULL,
  `status_enum` smallint(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_guarantor_fund_details_m_guarantor` (`guarantor_id`),
  KEY `FK_m_guarantor_fund_details_account_associations_id` (`account_associations_id`),
  CONSTRAINT `FK_m_guarantor_fund_details_account_associations_id` FOREIGN KEY (`account_associations_id`) REFERENCES `m_portfolio_account_associations` (`id`),
  CONSTRAINT `FK_m_guarantor_fund_details_m_guarantor` FOREIGN KEY (`guarantor_id`) REFERENCES `m_guarantor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor_funding_details`
--

LOCK TABLES `m_guarantor_funding_details` WRITE;
/*!40000 ALTER TABLE `m_guarantor_funding_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor_funding_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor_transaction`
--

DROP TABLE IF EXISTS `m_guarantor_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guarantor_fund_detail_id` bigint(20) NOT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `deposit_on_hold_transaction_id` bigint(20) NOT NULL,
  `is_reversed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_guarantor_transaction_m_deposit_account_on_hold_transaction` (`deposit_on_hold_transaction_id`),
  KEY `FK_guarantor_transaction_guarantor_fund_detail` (`guarantor_fund_detail_id`),
  KEY `FK_guarantor_transaction_m_loan_transaction` (`loan_transaction_id`),
  CONSTRAINT `FK_guarantor_transaction_guarantor_fund_detail` FOREIGN KEY (`guarantor_fund_detail_id`) REFERENCES `m_guarantor_funding_details` (`id`),
  CONSTRAINT `FK_guarantor_transaction_m_deposit_account_on_hold_transaction` FOREIGN KEY (`deposit_on_hold_transaction_id`) REFERENCES `m_deposit_account_on_hold_transaction` (`id`),
  CONSTRAINT `FK_guarantor_transaction_m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor_transaction`
--

LOCK TABLES `m_guarantor_transaction` WRITE;
/*!40000 ALTER TABLE `m_guarantor_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_holiday`
--

DROP TABLE IF EXISTS `m_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_holiday` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `from_date` datetime NOT NULL,
  `to_date` datetime NOT NULL,
  `repayments_rescheduled_to` datetime DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '100',
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(100) DEFAULT NULL,
  `rescheduling_type` int(5) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `holiday_name` (`name`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_holiday`
--

LOCK TABLES `m_holiday` WRITE;
/*!40000 ALTER TABLE `m_holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_holiday_office`
--

DROP TABLE IF EXISTS `m_holiday_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_holiday_office` (
  `holiday_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  PRIMARY KEY (`holiday_id`,`office_id`),
  KEY `m_holiday_id_ibfk_1` (`holiday_id`),
  KEY `m_office_id_ibfk_2` (`office_id`),
  CONSTRAINT `m_holiday_id_ibfk_1` FOREIGN KEY (`holiday_id`) REFERENCES `m_holiday` (`id`),
  CONSTRAINT `m_office_id_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_holiday_office`
--

LOCK TABLES `m_holiday_office` WRITE;
/*!40000 ALTER TABLE `m_holiday_office` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_holiday_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook`
--

DROP TABLE IF EXISTS `m_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `template_id` smallint(6) NOT NULL,
  `is_active` smallint(3) NOT NULL DEFAULT '1',
  `name` varchar(45) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `ugd_template_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_template_id_idx` (`template_id`),
  KEY `fk_ugd_template_id` (`ugd_template_id`),
  CONSTRAINT `fk_template_id` FOREIGN KEY (`template_id`) REFERENCES `m_hook_templates` (`id`),
  CONSTRAINT `fk_ugd_template_id` FOREIGN KEY (`ugd_template_id`) REFERENCES `m_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook`
--

LOCK TABLES `m_hook` WRITE;
/*!40000 ALTER TABLE `m_hook` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_configuration`
--

DROP TABLE IF EXISTS `m_hook_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hook_id` bigint(20) DEFAULT NULL,
  `field_type` varchar(45) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hook_id_idx` (`hook_id`),
  CONSTRAINT `fk_hook_id_cfg` FOREIGN KEY (`hook_id`) REFERENCES `m_hook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_configuration`
--

LOCK TABLES `m_hook_configuration` WRITE;
/*!40000 ALTER TABLE `m_hook_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_hook_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_registered_events`
--

DROP TABLE IF EXISTS `m_hook_registered_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_registered_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hook_id` bigint(20) NOT NULL,
  `entity_name` varchar(45) NOT NULL,
  `action_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hook_id_idx` (`hook_id`),
  CONSTRAINT `fk_hook_idc` FOREIGN KEY (`hook_id`) REFERENCES `m_hook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_registered_events`
--

LOCK TABLES `m_hook_registered_events` WRITE;
/*!40000 ALTER TABLE `m_hook_registered_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_hook_registered_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_schema`
--

DROP TABLE IF EXISTS `m_hook_schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_schema` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `hook_template_id` smallint(6) NOT NULL,
  `field_type` varchar(45) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `placeholder` varchar(100) DEFAULT NULL,
  `optional` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_hook_template_id_idx` (`hook_template_id`),
  CONSTRAINT `fk_hook_template_id` FOREIGN KEY (`hook_template_id`) REFERENCES `m_hook_templates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_schema`
--

LOCK TABLES `m_hook_schema` WRITE;
/*!40000 ALTER TABLE `m_hook_schema` DISABLE KEYS */;
INSERT INTO `m_hook_schema` VALUES (1,1,'string','Payload URL',NULL,0),(2,1,'string','Content Type','json / form',0),(3,2,'string','Payload URL',NULL,0),(4,2,'string','SMS Provider',NULL,0),(5,2,'string','Phone Number',NULL,0),(6,2,'string','SMS Provider Token',NULL,0),(7,2,'string','SMS Provider Account Id',NULL,0);
/*!40000 ALTER TABLE `m_hook_schema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_templates`
--

DROP TABLE IF EXISTS `m_hook_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_templates` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_templates`
--

LOCK TABLES `m_hook_templates` WRITE;
/*!40000 ALTER TABLE `m_hook_templates` DISABLE KEYS */;
INSERT INTO `m_hook_templates` VALUES (1,'Web'),(2,'SMS Bridge');
/*!40000 ALTER TABLE `m_hook_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_image`
--

DROP TABLE IF EXISTS `m_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `location` varchar(500) DEFAULT NULL,
  `storage_type_enum` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_image`
--

LOCK TABLES `m_image` WRITE;
/*!40000 ALTER TABLE `m_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_import_document`
--

DROP TABLE IF EXISTS `m_import_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_import_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_id` int(20) NOT NULL,
  `import_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `entity_type` tinyint(3) NOT NULL,
  `completed` tinyint(2) DEFAULT '0',
  `total_records` bigint(20) DEFAULT '0',
  `success_count` bigint(20) DEFAULT '0',
  `failure_count` bigint(20) DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `import_document_id` (`document_id`),
  KEY `FK_m_import_m_appuser` (`createdby_id`),
  CONSTRAINT `FK_m_import_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_import_m_document` FOREIGN KEY (`document_id`) REFERENCES `m_document` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_import_document`
--

LOCK TABLES `m_import_document` WRITE;
/*!40000 ALTER TABLE `m_import_document` DISABLE KEYS */;
INSERT INTO `m_import_document` VALUES (1,1,'2019-04-04 19:05:41','2019-04-04 19:05:48',1,1,32,0,32,1),(2,2,'2019-04-04 19:05:59','2019-04-04 19:06:03',1,1,32,0,32,1),(3,3,'2019-04-04 19:06:01','2019-04-04 19:06:05',1,1,32,0,32,1),(4,4,'2019-04-04 19:06:03','2019-04-04 19:06:07',1,1,32,0,32,1),(5,5,'2019-04-04 19:06:04','2019-04-04 19:06:07',1,1,32,0,32,1),(6,6,'2019-04-04 19:06:41','2019-04-04 19:06:42',1,1,32,0,32,1),(7,7,'2019-04-04 19:24:57','2019-04-04 19:24:59',1,1,32,0,32,1),(8,8,'2019-04-04 19:34:53','2019-04-04 17:04:53',1,0,31,0,0,1);
/*!40000 ALTER TABLE `m_import_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_interest_incentives`
--

DROP TABLE IF EXISTS `m_interest_incentives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_interest_incentives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interest_rate_slab_id` bigint(20) NOT NULL,
  `entiry_type` smallint(2) NOT NULL,
  `attribute_name` smallint(2) NOT NULL,
  `condition_type` smallint(2) NOT NULL,
  `attribute_value` varchar(50) NOT NULL,
  `incentive_type` smallint(2) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_interest_incentives_m_interest_rate_slab` (`interest_rate_slab_id`),
  CONSTRAINT `FK_m_interest_incentives_m_interest_rate_slab` FOREIGN KEY (`interest_rate_slab_id`) REFERENCES `m_interest_rate_slab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_interest_incentives`
--

LOCK TABLES `m_interest_incentives` WRITE;
/*!40000 ALTER TABLE `m_interest_incentives` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_interest_incentives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_interest_rate_chart`
--

DROP TABLE IF EXISTS `m_interest_rate_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_interest_rate_chart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `from_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_primary_grouping_by_amount` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_interest_rate_chart`
--

LOCK TABLES `m_interest_rate_chart` WRITE;
/*!40000 ALTER TABLE `m_interest_rate_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_interest_rate_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_interest_rate_slab`
--

DROP TABLE IF EXISTS `m_interest_rate_slab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_interest_rate_slab` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interest_rate_chart_id` bigint(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `period_type_enum` smallint(5) DEFAULT NULL,
  `from_period` int(11) DEFAULT NULL,
  `to_period` int(11) DEFAULT NULL,
  `amount_range_from` decimal(19,6) DEFAULT NULL,
  `amount_range_to` decimal(19,6) DEFAULT NULL,
  `annual_interest_rate` decimal(19,6) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKIRS00000000000001` (`interest_rate_chart_id`),
  CONSTRAINT `FKIRS00000000000001` FOREIGN KEY (`interest_rate_chart_id`) REFERENCES `m_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_interest_rate_slab`
--

LOCK TABLES `m_interest_rate_slab` WRITE;
/*!40000 ALTER TABLE `m_interest_rate_slab` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_interest_rate_slab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan`
--

DROP TABLE IF EXISTS `m_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `loanpurpose_cv_id` int(11) DEFAULT NULL,
  `loan_status_id` smallint(5) NOT NULL,
  `loan_type_enum` smallint(5) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `principal_amount_proposed` decimal(19,6) NOT NULL,
  `principal_amount` decimal(19,6) NOT NULL,
  `approved_principal` decimal(19,6) NOT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `is_floating_interest_rate` bit(1) DEFAULT b'0',
  `interest_rate_differential` decimal(19,6) DEFAULT '0.000000',
  `nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `interest_period_frequency_enum` smallint(5) DEFAULT NULL,
  `annual_nominal_interest_rate` decimal(19,6) DEFAULT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `allow_partial_period_interest_calcualtion` tinyint(1) NOT NULL DEFAULT '0',
  `term_frequency` smallint(5) NOT NULL DEFAULT '0',
  `term_period_frequency_enum` smallint(5) NOT NULL DEFAULT '2',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `grace_on_principal_periods` smallint(5) DEFAULT NULL,
  `recurring_moratorium_principal_periods` smallint(5) DEFAULT NULL,
  `grace_on_interest_periods` smallint(5) DEFAULT NULL,
  `grace_interest_free_periods` smallint(5) DEFAULT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `expected_disbursedon_date` date DEFAULT NULL,
  `expected_firstrepaymenton_date` date DEFAULT NULL,
  `interest_calculated_from_date` date DEFAULT NULL,
  `disbursedon_date` date DEFAULT NULL,
  `disbursedon_userid` bigint(20) DEFAULT NULL,
  `expected_maturedon_date` date DEFAULT NULL,
  `maturedon_date` date DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `total_charges_due_at_disbursement_derived` decimal(19,6) DEFAULT NULL,
  `principal_disbursed_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_expected_repayment_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_repayment_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_expected_costofloan_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_costofloan_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_overpaid_derived` decimal(19,6) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `rescheduledon_date` date DEFAULT NULL,
  `rescheduledon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `writtenoffon_date` date DEFAULT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  `sync_disbursement_with_meeting` tinyint(1) DEFAULT NULL,
  `loan_counter` smallint(6) DEFAULT NULL,
  `loan_product_counter` smallint(6) DEFAULT NULL,
  `fixed_emi_amount` decimal(19,6) DEFAULT NULL,
  `max_outstanding_loan_balance` decimal(19,6) DEFAULT NULL,
  `grace_on_arrears_ageing` smallint(5) DEFAULT NULL,
  `is_npa` tinyint(1) NOT NULL DEFAULT '0',
  `total_recovered_derived` decimal(19,6) DEFAULT NULL,
  `accrued_till` date DEFAULT NULL,
  `interest_recalcualated_on` date DEFAULT NULL,
  `days_in_month_enum` smallint(5) NOT NULL DEFAULT '1',
  `days_in_year_enum` smallint(5) NOT NULL DEFAULT '1',
  `interest_recalculation_enabled` tinyint(4) NOT NULL DEFAULT '0',
  `guarantee_amount_derived` decimal(19,6) DEFAULT NULL,
  `create_standing_instruction_at_disbursement` tinyint(1) DEFAULT NULL,
  `version` int(15) NOT NULL DEFAULT '1',
  `writeoff_reason_cv_id` int(11) DEFAULT NULL,
  `loan_sub_status_id` smallint(5) DEFAULT NULL,
  `is_topup` tinyint(1) NOT NULL DEFAULT '0',
  `is_equal_amortization` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `loan_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `loan_externalid_UNIQUE` (`external_id`),
  KEY `FKB6F935D87179A0CB` (`client_id`),
  KEY `FKB6F935D8C8D4B434` (`product_id`),
  KEY `FK7C885877240145` (`fund_id`),
  KEY `FK_loan_ltp_strategy` (`loan_transaction_strategy_id`),
  KEY `FK_m_loan_m_staff` (`loan_officer_id`),
  KEY `group_id` (`group_id`),
  KEY `FK_m_loanpurpose_codevalue` (`loanpurpose_cv_id`),
  KEY `FK_submittedon_userid` (`submittedon_userid`),
  KEY `FK_approvedon_userid` (`approvedon_userid`),
  KEY `FK_rejectedon_userid` (`rejectedon_userid`),
  KEY `FK_withdrawnon_userid` (`withdrawnon_userid`),
  KEY `FK_disbursedon_userid` (`disbursedon_userid`),
  KEY `FK_closedon_userid` (`closedon_userid`),
  KEY `fk_m_group_client_001_idx` (`group_id`,`client_id`),
  KEY `FK_writeoffreason_m_loan_m_code_value` (`writeoff_reason_cv_id`),
  CONSTRAINT `FK7C885877240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FKB6F935D87179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKB6F935D8C8D4B434` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `FK_approvedon_userid` FOREIGN KEY (`approvedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_closedon_userid` FOREIGN KEY (`closedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_disbursedon_userid` FOREIGN KEY (`disbursedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_loan_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`),
  CONSTRAINT `FK_m_loanpurpose_codevalue` FOREIGN KEY (`loanpurpose_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_loan_m_staff` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_rejectedon_userid` FOREIGN KEY (`rejectedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_submittedon_userid` FOREIGN KEY (`submittedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_withdrawnon_userid` FOREIGN KEY (`withdrawnon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_writeoffreason_m_loan_m_code_value` FOREIGN KEY (`writeoff_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `m_loan_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan`
--

LOCK TABLES `m_loan` WRITE;
/*!40000 ALTER TABLE `m_loan` DISABLE KEYS */;
INSERT INTO `m_loan` VALUES (1,'000000001',NULL,1,NULL,1,NULL,NULL,NULL,100,1,'USD',0,0,10000.000000,10000.000000,10000.000000,NULL,NULL,NULL,3.000000,2,36.000000,0,1,0,10,2,1,2,10,NULL,NULL,NULL,NULL,1,'2019-04-04',1,NULL,NULL,'2019-04-04',NULL,NULL,NULL,NULL,'2020-02-04','2020-02-04',NULL,NULL,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,1,0,NULL,NULL,2,NULL,NULL,0,0),(2,'000000002',NULL,2,NULL,1,NULL,NULL,NULL,100,1,'USD',0,0,10000.000000,10000.000000,10000.000000,NULL,NULL,NULL,3.000000,2,36.000000,0,1,0,10,2,1,2,10,NULL,NULL,NULL,NULL,1,'2019-04-04',1,NULL,NULL,'2019-04-04',NULL,NULL,NULL,NULL,'2020-02-04','2020-02-04',NULL,NULL,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,1,0,NULL,NULL,2,NULL,NULL,0,0),(3,'000000003',NULL,2,NULL,1,NULL,NULL,NULL,300,1,'USD',0,0,10000.000000,10000.000000,10000.000000,NULL,NULL,NULL,3.000000,2,36.000000,0,1,0,10,2,1,2,10,NULL,NULL,NULL,NULL,1,'2019-04-04',1,'2019-04-04',1,'2019-04-04',NULL,NULL,'2019-04-04',1,'2020-02-04','2020-02-04',NULL,NULL,0.000000,10000.000000,872.000000,0.000000,9128.000000,1724.000000,300.000000,0.000000,0.000000,1424.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,11724.000000,1172.000000,1724.000000,300.000000,0.000000,0.000000,10552.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,1,1,0,NULL,NULL,6,NULL,NULL,0,0),(4,'000000004',NULL,2,NULL,2,NULL,NULL,NULL,300,1,'USD',0,0,1000.000000,1000.000000,1000.000000,NULL,NULL,NULL,4.000000,2,48.000000,0,1,0,3,2,1,2,3,NULL,NULL,NULL,NULL,1,'2019-04-26',1,'2019-04-26',1,'2019-04-26',NULL,NULL,'2019-04-26',1,'2019-07-26','2019-07-26',NULL,NULL,0.000000,1000.000000,653.000000,0.000000,347.000000,81.000000,67.000000,0.000000,0.000000,14.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1081.000000,720.000000,81.000000,67.000000,0.000000,0.000000,361.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,1,1,0,NULL,NULL,7,NULL,NULL,0,0),(5,'000000005',NULL,396,NULL,2,NULL,NULL,NULL,300,1,'USD',0,0,1000.000000,1000.000000,1000.000000,NULL,NULL,NULL,4.000000,2,48.000000,0,1,0,3,2,1,2,3,NULL,NULL,NULL,NULL,1,'2019-05-07',1,'2019-05-07',1,'2019-05-07',NULL,NULL,'2019-05-07',1,'2019-08-07','2019-08-07',NULL,NULL,0.000000,1000.000000,320.000000,0.000000,680.000000,81.000000,40.000000,0.000000,0.000000,41.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1081.000000,360.000000,81.000000,40.000000,0.000000,0.000000,721.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,0,NULL,NULL,NULL,1,1,0,NULL,NULL,6,NULL,NULL,0,0);
/*!40000 ALTER TABLE `m_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_arrears_aging`
--

DROP TABLE IF EXISTS `m_loan_arrears_aging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_arrears_aging` (
  `loan_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `overdue_since_date_derived` date DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  CONSTRAINT `m_loan_arrears_aging_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_arrears_aging`
--

LOCK TABLES `m_loan_arrears_aging` WRITE;
/*!40000 ALTER TABLE `m_loan_arrears_aging` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_arrears_aging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_charge`
--

DROP TABLE IF EXISTS `m_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `charge_time_enum` smallint(5) NOT NULL,
  `due_for_collection_as_of_date` date DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `charge_payment_mode_enum` smallint(5) NOT NULL DEFAULT '0',
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `charge_amount_or_percentage` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `min_cap` decimal(19,6) DEFAULT NULL,
  `max_cap` decimal(19,6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_loan_charge_ibfk_2` (`loan_id`),
  CONSTRAINT `m_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_loan_charge_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_charge`
--

LOCK TABLES `m_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_charge_paid_by`
--

DROP TABLE IF EXISTS `m_loan_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_transaction_id` bigint(20) NOT NULL,
  `loan_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `installment_number` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__m_loan_transaction` (`loan_transaction_id`),
  KEY `FK__m_loan_charge` (`loan_charge_id`),
  CONSTRAINT `FK__m_loan_charge` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK__m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_charge_paid_by`
--

LOCK TABLES `m_loan_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_loan_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_collateral`
--

DROP TABLE IF EXISTS `m_loan_collateral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_collateral` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `type_cv_id` int(11) NOT NULL,
  `value` decimal(19,6) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_collateral_m_loan` (`loan_id`),
  KEY `FK_collateral_code_value` (`type_cv_id`),
  CONSTRAINT `FK_collateral_code_value` FOREIGN KEY (`type_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_collateral_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_collateral`
--

LOCK TABLES `m_loan_collateral` WRITE;
/*!40000 ALTER TABLE `m_loan_collateral` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_collateral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_disbursement_detail`
--

DROP TABLE IF EXISTS `m_loan_disbursement_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_disbursement_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `expected_disburse_date` datetime NOT NULL,
  `disbursedon_date` datetime DEFAULT NULL,
  `principal` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_loan_disbursement_detail_loan_id` (`loan_id`),
  CONSTRAINT `FK_loan_disbursement_detail_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_disbursement_detail`
--

LOCK TABLES `m_loan_disbursement_detail` WRITE;
/*!40000 ALTER TABLE `m_loan_disbursement_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_disbursement_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_installment_charge`
--

DROP TABLE IF EXISTS `m_loan_installment_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_installment_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `loan_schedule_id` bigint(20) NOT NULL,
  `due_date` date DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `amount_through_charge_payment` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_loan_charge_id_charge_schedule` (`loan_charge_id`),
  KEY `FK_loan_schedule_id_charge_schedule` (`loan_schedule_id`),
  CONSTRAINT `FK_loan_charge_id_charge_schedule` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_loan_schedule_id_charge_schedule` FOREIGN KEY (`loan_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_installment_charge`
--

LOCK TABLES `m_loan_installment_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_installment_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_installment_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_interest_recalculation_additional_details`
--

DROP TABLE IF EXISTS `m_loan_interest_recalculation_additional_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_interest_recalculation_additional_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_repayment_schedule_id` bigint(20) NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_additional_details_repayment_schedule_id` (`loan_repayment_schedule_id`),
  CONSTRAINT `FK_additional_details_repayment_schedule_id` FOREIGN KEY (`loan_repayment_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_interest_recalculation_additional_details`
--

LOCK TABLES `m_loan_interest_recalculation_additional_details` WRITE;
/*!40000 ALTER TABLE `m_loan_interest_recalculation_additional_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_interest_recalculation_additional_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_officer_assignment_history`
--

DROP TABLE IF EXISTS `m_loan_officer_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_m_loan_officer_assignment_history_0001` (`loan_id`),
  KEY `fk_m_loan_officer_assignment_history_0002` (`loan_officer_id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0001` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0002` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_officer_assignment_history`
--

LOCK TABLES `m_loan_officer_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_overdue_installment_charge`
--

DROP TABLE IF EXISTS `m_loan_overdue_installment_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_overdue_installment_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `loan_schedule_id` bigint(20) NOT NULL,
  `frequency_number` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_overdue_installment_charge_m_loan_charge` (`loan_charge_id`),
  KEY `FK_m_loan_overdue_installment_charge_m_loan_repayment_schedule` (`loan_schedule_id`),
  CONSTRAINT `FK_m_loan_overdue_installment_charge_m_loan_charge` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_m_loan_overdue_installment_charge_m_loan_repayment_schedule` FOREIGN KEY (`loan_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_overdue_installment_charge`
--

LOCK TABLES `m_loan_overdue_installment_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_overdue_installment_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_overdue_installment_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_paid_in_advance`
--

DROP TABLE IF EXISTS `m_loan_paid_in_advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_paid_in_advance` (
  `loan_id` bigint(20) NOT NULL,
  `principal_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`loan_id`),
  CONSTRAINT `m_loan_paid_in_advance_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_paid_in_advance`
--

LOCK TABLES `m_loan_paid_in_advance` WRITE;
/*!40000 ALTER TABLE `m_loan_paid_in_advance` DISABLE KEYS */;
INSERT INTO `m_loan_paid_in_advance` VALUES (4,653.000000,67.000000,0.000000,0.000000,720.000000),(5,320.000000,40.000000,0.000000,0.000000,360.000000);
/*!40000 ALTER TABLE `m_loan_paid_in_advance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_recalculation_details`
--

DROP TABLE IF EXISTS `m_loan_recalculation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_recalculation_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `compound_type_enum` smallint(5) NOT NULL,
  `reschedule_strategy_enum` smallint(5) NOT NULL,
  `rest_frequency_type_enum` smallint(1) NOT NULL,
  `rest_frequency_interval` smallint(3) NOT NULL DEFAULT '0',
  `compounding_frequency_type_enum` smallint(1) DEFAULT NULL,
  `compounding_frequency_interval` smallint(3) DEFAULT NULL,
  `rest_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `rest_frequency_on_day` int(5) DEFAULT NULL,
  `rest_frequency_weekday_enum` int(5) DEFAULT NULL,
  `compounding_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `compounding_frequency_on_day` int(5) DEFAULT NULL,
  `is_compounding_to_be_posted_as_transaction` tinyint(1) NOT NULL DEFAULT '0',
  `compounding_frequency_weekday_enum` int(5) DEFAULT NULL,
  `allow_compounding_on_eod` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_m_loan_recalculation_details` (`loan_id`),
  CONSTRAINT `FK_m_loan_m_loan_recalculation_details` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_recalculation_details`
--

LOCK TABLES `m_loan_recalculation_details` WRITE;
/*!40000 ALTER TABLE `m_loan_recalculation_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_recalculation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_repayment_schedule`
--

DROP TABLE IF EXISTS `m_loan_repayment_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_repayment_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `principal_completed_derived` decimal(19,6) DEFAULT NULL,
  `principal_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `interest_completed_derived` decimal(19,6) DEFAULT NULL,
  `interest_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `interest_waived_derived` decimal(19,6) DEFAULT NULL,
  `accrual_interest_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `fee_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `accrual_fee_charges_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `accrual_penalty_charges_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_in_advance_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_late_derived` decimal(19,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `obligations_met_on_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `recalculated_interest_component` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK488B92AA40BE0710` (`loan_id`),
  CONSTRAINT `FK488B92AA40BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_repayment_schedule`
--

LOCK TABLES `m_loan_repayment_schedule` WRITE;
/*!40000 ALTER TABLE `m_loan_repayment_schedule` DISABLE KEYS */;
INSERT INTO `m_loan_repayment_schedule` VALUES (1,1,'2019-05-04','2019-06-04',2,898.000000,NULL,NULL,274.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(2,1,'2019-11-04','2019-12-04',8,1072.000000,NULL,NULL,100.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(3,1,'2019-06-04','2019-07-04',3,925.000000,NULL,NULL,247.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(4,1,'2019-04-04','2019-05-04',1,872.000000,NULL,NULL,300.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(5,1,'2019-07-04','2019-08-04',4,953.000000,NULL,NULL,219.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(6,1,'2019-08-04','2019-09-04',5,981.000000,NULL,NULL,191.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(7,1,'2019-09-04','2019-10-04',6,1011.000000,NULL,NULL,161.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(8,1,'2019-10-04','2019-11-04',7,1041.000000,NULL,NULL,131.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(9,1,'2019-12-04','2020-01-04',9,1105.000000,NULL,NULL,67.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(10,1,'2020-01-04','2020-02-04',10,1142.000000,NULL,NULL,34.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:33:37','2019-04-04 14:33:37',1,0),(11,2,'2019-09-04','2019-10-04',6,1011.000000,NULL,NULL,161.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(12,2,'2019-12-04','2020-01-04',9,1105.000000,NULL,NULL,67.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(13,2,'2019-10-04','2019-11-04',7,1041.000000,NULL,NULL,131.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(14,2,'2019-06-04','2019-07-04',3,925.000000,NULL,NULL,247.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(15,2,'2019-05-04','2019-06-04',2,898.000000,NULL,NULL,274.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(16,2,'2019-07-04','2019-08-04',4,953.000000,NULL,NULL,219.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(17,2,'2019-08-04','2019-09-04',5,981.000000,NULL,NULL,191.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(18,2,'2019-04-04','2019-05-04',1,872.000000,NULL,NULL,300.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(19,2,'2020-01-04','2020-02-04',10,1142.000000,NULL,NULL,34.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(20,2,'2019-11-04','2019-12-04',8,1072.000000,NULL,NULL,100.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:13','2019-04-04 14:47:13',1,0),(31,3,'2019-04-04','2019-05-04',1,872.000000,872.000000,NULL,300.000000,300.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1172.000000,NULL,'','2019-04-04',1,'2019-04-04 14:47:30','2019-04-04 15:17:28',1,0),(32,3,'2019-05-04','2019-06-04',2,898.000000,NULL,NULL,274.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(33,3,'2019-06-04','2019-07-04',3,925.000000,NULL,NULL,247.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(34,3,'2019-07-04','2019-08-04',4,953.000000,NULL,NULL,219.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(35,3,'2019-08-04','2019-09-04',5,981.000000,NULL,NULL,191.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(36,3,'2019-09-04','2019-10-04',6,1011.000000,NULL,NULL,161.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(37,3,'2019-10-04','2019-11-04',7,1041.000000,NULL,NULL,131.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(38,3,'2019-11-04','2019-12-04',8,1072.000000,NULL,NULL,100.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(39,3,'2019-12-04','2020-01-04',9,1105.000000,NULL,NULL,67.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(40,3,'2020-01-04','2020-02-04',10,1142.000000,NULL,NULL,34.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-04 14:47:30','2019-04-04 14:47:30',1,0),(44,4,'2019-04-26','2019-05-26',1,320.000000,320.000000,NULL,40.000000,40.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,360.000000,NULL,'','2019-04-29',1,'2019-04-26 16:44:57','2019-04-29 09:57:53',1,0),(45,4,'2019-05-26','2019-06-26',2,333.000000,333.000000,NULL,27.000000,27.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,360.000000,NULL,'','2019-04-29',1,'2019-04-26 16:44:57','2019-04-29 09:57:53',1,0),(46,4,'2019-06-26','2019-07-26',3,347.000000,NULL,NULL,14.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-04-26 16:44:57','2019-04-26 16:44:57',1,0),(50,5,'2019-05-07','2019-06-07',1,320.000000,320.000000,NULL,40.000000,40.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,360.000000,NULL,'','2019-05-07',1,'2019-05-07 09:43:24','2019-05-07 09:43:59',1,0),(51,5,'2019-06-07','2019-07-07',2,333.000000,NULL,NULL,27.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-05-07 09:43:24','2019-05-07 09:43:24',1,0),(52,5,'2019-07-07','2019-08-07',3,347.000000,NULL,NULL,14.000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',NULL,1,'2019-05-07 09:43:24','2019-05-07 09:43:24',1,0);
/*!40000 ALTER TABLE `m_loan_repayment_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_repayment_schedule_history`
--

DROP TABLE IF EXISTS `m_loan_repayment_schedule_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_repayment_schedule_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_reschedule_request_id` bigint(20) DEFAULT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `version` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  KEY `loan_reschedule_request_id` (`loan_reschedule_request_id`),
  CONSTRAINT `m_loan_repayment_schedule_history_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `m_loan_repayment_schedule_history_ibfk_2` FOREIGN KEY (`loan_reschedule_request_id`) REFERENCES `m_loan_reschedule_request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_repayment_schedule_history`
--

LOCK TABLES `m_loan_repayment_schedule_history` WRITE;
/*!40000 ALTER TABLE `m_loan_repayment_schedule_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_repayment_schedule_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_reschedule_request`
--

DROP TABLE IF EXISTS `m_loan_reschedule_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_reschedule_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `status_enum` smallint(5) NOT NULL,
  `reschedule_from_installment` smallint(5) NOT NULL COMMENT 'Rescheduling will start from this installment',
  `reschedule_from_date` date NOT NULL COMMENT 'Rescheduling will start from the installment with due date similar to this date.',
  `recalculate_interest` tinyint(1) DEFAULT NULL COMMENT 'If set to 1, interest will be recalculated starting from the reschedule period.',
  `reschedule_reason_cv_id` int(11) DEFAULT NULL COMMENT 'ID of code value of reason for rescheduling',
  `reschedule_reason_comment` varchar(500) DEFAULT NULL COMMENT 'Text provided in addition to the reason code value',
  `submitted_on_date` date NOT NULL,
  `submitted_by_user_id` bigint(20) NOT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) DEFAULT NULL,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  KEY `reschedule_reason_cv_id` (`reschedule_reason_cv_id`),
  KEY `submitted_by_user_id` (`submitted_by_user_id`),
  KEY `approved_by_user_id` (`approved_by_user_id`),
  KEY `rejected_by_user_id` (`rejected_by_user_id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_2` FOREIGN KEY (`reschedule_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_3` FOREIGN KEY (`submitted_by_user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_4` FOREIGN KEY (`approved_by_user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_5` FOREIGN KEY (`rejected_by_user_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_reschedule_request`
--

LOCK TABLES `m_loan_reschedule_request` WRITE;
/*!40000 ALTER TABLE `m_loan_reschedule_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_reschedule_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_reschedule_request_term_variations_mapping`
--

DROP TABLE IF EXISTS `m_loan_reschedule_request_term_variations_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_reschedule_request_term_variations_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_reschedule_request_id` bigint(20) NOT NULL,
  `loan_term_variations_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__m_loan_reschedule_request` (`loan_reschedule_request_id`),
  KEY `FK__m_loan_term_variations` (`loan_term_variations_id`),
  CONSTRAINT `FK__m_loan_reschedule_request` FOREIGN KEY (`loan_reschedule_request_id`) REFERENCES `m_loan_reschedule_request` (`id`),
  CONSTRAINT `FK__m_loan_term_variations` FOREIGN KEY (`loan_term_variations_id`) REFERENCES `m_loan_term_variations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_reschedule_request_term_variations_mapping`
--

LOCK TABLES `m_loan_reschedule_request_term_variations_mapping` WRITE;
/*!40000 ALTER TABLE `m_loan_reschedule_request_term_variations_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_reschedule_request_term_variations_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_term_variations`
--

DROP TABLE IF EXISTS `m_loan_term_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_term_variations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `term_type` smallint(2) NOT NULL,
  `applicable_date` date NOT NULL,
  `decimal_value` decimal(19,6) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `is_specific_to_installment` tinyint(4) NOT NULL DEFAULT '0',
  `applied_on_loan_status` smallint(5) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_loan_id_m_loan_id` (`loan_id`),
  CONSTRAINT `FK_loan_id_m_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_term_variations`
--

LOCK TABLES `m_loan_term_variations` WRITE;
/*!40000 ALTER TABLE `m_loan_term_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_term_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_topup`
--

DROP TABLE IF EXISTS `m_loan_topup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_topup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `closure_loan_id` bigint(20) NOT NULL,
  `account_transfer_details_id` bigint(20) DEFAULT NULL,
  `topup_amount` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_loan_topup_FK_loan_id` (`loan_id`),
  KEY `m_loan_topup_FK_closure_loan_id` (`closure_loan_id`),
  KEY `m_loan_topup_FK_account_transfer_details_id` (`account_transfer_details_id`),
  CONSTRAINT `m_loan_topup_FK_account_transfer_details_id` FOREIGN KEY (`account_transfer_details_id`) REFERENCES `m_account_transfer_details` (`id`),
  CONSTRAINT `m_loan_topup_FK_closure_loan_id` FOREIGN KEY (`closure_loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `m_loan_topup_FK_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_topup`
--

LOCK TABLES `m_loan_topup` WRITE;
/*!40000 ALTER TABLE `m_loan_topup` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_topup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_tranche_charges`
--

DROP TABLE IF EXISTS `m_loan_tranche_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_tranche_charges` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_tranche_charges_m_loan` (`loan_id`),
  KEY `FK_m_loan_tranche_charges_m_charge` (`charge_id`),
  CONSTRAINT `FK_m_loan_tranche_charges_m_charge` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `FK_m_loan_tranche_charges_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_tranche_charges`
--

LOCK TABLES `m_loan_tranche_charges` WRITE;
/*!40000 ALTER TABLE `m_loan_tranche_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_tranche_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_tranche_disbursement_charge`
--

DROP TABLE IF EXISTS `m_loan_tranche_disbursement_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_tranche_disbursement_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `disbursement_detail_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_tranche_disbursement_charge_m_loan_charge` (`loan_charge_id`),
  KEY `FK_m_loan_tranche_disbursement_charge_m_loan_disbursement_detail` (`disbursement_detail_id`),
  CONSTRAINT `FK_m_loan_tranche_disbursement_charge_m_loan_charge` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_m_loan_tranche_disbursement_charge_m_loan_disbursement_detail` FOREIGN KEY (`disbursement_detail_id`) REFERENCES `m_loan_disbursement_detail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_tranche_disbursement_charge`
--

LOCK TABLES `m_loan_tranche_disbursement_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_tranche_disbursement_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_tranche_disbursement_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_transaction`
--

DROP TABLE IF EXISTS `m_loan_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `overpayment_portion_derived` decimal(19,6) DEFAULT NULL,
  `unrecognized_income_portion` decimal(19,6) DEFAULT NULL,
  `outstanding_loan_balance_derived` decimal(19,6) DEFAULT NULL,
  `submitted_on_date` date NOT NULL,
  `manually_adjusted_or_reversed` tinyint(1) DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `appuser_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `FKCFCEA42640BE0710` (`loan_id`),
  KEY `FK_m_loan_transaction_m_payment_detail` (`payment_detail_id`),
  KEY `FK_m_loan_transaction_m_office` (`office_id`),
  CONSTRAINT `FKCFCEA42640BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_m_loan_transaction_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_loan_transaction_m_payment_detail` FOREIGN KEY (`payment_detail_id`) REFERENCES `m_payment_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_transaction`
--

LOCK TABLES `m_loan_transaction` WRITE;
/*!40000 ALTER TABLE `m_loan_transaction` DISABLE KEYS */;
INSERT INTO `m_loan_transaction` VALUES (1,3,1,NULL,0,NULL,1,'2019-04-04',10000.000000,NULL,NULL,NULL,NULL,NULL,NULL,10000.000000,'2019-04-04',0,'2019-04-04 17:46:05',1),(2,3,1,NULL,0,NULL,10,'2019-04-04',1724.000000,NULL,1724.000000,NULL,NULL,NULL,NULL,NULL,'2019-04-04',0,'2019-04-04 17:46:05',1),(3,3,1,NULL,0,NULL,2,'2019-04-04',1172.000000,872.000000,300.000000,NULL,NULL,NULL,NULL,9128.000000,'2019-04-04',0,'2019-04-04 17:47:28',1),(4,4,1,2,0,NULL,1,'2019-04-26',1000.000000,NULL,NULL,NULL,NULL,NULL,NULL,1000.000000,'2019-04-26',0,'2019-04-26 19:15:01',1),(5,4,1,NULL,0,NULL,10,'2019-04-26',81.000000,NULL,81.000000,NULL,NULL,NULL,NULL,NULL,'2019-04-26',0,'2019-04-26 19:15:01',1),(6,4,1,3,0,NULL,2,'2019-04-29',360.000000,320.000000,40.000000,NULL,NULL,NULL,NULL,680.000000,'2019-04-29',0,'2019-04-29 12:27:27',1),(7,4,1,4,0,NULL,2,'2019-04-29',360.000000,333.000000,27.000000,NULL,NULL,NULL,NULL,347.000000,'2019-04-29',0,'2019-04-29 12:27:53',1),(8,5,1,5,0,NULL,1,'2019-05-07',1000.000000,NULL,NULL,NULL,NULL,NULL,NULL,1000.000000,'2019-05-07',0,'2019-05-07 12:13:28',1),(9,5,1,NULL,0,NULL,10,'2019-05-07',81.000000,NULL,81.000000,NULL,NULL,NULL,NULL,NULL,'2019-05-07',0,'2019-05-07 12:13:28',1),(10,5,1,6,0,NULL,2,'2019-05-07',360.000000,320.000000,40.000000,NULL,NULL,NULL,NULL,680.000000,'2019-05-07',0,'2019-05-07 12:13:59',1);
/*!40000 ALTER TABLE `m_loan_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_transaction_repayment_schedule_mapping`
--

DROP TABLE IF EXISTS `m_loan_transaction_repayment_schedule_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_transaction_repayment_schedule_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_transaction_id` bigint(20) NOT NULL,
  `loan_repayment_schedule_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_loan_transaction` (`loan_transaction_id`),
  KEY `FK_mappings_m_loan_repayment_schedule` (`loan_repayment_schedule_id`),
  CONSTRAINT `FK_mappings_m_loan_repayment_schedule` FOREIGN KEY (`loan_repayment_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`),
  CONSTRAINT `FK_mappings_m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_transaction_repayment_schedule_mapping`
--

LOCK TABLES `m_loan_transaction_repayment_schedule_mapping` WRITE;
/*!40000 ALTER TABLE `m_loan_transaction_repayment_schedule_mapping` DISABLE KEYS */;
INSERT INTO `m_loan_transaction_repayment_schedule_mapping` VALUES (1,3,31,1172.000000,872.000000,300.000000,NULL,NULL),(2,6,44,360.000000,320.000000,40.000000,NULL,NULL),(3,7,45,360.000000,333.000000,27.000000,NULL,NULL),(4,10,50,360.000000,320.000000,40.000000,NULL,NULL);
/*!40000 ALTER TABLE `m_loan_transaction_repayment_schedule_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loanproduct_provisioning_entry`
--

DROP TABLE IF EXISTS `m_loanproduct_provisioning_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loanproduct_provisioning_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `history_id` bigint(20) NOT NULL,
  `criteria_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `overdue_in_days` bigint(20) DEFAULT '0',
  `reseve_amount` decimal(20,6) DEFAULT '0.000000',
  `liability_account` bigint(20) DEFAULT NULL,
  `expense_account` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `history_id` (`history_id`),
  KEY `criteria_id` (`criteria_id`),
  KEY `office_id` (`office_id`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `liability_account` (`liability_account`),
  KEY `expense_account` (`expense_account`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_1` FOREIGN KEY (`history_id`) REFERENCES `m_provisioning_history` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_2` FOREIGN KEY (`criteria_id`) REFERENCES `m_provisioning_criteria` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_3` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_5` FOREIGN KEY (`category_id`) REFERENCES `m_provision_category` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_6` FOREIGN KEY (`liability_account`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_7` FOREIGN KEY (`expense_account`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loanproduct_provisioning_entry`
--

LOCK TABLES `m_loanproduct_provisioning_entry` WRITE;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loanproduct_provisioning_mapping`
--

DROP TABLE IF EXISTS `m_loanproduct_provisioning_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loanproduct_provisioning_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `criteria_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `criteria_id` (`criteria_id`),
  CONSTRAINT `m_loanproduct_provisioning_mapping_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_mapping_ibfk_2` FOREIGN KEY (`criteria_id`) REFERENCES `m_provisioning_criteria` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loanproduct_provisioning_mapping`
--

LOCK TABLES `m_loanproduct_provisioning_mapping` WRITE;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_mandatory_savings_schedule`
--

DROP TABLE IF EXISTS `m_mandatory_savings_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_mandatory_savings_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  `deposit_amount_completed_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_in_advance_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_late_derived` decimal(19,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `obligations_met_on_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKMSS0000000001` (`savings_account_id`),
  CONSTRAINT `FKMSS0000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_mandatory_savings_schedule`
--

LOCK TABLES `m_mandatory_savings_schedule` WRITE;
/*!40000 ALTER TABLE `m_mandatory_savings_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_mandatory_savings_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_meeting`
--

DROP TABLE IF EXISTS `m_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_meeting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_instance_id` bigint(20) NOT NULL,
  `meeting_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_calendar_instance_id_meeting_date` (`calendar_instance_id`,`meeting_date`),
  CONSTRAINT `FK_m_calendar_instance_m_meeting` FOREIGN KEY (`calendar_instance_id`) REFERENCES `m_calendar_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_meeting`
--

LOCK TABLES `m_meeting` WRITE;
/*!40000 ALTER TABLE `m_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_note`
--

DROP TABLE IF EXISTS `m_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `savings_account_transaction_id` bigint(20) DEFAULT NULL,
  `share_account_id` bigint(20) DEFAULT NULL,
  `note_type_enum` smallint(5) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7C9708924D26803` (`loan_transaction_id`),
  KEY `FK7C97089541F0A56` (`createdby_id`),
  KEY `FK7C970897179A0CB` (`client_id`),
  KEY `FK_m_note_m_group` (`group_id`),
  KEY `FK7C970898F889C3F` (`lastmodifiedby_id`),
  KEY `FK7C9708940BE0710` (`loan_id`),
  KEY `FK_savings_account_id` (`savings_account_id`),
  CONSTRAINT `FK7C9708924D26803` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK7C9708940BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK7C97089541F0A56` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK7C970897179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK7C970898F889C3F` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_note_m_group` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_savings_account_id` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_note`
--

LOCK TABLES `m_note` WRITE;
/*!40000 ALTER TABLE `m_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office`
--

DROP TABLE IF EXISTS `m_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `opening_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_org` (`name`),
  UNIQUE KEY `externalid_org` (`external_id`),
  KEY `FK2291C477E2551DCC` (`parent_id`),
  CONSTRAINT `FK2291C477E2551DCC` FOREIGN KEY (`parent_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office`
--

LOCK TABLES `m_office` WRITE;
/*!40000 ALTER TABLE `m_office` DISABLE KEYS */;
INSERT INTO `m_office` VALUES (1,NULL,'.','1','Head Office','2009-01-01'),(2,1,'.2.','2','BARINGO','2009-01-01'),(3,1,'.3.','3','BOMET','2009-01-01'),(4,1,'.4.','4','BONDO','2009-01-01'),(5,1,'.5.','5','BUNGOMA','2009-01-01'),(6,1,'.6.','6','BUSIA','2009-01-01'),(7,1,'.7.','7','ELDORET','2009-01-01'),(8,1,'.8.','8','EWUASO KAJIADO','2009-01-01'),(9,1,'.9.','9','HOLA','2009-01-01'),(10,1,'.10.','10','KANGUNDO','2009-01-01'),(11,1,'.11.','11','KAYOLE','2009-01-01'),(12,1,'.12.','12','KIKUYU','2009-01-01'),(13,1,'.13.','13','KILIFI','2009-01-01'),(14,1,'.14.','14','KISERIAN','2009-01-01'),(15,1,'.15.','15','KISII','2009-01-01'),(16,1,'.16.','16','KISUMU','2009-01-01'),(18,1,'.18.','18','KISUMU LUANDA','2009-01-01'),(19,1,'.19.','19','KITALE','2009-01-01'),(20,1,'.20.','20','KUKU MOJA','2009-01-01'),(21,1,'.21.','21','LAMU','2009-01-01'),(22,1,'.22.','22','LODWAR','2009-01-01'),(23,1,'.23.','23','MACHAKOS','2009-01-01'),(24,1,'.24.','24','MALINDI','2009-01-01'),(25,1,'.25.','25','MERU','2009-01-01'),(26,1,'.26.','26','MIGORI','2009-01-01'),(27,1,'.27.','27','MITABONI','2009-01-01'),(28,1,'.28.','28','MOGOTIOS','2009-01-01'),(29,1,'.29.','29','MOMBASA','2009-01-01'),(30,1,'.30.','30','MPEKETONI','2009-01-01'),(31,1,'.31.','31','MUMIAS','2009-01-01'),(32,1,'.32.','32','MURANG\'A','2009-01-01'),(34,1,'.34.','34','NAKURU','2009-01-01'),(35,1,'.35.','35','NAMANGA','2009-01-01'),(36,1,'.36.','36','NANYUKI','2009-01-01'),(37,1,'.37.','37','NGOLENI','2009-01-01'),(38,1,'.38.','38','NGONG','2009-01-01'),(39,1,'.39.','39','NGONG ROAD','2009-01-01'),(40,1,'.40.','40','NYAHURURU','2009-01-01'),(41,1,'.41.','41','PORT VICTORIA','2009-01-01'),(43,1,'.43.','43','RUIRU','2009-01-01'),(44,1,'.44.','44','SIAYA','2009-01-01'),(45,1,'.45.','45','TAVETA','2009-01-01'),(46,1,'.46.','46','THIKA','2009-01-01'),(47,1,'.47.','47','VIHIGA','2009-01-01'),(48,1,'.48.','48','VOI','2009-01-01'),(49,1,'.49.','CITYCORP','CITY HQ','2016-12-01'),(50,1,'.50.',NULL,'Sales Representatives','2019-01-01');
/*!40000 ALTER TABLE `m_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office_transaction`
--

DROP TABLE IF EXISTS `m_office_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) DEFAULT NULL,
  `to_office_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `transaction_amount` decimal(19,6) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E37728B93C6C1B6` (`to_office_id`),
  KEY `FK1E37728B783C5C25` (`from_office_id`),
  CONSTRAINT `FK1E37728B783C5C25` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK1E37728B93C6C1B6` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office_transaction`
--

LOCK TABLES `m_office_transaction` WRITE;
/*!40000 ALTER TABLE `m_office_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_office_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_organisation_creditbureau`
--

DROP TABLE IF EXISTS `m_organisation_creditbureau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_organisation_creditbureau` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alias` varchar(50) NOT NULL,
  `creditbureau_id` bigint(20) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `morgcb` (`alias`,`creditbureau_id`),
  KEY `orgcb_cbfk` (`creditbureau_id`),
  CONSTRAINT `orgcb_cbfk` FOREIGN KEY (`creditbureau_id`) REFERENCES `m_creditbureau` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_organisation_creditbureau`
--

LOCK TABLES `m_organisation_creditbureau` WRITE;
/*!40000 ALTER TABLE `m_organisation_creditbureau` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_organisation_creditbureau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_organisation_currency`
--

DROP TABLE IF EXISTS `m_organisation_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_organisation_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_organisation_currency`
--

LOCK TABLES `m_organisation_currency` WRITE;
/*!40000 ALTER TABLE `m_organisation_currency` DISABLE KEYS */;
INSERT INTO `m_organisation_currency` VALUES (21,'USD',2,NULL,'US Dollar','$','currency.USD');
/*!40000 ALTER TABLE `m_organisation_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_password_validation_policy`
--

DROP TABLE IF EXISTS `m_password_validation_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_password_validation_policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `regex` text NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_password_validation_policy`
--

LOCK TABLES `m_password_validation_policy` WRITE;
/*!40000 ALTER TABLE `m_password_validation_policy` DISABLE KEYS */;
INSERT INTO `m_password_validation_policy` VALUES (1,'^.{1,50}$','Password most be at least 1 character and not more that 50 characters long',1,'simple'),(2,'^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).{6,50}$','Password must be at least 6 characters, no more than 50 characters long, must include at least one upper case letter, one lower case letter, one numeric digit and no space',0,'secure');
/*!40000 ALTER TABLE `m_password_validation_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_payment_detail`
--

DROP TABLE IF EXISTS `m_payment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_payment_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_type_id` int(11) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `check_number` varchar(100) DEFAULT NULL,
  `receipt_number` varchar(100) DEFAULT NULL,
  `bank_number` varchar(100) DEFAULT NULL,
  `routing_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_payment_detail_m_payment_type` (`payment_type_id`),
  CONSTRAINT `FK_m_payment_detail_m_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `m_payment_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_payment_detail`
--

LOCK TABLES `m_payment_detail` WRITE;
/*!40000 ALTER TABLE `m_payment_detail` DISABLE KEYS */;
INSERT INTO `m_payment_detail` VALUES (1,NULL,'1','test','test','test',NULL),(2,1,'','','','',''),(3,4,'','','ethryu','rtuityty',''),(4,4,'','','test','test',''),(5,1,'','','','',''),(6,4,'','','MBL0UW55K8','MBL0UW55K8','');
/*!40000 ALTER TABLE `m_payment_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_payment_type`
--

DROP TABLE IF EXISTS `m_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_payment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `is_cash_payment` tinyint(1) DEFAULT '0',
  `order_position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_payment_type`
--

LOCK TABLES `m_payment_type` WRITE;
/*!40000 ALTER TABLE `m_payment_type` DISABLE KEYS */;
INSERT INTO `m_payment_type` VALUES (1,'Cash','cash',1,1),(2,'Cheque','cheque',0,2),(3,'Credit','credit',0,3),(4,'Mpesa','mpesa',1,4);
/*!40000 ALTER TABLE `m_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_permission`
--

DROP TABLE IF EXISTS `m_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grouping` varchar(45) DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  `entity_name` varchar(100) DEFAULT NULL,
  `action_name` varchar(100) DEFAULT NULL,
  `can_maker_checker` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=868 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_permission`
--

LOCK TABLES `m_permission` WRITE;
/*!40000 ALTER TABLE `m_permission` DISABLE KEYS */;
INSERT INTO `m_permission` VALUES (1,'special','ALL_FUNCTIONS',NULL,NULL,0),(2,'special','ALL_FUNCTIONS_READ',NULL,NULL,0),(3,'special','CHECKER_SUPER_USER',NULL,NULL,0),(4,'special','REPORTING_SUPER_USER',NULL,NULL,0),(5,'authorisation','READ_PERMISSION','PERMISSION','READ',0),(6,'authorisation','PERMISSIONS_ROLE','ROLE','PERMISSIONS',0),(7,'authorisation','CREATE_ROLE','ROLE','CREATE',0),(8,'authorisation','CREATE_ROLE_CHECKER','ROLE','CREATE_CHECKER',0),(9,'authorisation','READ_ROLE','ROLE','READ',0),(10,'authorisation','UPDATE_ROLE','ROLE','UPDATE',0),(11,'authorisation','UPDATE_ROLE_CHECKER','ROLE','UPDATE_CHECKER',0),(12,'authorisation','DELETE_ROLE','ROLE','DELETE',0),(13,'authorisation','DELETE_ROLE_CHECKER','ROLE','DELETE_CHECKER',0),(14,'authorisation','CREATE_USER','USER','CREATE',0),(15,'authorisation','CREATE_USER_CHECKER','USER','CREATE_CHECKER',0),(16,'authorisation','READ_USER','USER','READ',0),(17,'authorisation','UPDATE_USER','USER','UPDATE',0),(18,'authorisation','UPDATE_USER_CHECKER','USER','UPDATE_CHECKER',0),(19,'authorisation','DELETE_USER','USER','DELETE',0),(20,'authorisation','DELETE_USER_CHECKER','USER','DELETE_CHECKER',0),(21,'configuration','READ_CONFIGURATION','CONFIGURATION','READ',0),(22,'configuration','UPDATE_CONFIGURATION','CONFIGURATION','UPDATE',0),(23,'configuration','UPDATE_CONFIGURATION_CHECKER','CONFIGURATION','UPDATE_CHECKER',0),(24,'configuration','READ_CODE','CODE','READ',0),(25,'configuration','CREATE_CODE','CODE','CREATE',0),(26,'configuration','CREATE_CODE_CHECKER','CODE','CREATE_CHECKER',0),(27,'configuration','UPDATE_CODE','CODE','UPDATE',0),(28,'configuration','UPDATE_CODE_CHECKER','CODE','UPDATE_CHECKER',0),(29,'configuration','DELETE_CODE','CODE','DELETE',0),(30,'configuration','DELETE_CODE_CHECKER','CODE','DELETE_CHECKER',0),(31,'configuration','READ_CODEVALUE','CODEVALUE','READ',0),(32,'configuration','CREATE_CODEVALUE','CODEVALUE','CREATE',0),(33,'configuration','CREATE_CODEVALUE_CHECKER','CODEVALUE','CREATE_CHECKER',0),(34,'configuration','UPDATE_CODEVALUE','CODEVALUE','UPDATE',0),(35,'configuration','UPDATE_CODEVALUE_CHECKER','CODEVALUE','UPDATE_CHECKER',0),(36,'configuration','DELETE_CODEVALUE','CODEVALUE','DELETE',0),(37,'configuration','DELETE_CODEVALUE_CHECKER','CODEVALUE','DELETE_CHECKER',0),(38,'configuration','READ_CURRENCY','CURRENCY','READ',0),(39,'configuration','UPDATE_CURRENCY','CURRENCY','UPDATE',0),(40,'configuration','UPDATE_CURRENCY_CHECKER','CURRENCY','UPDATE_CHECKER',0),(41,'configuration','UPDATE_PERMISSION','PERMISSION','UPDATE',0),(42,'configuration','UPDATE_PERMISSION_CHECKER','PERMISSION','UPDATE_CHECKER',0),(43,'configuration','READ_DATATABLE','DATATABLE','READ',0),(44,'configuration','REGISTER_DATATABLE','DATATABLE','REGISTER',0),(45,'configuration','REGISTER_DATATABLE_CHECKER','DATATABLE','REGISTER_CHECKER',0),(46,'configuration','DEREGISTER_DATATABLE','DATATABLE','DEREGISTER',0),(47,'configuration','DEREGISTER_DATATABLE_CHECKER','DATATABLE','DEREGISTER_CHECKER',0),(48,'configuration','READ_AUDIT','AUDIT','READ',0),(49,'configuration','CREATE_CALENDAR','CALENDAR','CREATE',0),(50,'configuration','READ_CALENDAR','CALENDAR','READ',0),(51,'configuration','UPDATE_CALENDAR','CALENDAR','UPDATE',0),(52,'configuration','DELETE_CALENDAR','CALENDAR','DELETE',0),(53,'configuration','CREATE_CALENDAR_CHECKER','CALENDAR','CREATE_CHECKER',0),(54,'configuration','UPDATE_CALENDAR_CHECKER','CALENDAR','UPDATE_CHECKER',0),(55,'configuration','DELETE_CALENDAR_CHECKER','CALENDAR','DELETE_CHECKER',0),(57,'organisation','READ_CHARGE','CHARGE','READ',0),(58,'organisation','CREATE_CHARGE','CHARGE','CREATE',0),(59,'organisation','CREATE_CHARGE_CHECKER','CHARGE','CREATE_CHECKER',0),(60,'organisation','UPDATE_CHARGE','CHARGE','UPDATE',0),(61,'organisation','UPDATE_CHARGE_CHECKER','CHARGE','UPDATE_CHECKER',0),(62,'organisation','DELETE_CHARGE','CHARGE','DELETE',0),(63,'organisation','DELETE_CHARGE_CHECKER','CHARGE','DELETE_CHECKER',0),(64,'organisation','READ_FUND','FUND','READ',0),(65,'organisation','CREATE_FUND','FUND','CREATE',0),(66,'organisation','CREATE_FUND_CHECKER','FUND','CREATE_CHECKER',0),(67,'organisation','UPDATE_FUND','FUND','UPDATE',0),(68,'organisation','UPDATE_FUND_CHECKER','FUND','UPDATE_CHECKER',0),(69,'organisation','DELETE_FUND','FUND','DELETE',0),(70,'organisation','DELETE_FUND_CHECKER','FUND','DELETE_CHECKER',0),(71,'organisation','READ_LOANPRODUCT','LOANPRODUCT','READ',0),(72,'organisation','CREATE_LOANPRODUCT','LOANPRODUCT','CREATE',0),(73,'organisation','CREATE_LOANPRODUCT_CHECKER','LOANPRODUCT','CREATE_CHECKER',0),(74,'organisation','UPDATE_LOANPRODUCT','LOANPRODUCT','UPDATE',0),(75,'organisation','UPDATE_LOANPRODUCT_CHECKER','LOANPRODUCT','UPDATE_CHECKER',0),(76,'organisation','DELETE_LOANPRODUCT','LOANPRODUCT','DELETE',0),(77,'organisation','DELETE_LOANPRODUCT_CHECKER','LOANPRODUCT','DELETE_CHECKER',0),(78,'organisation','READ_OFFICE','OFFICE','READ',0),(79,'organisation','CREATE_OFFICE','OFFICE','CREATE',0),(80,'organisation','CREATE_OFFICE_CHECKER','OFFICE','CREATE_CHECKER',0),(81,'organisation','UPDATE_OFFICE','OFFICE','UPDATE',0),(82,'organisation','UPDATE_OFFICE_CHECKER','OFFICE','UPDATE_CHECKER',0),(83,'organisation','READ_OFFICETRANSACTION','OFFICETRANSACTION','READ',0),(84,'organisation','DELETE_OFFICE_CHECKER','OFFICE','DELETE_CHECKER',0),(85,'organisation','CREATE_OFFICETRANSACTION','OFFICETRANSACTION','CREATE',0),(86,'organisation','CREATE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','CREATE_CHECKER',0),(87,'organisation','DELETE_OFFICETRANSACTION','OFFICETRANSACTION','DELETE',0),(88,'organisation','DELETE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','DELETE_CHECKER',0),(89,'organisation','READ_STAFF','STAFF','READ',0),(90,'organisation','CREATE_STAFF','STAFF','CREATE',0),(91,'organisation','CREATE_STAFF_CHECKER','STAFF','CREATE_CHECKER',0),(92,'organisation','UPDATE_STAFF','STAFF','UPDATE',0),(93,'organisation','UPDATE_STAFF_CHECKER','STAFF','UPDATE_CHECKER',0),(94,'organisation','DELETE_STAFF','STAFF','DELETE',0),(95,'organisation','DELETE_STAFF_CHECKER','STAFF','DELETE_CHECKER',0),(96,'organisation','READ_SAVINGSPRODUCT','SAVINGSPRODUCT','READ',0),(97,'organisation','CREATE_SAVINGSPRODUCT','SAVINGSPRODUCT','CREATE',0),(98,'organisation','CREATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','CREATE_CHECKER',0),(99,'organisation','UPDATE_SAVINGSPRODUCT','SAVINGSPRODUCT','UPDATE',0),(100,'organisation','UPDATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','UPDATE_CHECKER',0),(101,'organisation','DELETE_SAVINGSPRODUCT','SAVINGSPRODUCT','DELETE',0),(102,'organisation','DELETE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','DELETE_CHECKER',0),(103,'portfolio','READ_LOAN','LOAN','READ',0),(104,'portfolio','CREATE_LOAN','LOAN','CREATE',0),(105,'portfolio','CREATE_LOAN_CHECKER','LOAN','CREATE_CHECKER',0),(106,'portfolio','UPDATE_LOAN','LOAN','UPDATE',0),(107,'portfolio','UPDATE_LOAN_CHECKER','LOAN','UPDATE_CHECKER',0),(108,'portfolio','DELETE_LOAN','LOAN','DELETE',0),(109,'portfolio','DELETE_LOAN_CHECKER','LOAN','DELETE_CHECKER',0),(110,'portfolio','READ_CLIENT','CLIENT','READ',0),(111,'portfolio','CREATE_CLIENT','CLIENT','CREATE',0),(112,'portfolio','CREATE_CLIENT_CHECKER','CLIENT','CREATE_CHECKER',0),(113,'portfolio','UPDATE_CLIENT','CLIENT','UPDATE',0),(114,'portfolio','UPDATE_CLIENT_CHECKER','CLIENT','UPDATE_CHECKER',0),(115,'portfolio','DELETE_CLIENT','CLIENT','DELETE',0),(116,'portfolio','DELETE_CLIENT_CHECKER','CLIENT','DELETE_CHECKER',0),(117,'portfolio','READ_CLIENTIMAGE','CLIENTIMAGE','READ',0),(118,'portfolio','CREATE_CLIENTIMAGE','CLIENTIMAGE','CREATE',0),(119,'portfolio','CREATE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','CREATE_CHECKER',0),(120,'portfolio','DELETE_CLIENTIMAGE','CLIENTIMAGE','DELETE',0),(121,'portfolio','DELETE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','DELETE_CHECKER',0),(122,'portfolio','READ_CLIENTNOTE','CLIENTNOTE','READ',0),(123,'portfolio','CREATE_CLIENTNOTE','CLIENTNOTE','CREATE',0),(124,'portfolio','CREATE_CLIENTNOTE_CHECKER','CLIENTNOTE','CREATE_CHECKER',0),(125,'portfolio','UPDATE_CLIENTNOTE','CLIENTNOTE','UPDATE',0),(126,'portfolio','UPDATE_CLIENTNOTE_CHECKER','CLIENTNOTE','UPDATE_CHECKER',0),(127,'portfolio','DELETE_CLIENTNOTE','CLIENTNOTE','DELETE',0),(128,'portfolio','DELETE_CLIENTNOTE_CHECKER','CLIENTNOTE','DELETE_CHECKER',0),(129,'portfolio_group','READ_GROUPNOTE','GROUPNOTE','READ',0),(130,'portfolio_group','CREATE_GROUPNOTE','GROUPNOTE','CREATE',0),(131,'portfolio_group','UPDATE_GROUPNOTE','GROUPNOTE','UPDATE',0),(132,'portfolio_group','DELETE_GROUPNOTE','GROUPNOTE','DELETE',0),(133,'portfolio_group','CREATE_GROUPNOTE_CHECKER','GROUPNOTE','CREATE_CHECKER',0),(134,'portfolio_group','UPDATE_GROUPNOTE_CHECKER','GROUPNOTE','UPDATE_CHECKER',0),(135,'portfolio_group','DELETE_GROUPNOTE_CHECKER','GROUPNOTE','DELETE_CHECKER',0),(136,'portfolio','READ_LOANNOTE','LOANNOTE','READ',0),(137,'portfolio','CREATE_LOANNOTE','LOANNOTE','CREATE',0),(138,'portfolio','UPDATE_LOANNOTE','LOANNOTE','UPDATE',0),(139,'portfolio','DELETE_LOANNOTE','LOANNOTE','DELETE',0),(140,'portfolio','CREATE_LOANNOTE_CHECKER','LOANNOTE','CREATE_CHECKER',0),(141,'portfolio','UPDATE_LOANNOTE_CHECKER','LOANNOTE','UPDATE_CHECKER',0),(142,'portfolio','DELETE_LOANNOTE_CHECKER','LOANNOTE','DELETE_CHECKER',0),(143,'portfolio','READ_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','READ',0),(144,'portfolio','CREATE_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','CREATE',0),(145,'portfolio','UPDATE_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','UPDATE',0),(146,'portfolio','DELETE_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','DELETE',0),(147,'portfolio','CREATE_LOANTRANSACTIONNOTE_CHECKER','LOANTRANSACTIONNOTE','CREATE_CHECKER',0),(148,'portfolio','UPDATE_LOANTRANSACTIONNOTE_CHECKER','LOANTRANSACTIONNOTE','UPDATE_CHECKER',0),(149,'portfolio','DELETE_LOANTRANSACTIONNOTE_CHECKER','LOANTRANSACTIONNOTE','DELETE_CHECKER',0),(150,'portfolio','READ_SAVINGNOTE','SAVINGNOTE','READ',0),(151,'portfolio','CREATE_SAVINGNOTE','SAVINGNOTE','CREATE',0),(152,'portfolio','UPDATE_SAVINGNOTE','SAVINGNOTE','UPDATE',0),(153,'portfolio','DELETE_SAVINGNOTE','SAVINGNOTE','DELETE',0),(154,'portfolio','CREATE_SAVINGNOTE_CHECKER','SAVINGNOTE','CREATE_CHECKER',0),(155,'portfolio','UPDATE_SAVINGNOTE_CHECKER','SAVINGNOTE','UPDATE_CHECKER',0),(156,'portfolio','DELETE_SAVINGNOTE_CHECKER','SAVINGNOTE','DELETE_CHECKER',0),(157,'portfolio','READ_CLIENTIDENTIFIER','CLIENTIDENTIFIER','READ',0),(158,'portfolio','CREATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','CREATE',0),(159,'portfolio','CREATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','CREATE_CHECKER',0),(160,'portfolio','UPDATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','UPDATE',0),(161,'portfolio','UPDATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','UPDATE_CHECKER',0),(162,'portfolio','DELETE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','DELETE',0),(163,'portfolio','DELETE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','DELETE_CHECKER',0),(164,'portfolio','READ_DOCUMENT','DOCUMENT','READ',0),(165,'portfolio','CREATE_DOCUMENT','DOCUMENT','CREATE',0),(166,'portfolio','CREATE_DOCUMENT_CHECKER','DOCUMENT','CREATE_CHECKER',0),(167,'portfolio','UPDATE_DOCUMENT','DOCUMENT','UPDATE',0),(168,'portfolio','UPDATE_DOCUMENT_CHECKER','DOCUMENT','UPDATE_CHECKER',0),(169,'portfolio','DELETE_DOCUMENT','DOCUMENT','DELETE',0),(170,'portfolio','DELETE_DOCUMENT_CHECKER','DOCUMENT','DELETE_CHECKER',0),(171,'portfolio_group','READ_GROUP','GROUP','READ',0),(172,'portfolio_group','CREATE_GROUP','GROUP','CREATE',0),(173,'portfolio_group','CREATE_GROUP_CHECKER','GROUP','CREATE_CHECKER',0),(174,'portfolio_group','UPDATE_GROUP','GROUP','UPDATE',0),(175,'portfolio_group','UPDATE_GROUP_CHECKER','GROUP','UPDATE_CHECKER',0),(176,'portfolio_group','DELETE_GROUP','GROUP','DELETE',0),(177,'portfolio_group','DELETE_GROUP_CHECKER','GROUP','DELETE_CHECKER',0),(178,'portfolio_group','UNASSIGNSTAFF_GROUP','GROUP','UNASSIGNSTAFF',0),(179,'portfolio_group','UNASSIGNSTAFF_GROUP_CHECKER','GROUP','UNASSIGNSTAFF_CHECKER',0),(180,'portfolio','CREATE_LOANCHARGE','LOANCHARGE','CREATE',0),(181,'portfolio','CREATE_LOANCHARGE_CHECKER','LOANCHARGE','CREATE_CHECKER',0),(182,'portfolio','UPDATE_LOANCHARGE','LOANCHARGE','UPDATE',0),(183,'portfolio','UPDATE_LOANCHARGE_CHECKER','LOANCHARGE','UPDATE_CHECKER',0),(184,'portfolio','DELETE_LOANCHARGE','LOANCHARGE','DELETE',0),(185,'portfolio','DELETE_LOANCHARGE_CHECKER','LOANCHARGE','DELETE_CHECKER',0),(186,'portfolio','WAIVE_LOANCHARGE','LOANCHARGE','WAIVE',0),(187,'portfolio','WAIVE_LOANCHARGE_CHECKER','LOANCHARGE','WAIVE_CHECKER',0),(188,'portfolio','READ_SAVINGSACCOUNT','SAVINGSACCOUNT','READ',0),(189,'portfolio','CREATE_SAVINGSACCOUNT','SAVINGSACCOUNT','CREATE',0),(190,'portfolio','CREATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CREATE_CHECKER',0),(191,'portfolio','UPDATE_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATE',0),(192,'portfolio','UPDATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UPDATE_CHECKER',0),(193,'portfolio','DELETE_SAVINGSACCOUNT','SAVINGSACCOUNT','DELETE',0),(194,'portfolio','DELETE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','DELETE_CHECKER',0),(195,'portfolio','READ_GUARANTOR','GUARANTOR','READ',0),(196,'portfolio','CREATE_GUARANTOR','GUARANTOR','CREATE',0),(197,'portfolio','CREATE_GUARANTOR_CHECKER','GUARANTOR','CREATE_CHECKER',0),(198,'portfolio','UPDATE_GUARANTOR','GUARANTOR','UPDATE',0),(199,'portfolio','UPDATE_GUARANTOR_CHECKER','GUARANTOR','UPDATE_CHECKER',0),(200,'portfolio','DELETE_GUARANTOR','GUARANTOR','DELETE',0),(201,'portfolio','DELETE_GUARANTOR_CHECKER','GUARANTOR','DELETE_CHECKER',0),(202,'portfolio','READ_COLLATERAL','COLLATERAL','READ',0),(203,'portfolio','CREATE_COLLATERAL','COLLATERAL','CREATE',0),(204,'portfolio','UPDATE_COLLATERAL','COLLATERAL','UPDATE',0),(205,'portfolio','DELETE_COLLATERAL','COLLATERAL','DELETE',0),(206,'portfolio','CREATE_COLLATERAL_CHECKER','COLLATERAL','CREATE_CHECKER',0),(207,'portfolio','UPDATE_COLLATERAL_CHECKER','COLLATERAL','UPDATE_CHECKER',0),(208,'portfolio','DELETE_COLLATERAL_CHECKER','COLLATERAL','DELETE_CHECKER',0),(209,'transaction_loan','APPROVE_LOAN','LOAN','APPROVE',0),(211,'transaction_loan','REJECT_LOAN','LOAN','REJECT',0),(213,'transaction_loan','WITHDRAW_LOAN','LOAN','WITHDRAW',0),(215,'transaction_loan','APPROVALUNDO_LOAN','LOAN','APPROVALUNDO',0),(216,'transaction_loan','DISBURSE_LOAN','LOAN','DISBURSE',0),(218,'transaction_loan','DISBURSALUNDO_LOAN','LOAN','DISBURSALUNDO',0),(219,'transaction_loan','REPAYMENT_LOAN','LOAN','REPAYMENT',0),(221,'transaction_loan','ADJUST_LOAN','LOAN','ADJUST',0),(222,'transaction_loan','WAIVEINTERESTPORTION_LOAN','LOAN','WAIVEINTERESTPORTION',0),(223,'transaction_loan','WRITEOFF_LOAN','LOAN','WRITEOFF',0),(224,'transaction_loan','CLOSE_LOAN','LOAN','CLOSE',0),(225,'transaction_loan','CLOSEASRESCHEDULED_LOAN','LOAN','CLOSEASRESCHEDULED',0),(226,'transaction_loan','UPDATELOANOFFICER_LOAN','LOAN','UPDATELOANOFFICER',0),(227,'transaction_loan','UPDATELOANOFFICER_LOAN_CHECKER','LOAN','UPDATELOANOFFICER_CHECKER',0),(228,'transaction_loan','REMOVELOANOFFICER_LOAN','LOAN','REMOVELOANOFFICER',0),(229,'transaction_loan','REMOVELOANOFFICER_LOAN_CHECKER','LOAN','REMOVELOANOFFICER_CHECKER',0),(230,'transaction_loan','BULKREASSIGN_LOAN','LOAN','BULKREASSIGN',0),(231,'transaction_loan','BULKREASSIGN_LOAN_CHECKER','LOAN','BULKREASSIGN_CHECKER',0),(232,'transaction_loan','APPROVE_LOAN_CHECKER','LOAN','APPROVE_CHECKER',0),(234,'transaction_loan','REJECT_LOAN_CHECKER','LOAN','REJECT_CHECKER',0),(236,'transaction_loan','WITHDRAW_LOAN_CHECKER','LOAN','WITHDRAW_CHECKER',0),(238,'transaction_loan','APPROVALUNDO_LOAN_CHECKER','LOAN','APPROVALUNDO_CHECKER',0),(239,'transaction_loan','DISBURSE_LOAN_CHECKER','LOAN','DISBURSE_CHECKER',0),(241,'transaction_loan','DISBURSALUNDO_LOAN_CHECKER','LOAN','DISBURSALUNDO_CHECKER',0),(242,'transaction_loan','REPAYMENT_LOAN_CHECKER','LOAN','REPAYMENT_CHECKER',0),(244,'transaction_loan','ADJUST_LOAN_CHECKER','LOAN','ADJUST_CHECKER',0),(245,'transaction_loan','WAIVEINTERESTPORTION_LOAN_CHECKER','LOAN','WAIVEINTERESTPORTION_CHECKER',0),(246,'transaction_loan','WRITEOFF_LOAN_CHECKER','LOAN','WRITEOFF_CHECKER',0),(247,'transaction_loan','CLOSE_LOAN_CHECKER','LOAN','CLOSE_CHECKER',0),(248,'transaction_loan','CLOSEASRESCHEDULED_LOAN_CHECKER','LOAN','CLOSEASRESCHEDULED_CHECKER',0),(249,'transaction_savings','DEPOSIT_SAVINGSACCOUNT','SAVINGSACCOUNT','DEPOSIT',0),(250,'transaction_savings','DEPOSIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','DEPOSIT_CHECKER',0),(251,'transaction_savings','WITHDRAWAL_SAVINGSACCOUNT','SAVINGSACCOUNT','WITHDRAWAL',0),(252,'transaction_savings','WITHDRAWAL_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','WITHDRAWAL_CHECKER',0),(253,'transaction_savings','ACTIVATE_SAVINGSACCOUNT','SAVINGSACCOUNT','ACTIVATE',0),(254,'transaction_savings','ACTIVATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','ACTIVATE_CHECKER',0),(255,'transaction_savings','CALCULATEINTEREST_SAVINGSACCOUNT','SAVINGSACCOUNT','CALCULATEINTEREST',0),(256,'transaction_savings','CALCULATEINTEREST_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CALCULATEINTEREST_CHECKER',0),(257,'accounting','CREATE_GLACCOUNT','GLACCOUNT','CREATE',0),(258,'accounting','UPDATE_GLACCOUNT','GLACCOUNT','UPDATE',0),(259,'accounting','DELETE_GLACCOUNT','GLACCOUNT','DELETE',0),(260,'accounting','CREATE_GLCLOSURE','GLCLOSURE','CREATE',0),(261,'accounting','UPDATE_GLCLOSURE','GLCLOSURE','UPDATE',0),(262,'accounting','DELETE_GLCLOSURE','GLCLOSURE','DELETE',0),(263,'accounting','CREATE_JOURNALENTRY','JOURNALENTRY','CREATE',0),(264,'accounting','REVERSE_JOURNALENTRY','JOURNALENTRY','REVERSE',0),(265,'report','READ_Active Loans - Details','Active Loans - Details','READ',0),(266,'report','READ_Active Loans - Summary','Active Loans - Summary','READ',0),(267,'report','READ_Active Loans by Disbursal Period','Active Loans by Disbursal Period','READ',0),(268,'report','READ_Active Loans in last installment','Active Loans in last installment','READ',0),(269,'report','READ_Active Loans in last installment Summary','Active Loans in last installment Summary','READ',0),(270,'report','READ_Active Loans Passed Final Maturity','Active Loans Passed Final Maturity','READ',0),(271,'report','READ_Active Loans Passed Final Maturity Summary','Active Loans Passed Final Maturity Summary','READ',0),(272,'report','READ_Aging Detail','Aging Detail','READ',0),(273,'report','READ_Aging Summary (Arrears in Months)','Aging Summary (Arrears in Months)','READ',0),(274,'report','READ_Aging Summary (Arrears in Weeks)','Aging Summary (Arrears in Weeks)','READ',0),(275,'report','READ_Balance Sheet','Balance Sheet','READ',0),(276,'report','READ_Branch Expected Cash Flow','Branch Expected Cash Flow','READ',0),(277,'report','READ_Client Listing','Client Listing','READ',0),(278,'report','READ_Client Loans Listing','Client Loans Listing','READ',0),(279,'report','READ_Expected Payments By Date - Basic','Expected Payments By Date - Basic','READ',0),(280,'report','READ_Expected Payments By Date - Formatted','Expected Payments By Date - Formatted','READ',0),(281,'report','READ_Funds Disbursed Between Dates Summary','Funds Disbursed Between Dates Summary','READ',0),(282,'report','READ_Funds Disbursed Between Dates Summary by Office','Funds Disbursed Between Dates Summary by Office','READ',0),(283,'report','READ_Income Statement','Income Statement','READ',0),(284,'report','READ_Loan Account Schedule','Loan Account Schedule','READ',0),(285,'report','READ_Loans Awaiting Disbursal','Loans Awaiting Disbursal','READ',0),(286,'report','READ_Loans Awaiting Disbursal Summary','Loans Awaiting Disbursal Summary','READ',0),(287,'report','READ_Loans Awaiting Disbursal Summary by Month','Loans Awaiting Disbursal Summary by Month','READ',0),(288,'report','READ_Loans Pending Approval','Loans Pending Approval','READ',0),(289,'report','READ_Obligation Met Loans Details','Obligation Met Loans Details','READ',0),(290,'report','READ_Obligation Met Loans Summary','Obligation Met Loans Summary','READ',0),(291,'report','READ_Portfolio at Risk','Portfolio at Risk','READ',0),(292,'report','READ_Portfolio at Risk by Branch','Portfolio at Risk by Branch','READ',0),(293,'report','READ_Rescheduled Loans','Rescheduled Loans','READ',0),(294,'report','READ_Trial Balance','Trial Balance','READ',0),(295,'report','READ_Written-Off Loans','Written-Off Loans','READ',0),(296,'transaction_savings','POSTINTEREST_SAVINGSACCOUNT','SAVINGSACCOUNT','POSTINTEREST',1),(297,'transaction_savings','POSTINTEREST_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','POSTINTEREST_CHECKER',0),(298,'portfolio_center','READ_CENTER','CENTER','READ',0),(299,'portfolio_center','CREATE_CENTER','CENTER','CREATE',0),(300,'portfolio_center','CREATE_CENTER_CHECKER','CENTER','CREATE_CHECKER',0),(301,'portfolio_center','UPDATE_CENTER','CENTER','UPDATE',0),(302,'portfolio_center','UPDATE_CENTER_CHECKER','CENTER','UPDATE_CHECKER',0),(303,'portfolio_center','DELETE_CENTER','CENTER','DELETE',0),(304,'portfolio_center','DELETE_CENTER_CHECKER','CENTER','DELETE_CHECKER',0),(305,'configuration','READ_REPORT','REPORT','READ',0),(306,'configuration','CREATE_REPORT','REPORT','CREATE',0),(307,'configuration','CREATE_REPORT_CHECKER','REPORT','CREATE_CHECKER',0),(308,'configuration','UPDATE_REPORT','REPORT','UPDATE',0),(309,'configuration','UPDATE_REPORT_CHECKER','REPORT','UPDATE_CHECKER',0),(310,'configuration','DELETE_REPORT','REPORT','DELETE',0),(311,'configuration','DELETE_REPORT_CHECKER','REPORT','DELETE_CHECKER',0),(312,'portfolio','ACTIVATE_CLIENT','CLIENT','ACTIVATE',1),(313,'portfolio','ACTIVATE_CLIENT_CHECKER','CLIENT','ACTIVATE_CHECKER',0),(314,'portfolio_center','ACTIVATE_CENTER','CENTER','ACTIVATE',1),(315,'portfolio_center','ACTIVATE_CENTER_CHECKER','CENTER','ACTIVATE_CHECKER',0),(316,'portfolio_group','ACTIVATE_GROUP','GROUP','ACTIVATE',1),(317,'portfolio_group','ACTIVATE_GROUP_CHECKER','GROUP','ACTIVATE_CHECKER',0),(318,'portfolio_group','ASSOCIATECLIENTS_GROUP','GROUP','ASSOCIATECLIENTS',0),(319,'portfolio_group','DISASSOCIATECLIENTS_GROUP','GROUP','DISASSOCIATECLIENTS',0),(320,'portfolio_group','SAVECOLLECTIONSHEET_GROUP','GROUP','SAVECOLLECTIONSHEET',0),(321,'portfolio_center','SAVECOLLECTIONSHEET_CENTER','CENTER','SAVECOLLECTIONSHEET',0),(323,'accounting','DELETE_ACCOUNTINGRULE','ACCOUNTINGRULE','DELETE',0),(324,'accounting','CREATE_ACCOUNTINGRULE','ACCOUNTINGRULE','CREATE',0),(325,'accounting','UPDATE_ACCOUNTINGRULE','ACCOUNTINGRULE','UPDATE',0),(326,'report','READ_GroupSummaryCounts','GroupSummaryCounts','READ',0),(327,'report','READ_GroupSummaryAmounts','GroupSummaryAmounts','READ',0),(328,'configuration','CREATE_DATATABLE','DATATABLE','CREATE',0),(329,'configuration','CREATE_DATATABLE_CHECKER','DATATABLE','CREATE_CHECKER',0),(330,'configuration','UPDATE_DATATABLE','DATATABLE','UPDATE',0),(331,'configuration','UPDATE_DATATABLE_CHECKER','DATATABLE','UPDATE_CHECKER',0),(332,'configuration','DELETE_DATATABLE','DATATABLE','DELETE',0),(333,'configuration','DELETE_DATATABLE_CHECKER','DATATABLE','DELETE_CHECKER',0),(334,'organisation','CREATE_HOLIDAY','HOLIDAY','CREATE',0),(335,'portfolio_group','ASSIGNROLE_GROUP','GROUP','ASSIGNROLE',0),(336,'portfolio_group','UNASSIGNROLE_GROUP','GROUP','UNASSIGNROLE',0),(337,'portfolio_group','UPDATEROLE_GROUP','GROUP','UPDATEROLE',0),(346,'report','READ_TxnRunningBalances','TxnRunningBalances','READ',0),(347,'portfolio','UNASSIGNSTAFF_CLIENT','CLIENT','UNASSIGNSTAFF',0),(348,'portfolio','ASSIGNSTAFF_CLIENT','CLIENT','ASSIGNSTAFF',0),(349,'portfolio','CLOSE_CLIENT','CLIENT','CLOSE',1),(350,'report','READ_FieldAgentStats','FieldAgentStats','READ',0),(351,'report','READ_FieldAgentPrograms','FieldAgentPrograms','READ',0),(352,'report','READ_ProgramDetails','ProgramDetails','READ',0),(353,'report','READ_ChildrenStaffList','ChildrenStaffList','READ',0),(354,'report','READ_CoordinatorStats','CoordinatorStats','READ',0),(355,'report','READ_BranchManagerStats','BranchManagerStats','READ',0),(356,'report','READ_ProgramDirectorStats','ProgramDirectorStats','READ',0),(357,'report','READ_ProgramStats','ProgramStats','READ',0),(358,'transaction_savings','APPROVE_SAVINGSACCOUNT','SAVINGSACCOUNT','APPROVE',1),(359,'transaction_savings','REJECT_SAVINGSACCOUNT','SAVINGSACCOUNT','REJECT',1),(360,'transaction_savings','WITHDRAW_SAVINGSACCOUNT','SAVINGSACCOUNT','WITHDRAW',1),(361,'transaction_savings','APPROVALUNDO_SAVINGSACCOUNT','SAVINGSACCOUNT','APPROVALUNDO',1),(362,'transaction_savings','CLOSE_SAVINGSACCOUNT','SAVINGSACCOUNT','CLOSE',1),(363,'transaction_savings','APPROVE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','APPROVE_CHECKER',0),(364,'transaction_savings','REJECT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','REJECT_CHECKER',0),(365,'transaction_savings','WITHDRAW_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','WITHDRAW_CHECKER',0),(366,'transaction_savings','APPROVALUNDO_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','APPROVALUNDO_CHECKER',0),(367,'transaction_savings','CLOSE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CLOSE_CHECKER',0),(368,'transaction_savings','UNDOTRANSACTION_SAVINGSACCOUNT','SAVINGSACCOUNT','UNDOTRANSACTION',1),(369,'transaction_savings','UNDOTRANSACTION_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNDOTRANSACTION_CHECKER',0),(370,'portfolio','CREATE_PRODUCTMIX','PRODUCTMIX','CREATE',0),(371,'portfolio','UPDATE_PRODUCTMIX','PRODUCTMIX','UPDATE',0),(372,'portfolio','DELETE_PRODUCTMIX','PRODUCTMIX','DELETE',0),(373,'jobs','UPDATE_SCHEDULER','SCHEDULER','UPDATE',0),(374,'transaction_savings','APPLYANNUALFEE_SAVINGSACCOUNT','SAVINGSACCOUNT','APPLYANNUALFEE',1),(375,'transaction_savings','APPLYANNUALFEE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','APPLYANNUALFEE_CHECKER',0),(376,'portfolio_group','ASSIGNSTAFF_GROUP','GROUP','ASSIGNSTAFF',0),(377,'transaction_savings','READ_ACCOUNTTRANSFER','ACCOUNTTRANSFER','READ',0),(378,'transaction_savings','CREATE_ACCOUNTTRANSFER','ACCOUNTTRANSFER','CREATE',1),(379,'transaction_savings','CREATE_ACCOUNTTRANSFER_CHECKER','ACCOUNTTRANSFER','CREATE_CHECKER',0),(380,'transaction_savings','ADJUSTTRANSACTION_SAVINGSACCOUNT','SAVINGSACCOUNT','ADJUSTTRANSACTION',0),(381,'portfolio','CREATE_MEETING','MEETING','CREATE',0),(382,'portfolio','UPDATE_MEETING','MEETING','UPDATE',0),(383,'portfolio','DELETE_MEETING','MEETING','DELETE',0),(384,'portfolio','SAVEORUPDATEATTENDANCE_MEETING','MEETING','SAVEORUPDATEATTENDANCE',0),(385,'portfolio_group','TRANSFERCLIENTS_GROUP','GROUP','TRANSFERCLIENTS',0),(386,'portfolio_group','TRANSFERCLIENTS_GROUP_CHECKER','GROUP','TRANSFERCLIENTS_CHECKER',0),(389,'portfolio','PROPOSETRANSFER_CLIENT','CLIENT','PROPOSETRANSFER',0),(390,'portfolio','PROPOSETRANSFER_CLIENT_CHECKER','CLIENT','PROPOSETRANSFER_CHECKER',0),(391,'portfolio','ACCEPTTRANSFER_CLIENT','CLIENT','ACCEPTTRANSFER',0),(392,'portfolio','ACCEPTTRANSFER_CLIENT_CHECKER','CLIENT','ACCEPTTRANSFER_CHECKER',0),(393,'portfolio','REJECTTRANSFER_CLIENT','CLIENT','REJECTTRANSFER',0),(394,'portfolio','REJECTTRANSFER_CLIENT_CHECKER','CLIENT','REJECTTRANSFER_CHECKER',0),(395,'portfolio','WITHDRAWTRANSFER_CLIENT','CLIENT','WITHDRAWTRANSFER',0),(396,'portfolio','WITHDRAWTRANSFER_CLIENT_CHECKER','CLIENT','WITHDRAWTRANSFER_CHECKER',0),(397,'portfolio','CLOSE_GROUP','GROUP','CLOSE',1),(398,'portfolio','CLOSE_CENTER','CENTER','CLOSE',1),(399,'xbrlmapping','UPDATE_XBRLMAPPING','XBRLMAPPING','UPDATE',0),(400,'configuration','READ_CACHE','CACHE','READ',0),(401,'configuration','UPDATE_CACHE','CACHE','UPDATE',0),(402,'transaction_loan','PAY_LOANCHARGE','LOANCHARGE','PAY',0),(403,'portfolio','CREATE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','CREATE',0),(404,'portfolio','CREATE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','CREATE_CHECKER',0),(405,'portfolio','UPDATE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','UPDATE',0),(406,'portfolio','UPDATE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','UPDATE_CHECKER',0),(407,'portfolio','DELETE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','DELETE',0),(408,'portfolio','DELETE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','DELETE_CHECKER',0),(409,'portfolio','WAIVE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','WAIVE',0),(410,'portfolio','WAIVE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','WAIVE_CHECKER',0),(411,'portfolio','PAY_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','PAY',0),(412,'portfolio','PAY_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','PAY_CHECKER',0),(413,'portfolio','PROPOSEANDACCEPTTRANSFER_CLIENT','CLIENT','PROPOSEANDACCEPTTRANSFER',0),(414,'portfolio','PROPOSEANDACCEPTTRANSFER_CLIENT_CHECKER','CLIENT','PROPOSEANDACCEPTTRANSFER_CHECKER',0),(415,'organisation','DELETE_TEMPLATE','TEMPLATE','DELETE',0),(416,'organisation','CREATE_TEMPLATE','TEMPLATE','CREATE',0),(417,'organisation','UPDATE_TEMPLATE','TEMPLATE','UPDATE',0),(418,'organisation','READ_TEMPLATE','TEMPLATE','READ',0),(419,'accounting','UPDATERUNNINGBALANCE_JOURNALENTRY','JOURNALENTRY','UPDATERUNNINGBALANCE',0),(420,'organisation','READ_SMS','SMS','READ',0),(421,'organisation','CREATE_SMS','SMS','CREATE',0),(422,'organisation','CREATE_SMS_CHECKER','SMS','CREATE_CHECKER',0),(423,'organisation','UPDATE_SMS','SMS','UPDATE',0),(424,'organisation','UPDATE_SMS_CHECKER','SMS','UPDATE_CHECKER',0),(425,'organisation','DELETE_SMS','SMS','DELETE',0),(426,'organisation','DELETE_SMS_CHECKER','SMS','DELETE_CHECKER',0),(427,'organisation','CREATE_HOLIDAY_CHECKER','HOLIDAY','CREATE_CHECKER',0),(428,'organisation','ACTIVATE_HOLIDAY','HOLIDAY','ACTIVATE',0),(429,'organisation','ACTIVATE_HOLIDAY_CHECKER','HOLIDAY','ACTIVATE_CHECKER',0),(430,'organisation','UPDATE_HOLIDAY','HOLIDAY','UPDATE',0),(431,'organisation','UPDATE_HOLIDAY_CHECKER','HOLIDAY','UPDATE_CHECKER',0),(432,'organisation','DELETE_HOLIDAY','HOLIDAY','DELETE',0),(433,'organisation','DELETE_HOLIDAY_CHECKER','HOLIDAY','DELETE_CHECKER',0),(434,'transaction_loan','UNDOWRITEOFF_LOAN','LOAN','UNDOWRITEOFF',0),(435,'portfolio','READ_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','READ',0),(436,'accounting','CREATE_JOURNALENTRY_CHECKER','JOURNALENTRY','CREATE_CHECKER',0),(437,'portfolio','UPDATE_DISBURSEMENTDETAIL','DISBURSEMENTDETAIL','UPDATE',0),(438,'portfolio','UPDATESAVINGSACCOUNT_CLIENT','CLIENT','UPDATESAVINGSACCOUNT',0),(439,'accounting','READ_ACCOUNTINGRULE','ACCOUNTINGRULE','READ',0),(440,'accounting','READ_JOURNALENTRY','JOURNALENTRY','READ',0),(441,'accounting','READ_GLACCOUNT','GLACCOUNT','READ',0),(442,'accounting','READ_GLCLOSURE','GLCLOSURE','READ',0),(443,'organisation','READ_HOLIDAY','HOLIDAY','READ',0),(444,'jobs','READ_SCHEDULER','SCHEDULER','READ',0),(445,'portfolio','READ_PRODUCTMIX','PRODUCTMIX','READ',0),(446,'portfolio','READ_MEETING','MEETING','READ',0),(447,'jobs','EXECUTEJOB_SCHEDULER','SCHEDULER','EXECUTEJOB',0),(448,'account_transfer','READ_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','READ',0),(449,'account_transfer','CREATE_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','CREATE',0),(450,'account_transfer','UPDATE_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','UPDATE',0),(451,'account_transfer','DELETE_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','DELETE',0),(452,'portfolio','CREATE_INTERESTRATECHART','INTERESTRATECHART','CREATE',0),(453,'portfolio','CREATE_INTERESTRATECHART_CHECKER','INTERESTRATECHART','CREATE_CHECKER',0),(454,'portfolio','UPDATE_INTERESTRATECHART','INTERESTRATECHART','UPDATE',0),(455,'portfolio','DELETE_INTERESTRATECHART','INTERESTRATECHART','DELETE',0),(456,'portfolio','UPDATE_INTERESTRATECHART_CHECKER','INTERESTRATECHART','UPDATE_CHECKER',0),(457,'portfolio','DELETE_INTERESTRATECHART_CHECKER','INTERESTRATECHART','DELETE_CHECKER',0),(458,'portfolio','CREATE_CHARTSLAB','CHARTSLAB','CREATE',0),(459,'portfolio','CREATE_CHARTSLAB_CHECKER','CHARTSLAB','CREATE_CHECKER',0),(460,'portfolio','UPDATE_CHARTSLAB','CHARTSLAB','UPDATE',0),(461,'portfolio','DELETE_CHARTSLAB','CHARTSLAB','DELETE',0),(462,'portfolio','UPDATE_CHARTSLAB_CHECKER','CHARTSLAB','UPDATE_CHECKER',0),(463,'portfolio','DELETE_CHARTSLAB_CHECKER','CHARTSLAB','DELETE_CHECKER',0),(464,'portfolio','CREATE_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','CREATE',0),(465,'portfolio','CREATE_FIXEDDEPOSITPRODUCT_CHECKER','FIXEDDEPOSITPRODUCT','CREATE_CHECKER',0),(466,'portfolio','UPDATE_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','UPDATE',0),(467,'portfolio','DELETE_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','DELETE',0),(468,'portfolio','UPDATE_FIXEDDEPOSITPRODUCT_CHECKER','FIXEDDEPOSITPRODUCT','UPDATE_CHECKER',0),(469,'portfolio','DELETE_FIXEDDEPOSITPRODUCT_CHECKER','FIXEDDEPOSITPRODUCT','DELETE_CHECKER',0),(470,'portfolio','CREATE_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','CREATE',0),(471,'portfolio','CREATE_RECURRINGDEPOSITPRODUCT_CHECKER','RECURRINGDEPOSITPRODUCT','CREATE_CHECKER',0),(472,'portfolio','UPDATE_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','UPDATE',0),(473,'portfolio','DELETE_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','DELETE',0),(474,'portfolio','UPDATE_RECURRINGDEPOSITPRODUCT_CHECKER','RECURRINGDEPOSITPRODUCT','UPDATE_CHECKER',0),(475,'portfolio','DELETE_RECURRINGDEPOSITPRODUCT_CHECKER','RECURRINGDEPOSITPRODUCT','DELETE_CHECKER',0),(476,'portfolio','READ_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','READ',0),(477,'portfolio','CREATE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','CREATE',0),(478,'portfolio','CREATE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','CREATE_CHECKER',0),(479,'portfolio','UPDATE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','UPDATE',0),(480,'portfolio','UPDATE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','UPDATE_CHECKER',0),(481,'portfolio','DELETE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','DELETE',0),(482,'portfolio','DELETE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','DELETE_CHECKER',0),(483,'transaction_savings','DEPOSIT_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','DEPOSIT',0),(484,'transaction_savings','DEPOSIT_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','DEPOSIT_CHECKER',0),(485,'transaction_savings','WITHDRAWAL_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','WITHDRAWAL',0),(486,'transaction_savings','WITHDRAWAL_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','WITHDRAWAL_CHECKER',0),(487,'transaction_savings','ACTIVATE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','ACTIVATE',0),(488,'transaction_savings','ACTIVATE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','ACTIVATE_CHECKER',0),(489,'transaction_savings','CALCULATEINTEREST_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','CALCULATEINTEREST',0),(490,'transaction_savings','CALCULATEINTEREST_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','CALCULATEINTEREST_CHECKER',0),(491,'transaction_savings','POSTINTEREST_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','POSTINTEREST',1),(492,'transaction_savings','POSTINTEREST_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','POSTINTEREST_CHECKER',0),(493,'transaction_savings','APPROVE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','APPROVE',1),(494,'transaction_savings','REJECT_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','REJECT',1),(495,'transaction_savings','WITHDRAW_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','WITHDRAW',1),(496,'transaction_savings','APPROVALUNDO_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','APPROVALUNDO',1),(497,'transaction_savings','CLOSE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','CLOSE',1),(498,'transaction_savings','APPROVE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','APPROVE_CHECKER',0),(499,'transaction_savings','REJECT_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','REJECT_CHECKER',0),(500,'transaction_savings','WITHDRAW_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','WITHDRAW_CHECKER',0),(501,'transaction_savings','APPROVALUNDO_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','APPROVALUNDO_CHECKER',0),(502,'transaction_savings','CLOSE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','CLOSE_CHECKER',0),(503,'transaction_savings','UNDOTRANSACTION_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','UNDOTRANSACTION',1),(504,'transaction_savings','UNDOTRANSACTION_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','UNDOTRANSACTION_CHECKER',0),(505,'transaction_savings','ADJUSTTRANSACTION_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','ADJUSTTRANSACTION',0),(506,'portfolio','READ_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','READ',0),(507,'portfolio','CREATE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','CREATE',0),(508,'portfolio','CREATE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','CREATE_CHECKER',0),(509,'portfolio','UPDATE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','UPDATE',0),(510,'portfolio','UPDATE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','UPDATE_CHECKER',0),(511,'portfolio','DELETE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','DELETE',0),(512,'portfolio','DELETE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','DELETE_CHECKER',0),(513,'transaction_savings','DEPOSIT_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','DEPOSIT',0),(514,'transaction_savings','DEPOSIT_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','DEPOSIT_CHECKER',0),(515,'transaction_savings','WITHDRAWAL_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','WITHDRAWAL',0),(516,'transaction_savings','WITHDRAWAL_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','WITHDRAWAL_CHECKER',0),(517,'transaction_savings','ACTIVATE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','ACTIVATE',0),(518,'transaction_savings','ACTIVATE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','ACTIVATE_CHECKER',0),(519,'transaction_savings','CALCULATEINTEREST_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','CALCULATEINTEREST',0),(520,'transaction_savings','CALCULATEINTEREST_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','CALCULATEINTEREST_CHECKER',0),(521,'transaction_savings','POSTINTEREST_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','POSTINTEREST',1),(522,'transaction_savings','POSTINTEREST_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','POSTINTEREST_CHECKER',0),(523,'transaction_savings','APPROVE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','APPROVE',1),(524,'transaction_savings','REJECT_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','REJECT',1),(525,'transaction_savings','WITHDRAW_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','WITHDRAW',1),(526,'transaction_savings','APPROVALUNDO_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','APPROVALUNDO',1),(527,'transaction_savings','CLOSE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','CLOSE',1),(528,'transaction_savings','APPROVE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','APPROVE_CHECKER',0),(529,'transaction_savings','REJECT_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','REJECT_CHECKER',0),(530,'transaction_savings','WITHDRAW_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','WITHDRAW_CHECKER',0),(531,'transaction_savings','APPROVALUNDO_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','APPROVALUNDO_CHECKER',0),(532,'transaction_savings','CLOSE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','CLOSE_CHECKER',0),(533,'transaction_savings','UNDOTRANSACTION_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','UNDOTRANSACTION',1),(534,'transaction_savings','UNDOTRANSACTION_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','UNDOTRANSACTION_CHECKER',0),(535,'transaction_savings','ADJUSTTRANSACTION_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','ADJUSTTRANSACTION',0),(536,'transaction_savings','PREMATURECLOSE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','PREMATURECLOSE_CHECKER',0),(537,'transaction_savings','PREMATURECLOSE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','PREMATURECLOSE',1),(538,'transaction_savings','PREMATURECLOSE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','PREMATURECLOSE_CHECKER',0),(539,'transaction_savings','PREMATURECLOSE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','PREMATURECLOSE',1),(540,'transaction_loan','DISBURSETOSAVINGS_LOAN','LOAN','DISBURSETOSAVINGS',0),(541,'transaction_loan','RECOVERYPAYMENT_LOAN','LOAN','RECOVERYPAYMENT',0),(542,'organisation','READ_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','READ',0),(543,'organisation','READ_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','READ',0),(544,'accounting','READ_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','READ',0),(545,'accounting','CREATE_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','CREATE',0),(546,'accounting','DELETE_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','DELETE',0),(547,'accounting','UPDATE_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','UPDATE',0),(548,'datatable','UPDATE_LIKELIHOOD','likelihood','UPDATE',0),(549,'survey','REGISTER_SURVEY','survey','CREATE',0),(550,'accounting','EXECUTE_PERIODICACCRUALACCOUNTING','PERIODICACCRUALACCOUNTING','EXECUTE',0),(551,'portfolio','INACTIVATE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','INACTIVATE',0),(552,'portfolio','INACTIVATE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','INACTIVATE_CHECKER',0),(553,'portfolio_center','DISASSOCIATEGROUPS_CENTER','CENTER','DISASSOCIATEGROUPS',0),(554,'portfolio_center','ASSOCIATEGROUPS_CENTER','CENTER','ASSOCIATEGROUPS',0),(555,'portfolio_center','DISASSOCIATEGROUPS_CENTER_CHECKER','CENTER','DISASSOCIATEGROUPS_CHECKER',0),(556,'portfolio_center','ASSOCIATEGROUPS_CENTER_CHECKER','CENTER','ASSOCIATEGROUPS_CHECKER',0),(557,'loan_reschedule','READ_RESCHEDULELOAN','RESCHEDULELOAN','READ',0),(558,'loan_reschedule','CREATE_RESCHEDULELOAN','RESCHEDULELOAN','CREATE',0),(559,'loan_reschedule','REJECT_RESCHEDULELOAN','RESCHEDULELOAN','REJECT',0),(560,'loan_reschedule','APPROVE_RESCHEDULELOAN','RESCHEDULELOAN','APPROVE',0),(561,'configuration','CREATE_HOOK','HOOK','CREATE',0),(562,'configuration','READ_HOOK','HOOK','READ',0),(563,'configuration','UPDATE_HOOK','HOOK','UPDATE',0),(564,'configuration','DELETE_HOOK','HOOK','DELETE',0),(565,'portfolio','REMOVESAVINGSOFFICER_SAVINGSACCOUNT','SAVINGSACCOUNT','REMOVESAVINGSOFFICER',1),(566,'portfolio','UPDATESAVINGSOFFICER_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATESAVINGSOFFICER',1),(567,'report','READ_Active Loans - Summary(Pentaho)','Active Loans - Summary(Pentaho)','READ',0),(568,'report','READ_Active Loans by Disbursal Period(Pentaho)','Active Loans by Disbursal Period(Pentaho)','READ',0),(569,'report','READ_Active Loans in last installment Summary(Pentaho)','Active Loans in last installment Summary(Pentaho)','READ',0),(570,'report','READ_Active Loans in last installment(Pentaho)','Active Loans in last installment(Pentaho)','READ',0),(571,'report','READ_Active Loans Passed Final Maturity Summary(Pentaho)','Active Loans Passed Final Maturity Summary(Pentaho)','READ',0),(572,'report','READ_Active Loans Passed Final Maturity(Pentaho)','Active Loans Passed Final Maturity(Pentaho)','READ',0),(573,'report','READ_Aging Detail(Pentaho)','Aging Detail(Pentaho)','READ',0),(574,'report','READ_Aging Summary (Arrears in Months)(Pentaho)','Aging Summary (Arrears in Months)(Pentaho)','READ',0),(575,'report','READ_Aging Summary (Arrears in Weeks)(Pentaho)','Aging Summary (Arrears in Weeks)(Pentaho)','READ',0),(576,'report','READ_Client Listing(Pentaho)','Client Listing(Pentaho)','READ',0),(577,'report','READ_Client Loan Account Schedule','Client Loan Account Schedule','READ',0),(578,'report','READ_Client Loans Listing(Pentaho)','Client Loans Listing(Pentaho)','READ',0),(579,'report','READ_Client Saving Transactions','Client Saving Transactions','READ',0),(580,'report','READ_Client Savings Summary','Client Savings Summary','READ',0),(581,'report','READ_ClientSummary ','ClientSummary ','READ',0),(582,'report','READ_ClientTrendsByDay','ClientTrendsByDay','READ',0),(583,'report','READ_ClientTrendsByMonth','ClientTrendsByMonth','READ',0),(584,'report','READ_ClientTrendsByWeek','ClientTrendsByWeek','READ',0),(585,'report','READ_Demand_Vs_Collection','Demand_Vs_Collection','READ',0),(586,'report','READ_Disbursal_Vs_Awaitingdisbursal','Disbursal_Vs_Awaitingdisbursal','READ',0),(587,'report','READ_Expected Payments By Date - Basic(Pentaho)','Expected Payments By Date - Basic(Pentaho)','READ',0),(588,'report','READ_Funds Disbursed Between Dates Summary by Office(Pentaho)','Funds Disbursed Between Dates Summary by Office(Pentaho)','READ',0),(589,'report','READ_Funds Disbursed Between Dates Summary(Pentaho)','Funds Disbursed Between Dates Summary(Pentaho)','READ',0),(590,'report','READ_GroupNamesByStaff','GroupNamesByStaff','READ',0),(591,'report','READ_GroupSavingSummary','GroupSavingSummary','READ',0),(592,'report','READ_LoanCyclePerProduct','LoanCyclePerProduct','READ',0),(593,'report','READ_Loans Awaiting Disbursal Summary by Month(Pentaho)','Loans Awaiting Disbursal Summary by Month(Pentaho)','READ',0),(594,'report','READ_Loans Awaiting Disbursal Summary(Pentaho)','Loans Awaiting Disbursal Summary(Pentaho)','READ',0),(595,'report','READ_Loans Awaiting Disbursal(Pentaho)','Loans Awaiting Disbursal(Pentaho)','READ',0),(596,'report','READ_Loans Pending Approval(Pentaho)','Loans Pending Approval(Pentaho)','READ',0),(597,'report','READ_LoanTrendsByDay','LoanTrendsByDay','READ',0),(598,'report','READ_LoanTrendsByMonth','LoanTrendsByMonth','READ',0),(599,'report','READ_LoanTrendsByWeek','LoanTrendsByWeek','READ',0),(600,'report','READ_Obligation Met Loans Details(Pentaho)','Obligation Met Loans Details(Pentaho)','READ',0),(601,'report','READ_Obligation Met Loans Summary(Pentaho)','Obligation Met Loans Summary(Pentaho)','READ',0),(602,'report','READ_Portfolio at Risk by Branch(Pentaho)','Portfolio at Risk by Branch(Pentaho)','READ',0),(603,'report','READ_Portfolio at Risk(Pentaho)','Portfolio at Risk(Pentaho)','READ',0),(604,'report','READ_Rescheduled Loans(Pentaho)','Rescheduled Loans(Pentaho)','READ',0),(605,'report','READ_Savings Transactions','Savings Transactions','READ',0),(606,'report','READ_TxnRunningBalances(Pentaho)','TxnRunningBalances(Pentaho)','READ',0),(607,'report','READ_Written-Off Loans(Pentaho)','Written-Off Loans(Pentaho)','READ',0),(608,'configuration','CREATE_ACCOUNTNUMBERFORMAT','ACCOUNTNUMBERFORMAT','CREATE',0),(609,'configuration','READ_ACCOUNTNUMBERFORMAT','ACCOUNTNUMBERFORMAT','READ',0),(610,'configuration','UPDATE_ACCOUNTNUMBERFORMAT','ACCOUNTNUMBERFORMAT','UPDATE',0),(611,'configuration','DELETE_ACCOUNTNUMBERFORMAT','HOOK','DELETE',0),(612,'portfolio','RECOVERGUARANTEES_LOAN','LOAN','RECOVERGUARANTEES',0),(613,'portfolio','RECOVERGUARANTEES_LOAN_CHECKER','LOAN','RECOVERGUARANTEES_CHECKER',0),(614,'portfolio','REJECT_CLIENT','CLIENT','REJECT',1),(615,'portfolio','REJECT_CLIENT_CHECKER','CLIENT','REJECT_CHECKER',0),(616,'portfolio','WITHDRAW_CLIENT','CLIENT','WITHDRAW',1),(617,'portfolio','WITHDRAW_CLIENT_CHECKER','CLIENT','WITHDRAW_CHECKER',0),(618,'portfolio','REACTIVATE_CLIENT','CLIENT','REACTIVATE',1),(619,'portfolio','REACTIVATE_CLIENT_CHECKER','CLIENT','REACTIVATE_CHECKER',0),(620,'transaction_savings','UPDATEDEPOSITAMOUNT_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','UPDATEDEPOSITAMOUNT',1),(621,'transaction_savings','UPDATEDEPOSITAMOUNT_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','UPDATEDEPOSITAMOUNT',1),(622,'transaction_savings','REFUNDBYTRANSFER_ACCOUNTTRANSFER_CHECKER','ACCOUNTTRANSFER','REFUNDBYTRANSFER',0),(623,'transaction_savings','REFUNDBYTRANSFER_ACCOUNTTRANSFER','ACCOUNTTRANSFER','REFUNDBYTRANSFER',1),(624,'transaction_loan','REFUNDBYCASH_LOAN','LOAN','REFUNDBYCASH',1),(625,'transaction_loan','REFUNDBYCASH_LOAN_CHECKER','LOAN','REFUNDBYCASH',0),(626,'cash_mgmt','CREATE_TELLER','TELLER','CREATE',1),(627,'cash_mgmt','UPDATE_TELLER','TELLER','UPDATE',1),(628,'cash_mgmt','ALLOCATECASHIER_TELLER','TELLER','ALLOCATE',1),(629,'cash_mgmt','UPDATECASHIERALLOCATION_TELLER','TELLER','UPDATECASHIERALLOCATION',1),(630,'cash_mgmt','DELETECASHIERALLOCATION_TELLER','TELLER','DELETECASHIERALLOCATION',1),(631,'cash_mgmt','ALLOCATECASHTOCASHIER_TELLER','TELLER','ALLOCATECASHTOCASHIER',1),(632,'cash_mgmt','SETTLECASHFROMCASHIER_TELLER','TELLER','SETTLECASHFROMCASHIER',1),(633,'authorisation','DISABLE_ROLE','ROLE','DISABLE',0),(634,'authorisation','DISABLE_ROLE_CHECKER','ROLE','DISABLE_CHECKER',0),(635,'authorisation','ENABLE_ROLE','ROLE','ENABLE',0),(636,'authorisation','ENABLE_ROLE_CHECKER','ROLE','ENABLE_CHECKER',0),(637,'accounting','DEFINEOPENINGBALANCE_JOURNALENTRY','JOURNALENTRY','DEFINEOPENINGBALANCE',1),(638,'collection_sheet','READ_COLLECTIONSHEET','COLLECTIONSHEET','READ',0),(639,'collection_sheet','SAVE_COLLECTIONSHEET','COLLECTIONSHEET','SAVE',0),(640,'infrastructure','CREATE_ENTITYMAPPING','ENTITYMAPPING','CREATE',0),(641,'infrastructure','UPDATE_ENTITYMAPPING','ENTITYMAPPING','UPDATE',0),(642,'infrastructure','DELETE_ENTITYMAPPING','ENTITYMAPPING','DELETE',0),(643,'organisation','READ_WORKINGDAYS','WORKINGDAYS','READ',0),(644,'organisation','UPDATE_WORKINGDAYS','WORKINGDAYS','UPDATE',0),(645,'organisation','UPDATE_WORKINGDAYS_CHECKER','WORKINGDAYS','UPDATE_CHECKER',0),(646,'authorisation','READ_PASSWORD_PREFERENCES','PASSWORD_PREFERENCES','READ',0),(647,'authorisation','UPDATE_PASSWORD_PREFERENCES','PASSWORD_PREFERENCES','UPDATE',0),(648,'authorisation','UPDATE_PASSWORD_PREFERENCES_CHECKER','PASSWORD_PREFERENCES','UPDATE_CHECKER',0),(649,'portfolio','CREATE_PAYMENTTYPE','PAYMENTTYPE','CREATE',0),(650,'portfolio','UPDATE_PAYMENTTYPE','PAYMENTTYPE','UPDATE',0),(651,'portfolio','DELETE_PAYMENTTYPE','PAYMENTTYPE','DELETE',0),(652,'cash_mgmt','DELETE_TELLER','TELLER','DELETE',1),(653,'report','READ_General Ledger Report','General Ledger Report','READ',0),(654,'portfolio','READ_STAFFIMAGE','STAFFIMAGE','READ',0),(655,'portfolio','CREATE_STAFFIMAGE','STAFFIMAGE','CREATE',1),(656,'portfolio','CREATE_STAFFIMAGE_CHECKER','STAFFIMAGE','CREATE',0),(657,'portfolio','DELETE_STAFFIMAGE','STAFFIMAGE','DELETE',1),(658,'portfolio','DELETE_STAFFIMAGE_CHECKER','STAFFIMAGE','DELETE',0),(659,'report','READ_Active Loan Summary per Branch','Active Loan Summary per Branch','READ',0),(660,'report','READ_Disbursal Report','Disbursal Report','READ',0),(661,'report','READ_Balance Outstanding','Balance Outstanding','READ',0),(662,'report','READ_Collection Report','Collection Report','READ',0),(663,'portfolio','READ_PAYMENTTYPE','PAYMENTTYPE','READ',0),(664,'report','READ_Staff Assignment History','Staff Assignment History(Pentaho)','READ',0),(665,'externalservices','UPDATE_EXTERNALSERVICES','EXTERNALSERVICES','UPDATE',0),(666,'portfolio','READ_CLIENTCHARGE','CLIENTCHARGE','READ',0),(667,'portfolio','CREATE_CLIENTCHARGE','CLIENTCHARGE','CREATE',0),(668,'portfolio','DELETE_CLIENTCHARGE','CLIENTCHARGE','DELETE',0),(669,'portfolio','WAIVE_CLIENTCHARGE','CLIENTCHARGE','WAIVE',0),(670,'portfolio','PAY_CLIENTCHARGE','CLIENTCHARGE','PAY',0),(671,'portfolio','INACTIVATE_CLIENTCHARGE','CLIENTCHARGE','INACTIVATE',0),(672,'portfolio','UPDATE_CLIENTCHARGE','CLIENTCHARGE','UPDATE',0),(673,'portfolio','CREATE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','CREATE_CHECKER',0),(674,'portfolio','DELETE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','DELETE_CHECKER',0),(675,'portfolio','WAIVE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','WAIVE_CHECKER',0),(676,'portfolio','PAY_CLIENTCHARGE_CHECKER','CLIENTCHARGE','PAY_CHECKER',0),(677,'portfolio','INACTIVATE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','INACTIVATE_CHECKER',0),(678,'portfolio','UPDATE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','UPDATE_CHECKER',0),(679,'transaction_client','READTRANSACTION_CLIENT','CLIENT','READTRANSACTION',0),(680,'transaction_client','UNDOTRANSACTION_CLIENT','CLIENT','UNDOTRANSACTION',0),(681,'transaction_client','UNDOTRANSACTION_CLIENT_CHECKER','CLIENT','UNDOTRANSACTION_CHECKER',0),(682,'LOAN_PROVISIONING','CREATE_PROVISIONCATEGORY','PROVISIONCATEGORY','CREATE',0),(683,'LOAN_PROVISIONING','DELETE_PROVISIONCATEGORY','PROVISIONCATEGORY','DELETE',0),(684,'LOAN_PROVISIONING','CREATE_PROVISIONCRITERIA','PROVISIONINGCRITERIA','CREATE',0),(685,'LOAN_PROVISIONING','UPDATE_PROVISIONCRITERIA','PROVISIONINGCRITERIA','UPDATE',0),(686,'LOAN_PROVISIONING','DELETE_PROVISIONCRITERIA','PROVISIONINGCRITERIA','DELETE',0),(687,'LOAN_PROVISIONING','CREATE_PROVISIONENTRIES','PROVISIONINGENTRIES','CREATE',0),(688,'LOAN_PROVISIONING','CREATE_PROVISIONJOURNALENTRIES','PROVISIONINGENTRIES','CREATE',0),(689,'LOAN_PROVISIONING','RECREATE_PROVISIONENTRIES','PROVISIONINGENTRIES','RECREATE',0),(690,'portfolio','READ_FLOATINGRATE','FLOATINGRATE','READ',0),(691,'portfolio','CREATE_FLOATINGRATE','FLOATINGRATE','CREATE',1),(692,'portfolio','CREATE_FLOATINGRATE_CHECKER','FLOATINGRATE','CREATE_CHECKER',0),(693,'portfolio','UPDATE_FLOATINGRATE','FLOATINGRATE','UPDATE',1),(694,'portfolio','UPDATE_FLOATINGRATE_CHECKER','FLOATINGRATE','UPDATE_CHECKER',0),(695,'portfolio','CREATESCHEDULEEXCEPTIONS_LOAN','LOAN','CREATESCHEDULEEXCEPTIONS',0),(696,'portfolio','CREATESCHEDULEEXCEPTIONS_LOAN_CHECKER','LOAN','CREATESCHEDULEEXCEPTIONS_CHECKER',0),(697,'portfolio','DELETESCHEDULEEXCEPTIONS_LOAN','LOAN','DELETESCHEDULEEXCEPTIONS',0),(698,'portfolio','DELETESCHEDULEEXCEPTIONS_LOAN_CHECKER','LOAN','DELETESCHEDULEEXCEPTIONS_CHECKER',0),(699,'transaction_loan','DISBURSALLASTUNDO_LOAN','LOAN','DISBURSALLASTUNDO',0),(700,'transaction_loan','DISBURSALLASTUNDO_LOAN_CHECKER','LOAN','DISBURSALLASTUNDO_CHECKER',0),(701,'SHAREPRODUCT','CREATE_SHAREPRODUCT','SHAREPRODUCT','CREATE',0),(702,'SHAREPRODUCT','UPDATE_SHAREPRODUCT','SHAREPRODUCT','CREATE',0),(703,'SHAREACCOUNT','CREATE_SHAREACCOUNT','SHAREACCOUNT','CREATE',0),(704,'SHAREACCOUNT','UPDATE_SHAREACCOUNT','SHAREACCOUNT','CREATE',0),(705,'organisation','READ_TAXCOMPONENT','TAXCOMPONENT','READ',0),(706,'organisation','CREATE_TAXCOMPONENT','TAXCOMPONENT','CREATE',0),(707,'organisation','CREATE_TAXCOMPONENT_CHECKER','TAXCOMPONENT','CREATE_CHECKER',0),(708,'organisation','UPDATE_TAXCOMPONENT','TAXCOMPONENT','UPDATE',0),(709,'organisation','UPDATE_TAXCOMPONENT_CHECKER','TAXCOMPONENT','UPDATE_CHECKER',0),(710,'organisation','READ_TAXGROUP','TAXGROUP','READ',0),(711,'organisation','CREATE_TAXGROUP','TAXGROUP','CREATE',0),(712,'organisation','CREATE_TAXGROUP_CHECKER','TAXGROUP','CREATE_CHECKER',0),(713,'organisation','UPDATE_TAXGROUP','TAXGROUP','UPDATE',0),(714,'organisation','UPDATE_TAXGROUP_CHECKER','TAXGROUP','UPDATE_CHECKER',0),(715,'portfolio','UPDATEWITHHOLDTAX_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATEWITHHOLDTAX',0),(716,'portfolio','UPDATEWITHHOLDTAX_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UPDATEWITHHOLDTAX_CHECKER',0),(717,'SHAREPRODUCT','CREATE_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','CREATE_DIVIDEND',0),(718,'SHAREPRODUCT','CREATE_DIVIDEND_SHAREPRODUCT_CHECKER','SHAREPRODUCT','CREATE_DIVIDEND_CHECKER',0),(719,'SHAREPRODUCT','APPROVE_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','APPROVE_DIVIDEND',0),(720,'SHAREPRODUCT','APPROVE_DIVIDEND_SHAREPRODUCT_CHECKER','SHAREPRODUCT','APPROVE_DIVIDEND_CHECKER',0),(721,'SHAREPRODUCT','DELETE_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','DELETE_DIVIDEND',0),(722,'SHAREPRODUCT','DELETE_DIVIDEND_SHAREPRODUCT_CHECKER','SHAREPRODUCT','DELETE_DIVIDEND_CHECKER',0),(723,'SHAREPRODUCT','READ_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','READ_DIVIDEND',0),(724,'SHAREACCOUNT','APPROVE_SHAREACCOUNT','SHAREACCOUNT','APPROVE',0),(725,'SHAREACCOUNT','ACTIVATE_SHAREACCOUNT','SHAREACCOUNT','ACTIVATE',0),(726,'SHAREACCOUNT','UNDOAPPROVAL_SHAREACCOUNT','SHAREACCOUNT','UNDOAPPROVAL',0),(727,'SHAREACCOUNT','REJECT_SHAREACCOUNT','SHAREACCOUNT','REJECT',0),(728,'SHAREACCOUNT','APPLYADDITIONALSHARES_SHAREACCOUNT','SHAREACCOUNT','APPLYADDITIONALSHARES',0),(729,'SHAREACCOUNT','APPROVEADDITIONALSHARES_SHAREACCOUNT','SHAREACCOUNT','APPROVEADDITIONALSHARES',0),(730,'SHAREACCOUNT','REJECTADDITIONALSHARES_SHAREACCOUNT','SHAREACCOUNT','REJECTADDITIONALSHARES',0),(731,'SHAREACCOUNT','REDEEMSHARES_SHAREACCOUNT','SHAREACCOUNT','REDEEMSHARES',0),(732,'SHAREACCOUNT','CLOSE_SHAREACCOUNT','SHAREACCOUNT','CLOSE',0),(733,'SSBENEFICIARYTPT','READ_SSBENEFICIARYTPT','SSBENEFICIARYTPT','READ',0),(734,'SSBENEFICIARYTPT','CREATE_SSBENEFICIARYTPT','SSBENEFICIARYTPT','CREATE',0),(735,'SSBENEFICIARYTPT','UPDATE_SSBENEFICIARYTPT','SSBENEFICIARYTPT','UPDATE',0),(736,'SSBENEFICIARYTPT','DELETE_SSBENEFICIARYTPT','SSBENEFICIARYTPT','DELETE',0),(737,'portfolio','FORECLOSURE_LOAN','LOAN','FORECLOSURE',0),(738,'portfolio','FORECLOSURE_LOAN_CHECKER','LOAN','FORECLOSURE_CHECKER',0),(739,'portfolio','CREATE_ADDRESS','ADDRESS','CREATE',0),(740,'portfolio','CREATE_ADDRESS_CHECKER','ADDRESS','CREATE_CHECKER',1),(741,'portfolio','UPDATE_ADDRESS','ADDRESS','UPDATE',0),(742,'portfolio','UPDATE_ADDRESS_CHECKER','ADDRESS','UPDATE_CHECKER',1),(743,'portfolio','READ_ADDRESS','ADDRESS','READ',0),(744,'portfolio','DELETE_ADDRESS','ADDRESS','DELETE',0),(745,'portfolio','DELETE_ADDRESS_CHECKER','ADDRESS','DELETE_CHECKER',1),(746,'jobs','CREATE_REPORTMAILINGJOB','REPORTMAILINGJOB','CREATE',0),(747,'jobs','UPDATE_REPORTMAILINGJOB','REPORTMAILINGJOB','UPDATE',0),(748,'jobs','DELETE_REPORTMAILINGJOB','REPORTMAILINGJOB','DELETE',0),(749,'jobs','READ_REPORTMAILINGJOB','REPORTMAILINGJOB','READ',0),(750,'portfolio','UNDOREJECT_CLIENT','CLIENT','UNDOREJECT',1),(751,'portfolio','UNDOREJECT_CLIENT_CHECKER','CLIENT','UNDOREJECT_CHECKER',1),(752,'portfolio','UNDOWITHDRAWAL_CLIENT','CLIENT','UNDOWITHDRAWAL',1),(753,'portfolio','UNDOWITHDRAWAL_CLIENT_CHECKER','CLIENT','UNDOWITHDRAWAL_CHECKER',1),(754,'organisation','READ_SMSCAMPAIGN','SMSCAMPAIGN','READ',0),(755,'organisation','CREATE_SMSCAMPAIGN','SMSCAMPAIGN','CREATE',0),(756,'organisation','CREATE_SMSCAMPAIGN_CHECKER','SMSCAMPAIGN','CREATE',0),(757,'organisation','UPDATE_SMSCAMPAIGN','SMSCAMPAIGN','UPDATE',0),(758,'organisation','UPDATE_SMSCAMPAIGN_CHECKER','SMSCAMPAIGN','UPDATE',0),(759,'organisation','DELETE_SMSCAMPAIGN','SMSCAMPAIGN','DELETE',0),(760,'organisation','DELETE_SMSCAMPAIGN_CHECKER','SMSCAMPAIGN','DELETE',0),(761,'organisation','ACTIVATE_SMSCAMPAIGN','SMSCAMPAIGN','ACTIVATE',0),(762,'organisation','CLOSE_SMSCAMPAIGN','SMSCAMPAIGN','CLOSE',0),(763,'organisation','REACTIVATE_SMSCAMPAIGN','SMSCAMPAIGN','REACTIVATE',0),(764,'organisation','READ_EMAIL','EMAIL','READ',0),(765,'organisation','CREATE_EMAIL','EMAIL','CREATE',0),(766,'organisation','CREATE_EMAIL_CHECKER','EMAIL','CREATE_CHECKER',0),(767,'organisation','UPDATE_EMAIL','EMAIL','UPDATE',0),(768,'organisation','UPDATE_EMAIL_CHECKER','EMAIL','UPDATE_CHECKER',0),(769,'organisation','DELETE_EMAIL','EMAIL','DELETE',0),(770,'organisation','DELETE_EMAIL_CHECKER','EMAIL','DELETE_CHECKER',0),(771,'organisation','READ_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','READ',0),(772,'organisation','CREATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','CREATE',0),(773,'organisation','CREATE_EMAIL_CAMPAIGN_CHECKER','EMAIL_CAMPAIGN','CREATE_CHECKER',0),(774,'organisation','UPDATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','UPDATE',0),(775,'organisation','UPDATE_EMAIL_CAMPAIGN_CHECKER','EMAIL_CAMPAIGN','UPDATE_CHECKER',0),(776,'organisation','DELETE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','DELETE',0),(777,'organisation','DELETE_EMAIL_CAMPAIGN_CHECKER','EMAIL_CAMPAIGN','DELETE_CHECKER',0),(778,'organisation','CLOSE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','CLOSE',0),(779,'organisation','ACTIVATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','ACTIVATE',0),(780,'organisation','REACTIVATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','REACTIVATE',0),(781,'organisation','READ_EMAIL_CONFIGURATION','EMAIL_CONFIGURATION','READ',0),(782,'organisation','UPDATE_EMAIL_CONFIGURATION','EMAIL_CONFIGURATION','UPDATE',0),(783,'report','READ_Active Clients - Email','Active Clients - Email','READ',0),(784,'report','READ_Prospective Clients - Email','Prospective Clients - Email','READ',0),(785,'report','READ_Active Loan Clients - Email','Active Loan Clients - Email','READ',0),(786,'report','READ_Loans in arrears - Email','Loans in arrears - Email','READ',0),(787,'report','READ_Loans disbursed to clients - Email','Loans disbursed to clients - Email','READ',0),(788,'report','READ_Loan payments due - Email','Loan payments due - Email','READ',0),(789,'report','READ_Dormant Prospects - Email','Dormant Prospects - Email','READ',0),(790,'report','READ_Active Group Leaders - Email','Active Group Leaders - Email','READ',0),(791,'report','READ_Loan Payments Due (Overdue Loans) - Email','Loan Payments Due (Overdue Loans) - Email','READ',0),(792,'report','READ_Loan Payments Received (Active Loans) - Email','Loan Payments Received (Active Loans) - Email','READ',0),(793,'report','READ_Loan Payments Received (Overdue Loans) - Email','Loan Payments Received (Overdue Loans)  - Email','READ',0),(794,'report','READ_Loan Fully Repaid - Email','Loan Fully Repaid - Email','READ',0),(795,'report','READ_Loans Outstanding after final instalment date - Email','Loans Outstanding after final instalment date - Email','READ',0),(796,'report','READ_Happy Birthday - Email','Happy Birthday - Email','READ',0),(797,'report','READ_Loan Rejected - Email','Loan Rejected - Email','READ',0),(798,'report','READ_Loan Approved - Email','Loan Approved - Email','READ',0),(799,'report','READ_Loan Repayment - Email','Loan Repayment - Email','READ',0),(800,'datatable','READ_ENTITY_DATATABLE_CHECK','ENTITY_DATATABLE_CHECK','READ',0),(801,'datatable','CREATE_ENTITY_DATATABLE_CHECK','ENTITY_DATATABLE_CHECK','CREATE',0),(802,'datatable','DELETE_ENTITY_DATATABLE_CHECK','ENTITY_DATATABLE_CHECK','DELETE',0),(803,'configuration','CREATE_CREDITBUREAU_LOANPRODUCT_MAPPING','CREDITBUREAU_LOANPRODUCT_MAPPING','CREATE',0),(804,'configuration','CREATE_ORGANISATIONCREDITBUREAU','ORGANISATIONCREDITBUREAU','CREATE',0),(805,'configuration','UPDATE_ORGANISATIONCREDITBUREAU','ORGANISATIONCREDITBUREAU','UPDATE',0),(806,'configuration','UPDATE_CREDITBUREAU_LOANPRODUCT_MAPPING','CREDITBUREAU_LOANPRODUCT_MAPPING','UPDATE',0),(807,'portfolio','CREATE_FAMILYMEMBERS','FAMILYMEMBERS','CREATE',0),(808,'portfolio','UPDATE_FAMILYMEMBERS','FAMILYMEMBERS','UPDATE',0),(809,'portfolio','DELETE_FAMILYMEMBERS','FAMILYMEMBERS','DELETE',0),(810,'transaction_savings','HOLDAMOUNT_SAVINGSACCOUNT','SAVINGSACCOUNT','HOLDAMOUNT',0),(811,'transaction_savings','HOLDAMOUNT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','HOLDAMOUNT_CHECKER',0),(812,'transaction_savings','BLOCKDEBIT_SAVINGSACCOUNT','SAVINGSACCOUNT','BLOCKDEBIT',0),(813,'transaction_savings','BLOCKDEBIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','BLOCKDEBIT_CHECKER',0),(814,'transaction_savings','UNBLOCKDEBIT_SAVINGSACCOUNT','SAVINGSACCOUNT','UNBLOCKDEBIT',0),(815,'transaction_savings','UNBLOCKDEBIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNBLOCKDEBIT_CHECKER',0),(816,'transaction_savings','BLOCKCREDIT_SAVINGSACCOUNT','SAVINGSACCOUNT','BLOCKCREDIT',0),(817,'transaction_savings','BLOCKCREDIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','BLOCKCREDIT_CHECKER',0),(818,'transaction_savings','UNBLOCKCREDIT_SAVINGSACCOUNT','SAVINGSACCOUNT','UNBLOCKCREDIT',0),(819,'transaction_savings','UNBLOCKCREDIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNBLOCKCREDIT_CHECKER',0),(820,'transaction_savings','BLOCK_SAVINGSACCOUNT','SAVINGSACCOUNT','BLOCK',0),(821,'transaction_savings','BLOCK_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','BLOCK_CHECKER',0),(822,'transaction_savings','UNBLOCK_SAVINGSACCOUNT','SAVINGSACCOUNT','UNBLOCK',0),(823,'transaction_savings','UNBLOCK_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNBLOCK_CHECKER',0),(824,'transaction_savings','RELEASEAMOUNT_SAVINGSACCOUNT','SAVINGSACCOUNT','RELEASEAMOUNT',0),(825,'transaction_savings','RELEASEAMOUNT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','RELEASEAMOUNT_CHECKER',0),(826,'authorisation','UPDATE_ADHOC','ADHOC','UPDATE',1),(827,'authorisation','UPDATE_ADHOC_CHECKER','ADHOC','UPDATE',0),(828,'authorisation','DELETE_ADHOC','ADHOC','DELETE',1),(829,'authorisation','DELETE_ADHOC_CHECKER','ADHOC','DELETE',0),(830,'authorisation','CREATE_ADHOC','ADHOC','CREATE',1),(831,'authorisation','CREATE_ADHOC_CHECKER','ADHOC','CREATE',0),(832,'authorisation','INVALIDATE_TWOFACTOR_ACCESSTOKEN','TWOFACTOR_ACCESSTOKEN','INVALIDATE',0),(833,'configuration','READ_TWOFACTOR_CONFIGURATION','TWOFACTOR_CONFIGURATION','READ',0),(834,'configuration','UPDATE_TWOFACTOR_CONFIGURATION','TWOFACTOR_CONFIGURATION','UPDATE',0),(835,'special','BYPASS_TWOFACTOR',NULL,NULL,0),(836,'infrastructure','READ_IMPORT','IMPORT','READ',0),(837,'datatable','CREATE_duplicate_loan','duplicate_loan','CREATE',1),(838,'datatable','CREATE_duplicate_loan_CHECKER','duplicate_loan','CREATE',0),(839,'datatable','READ_duplicate_loan','duplicate_loan','READ',0),(840,'datatable','UPDATE_duplicate_loan','duplicate_loan','UPDATE',1),(841,'datatable','UPDATE_duplicate_loan_CHECKER','duplicate_loan','UPDATE',0),(842,'datatable','DELETE_duplicate_loan','duplicate_loan','DELETE',1),(843,'datatable','DELETE_duplicate_loan_CHECKER','duplicate_loan','DELETE',0),(844,'datatable','CREATE_motorbike_details','motorbike_details','CREATE',1),(845,'datatable','CREATE_motorbike_details_CHECKER','motorbike_details','CREATE',0),(846,'datatable','READ_motorbike_details','motorbike_details','READ',0),(847,'datatable','UPDATE_motorbike_details','motorbike_details','UPDATE',1),(848,'datatable','UPDATE_motorbike_details_CHECKER','motorbike_details','UPDATE',0),(849,'datatable','DELETE_motorbike_details','motorbike_details','DELETE',1),(850,'datatable','DELETE_motorbike_details_CHECKER','motorbike_details','DELETE',0),(858,'datatable','CREATE_More Client Details','More Client Details','CREATE',1),(859,'datatable','CREATE_More Client Details_CHECKER','More Client Details','CREATE',0),(860,'datatable','READ_More Client Details','More Client Details','READ',0),(861,'datatable','UPDATE_More Client Details','More Client Details','UPDATE',1),(862,'datatable','UPDATE_More Client Details_CHECKER','More Client Details','UPDATE',0),(863,'datatable','DELETE_More Client Details','More Client Details','DELETE',1),(864,'datatable','DELETE_More Client Details_CHECKER','More Client Details','DELETE',0),(865,'report','READ_Daily Teller Cash Report (Pentaho)','Daily Teller Cash Report (Pentaho)','READ',0),(866,'portfolio','LINK_ACCOUNT_TO_POCKET','POCKET','LINK_ACCOUNT_TO',0),(867,'portfolio','DELINK_ACCOUNT_FROM_POCKET','POCKET','DELINK_ACCOUNT_FROM',0);
/*!40000 ALTER TABLE `m_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_pocket`
--

DROP TABLE IF EXISTS `m_pocket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_pocket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_id` (`app_user_id`),
  CONSTRAINT `FK__m_appuser__pocket` FOREIGN KEY (`app_user_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_pocket`
--

LOCK TABLES `m_pocket` WRITE;
/*!40000 ALTER TABLE `m_pocket` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_pocket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_pocket_accounts_mapping`
--

DROP TABLE IF EXISTS `m_pocket_accounts_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_pocket_accounts_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pocket_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `account_type` int(5) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_pocket_mapping` (`pocket_id`,`account_id`,`account_type`),
  CONSTRAINT `FK__m_pocket` FOREIGN KEY (`pocket_id`) REFERENCES `m_pocket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_pocket_accounts_mapping`
--

LOCK TABLES `m_pocket_accounts_mapping` WRITE;
/*!40000 ALTER TABLE `m_pocket_accounts_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_pocket_accounts_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_portfolio_account_associations`
--

DROP TABLE IF EXISTS `m_portfolio_account_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_portfolio_account_associations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_account_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `linked_loan_account_id` bigint(20) DEFAULT NULL,
  `linked_savings_account_id` bigint(20) DEFAULT NULL,
  `association_type_enum` smallint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `account_association_loan_fk` (`loan_account_id`),
  KEY `account_association_savings_fk` (`savings_account_id`),
  KEY `linked_loan_fk` (`linked_loan_account_id`),
  KEY `linked_savings_fk` (`linked_savings_account_id`),
  CONSTRAINT `account_association_loan_fk` FOREIGN KEY (`loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `account_association_savings_fk` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `linked_loan_fk` FOREIGN KEY (`linked_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `linked_savings_fk` FOREIGN KEY (`linked_savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_portfolio_account_associations`
--

LOCK TABLES `m_portfolio_account_associations` WRITE;
/*!40000 ALTER TABLE `m_portfolio_account_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_portfolio_account_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_portfolio_command_source`
--

DROP TABLE IF EXISTS `m_portfolio_command_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_portfolio_command_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(50) NOT NULL,
  `entity_name` varchar(50) NOT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `api_get_url` varchar(100) NOT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `subresource_id` bigint(20) DEFAULT NULL,
  `command_as_json` text NOT NULL,
  `maker_id` bigint(20) NOT NULL,
  `made_on_date` datetime NOT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `checked_on_date` datetime DEFAULT NULL,
  `processing_result_enum` smallint(5) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `creditbureau_id` bigint(20) DEFAULT NULL,
  `organisation_creditbureau_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_maker_m_appuser` (`maker_id`),
  KEY `FK_m_checker_m_appuser` (`checker_id`),
  KEY `action_name` (`action_name`),
  KEY `entity_name` (`entity_name`,`resource_id`),
  KEY `made_on_date` (`made_on_date`),
  KEY `checked_on_date` (`checked_on_date`),
  KEY `processing_result_enum` (`processing_result_enum`),
  KEY `office_id` (`office_id`),
  KEY `group_id` (`office_id`),
  KEY `client_id` (`office_id`),
  KEY `loan_id` (`office_id`),
  CONSTRAINT `FK_m_checker_m_appuser` FOREIGN KEY (`checker_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_maker_m_appuser` FOREIGN KEY (`maker_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_portfolio_command_source`
--

LOCK TABLES `m_portfolio_command_source` WRITE;
/*!40000 ALTER TABLE `m_portfolio_command_source` DISABLE KEYS */;
INSERT INTO `m_portfolio_command_source` VALUES (1,'CREATE','CLIENT',1,NULL,1,NULL,NULL,'/clients/template',1,NULL,'{\"address\":[],\"familyMembers\":[],\"officeId\":1,\"legalFormId\":1,\"firstname\":\"Test\",\"lastname\":\"Test\",\"active\":true,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"04 April 2019\",\"submittedOnDate\":\"04 April 2019\",\"savingsProductId\":null}',1,'2019-04-04 14:29:56',NULL,NULL,1,NULL,NULL,NULL,NULL),(2,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"duplicate_loan\",\"apptableName\":\"m_loan\",\"multiRow\":true,\"columns\":[{\"name\":\"cityLoanId\",\"type\":\"String\",\"mandatory\":false,\"length\":\"100\"},{\"name\":\"clientLoanId\",\"type\":\"String\",\"mandatory\":false,\"length\":\"100\"}]}',1,'2019-04-04 14:31:37',NULL,NULL,1,NULL,NULL,NULL,NULL),(3,'CREATE','LOANPRODUCT',NULL,NULL,NULL,NULL,NULL,'/loanproducts/template',1,NULL,'{\"currencyCode\":\"USD\",\"includeInBorrowerCycle\":\"false\",\"useBorrowerCycle\":false,\"digitsAfterDecimal\":\"0\",\"inMultiplesOf\":\"0\",\"repaymentFrequencyType\":2,\"interestRateFrequencyType\":2,\"amortizationType\":1,\"interestType\":0,\"interestCalculationPeriodType\":1,\"transactionProcessingStrategyId\":1,\"principalVariationsForBorrowerCycle\":[],\"interestRateVariationsForBorrowerCycle\":[],\"numberOfRepaymentVariationsForBorrowerCycle\":[],\"multiDisburseLoan\":false,\"accountingRule\":\"1\",\"daysInYearType\":1,\"daysInMonthType\":1,\"isInterestRecalculationEnabled\":false,\"preClosureInterestCalculationStrategy\":1,\"isLinkedToFloatingInterestRates\":false,\"allowVariableInstallments\":false,\"name\":\"Dummy\",\"description\":\"Dummy Product\",\"shortName\":\"TS\",\"installmentAmountInMultiplesOf\":\"1\",\"minPrincipal\":\"1000\",\"principal\":\"10000\",\"maxPrincipal\":\"100000\",\"minNumberOfRepayments\":\"1\",\"numberOfRepayments\":\"10\",\"maxNumberOfRepayments\":\"12\",\"minInterestRatePerPeriod\":\"1\",\"interestRatePerPeriod\":\"3\",\"maxInterestRatePerPeriod\":\"6\",\"repaymentEvery\":\"1\",\"paymentChannelToFundSourceMappings\":[],\"feeToIncomeAccountMappings\":[],\"penaltyToIncomeAccountMappings\":[],\"charges\":[],\"allowAttributeOverrides\":{\"amortizationType\":true,\"interestType\":true,\"transactionProcessingStrategyId\":true,\"interestCalculationPeriodType\":true,\"inArrearsTolerance\":true,\"repaymentEvery\":true,\"graceOnPrincipalAndInterestPayment\":true,\"graceOnArrearsAgeing\":true},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2019-04-04 14:33:06',NULL,NULL,1,NULL,NULL,NULL,NULL),(4,'CREATE','LOAN',1,NULL,1,1,NULL,'/loans',1,NULL,'{\"clientId\":\"1\",\"productId\":1,\"disbursementData\":[],\"principal\":10000,\"loanTermFrequency\":10,\"loanTermFrequencyType\":2,\"numberOfRepayments\":10,\"repaymentEvery\":1,\"repaymentFrequencyType\":2,\"interestRatePerPeriod\":3,\"amortizationType\":1,\"isEqualAmortization\":false,\"interestType\":0,\"interestCalculationPeriodType\":1,\"allowPartialPeriodInterestCalcualtion\":false,\"transactionProcessingStrategyId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"loanType\":\"individual\",\"expectedDisbursementDate\":\"04 April 2019\",\"submittedOnDate\":\"04 April 2019\"}',1,'2019-04-04 14:33:38',NULL,NULL,1,NULL,NULL,NULL,NULL),(5,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"motorbike_details\",\"apptableName\":\"m_client\",\"multiRow\":true,\"columns\":[{\"name\":\"Model\",\"type\":\"String\",\"mandatory\":false,\"length\":\"255\"},{\"name\":\"Engine\",\"type\":\"String\",\"mandatory\":false,\"length\":\"255\"}]}',1,'2019-04-04 14:37:15',NULL,NULL,1,NULL,NULL,NULL,NULL),(6,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"More Client Details\",\"apptableName\":\"m_client\",\"multiRow\":true,\"columns\":[{\"name\":\"email\",\"type\":\"String\",\"mandatory\":false,\"length\":\"100\"}]}',1,'2019-04-04 14:39:44',NULL,NULL,1,NULL,NULL,NULL,NULL),(7,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"More Client Details\",\"apptableName\":\"m_client\",\"multiRow\":false,\"columns\":[{\"name\":\"email\",\"type\":\"String\",\"mandatory\":false,\"length\":\"255\"}]}',1,'2019-04-04 14:41:45',NULL,NULL,1,NULL,NULL,NULL,NULL),(8,'CREATE','ENTITY_DATATABLE_CHECK',NULL,NULL,NULL,NULL,NULL,'/entityDatatableChecks/',1,NULL,'{\"entity\":\"m_client\",\"status\":100,\"datatableName\":\"More Client Details\"}',1,'2019-04-04 14:42:27',NULL,NULL,1,NULL,NULL,NULL,NULL),(9,'CREATE','CLIENT',1,NULL,2,NULL,NULL,'/clients/template',2,NULL,'{\"address\":[],\"familyMembers\":[],\"datatables\":[{\"registeredTableName\":\"More Client Details\",\"data\":{\"locale\":\"en\",\"email\":\"cliffordmasi07@gmail.com\"}}],\"officeId\":1,\"firstname\":\"Clifford\",\"lastname\":\"Masi\",\"legalFormId\":1,\"active\":true,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"04 April 2019\",\"submittedOnDate\":\"04 April 2019\",\"savingsProductId\":null}',1,'2019-04-04 14:43:18',NULL,NULL,1,NULL,NULL,NULL,NULL),(10,'CREATE','LOAN',1,NULL,2,2,NULL,'/loans',2,NULL,'{\"clientId\":\"2\",\"productId\":1,\"disbursementData\":[],\"principal\":10000,\"loanTermFrequency\":10,\"loanTermFrequencyType\":2,\"numberOfRepayments\":10,\"repaymentEvery\":1,\"repaymentFrequencyType\":2,\"interestRatePerPeriod\":3,\"amortizationType\":1,\"isEqualAmortization\":false,\"interestType\":0,\"interestCalculationPeriodType\":1,\"allowPartialPeriodInterestCalcualtion\":false,\"transactionProcessingStrategyId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"loanType\":\"individual\",\"expectedDisbursementDate\":\"04 April 2019\",\"submittedOnDate\":\"04 April 2019\"}',1,'2019-04-04 14:47:14',NULL,NULL,1,NULL,NULL,NULL,NULL),(11,'CREATE','LOAN',1,NULL,2,3,NULL,'/loans',3,NULL,'{\"clientId\":\"2\",\"productId\":1,\"disbursementData\":[],\"principal\":10000,\"loanTermFrequency\":10,\"loanTermFrequencyType\":2,\"numberOfRepayments\":10,\"repaymentEvery\":1,\"repaymentFrequencyType\":2,\"interestRatePerPeriod\":3,\"amortizationType\":1,\"isEqualAmortization\":false,\"interestType\":0,\"interestCalculationPeriodType\":1,\"allowPartialPeriodInterestCalcualtion\":false,\"transactionProcessingStrategyId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"loanType\":\"individual\",\"expectedDisbursementDate\":\"04 April 2019\",\"submittedOnDate\":\"04 April 2019\"}',1,'2019-04-04 14:47:15',NULL,NULL,1,NULL,NULL,NULL,NULL),(12,'APPROVE','LOAN',1,NULL,2,3,NULL,'/loans/3',3,NULL,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\",\"pendingApproval\":false,\"waitingForDisbursal\":true,\"active\":false,\"closedObligationsMet\":false,\"closedWrittenOff\":false,\"closedRescheduled\":false,\"closed\":false,\"overpaid\":false},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"04 April 2019\",\"expectedDisbursementDate\":{}}',1,'2019-04-04 14:47:31',NULL,NULL,1,NULL,NULL,NULL,NULL),(13,'DISBURSE','LOAN',1,NULL,2,3,NULL,'/loans/3',3,NULL,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\",\"pendingApproval\":false,\"waitingForDisbursal\":false,\"active\":true,\"closedObligationsMet\":false,\"closedWrittenOff\":false,\"closedRescheduled\":false,\"closed\":false,\"overpaid\":false},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"actualDisbursementDate\":\"04 April 2019\"}',1,'2019-04-04 15:16:05',NULL,NULL,1,NULL,NULL,NULL,NULL),(14,'REPAYMENT','LOAN',1,NULL,2,3,NULL,'/loans/3/transactions/template?command=repayment',3,NULL,'{\"transactionDate\":\"04 April 2019\",\"transactionAmount\":\"1172\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"paymentTypeId\":\"\"}',1,'2019-04-04 15:17:28',NULL,NULL,1,NULL,NULL,NULL,NULL),(15,'CREATE','STAFF',1,NULL,NULL,NULL,NULL,'/staff/template',1,NULL,'{\"isLoanOfficer\":true,\"officeId\":1,\"firstname\":\"PIUS\",\"lastname\":\"SYUKI\",\"joiningDate\":\"01 February 2019\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2019-04-04 16:15:05',NULL,NULL,1,NULL,NULL,NULL,NULL),(16,'CREATE','STAFF',1,NULL,NULL,NULL,NULL,'/staff/template',2,NULL,'{\"isLoanOfficer\":true,\"officeId\":1,\"firstname\":\"PARTICIA\",\"lastname\":\"KISINI\",\"joiningDate\":\"01 February 2019\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2019-04-04 16:15:42',NULL,NULL,1,NULL,NULL,NULL,NULL),(17,'CREATE','motorbike_details',1,NULL,2,NULL,NULL,'/datatables/motorbike_details/2',2,NULL,'{\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"Model\":\"\",\"Engine\":\"\"}',1,'2019-04-08 14:08:41',NULL,NULL,1,NULL,NULL,NULL,NULL),(18,'CREATE','PAYMENTTYPE',NULL,NULL,NULL,NULL,NULL,'/paymenttype',1,NULL,'{\"name\":\"Cash\",\"description\":\"cash\",\"isCashPayment\":true,\"position\":\"1\"}',1,'2019-04-26 16:36:12',NULL,NULL,1,NULL,NULL,NULL,NULL),(19,'CREATE','PAYMENTTYPE',NULL,NULL,NULL,NULL,NULL,'/paymenttype',2,NULL,'{\"name\":\"Cheque\",\"description\":\"cheque\",\"position\":\"2\",\"isCashPayment\":false}',1,'2019-04-26 16:36:29',NULL,NULL,1,NULL,NULL,NULL,NULL),(20,'CREATE','PAYMENTTYPE',NULL,NULL,NULL,NULL,NULL,'/paymenttype',3,NULL,'{\"name\":\"Credit\",\"description\":\"credit\",\"isCashPayment\":false,\"position\":\"3\"}',1,'2019-04-26 16:36:41',NULL,NULL,1,NULL,NULL,NULL,NULL),(21,'CREATE','PAYMENTTYPE',NULL,NULL,NULL,NULL,NULL,'/paymenttype',4,NULL,'{\"name\":\"Mpesa\",\"description\":\"mpesa\",\"isCashPayment\":true,\"position\":\"4\"}',1,'2019-04-26 16:36:53',NULL,NULL,1,NULL,NULL,NULL,NULL),(22,'CREATE','LOANPRODUCT',NULL,NULL,NULL,NULL,NULL,'/loanproducts/template',2,NULL,'{\"currencyCode\":\"USD\",\"includeInBorrowerCycle\":\"false\",\"useBorrowerCycle\":false,\"digitsAfterDecimal\":\"0\",\"inMultiplesOf\":\"0\",\"repaymentFrequencyType\":2,\"interestRateFrequencyType\":2,\"amortizationType\":1,\"interestType\":0,\"interestCalculationPeriodType\":1,\"transactionProcessingStrategyId\":1,\"principalVariationsForBorrowerCycle\":[],\"interestRateVariationsForBorrowerCycle\":[],\"numberOfRepaymentVariationsForBorrowerCycle\":[],\"multiDisburseLoan\":false,\"accountingRule\":\"1\",\"daysInYearType\":1,\"daysInMonthType\":1,\"isInterestRecalculationEnabled\":false,\"preClosureInterestCalculationStrategy\":1,\"isLinkedToFloatingInterestRates\":false,\"allowVariableInstallments\":false,\"name\":\"New\",\"shortName\":\"N\",\"minPrincipal\":\"1000\",\"principal\":\"1000\",\"maxPrincipal\":\"9000\",\"minNumberOfRepayments\":\"1\",\"numberOfRepayments\":\"3\",\"maxNumberOfRepayments\":\"5\",\"minInterestRatePerPeriod\":\"2\",\"interestRatePerPeriod\":\"4\",\"maxInterestRatePerPeriod\":\"6\",\"repaymentEvery\":\"1\",\"paymentChannelToFundSourceMappings\":[],\"feeToIncomeAccountMappings\":[],\"penaltyToIncomeAccountMappings\":[],\"charges\":[],\"allowAttributeOverrides\":{\"amortizationType\":true,\"interestType\":true,\"transactionProcessingStrategyId\":true,\"interestCalculationPeriodType\":true,\"inArrearsTolerance\":true,\"repaymentEvery\":true,\"graceOnPrincipalAndInterestPayment\":true,\"graceOnArrearsAgeing\":true},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2019-04-26 16:44:37',NULL,NULL,1,NULL,NULL,NULL,NULL),(23,'CREATE','LOAN',1,NULL,2,4,NULL,'/loans',4,NULL,'{\"clientId\":\"2\",\"productId\":2,\"disbursementData\":[],\"principal\":1000,\"loanTermFrequency\":3,\"loanTermFrequencyType\":2,\"numberOfRepayments\":3,\"repaymentEvery\":1,\"repaymentFrequencyType\":2,\"interestRatePerPeriod\":4,\"amortizationType\":1,\"interestType\":0,\"interestCalculationPeriodType\":1,\"allowPartialPeriodInterestCalcualtion\":false,\"transactionProcessingStrategyId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"loanType\":\"individual\",\"expectedDisbursementDate\":\"26 April 2019\",\"submittedOnDate\":\"26 April 2019\"}',1,'2019-04-26 16:44:52',NULL,NULL,1,NULL,NULL,NULL,NULL),(24,'APPROVE','LOAN',1,NULL,2,4,NULL,'/loans/4',4,NULL,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\",\"pendingApproval\":false,\"waitingForDisbursal\":true,\"active\":false,\"closedObligationsMet\":false,\"closedWrittenOff\":false,\"closedRescheduled\":false,\"closed\":false,\"overpaid\":false},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"26 April 2019\",\"expectedDisbursementDate\":{}}',1,'2019-04-26 16:44:57',NULL,NULL,1,NULL,NULL,NULL,NULL),(25,'DISBURSE','LOAN',1,NULL,2,4,NULL,'/loans/4',4,NULL,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\",\"pendingApproval\":false,\"waitingForDisbursal\":false,\"active\":true,\"closedObligationsMet\":false,\"closedWrittenOff\":false,\"closedRescheduled\":false,\"closed\":false,\"overpaid\":false},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"actualDisbursementDate\":\"26 April 2019\"}',1,'2019-04-26 16:45:01',NULL,NULL,1,NULL,NULL,NULL,NULL),(26,'REPAYMENT','LOAN',1,NULL,2,4,NULL,'/loans/4/transactions/template?command=repayment',6,NULL,'{\"transactionDate\":\"29 April 2019\",\"transactionAmount\":\"360\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"paymentTypeId\":\"4\",\"receiptNumber\":\"ethryu\",\"bankNumber\":\"rtuityty\"}',1,'2019-04-29 09:57:27',NULL,NULL,1,NULL,NULL,NULL,NULL),(27,'REPAYMENT','LOAN',1,NULL,2,4,NULL,'/loans/4/transactions/template?command=repayment',7,NULL,'{\"transactionDate\":\"29 April 2019\",\"transactionAmount\":\"360\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"paymentTypeId\":\"4\",\"receiptNumber\":\"test\",\"bankNumber\":\"test\"}',1,'2019-04-29 09:57:53',NULL,NULL,1,NULL,NULL,NULL,NULL),(28,'CREATE','LOAN',1,NULL,396,5,NULL,'/loans',5,NULL,'{\"clientId\":\"396\",\"productId\":2,\"disbursementData\":[],\"principal\":1000,\"loanTermFrequency\":3,\"loanTermFrequencyType\":2,\"numberOfRepayments\":3,\"repaymentEvery\":1,\"repaymentFrequencyType\":2,\"interestRatePerPeriod\":4,\"amortizationType\":1,\"interestType\":0,\"interestCalculationPeriodType\":1,\"allowPartialPeriodInterestCalcualtion\":false,\"transactionProcessingStrategyId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"loanType\":\"individual\",\"expectedDisbursementDate\":\"07 May 2019\",\"submittedOnDate\":\"07 May 2019\"}',1,'2019-05-07 09:43:19',NULL,NULL,1,NULL,NULL,NULL,NULL),(29,'APPROVE','LOAN',1,NULL,396,5,NULL,'/loans/5',5,NULL,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\",\"pendingApproval\":false,\"waitingForDisbursal\":true,\"active\":false,\"closedObligationsMet\":false,\"closedWrittenOff\":false,\"closedRescheduled\":false,\"closed\":false,\"overpaid\":false},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"07 May 2019\",\"expectedDisbursementDate\":{}}',1,'2019-05-07 09:43:24',NULL,NULL,1,NULL,NULL,NULL,NULL),(30,'DISBURSE','LOAN',1,NULL,396,5,NULL,'/loans/5',5,NULL,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\",\"pendingApproval\":false,\"waitingForDisbursal\":false,\"active\":true,\"closedObligationsMet\":false,\"closedWrittenOff\":false,\"closedRescheduled\":false,\"closed\":false,\"overpaid\":false},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"actualDisbursementDate\":\"07 May 2019\"}',1,'2019-05-07 09:43:28',NULL,NULL,1,NULL,NULL,NULL,NULL),(31,'REPAYMENT','LOAN',1,NULL,396,5,NULL,'/loans/5/transactions/template?command=repayment',10,NULL,'{\"transactionDate\":\"07 May 2019\",\"transactionAmount\":\"360\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"paymentTypeId\":\"4\",\"receiptNumber\":\"MBL0UW55K8\",\"bankNumber\":\"MBL0UW55K8\"}',1,'2019-05-07 09:43:59',NULL,NULL,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_portfolio_command_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan`
--

DROP TABLE IF EXISTS `m_product_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `short_name` varchar(4) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `min_principal_amount` decimal(19,6) DEFAULT NULL,
  `max_principal_amount` decimal(19,6) DEFAULT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `is_linked_to_floating_interest_rates` bit(1) NOT NULL DEFAULT b'0',
  `allow_variabe_installments` bit(1) NOT NULL DEFAULT b'0',
  `nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `min_nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `max_nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `interest_period_frequency_enum` smallint(5) DEFAULT NULL,
  `annual_nominal_interest_rate` decimal(19,6) DEFAULT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `allow_partial_period_interest_calcualtion` tinyint(1) NOT NULL DEFAULT '0',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `min_number_of_repayments` smallint(5) DEFAULT NULL,
  `max_number_of_repayments` smallint(5) DEFAULT NULL,
  `grace_on_principal_periods` smallint(5) DEFAULT NULL,
  `recurring_moratorium_principal_periods` smallint(5) DEFAULT NULL,
  `grace_on_interest_periods` smallint(5) DEFAULT NULL,
  `grace_interest_free_periods` smallint(5) DEFAULT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `accounting_type` smallint(5) NOT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `include_in_borrower_cycle` tinyint(1) NOT NULL DEFAULT '0',
  `use_borrower_cycle` tinyint(1) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `allow_multiple_disbursals` tinyint(1) NOT NULL DEFAULT '0',
  `max_disbursals` int(2) DEFAULT NULL,
  `max_outstanding_loan_balance` decimal(19,6) DEFAULT NULL,
  `grace_on_arrears_ageing` smallint(5) DEFAULT NULL,
  `overdue_days_for_npa` smallint(5) DEFAULT NULL,
  `days_in_month_enum` smallint(5) NOT NULL DEFAULT '1',
  `days_in_year_enum` smallint(5) NOT NULL DEFAULT '1',
  `interest_recalculation_enabled` tinyint(4) NOT NULL DEFAULT '0',
  `min_days_between_disbursal_and_first_repayment` int(3) DEFAULT NULL,
  `hold_guarantee_funds` tinyint(1) NOT NULL DEFAULT '0',
  `principal_threshold_for_last_installment` decimal(5,2) NOT NULL DEFAULT '50.00',
  `account_moves_out_of_npa_only_on_arrears_completion` tinyint(1) NOT NULL DEFAULT '0',
  `can_define_fixed_emi_amount` tinyint(1) NOT NULL DEFAULT '0',
  `instalment_amount_in_multiples_of` decimal(19,6) DEFAULT NULL,
  `can_use_for_topup` tinyint(1) NOT NULL DEFAULT '0',
  `sync_expected_with_disbursement_date` tinyint(4) DEFAULT '0',
  `is_equal_amortization` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`),
  UNIQUE KEY `unq_short_name` (`short_name`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `FKA6A8A7D77240145` (`fund_id`),
  KEY `FK_ltp_strategy` (`loan_transaction_strategy_id`),
  CONSTRAINT `FKA6A8A7D77240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FK_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan`
--

LOCK TABLES `m_product_loan` WRITE;
/*!40000 ALTER TABLE `m_product_loan` DISABLE KEYS */;
INSERT INTO `m_product_loan` VALUES (1,'TS','USD',0,0,10000.000000,1000.000000,100000.000000,NULL,'Dummy','Dummy Product',NULL,'\0','\0',3.000000,1.000000,6.000000,2,36.000000,0,1,0,1,2,10,1,12,NULL,NULL,NULL,NULL,1,1,1,NULL,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,1,1,0,NULL,0,0.00,0,0,1.000000,0,0,0),(2,'N','USD',0,0,1000.000000,1000.000000,9000.000000,NULL,'New',NULL,NULL,'\0','\0',4.000000,2.000000,6.000000,2,48.000000,0,1,0,1,2,3,1,5,NULL,NULL,NULL,NULL,1,1,1,NULL,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,1,1,0,NULL,0,0.00,0,0,NULL,0,0,0);
/*!40000 ALTER TABLE `m_product_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_charge`
--

DROP TABLE IF EXISTS `m_product_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_charge` (
  `product_loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`product_loan_id`,`charge_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `m_product_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_product_loan_charge_ibfk_2` FOREIGN KEY (`product_loan_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_charge`
--

LOCK TABLES `m_product_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_product_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_configurable_attributes`
--

DROP TABLE IF EXISTS `m_product_loan_configurable_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_configurable_attributes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `amortization_method_enum` tinyint(4) NOT NULL DEFAULT '1',
  `interest_method_enum` tinyint(4) NOT NULL DEFAULT '1',
  `loan_transaction_strategy_id` tinyint(4) NOT NULL DEFAULT '1',
  `interest_calculated_in_period_enum` tinyint(4) NOT NULL DEFAULT '1',
  `arrearstolerance_amount` tinyint(4) NOT NULL DEFAULT '1',
  `repay_every` tinyint(4) NOT NULL DEFAULT '1',
  `moratorium` tinyint(4) NOT NULL DEFAULT '1',
  `grace_on_arrears_ageing` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_m_product_loan_configurable_attributes_0001` (`loan_product_id`),
  CONSTRAINT `fk_m_product_loan_configurable_attributes_0001` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_configurable_attributes`
--

LOCK TABLES `m_product_loan_configurable_attributes` WRITE;
/*!40000 ALTER TABLE `m_product_loan_configurable_attributes` DISABLE KEYS */;
INSERT INTO `m_product_loan_configurable_attributes` VALUES (1,1,1,1,1,1,1,1,1,1),(2,2,1,1,1,1,1,1,1,1);
/*!40000 ALTER TABLE `m_product_loan_configurable_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_floating_rates`
--

DROP TABLE IF EXISTS `m_product_loan_floating_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_floating_rates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `floating_rates_id` bigint(20) NOT NULL,
  `interest_rate_differential` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `min_differential_lending_rate` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `default_differential_lending_rate` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `max_differential_lending_rate` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_floating_interest_rate_calculation_allowed` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_product_loan_id` (`loan_product_id`),
  KEY `FK_mappings_m_floating_rates_id` (`floating_rates_id`),
  CONSTRAINT `FK_mappings_m_floating_rates_id` FOREIGN KEY (`floating_rates_id`) REFERENCES `m_floating_rates` (`id`),
  CONSTRAINT `FK_mappings_m_product_loan_id` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_floating_rates`
--

LOCK TABLES `m_product_loan_floating_rates` WRITE;
/*!40000 ALTER TABLE `m_product_loan_floating_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_floating_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_guarantee_details`
--

DROP TABLE IF EXISTS `m_product_loan_guarantee_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_guarantee_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `mandatory_guarantee` decimal(19,5) NOT NULL,
  `minimum_guarantee_from_own_funds` decimal(19,5) DEFAULT NULL,
  `minimum_guarantee_from_guarantor_funds` decimal(19,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_guarantee_details_loan_product` (`loan_product_id`),
  CONSTRAINT `FK_guarantee_details_loan_product` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_guarantee_details`
--

LOCK TABLES `m_product_loan_guarantee_details` WRITE;
/*!40000 ALTER TABLE `m_product_loan_guarantee_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_guarantee_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_recalculation_details`
--

DROP TABLE IF EXISTS `m_product_loan_recalculation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_recalculation_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `compound_type_enum` smallint(5) NOT NULL,
  `reschedule_strategy_enum` smallint(5) NOT NULL,
  `rest_frequency_type_enum` smallint(1) NOT NULL,
  `rest_frequency_interval` smallint(3) NOT NULL DEFAULT '0',
  `arrears_based_on_original_schedule` tinyint(1) NOT NULL DEFAULT '0',
  `pre_close_interest_calculation_strategy` smallint(3) NOT NULL DEFAULT '1',
  `compounding_frequency_type_enum` smallint(1) DEFAULT NULL,
  `compounding_frequency_interval` smallint(3) DEFAULT NULL,
  `rest_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `rest_frequency_on_day` int(5) DEFAULT NULL,
  `rest_frequency_weekday_enum` int(5) DEFAULT NULL,
  `compounding_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `compounding_frequency_on_day` int(5) DEFAULT NULL,
  `compounding_frequency_weekday_enum` int(5) DEFAULT NULL,
  `is_compounding_to_be_posted_as_transaction` tinyint(1) NOT NULL DEFAULT '0',
  `allow_compounding_on_eod` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_m_product_loan_m_product_loan_recalculation_details` (`product_id`),
  CONSTRAINT `FK_m_product_loan_m_product_loan_recalculation_details` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_recalculation_details`
--

LOCK TABLES `m_product_loan_recalculation_details` WRITE;
/*!40000 ALTER TABLE `m_product_loan_recalculation_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_recalculation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_variable_installment_config`
--

DROP TABLE IF EXISTS `m_product_loan_variable_installment_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_variable_installment_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `minimum_gap` int(4) NOT NULL,
  `maximum_gap` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_variable_product_loan_id` (`loan_product_id`),
  CONSTRAINT `FK_mappings_m_variable_product_loan_id` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_variable_installment_config`
--

LOCK TABLES `m_product_loan_variable_installment_config` WRITE;
/*!40000 ALTER TABLE `m_product_loan_variable_installment_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_variable_installment_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_variations_borrower_cycle`
--

DROP TABLE IF EXISTS `m_product_loan_variations_borrower_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_variations_borrower_cycle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL DEFAULT '0',
  `borrower_cycle_number` int(3) NOT NULL DEFAULT '0',
  `value_condition` int(1) NOT NULL DEFAULT '0',
  `param_type` int(1) NOT NULL DEFAULT '0',
  `default_value` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `max_value` decimal(19,6) DEFAULT NULL,
  `min_value` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `borrower_cycle_loan_product_FK` (`loan_product_id`),
  CONSTRAINT `borrower_cycle_loan_product_FK` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_variations_borrower_cycle`
--

LOCK TABLES `m_product_loan_variations_borrower_cycle` WRITE;
/*!40000 ALTER TABLE `m_product_loan_variations_borrower_cycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_variations_borrower_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_mix`
--

DROP TABLE IF EXISTS `m_product_mix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_mix` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `restricted_product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_product_mix_product_id_to_m_product_loan` (`product_id`),
  KEY `FK_m_product_mix_restricted_product_id_to_m_product_loan` (`restricted_product_id`),
  CONSTRAINT `FK_m_product_mix_product_id_to_m_product_loan` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `FK_m_product_mix_restricted_product_id_to_m_product_loan` FOREIGN KEY (`restricted_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_mix`
--

LOCK TABLES `m_product_mix` WRITE;
/*!40000 ALTER TABLE `m_product_mix` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_mix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provision_category`
--

DROP TABLE IF EXISTS `m_provision_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provision_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provision_category`
--

LOCK TABLES `m_provision_category` WRITE;
/*!40000 ALTER TABLE `m_provision_category` DISABLE KEYS */;
INSERT INTO `m_provision_category` VALUES (1,'STANDARD','Punctual Payment without any dues'),(2,'SUB-STANDARD','Principal and/or Interest overdue by x days'),(3,'DOUBTFUL','Principal and/or Interest overdue by x days and less than y'),(4,'LOSS','Principal and/or Interest overdue by y days');
/*!40000 ALTER TABLE `m_provision_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provisioning_criteria`
--

DROP TABLE IF EXISTS `m_provisioning_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provisioning_criteria` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `criteria_name` varchar(200) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `criteria_name` (`criteria_name`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `m_provisioning_criteria_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_provisioning_criteria_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provisioning_criteria`
--

LOCK TABLES `m_provisioning_criteria` WRITE;
/*!40000 ALTER TABLE `m_provisioning_criteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_provisioning_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provisioning_criteria_definition`
--

DROP TABLE IF EXISTS `m_provisioning_criteria_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provisioning_criteria_definition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `criteria_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `min_age` bigint(20) NOT NULL,
  `max_age` bigint(20) NOT NULL,
  `provision_percentage` decimal(5,2) NOT NULL,
  `liability_account` bigint(20) DEFAULT NULL,
  `expense_account` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `criteria_id` (`criteria_id`),
  KEY `category_id` (`category_id`),
  KEY `liability_account` (`liability_account`),
  KEY `expense_account` (`expense_account`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_1` FOREIGN KEY (`criteria_id`) REFERENCES `m_provisioning_criteria` (`id`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `m_provision_category` (`id`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_3` FOREIGN KEY (`liability_account`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_4` FOREIGN KEY (`expense_account`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provisioning_criteria_definition`
--

LOCK TABLES `m_provisioning_criteria_definition` WRITE;
/*!40000 ALTER TABLE `m_provisioning_criteria_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_provisioning_criteria_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provisioning_history`
--

DROP TABLE IF EXISTS `m_provisioning_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provisioning_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `journal_entry_created` bit(1) DEFAULT b'0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `m_provisioning_history_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_provisioning_history_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provisioning_history`
--

LOCK TABLES `m_provisioning_history` WRITE;
/*!40000 ALTER TABLE `m_provisioning_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_provisioning_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_report_mailing_job`
--

DROP TABLE IF EXISTS `m_report_mailing_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_report_mailing_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `start_datetime` datetime NOT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `created_date` date NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodified_date` date DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `email_recipients` text NOT NULL,
  `email_subject` varchar(100) NOT NULL,
  `email_message` text NOT NULL,
  `email_attachment_file_format` varchar(10) NOT NULL,
  `stretchy_report_id` int(11) NOT NULL,
  `stretchy_report_param_map` text,
  `previous_run_datetime` datetime DEFAULT NULL,
  `next_run_datetime` datetime DEFAULT NULL,
  `previous_run_status` varchar(10) DEFAULT NULL,
  `previous_run_error_log` text,
  `previous_run_error_message` text,
  `number_of_runs` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `run_as_userid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  KEY `stretchy_report_id` (`stretchy_report_id`),
  KEY `run_as_userid` (`run_as_userid`),
  CONSTRAINT `m_report_mailing_job_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_report_mailing_job_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_report_mailing_job_ibfk_3` FOREIGN KEY (`stretchy_report_id`) REFERENCES `stretchy_report` (`id`),
  CONSTRAINT `m_report_mailing_job_ibfk_4` FOREIGN KEY (`run_as_userid`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_report_mailing_job`
--

LOCK TABLES `m_report_mailing_job` WRITE;
/*!40000 ALTER TABLE `m_report_mailing_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_report_mailing_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_report_mailing_job_configuration`
--

DROP TABLE IF EXISTS `m_report_mailing_job_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_report_mailing_job_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_report_mailing_job_configuration`
--

LOCK TABLES `m_report_mailing_job_configuration` WRITE;
/*!40000 ALTER TABLE `m_report_mailing_job_configuration` DISABLE KEYS */;
INSERT INTO `m_report_mailing_job_configuration` VALUES (1,'GMAIL_SMTP_SERVER','smtp.gmail.com'),(2,'GMAIL_SMTP_PORT','587'),(3,'GMAIL_SMTP_USERNAME',''),(4,'GMAIL_SMTP_PASSWORD','');
/*!40000 ALTER TABLE `m_report_mailing_job_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_report_mailing_job_run_history`
--

DROP TABLE IF EXISTS `m_report_mailing_job_run_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_report_mailing_job_run_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` text,
  `error_log` text,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `m_report_mailing_job_run_history_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `m_report_mailing_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_report_mailing_job_run_history`
--

LOCK TABLES `m_report_mailing_job_run_history` WRITE;
/*!40000 ALTER TABLE `m_report_mailing_job_run_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_report_mailing_job_run_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role`
--

DROP TABLE IF EXISTS `m_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role`
--

LOCK TABLES `m_role` WRITE;
/*!40000 ALTER TABLE `m_role` DISABLE KEYS */;
INSERT INTO `m_role` VALUES (1,'Super user','This role provides all application permissions.',0),(2,'Self Service User','self service user role',1);
/*!40000 ALTER TABLE `m_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role_permission`
--

DROP TABLE IF EXISTS `m_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `FK8DEDB04815CEC7AB` (`role_id`),
  KEY `FK8DEDB048103B544B` (`permission_id`),
  CONSTRAINT `FK8DEDB048103B544B` FOREIGN KEY (`permission_id`) REFERENCES `m_permission` (`id`),
  CONSTRAINT `FK8DEDB04815CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role_permission`
--

LOCK TABLES `m_role_permission` WRITE;
/*!40000 ALTER TABLE `m_role_permission` DISABLE KEYS */;
INSERT INTO `m_role_permission` VALUES (1,1);
/*!40000 ALTER TABLE `m_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account`
--

DROP TABLE IF EXISTS `m_savings_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `field_officer_id` bigint(20) DEFAULT NULL,
  `status_enum` smallint(5) NOT NULL DEFAULT '300',
  `sub_status_enum` smallint(5) NOT NULL DEFAULT '0',
  `account_type_enum` smallint(5) NOT NULL DEFAULT '1',
  `deposit_type_enum` smallint(5) NOT NULL DEFAULT '100',
  `submittedon_date` date NOT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `activatedon_date` date DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `nominal_annual_interest_rate` decimal(19,6) NOT NULL,
  `interest_compounding_period_enum` smallint(5) NOT NULL,
  `interest_posting_period_enum` smallint(5) NOT NULL DEFAULT '4',
  `interest_calculation_type_enum` smallint(5) NOT NULL,
  `interest_calculation_days_in_year_type_enum` smallint(5) NOT NULL,
  `min_required_opening_balance` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `withdrawal_fee_for_transfer` tinyint(4) DEFAULT '1',
  `allow_overdraft` tinyint(1) NOT NULL DEFAULT '0',
  `overdraft_limit` decimal(19,6) DEFAULT NULL,
  `nominal_annual_interest_rate_overdraft` decimal(19,6) DEFAULT '0.000000',
  `min_overdraft_for_interest_calculation` decimal(19,6) DEFAULT '0.000000',
  `lockedin_until_date_derived` date DEFAULT NULL,
  `total_deposits_derived` decimal(19,6) DEFAULT NULL,
  `total_withdrawals_derived` decimal(19,6) DEFAULT NULL,
  `total_withdrawal_fees_derived` decimal(19,6) DEFAULT NULL,
  `total_fees_charge_derived` decimal(19,6) DEFAULT NULL,
  `total_penalty_charge_derived` decimal(19,6) DEFAULT NULL,
  `total_annual_fees_derived` decimal(19,6) DEFAULT NULL,
  `total_interest_earned_derived` decimal(19,6) DEFAULT NULL,
  `total_interest_posted_derived` decimal(19,6) DEFAULT NULL,
  `total_overdraft_interest_derived` decimal(19,6) DEFAULT '0.000000',
  `total_withhold_tax_derived` decimal(19,6) DEFAULT NULL,
  `account_balance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `min_required_balance` decimal(19,6) DEFAULT NULL,
  `enforce_min_required_balance` tinyint(1) NOT NULL DEFAULT '0',
  `min_balance_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `start_interest_calculation_date` date DEFAULT NULL,
  `on_hold_funds_derived` decimal(19,6) DEFAULT NULL,
  `version` int(15) NOT NULL DEFAULT '1',
  `withhold_tax` tinyint(4) NOT NULL DEFAULT '0',
  `tax_group_id` bigint(20) DEFAULT NULL,
  `last_interest_calculation_date` date DEFAULT NULL,
  `total_savings_amount_on_hold` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sa_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `sa_externalid_UNIQUE` (`external_id`),
  KEY `FKSA00000000000001` (`client_id`),
  KEY `FKSA00000000000002` (`group_id`),
  KEY `FKSA00000000000003` (`product_id`),
  KEY `FK_savings_account_tax_group` (`tax_group_id`),
  CONSTRAINT `FKSA00000000000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKSA00000000000002` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FKSA00000000000003` FOREIGN KEY (`product_id`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FK_savings_account_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account`
--

LOCK TABLES `m_savings_account` WRITE;
/*!40000 ALTER TABLE `m_savings_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_charge`
--

DROP TABLE IF EXISTS `m_savings_account_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_due_date` date DEFAULT NULL,
  `fee_on_month` smallint(5) DEFAULT NULL,
  `fee_on_day` smallint(5) DEFAULT NULL,
  `fee_interval` smallint(5) DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `inactivated_on_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_savings_account_charge_ibfk_2` (`savings_account_id`),
  CONSTRAINT `m_savings_account_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_savings_account_charge_ibfk_2` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_charge`
--

LOCK TABLES `m_savings_account_charge` WRITE;
/*!40000 ALTER TABLE `m_savings_account_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_charge_paid_by`
--

DROP TABLE IF EXISTS `m_savings_account_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_transaction_id` bigint(20) NOT NULL,
  `savings_account_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__m_savings_account_transaction` (`savings_account_transaction_id`),
  KEY `FK__m_savings_account_charge` (`savings_account_charge_id`),
  CONSTRAINT `FK__m_savings_account_charge` FOREIGN KEY (`savings_account_charge_id`) REFERENCES `m_savings_account_charge` (`id`),
  CONSTRAINT `FK__m_savings_account_transaction` FOREIGN KEY (`savings_account_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_charge_paid_by`
--

LOCK TABLES `m_savings_account_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_savings_account_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_interest_rate_chart`
--

DROP TABLE IF EXISTS `m_savings_account_interest_rate_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_interest_rate_chart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `from_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_primary_grouping_by_amount` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKSAIRC00000000000001` (`savings_account_id`),
  CONSTRAINT `FKSAIRC00000000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_interest_rate_chart`
--

LOCK TABLES `m_savings_account_interest_rate_chart` WRITE;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_interest_rate_slab`
--

DROP TABLE IF EXISTS `m_savings_account_interest_rate_slab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_interest_rate_slab` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_interest_rate_chart_id` bigint(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `period_type_enum` smallint(5) DEFAULT NULL,
  `from_period` int(11) DEFAULT NULL,
  `to_period` int(11) DEFAULT NULL,
  `amount_range_from` decimal(19,6) DEFAULT NULL,
  `amount_range_to` decimal(19,6) DEFAULT NULL,
  `annual_interest_rate` decimal(19,6) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSAIRS00000000000001` (`savings_account_interest_rate_chart_id`),
  CONSTRAINT `FKSAIRS00000000000001` FOREIGN KEY (`savings_account_interest_rate_chart_id`) REFERENCES `m_savings_account_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_interest_rate_slab`
--

LOCK TABLES `m_savings_account_interest_rate_slab` WRITE;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_slab` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_slab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_transaction`
--

DROP TABLE IF EXISTS `m_savings_account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `overdraft_amount_derived` decimal(19,6) DEFAULT NULL,
  `balance_end_date_derived` date DEFAULT NULL,
  `balance_number_of_days_derived` int(11) DEFAULT NULL,
  `running_balance_derived` decimal(19,6) DEFAULT NULL,
  `cumulative_balance_derived` decimal(19,6) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `appuser_id` bigint(20) DEFAULT NULL,
  `is_manual` tinyint(1) DEFAULT '0',
  `release_id_of_hold_amount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSAT0000000001` (`savings_account_id`),
  KEY `FK_m_savings_account_transaction_m_payment_detail` (`payment_detail_id`),
  KEY `FK_m_savings_account_transaction_m_office` (`office_id`),
  CONSTRAINT `FKSAT0000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_m_savings_account_transaction_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_savings_account_transaction_m_payment_detail` FOREIGN KEY (`payment_detail_id`) REFERENCES `m_payment_detail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_transaction`
--

LOCK TABLES `m_savings_account_transaction` WRITE;
/*!40000 ALTER TABLE `m_savings_account_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_transaction_tax_details`
--

DROP TABLE IF EXISTS `m_savings_account_transaction_tax_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_transaction_tax_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_transaction_id` bigint(20) NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_savings_account_transaction_tax_details_savings_transaction` (`savings_transaction_id`),
  KEY `FK_savings_account_transaction_tax_details_tax_component` (`tax_component_id`),
  CONSTRAINT `FK_savings_account_transaction_tax_details_savings_transaction` FOREIGN KEY (`savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FK_savings_account_transaction_tax_details_tax_component` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_transaction_tax_details`
--

LOCK TABLES `m_savings_account_transaction_tax_details` WRITE;
/*!40000 ALTER TABLE `m_savings_account_transaction_tax_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_transaction_tax_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_interest_incentives`
--

DROP TABLE IF EXISTS `m_savings_interest_incentives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_interest_incentives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deposit_account_interest_rate_slab_id` bigint(20) NOT NULL,
  `entiry_type` smallint(2) NOT NULL,
  `attribute_name` smallint(2) NOT NULL,
  `condition_type` smallint(2) NOT NULL,
  `attribute_value` varchar(50) NOT NULL,
  `incentive_type` smallint(2) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_savings_interest_incentives_m_savings_interest_rate_slab` (`deposit_account_interest_rate_slab_id`),
  CONSTRAINT `FK_m_savings_interest_incentives_m_savings_interest_rate_slab` FOREIGN KEY (`deposit_account_interest_rate_slab_id`) REFERENCES `m_savings_account_interest_rate_slab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_interest_incentives`
--

LOCK TABLES `m_savings_interest_incentives` WRITE;
/*!40000 ALTER TABLE `m_savings_interest_incentives` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_interest_incentives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_officer_assignment_history`
--

DROP TABLE IF EXISTS `m_savings_officer_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `savings_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_m_savings_officer_assignment_history_0001` (`account_id`),
  KEY `fk_m_savings_officer_assignment_history_0002` (`savings_officer_id`),
  CONSTRAINT `fk_m_savings_officer_assignment_history_0001` FOREIGN KEY (`account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `fk_m_savings_officer_assignment_history_0002` FOREIGN KEY (`savings_officer_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_officer_assignment_history`
--

LOCK TABLES `m_savings_officer_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_savings_officer_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_officer_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_product`
--

DROP TABLE IF EXISTS `m_savings_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `short_name` varchar(4) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `deposit_type_enum` smallint(5) NOT NULL DEFAULT '100',
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `nominal_annual_interest_rate` decimal(19,6) NOT NULL,
  `interest_compounding_period_enum` smallint(5) NOT NULL,
  `interest_posting_period_enum` smallint(5) NOT NULL DEFAULT '4',
  `interest_calculation_type_enum` smallint(5) NOT NULL,
  `interest_calculation_days_in_year_type_enum` smallint(5) NOT NULL,
  `min_required_opening_balance` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `accounting_type` smallint(5) NOT NULL,
  `withdrawal_fee_amount` decimal(19,6) DEFAULT NULL,
  `withdrawal_fee_type_enum` smallint(5) DEFAULT NULL,
  `withdrawal_fee_for_transfer` tinyint(4) DEFAULT '1',
  `allow_overdraft` tinyint(1) NOT NULL DEFAULT '0',
  `overdraft_limit` decimal(19,6) DEFAULT NULL,
  `nominal_annual_interest_rate_overdraft` decimal(19,6) DEFAULT '0.000000',
  `min_overdraft_for_interest_calculation` decimal(19,6) DEFAULT '0.000000',
  `min_required_balance` decimal(19,6) DEFAULT NULL,
  `enforce_min_required_balance` tinyint(1) NOT NULL DEFAULT '0',
  `min_balance_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `withhold_tax` tinyint(4) NOT NULL DEFAULT '0',
  `tax_group_id` bigint(20) DEFAULT NULL,
  `is_dormancy_tracking_active` smallint(1) DEFAULT NULL,
  `days_to_inactive` int(11) DEFAULT NULL,
  `days_to_dormancy` int(11) DEFAULT NULL,
  `days_to_escheat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sp_unq_name` (`name`),
  UNIQUE KEY `sp_unq_short_name` (`short_name`),
  KEY `FK_savings_product_tax_group` (`tax_group_id`),
  CONSTRAINT `FK_savings_product_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_product`
--

LOCK TABLES `m_savings_product` WRITE;
/*!40000 ALTER TABLE `m_savings_product` DISABLE KEYS */;
INSERT INTO `m_savings_product` VALUES (1,'Member Deposit','MD','MD',100,'KES',4,0,0.000000,4,4,1,365,NULL,NULL,NULL,2,NULL,NULL,1,0,NULL,NULL,NULL,NULL,1,NULL,0,NULL,0,NULL,NULL,NULL),(2,'Registration Fees','RF','CRB',100,'KES',2,1,0.000000,1,4,1,365,NULL,NULL,NULL,2,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,NULL,0,NULL,0,NULL,NULL,NULL),(3,'Pending C2B Payments','PB2C','Product for pending B2C MPESA Payments',100,'KES',2,0,0.000000,1,4,1,365,NULL,NULL,NULL,2,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,NULL,0,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_savings_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_product_charge`
--

DROP TABLE IF EXISTS `m_savings_product_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_product_charge` (
  `savings_product_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`savings_product_id`,`charge_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `m_savings_product_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_savings_product_charge_ibfk_2` FOREIGN KEY (`savings_product_id`) REFERENCES `m_savings_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_product_charge`
--

LOCK TABLES `m_savings_product_charge` WRITE;
/*!40000 ALTER TABLE `m_savings_product_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_product_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_selfservice_beneficiaries_tpt`
--

DROP TABLE IF EXISTS `m_selfservice_beneficiaries_tpt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_selfservice_beneficiaries_tpt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_user_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `account_type` smallint(4) NOT NULL,
  `transfer_limit` bigint(20) DEFAULT '0',
  `is_active` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`app_user_id`,`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_selfservice_beneficiaries_tpt`
--

LOCK TABLES `m_selfservice_beneficiaries_tpt` WRITE;
/*!40000 ALTER TABLE `m_selfservice_beneficiaries_tpt` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_selfservice_beneficiaries_tpt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_selfservice_user_client_mapping`
--

DROP TABLE IF EXISTS `m_selfservice_user_client_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_selfservice_user_client_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appuser_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appuser_id_client_id` (`appuser_id`,`client_id`),
  KEY `m_selfservice_client_id` (`client_id`),
  CONSTRAINT `m_selfservice_appuser_id` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_selfservice_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_selfservice_user_client_mapping`
--

LOCK TABLES `m_selfservice_user_client_mapping` WRITE;
/*!40000 ALTER TABLE `m_selfservice_user_client_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_selfservice_user_client_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account`
--

DROP TABLE IF EXISTS `m_share_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(50) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` smallint(5) NOT NULL DEFAULT '300',
  `total_approved_shares` bigint(20) DEFAULT NULL,
  `total_pending_shares` bigint(20) DEFAULT NULL,
  `submitted_date` date NOT NULL,
  `submitted_userid` bigint(20) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `approved_userid` bigint(20) DEFAULT NULL,
  `rejected_date` date DEFAULT NULL,
  `rejected_userid` bigint(20) DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `activated_userid` bigint(20) DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `closed_userid` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `savings_account_id` bigint(20) NOT NULL,
  `minimum_active_period_frequency` decimal(19,6) DEFAULT NULL,
  `minimum_active_period_frequency_enum` smallint(5) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `allow_dividends_inactive_clients` smallint(1) DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_share_account_ibfk_1` (`product_id`),
  KEY `m_share_account_ibfk_2` (`savings_account_id`),
  KEY `m_share_account_ibfk_3` (`submitted_userid`),
  KEY `m_share_account_ibfk_4` (`approved_userid`),
  KEY `m_share_account_ibfk_5` (`rejected_userid`),
  KEY `m_share_account_ibfk_6` (`activated_userid`),
  KEY `m_share_account_ibfk_7` (`closed_userid`),
  KEY `m_share_account_ibfk_8` (`lastmodifiedby_id`),
  KEY `m_share_account_ibfk_9` (`client_id`),
  CONSTRAINT `m_share_account_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`),
  CONSTRAINT `m_share_account_ibfk_2` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `m_share_account_ibfk_3` FOREIGN KEY (`submitted_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_4` FOREIGN KEY (`approved_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_5` FOREIGN KEY (`rejected_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_6` FOREIGN KEY (`activated_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_7` FOREIGN KEY (`closed_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_8` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_9` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account`
--

LOCK TABLES `m_share_account` WRITE;
/*!40000 ALTER TABLE `m_share_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_charge`
--

DROP TABLE IF EXISTS `m_share_account_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `charge_payment_mode_enum` smallint(5) NOT NULL DEFAULT '0',
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `charge_amount_or_percentage` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `min_cap` decimal(19,6) DEFAULT NULL,
  `max_cap` decimal(19,6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_share_account_charge_ibfk_2` (`account_id`),
  CONSTRAINT `m_share_account_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_share_account_charge_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `m_share_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_charge`
--

LOCK TABLES `m_share_account_charge` WRITE;
/*!40000 ALTER TABLE `m_share_account_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_charge_paid_by`
--

DROP TABLE IF EXISTS `m_share_account_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `share_transaction_id` bigint(20) DEFAULT NULL,
  `charge_transaction_id` bigint(20) DEFAULT NULL,
  `amount` decimal(20,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `m_share_account_transactions_charge_mapping_ibfk1` (`share_transaction_id`),
  KEY `m_share_account_transactions_charge_mapping_ibfk2` (`charge_transaction_id`),
  CONSTRAINT `m_share_account_transactions_charge_mapping_ibfk1` FOREIGN KEY (`share_transaction_id`) REFERENCES `m_share_account_transactions` (`id`),
  CONSTRAINT `m_share_account_transactions_charge_mapping_ibfk2` FOREIGN KEY (`charge_transaction_id`) REFERENCES `m_share_account_charge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_charge_paid_by`
--

LOCK TABLES `m_share_account_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_share_account_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_dividend_details`
--

DROP TABLE IF EXISTS `m_share_account_dividend_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_dividend_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dividend_pay_out_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `status` smallint(3) NOT NULL,
  `savings_transaction_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_share_account_dividend_details_dividend_pay_out_id` (`dividend_pay_out_id`),
  KEY `FK_m_share_account_dividend_details_account_id` (`account_id`),
  CONSTRAINT `FK_m_share_account_dividend_details_account_id` FOREIGN KEY (`account_id`) REFERENCES `m_share_account` (`id`),
  CONSTRAINT `FK_m_share_account_dividend_details_dividend_pay_out_id` FOREIGN KEY (`dividend_pay_out_id`) REFERENCES `m_share_product_dividend_pay_out` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_dividend_details`
--

LOCK TABLES `m_share_account_dividend_details` WRITE;
/*!40000 ALTER TABLE `m_share_account_dividend_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_dividend_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_transactions`
--

DROP TABLE IF EXISTS `m_share_account_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `transaction_date` date DEFAULT NULL,
  `total_shares` bigint(20) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `amount` decimal(20,2) DEFAULT NULL,
  `charge_amount` decimal(20,2) DEFAULT NULL,
  `amount_paid` decimal(20,2) DEFAULT NULL,
  `status_enum` smallint(5) NOT NULL DEFAULT '300',
  `type_enum` smallint(5) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `m_share_account_purchased_shares_ibfk_1` (`account_id`),
  CONSTRAINT `m_share_account_purchased_shares_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `m_share_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_transactions`
--

LOCK TABLES `m_share_account_transactions` WRITE;
/*!40000 ALTER TABLE `m_share_account_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product`
--

DROP TABLE IF EXISTS `m_share_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `short_name` varchar(4) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `total_shares` bigint(20) NOT NULL,
  `issued_shares` bigint(20) DEFAULT NULL,
  `totalsubscribed_shares` bigint(20) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `capital_amount` decimal(20,2) NOT NULL,
  `minimum_client_shares` bigint(20) DEFAULT NULL,
  `nominal_client_shares` bigint(20) NOT NULL,
  `maximum_client_shares` bigint(20) DEFAULT NULL,
  `minimum_active_period_frequency` decimal(19,6) DEFAULT NULL,
  `minimum_active_period_frequency_enum` smallint(5) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `allow_dividends_inactive_clients` smallint(1) DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `accounting_type` smallint(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `m_share_product_ibfk_1` (`createdby_id`),
  KEY `m_share_product_ibfk_2` (`lastmodifiedby_id`),
  CONSTRAINT `m_share_product_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_product_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product`
--

LOCK TABLES `m_share_product` WRITE;
/*!40000 ALTER TABLE `m_share_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product_charge`
--

DROP TABLE IF EXISTS `m_share_product_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product_charge` (
  `product_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`product_id`,`charge_id`),
  KEY `m_share_product_charge_ibfk_1` (`charge_id`),
  CONSTRAINT `m_share_product_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_share_product_charge_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product_charge`
--

LOCK TABLES `m_share_product_charge` WRITE;
/*!40000 ALTER TABLE `m_share_product_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product_dividend_pay_out`
--

DROP TABLE IF EXISTS `m_share_product_dividend_pay_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product_dividend_pay_out` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `dividend_period_start_date` date NOT NULL,
  `dividend_period_end_date` date NOT NULL,
  `status` smallint(3) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_share_product_dividend_pay_out_product_id` (`product_id`),
  KEY `FK_m_share_product_dividend_pay_out_createdby_id` (`createdby_id`),
  KEY `FK_m_share_product_dividend_pay_out_lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `FK_m_share_product_dividend_pay_out_createdby_id` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_share_product_dividend_pay_out_lastmodifiedby_id` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_share_product_dividend_pay_out_product_id` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product_dividend_pay_out`
--

LOCK TABLES `m_share_product_dividend_pay_out` WRITE;
/*!40000 ALTER TABLE `m_share_product_dividend_pay_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product_dividend_pay_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product_market_price`
--

DROP TABLE IF EXISTS `m_share_product_market_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product_market_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `from_date` date DEFAULT NULL,
  `share_value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `m_share_product_market_price_ibfk_1` (`product_id`),
  CONSTRAINT `m_share_product_market_price_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product_market_price`
--

LOCK TABLES `m_share_product_market_price` WRITE;
/*!40000 ALTER TABLE `m_share_product_market_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product_market_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_staff`
--

DROP TABLE IF EXISTS `m_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_staff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_loan_officer` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `display_name` varchar(102) NOT NULL,
  `mobile_no` varchar(50) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `organisational_role_enum` smallint(6) DEFAULT NULL,
  `organisational_role_parent_staff_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `joining_date` date DEFAULT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  UNIQUE KEY `mobile_no_UNIQUE` (`mobile_no`),
  KEY `FK_m_staff_m_office` (`office_id`),
  KEY `FK_m_staff_m_image` (`image_id`),
  CONSTRAINT `FK_m_staff_m_image` FOREIGN KEY (`image_id`) REFERENCES `m_image` (`id`),
  CONSTRAINT `FK_m_staff_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_staff`
--

LOCK TABLES `m_staff` WRITE;
/*!40000 ALTER TABLE `m_staff` DISABLE KEYS */;
INSERT INTO `m_staff` VALUES (1,1,1,'JANE','MACHARIA','MACHARIA, JANE','254720662577','EXT2O7ZP8XK0WZN6TCG5INZHI75JAAA8A90JOUZTQ9XSE9P7BF31ACIGR837I0DCMD3KEZECZSWDMZU8A914MJ29PQRERF3RDF1D',NULL,NULL,1,'2011-09-20',NULL,NULL),(2,1,1,'LILIAN','MUIRURI','MUIRURI, LILIAN','254724379003',NULL,NULL,NULL,1,'2011-09-20',NULL,NULL),(3,1,1,'FELLY','OYUGA','OYUGA, FELLY','2547277738345',NULL,NULL,NULL,1,'2011-09-20',NULL,NULL),(4,1,1,'Junior','Gichuru','Gichuru, Junior','25490792840',NULL,NULL,NULL,1,'2019-01-09',NULL,NULL),(5,1,50,'sam','kimani','kimani, sam',NULL,NULL,NULL,NULL,1,'2019-01-20',NULL,NULL),(6,1,50,'Joshua','Musembi','Musembi, Joshua',NULL,NULL,NULL,NULL,1,'2019-02-05',NULL,NULL),(7,1,50,'Kevin','Akhaya Ainea','Akhaya Ainea, Kevin','0706519716',NULL,NULL,NULL,1,'2019-02-05',NULL,NULL),(8,1,50,'Brian','Kembui Luvandale','Kembui Luvandale, Brian','0743566507',NULL,NULL,NULL,1,'2019-02-05',NULL,NULL);
/*!40000 ALTER TABLE `m_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_staff_assignment_history`
--

DROP TABLE IF EXISTS `m_staff_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_staff_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `centre_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_staff_assignment_history_centre_id_m_group` (`centre_id`),
  KEY `FK_m_staff_assignment_history_m_staff` (`staff_id`),
  CONSTRAINT `FK_m_staff_assignment_history_centre_id_m_group` FOREIGN KEY (`centre_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_m_staff_assignment_history_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_staff_assignment_history`
--

LOCK TABLES `m_staff_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_staff_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_staff_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_components`
--

DROP TABLE IF EXISTS `m_survey_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_components` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `a_key` varchar(32) NOT NULL,
  `a_text` varchar(255) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `sequence_no` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `m_survey_components_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_components`
--

LOCK TABLES `m_survey_components` WRITE;
/*!40000 ALTER TABLE `m_survey_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_lookup_tables`
--

DROP TABLE IF EXISTS `m_survey_lookup_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_lookup_tables` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `a_key` varchar(255) NOT NULL,
  `description` int(4) DEFAULT NULL,
  `value_from` int(4) NOT NULL,
  `value_to` int(4) NOT NULL,
  `score` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `m_survey_lookup_tables_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_lookup_tables`
--

LOCK TABLES `m_survey_lookup_tables` WRITE;
/*!40000 ALTER TABLE `m_survey_lookup_tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_lookup_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_questions`
--

DROP TABLE IF EXISTS `m_survey_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `component_key` varchar(32) DEFAULT NULL,
  `a_key` varchar(32) NOT NULL,
  `a_text` varchar(255) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `sequence_no` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `m_survey_questions_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_questions`
--

LOCK TABLES `m_survey_questions` WRITE;
/*!40000 ALTER TABLE `m_survey_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_responses`
--

DROP TABLE IF EXISTS `m_survey_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_responses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) NOT NULL,
  `a_text` varchar(255) NOT NULL,
  `a_value` int(4) NOT NULL,
  `sequence_no` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `m_survey_responses_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `m_survey_questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_responses`
--

LOCK TABLES `m_survey_responses` WRITE;
/*!40000 ALTER TABLE `m_survey_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_scorecards`
--

DROP TABLE IF EXISTS `m_survey_scorecards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_scorecards` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `response_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `created_on` datetime DEFAULT NULL,
  `a_value` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  KEY `question_id` (`question_id`),
  KEY `response_id` (`response_id`),
  KEY `user_id` (`user_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `m_survey_scorecards_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `m_survey_questions` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_3` FOREIGN KEY (`response_id`) REFERENCES `m_survey_responses` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_5` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_scorecards`
--

LOCK TABLES `m_survey_scorecards` WRITE;
/*!40000 ALTER TABLE `m_survey_scorecards` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_scorecards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_surveys`
--

DROP TABLE IF EXISTS `m_surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_surveys` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a_key` varchar(32) NOT NULL,
  `a_name` varchar(255) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `country_code` varchar(2) NOT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_surveys`
--

LOCK TABLES `m_surveys` WRITE;
/*!40000 ALTER TABLE `m_surveys` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_component`
--

DROP TABLE IF EXISTS `m_tax_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_component` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `percentage` decimal(19,6) NOT NULL,
  `debit_account_type_enum` smallint(2) DEFAULT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `credit_account_type_enum` smallint(2) DEFAULT NULL,
  `credit_account_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_component_debit_gl_account` (`debit_account_id`),
  KEY `FK_tax_component_credit_gl_account` (`credit_account_id`),
  KEY `FK_tax_component_createdby` (`createdby_id`),
  KEY `FK_tax_component_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_component_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_component_credit_gl_account` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_tax_component_debit_gl_account` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_tax_component_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_component`
--

LOCK TABLES `m_tax_component` WRITE;
/*!40000 ALTER TABLE `m_tax_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_component_history`
--

DROP TABLE IF EXISTS `m_tax_component_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_component_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tax_component_id` bigint(20) NOT NULL,
  `percentage` decimal(19,6) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_component_history_tax_component_id` (`tax_component_id`),
  KEY `FK_tax_component_history_createdby` (`createdby_id`),
  KEY `FK_tax_component_history_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_component_history_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_component_history_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_component_history_tax_component_id` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_component_history`
--

LOCK TABLES `m_tax_component_history` WRITE;
/*!40000 ALTER TABLE `m_tax_component_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_component_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_group`
--

DROP TABLE IF EXISTS `m_tax_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_group_createdby` (`createdby_id`),
  KEY `FK_tax_group_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_group_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_group_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_group`
--

LOCK TABLES `m_tax_group` WRITE;
/*!40000 ALTER TABLE `m_tax_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_group_mappings`
--

DROP TABLE IF EXISTS `m_tax_group_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_group_mappings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tax_group_id` bigint(20) NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_group_mappings_tax_group` (`tax_group_id`),
  KEY `FK_tax_group_mappings_tax_component` (`tax_component_id`),
  KEY `FK_tax_group_mappings_createdby` (`createdby_id`),
  KEY `FK_tax_group_mappings_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_group_mappings_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_group_mappings_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_group_mappings_tax_component` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`),
  CONSTRAINT `FK_tax_group_mappings_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_group_mappings`
--

LOCK TABLES `m_tax_group_mappings` WRITE;
/*!40000 ALTER TABLE `m_tax_group_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tellers`
--

DROP TABLE IF EXISTS `m_tellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tellers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `credit_account_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  `state` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `m_tellers_name_unq` (`name`),
  KEY `IK_m_tellers_m_office` (`office_id`),
  KEY `FK_m_tellers_gl_account_debit_account_id` (`debit_account_id`),
  KEY `FK_m_tellers_gl_account_credit_account_id` (`credit_account_id`),
  CONSTRAINT `FK_m_tellers_gl_account_credit_account_id` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_m_tellers_gl_account_debit_account_id` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_m_tellers_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tellers`
--

LOCK TABLES `m_tellers` WRITE;
/*!40000 ALTER TABLE `m_tellers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_template`
--

DROP TABLE IF EXISTS `m_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_template`
--

LOCK TABLES `m_template` WRITE;
/*!40000 ALTER TABLE `m_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_template_m_templatemappers`
--

DROP TABLE IF EXISTS `m_template_m_templatemappers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_template_m_templatemappers` (
  `m_template_id` bigint(20) NOT NULL,
  `mappers_id` bigint(20) NOT NULL,
  UNIQUE KEY `mappers_id` (`mappers_id`),
  KEY `mappers_id_2` (`mappers_id`),
  KEY `m_template_id` (`m_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_template_m_templatemappers`
--

LOCK TABLES `m_template_m_templatemappers` WRITE;
/*!40000 ALTER TABLE `m_template_m_templatemappers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_template_m_templatemappers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_templatemappers`
--

DROP TABLE IF EXISTS `m_templatemappers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_templatemappers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mapperkey` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `mapperorder` int(11) DEFAULT NULL,
  `mappervalue` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_templatemappers`
--

LOCK TABLES `m_templatemappers` WRITE;
/*!40000 ALTER TABLE `m_templatemappers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_templatemappers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_trial_balance`
--

DROP TABLE IF EXISTS `m_trial_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_trial_balance` (
  `office_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `entry_date` date NOT NULL,
  `created_date` date DEFAULT NULL,
  `closing_balance` decimal(19,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_trial_balance`
--

LOCK TABLES `m_trial_balance` WRITE;
/*!40000 ALTER TABLE `m_trial_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_trial_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_working_days`
--

DROP TABLE IF EXISTS `m_working_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_working_days` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recurrence` varchar(100) DEFAULT NULL,
  `repayment_rescheduling_enum` smallint(5) DEFAULT NULL,
  `extend_term_daily_repayments` tinyint(1) DEFAULT '0',
  `extend_term_holiday_repayment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_working_days`
--

LOCK TABLES `m_working_days` WRITE;
/*!40000 ALTER TABLE `m_working_days` DISABLE KEYS */;
INSERT INTO `m_working_days` VALUES (1,'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,TU,WE,TH,FR,SA,SU',2,0,0);
/*!40000 ALTER TABLE `m_working_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mix_taxonomy`
--

DROP TABLE IF EXISTS `mix_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mix_taxonomy` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `namespace_id` int(11) DEFAULT NULL,
  `dimension` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `need_mapping` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mix_taxonomy`
--

LOCK TABLES `mix_taxonomy` WRITE;
/*!40000 ALTER TABLE `mix_taxonomy` DISABLE KEYS */;
INSERT INTO `mix_taxonomy` VALUES (1,'AdministrativeExpense',1,NULL,3,NULL,1),(2,'Assets',3,NULL,1,'All outstanding principals due for all outstanding client loans. This includes current, delinquent, and renegotiated loans, but not loans that have been written off. It does not include interest receivable.',1),(3,'Assets',3,'MaturityDimension:LessThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',1),(4,'Assets',3,'MaturityDimension:MoreThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',1),(5,'CashAndCashEquivalents',1,NULL,1,NULL,1),(6,'Deposits',3,NULL,1,'The total value of funds placed in an account with an MFI that are payable to a depositor. This item includes any current, checking, or savings accounts that are payable on demand. It also includes time deposits which have a fixed maturity date and compulsory deposits.',1),(7,'Deposits',3,'DepositProductsDimension:CompulsoryMember',1,'The value of deposits that an MFI\'s clients are required to  maintain as a condition of an existing or future loan.',NULL),(8,'Deposits',3,'DepositProductsDimension:VoluntaryMember',1,'The value of deposits that an MFI\'s clients are not required to  maintain as a condition of an existing or future loan.',NULL),(9,'Deposits',3,'LocationDimension:RuralMember',1,'Located in rural areas. Segmentation based on location.',NULL),(10,'Deposits',3,'LocationDimension:UrbanMember',1,'Located in urban areas. Segmentation based on location.',NULL),(11,'Deposits',3,'MaturityDimension:LessThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(12,'Deposits',3,'MaturityDimension:MoreThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(13,'EmployeeBenefitsExpense',1,NULL,3,NULL,NULL),(14,'Equity',1,NULL,1,NULL,NULL),(15,'Expense',1,NULL,3,NULL,NULL),(16,'FinancialExpense',3,NULL,3,'All costs All costs incurred in raising funds from third parties, fee expenses from non-financial services, net gains (losses) due to changes in fair value of financial liabilities, impairment losses net of reversals of financial assets other than loan portfolio and net gains (losses) from restatement of financial statements in terms of the measuring unit current at the end of the reporting period.',NULL),(17,'FinancialRevenueOnLoans',3,NULL,2,'Interest and non-interest income generated by the provision of credit services to the clients. Fees and commissions for late payment are also included.',NULL),(18,'ImpairmentLossAllowanceGrossLoanPortfolio',3,NULL,2,'An allowance for the risk of losses in the gross loan portfolio due to default .',NULL),(19,'Liabilities',1,NULL,1,NULL,NULL),(20,'Liabilities',3,'MaturityDimension:LessThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(21,'Liabilities',3,'MaturityDimension:MoreThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(22,'LoanPortfolioGross',3,NULL,2,'All outstanding principals due for all outstanding client loans. This includes current, delinquent, and renegotiated loans, but not loans that have been written off. It does not include interest receivable.',NULL),(23,'LoanPortfolioGross',3,'CreditProductsDimension:MicroenterpriseMember',2,'Loans that finance the production or trade of goods and  services for an individual\'s microenterprise, whether or not the microenterprise is legally registered. Segmentation based on loan product.',NULL),(24,'LoanPortfolioGross',3,'DelinquencyDimension:OneMonthOrMoreMember',2,'Segmentation based on the principal balance of all loans outstanding that have one or more installments of principal  past due or renegotiated. Segmentation based on the  principal balance of all loans outstanding that have one or  more installments of principal past due or renegotiated.',NULL),(25,'LoanPortfolioGross',3,'DelinquencyDimension:ThreeMonthsOrMoreMember',2,'Segmentation based on the principal balance of all loans outstanding that have one or more installments of principal  past due or renegotiated.? Segmentation based on the  principal balance of all loans outstanding that have one or  more installments of principal past due or renegotiated.',NULL),(26,'LoanPortfolioGross',3,'LocationDimension:RuralMember',2,'Located in rural areas. Segmentation based on geographic location.',NULL),(27,'LoanPortfolioGross',3,'LocationDimension:UrbanMember',2,'Located in urbal areas. Segmentation based on geographic location.',NULL),(28,'LoanPortfolioGross',3,'MaturityDimension:LessThanOneYearMember',2,'Segmentation based on the life of an asset or liability.',NULL),(29,'LoanPortfolioGross',3,'MaturityDimension:MoreThanOneYearMember',2,'Segmentation based on the life of an asset or liability.',NULL),(30,'NetLoanLoss',3,'',3,'Referred to the value of delinquency loans written off net of any principal recovery.',NULL),(31,'NetLoanLossProvisionExpense',3,NULL,3,'Represent the net value of loan portfolio impairment loss considering any reversal on impairment loss and any recovery on loans written off recognized as a income during the accounting period.',NULL),(32,'NetOperatingIncome',3,NULL,2,'Total operating revenue less all expenses related to the MFI\'s core financial service operation including total financial expense, impairment loss and operating expense. Donations are excluded.',NULL),(33,'NetOperatingIncomeNetOfTaxExpense',3,NULL,3,'Net operating income reported incorporating the effect of taxes. Taxes include all domestic and foreign taxes which are based on taxable profits, other taxes related to personnel, financial transactions or value-added taxes are not considered in calculation of this value.',NULL),(34,'NumberOfActiveBorrowers',3,NULL,0,'The number of individuals who currently have an outstanding loan balance with the MFI or are primarily responsible for repaying any portion of the gross loan portfolio. Individuals who have multiple loans with an MFI should be counted as a single borrower.',NULL),(35,'NumberOfActiveBorrowers',3,'GenderDimension:FemaleMember',0,'The number of individuals who currently have an outstanding loan balance with the MFI or are primarily responsible for repaying any portion of the gross loan portfolio. Individuals who have multiple loans with an MFI should be counted as a single borrower.',NULL),(36,'NumberOfBoardMembers',3,'GenderDimension:FemaleMember',0,'The number of members that comprise the board of directors at the end of the reporting period who are female.',NULL),(37,'NumberOfDepositAccounts',3,NULL,0,'The number of individuals who currently have funds on deposit with the MFI on a voluntary basis; i.e., they are not required to maintain the deposit account to access a loan. This number applies only to deposits held by an MFI, not to those deposits held in other institutions by the MFI\'s clients. The number should be based on the number of individuals rather than the number of groups. A single deposit account may represent multiple depositors.',NULL),(38,'NumberOfDepositors',3,'',0,'The number of deposit accounts, both voluntary and compulsory, opened at the MFI whose balances the institution is liable to repay. The number should be based on the number of individual accounts rather than on the number of groups.',NULL),(39,'NumberOfEmployees',3,NULL,0,'The number of individuals who are actively employed by an entity. This number includes contract employees or advisors who dedicate a substantial portion of their time to the entity, even if they are not on the entity\'s employees roster.',NULL),(40,'NumberOfEmployees',3,'GenderDimension:FemaleMember',0,'The number of individuals who are actively employed by an entity. This number includes contract employees or advisors who dedicate a substantial portion of their time to the entity, even if they are not on the entity\'s employees roster.',NULL),(41,'NumberOfLoanOfficers',3,NULL,0,'The number of employees whose main activity is to manage a portion of the gross loan portfolio. A loan officer is a staff member of record who is directly responsible for arranging and monitoring client loans.',NULL),(42,'NumberOfLoanOfficers',3,'GenderDimension:FemaleMember',0,'The number of employees whose main activity is to manage a portion of the gross loan portfolio. A loan officer is a staff member of record who is directly responsible for arranging and monitoring client loans.',NULL),(43,'NumberOfManagers',3,'GenderDimension:FemaleMember',0,'The number of members that comprise the management of the institution who are female.',NULL),(44,'NumberOfOffices',3,NULL,0,'The number of staffed points of service and administrative sites used to deliver or support the delivery of financial services to microfinance clients.',NULL),(45,'NumberOfOutstandingLoans',3,NULL,0,'The number of loans in the gross loan portfolio. For MFIs using a group lending methodology, the number of loans should refer to the number of individuals receiving loans as part of a group or as part of a group loan.',NULL),(46,'OperatingExpense',3,NULL,3,'Includes expenses not related to financial and credit loss impairment, such as personnel expenses, depreciation, amortization and administrative expenses.',NULL),(47,'OperatingIncome',3,NULL,2,'Includes all financial income and other operating revenue which is generated from non-financial services. Operating income also includes net gains (losses) from holding financial assets (changes on their values during the period and foreign exchange differences). Donations or any revenue not related with an MFI\'s core business of making loans and providing financial services are not considered under this category.',NULL),(48,'WriteOffsOnGrossLoanPortfolio',3,NULL,2,'The value of loans that have been recognized as uncollectible for accounting purposes. A write-off is an accounting procedure that removes the outstanding balance of the loan from the gross loan portfolio and impairment loss allowance. Thus, the write-off does not affect the net loan portfolio, total assets, or any equity account. If the impairment loss allowance is insufficient to cover the amount written off, the excess amount will result in an additional impairment loss on loans recognised in profit or loss of the period.',NULL);
/*!40000 ALTER TABLE `mix_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mix_taxonomy_mapping`
--

DROP TABLE IF EXISTS `mix_taxonomy_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mix_taxonomy_mapping` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `config` varchar(200) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  `currency` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mix_taxonomy_mapping`
--

LOCK TABLES `mix_taxonomy_mapping` WRITE;
/*!40000 ALTER TABLE `mix_taxonomy_mapping` DISABLE KEYS */;
INSERT INTO `mix_taxonomy_mapping` VALUES (1,'default',NULL,NULL,'');
/*!40000 ALTER TABLE `mix_taxonomy_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mix_xbrl_namespace`
--

DROP TABLE IF EXISTS `mix_xbrl_namespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mix_xbrl_namespace` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `prefix` varchar(20) NOT NULL DEFAULT '',
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQUE` (`prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mix_xbrl_namespace`
--

LOCK TABLES `mix_xbrl_namespace` WRITE;
/*!40000 ALTER TABLE `mix_xbrl_namespace` DISABLE KEYS */;
INSERT INTO `mix_xbrl_namespace` VALUES (1,'ifrs','http://xbrl.iasb.org/taxonomy/2009-04-01/ifrs'),(2,'iso4217','http://www.xbrl.org/2003/iso4217'),(3,'mix','http://www.themix.org/int/fr/ifrs/basi/YYYY-MM-DD/mx-cor'),(4,'xbrldi','http://xbrl.org/2006/xbrldi'),(5,'xbrli','http://www.xbrl.org/2003/instance'),(6,'link','http://www.xbrl.org/2003/linkbase'),(7,'dc-all','http://www.themix.org/int/fr/ifrs/basi/2010-08-31/dc-all');
/*!40000 ALTER TABLE `mix_xbrl_namespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `more client details`
--

DROP TABLE IF EXISTS `more client details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `more client details` (
  `client_id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_more_client_details_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `more client details`
--

LOCK TABLES `more client details` WRITE;
/*!40000 ALTER TABLE `more client details` DISABLE KEYS */;
INSERT INTO `more client details` VALUES (2,'cliffordmasi07@gmail.com');
/*!40000 ALTER TABLE `more client details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motorbike_details`
--

DROP TABLE IF EXISTS `motorbike_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motorbike_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `Engine` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_client_id` (`client_id`),
  CONSTRAINT `fk_motorbike_details_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motorbike_details`
--

LOCK TABLES `motorbike_details` WRITE;
/*!40000 ALTER TABLE `motorbike_details` DISABLE KEYS */;
INSERT INTO `motorbike_details` VALUES (1,2,NULL,NULL);
/*!40000 ALTER TABLE `motorbike_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_generator`
--

DROP TABLE IF EXISTS `notification_generator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_generator` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_type` text,
  `object_identifier` bigint(20) DEFAULT NULL,
  `action` text,
  `actor` bigint(20) DEFAULT NULL,
  `is_system_generated` tinyint(1) DEFAULT '0',
  `notification_content` text,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_generator`
--

LOCK TABLES `notification_generator` WRITE;
/*!40000 ALTER TABLE `notification_generator` DISABLE KEYS */;
INSERT INTO `notification_generator` VALUES (1,'client',1,'created',1,0,'New client created','2019-04-04 14:29:57'),(2,'loanProduct',1,'created',1,0,'New loan product created','2019-04-04 14:33:05'),(3,'loanProduct',1,'created',1,0,'New loan product created','2019-04-04 14:33:06'),(4,'loan',1,'created',1,0,'New loan created','2019-04-04 14:33:38'),(5,'client',2,'created',1,0,'New client created','2019-04-04 14:43:18'),(6,'loan',2,'created',1,0,'New loan created','2019-04-04 14:47:14'),(7,'loan',3,'created',1,0,'New loan created','2019-04-04 14:47:15'),(8,'loan',3,'approved',1,0,'New loan approved','2019-04-04 14:47:31');
/*!40000 ALTER TABLE `notification_generator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_mapper`
--

DROP TABLE IF EXISTS `notification_mapper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_mapper` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_mapper` (`user_id`),
  KEY `notification_id` (`notification_id`),
  CONSTRAINT `notification_mapper_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `notification_mapper_ibfk_3` FOREIGN KEY (`notification_id`) REFERENCES `notification_generator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_mapper`
--

LOCK TABLES `notification_mapper` WRITE;
/*!40000 ALTER TABLE `notification_mapper` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_mapper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_token`
--

DROP TABLE IF EXISTS `oauth_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(256) DEFAULT NULL,
  `user_name` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  `authentication` blob,
  `refresh_token` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_token`
--

LOCK TABLES `oauth_access_token` WRITE;
/*!40000 ALTER TABLE `oauth_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client_details`
--

DROP TABLE IF EXISTS `oauth_client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(128) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` bit(1) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client_details`
--

LOCK TABLES `oauth_client_details` WRITE;
/*!40000 ALTER TABLE `oauth_client_details` DISABLE KEYS */;
INSERT INTO `oauth_client_details` VALUES ('community-app',NULL,'123','all','password,refresh_token',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `oauth_client_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_token`
--

DROP TABLE IF EXISTS `oauth_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_token`
--

LOCK TABLES `oauth_refresh_token` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_likelihoods`
--

DROP TABLE IF EXISTS `ppi_likelihoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppi_likelihoods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppi_likelihoods`
--

LOCK TABLES `ppi_likelihoods` WRITE;
/*!40000 ALTER TABLE `ppi_likelihoods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_likelihoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_likelihoods_ppi`
--

DROP TABLE IF EXISTS `ppi_likelihoods_ppi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppi_likelihoods_ppi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `likelihood_id` bigint(20) NOT NULL,
  `ppi_name` varchar(250) NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppi_likelihoods_ppi`
--

LOCK TABLES `ppi_likelihoods_ppi` WRITE;
/*!40000 ALTER TABLE `ppi_likelihoods_ppi` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_likelihoods_ppi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_scores`
--

DROP TABLE IF EXISTS `ppi_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppi_scores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `score_from` int(11) NOT NULL,
  `score_to` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppi_scores`
--

LOCK TABLES `ppi_scores` WRITE;
/*!40000 ALTER TABLE `ppi_scores` DISABLE KEYS */;
INSERT INTO `ppi_scores` VALUES (1,0,4),(2,5,9),(3,10,14),(4,15,19),(5,20,24),(6,25,29),(7,30,34),(8,35,39),(9,40,44),(10,45,49),(11,50,54),(12,55,59),(13,60,64),(14,65,69),(15,70,74),(16,75,79),(17,80,84),(18,85,89),(19,90,94),(20,95,100);
/*!40000 ALTER TABLE `ppi_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `r_enum_value`
--

DROP TABLE IF EXISTS `r_enum_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `r_enum_value` (
  `enum_name` varchar(100) NOT NULL,
  `enum_id` int(11) NOT NULL,
  `enum_message_property` varchar(100) NOT NULL,
  `enum_value` varchar(100) NOT NULL,
  `enum_type` tinyint(1) NOT NULL,
  PRIMARY KEY (`enum_name`,`enum_id`),
  UNIQUE KEY `enum_message_property` (`enum_name`,`enum_message_property`),
  UNIQUE KEY `enum_value` (`enum_name`,`enum_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `r_enum_value`
--

LOCK TABLES `r_enum_value` WRITE;
/*!40000 ALTER TABLE `r_enum_value` DISABLE KEYS */;
INSERT INTO `r_enum_value` VALUES ('account_type_type_enum',0,'INVALID','INVALID',0),('account_type_type_enum',1,'INDIVIDUAL','INDIVIDUAL',0),('account_type_type_enum',2,'GROUP','GROUP',0),('account_type_type_enum',3,'JLG','JLG',0),('accrual_accounts_for_loan_type_enum',1,'FUND_SOURCE','FUND_SOURCE',0),('accrual_accounts_for_loan_type_enum',2,'LOAN_PORTFOLIO','LOAN_PORTFOLIO',0),('accrual_accounts_for_loan_type_enum',3,'INTEREST_ON_LOANS','INTEREST_ON_LOANS',0),('accrual_accounts_for_loan_type_enum',4,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('accrual_accounts_for_loan_type_enum',5,'INCOME_FROM_PENALTIES','INCOME_FROM_PENALTIES',0),('accrual_accounts_for_loan_type_enum',6,'LOSSES_WRITTEN_OFF','LOSSES_WRITTEN_OFF',0),('accrual_accounts_for_loan_type_enum',7,'INTEREST_RECEIVABLE','INTEREST_RECEIVABLE',0),('accrual_accounts_for_loan_type_enum',8,'FEES_RECEIVABLE','FEES_RECEIVABLE',0),('accrual_accounts_for_loan_type_enum',9,'PENALTIES_RECEIVABLE','PENALTIES_RECEIVABLE',0),('accrual_accounts_for_loan_type_enum',10,'TRANSFERS_SUSPENSE','TRANSFERS_SUSPENSE',0),('accrual_accounts_for_loan_type_enum',11,'OVERPAYMENT','OVERPAYMENT',0),('accrual_accounts_for_loan_type_enum',12,'INCOME_FROM_RECOVERY','INCOME_FROM_RECOVERY',0),('amortization_method_enum',0,'Equal principle payments','Equal principle payments',0),('amortization_method_enum',1,'Equal installments','Equal installments',0),('calendar_type_enum',0,'INVALID','INVALID',0),('calendar_type_enum',1,'CLIENTS','CLIENTS',0),('calendar_type_enum',2,'GROUPS','GROUPS',0),('calendar_type_enum',3,'LOANS','LOANS',0),('calendar_type_enum',4,'CENTERS','CENTERS',0),('calendar_type_enum',5,'SAVINGS','SAVINGS',0),('calendar_type_enum',6,'LOAN_RECALCULATION_REST_DETAIL','LOAN_RECALCULATION_REST_DETAIL',0),('calendar_type_enum',7,'LOAN_RECALCULATION_COMPOUNDING_DETAIL','LOAN_RECALCULATION_COMPOUNDING_DETAIL',0),('cash_accounts_for_loan_type_enum',1,'FUND_SOURCE','FUND_SOURCE',0),('cash_accounts_for_loan_type_enum',2,'LOAN_PORTFOLIO','LOAN_PORTFOLIO',0),('cash_accounts_for_loan_type_enum',3,'INTEREST_ON_LOANS','INTEREST_ON_LOANS',0),('cash_accounts_for_loan_type_enum',4,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('cash_accounts_for_loan_type_enum',5,'INCOME_FROM_PENALTIES','INCOME_FROM_PENALTIES',0),('cash_accounts_for_loan_type_enum',6,'LOSSES_WRITTEN_OFF','LOSSES_WRITTEN_OFF',0),('cash_accounts_for_loan_type_enum',10,'TRANSFERS_SUSPENSE','TRANSFERS_SUSPENSE',0),('cash_accounts_for_loan_type_enum',11,'OVERPAYMENT','OVERPAYMENT',0),('cash_accounts_for_loan_type_enum',12,'INCOME_FROM_RECOVERY','INCOME_FROM_RECOVERY',0),('cash_accounts_for_savings_type_enum',1,'SAVINGS_REFERENCE','SAVINGS_REFERENCE',0),('cash_accounts_for_savings_type_enum',2,'SAVINGS_CONTROL','SAVINGS_CONTROL',0),('cash_accounts_for_savings_type_enum',3,'INTEREST_ON_SAVINGS','INTEREST_ON_SAVINGS',0),('cash_accounts_for_savings_type_enum',4,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('cash_accounts_for_savings_type_enum',5,'INCOME_FROM_PENALTIES','INCOME_FROM_PENALTIES',0),('cash_accounts_for_savings_type_enum',10,'TRANSFERS_SUSPENSE','TRANSFERS_SUSPENSE',0),('cash_accounts_for_savings_type_enum',11,'OVERDRAFT_PORTFOLIO_CONTROL','OVERDRAFT_PORTFOLIO_CONTROL',0),('cash_accounts_for_savings_type_enum',12,'INCOME_FROM_INTEREST','INCOME_FROM_INTEREST',0),('cash_account_for_shares_type_enum',1,'SHARES_REFERENCE','SHARES_REFERENCE',0),('cash_account_for_shares_type_enum',2,'SHARES_SUSPENSE','SHARES_SUSPENSE',0),('cash_account_for_shares_type_enum',3,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('cash_account_for_shares_type_enum',4,'SHARES_EQUITY','SHARES_EQUITY',0),('client_transaction_type_enum',1,'PAY_CHARGE','PAY_CHARGE',0),('client_transaction_type_enum',2,'WAIVE_CHARGE','WAIVE_CHARGE',0),('entity_account_type_enum',1,'CLIENT','CLIENT',0),('entity_account_type_enum',2,'LOAN','LOAN',0),('entity_account_type_enum',3,'SAVINGS','SAVINGS',0),('entity_account_type_enum',4,'CENTER','CENTER',0),('entity_account_type_enum',5,'GROUP','GROUP',0),('entity_account_type_enum',6,'SHARES','SHARES',0),('financial_activity_type_enum',100,'ASSET_TRANSFER','ASSET_TRANSFER',0),('financial_activity_type_enum',101,'CASH_AT_MAINVAULT','CASH_AT_MAINVAULT',0),('financial_activity_type_enum',102,'CASH_AT_TELLER','CASH_AT_TELLER',0),('financial_activity_type_enum',103,'ASSET_FUND_SOURCE','ASSET_FUND_SOURCE',0),('financial_activity_type_enum',200,'LIABILITY_TRANSFER','LIABILITY_TRANSFER',0),('financial_activity_type_enum',201,'PAYABLE_DIVIDENDS','PAYABLE_DIVIDENDS',0),('financial_activity_type_enum',300,'OPENING_BALANCES_TRANSFER_CONTRA','OPENING_BALANCES_TRANSFER_CONTRA',0),('glaccount_type_enum',1,'ASSET','ASSET',0),('glaccount_type_enum',2,'LIABILITY','LIABILITY',0),('glaccount_type_enum',3,'EQUITY','EQUITY',0),('glaccount_type_enum',4,'INCOME','INCOME',0),('glaccount_type_enum',5,'EXPENSE','EXPENSE',0),('interest_calculated_in_period_enum',0,'Daily','Daily',0),('interest_calculated_in_period_enum',1,'Same as repayment period','Same as repayment period',0),('interest_method_enum',0,'Declining Balance','Declining Balance',0),('interest_method_enum',1,'Flat','Flat',0),('interest_period_frequency_enum',2,'Per month','Per month',0),('interest_period_frequency_enum',3,'Per year','Per year',0),('journal_entry_type_type_enum',1,'CREDIT','CREDIT',0),('journal_entry_type_type_enum',2,'DEBIT','DEBIT',0),('loan_status_id',0,'Invalid','Invalid',0),('loan_status_id',100,'Submitted and awaiting approval','Submitted and awaiting approval',0),('loan_status_id',200,'Approved','Approved',0),('loan_status_id',300,'Active','Active',0),('loan_status_id',400,'Withdrawn by client','Withdrawn by client',0),('loan_status_id',500,'Rejected','Rejected',0),('loan_status_id',600,'Closed','Closed',0),('loan_status_id',601,'Written-Off','Written-Off',0),('loan_status_id',602,'Rescheduled','Rescheduled',0),('loan_status_id',700,'Overpaid','Overpaid',0),('loan_transaction_strategy_id',1,'mifos-standard-strategy','Mifos style',0),('loan_transaction_strategy_id',2,'heavensfamily-strategy','Heavensfamily',0),('loan_transaction_strategy_id',3,'creocore-strategy','Creocore',0),('loan_transaction_strategy_id',4,'rbi-india-strategy','RBI (India)',0),('loan_transaction_type_enum',0,'INVALID','INVALID',0),('loan_transaction_type_enum',1,'DISBURSEMENT','DISBURSEMENT',0),('loan_transaction_type_enum',2,'REPAYMENT','REPAYMENT',0),('loan_transaction_type_enum',3,'CONTRA','CONTRA',0),('loan_transaction_type_enum',4,'WAIVE_INTEREST','WAIVE_INTEREST',0),('loan_transaction_type_enum',5,'REPAYMENT_AT_DISBURSEMENT','REPAYMENT_AT_DISBURSEMENT',0),('loan_transaction_type_enum',6,'WRITEOFF','WRITEOFF',0),('loan_transaction_type_enum',7,'MARKED_FOR_RESCHEDULING','MARKED_FOR_RESCHEDULING',0),('loan_transaction_type_enum',8,'RECOVERY_REPAYMENT','RECOVERY_REPAYMENT',0),('loan_transaction_type_enum',9,'WAIVE_CHARGES','WAIVE_CHARGES',0),('loan_transaction_type_enum',10,'ACCRUAL','ACCRUAL',0),('loan_transaction_type_enum',12,'INITIATE_TRANSFER','INITIATE_TRANSFER',0),('loan_transaction_type_enum',13,'APPROVE_TRANSFER','APPROVE_TRANSFER',0),('loan_transaction_type_enum',14,'WITHDRAW_TRANSFER','WITHDRAW_TRANSFER',0),('loan_transaction_type_enum',15,'REJECT_TRANSFER','REJECT_TRANSFER',0),('loan_transaction_type_enum',16,'REFUND','REFUND',0),('loan_transaction_type_enum',17,'CHARGE_PAYMENT','CHARGE_PAYMENT',0),('loan_transaction_type_enum',18,'REFUND_FOR_ACTIVE_LOAN','REFUND_FOR_ACTIVE_LOAN',0),('loan_transaction_type_enum',19,'INCOME_POSTING','INCOME_POSTING',0),('loan_type_enum',1,'Individual Loan','Individual Loan',0),('loan_type_enum',2,'Group Loan','Group Loan',0),('portfolio_account_type_enum',1,'LOAN','LOAN',0),('portfolio_account_type_enum',2,'SAVING','EXPENSE',0),('portfolio_account_type_enum',3,'PROVISIONING','PROVISIONING',0),('portfolio_account_type_enum',4,'SHARES','SHARES',0),('processing_result_enum',0,'invalid','Invalid',0),('processing_result_enum',1,'processed','Processed',0),('processing_result_enum',2,'awaiting.approval','Awaiting Approval',0),('processing_result_enum',3,'rejected','Rejected',0),('repayment_period_frequency_enum',0,'Days','Days',0),('repayment_period_frequency_enum',1,'Weeks','Weeks',0),('repayment_period_frequency_enum',2,'Months','Months',0),('savings_transaction_type_enum',0,'INVALID','INVALID',0),('savings_transaction_type_enum',1,'deposit','deposit',0),('savings_transaction_type_enum',2,'withdrawal','withdrawal',1),('savings_transaction_type_enum',3,'Interest Posting','Interest Posting',0),('savings_transaction_type_enum',4,'Withdrawal Fee','Withdrawal Fee',1),('savings_transaction_type_enum',5,'Annual Fee','Annual Fee',1),('savings_transaction_type_enum',6,'Waive Charge','Waive Charge',0),('savings_transaction_type_enum',7,'Pay Charge','Pay Charge',1),('savings_transaction_type_enum',8,'DIVIDEND_PAYOUT','DIVIDEND_PAYOUT',0),('savings_transaction_type_enum',12,'Initiate Transfer','Initiate Transfer',0),('savings_transaction_type_enum',13,'Approve Transfer','Approve Transfer',0),('savings_transaction_type_enum',14,'Withdraw Transfer','Withdraw Transfer',0),('savings_transaction_type_enum',15,'Reject Transfer','Reject Transfer',0),('savings_transaction_type_enum',16,'Written-Off','Written-Off',0),('savings_transaction_type_enum',17,'Overdraft Interest','Overdraft Interest',0),('savings_transaction_type_enum',19,'WITHHOLD_TAX','WITHHOLD_TAX',0),('status_enum',0,'Invalid','Invalid',0),('status_enum',100,'Pending','Pending',0),('status_enum',300,'Active','Active',0),('status_enum',600,'Closed','Closed',0),('teller_status',300,'Active','Active',0),('teller_status',400,'Inactive','Inactive',0),('teller_status',600,'Closed','Closed',0),('term_period_frequency_enum',0,'Days','Days',0),('term_period_frequency_enum',1,'Weeks','Weeks',0),('term_period_frequency_enum',2,'Months','Months',0),('term_period_frequency_enum',3,'Years','Years',0),('transaction_type_enum',1,'Disbursement','Disbursement',0),('transaction_type_enum',2,'Repayment','Repayment',0),('transaction_type_enum',3,'Contra','Contra',0),('transaction_type_enum',4,'Waive Interest','Waive Interest',0),('transaction_type_enum',5,'Repayment At Disbursement','Repayment At Disbursement',0),('transaction_type_enum',6,'Write-Off','Write-Off',0),('transaction_type_enum',7,'Marked for Rescheduling','Marked for Rescheduling',0),('transaction_type_enum',8,'Recovery Repayment','Recovery Repayment',0),('transaction_type_enum',9,'Waive Charges','Waive Charges',0),('transaction_type_enum',10,'Apply Charges','Apply Charges',0),('transaction_type_enum',11,'Apply Interest','Apply Interest',0);
/*!40000 ALTER TABLE `r_enum_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_loan_transaction_processing_strategy`
--

DROP TABLE IF EXISTS `ref_loan_transaction_processing_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_loan_transaction_processing_strategy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ltp_strategy_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_loan_transaction_processing_strategy`
--

LOCK TABLES `ref_loan_transaction_processing_strategy` WRITE;
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` DISABLE KEYS */;
INSERT INTO `ref_loan_transaction_processing_strategy` VALUES (1,'mifos-standard-strategy','Penalties, Fees, Interest, Principal order',1),(2,'heavensfamily-strategy','HeavensFamily Unique',6),(3,'creocore-strategy','Creocore Unique',7),(4,'rbi-india-strategy','Overdue/Due Fee/Int,Principal',2),(5,'principal-interest-penalties-fees-order-strategy','Principal, Interest, Penalties, Fees Order',3),(6,'interest-principal-penalties-fees-order-strategy','Interest, Principal, Penalties, Fees Order',4),(7,'early-repayment-strategy','Early Repayment Strategy',5);
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_audit_table`
--

DROP TABLE IF EXISTS `request_audit_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_audit_table` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lastname` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `mobile_number` varchar(50) DEFAULT NULL,
  `firstname` varchar(100) NOT NULL,
  `authentication_token` varchar(100) DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(100) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `created_date` date NOT NULL,
  `account_number` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_request_audit_table_m_client` (`client_id`),
  CONSTRAINT `FK1_request_audit_table_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_audit_table`
--

LOCK TABLES `request_audit_table` WRITE;
/*!40000 ALTER TABLE `request_audit_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_audit_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_sequence`
--

DROP TABLE IF EXISTS `rpt_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rpt_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_sequence`
--

LOCK TABLES `rpt_sequence` WRITE;
/*!40000 ALTER TABLE `rpt_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_email_campaign`
--

DROP TABLE IF EXISTS `scheduled_email_campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_email_campaign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_name` varchar(100) NOT NULL,
  `campaign_type` int(11) NOT NULL,
  `businessRule_id` int(11) NOT NULL,
  `param_value` text,
  `status_enum` int(11) NOT NULL,
  `email_subject` varchar(100) NOT NULL,
  `email_message` text NOT NULL,
  `email_attachment_file_format` varchar(10) NOT NULL,
  `stretchy_report_id` int(11) NOT NULL,
  `stretchy_report_param_map` text,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `next_trigger_date` datetime DEFAULT NULL,
  `last_trigger_date` datetime DEFAULT NULL,
  `recurrence_start_date` datetime DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT '1',
  `previous_run_error_log` text,
  `previous_run_error_message` text,
  `previous_run_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduled_email_campaign_ibfk_1` (`stretchy_report_id`),
  CONSTRAINT `scheduled_email_campaign_ibfk_1` FOREIGN KEY (`stretchy_report_id`) REFERENCES `stretchy_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_email_campaign`
--

LOCK TABLES `scheduled_email_campaign` WRITE;
/*!40000 ALTER TABLE `scheduled_email_campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_email_campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_email_configuration`
--

DROP TABLE IF EXISTS `scheduled_email_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_email_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_email_configuration`
--

LOCK TABLES `scheduled_email_configuration` WRITE;
/*!40000 ALTER TABLE `scheduled_email_configuration` DISABLE KEYS */;
INSERT INTO `scheduled_email_configuration` VALUES (1,'SMTP_SERVER',NULL),(2,'SMTP_PORT',NULL),(3,'SMTP_USERNAME',NULL),(4,'SMTP_PASSWORD',NULL);
/*!40000 ALTER TABLE `scheduled_email_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_email_messages_outbound`
--

DROP TABLE IF EXISTS `scheduled_email_messages_outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_email_messages_outbound` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `email_campaign_id` bigint(20) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '100',
  `email_address` varchar(50) NOT NULL,
  `email_subject` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `campaign_name` varchar(200) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `error_message` text,
  PRIMARY KEY (`id`),
  KEY `SEFKGROUP000000001` (`group_id`),
  KEY `SEFKCLIENT00000001` (`client_id`),
  KEY `SEFKSTAFF000000001` (`staff_id`),
  KEY `fk_schedule_email_campign1` (`email_campaign_id`),
  CONSTRAINT `fk_schedule_email_campign1` FOREIGN KEY (`email_campaign_id`) REFERENCES `scheduled_email_campaign` (`id`),
  CONSTRAINT `SEFKCLIENT00000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `SEFKGROUP000000001` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `SEFKSTAFF000000001` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_email_messages_outbound`
--

LOCK TABLES `scheduled_email_messages_outbound` WRITE;
/*!40000 ALTER TABLE `scheduled_email_messages_outbound` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_email_messages_outbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_detail`
--

DROP TABLE IF EXISTS `scheduler_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_detail` (
  `id` smallint(2) NOT NULL AUTO_INCREMENT,
  `is_suspended` tinyint(1) NOT NULL DEFAULT '0',
  `execute_misfired_jobs` tinyint(1) NOT NULL DEFAULT '1',
  `reset_scheduler_on_bootup` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_detail`
--

LOCK TABLES `scheduler_detail` WRITE;
/*!40000 ALTER TABLE `scheduler_detail` DISABLE KEYS */;
INSERT INTO `scheduler_detail` VALUES (1,0,1,1);
/*!40000 ALTER TABLE `scheduler_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `version_rank` int(11) NOT NULL,
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`version`),
  KEY `schema_version_vr_idx` (`version_rank`),
  KEY `schema_version_ir_idx` (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (1,1,'1','mifosplatform-core-ddl-latest','SQL','V1__mifosplatform-core-ddl-latest.sql',-1243364190,'root','2019-04-04 11:19:55',2047,1),(10,10,'10','interest-posting-fields-for-savings','SQL','V10__interest-posting-fields-for-savings.sql',79717272,'root','2019-04-04 11:19:57',210,1),(100,100,'100','Group saving summary report','SQL','V100__Group_saving_summary_report.sql',-754402574,'root','2019-04-04 11:20:15',15,1),(101,101,'101','add mulitplesof to account transfers table','SQL','V101__add_mulitplesof_to_account_transfers_table.sql',-1862733976,'root','2019-04-04 11:20:15',94,1),(102,102,'102','client attendance tables','SQL','V102__client_attendance_tables.sql',-1564312651,'root','2019-04-04 11:20:16',78,1),(103,103,'103','cluster support for batch jobs','SQL','V103__cluster_support_for_batch_jobs.sql',1111178393,'root','2019-04-04 11:20:16',125,1),(104,104,'104','permissions for transfers','SQL','V104__permissions_for_transfers.sql',-347262213,'root','2019-04-04 11:20:16',0,1),(105,105,'105','track loan transaction against office','SQL','V105__track_loan_transaction_against_office.sql',-2084319791,'root','2019-04-04 11:20:16',231,1),(106,106,'106','more permissions for transfers','SQL','V106__more_permissions_for_transfers.sql',-136119894,'root','2019-04-04 11:20:17',15,1),(107,107,'107','datatable code mappings','SQL','V107__datatable_code_mappings.sql',907861419,'root','2019-04-04 11:20:17',72,1),(108,108,'108','client has transfer office','SQL','V108__client_has_transfer_office.sql',-1299345701,'root','2019-04-04 11:20:17',78,1),(109,109,'109','account transfer withdrawal fee configuration','SQL','V109__account_transfer_withdrawal_fee_configuration.sql',1026122328,'root','2019-04-04 11:20:17',167,1),(11,11,'11','add-payment-details','SQL','V11__add-payment-details.sql',-1900991138,'root','2019-04-04 11:19:58',187,1),(110,110,'110','group center close','SQL','V110__group_center_close.sql',-731961406,'root','2019-04-04 11:20:17',78,1),(111,111,'111','disable constraint approach for datatables by default','SQL','V111__disable_constraint_approach_for_datatables_by_default.sql',570971038,'root','2019-04-04 11:20:17',0,1),(112,112,'111.1','set default transfers in suspense account for existing loan products','SQL','V111_1__set default_transfers_in_suspense_account_for_existing_loan_products.sql',-368844854,'root','2019-04-04 11:20:18',16,1),(113,113,'112','mixreport sql support','SQL','V112__mixreport_sql_support.sql',1955735805,'root','2019-04-04 11:20:18',94,1),(114,114,'113','track savings transaction against office','SQL','V113__track_savings_transaction_against_office.sql',1117484424,'root','2019-04-04 11:20:18',172,1),(115,115,'114','set default transfers in suspense account for existing savings products - Copy','SQL','V114__set_default_transfers_in_suspense_account_for_existing_savings_products - Copy.sql',-1053914103,'root','2019-04-04 11:20:18',0,1),(116,116,'115','permissions for cache api','SQL','V115__permissions_for_cache_api.sql',1454363094,'root','2019-04-04 11:20:18',47,1),(117,117,'116','track currency for journal entries','SQL','V116__track_currency_for_journal_entries.sql',-1392964791,'root','2019-04-04 11:20:19',199,1),(118,118,'117','loan charge from savings','SQL','V117__loan_charge_from_savings.sql',-1454721638,'root','2019-04-04 11:20:19',194,1),(119,119,'118','savings charge','SQL','V118__savings_charge.sql',-2007870881,'root','2019-04-04 11:20:19',109,1),(120,120,'118.1','savings charge patch update','SQL','V118_1__savings_charge_patch_update.sql',813878610,'root','2019-04-04 11:20:19',62,1),(121,121,'118.2','product mapping delete duplicate fund source to account mappings','SQL','V118_2__product_mapping_delete_duplicate_fund_source_to_account_mappings.sql',-1682827795,'root','2019-04-04 11:20:19',16,1),(122,122,'118.3','permissions form propose and accept client transfers','SQL','V118_3__permissions_form_propose_and_accept_client_transfers.sql',-984451311,'root','2019-04-04 11:20:19',15,1),(123,123,'118.4','reset default transfers in suspense account for existing savings products','SQL','V118_4__reset_default_transfers_in_suspense_account_for_existing_savings_products.sql',1253777410,'root','2019-04-04 11:20:20',16,1),(124,124,'118.5','batch job entry for pay savings charge','SQL','V118_5__batch_job_entry_for_pay_savings_charge.sql',1853280559,'root','2019-04-04 11:20:20',16,1),(125,125,'118.6','defaults for income from penalties for savings product','SQL','V118_6__defaults_for_income_from_penalties_for savings_product.sql',-1890547137,'root','2019-04-04 11:20:20',0,1),(126,126,'118.7','move withdrawal annual fee to charges','SQL','V118_7__move_withdrawal_annual_fee_to_charges.sql',843172186,'root','2019-04-04 11:20:20',386,1),(127,127,'118.8','track overpayments seperately in loan transactions','SQL','V118_8__track_overpayments_seperately_in_loan_transactions.sql',103894334,'root','2019-04-04 11:20:21',62,1),(128,128,'119','add template table','SQL','V119__add_template_table.sql',-432032770,'root','2019-04-04 11:20:21',119,1),(12,12,'12','add external id to couple of tables','SQL','V12__add_external_id_to_couple_of_tables.sql',2145623175,'root','2019-04-04 11:19:58',381,1),(129,129,'120','accounting running balance','SQL','V120__accounting_running_balance.sql',561327556,'root','2019-04-04 11:20:21',94,1),(130,130,'121','accounting running balance for organization','SQL','V121__accounting_running_balance_for_organization.sql',-576778038,'root','2019-04-04 11:20:21',93,1),(131,131,'122','recurring fee support for savings','SQL','V122__recurring_fee_support_for_savings.sql',1042442680,'root','2019-04-04 11:20:21',140,1),(132,132,'123','remove payment mode for savings','SQL','V123__remove_payment_mode_for_savings.sql',469806906,'root','2019-04-04 11:20:22',47,1),(133,133,'124','added min max cap for charges','SQL','V124__added_min_max_cap_for_charges.sql',1878563905,'root','2019-04-04 11:20:22',141,1),(134,134,'125','added column for actual fee amount or percentage','SQL','V125__added_column_for_actual_fee_amount_or_percentage.sql',1201765940,'root','2019-04-04 11:20:22',63,1),(135,135,'126','initial database structure for sms outbound','SQL','V126__initial_database_structure_for_sms_outbound.sql',1161953791,'root','2019-04-04 11:20:22',63,1),(136,136,'127','mobile no fields','SQL','V127__mobile_no_fields.sql',1026994283,'root','2019-04-04 11:20:22',140,1),(137,137,'128','added loan installment charge','SQL','V128__added_loan_installment_charge.sql',1780045777,'root','2019-04-04 11:20:22',31,1),(138,138,'129','client and group timeline','SQL','V129__client_and_group_timeline.sql',1766656680,'root','2019-04-04 11:20:23',128,1),(13,13,'13','add group and client pending configuration','SQL','V13__add_group_and_client_pending_configuration.sql',-192455526,'root','2019-04-04 11:19:59',98,1),(139,139,'130','calendar-history-table','SQL','V130__calendar-history-table.sql',-2132039976,'root','2019-04-04 11:20:23',79,1),(140,140,'131','holiday-status-column-and-permissions','SQL','V131__holiday-status-column-and-permissions.sql',-72373073,'root','2019-04-04 11:20:23',154,1),(141,141,'132','borrower cycle changes','SQL','V132__borrower_cycle_changes.sql',-974707474,'root','2019-04-04 11:20:23',94,1),(142,142,'133','adding payment detail with journal entry','SQL','V133__adding_payment_detail_with_journal_entry.sql',-55582257,'root','2019-04-04 11:20:24',62,1),(143,143,'134','added column value on c configuration','SQL','V134__added_column_value_on_c_configuration.sql',293040383,'root','2019-04-04 11:20:24',96,1),(144,144,'134.1','submitted date updation for clients','SQL','V134_1__submitted_date_updation_for_clients.sql',1748790046,'root','2019-04-04 11:20:24',15,1),(145,145,'134.2','permissions spelling correction','SQL','V134_2__permissions_spelling_correction.sql',-1713075394,'root','2019-04-04 11:20:24',16,1),(146,146,'135','added permission for undo written off','SQL','V135__added_permission_for_undo_written_off.sql',-761587924,'root','2019-04-04 11:20:24',15,1),(147,147,'136.1','update script strechy parameter','SQL','V136_1__update_script_strechy_parameter.sql',-484185,'root','2019-04-04 11:20:24',0,1),(148,148,'137','added is active column in m staff','SQL','V137__added_is_active_column_in_m_staff.sql',1494120188,'root','2019-04-04 11:20:24',94,1),(149,149,'138','add short name for m product loan and m savings product','SQL','V138__add_short_name_for_m_product_loan_and_m_savings_product.sql',1419334573,'root','2019-04-04 11:20:25',350,1),(150,150,'139','default value for is active updated to true in m staff','SQL','V139__default_value_for_is_active_updated_to_true_in_m_staff.sql',1480735386,'root','2019-04-04 11:20:25',63,1),(14,14,'14','rename status id to enum','SQL','V14__rename_status_id_to_enum.sql',-1081945577,'root','2019-04-04 11:19:59',169,1),(151,151,'140','added loan charge status','SQL','V140__added_loan_charge_status.sql',1121535657,'root','2019-04-04 11:20:25',61,1),(152,152,'140.1','added payment detail id in ac gl journal entry','SQL','V140_1__added_payment_detail_id_in_ac_gl_journal_entry.sql',1235438247,'root','2019-04-04 11:20:25',75,1),(153,153,'141','add early repayment strategy','SQL','V141__add_early_repayment_strategy.sql',-227396086,'root','2019-04-04 11:20:25',0,1),(154,154,'142','read savingsaccount charge permission','SQL','V142__read_savingsaccount_charge_permission.sql',299242827,'root','2019-04-04 11:20:25',16,1),(155,155,'143','create journalentry checker permission','SQL','V143__create_journalentry_checker_permission.sql',2044638229,'root','2019-04-04 11:20:26',16,1),(156,156,'144','spelling mistake corrections','SQL','V144__spelling_mistake_corrections.sql',-1509260601,'root','2019-04-04 11:20:26',79,1),(157,157,'145','add force password reset in c configuration','SQL','V145__add_force_password_reset_in_c_configuration.sql',-407253534,'root','2019-04-04 11:20:26',234,1),(158,158,'146','tranche loans','SQL','V146__tranche_loans.sql',1632857244,'root','2019-04-04 11:20:26',218,1),(159,159,'147','tranche loans column name changes','SQL','V147__tranche_loans_column_name_changes.sql',1323481977,'root','2019-04-04 11:20:27',62,1),(160,160,'148','overdraft changes','SQL','V148__overdraft_changes.sql',1203044488,'root','2019-04-04 11:20:27',250,1),(161,161,'149','add created date savings transaction','SQL','V149__add_created_date_savings_transaction.sql',-1126372170,'root','2019-04-04 11:20:27',96,1),(15,15,'15','center permissions','SQL','V15__center_permissions.sql',-397540463,'root','2019-04-04 11:19:59',18,1),(162,162,'150','basic savings report','SQL','V150__basic_savings_report.sql',-1036803254,'root','2019-04-04 11:20:27',94,1),(163,163,'151','add default savings account to client','SQL','V151__add_default_savings_account_to_client.sql',798635423,'root','2019-04-04 11:20:28',77,1),(164,164,'152','added grace for over due','SQL','V152__added_grace_for_over_due.sql',-1916581696,'root','2019-04-04 11:20:28',157,1),(165,165,'153','Insert missed permissions','SQL','V153__Insert_missed_permissions.sql',1408459847,'root','2019-04-04 11:20:28',16,1),(166,166,'154','aging details','SQL','V154__aging_details.sql',-1125432672,'root','2019-04-04 11:20:28',0,1),(167,167,'155','stretchy into pentaho','SQL','V155__stretchy_into_pentaho.sql',-1288576894,'root','2019-04-04 11:20:28',93,1),(168,168,'156','added loan saving txns pentaho','SQL','V156__added_loan_saving_txns_pentaho.sql',1916408309,'root','2019-04-04 11:20:28',15,1),(169,169,'157','overdue charge improvements','SQL','V157__overdue_charge_improvements.sql',1926239015,'root','2019-04-04 11:20:29',109,1),(170,170,'158','dashboard and navigation queries','SQL','V158__dashboard_and_navigation_queries.sql',-1003182169,'root','2019-04-04 11:20:29',31,1),(171,171,'159','add transaction id column m portfolio command source','SQL','V159__add_transaction_id_column_m_portfolio_command_source.sql',1856672381,'root','2019-04-04 11:20:29',109,1),(16,16,'16','drop min max column on loan table','SQL','V16__drop_min_max_column_on_loan_table.sql',1414842463,'root','2019-04-04 11:19:59',139,1),(172,172,'160','standing instruction changes','SQL','V160__standing_instruction_changes.sql',-951720020,'root','2019-04-04 11:20:29',300,1),(173,173,'160.2','Allow nullValue For principal on lonProduct','SQL','V160_2__Allow_nullValue_For_principal_on_lonProduct.sql',1498909616,'root','2019-04-04 11:20:30',47,1),(174,174,'161','added accrual batch job','SQL','V161__added_accrual_batch_job.sql',1530884559,'root','2019-04-04 11:20:30',89,1),(175,175,'162','overdue charge batch job','SQL','V162__overdue_charge_batch_job.sql',-601622307,'root','2019-04-04 11:20:30',0,1),(176,176,'163','added npa for loans','SQL','V163__added_npa_for_loans.sql',4757824,'root','2019-04-04 11:20:30',303,1),(177,177,'164','fd and rd deposit tables','SQL','V164__fd_and_rd_deposit_tables.sql',-2117275016,'root','2019-04-04 11:20:31',588,1),(178,178,'165','added permission for disburse to saving account','SQL','V165__added_permission_for_disburse_to_saving_account.sql',-1245643496,'root','2019-04-04 11:20:31',16,1),(179,179,'166','added deposit amount to product term and preclosure','SQL','V166__added_deposit_amount_to_product_term_and_preclosure.sql',-2019432635,'root','2019-04-04 11:20:31',161,1),(180,180,'167','added columns for writtenOff loans recovered','SQL','V167__added_columns_for_writtenOff_loans_recovered.sql',887814697,'root','2019-04-04 11:20:32',110,1),(181,181,'168','added transfer fixed deposit interest to linked account','SQL','V168__added_transfer_fixed_deposit_interest_to_linked_account.sql',2021698129,'root','2019-04-04 11:20:32',150,1),(182,182,'169','update dashboard reports to core reports use report to false','SQL','V169__update_dashboard_reports_to_core_reports_use_report_to_false.sql',-1082743067,'root','2019-04-04 11:20:32',16,1),(17,17,'17','update stretchy reporting ddl','SQL','V17__update_stretchy_reporting_ddl.sql',436966109,'root','2019-04-04 11:20:00',451,1),(183,183,'170','update deposit accounts maturity details job','SQL','V170__update_deposit_accounts_maturity_details_job.sql',30397538,'root','2019-04-04 11:20:32',16,1),(184,184,'171','added mandatory savings and rd changes','SQL','V171__added_mandatory_savings_and_rd_changes.sql',-218191905,'root','2019-04-04 11:20:33',440,1),(185,185,'172','accounting changes for transfers','SQL','V172__accounting_changes_for_transfers.sql',-1246214897,'root','2019-04-04 11:20:33',47,1),(186,186,'173','ppi','SQL','V173__ppi.sql',1465403384,'root','2019-04-04 11:20:33',234,1),(187,187,'174','remove interest accrual','SQL','V174__remove_interest_accrual.sql',-1593433770,'root','2019-04-04 11:20:33',0,1),(188,188,'175','added incentive interest rates','SQL','V175__added_incentive_interest_rates.sql',-17965975,'root','2019-04-04 11:20:34',250,1),(189,189,'176','updates to financial activity accounts','SQL','V176__updates_to_financial_activity_accounts.sql',103591100,'root','2019-04-04 11:20:34',223,1),(190,190,'177','cleanup for client incentives','SQL','V177__cleanup_for_client_incentives.sql',1070538805,'root','2019-04-04 11:20:34',16,1),(191,191,'178','updates to financial activity accounts pt2','SQL','V178__updates_to_financial_activity_accounts_pt2.sql',1430879501,'root','2019-04-04 11:20:34',16,1),(192,192,'179','updates to action names for maker checker permissions','SQL','V179__updates_to_action_names_for_maker_checker_permissions.sql',871278301,'root','2019-04-04 11:20:34',32,1),(18,18,'18','update stretchy reporting reportSql','SQL','V18__update_stretchy_reporting_reportSql.sql',-520607907,'root','2019-04-04 11:20:00',15,1),(193,193,'180','update report schemas for disbursed vs awaitingdisbursal and groupnamesbystaff','SQL','V180__update_report_schemas_for_disbursed_vs_awaitingdisbursal_and_groupnamesbystaff.sql',-1697108470,'root','2019-04-04 11:20:34',16,1),(194,194,'181','standing instruction logging','SQL','V181__standing_instruction_logging.sql',1151150413,'root','2019-04-04 11:20:35',48,1),(195,195,'182','added min required balance to savings product','SQL','V182__added_min_required_balance_to_savings_product.sql',89955786,'root','2019-04-04 11:20:35',172,1),(196,196,'183','added min balance for interest calculation','SQL','V183__added_min_balance_for_interest_calculation.sql',479667978,'root','2019-04-04 11:20:35',166,1),(197,197,'184','update min required balance for savings product','SQL','V184__update_min_required_balance_for_savings_product.sql',1380290285,'root','2019-04-04 11:20:36',171,1),(198,198,'185','add accrual till date for periodic accrual','SQL','V185__add_accrual_till_date_for_periodic_accrual.sql',2132938814,'root','2019-04-04 11:20:36',94,1),(199,199,'186','added periodic accrual job','SQL','V186__added_periodic_accrual_job.sql',717708357,'root','2019-04-04 11:20:36',16,1),(200,200,'187','added permission to periodic accrual','SQL','V187__added_permission_to_periodic_accrual.sql',-1350750892,'root','2019-04-04 11:20:36',0,1),(201,201,'188','add savingscharge inactivate permissions','SQL','V188__add_savingscharge_inactivate_permissions.sql',-543121447,'root','2019-04-04 11:20:36',79,1),(202,202,'189','m loan interest recalculation tables','SQL','V189__m_loan_interest_recalculation_tables.sql',-1849437648,'root','2019-04-04 11:20:37',166,1),(19,19,'19','report maintenance permissions','SQL','V19__report_maintenance_permissions.sql',-139431294,'root','2019-04-04 11:20:00',32,1),(203,203,'190','add associategroup disassociategroup permissions','SQL','V190__add_associategroup_disassociategroup_permissions.sql',-738284830,'root','2019-04-04 11:20:37',0,1),(204,204,'191','update gl account increase size of name col','SQL','V191__update_gl_account_increase_size_of_name_col.sql',99612865,'root','2019-04-04 11:20:37',79,1),(205,205,'192','interest recalculate job','SQL','V192__interest_recalculate_job.sql',1431072766,'root','2019-04-04 11:20:37',0,1),(206,206,'193','added column joiningDate for staff','SQL','V193__added_column_joiningDate_for_staff.sql',1584808613,'root','2019-04-04 11:20:37',78,1),(207,207,'194','added recalculatedInterestComponent for interest recalculation','SQL','V194__added_recalculatedInterestComponent_for_interest_recalculation.sql',-425206815,'root','2019-04-04 11:20:38',47,1),(208,208,'195','moved rest frequency to product level','SQL','V195__moved_rest_frequency_to_product_level.sql',-250893403,'root','2019-04-04 11:20:38',93,1),(209,209,'196','added loan running balance to transactions','SQL','V196__added_loan_running_balance_to_transactions.sql',-1872675055,'root','2019-04-04 11:20:38',78,1),(210,210,'197','updated loan running balance of transactions','SQL','V197__updated_loan_running_balance_of_transactions.sql',-364666887,'root','2019-04-04 11:20:38',69,1),(211,211,'198','loan rescheduling tables and permissions','SQL','V198__loan_rescheduling_tables_and_permissions.sql',1610194559,'root','2019-04-04 11:20:39',175,1),(212,212,'199','removed extra columns from schedule history','SQL','V199__removed_extra_columns_from_schedule_history.sql',352416187,'root','2019-04-04 11:20:39',93,1),(2,2,'2','mifosx-base-reference-data-utf8','SQL','V2__mifosx-base-reference-data-utf8.sql',802596776,'root','2019-04-04 11:19:56',78,1),(20,20,'20','report maint perms really configuration','SQL','V20__report_maint_perms_really_configuration.sql',-1671252627,'root','2019-04-04 11:20:00',15,1),(213,213,'200','alter savings account for start interest calculation date','SQL','V200__alter_savings_account_for_start_interest_calculation_date.sql',-1953903651,'root','2019-04-04 11:20:39',63,1),(214,214,'201','webhooks','SQL','V201__webhooks.sql',-1336007721,'root','2019-04-04 11:20:39',158,1),(215,215,'202','savings officer history table','SQL','V202__savings_officer_history_table.sql',-1190601063,'root','2019-04-04 11:20:39',78,1),(216,216,'203','added subbmittedDate loantransaction','SQL','V203__added_subbmittedDate_loantransaction.sql',-1720588441,'root','2019-04-04 11:20:40',94,1),(217,217,'204','insert script for charges paid by for accruals','SQL','V204__insert_script_for_charges_paid_by_for_accruals.sql',921311711,'root','2019-04-04 11:20:40',16,1),(218,218,'205','fix for charge and interest waiver with accruals','SQL','V205__fix_for_charge_and_interest_waiver_with_accruals.sql',2064156368,'root','2019-04-04 11:20:40',106,1),(219,219,'206','interest posting configuration','SQL','V206__interest_posting_configuration.sql',1969946491,'root','2019-04-04 11:20:40',86,1),(220,220,'207','min max clients per group','SQL','V207__min_max_clients_per_group.sql',-941684012,'root','2019-04-04 11:20:41',96,1),(221,221,'208','min max clients in group redux','SQL','V208__min_max_clients_in_group_redux.sql',1555975738,'root','2019-04-04 11:20:41',141,1),(222,222,'209','add all report names in m permission table','SQL','V209__add_all_report_names_in_m_permission_table.sql',79899864,'root','2019-04-04 11:20:41',49,1),(21,21,'21','activation-permissions-for-clients','SQL','V21__activation-permissions-for-clients.sql',-1201397355,'root','2019-04-04 11:20:00',122,1),(223,223,'210','track manually adjusted transactions','SQL','V210__track_manually_adjusted_transactions.sql',-314992180,'root','2019-04-04 11:20:41',56,1),(224,224,'211','minimum days between disbursal and first repayment','SQL','V211__minimum_days_between_disbursal_and_first_repayment.sql',-896943661,'root','2019-04-04 11:20:41',78,1),(225,225,'212','add NthDay and DayOfWeek columns loan','SQL','V212__add_NthDay_and_DayOfWeek_columns_loan.sql',-1408877083,'root','2019-04-04 11:20:42',98,1),(226,226,'213','NthDay and DayOfWeek columns should be nullable','SQL','V213__NthDay_and_DayOfWeek_columns_should_be_nullable.sql',-571189232,'root','2019-04-04 11:20:42',125,1),(227,227,'214','alter table add create SI at disbursement','SQL','V214__alter_table_add_create_SI_at_disbursement.sql',785371501,'root','2019-04-04 11:20:42',78,1),(228,228,'215','guarantee on hold fund changes','SQL','V215__guarantee_on_hold_fund_changes.sql',-491155023,'root','2019-04-04 11:20:42',234,1),(229,229,'216','adding loan proposed amount to loan','SQL','V216__adding_loan_proposed_amount_to_loan.sql',1664104750,'root','2019-04-04 11:20:43',47,1),(230,230,'217','client substatus and codevalue description','SQL','V217__client_substatus_and_codevalue_description.sql',1701078555,'root','2019-04-04 11:20:43',187,1),(231,231,'218','add user and datetime for loan savings transactions','SQL','V218__add_user_and_datetime_for_loan_savings_transactions.sql',811251105,'root','2019-04-04 11:20:43',141,1),(232,232,'219','guarantor on hold fund changes for account','SQL','V219__guarantor_on_hold_fund_changes_for_account.sql',-636439330,'root','2019-04-04 11:20:44',375,1),(22,22,'22','alter-group-for-consistency-add-permissions','SQL','V22__alter-group-for-consistency-add-permissions.sql',1501525144,'root','2019-04-04 11:20:01',285,1),(233,233,'220','account number preferences','SQL','V220__account_number_preferences.sql',498517685,'root','2019-04-04 11:20:44',63,1),(234,234,'221','add version for m savings account','SQL','V221__add_version_for_m_savings_account.sql',-1315329107,'root','2019-04-04 11:20:44',62,1),(235,235,'222','guarantor on hold fund changes for transactions','SQL','V222__guarantor_on_hold_fund_changes_for_transactions.sql',1448959843,'root','2019-04-04 11:20:44',222,1),(236,236,'223','add version for m loan account','SQL','V223__add_version_for_m_loan_account.sql',1110042443,'root','2019-04-04 11:20:46',998,1),(237,237,'224','client lifecycle adding statuses','SQL','V224__client_lifecycle_adding_statuses.sql',-1260726557,'root','2019-04-04 11:20:48',2085,1),(238,238,'225','permissions for updating recurring deposit amount','SQL','V225__permissions_for_updating_recurring_deposit_amount.sql',17824143,'root','2019-04-04 11:20:49',246,1),(239,239,'226','configuration for enforcing calendars for jlg loans','SQL','V226__configuration_for_enforcing_calendars_for_jlg_loans.sql',530541054,'root','2019-04-04 11:20:49',15,1),(240,240,'227','loan-refund-permissions','SQL','V227__loan-refund-permissions.sql',-199541245,'root','2019-04-04 11:20:49',31,1),(241,241,'228','entity to entity access','SQL','V228__entity_to_entity_access.sql',-886972575,'root','2019-04-04 11:20:49',80,1),(242,242,'229','teller cash management','SQL','V229__teller_cash_management.sql',1797536464,'root','2019-04-04 11:20:50',203,1),(23,23,'23','remove-enable-disable-configuration-for-client-group-status','SQL','V23__remove-enable-disable-configuration-for-client-group-status.sql',43458638,'root','2019-04-04 11:20:01',63,1),(243,243,'230','role status and correspoding permissions','SQL','V230__role_status_and_correspoding_permissions.sql',-718483838,'root','2019-04-04 11:20:50',125,1),(244,244,'231','m cashier transaction added currency code','SQL','V231__m_cashier_transaction_added_currency_code.sql',-1646679447,'root','2019-04-04 11:20:50',91,1),(245,245,'232','insert center closure reason','SQL','V232__insert_center_closure_reason.sql',976483171,'root','2019-04-04 11:20:50',0,1),(246,246,'233','Savings Transaction Receipt','SQL','V233__Savings_Transaction_Receipt.sql',904771282,'root','2019-04-04 11:20:50',15,1),(247,247,'234','opening balaces setup','SQL','V234__opening_balaces_setup.sql',640123929,'root','2019-04-04 11:20:50',62,1),(248,248,'235','add ugd template id m hook','SQL','V235__add_ugd_template_id_m_hook.sql',-1268706826,'root','2019-04-04 11:20:51',125,1),(249,249,'236','individual collection sheet permissions','SQL','V236__individual_collection_sheet_permissions.sql',-569636466,'root','2019-04-04 11:20:51',15,1),(250,250,'237','add threshold config for last instalment','SQL','V237__add_threshold_config_for_last_instalment.sql',255818398,'root','2019-04-04 11:20:51',172,1),(251,251,'238','update staff display name length','SQL','V238__update_staff_display_name_length.sql',1942648833,'root','2019-04-04 11:20:51',109,1),(252,252,'239','Loan Transaction Receipt','SQL','V239__Loan_Transaction_Receipt.sql',1892953443,'root','2019-04-04 11:20:52',32,1),(24,24,'24','add-group-client-foreign-key-constraint-in-loan-table','SQL','V24__add-group-client-foreign-key-constraint-in-loan-table.sql',585910999,'root','2019-04-04 11:20:01',56,1),(253,253,'240','arrears aging config for interest recalculation','SQL','V240__arrears_aging_config_for_interest_recalculation.sql',1657223198,'root','2019-04-04 11:20:52',203,1),(254,254,'241','fixed emi changes','SQL','V241__fixed_emi_changes.sql',571693336,'root','2019-04-04 11:20:52',62,1),(255,255,'242','entitytoentitymappingrelation','SQL','V242__entitytoentitymappingrelation.sql',1876771949,'root','2019-04-04 11:20:52',94,1),(256,256,'243','alter loan disbursement details','SQL','V243__alter_loan_disbursement_details.sql',2125791789,'root','2019-04-04 11:20:53',94,1),(257,257,'244','staff assignment history table','SQL','V244__staff_assignment_history_table.sql',285562400,'root','2019-04-04 11:20:53',32,1),(258,258,'245','open rd changes','SQL','V245__open_rd_changes.sql',88342375,'root','2019-04-04 11:20:53',16,1),(259,259,'246','drop group client foreign key from m loan','SQL','V246__drop_group_client_foreign_key_from_m_loan.sql',2066150361,'root','2019-04-04 11:20:53',125,1),(260,260,'247','consistency wrt spelling principalThresholdForLastInstalment','SQL','V247__consistency_wrt_spelling_principalThresholdForLastInstalment.sql',1868904766,'root','2019-04-04 11:20:53',94,1),(261,261,'248','added password never expired to User','SQL','V248__added_password_never_expired_to_User.sql',-207588405,'root','2019-04-04 11:20:53',62,1),(262,262,'249','workingdays permissions','SQL','V249__workingdays_permissions.sql',845502408,'root','2019-04-04 11:20:54',15,1),(25,25,'25','update client reports for status and activation change','SQL','V25__update_client_reports_for_status_and_activation_change.sql',1872185975,'root','2019-04-04 11:20:01',31,1),(263,263,'250','password validation policy','SQL','V250__password_validation_policy.sql',1858897569,'root','2019-04-04 11:20:54',27,1),(264,264,'251','paymentType table','SQL','V251__paymentType_table.sql',-350734561,'root','2019-04-04 11:20:54',312,1),(265,265,'252','bug fix teller cash management','SQL','V252__bug_fix_teller_cash_management.sql',1224535024,'root','2019-04-04 11:20:54',109,1),(266,266,'253','product loan configurable attributes','SQL','V253__product_loan_configurable_attributes.sql',-1912798616,'root','2019-04-04 11:20:54',32,1),(267,267,'254','General Ledger Report','SQL','V254__General_Ledger_Report.sql',2037924653,'root','2019-04-04 11:20:55',16,1),(268,268,'255','pre close interest period config','SQL','V255__pre_close_interest_period_config.sql',1717451256,'root','2019-04-04 11:20:55',47,1),(269,269,'256','Update script for General Ledger report','SQL','V256__Update script for General_Ledger_report.sql',-1400786952,'root','2019-04-04 11:20:55',15,1),(270,270,'257','staff image association','SQL','V257__staff_image_association.sql',-1702585950,'root','2019-04-04 11:20:55',110,1),(271,271,'258','interest compounding changes','SQL','V258__interest_compounding_changes.sql',-930986140,'root','2019-04-04 11:20:55',125,1),(272,272,'259','alter working days','SQL','V259__alter_working_days.sql',-1436809036,'root','2019-04-04 11:20:56',62,1),(26,26,'26','add-support-for-withdrawal-fees-on-savings','SQL','V26__add-support-for-withdrawal-fees-on-savings.sql',2118474011,'root','2019-04-04 11:20:02',215,1),(273,273,'260','alter password validation policy','SQL','V260__alter_password_validation_policy.sql',-720915497,'root','2019-04-04 11:20:56',80,1),(274,274,'261','Update script for Client Loan Account Schedule Report','SQL','V261__Update script for Client_Loan_Account_Schedule_Report.sql',-1203826809,'root','2019-04-04 11:20:56',16,1),(275,275,'262','accountNumber for groups','SQL','V262__accountNumber_for_groups.sql',-1618907984,'root','2019-04-04 11:20:56',47,1),(276,276,'263','mifos reports','SQL','V263__mifos_reports.sql',5463425,'root','2019-04-04 11:20:56',16,1),(277,277,'264','insert paymenttype and report read permission','SQL','V264__insert_paymenttype_and_report_read_permission.sql',-878457774,'root','2019-04-04 11:20:56',1,1),(278,278,'265','modify external service schema','SQL','V265__modify_external_service_schema.sql',-2093326987,'root','2019-04-04 11:20:57',416,1),(279,279,'266','client fees','SQL','V266__client_fees.sql',1985527595,'root','2019-04-04 11:20:57',188,1),(280,280,'267','client transaction permissions','SQL','V267__client_transaction_permissions.sql',2102532971,'root','2019-04-04 11:20:57',16,1),(281,281,'268','update gmail password','SQL','V268__update_gmail_password.sql',-1488155404,'root','2019-04-04 11:20:57',16,1),(282,282,'269','increased calendar title length ','SQL','V269__increased_calendar_title_length .sql',2009701575,'root','2019-04-04 11:20:58',141,1),(27,27,'27','add-loan-type-column-to-loan-table','SQL','V27__add-loan-type-column-to-loan-table.sql',687699677,'root','2019-04-04 11:20:02',85,1),(283,283,'270','add rounding mode configuration','SQL','V270__add_rounding_mode_configuration.sql',-1749059384,'root','2019-04-04 11:20:58',114,1),(284,284,'271','accounting for client charges','SQL','V271__accounting_for_client_charges.sql',-504614323,'root','2019-04-04 11:20:58',188,1),(285,285,'272','loan tranche disbursement charge','SQL','V272__loan_tranche_disbursement_charge.sql',-285159057,'root','2019-04-04 11:20:58',221,1),(286,286,'273','oauth changes','SQL','V273__oauth_changes.sql',-344895003,'root','2019-04-04 11:20:59',94,1),(287,287,'274','Loan Reschedule Code Value','SQL','V274__Loan_Reschedule_Code_Value.sql',217374783,'root','2019-04-04 11:20:59',4,1),(288,288,'275','loan transaction to repayment schedule mapping','SQL','V275__loan_transaction_to_repayment_schedule_mapping.sql',103630394,'root','2019-04-04 11:20:59',31,1),(289,289,'276','loan recalulated till date','SQL','V276__loan_recalulated_till_date.sql',368993412,'root','2019-04-04 11:20:59',109,1),(290,290,'277','Loan Product Provisioning','SQL','V277__Loan_Product_Provisioning.sql',706445180,'root','2019-04-04 11:21:00',369,1),(291,291,'278','LoanTransactionProcessingStrategy','SQL','V278__LoanTransactionProcessingStrategy.sql',-1455572446,'root','2019-04-04 11:21:00',97,1),(292,292,'279','floating rates','SQL','V279__floating_rates.sql',656913236,'root','2019-04-04 11:21:00',296,1),(28,28,'28','accounting-abstractions-and-autoposting','SQL','V28__accounting-abstractions-and-autoposting.sql',1795480561,'root','2019-04-04 11:20:02',85,1),(293,293,'280','spm framework initial tables','SQL','V280__spm_framework_initial_tables.sql',-2084662630,'root','2019-04-04 11:21:01',262,1),(294,294,'281','add configuration param backdate-penalties','SQL','V281__add_configuration_param_backdate-penalties.sql',-396872379,'root','2019-04-04 11:21:01',24,1),(295,295,'282','CustomerSelfService','SQL','V282__CustomerSelfService.sql',-2032395686,'root','2019-04-04 11:21:01',118,1),(296,296,'283','Variable Installments','SQL','V283__Variable_Installments.sql',886050646,'root','2019-04-04 11:21:01',205,1),(297,297,'284','update codevalue','SQL','V284__update_codevalue.sql',-675349506,'root','2019-04-04 11:21:02',187,1),(298,298,'285','undo last tranche script','SQL','V285__undo_last_tranche_script.sql',-891471969,'root','2019-04-04 11:21:02',47,1),(299,299,'286','partial period interest calcualtion','SQL','V286__partial_period_interest_calcualtion.sql',1621312358,'root','2019-04-04 11:21:02',154,1),(300,300,'287','alter spm scorecard','SQL','V287__alter_spm_scorecard.sql',-729460302,'root','2019-04-04 11:21:02',89,1),(301,301,'288','overdraft interest','SQL','V288__overdraft_interest.sql',1983820448,'root','2019-04-04 11:21:03',156,1),(302,302,'289','client non person','SQL','V289__client_non_person.sql',-2000808984,'root','2019-04-04 11:21:03',124,1),(29,29,'29','add-support-for-annual-fees-on-savings','SQL','V29__add-support-for-annual-fees-on-savings.sql',-2091285116,'root','2019-04-04 11:20:02',200,1),(303,303,'290','shares dividends permissions script','SQL','V290__shares_dividends_permissions_script.sql',1794609838,'root','2019-04-04 11:21:03',15,1),(304,304,'291','organisation start date config','SQL','V291__organisation_start_date_config.sql',163957436,'root','2019-04-04 11:21:03',89,1),(305,305,'292','update organisation start date','SQL','V292__update_organisation_start_date.sql',1186979674,'root','2019-04-04 11:21:03',4,1),(306,306,'293','interest rate chart support for amounts','SQL','V293__interest_rate_chart_support_for_amounts.sql',1403529502,'root','2019-04-04 11:21:04',245,1),(307,307,'294','configuration for paymnettype application forDisbursement charge','SQL','V294__configuration_for_paymnettype_application_forDisbursement_charge.sql',-499755507,'root','2019-04-04 11:21:04',16,1),(308,308,'295','configuration for interest charged date same as disbursal date','SQL','V295__configuration_for_interest_charged_date_same_as_disbursal_date.sql',-1036462051,'root','2019-04-04 11:21:04',16,1),(309,309,'296','skip repayment on first-day of month','SQL','V296__skip_repayment_on first-day_of_month.sql',-831182585,'root','2019-04-04 11:21:04',15,1),(310,310,'297','Adding Meeting Time column','SQL','V297__Adding_Meeting_Time_column.sql',2130113830,'root','2019-04-04 11:21:04',78,1),(311,311,'298','savings interest tax','SQL','V298__savings_interest_tax.sql',1521315509,'root','2019-04-04 11:21:05',637,1),(312,312,'299','share products','SQL','V299__share_products.sql',1965974581,'root','2019-04-04 11:21:06',475,1),(3,3,'3','mifosx-permissions-and-authorisation-utf8','SQL','V3__mifosx-permissions-and-authorisation-utf8.sql',-2068712444,'root','2019-04-04 11:19:56',79,1),(30,30,'30','add-referenceNumber-to-acc gl journal entry','SQL','V30__add-referenceNumber-to-acc_gl_journal_entry.sql',1755375098,'root','2019-04-04 11:20:03',88,1),(313,313,'300','configuration for allow changing of emi amount','SQL','V300__configuration_for_allow_changing_of_emi_amount.sql',-77580122,'root','2019-04-04 11:21:06',91,1),(314,314,'301','recurring moratorium principal periods','SQL','V301__recurring_moratorium_principal_periods.sql',-1417393406,'root','2019-04-04 11:21:06',156,1),(315,315,'302','add status to client identifier','SQL','V302__add_status_to_client_identifier.sql',293526785,'root','2019-04-04 11:21:06',63,1),(316,316,'303','Savings Account Dormancy','SQL','V303__Savings_Account_Dormancy.sql',722055066,'root','2019-04-04 11:21:06',156,1),(317,317,'304','customer self service third party transfers','SQL','V304__customer_self_service_third_party_transfers.sql',-884817516,'root','2019-04-04 11:21:07',47,1),(318,318,'305','compounding and rest frequency nth day freq and insertion script for accrual job','SQL','V305__compounding_and_rest_frequency_nth_day_freq_and_insertion_script_for_accrual_job.sql',77106775,'root','2019-04-04 11:21:07',493,1),(319,319,'306','add domancy tracking job to savings group','SQL','V306__add_domancy_tracking_job_to_savings_group.sql',-1684964164,'root','2019-04-04 11:21:07',16,1),(320,320,'307','add share notes','SQL','V307__add_share_notes.sql',-264448271,'root','2019-04-04 11:21:08',63,1),(321,321,'308','add interest recalculation in savings account','SQL','V308__add_interest_recalculation_in_savings_account.sql',-337873986,'root','2019-04-04 11:21:08',62,1),(322,322,'309','add loan write off reason code','SQL','V309__add_loan_write_off_reason_code.sql',2026829662,'root','2019-04-04 11:21:08',140,1),(31,31,'31','drop-autopostings','SQL','V31__drop-autopostings.sql',499669958,'root','2019-04-04 11:20:03',0,1),(323,323,'310','copy data from entitytoentityaccess to entitytoentitymapping','SQL','V310__copy_data_from_entitytoentityaccess_to_entitytoentitymapping.sql',-1649070300,'root','2019-04-04 11:21:08',15,1),(324,324,'311','foreclosure details','SQL','V311__foreclosure_details.sql',-1065709257,'root','2019-04-04 11:21:08',125,1),(325,325,'312','add is mandatory to code value','SQL','V312__add_is_mandatory_to_code_value.sql',-126173291,'root','2019-04-04 11:21:09',94,1),(326,326,'313','multi rescheduling script','SQL','V313__multi_rescheduling_script.sql',277324082,'root','2019-04-04 11:21:09',453,1),(327,327,'314','updating r enum table','SQL','V314__updating_r_enum_table.sql',1732507970,'root','2019-04-04 11:21:09',23,1),(328,328,'315','add sync expected with disbursement date in m product loan','SQL','V315__add_sync_expected_with_disbursement_date_in_m_product_loan.sql',-843455125,'root','2019-04-04 11:21:09',88,1),(329,329,'316','address module tables metadat','SQL','V316__address_module_tables_metadat.sql',-802461604,'root','2019-04-04 11:21:10',201,1),(330,330,'317','report mailing job module','SQL','V317__report_mailing_job_module.sql',-839807922,'root','2019-04-04 11:21:10',125,1),(331,331,'318','topuploan','SQL','V318__topuploan.sql',-2043298172,'root','2019-04-04 11:21:10',233,1),(332,332,'319','client undoreject','SQL','V319__client_undoreject.sql',-2115496427,'root','2019-04-04 11:21:11',78,1),(32,32,'32','associate-disassociate-clients-from-group-permissions','SQL','V32__associate-disassociate-clients-from-group-permissions.sql',-1523966200,'root','2019-04-04 11:20:03',0,1),(333,333,'320','add holiday payment reschedule','SQL','V320__add_holiday_payment_reschedule.sql',2014943609,'root','2019-04-04 11:21:11',76,1),(334,334,'321','boolean field As Interest PostedOn','SQL','V321__boolean_field_As_Interest_PostedOn.sql',-1865452289,'root','2019-04-04 11:21:11',78,1),(335,335,'322','sms campaign','SQL','V322__sms_campaign.sql',325413061,'root','2019-04-04 11:21:11',232,1),(336,336,'322.1','scheduled email campaign','SQL','V322_1__scheduled_email_campaign.sql',2005034399,'root','2019-04-04 11:21:12',301,1),(337,337,'322.2','email business rules','SQL','V322_2__email_business_rules.sql',-1042026609,'root','2019-04-04 11:21:12',16,1),(338,338,'323','spm replace dead fk with exisiting one','SQL','V323__spm_replace_dead_fk_with_exisiting_one.sql',588066913,'root','2019-04-04 11:21:12',227,1),(339,339,'324','datatable checks','SQL','V324__datatable_checks.sql',-1938197720,'root','2019-04-04 11:21:12',31,1),(340,340,'325','add is staff client data','SQL','V325__add_is_staff_client_data.sql',-1873777737,'root','2019-04-04 11:21:13',94,1),(341,341,'326','data migration for client tr gl entries','SQL','V326__data_migration_for_client_tr_gl_entries.sql',955740895,'root','2019-04-04 11:21:13',16,1),(342,342,'327','creditbureau configuration','SQL','V327__creditbureau_configuration.sql',1668840284,'root','2019-04-04 11:21:13',219,1),(343,343,'328','family members sql support','SQL','V328__family_members_sql_support.sql',-573306316,'root','2019-04-04 11:21:13',107,1),(344,344,'329','sms messages without campaign','SQL','V329__sms_messages_without_campaign.sql',-1105953017,'root','2019-04-04 11:21:13',106,1),(33,33,'33','drop unique check on stretchy report parameter','SQL','V33__drop_unique_check_on_stretchy_report_parameter.sql',-1703958717,'root','2019-04-04 11:20:03',70,1),(345,345,'330','savings account transaction releaseId','SQL','V330__savings_account_transaction_releaseId.sql',955636224,'root','2019-04-04 11:21:14',140,1),(346,346,'331','holiday schema changes','SQL','V331__holiday_schema_changes.sql',115844504,'root','2019-04-04 11:21:14',78,1),(347,347,'332','self service registration schema','SQL','V332__self_service_registration_schema.sql',633744390,'root','2019-04-04 11:21:14',31,1),(348,348,'333','adhocquery','SQL','V333__adhocquery.sql',-1793709676,'root','2019-04-04 11:21:14',47,1),(349,349,'334','notification module tables','SQL','V334__notification_module_tables.sql',2078988506,'root','2019-04-04 11:21:14',140,1),(350,350,'335','self service user role','SQL','V335__self_service_user_role.sql',-1007891545,'root','2019-04-04 11:21:15',16,1),(351,351,'336','sms campaign notification','SQL','V336__sms_campaign_notification.sql',-1618899110,'root','2019-04-04 11:21:15',155,1),(352,352,'337','equal amortization','SQL','V337__equal_amortization.sql',376914729,'root','2019-04-04 11:21:15',185,1),(353,353,'338','two factor authentication','SQL','V338__two_factor_authentication.sql',313249194,'root','2019-04-04 11:21:15',63,1),(354,354,'339','report-run-frequency','SQL','V339__report-run-frequency.sql',711922458,'root','2019-04-04 11:21:16',219,1),(34,34,'34','add unique check on stretchy report parameter','SQL','V34__add_unique_check_on_stretchy_report_parameter.sql',771466793,'root','2019-04-04 11:20:03',46,1),(355,355,'340','nullable-adhoc-email','SQL','V340__nullable-adhoc-email.sql',1937711890,'root','2019-04-04 11:21:16',93,1),(356,356,'341','m import document','SQL','V341__m_import_document.sql',-1267409700,'root','2019-04-04 11:21:16',78,1),(357,357,'342','topic module table','SQL','V342__topic_module_table.sql',-984858634,'root','2019-04-04 11:21:16',95,1),(358,358,'343','scheduled email campaign status','SQL','V343__scheduled_email_campaign_status.sql',507386259,'root','2019-04-04 11:21:16',47,1),(359,359,'345','reports for self service user','SQL','V345__reports_for_self_service_user.sql',1608208476,'root','2019-04-04 11:21:17',78,1),(360,361,'346','nullable saving product description','SQL','V346__nullable_saving_product_description.sql',-369597878,'root','2019-04-11 08:46:04',122,1),(361,362,'347','correcting report category','SQL','V347__correcting_report_category.sql',-105509656,'root','2019-04-11 08:46:04',32,1),(362,363,'348','m trial balance table','SQL','V348__m_trial_balance_table.sql',965898415,'root','2019-04-11 08:46:05',195,1),(363,364,'349','client transfer details','SQL','V349__client_transfer_details.sql',-1682262548,'root','2019-04-11 08:46:05',141,1),(35,35,'35','add hierarchy column for acc gl account','SQL','V35__add_hierarchy_column_for_acc_gl_account.sql',-507655908,'root','2019-04-04 11:20:03',73,1),(364,365,'350','email from','SQL','V350__email_from.sql',337447721,'root','2019-04-11 08:46:05',31,1),(365,366,'351','pocket mapping','SQL','V351__pocket_mapping.sql',801256479,'root','2019-04-11 08:46:05',62,1),(36,36,'36','add tag id column for acc gl account','SQL','V36__add_tag_id_column_for_acc_gl_account.sql',1202085498,'root','2019-04-04 11:20:03',62,1),(37,37,'37','add-center-group-collection-sheet-permissions','SQL','V37__add-center-group-collection-sheet-permissions.sql',1955324939,'root','2019-04-04 11:20:04',7,1),(38,38,'38','add-group-summary-details-report','SQL','V38__add-group-summary-details-report.sql',-1699228726,'root','2019-04-04 11:20:04',18,1),(39,39,'39','payment-channels-updates','SQL','V39__payment-channels-updates.sql',-561424848,'root','2019-04-04 11:20:04',211,1),(4,4,'4','mifosx-core-reports-utf8','SQL','V4__mifosx-core-reports-utf8.sql',-1262708825,'root','2019-04-04 11:19:56',154,1),(40,40,'40','add permissions for accounting rule','SQL','V40__add_permissions_for_accounting_rule.sql',-1703106875,'root','2019-04-04 11:20:04',0,1),(41,41,'41','group-summary-reports','SQL','V41__group-summary-reports.sql',1384609136,'root','2019-04-04 11:20:04',15,1),(42,42,'42','Add default value for id for acc accounting rule','SQL','V42__Add_default_value_for_id_for_acc_accounting_rule.sql',298600221,'root','2019-04-04 11:20:04',79,1),(43,43,'43','accounting-for-savings','SQL','V43__accounting-for-savings.sql',1994927835,'root','2019-04-04 11:20:05',168,1),(44,44,'44','document-increase-size-of-column-type','SQL','V44__document-increase-size-of-column-type.sql',1988036274,'root','2019-04-04 11:20:05',81,1),(45,45,'45','create acc rule tags table','SQL','V45__create_acc_rule_tags_table.sql',-76884353,'root','2019-04-04 11:20:05',47,1),(46,46,'46','extend datatables api','SQL','V46__extend_datatables_api.sql',-1371499241,'root','2019-04-04 11:20:05',16,1),(47,47,'47','staff-hierarchy-link-to-users','SQL','V47__staff-hierarchy-link-to-users.sql',-1745268815,'root','2019-04-04 11:20:05',241,1),(48,48,'48','adding-S3-Support','SQL','V48__adding-S3-Support.sql',-1069415834,'root','2019-04-04 11:20:06',417,1),(49,49,'49','track-loan-charge-payment-transactions','SQL','V49__track-loan-charge-payment-transactions.sql',1658312740,'root','2019-04-04 11:20:06',61,1),(5,5,'5','update-savings-product-and-account-tables','SQL','V5__update-savings-product-and-account-tables.sql',378848888,'root','2019-04-04 11:19:56',119,1),(50,50,'50','add-grace-settings-to-loan-product','SQL','V50__add-grace-settings-to-loan-product.sql',1919481959,'root','2019-04-04 11:20:06',134,1),(366,360,'5000','Daily Teller Cash Report pentaho','SQL','V5000__Daily_Teller_Cash_Report_pentaho.sql',1852890841,'root','2019-04-11 07:59:08',125,1),(51,51,'51','track-additional-details-related-to-installment-performance','SQL','V51__track-additional-details-related-to-installment-performance.sql',508807417,'root','2019-04-04 11:20:07',127,1),(52,52,'52','add boolean support cols to acc accounting rule','SQL','V52__add_boolean_support_cols_to_acc_accounting_rule.sql',-1786009479,'root','2019-04-04 11:20:07',115,1),(53,53,'53','track-advance-and-late-payments-on-installment','SQL','V53__track-advance-and-late-payments-on-installment.sql',156397562,'root','2019-04-04 11:20:07',69,1),(54,54,'54','charge-to-income-account-mappings','SQL','V54__charge-to-income-account-mappings.sql',1497405377,'root','2019-04-04 11:20:07',36,1),(55,55,'55','add-additional-transaction-processing-strategies','SQL','V55__add-additional-transaction-processing-strategies.sql',-460619563,'root','2019-04-04 11:20:07',73,1),(56,56,'56','track-overpaid-amount-on-loans','SQL','V56__track-overpaid-amount-on-loans.sql',382763118,'root','2019-04-04 11:20:07',60,1),(57,57,'57','add default values to debit and credit accounts acc accounting rule','SQL','V57__add_default_values_to_debit_and_credit_accounts_acc_accounting_rule.sql',-1568824194,'root','2019-04-04 11:20:08',69,1),(58,58,'58','create-holiday-tables changed','SQL','V58__create-holiday-tables_changed.sql',-962646632,'root','2019-04-04 11:20:08',75,1),(59,59,'59','add group roles schema and permissions','SQL','V59__add_group_roles_schema_and_permissions.sql',368364301,'root','2019-04-04 11:20:08',78,1),(6,6,'6','add min max principal column to loan','SQL','V6__add_min_max_principal_column_to_loan.sql',70722042,'root','2019-04-04 11:19:57',160,1),(60,60,'60','quipo dashboard reports','SQL','V60__quipo_dashboard_reports.sql',2046253614,'root','2019-04-04 11:20:08',32,1),(61,61,'61','txn running balance example','SQL','V61__txn_running_balance_example.sql',-450363348,'root','2019-04-04 11:20:08',15,1),(62,62,'62','add staff id to m client changed','SQL','V62__add_staff_id_to_m_client_changed.sql',1164419989,'root','2019-04-04 11:20:09',82,1),(63,63,'63','add sync disbursement with meeting column to loan','SQL','V63__add_sync_disbursement_with_meeting_column_to_loan.sql',-947659725,'root','2019-04-04 11:20:09',95,1),(64,64,'64','add permission for assign staff','SQL','V64__add_permission_for_assign_staff.sql',-1794585739,'root','2019-04-04 11:20:09',15,1),(65,65,'65','fix rupee symbol issues','SQL','V65__fix_rupee_symbol_issues.sql',-1194352396,'root','2019-04-04 11:20:09',63,1),(66,66,'66','client close functionality','SQL','V66__client_close_functionality.sql',1532902384,'root','2019-04-04 11:20:09',148,1),(67,67,'67','loans in advance table','SQL','V67__loans_in_advance_table.sql',300209608,'root','2019-04-04 11:20:09',32,1),(68,68,'68','quipo dashboard reports updated','SQL','V68__quipo_dashboard_reports_updated.sql',-1147318254,'root','2019-04-04 11:20:10',47,1),(69,69,'69','loans in advance initialise','SQL','V69__loans_in_advance_initialise.sql',-2069978996,'root','2019-04-04 11:20:10',31,1),(7,7,'7','remove read makerchecker permission','SQL','V7__remove_read_makerchecker_permission.sql',-326347048,'root','2019-04-04 11:19:57',32,1),(70,70,'70','quipo program detail query fix','SQL','V70__quipo_program_detail_query_fix.sql',-1017138863,'root','2019-04-04 11:20:10',32,1),(71,71,'71','insert reschedule repayment to configuration','SQL','V71__insert_reschedule_repayment_to_configuration.sql',-11153805,'root','2019-04-04 11:20:10',0,1),(72,72,'72','add m loan counter changes','SQL','V72__add_m_loan_counter_changes.sql',204127945,'root','2019-04-04 11:20:10',125,1),(73,73,'73','add repayments rescheduled to and processed column to holiday','SQL','V73__add_repayments_rescheduled_to_and_processed_column_to_holiday.sql',1638728810,'root','2019-04-04 11:20:10',78,1),(74,74,'74','alter m loan counter table add group','SQL','V74__alter_m_loan_counter_table_add_group.sql',-1938854244,'root','2019-04-04 11:20:10',78,1),(75,75,'75','add reschedule-repayments-on-holidays to configuration','SQL','V75__add_reschedule-repayments-on-holidays_to_configuration.sql',-2118763844,'root','2019-04-04 11:20:11',0,1),(76,76,'76','rename permission grouping','SQL','V76__rename_permission_grouping.sql',-53740793,'root','2019-04-04 11:20:11',16,1),(77,77,'77','alter m product loan changes','SQL','V77__alter_m_product_loan_changes.sql',-1791822757,'root','2019-04-04 11:20:11',63,1),(78,78,'78','breakdown portfolio grouping','SQL','V78__breakdown_portfolio_grouping.sql',-1667180527,'root','2019-04-04 11:20:11',0,1),(79,79,'79','schedule jobs tables','SQL','V79__schedule_jobs_tables.sql',-803375537,'root','2019-04-04 11:20:11',94,1),(8,8,'8','deposit-transaction-permissions-if-they-exist','SQL','V8__deposit-transaction-permissions-if-they-exist.sql',1336264325,'root','2019-04-04 11:19:57',0,1),(80,80,'80','schedule jobs tables updates','SQL','V80__schedule_jobs_tables_updates.sql',743488132,'root','2019-04-04 11:20:12',297,1),(81,81,'81','savings related changes','SQL','V81__savings_related_changes.sql',570043414,'root','2019-04-04 11:20:12',375,1),(82,82,'82','schedule jobs tables updates for running status','SQL','V82__schedule_jobs_tables_updates_for_running_status.sql',333776790,'root','2019-04-04 11:20:12',151,1),(83,83,'83','non-working-days-table','SQL','V83__non-working-days-table.sql',1562001980,'root','2019-04-04 11:20:12',50,1),(84,84,'84','undo savings transaction permission','SQL','V84__undo_savings_transaction_permission.sql',-1532397221,'root','2019-04-04 11:20:13',16,1),(85,85,'85','product mix related changes','SQL','V85__product_mix_related_changes.sql',650997088,'root','2019-04-04 11:20:13',99,1),(86,86,'86','update-working-days','SQL','V86__update-working-days.sql',1454599851,'root','2019-04-04 11:20:13',31,1),(87,87,'87','add permission for scheduler','SQL','V87__add_permission_for_scheduler.sql',-143804840,'root','2019-04-04 11:20:13',15,1),(88,88,'88','added update constrain for scheduler jobs','SQL','V88__added_update_constrain_for_scheduler_jobs.sql',-1721849104,'root','2019-04-04 11:20:13',62,1),(89,89,'89','added scheduler group','SQL','V89__added_scheduler_group.sql',870811111,'root','2019-04-04 11:20:13',62,1),(9,9,'9','add min max constraint column to loan loanproduct','SQL','V9__add_min_max_constraint_column_to_loan_loanproduct.sql',1914461568,'root','2019-04-04 11:19:57',340,1),(90,90,'90','client performance history reports','SQL','V90__client_performance_history_reports.sql',1339964541,'root','2019-04-04 11:20:13',15,1),(91,91,'91','apply annual fees permission','SQL','V91__apply_annual_fees_permission.sql',1903694379,'root','2019-04-04 11:20:14',15,1),(92,92,'91.1','configuration settings for holiday and non workingday','SQL','V91_1__configuration_settings_for_holiday_and_non_workingday.sql',550696268,'root','2019-04-04 11:20:14',15,1),(93,93,'92','group center assign staff permission','SQL','V92__group_center_assign_staff_permission.sql',-1720945560,'root','2019-04-04 11:20:14',16,1),(94,94,'93','loan transaction external id','SQL','V93__loan_transaction_external_id.sql',1883193852,'root','2019-04-04 11:20:14',78,1),(95,95,'94','added savings accont type','SQL','V94__added_savings_accont type.sql',900679016,'root','2019-04-04 11:20:14',63,1),(96,96,'95','batch job postInterest','SQL','V95__batch_job_postInterest.sql',1639975057,'root','2019-04-04 11:20:14',15,1),(97,97,'96','savings accounts transfers table','SQL','V96__savings_accounts_transfers_table.sql',670361759,'root','2019-04-04 11:20:15',141,1),(98,98,'97','add permission for adjust savings transaction','SQL','V97__add_permission_for_adjust_savings_transaction.sql',-1776198278,'root','2019-04-04 11:20:15',31,1),(99,99,'98','added currency roundof for multipleof','SQL','V98__added_currency_roundof_for_multipleof.sql',-1419021504,'root','2019-04-04 11:20:15',449,1);
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_campaign`
--

DROP TABLE IF EXISTS `sms_campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_campaign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_name` varchar(100) NOT NULL,
  `campaign_type` int(11) NOT NULL,
  `campaign_trigger_type` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `provider_id` bigint(20) DEFAULT NULL,
  `param_value` text,
  `status_enum` int(11) NOT NULL,
  `message` text NOT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `next_trigger_date` datetime DEFAULT NULL,
  `last_trigger_date` datetime DEFAULT NULL,
  `recurrence_start_date` datetime DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT '1',
  `is_notification` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `sms_campaign_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `stretchy_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_campaign`
--

LOCK TABLES `sms_campaign` WRITE;
/*!40000 ALTER TABLE `sms_campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_messages_outbound`
--

DROP TABLE IF EXISTS `sms_messages_outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_messages_outbound` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '100',
  `mobile_no` varchar(50) DEFAULT NULL,
  `message` varchar(1000) NOT NULL,
  `campaign_id` bigint(20) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `delivered_on_date` datetime DEFAULT NULL,
  `is_notification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKGROUP000000001` (`group_id`),
  KEY `FKCLIENT00000001` (`client_id`),
  KEY `FKSTAFF000000001` (`staff_id`),
  KEY `FKCAMPAIGN00000001` (`campaign_id`),
  CONSTRAINT `FKCAMPAIGN00000001` FOREIGN KEY (`campaign_id`) REFERENCES `sms_campaign` (`id`),
  CONSTRAINT `FKCLIENT00000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKGROUP000000001` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FKSTAFF000000001` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_messages_outbound`
--

LOCK TABLES `sms_messages_outbound` WRITE;
/*!40000 ALTER TABLE `sms_messages_outbound` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_messages_outbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_parameter`
--

DROP TABLE IF EXISTS `stretchy_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(45) NOT NULL,
  `parameter_variable` varchar(45) DEFAULT NULL,
  `parameter_label` varchar(45) NOT NULL,
  `parameter_displayType` varchar(45) NOT NULL,
  `parameter_FormatType` varchar(10) NOT NULL,
  `parameter_default` varchar(45) NOT NULL,
  `special` varchar(1) DEFAULT NULL,
  `selectOne` varchar(1) DEFAULT NULL,
  `selectAll` varchar(1) DEFAULT NULL,
  `parameter_sql` text,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`parameter_name`),
  KEY `fk_stretchy_parameter_001_idx` (`parent_id`),
  CONSTRAINT `fk_stretchy_parameter_001` FOREIGN KEY (`parent_id`) REFERENCES `stretchy_parameter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_parameter`
--

LOCK TABLES `stretchy_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_parameter` VALUES (1,'startDateSelect','startDate','startDate','date','date','today',NULL,NULL,NULL,NULL,NULL),(2,'endDateSelect','endDate','endDate','date','date','today',NULL,NULL,NULL,NULL,NULL),(3,'obligDateTypeSelect','obligDateType','obligDateType','select','number','0',NULL,NULL,NULL,'select * from\r\n(select 1 as id, \"Closed\" as `name` union all\r\nselect 2, \"Disbursal\" ) x\r\norder by x.`id`',NULL),(5,'OfficeIdSelectOne','officeId','Office','select','number','0',NULL,'Y',NULL,'select id, \r\nconcat(substring(\"........................................\", 1, \r\n   \n\n((LENGTH(`hierarchy`) - LENGTH(REPLACE(`hierarchy`, \'.\', \'\')) - 1) * 4)), \r\n   `name`) as tc\r\nfrom m_office\r\nwhere hierarchy like concat\n\n(\'${currentUserHierarchy}\', \'%\')\r\norder by hierarchy',NULL),(6,'loanOfficerIdSelectAll','loanOfficerId','Loan Officer','select','number','0',NULL,NULL,'Y','(select lo.id, lo.display_name as `Name` \r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\njoin m_staff lo on lo.office_id = ounder.id\r\nwhere lo.is_loan_officer = true\r\nand o.id = ${officeId})\r\nunion all\r\n(select -10, \'-\')\r\norder by 2',5),(10,'currencyIdSelectAll','currencyId','Currency','select','number','0',NULL,NULL,'Y','select `code`, `name`\r\nfrom m_organisation_currency\r\norder by `code`',NULL),(20,'fundIdSelectAll','fundId','Fund','select','number','0',NULL,NULL,'Y','(select id, `name`\r\nfrom m_fund)\r\nunion all\r\n(select -10, \'-\')\r\norder by 2',NULL),(25,'loanProductIdSelectAll','loanProductId','Product','select','number','0',NULL,NULL,'Y','select p.id, p.`name`\r\nfrom m_product_loan p\r\nwhere (p.currency_code = \'${currencyId}\' or \'-1\'= \'${currencyId}\')\r\norder by 2',10),(26,'loanPurposeIdSelectAll','loanPurposeId','Loan Purpose','select','number','0',NULL,NULL,'Y','select -10 as id, \'-\' as code_value\r\nunion all\r\nselect * from (select v.id, v.code_value\r\nfrom m_code c\r\njoin m_code_value v on v.code_id = c.id\r\nwhere c.code_name = \"loanPurpose\"\r\norder by v.order_position)  x',NULL),(100,'parTypeSelect','parType','parType','select','number','0',NULL,NULL,NULL,'select * from\r\n(select 1 as id, \"Principal Only\" as `name` union all\r\nselect 2, \"Principal + Interest\" union all\r\nselect 3, \"Principal + Interest + Fees\" union all\r\nselect 4, \"Principal + Interest + Fees + Penalties\") x\r\norder by x.`id`',NULL),(1001,'FullReportList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.id as report_id, r.report_name, r.report_type, r.report_subtype, r.report_category,\nrp.id as parameter_id, rp.report_parameter_name, p.parameter_name\n  from stretchy_report r\n  left join stretchy_report_parameter rp on rp.report_id = r.id \n  left join stretchy_parameter p on p.id = rp.parameter_id\n  where r.use_report is true and r.self_service_user_report = \'${isSelfServiceUser}\'\n  and exists\n  ( select \'f\'\n  from m_appuser_role ur \n  join m_role r on r.id = ur.role_id\n  join m_role_permission rp on rp.role_id = r.id\n  join m_permission p on p.id = rp.permission_id\n  where ur.appuser_id = ${currentUserId}\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = concat(\"READ_\", r.report_name)) )\n  order by r.report_category, r.report_name, rp.id',NULL),(1002,'FullParameterList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select sp.parameter_name, sp.parameter_variable, sp.parameter_label, sp.parameter_displayType, \r sp.parameter_FormatType, sp.parameter_default, sp.selectOne,  sp.selectAll, spp.parameter_name as parentParameterName\r from stretchy_parameter sp\r left join stretchy_parameter spp on spp.id = sp.parent_id\r where sp.special is null\r and exists \r   (select \'f\' \r  from stretchy_report sr\r   join stretchy_report_parameter srp on srp.report_id = sr.id   and sr.self_service_user_report = \'${isSelfServiceUser}\'\r   where sr.report_name in(${reportListing})\r   and srp.parameter_id = sp.id\r  )\r order by sp.id',NULL),(1003,'reportCategoryList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.id as report_id, r.report_name, r.report_type, r.report_subtype, r.report_category,\n  rp.id as parameter_id, rp.report_parameter_name, p.parameter_name\n  from stretchy_report r\n  left join stretchy_report_parameter rp on rp.report_id = r.id\n  left join stretchy_parameter p on p.id = rp.parameter_id\n  where r.report_category = \'${reportCategory}\'\n  and r.use_report is true and r.self_service_user_report = \'${isSelfServiceUser}\'  \n  and exists\n  (select \'f\'\n  from m_appuser_role ur \n  join m_role r on r.id = ur.role_id\n  join m_role_permission rp on rp.role_id = r.id\n  join m_permission p on p.id = rp.permission_id\n  where ur.appuser_id = ${currentUserId}\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = concat(\"READ_\", r.report_name)) )\n  order by r.report_category, r.report_name, rp.id',NULL),(1004,'selectAccount','accountNo','Enter Account No','text','string','n/a',NULL,NULL,NULL,NULL,NULL),(1005,'savingsProductIdSelectAll','savingsProductId','Product','select','number','0',NULL,NULL,'Y','select p.id, p.`name`\r\nfrom m_savings_product p\r\norder by 2',NULL),(1006,'transactionId','transactionId','transactionId','text','string','n/a',NULL,NULL,NULL,NULL,NULL),(1007,'selectCenterId','centerId','Enter Center Id','text','string','n/a',NULL,NULL,NULL,NULL,NULL),(1008,'SelectGLAccountNO','GLAccountNO','GLAccountNO','select','number','0',NULL,NULL,NULL,'select id aid,name aname\r\nfrom acc_gl_account',NULL),(1009,'asOnDate','asOn','As On','date','date','today',NULL,NULL,NULL,NULL,NULL),(1010,'SavingsAccountSubStatus','subStatus','SavingsAccountDormancyStatus','select','number','100',NULL,NULL,NULL,'select * from\r\n(select 100 as id, \"Inactive\" as name  union all\r\nselect 200 as id, \"Dormant\" as  name union all \r\nselect 300 as id, \"Escheat\" as name) x\r\norder by x.`id`',NULL),(1011,'cycleXSelect','cycleX','Cycle X Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1012,'cycleYSelect','cycleY','Cycle Y Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1013,'fromXSelect','fromX','From X Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1014,'toYSelect','toY','To Y Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1015,'overdueXSelect','overdueX','Overdue X Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1016,'overdueYSelect','overdueY','Overdue Y Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1017,'DefaultLoan','loanId','Loan','none','number','-1',NULL,NULL,'Y','select ml.id \nfrom m_loan ml \nleft join m_client mc on mc.id = ml.client_id \nleft join m_office mo on mo.id = mc.office_id \nwhere mo.id = ${officeId} or ${officeId} = -1',5),(1018,'DefaultClient','clientId','Client','none','number','-1',NULL,NULL,'Y','select mc.id \nfrom m_client mc\n left join m_office on mc.office_id = mo.id\n where mo.id = ${officeId} or ${officeId} = -1',5),(1019,'DefaultGroup','groupId','Group','none','number','-1',NULL,NULL,'Y','select mg.id \nfrom m_group mg\nleft join m_office mo on mg.office_id = mo.id\nwhere mo.id = ${officeId} or ${officeId} = -1',5),(1020,'SelectLoanType','loanType','Loan Type','select','number','-1',NULL,NULL,'Y','select\nenum_id as id,\nenum_value as value\nfrom r_enum_value\nwhere enum_name = \'loan_type_enum\'',NULL),(1021,'DefaultSavings','savingsId','Savings','none','number','-1',NULL,NULL,'Y',NULL,5),(1022,'DefaultSavingsTransactionId','savingsTransactionId','Savings Transaction','none','number','-1',NULL,NULL,'Y',NULL,5),(1023,'tellerIdSelectOne','tellerId','Teller','select','number','0',NULL,'Y','N','select id, name from m_tellers where office_id = ${officeId}',5),(1024,'cashierIdSelectOne','cashierId','Cashier','select','number','0',NULL,'Y','N','select c.id, s.display_name from m_cashiers as c left join m_staff as s on c.staff_id = s.id where c.teller_id = ${tellerId}',1023),(1025,'currencyCodeSelectOne','currencyCode','Currency','select','string','0',NULL,'Y','N','select `code`, `name` from m_organisation_currency order by `code`',NULL);
/*!40000 ALTER TABLE `stretchy_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report`
--

DROP TABLE IF EXISTS `stretchy_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) NOT NULL,
  `report_type` varchar(20) NOT NULL,
  `report_subtype` varchar(20) DEFAULT NULL,
  `report_category` varchar(45) DEFAULT NULL,
  `report_sql` text,
  `description` text,
  `core_report` tinyint(1) DEFAULT '0',
  `use_report` tinyint(1) DEFAULT '0',
  `self_service_user_report` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_name_UNIQUE` (`report_name`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report`
--

LOCK TABLES `stretchy_report` WRITE;
/*!40000 ALTER TABLE `stretchy_report` DISABLE KEYS */;
INSERT INTO `stretchy_report` VALUES (1,'Client Listing','Table',NULL,'Client','select\nconcat(repeat(\"..\",\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\n c.account_no as \"Client Account No.\",\nc.display_name as \"Name\",\nr.enum_message_property as \"Status\",\nc.activation_date as \"Activation\", c.external_id as \"External Id\"\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\nleft join r_enum_value r on r.enum_name = \'status_enum\' and r.enum_id = c.status_enum\nwhere o.id = ${officeId}\norder by ounder.hierarchy, c.account_no','Individual Client Report\r\n\r\nLists the small number of defined fields on the client table.  Would expect to copy this \n\nreport and add any \'one to one\' additional data for specific tenant needs.\r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for \n\nlarger ones.  Depending on how many columns are displayed, there is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t \n\nhave that client browser/memory impact).',1,1,0),(2,'Client Loans Listing','Table',NULL,'Client','select\nconcat(repeat(\"..\",\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\", c.account_no as \"Client Account No.\",\nc.display_name as \"Name\",\nr.enum_message_property as \"Client Status\",\nlo.display_name as \"Loan Officer\", l.account_no as \"Loan Account No.\", l.external_id as \"External Id\", p.name as Loan, st.enum_message_property as \"Status\",\nf.`name` as Fund, purp.code_value as \"Loan Purpose\",\nifnull(cur.display_symbol, l.currency_code) as Currency,\nl.principal_amount, l.arrearstolerance_amount as \"Arrears Tolerance Amount\",\nl.number_of_repayments as \"Expected No. Repayments\",\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\",\nl.nominal_interest_rate_per_period as \"Nominal Interest Rate Per Period\",\nipf.enum_message_property as \"Interest Rate Frequency\",\nim.enum_message_property as \"Interest Method\",\nicp.enum_message_property as \"Interest Calculated in Period\",\nl.term_frequency as \"Term Frequency\",\ntf.enum_message_property as \"Term Frequency Period\",\nl.repay_every as \"Repayment Frequency\",\nrf.enum_message_property as \"Repayment Frequency Period\",\nam.enum_message_property as \"Amortization\",\nl.total_charges_due_at_disbursement_derived as \"Total Charges Due At Disbursement\",\ndate(l.submittedon_date) as Submitted, date(l.approvedon_date) Approved, l.expected_disbursedon_date As \"Expected Disbursal\",\ndate(l.expected_firstrepaymenton_date) as \"Expected First Repayment\",\ndate(l.interest_calculated_from_date) as \"Interest Calculated From\" ,\ndate(l.disbursedon_date) as Disbursed,\ndate(l.expected_maturedon_date) \"Expected Maturity\",\ndate(l.maturedon_date) as \"Matured On\", date(l.closedon_date) as Closed,\ndate(l.rejectedon_date) as Rejected, date(l.rescheduledon_date) as Rescheduled,\ndate(l.withdrawnon_date) as Withdrawn, date(l.writtenoffon_date) \"Written Off\"\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\nleft join r_enum_value r on r.enum_name = \'status_enum\'\n and r.enum_id = c.status_enum\nleft join m_loan l on l.client_id = c.id\nleft join m_staff lo on lo.id = l.loan_officer_id\nleft join m_product_loan p on p.id = l.product_id\nleft join m_fund f on f.id = l.fund_id\nleft join r_enum_value st on st.enum_name = \"loan_status_id\" and st.enum_id = l.loan_status_id\nleft join r_enum_value ipf on ipf.enum_name = \"interest_period_frequency_enum\"\n and ipf.enum_id = l.interest_period_frequency_enum\nleft join r_enum_value im on im.enum_name = \"interest_method_enum\"\n and im.enum_id = l.interest_method_enum\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\"\n and tf.enum_id = l.term_period_frequency_enum\nleft join r_enum_value icp on icp.enum_name = \"interest_calculated_in_period_enum\"\n and icp.enum_id = l.interest_calculated_in_period_enum\nleft join r_enum_value rf on rf.enum_name = \"repayment_period_frequency_enum\"\n and rf.enum_id = l.repayment_period_frequency_enum\nleft join r_enum_value am on am.enum_name = \"amortization_method_enum\"\n and am.enum_id = l.amortization_method_enum\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\nleft join m_currency cur on cur.code = l.currency_code\nwhere o.id = ${officeId}\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\norder by ounder.hierarchy, 2 , l.id','Individual Client Report\r\n\r\nPretty \n\nwide report that lists the basic details of client loans.  \r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for larger ones.  \n\nThere is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t have that client browser/memory impact).',1,1,0),(5,'Loans Awaiting Disbursal','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client Account No\", c.display_name as \"Name\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund, ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nl.principal_amount as Principal,  \r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\",\r\ndate(l.approvedon_date) \"Approved\",\r\ndatediff(l.expected_disbursedon_date, curdate()) as \"Days to Disbursal\",\r\ndate(l.expected_disbursedon_date) \"Expected Disbursal\",\r\npurp.code_value as \"Loan Purpose\",\r\n lo.display_name as \"Loan Officer\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = l.term_period_frequency_enum\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\norder by ounder.hierarchy, datediff(l.expected_disbursedon_date, curdate()),  c.account_no','Individual Client Report',1,1,0),(6,'Loans Awaiting Disbursal Summary','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\npl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  f.`name` as Fund,\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`\r\norder by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`','Individual Client Report',1,1,0),(7,'Loans Awaiting Disbursal Summary by Month','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\npl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nyear(l.expected_disbursedon_date) as \"Year\", \r\nmonthname(l.expected_disbursedon_date) as \"Month\",\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)\r\norder by ounder.hierarchy, pl.`name`, l.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)','Individual Client Report',1,1,0),(8,'Loans Pending Approval','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client Account No.\", c.display_name as \"Client Name\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  pl.`name` as \"Product\", \r\nl.account_no as \"Loan Account No.\", \r\nl.principal_amount as \"Loan Amount\", \r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.annual_nominal_interest_rate as \" Annual \n\nNominal Interest Rate\", \r\ndatediff(curdate(), l.submittedon_date) \"Days Pending Approval\", \r\npurp.code_value as \"Loan Purpose\",\r\nlo.display_name as \"Loan Officer\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = l.term_period_frequency_enum\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 100 /*Submitted and awaiting approval */\r\norder by ounder.hierarchy, l.submittedon_date,  l.account_no','Individual Client Report',1,1,0),(11,'Active Loans - Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. loans_in_arrears_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select ounder.id as branch,\r\nifnull(cur.display_symbol, l.currency_code) as currency,\r\ncount(distinct(c.id)) as client_count, \r\ncount(distinct(l.id)) as  active_loan_count,\r\ncount(distinct(if(laa.loan_id is not null,  l.id, null)  )) as loans_in_arrears_count,\r\n\r\nsum(l.principal_disbursed_derived) as principal,\r\nsum(l.principal_repaid_derived) as principal_repaid,\r\nsum(l.principal_outstanding_derived) as principal_outstanding,\r\nsum(laa.principal_overdue_derived) as principal_overdue,\r\n\r\nsum(l.interest_charged_derived) as interest,\r\nsum(l.interest_repaid_derived) as interest_repaid,\r\nsum(l.interest_outstanding_derived) as interest_outstanding,\r\nsum(laa.interest_overdue_derived) as interest_overdue,\r\n\r\nsum(l.fee_charges_charged_derived) as fees,\r\nsum(l.fee_charges_repaid_derived) as fees_repaid,\r\nsum(l.fee_charges_outstanding_derived)  as fees_outstanding,\r\nsum(laa.fee_charges_overdue_derived) as fees_overdue,\r\n\r\nsum(l.penalty_charges_charged_derived) as penalties,\r\nsum(l.penalty_charges_repaid_derived) as penalties_repaid,\r\nsum(l.penalty_charges_outstanding_derived) as penalties_outstanding,\r\nsum(laa.penalty_charges_overdue_derived) as penalties_overdue\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency',NULL,1,1,0),(12,'Active Loans - Details','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", \r\nc.display_name as \"Client\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\ndate(l.expected_maturedon_date) as \"Expected Matured On\",\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.principal_outstanding_derived as \"Principal Outstanding\",\r\nlaa.principal_overdue_derived as \"Principal Overdue\",\r\n\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.interest_outstanding_derived as \"Interest Outstanding\",\r\nlaa.interest_overdue_derived as \"Interest Overdue\",\r\n\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.fee_charges_outstanding_derived  as \"Fees Outstanding\",\r\nlaa.fee_charges_overdue_derived as \"Fees Overdue\",\r\n\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nl.penalty_charges_outstanding_derived as \"Penalties Outstanding\",\r\npenalty_charges_overdue_derived as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1,0),(13,'Obligation Met Loans Details','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nc.account_no as \"Client Account No.\", c.display_name as \"Client\",\r\nl.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.total_repayment_derived  as \"Total Repaid\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", \r\ndate(l.closedon_date) as \"Closed\",\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nlo.display_name as \"Loan Officer\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand (case\r\n	when ${obligDateType} = 1 then\r\n    l.closedon_date between \'${startDate}\' and \'${endDate}\'\r\n	when ${obligDateType} = 2 then\r\n    l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\n	else 1 = 1\r\n	end)\r\nand l.loan_status_id = 600\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1,0),(14,'Obligation Met Loans Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\ncount(distinct(c.id)) as \"No. of Clients\",\r\ncount(distinct(l.id)) as \"No. of Loans\",\r\nsum(l.principal_amount) as \"Total Loan Amount\", \r\nsum(l.principal_repaid_derived) as \"Total Principal Repaid\",\r\nsum(l.interest_repaid_derived) as \"Total Interest Repaid\",\r\nsum(l.fee_charges_repaid_derived) as \"Total Fees Repaid\",\r\nsum(l.penalty_charges_repaid_derived) as \"Total Penalties Repaid\",\r\nsum(l.interest_waived_derived) as \"Total Interest Waived\",\r\nsum(l.fee_charges_waived_derived) as \"Total Fees Waived\",\r\nsum(l.penalty_charges_waived_derived) as \"Total Penalties Waived\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand (case\r\n	when ${obligDateType} = 1 then\r\n    l.closedon_date between \'${startDate}\' and \'${endDate}\'\r\n	when ${obligDateType} = 2 then\r\n    l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\n	else 1 = 1\r\n	end)\r\nand l.loan_status_id = 600\r\ngroup by ounder.hierarchy, l.currency_code\r\norder by ounder.hierarchy, l.currency_code','Individual Client \n\nReport',1,1,0),(15,'Portfolio at Risk','Table',NULL,'Loan','select x.Currency, x.`Principal Outstanding`, x.`Principal Overdue`, x.`Interest Outstanding`, x.`Interest Overdue`, \r\nx.`Fees Outstanding`, x.`Fees Overdue`, x.`Penalties Outstanding`, x.`Penalties Overdue`,\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.`Principal Overdue` * 100) / x.`Principal Outstanding`, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding`), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding`), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue` + x.`Penalties Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding` + x.`Penalties Overdue`), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from \r\n(select  ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nsum(l.principal_outstanding_derived) as \"Principal Outstanding\",\r\nsum(laa.principal_overdue_derived) as \"Principal Overdue\",\r\n\r\nsum(l.interest_outstanding_derived) as \"Interest Outstanding\",\r\nsum(laa.interest_overdue_derived) as \"Interest Overdue\",\r\n\r\nsum(l.fee_charges_outstanding_derived)  as \"Fees Outstanding\",\r\nsum(laa.fee_charges_overdue_derived) as \"Fees Overdue\",\r\n\r\nsum(penalty_charges_outstanding_derived) as \"Penalties Outstanding\",\r\nsum(laa.penalty_charges_overdue_derived) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by l.currency_code\r\norder by l.currency_code) x','Covers all loans.\r\n\r\nFor larger MFIs … we should add some derived fields on loan (or a 1:1 loan related table like mifos 2.x does)\r\nPrinciple, Interest, Fees, Penalties Outstanding and Overdue (possibly waived and written off too)',1,1,0),(16,'Portfolio at Risk by Branch','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\",\r\nx.Currency, x.`Principal Outstanding`, x.`Principal Overdue`, x.`Interest Outstanding`, x.`Interest Overdue`, \r\nx.`Fees Outstanding`, x.`Fees Overdue`, x.`Penalties Outstanding`, x.`Penalties Overdue`,\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.`Principal Overdue` * 100) / x.`Principal Outstanding`, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding`), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding`), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue` + x.`Penalties Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding` + x.`Penalties Overdue`), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select  ounder.id as \"branch\", ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\n\r\nsum(l.principal_outstanding_derived) as \"Principal Outstanding\",\r\nsum(laa.principal_overdue_derived) as \"Principal Overdue\",\r\n\r\nsum(l.interest_outstanding_derived) as \"Interest Outstanding\",\r\nsum(laa.interest_overdue_derived) as \"Interest Overdue\",\r\n\r\nsum(l.fee_charges_outstanding_derived)  as \"Fees Outstanding\",\r\nsum(laa.fee_charges_overdue_derived) as \"Fees Overdue\",\r\n\r\nsum(penalty_charges_outstanding_derived) as \"Penalties Outstanding\",\r\nsum(laa.penalty_charges_overdue_derived) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency','Covers all loans.\r\n\r\nFor larger MFIs … we should add some derived fields on loan (or a 1:1 loan related table like mifos 2.x does)\r\nPrinciple, Interest, Fees, Penalties Outstanding and Overdue (possibly waived and written off too)',1,1,0),(20,'Funds Disbursed Between Dates Summary','Table',NULL,'Fund','select ifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, \r\nround(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office ounder \r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\ngroup by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)\r\norder by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1,0),(21,'Funds Disbursed Between Dates Summary by Office','Table',NULL,'Fund','select \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\n \n\nifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, round(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office o\r\n\n\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c \n\non c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\n\n\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand o.id = ${officeId}\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand \n\n(l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\ngroup by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, \n\nl.currency_code)\r\norder by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1,0),(48,'Balance Sheet','Pentaho',NULL,'Accounting',NULL,'Balance Sheet',1,1,0),(49,'Income Statement','Pentaho',NULL,'Accounting',NULL,'Profit and Loss Statement',1,1,0),(50,'Trial Balance','Pentaho',NULL,'Accounting',NULL,'Trial Balance Report',1,1,0),(51,'Written-Off Loans','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nc.account_no as \"Client Account No.\",\r\nc.display_name AS \'Client Name\',\r\nml.account_no AS \'Loan Account No.\',\r\nmpl.name AS \'Product Name\',\r\nml.disbursedon_date AS \'Disbursed Date\',\r\nlt.transaction_date AS \'Written Off date\',\r\nml.principal_amount as \"Loan Amount\",\r\nifnull(lt.principal_portion_derived, 0) AS \'Written-Off Principal\',\r\nifnull(lt.interest_portion_derived, 0) AS \'Written-Off Interest\',\r\nifnull(lt.fee_charges_portion_derived,0) AS \'Written-Off Fees\',\r\nifnull(lt.penalty_charges_portion_derived,0) AS \'Written-Off Penalties\',\r\nn.note AS \'Reason For Write-Off\',\r\nIFNULL(ms.display_name,\'-\') AS \'Loan Officer Name\'\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan ml ON ml.client_id = c.id\r\nJOIN m_product_loan mpl ON mpl.id=ml.product_id\r\nLEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\nJOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nLEFT JOIN m_note n ON n.loan_transaction_id = lt.id\r\nLEFT JOIN m_currency cur on cur.code = ml.currency_code\r\nWHERE lt.transaction_type_enum = 6 /*write-off */\r\nAND lt.is_reversed is false \r\nAND ml.loan_status_id=601\r\nAND o.id=${officeId}\r\nAND (mpl.id=${loanProductId} OR ${loanProductId}=-1)\r\nAND lt.transaction_date BETWEEN \'${startDate}\' AND \'${endDate}\'\r\nAND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\") \r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no','Individual Lending Report. Written Off Loans',1,1,0),(52,'Aging Detail','Table',NULL,'Loan','\r\nSELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nmc.account_no as \"Client Account No.\",\r\n 	mc.display_name AS \"Client Name\",\r\n 	ml.account_no AS \"Account Number\",\r\n 	ml.principal_amount AS \"Loan Amount\",\r\n ml.principal_disbursed_derived AS \"Original Principal\",\r\n ml.interest_charged_derived AS \"Original Interest\",\r\n ml.principal_repaid_derived AS \"Principal Paid\",\r\n ml.interest_repaid_derived AS \"Interest Paid\",\r\n laa.principal_overdue_derived AS \"Principal Overdue\",\r\n laa.interest_overdue_derived AS \"Interest Overdue\",\r\nDATEDIFF(CURDATE(), laa.overdue_since_date_derived) as \"Days in Arrears\",\r\n\r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<7, \'<1\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<8, \' 1\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<15,  \'2\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<22, \' 3\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<29, \' 4\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<36, \' 5\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<43, \' 6\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<50, \' 7\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<57, \' 8\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<64, \' 9\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<71, \'10\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<78, \'11\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<85, \'12\', \'12+\')))))))))))) )AS \"Weeks In Arrears Band\",\r\n\r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<31, \'0 - 30\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<61, \'30 - 60\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<91, \'60 - 90\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<181, \'90 - 180\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<361, \'180 - 360\', \r\n				 \'> 360\'))))) AS \"Days in Arrears Band\"\r\n\r\n	FROM m_office mo \r\n    JOIN m_office ounder ON ounder.hierarchy like concat(mo.hierarchy, \'%\')\r\n	        AND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n    INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n	    INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n	    INNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\n    INNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\n    left join m_currency cur on cur.code = ml.currency_code\r\n	WHERE ml.loan_status_id=300\r\n    AND mo.id=${officeId}\r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no\r\n','Loan arrears aging (Weeks)',1,1,0),(53,'Aging Summary (Arrears in Weeks)','Table',NULL,'Loan','SELECT \r\n  IFNULL(periods.currencyName, periods.currency) as currency, \r\n  periods.period_no \'Weeks In Arrears (Up To)\', \r\n  IFNULL(ars.loanId, 0) \'No Of Loans\', \r\n  IFNULL(ars.principal,0.0) \'Original Principal\', \r\n  IFNULL(ars.interest,0.0) \'Original Interest\', \r\n  IFNULL(ars.prinPaid,0.0) \'Principal Paid\', \r\n  IFNULL(ars.intPaid,0.0) \'Interest Paid\', \r\n  IFNULL(ars.prinOverdue,0.0) \'Principal Overdue\', \r\n  IFNULL(ars.intOverdue,0.0)\'Interest Overdue\'\r\nFROM \r\n	/* full table of aging periods/currencies used combo to ensure each line represented */\r\n  (SELECT curs.code as currency, curs.name as currencyName, pers.* from\r\n	(SELECT \'On Schedule\' period_no,1 pid UNION\r\n		SELECT \'1\',2 UNION\r\n		SELECT \'2\',3 UNION\r\n		SELECT \'3\',4 UNION\r\n		SELECT \'4\',5 UNION\r\n		SELECT \'5\',6 UNION\r\n		SELECT \'6\',7 UNION\r\n		SELECT \'7\',8 UNION\r\n		SELECT \'8\',9 UNION\r\n		SELECT \'9\',10 UNION\r\n		SELECT \'10\',11 UNION\r\n		SELECT \'11\',12 UNION\r\n		SELECT \'12\',13 UNION\r\n		SELECT \'12+\',14) pers,\r\n	(SELECT distinctrow moc.code, moc.name\r\n  	FROM m_office mo2\r\n   	INNER JOIN m_office ounder2 ON ounder2.hierarchy \r\n				LIKE CONCAT(mo2.hierarchy, \'%\')\r\nAND ounder2.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   	INNER JOIN m_client mc2 ON mc2.office_id=ounder2.id\r\n   	INNER JOIN m_loan ml2 ON ml2.client_id = mc2.id\r\n	INNER JOIN m_organisation_currency moc ON moc.code = ml2.currency_code\r\n	WHERE ml2.loan_status_id=300 /* active */\r\n	AND mo2.id=${officeId}\r\nAND (ml2.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")) curs) periods\r\n\r\n\r\nLEFT JOIN /* table of aging periods per currency with gaps if no applicable loans */\r\n(SELECT \r\n  	z.currency, z.arrPeriod, \r\n	COUNT(z.loanId) as loanId, SUM(z.principal) as principal, SUM(z.interest) as interest, \r\n	SUM(z.prinPaid) as prinPaid, SUM(z.intPaid) as intPaid, \r\n	SUM(z.prinOverdue) as prinOverdue, SUM(z.intOverdue) as intOverdue\r\nFROM\r\n	/*derived table just used to get arrPeriod value (was much slower to\r\n	duplicate calc of minOverdueDate in inner query)\r\nmight not be now with derived fields but didn’t check */\r\n	(SELECT x.loanId, x.currency, x.principal, x.interest, x.prinPaid, x.intPaid, x.prinOverdue, x.intOverdue,\r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<1, \'On Schedule\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<8, \'1\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<15, \'2\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<22, \'3\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<29, \'4\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<36, \'5\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<43, \'6\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<50, \'7\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<57, \'8\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<64, \'9\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<71, \'10\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<78, \'11\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<85, \'12\',\r\n				 \'12+\'))))))))))))) AS arrPeriod\r\n\r\n	FROM /* get the individual loan details */\r\n		(SELECT ml.id AS loanId, ml.currency_code as currency,\r\n   			ml.principal_disbursed_derived as principal, \r\n			   ml.interest_charged_derived as interest, \r\n   			ml.principal_repaid_derived as prinPaid, \r\n			   ml.interest_repaid_derived intPaid,\r\n\r\n			   laa.principal_overdue_derived as prinOverdue,\r\n			   laa.interest_overdue_derived as intOverdue,\r\n\r\n			   IFNULL(laa.overdue_since_date_derived, curdate()) as minOverdueDate\r\n			  \r\n  		FROM m_office mo\r\n   		INNER JOIN m_office ounder ON ounder.hierarchy \r\n				LIKE CONCAT(mo.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   		INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n   		INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n		   LEFT JOIN m_loan_arrears_aging laa on laa.loan_id = ml.id\r\n		WHERE ml.loan_status_id=300 /* active */\r\n     		AND mo.id=${officeId}\r\n     AND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\n  		GROUP BY ml.id) x\r\n	) z \r\nGROUP BY z.currency, z.arrPeriod ) ars ON ars.arrPeriod=periods.period_no and ars.currency = periods.currency\r\nORDER BY periods.currency, periods.pid','Loan amount in arrears by branch',1,1,0),(54,'Rescheduled Loans','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nc.account_no as \"Client Account No.\",\r\nc.display_name AS \'Client Name\',\r\nml.account_no AS \'Loan Account No.\',\r\nmpl.name AS \'Product Name\',\r\nml.disbursedon_date AS \'Disbursed Date\',\r\nlt.transaction_date AS \'Written Off date\',\r\nml.principal_amount as \"Loan Amount\",\r\nifnull(lt.principal_portion_derived, 0) AS \'Rescheduled Principal\',\r\nifnull(lt.interest_portion_derived, 0) AS \'Rescheduled Interest\',\r\nifnull(lt.fee_charges_portion_derived,0) AS \'Rescheduled Fees\',\r\nifnull(lt.penalty_charges_portion_derived,0) AS \'Rescheduled Penalties\',\r\nn.note AS \'Reason For Rescheduling\',\r\nIFNULL(ms.display_name,\'-\') AS \'Loan Officer Name\'\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan ml ON ml.client_id = c.id\r\nJOIN m_product_loan mpl ON mpl.id=ml.product_id\r\nLEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\nJOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nLEFT JOIN m_note n ON n.loan_transaction_id = lt.id\r\nLEFT JOIN m_currency cur on cur.code = ml.currency_code\r\nWHERE lt.transaction_type_enum = 7 /*marked for rescheduling */\r\nAND lt.is_reversed is false \r\nAND ml.loan_status_id=602\r\nAND o.id=${officeId}\r\nAND (mpl.id=${loanProductId} OR ${loanProductId}=-1)\r\nAND lt.transaction_date BETWEEN \'${startDate}\' AND \'${endDate}\'\r\nAND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no','Individual Lending Report. Rescheduled Loans.  The ability to reschedule (or mark that you have rescheduled the loan elsewhere) is a legacy of the older Mifos product.  Needed for migration.',1,1,0),(55,'Active Loans Passed Final Maturity','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", \r\nc.display_name as \"Client\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\ndate(l.expected_maturedon_date) as \"Expected Matured On\",\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.principal_outstanding_derived as \"Principal Outstanding\",\r\nlaa.principal_overdue_derived as \"Principal Overdue\",\r\n\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.interest_outstanding_derived as \"Interest Outstanding\",\r\nlaa.interest_overdue_derived as \"Interest Overdue\",\r\n\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.fee_charges_outstanding_derived  as \"Fees Outstanding\",\r\nlaa.fee_charges_overdue_derived as \"Fees Overdue\",\r\n\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nl.penalty_charges_outstanding_derived as \"Penalties Outstanding\",\r\nlaa.penalty_charges_overdue_derived as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand l.expected_maturedon_date < curdate()\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1,0),(56,'Active Loans Passed Final Maturity Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select ounder.id as branch,\r\nifnull(cur.display_symbol, l.currency_code) as currency,\r\ncount(distinct(c.id)) as client_count, \r\ncount(distinct(l.id)) as  active_loan_count,\r\ncount(distinct(laa.loan_id)  ) as arrears_loan_count,\r\n\r\nsum(l.principal_disbursed_derived) as principal,\r\nsum(l.principal_repaid_derived) as principal_repaid,\r\nsum(l.principal_outstanding_derived) as principal_outstanding,\r\nsum(ifnull(laa.principal_overdue_derived,0)) as principal_overdue,\r\n\r\nsum(l.interest_charged_derived) as interest,\r\nsum(l.interest_repaid_derived) as interest_repaid,\r\nsum(l.interest_outstanding_derived) as interest_outstanding,\r\nsum(ifnull(laa.interest_overdue_derived,0)) as interest_overdue,\r\n\r\nsum(l.fee_charges_charged_derived) as fees,\r\nsum(l.fee_charges_repaid_derived) as fees_repaid,\r\nsum(l.fee_charges_outstanding_derived)  as fees_outstanding,\r\nsum(ifnull(laa.fee_charges_overdue_derived,0)) as fees_overdue,\r\n\r\nsum(l.penalty_charges_charged_derived) as penalties,\r\nsum(l.penalty_charges_repaid_derived) as penalties_repaid,\r\nsum(l.penalty_charges_outstanding_derived) as penalties_outstanding,\r\nsum(ifnull(laa.penalty_charges_overdue_derived,0)) as penalties_overdue\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand l.expected_maturedon_date < curdate()\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency',NULL,1,1,0),(57,'Active Loans in last installment','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(lastInstallment.`hierarchy`) - LENGTH(REPLACE(lastInstallment.`hierarchy`, \'.\', \'\')) - 1))), lastInstallment.branch) as \"Office/Branch\",\r\nlastInstallment.Currency,\r\nlastInstallment.`Loan Officer`, \r\nlastInstallment.`Client Account No`, lastInstallment.`Client`, \r\nlastInstallment.`Loan Account No`, lastInstallment.`Product`, \r\nlastInstallment.`Fund`,  lastInstallment.`Loan Amount`, \r\nlastInstallment.`Annual Nominal Interest Rate`, \r\nlastInstallment.`Disbursed`, lastInstallment.`Expected Matured On` ,\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.principal_outstanding_derived as \"Principal Outstanding\",\r\nlaa.principal_overdue_derived as \"Principal Overdue\",\r\n\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.interest_outstanding_derived as \"Interest Outstanding\",\r\nlaa.interest_overdue_derived as \"Interest Overdue\",\r\n\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.fee_charges_outstanding_derived  as \"Fees Outstanding\",\r\nlaa.fee_charges_overdue_derived as \"Fees Overdue\",\r\n\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nl.penalty_charges_outstanding_derived as \"Penalties Outstanding\",\r\nlaa.penalty_charges_overdue_derived as \"Penalties Overdue\"\r\n\r\nfrom \r\n(select l.id as loanId, l.number_of_repayments, min(r.installment), \r\nounder.id, ounder.hierarchy, ounder.`name` as branch, \r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", c.account_no as \"Client Account No\",\r\nc.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  l.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \"Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", date(l.expected_maturedon_date) as \"Expected Matured On\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand r.completed_derived is false\r\nand r.duedate >= curdate()\r\ngroup by l.id\r\nhaving l.number_of_repayments = min(r.installment)) lastInstallment\r\njoin m_loan l on l.id = lastInstallment.loanId\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\norder by lastInstallment.hierarchy, lastInstallment.Currency, lastInstallment.`Client Account No`, lastInstallment.`Loan Account No`','Individual Client \n\nReport',1,1,0),(58,'Active Loans in last installment Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select lastInstallment.branchId as branchId,\r\nlastInstallment.Currency,\r\ncount(distinct(lastInstallment.clientId)) as client_count, \r\ncount(distinct(lastInstallment.loanId)) as  active_loan_count,\r\ncount(distinct(laa.loan_id)  ) as arrears_loan_count,\r\n\r\nsum(l.principal_disbursed_derived) as principal,\r\nsum(l.principal_repaid_derived) as principal_repaid,\r\nsum(l.principal_outstanding_derived) as principal_outstanding,\r\nsum(ifnull(laa.principal_overdue_derived,0)) as principal_overdue,\r\n\r\nsum(l.interest_charged_derived) as interest,\r\nsum(l.interest_repaid_derived) as interest_repaid,\r\nsum(l.interest_outstanding_derived) as interest_outstanding,\r\nsum(ifnull(laa.interest_overdue_derived,0)) as interest_overdue,\r\n\r\nsum(l.fee_charges_charged_derived) as fees,\r\nsum(l.fee_charges_repaid_derived) as fees_repaid,\r\nsum(l.fee_charges_outstanding_derived)  as fees_outstanding,\r\nsum(ifnull(laa.fee_charges_overdue_derived,0)) as fees_overdue,\r\n\r\nsum(l.penalty_charges_charged_derived) as penalties,\r\nsum(l.penalty_charges_repaid_derived) as penalties_repaid,\r\nsum(l.penalty_charges_outstanding_derived) as penalties_outstanding,\r\nsum(ifnull(laa.penalty_charges_overdue_derived,0)) as penalties_overdue\r\n\r\nfrom \r\n(select l.id as loanId, l.number_of_repayments, min(r.installment), \r\nounder.id as branchId, ounder.hierarchy, ounder.`name` as branch, \r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", c.id as clientId, c.account_no as \"Client Account No\",\r\nc.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  l.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \"Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", date(l.expected_maturedon_date) as \"Expected Matured On\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand r.completed_derived is false\r\nand r.duedate >= curdate()\r\ngroup by l.id\r\nhaving l.number_of_repayments = min(r.installment)) lastInstallment\r\njoin m_loan l on l.id = lastInstallment.loanId\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\ngroup by lastInstallment.branchId) x on x.branchId = mo.id\r\norder by mo.hierarchy, x.Currency','Individual Client \n\nReport',1,1,0),(59,'Active Loans by Disbursal Period','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nc.account_no as \"Client Account No\", c.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Principal Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\n\r\nl.total_expected_repayment_derived as \"Total Loan (P+I+F+Pen)\",\r\nl.total_repayment_derived as \"Total Repaid (P+I+F+Pen)\",\r\nlo.display_name as \"Loan Officer\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1,0),(61,'Aging Summary (Arrears in Months)','Table',NULL,'Loan','SELECT \r\n  IFNULL(periods.currencyName, periods.currency) as currency, \r\n  periods.period_no \'Days In Arrears\', \r\n  IFNULL(ars.loanId, 0) \'No Of Loans\', \r\n  IFNULL(ars.principal,0.0) \'Original Principal\', \r\n  IFNULL(ars.interest,0.0) \'Original Interest\', \r\n  IFNULL(ars.prinPaid,0.0) \'Principal Paid\', \r\n  IFNULL(ars.intPaid,0.0) \'Interest Paid\', \r\n  IFNULL(ars.prinOverdue,0.0) \'Principal Overdue\', \r\n  IFNULL(ars.intOverdue,0.0)\'Interest Overdue\'\r\nFROM \r\n	/* full table of aging periods/currencies used combo to ensure each line represented */\r\n  (SELECT curs.code as currency, curs.name as currencyName, pers.* from\r\n	(SELECT \'On Schedule\' period_no,1 pid UNION\r\n		SELECT \'0 - 30\',2 UNION\r\n		SELECT \'30 - 60\',3 UNION\r\n		SELECT \'60 - 90\',4 UNION\r\n		SELECT \'90 - 180\',5 UNION\r\n		SELECT \'180 - 360\',6 UNION\r\n		SELECT \'> 360\',7 ) pers,\r\n	(SELECT distinctrow moc.code, moc.name\r\n  	FROM m_office mo2\r\n   	INNER JOIN m_office ounder2 ON ounder2.hierarchy \r\n				LIKE CONCAT(mo2.hierarchy, \'%\')\r\nAND ounder2.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   	INNER JOIN m_client mc2 ON mc2.office_id=ounder2.id\r\n   	INNER JOIN m_loan ml2 ON ml2.client_id = mc2.id\r\n	INNER JOIN m_organisation_currency moc ON moc.code = ml2.currency_code\r\n	WHERE ml2.loan_status_id=300 /* active */\r\n	AND mo2.id=${officeId}\r\nAND (ml2.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")) curs) periods\r\n\r\n\r\nLEFT JOIN /* table of aging periods per currency with gaps if no applicable loans */\r\n(SELECT \r\n  	z.currency, z.arrPeriod, \r\n	COUNT(z.loanId) as loanId, SUM(z.principal) as principal, SUM(z.interest) as interest, \r\n	SUM(z.prinPaid) as prinPaid, SUM(z.intPaid) as intPaid, \r\n	SUM(z.prinOverdue) as prinOverdue, SUM(z.intOverdue) as intOverdue\r\nFROM\r\n	/*derived table just used to get arrPeriod value (was much slower to\r\n	duplicate calc of minOverdueDate in inner query)\r\nmight not be now with derived fields but didn’t check */\r\n	(SELECT x.loanId, x.currency, x.principal, x.interest, x.prinPaid, x.intPaid, x.prinOverdue, x.intOverdue,\r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<1, \'On Schedule\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<31, \'0 - 30\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<61, \'30 - 60\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<91, \'60 - 90\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<181, \'90 - 180\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<361, \'180 - 360\', \r\n				 \'> 360\')))))) AS arrPeriod\r\n\r\n	FROM /* get the individual loan details */\r\n		(SELECT ml.id AS loanId, ml.currency_code as currency,\r\n   			ml.principal_disbursed_derived as principal, \r\n			   ml.interest_charged_derived as interest, \r\n   			ml.principal_repaid_derived as prinPaid, \r\n			   ml.interest_repaid_derived intPaid,\r\n\r\n			   laa.principal_overdue_derived as prinOverdue,\r\n			   laa.interest_overdue_derived as intOverdue,\r\n\r\n			   IFNULL(laa.overdue_since_date_derived, curdate()) as minOverdueDate\r\n			  \r\n  		FROM m_office mo\r\n   		INNER JOIN m_office ounder ON ounder.hierarchy \r\n				LIKE CONCAT(mo.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   		INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n   		INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n		   LEFT JOIN m_loan_arrears_aging laa on laa.loan_id = ml.id\r\n		WHERE ml.loan_status_id=300 /* active */\r\n     		AND mo.id=${officeId}\r\n     AND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\n  		GROUP BY ml.id) x\r\n	) z \r\nGROUP BY z.currency, z.arrPeriod ) ars ON ars.arrPeriod=periods.period_no and ars.currency = periods.currency\r\nORDER BY periods.currency, periods.pid','Loan amount in arrears by branch',1,1,0),(91,'Loan Account Schedule','Pentaho',NULL,'Loan',NULL,NULL,1,0,0),(92,'Branch Expected Cash Flow','Pentaho',NULL,'Loan',NULL,NULL,1,1,0),(93,'Expected Payments By Date - Basic','Table',NULL,'Loan','SELECT \r\n      ounder.name \'Office\', \r\n      IFNULL(ms.display_name,\'-\') \'Loan Officer\',\r\n	  mc.account_no \'Client Account Number\',\r\n	  mc.display_name \'Name\',\r\n	  mp.name \'Product\',\r\n	  ml.account_no \'Loan Account Number\',\r\n	  mr.duedate \'Due Date\',\r\n	  mr.installment \'Installment\',\r\n	  cu.display_symbol \'Currency\',\r\n	  mr.principal_amount- IFNULL(mr.principal_completed_derived,0) \'Principal Due\',\r\n	  mr.interest_amount- IFNULL(IFNULL(mr.interest_completed_derived,mr.interest_waived_derived),0) \'Interest Due\', \r\n	  IFNULL(mr.fee_charges_amount,0)- IFNULL(IFNULL(mr.fee_charges_completed_derived,mr.fee_charges_waived_derived),0) \'Fees Due\', \r\n	  IFNULL(mr.penalty_charges_amount,0)- IFNULL(IFNULL(mr.penalty_charges_completed_derived,mr.penalty_charges_waived_derived),0) \'Penalty Due\',\r\n      (mr.principal_amount- IFNULL(mr.principal_completed_derived,0)) +\r\n       (mr.interest_amount- IFNULL(IFNULL(mr.interest_completed_derived,mr.interest_waived_derived),0)) + \r\n       (IFNULL(mr.fee_charges_amount,0)- IFNULL(IFNULL(mr.fee_charges_completed_derived,mr.fee_charges_waived_derived),0)) + \r\n       (IFNULL(mr.penalty_charges_amount,0)- IFNULL(IFNULL(mr.penalty_charges_completed_derived,mr.penalty_charges_waived_derived),0)) \'Total Due\', \r\n     mlaa.total_overdue_derived \'Total Overdue\'\r\n										 \r\n FROM m_office mo\r\n  JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\n  \r\n  AND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n	\r\n  LEFT JOIN m_client mc ON mc.office_id=ounder.id\r\n  LEFT JOIN m_loan ml ON ml.client_id=mc.id AND ml.loan_status_id=300\r\n  LEFT JOIN m_loan_arrears_aging mlaa ON mlaa.loan_id=ml.id\r\n  LEFT JOIN m_loan_repayment_schedule mr ON mr.loan_id=ml.id AND mr.completed_derived=0\r\n  LEFT JOIN m_product_loan mp ON mp.id=ml.product_id\r\n  LEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\n  LEFT JOIN m_currency cu ON cu.code=ml.currency_code\r\n WHERE mo.id=${officeId}\r\n AND (IFNULL(ml.loan_officer_id, -10) = \"${loanOfficerId}\" OR \"-1\" = \"${loanOfficerId}\")\r\n AND mr.duedate BETWEEN \'${startDate}\' AND \'${endDate}\'\r\n ORDER BY ounder.id,mr.duedate,ml.account_no','Test',1,1,0),(94,'Expected Payments By Date - Formatted','Pentaho',NULL,'Loan',NULL,NULL,1,1,0),(96,'GroupSummaryCounts','Table',NULL,NULL,'\n/*\nActive Client is a client linked to the \'group\' via m_group_client\nand with an active \'status_enum\'.)\nActive Borrowers - Borrower may be a client or a \'group\'\n*/\nselect x.*\nfrom m_office o,\nm_group g,\n\n(select a.activeClients,\n(b.activeClientLoans + c.activeGroupLoans) as activeLoans,\nb.activeClientLoans, c.activeGroupLoans,\n(b.activeClientBorrowers + c.activeGroupBorrowers) as activeBorrowers,\nb.activeClientBorrowers, c.activeGroupBorrowers,\n(b.overdueClientLoans +  c.overdueGroupLoans) as overdueLoans,\nb.overdueClientLoans, c.overdueGroupLoans\nfrom\n(select count(*) as activeClients\nfrom m_group topgroup\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_group_client gc on gc.group_id = g.id\njoin m_client c on c.id = gc.client_id\nwhere topgroup.id = ${groupId}\nand c.status_enum = 300) a,\n\n(select count(*) as activeClientLoans,\ncount(distinct(l.client_id)) as activeClientBorrowers,\nifnull(sum(if(laa.loan_id is not null, 1, 0)), 0) as overdueClientLoans\nfrom m_group topgroup\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_loan l on l.group_id = g.id and l.client_id is not null\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nwhere topgroup.id = ${groupId}\nand l.loan_status_id = 300) b,\n\n(select count(*) as activeGroupLoans,\ncount(distinct(l.group_id)) as activeGroupBorrowers,\nifnull(sum(if(laa.loan_id is not null, 1, 0)), 0) as overdueGroupLoans\nfrom m_group topgroup\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_loan l on l.group_id = g.id and l.client_id is null\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nwhere topgroup.id = ${groupId}\nand l.loan_status_id = 300) c\n) x\n\nwhere g.id = ${groupId}\nand o.id = g.office_id\nand o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\n','Utility query for getting group summary count details for a group_id',1,0,0),(97,'GroupSummaryAmounts','Table',NULL,NULL,'\nselect ifnull(cur.display_symbol, l.currency_code) as currency,\nifnull(sum(l.principal_disbursed_derived),0) as totalDisbursedAmount,\nifnull(sum(l.principal_outstanding_derived),0) as totalLoanOutstandingAmount,\ncount(laa.loan_id) as overdueLoans, ifnull(sum(laa.total_overdue_derived), 0) as totalLoanOverdueAmount\nfrom m_group topgroup\njoin m_office o on o.id = topgroup.office_id and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_loan l on l.group_id = g.id\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_currency cur on cur.code = l.currency_code\nwhere topgroup.id = ${groupId}\nand l.disbursedon_date is not null\ngroup by l.currency_code\n','Utility query for getting group summary currency amount details for a group_id',1,0,0),(106,'TxnRunningBalances','Table',NULL,'Transaction','\nselect date(\'${startDate}\') as \'Transaction Date\', \'Opening Balance\' as `Transaction Type`, null as Office,\n	null as \'Loan Officer\', null as `Loan Account No`, null as `Loan Product`, null as `Currency`,\n	null as `Client Account No`, null as Client,\n	null as Amount, null as Principal, null as Interest,\n@totalOutstandingPrincipal :=\nifnull(round(sum(\n	if (txn.transaction_type_enum = 1 /* disbursement */,\n		ifnull(txn.amount,0.00),\n		ifnull(txn.principal_portion_derived,0.00) * -1))\n			,2),0.00)  as \'Outstanding Principal\',\n\n@totalInterestIncome :=\nifnull(round(sum(\n	if (txn.transaction_type_enum in (2,5,8) /* repayment, repayment at disbursal, recovery repayment */,\n		ifnull(txn.interest_portion_derived,0.00),\n		0))\n			,2),0.00) as \'Interest Income\',\n\n@totalWriteOff :=\nifnull(round(sum(\n	if (txn.transaction_type_enum = 6 /* write-off */,\n		ifnull(txn.principal_portion_derived,0.00),\n		0))\n			,2),0.00) as \'Principal Write Off\'\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\n                          and ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\njoin m_loan l on l.client_id = c.id\njoin m_product_loan lp on lp.id = l.product_id\njoin m_loan_transaction txn on txn.loan_id = l.id\nleft join m_currency cur on cur.code = l.currency_code\nwhere txn.is_reversed = false\nand txn.transaction_type_enum not in (10,11)\nand o.id = ${officeId}\nand txn.transaction_date < date(\'${startDate}\')\n\nunion all\n\nselect x.`Transaction Date`, x.`Transaction Type`, x.Office, x.`Loan Officer`, x.`Loan Account No`, x.`Loan Product`, x.`Currency`,\n	x.`Client Account No`, x.Client, x.Amount, x.Principal, x.Interest,\ncast(round(\n	if (x.transaction_type_enum = 1 /* disbursement */,\n		@totalOutstandingPrincipal := @totalOutstandingPrincipal + x.`Amount`,\n		@totalOutstandingPrincipal := @totalOutstandingPrincipal - x.`Principal`)\n			,2) as decimal(19,2)) as \'Outstanding Principal\',\ncast(round(\n	if (x.transaction_type_enum in (2,5,8) /* repayment, repayment at disbursal, recovery repayment */,\n		@totalInterestIncome := @totalInterestIncome + x.`Interest`,\n		@totalInterestIncome)\n			,2) as decimal(19,2)) as \'Interest Income\',\ncast(round(\n	if (x.transaction_type_enum = 6 /* write-off */,\n		@totalWriteOff := @totalWriteOff + x.`Principal`,\n		@totalWriteOff)\n			,2) as decimal(19,2)) as \'Principal Write Off\'\nfrom\n(select txn.transaction_type_enum, txn.id as txn_id, txn.transaction_date as \'Transaction Date\',\ncast(\n	ifnull(re.enum_message_property, concat(\'Unknown Transaction Type Value: \' , txn.transaction_type_enum))\n	as char) as \'Transaction Type\',\nounder.`name` as Office, lo.display_name as \'Loan Officer\',\nl.account_no  as \'Loan Account No\', lp.`name` as \'Loan Product\',\nifnull(cur.display_symbol, l.currency_code) as Currency,\nc.account_no as \'Client Account No\', c.display_name as \'Client\',\nifnull(txn.amount,0.00) as Amount,\nifnull(txn.principal_portion_derived,0.00) as Principal,\nifnull(txn.interest_portion_derived,0.00) as Interest\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\n                          and ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\njoin m_loan l on l.client_id = c.id\nleft join m_staff lo on lo.id = l.loan_officer_id\njoin m_product_loan lp on lp.id = l.product_id\njoin m_loan_transaction txn on txn.loan_id = l.id\nleft join m_currency cur on cur.code = l.currency_code\nleft join r_enum_value re on re.enum_name = \'transaction_type_enum\'\n						and re.enum_id = txn.transaction_type_enum\nwhere txn.is_reversed = false\nand txn.transaction_type_enum not in (10,11)\nand (ifnull(l.loan_officer_id, -10) = \'${loanOfficerId}\' or \'-1\' = \'${loanOfficerId}\')\nand o.id = ${officeId}\nand txn.transaction_date >= date(\'${startDate}\')\nand txn.transaction_date <= date(\'${endDate}\')\norder by txn.transaction_date, txn.id) x\n','Running Balance Txn report for Individual Lending.\nSuitable for small MFI\'s.  Larger could use it using the branch or other parameters.\nBasically, suck it and see if its quick enough for you out-of-te box or whether it needs performance work in your situation.\n',0,0,0),(107,'FieldAgentStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff fa\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere fa.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Field Agent Statistics',0,0,0),(108,'FieldAgentPrograms','Table',NULL,'Quipo','\nselect pgm.id, pgm.display_name as `name`, sts.enum_message_property as status\n from m_group pgm\n join m_office o on o.id = pgm.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\n left join r_enum_value sts on sts.enum_name = \'status_enum\' and sts.enum_id = pgm.status_enum\n where pgm.staff_id = ${staffId}\n','List of Field Agent Programs',0,0,0),(109,'ProgramDetails','Table',NULL,'Quipo','\n select l.id as loanId, l.account_no as loanAccountNo, c.id as clientId, c.account_no as clientAccountNo,\n pgm.display_name as programName,\n\n(select count(*)\nfrom m_loan cy\nwhere cy.group_id = pgm.id and cy.client_id =c.id\nand cy.disbursedon_date <= l.disbursedon_date) as loanCycleNo,\n\nc.display_name as clientDisplayName,\n ifnull(cur.display_symbol, l.currency_code) as Currency,\nifnull(l.principal_repaid_derived,0.0) as loanRepaidAmount,\nifnull(l.principal_outstanding_derived, 0.0) as loanOutstandingAmount,\nifnull(lpa.principal_in_advance_derived,0.0) as LoanPaidInAdvance,\n\nifnull(laa.principal_overdue_derived, 0.0) as loanInArrearsAmount,\nif(ifnull(laa.principal_overdue_derived, 0.00) > 0, \'Yes\', \'No\') as inDefault,\n\nif(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)  as portfolioAtRisk\n\n from m_group pgm\n join m_office o on o.id = pgm.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\n join m_loan l on l.group_id = pgm.id and l.client_id is not null\n left join m_currency cur on cur.code = l.currency_code\n join m_client c on c.id = l.client_id\n left join m_loan_arrears_aging laa on laa.loan_id = l.id\n left join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\n where pgm.id = ${programId}\n and l.loan_status_id = 300\norder by c.display_name, l.account_no\n\n','List of Loans in a Program',0,0,0),(110,'ChildrenStaffList','Table',NULL,'Quipo','\n select s.id, s.display_name,\ns.firstname, s.lastname, s.organisational_role_enum,\ns.organisational_role_parent_staff_id,\nsp.display_name as `organisational_role_parent_staff_display_name`\nfrom m_staff s\njoin m_staff sp on s.organisational_role_parent_staff_id = sp.id\nwhere s.organisational_role_parent_staff_id = ${staffId}\n','Get Next Level Down Staff',0,0,0),(111,'CoordinatorStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff coord\njoin m_staff fa on fa.organisational_role_parent_staff_id = coord.id\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere coord.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Coordinator Statistics',0,0,0),(112,'BranchManagerStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff bm\njoin m_staff coord on coord.organisational_role_parent_staff_id = bm.id\njoin m_staff fa on fa.organisational_role_parent_staff_id = coord.id\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere bm.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Branch Manager Statistics',0,0,0),(113,'ProgramDirectorStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff pd\njoin m_staff bm on bm.organisational_role_parent_staff_id = pd.id\njoin m_staff coord on coord.organisational_role_parent_staff_id = bm.id\njoin m_staff fa on fa.organisational_role_parent_staff_id = coord.id\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere pd.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Program DirectorStatistics',0,0,0),(114,'ProgramStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_group pgm\njoin m_office o on o.id = pgm.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere pgm.id = ${programId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Program Statistics',0,0,0),(115,'ClientSummary ','Table',NULL,NULL,'SELECT x.* FROM m_client c, m_office o, \n(\n       SELECT a.loanCycle, a.activeLoans, b.lastLoanAmount, d.activeSavings, d.totalSavings FROM \n	(SELECT IFNULL(MAX(l.loan_counter),0) AS loanCycle, COUNT(l.id) AS activeLoans FROM m_loan l WHERE l.loan_status_id=300 AND l.client_id=${clientId}) a, \n	(SELECT count(l.id), IFNULL(l.principal_amount,0) AS \'lastLoanAmount\' FROM m_loan l WHERE l.client_id=${clientId} AND l.disbursedon_date = (SELECT IFNULL(MAX(disbursedon_date),NOW()) FROM m_loan where client_id=${clientId} and loan_status_id=300) group by l.principal_amount) b, \n	(SELECT COUNT(s.id) AS \'activeSavings\', IFNULL(SUM(s.account_balance_derived),0) AS \'totalSavings\' FROM m_savings_account s WHERE s.status_enum=300 AND s.client_id=${clientId}) d\n) x\nWHERE c.id=${clientId} AND o.id = c.office_id AND o.hierarchy LIKE CONCAT(\'${currentUserHierarchy}\', \'%\')','Utility query for getting the client summary details',1,0,0),(116,'LoanCyclePerProduct','Table',NULL,NULL,'SELECT lp.name AS \'productName\', MAX(l.loan_product_counter) AS \'loanProductCycle\' FROM m_loan l JOIN m_product_loan lp ON l.product_id=lp.id WHERE lp.include_in_borrower_cycle=1 AND l.loan_product_counter IS NOT NULL AND l.client_id=${clientId} GROUP BY l.product_id','Utility query for getting the client loan cycle details',1,0,0),(117,'GroupSavingSummary','Table',NULL,NULL,'select ifnull(cur.display_symbol, sa.currency_code) as currency,\ncount(sa.id) as totalSavingAccounts, ifnull(sum(sa.account_balance_derived),0) as totalSavings\nfrom m_group topgroup\njoin m_office o on o.id = topgroup.office_id and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_savings_account sa on sa.group_id = g.id\nleft join m_currency cur on cur.code = sa.currency_code\nwhere topgroup.id = ${groupId}\nand sa.activatedon_date is not null\ngroup by sa.currency_code','Utility query for getting group or center saving summary details for a group_id',1,0,0),(118,'Savings Transactions','Pentaho',NULL,'Savings',NULL,NULL,0,1,0),(119,'Client Savings Summary','Pentaho',NULL,'Savings',NULL,NULL,0,1,0),(120,'Active Loans - Details(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(121,'Active Loans - Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(122,'Active Loans by Disbursal Period(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(123,'Active Loans in last installment Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(124,'Active Loans in last installment(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(125,'Active Loans Passed Final Maturity Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(126,'Active Loans Passed Final Maturity(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(127,'Aging Detail(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(128,'Aging Summary (Arrears in Months)(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(129,'Aging Summary (Arrears in Weeks)(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(130,'Client Listing(Pentaho)','Pentaho',NULL,'Client','(NULL)','(NULL)',1,1,0),(131,'Client Loans Listing(Pentaho)','Pentaho',NULL,'Client','(NULL)','(NULL)',1,1,0),(132,'Expected Payments By Date - Basic(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(133,'Funds Disbursed Between Dates Summary by Office(Pentaho)','Pentaho',NULL,'Fund','(NULL)','(NULL)',1,1,0),(134,'Funds Disbursed Between Dates Summary(Pentaho)','Pentaho',NULL,'Fund','(NULL)','(NULL)',1,1,0),(135,'Loans Awaiting Disbursal Summary by Month(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(136,'Loans Awaiting Disbursal Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(137,'Loans Awaiting Disbursal(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(138,'Loans Pending Approval(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(139,'Obligation Met Loans Details(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(140,'Obligation Met Loans Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(141,'Portfolio at Risk by Branch(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(142,'Portfolio at Risk(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(143,'Rescheduled Loans(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(144,'TxnRunningBalances(Pentaho)','Pentaho',NULL,'Transaction','(NULL)','(NULL)',1,1,0),(145,'Written-Off Loans(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1,0),(146,'Client Saving Transactions','Pentaho',NULL,'Savings',NULL,NULL,0,0,0),(147,'Client Loan Account Schedule','Pentaho',NULL,'Loan',NULL,NULL,0,0,0),(148,'GroupNamesByStaff','Table','','','Select gr.id as id, gr.display_name as name from m_group gr where gr.level_id=1 and gr.staff_id = ${staffId}','',1,0,0),(149,'ClientTrendsByDay','Table','','Client','SELECT 	COUNT(cl.id) AS count, \n		cl.activation_date AS days\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (cl.activation_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 DAY) AND DATE(NOW()- INTERVAL 1 DAY))\nGROUP BY days','Retrieves the number of clients joined in last 12 days',1,0,0),(150,'ClientTrendsByWeek','Table','','Client','SELECT 	COUNT(cl.id) AS count, \n		WEEK(cl.activation_date) AS Weeks\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (cl.activation_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 WEEK) AND DATE(NOW()))\nGROUP BY Weeks','',1,0,0),(151,'ClientTrendsByMonth','Table','','Client','SELECT 	COUNT(cl.id) AS count, \n		MONTHNAME(cl.activation_date) AS Months\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (cl.activation_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH) AND DATE(NOW()))\nGROUP BY Months','',1,0,0),(152,'LoanTrendsByDay','Table','','Loan','SELECT 	COUNT(ln.id) AS lcount, \n		ln.disbursedon_date AS days\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\n	LEFT JOIN m_loan ln on cl.id = ln.client_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (ln.disbursedon_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 DAY) AND DATE(NOW()- INTERVAL 1 DAY))\nGROUP BY days','Retrieves Number of loans disbursed for last 12 days',1,0,0),(153,'LoanTrendsByWeek','Table','','Loan','SELECT 	COUNT(ln.id) AS lcount, \n		WEEK(ln.disbursedon_date) AS Weeks\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\n	LEFT JOIN m_loan ln on cl.id = ln.client_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (ln.disbursedon_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 WEEK) AND DATE(NOW()))\nGROUP BY Weeks','',1,0,0),(154,'LoanTrendsByMonth','Table','','Loan','SELECT 	COUNT(ln.id) AS lcount, \n		MONTHNAME(ln.disbursedon_date) AS Months\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\n	LEFT JOIN m_loan ln on cl.id = ln.client_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (ln.disbursedon_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH) AND DATE(NOW()))\nGROUP BY Months','',1,0,0),(155,'Demand_Vs_Collection','Table','','Loan','select amount.AmountDue-amount.AmountPaid as AmountDue, amount.AmountPaid as AmountPaid from\n(SELECT \n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \n - IFNULL(SUM(ls.interest_waived_derived),0)\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\n) AS AmountDue, \n\n(IFNULL(SUM(ls.principal_completed_derived),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0) + IFNULL(SUM(ls.interest_completed_derived),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \n - IFNULL(SUM(ls.interest_waived_derived),0)\n + IFNULL(SUM(ls.fee_charges_completed_derived),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\n + IFNULL(SUM(ls.penalty_charges_completed_derived),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\n) AS AmountPaid\nFROM m_office of\nLEFT JOIN m_client cl ON of.id = cl.office_id\nLEFT JOIN m_loan ln ON cl.id = ln.client_id\nLEFT JOIN m_loan_repayment_schedule ls ON ln.id = ls.loan_id\nWHERE ls.duedate = DATE(NOW()) AND \n (of.hierarchy LIKE CONCAT((\nSELECT ino.hierarchy\nFROM m_office ino\nWHERE ino.id = ${officeId}),\"%\"))) as amount','Demand Vs Collection',1,0,0),(156,'Disbursal_Vs_Awaitingdisbursal','Table','','Loan','select awaitinddisbursal.amount-disbursedAmount.amount as amountToBeDisburse, disbursedAmount.amount as disbursedAmount from \n(\nSELECT 	COUNT(ln.id) AS noOfLoans, \n			IFNULL(SUM(ln.principal_amount),0) AS amount\nFROM \nm_office of\nLEFT JOIN m_client cl ON cl.office_id = of.id\nLEFT JOIN m_loan ln ON cl.id = ln.client_id\nWHERE \nln.expected_disbursedon_date = DATE(NOW()) AND \n(ln.loan_status_id=200 OR ln.loan_status_id=300) AND\n of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" )\n) awaitinddisbursal,\n(\nSELECT 	COUNT(ltrxn.id) as count, \n			IFNULL(SUM(ltrxn.amount),0) as amount \nFROM \nm_office of\nLEFT JOIN m_client cl ON cl.office_id = of.id\nLEFT JOIN m_loan ln ON cl.id = ln.client_id\nLEFT JOIN m_loan_transaction ltrxn ON ln.id = ltrxn.loan_id\nWHERE \nltrxn.transaction_date = DATE(NOW()) AND \nltrxn.is_reversed = 0 AND\nltrxn.transaction_type_enum=1 AND\n of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n) disbursedAmount','Disbursal_Vs_Awaitingdisbursal',1,0,0),(157,'Savings Transaction Receipt','Pentaho',NULL,NULL,NULL,NULL,0,1,0),(158,'Loan Transaction Receipt','Pentaho',NULL,NULL,NULL,NULL,0,1,0),(159,'Staff Assignment History','Pentaho',NULL,NULL,NULL,NULL,0,1,0),(160,'GeneralLedgerReport','Pentaho',NULL,'Accounting',NULL,NULL,0,1,0),(161,'Active Loan Summary per Branch','Pentaho',NULL,'Loan',NULL,NULL,0,1,0),(162,'Balance Outstanding','Pentaho',NULL,'Loan',NULL,NULL,0,1,0),(163,'Collection Report','Pentaho',NULL,'Loan',NULL,NULL,0,1,0),(164,'Disbursal Report','Pentaho',NULL,'Loan',NULL,NULL,0,1,0),(165,'Savings Accounts Dormancy Report','Table',NULL,'Savings','select cl.display_name as \'Client Display Name\',\r\nsa.account_no as \'Account Number\',\r\ncl.mobile_no as \'Mobile Number\',\r\n@lastdate:=(select IFNULL(max(sat.transaction_date),sa.activatedon_date) \r\n            from m_savings_account_transaction as sat \r\n            where sat.is_reversed = 0 \r\n            and sat.transaction_type_enum in (1,2) \r\n            and sat.savings_account_id = sa.id) as \'Date of Last Activity\',\r\nDATEDIFF(now(), @lastdate) as \'Days Since Last Activity\'\r\nfrom m_savings_account as sa \r\ninner join m_savings_product as sp on (sa.product_id = sp.id and sp.is_dormancy_tracking_active = 1) \r\nleft join m_client as cl on sa.client_id = cl.id \r\nwhere sa.sub_status_enum = ${subStatus}\r\nand cl.office_id = ${officeId}',NULL,1,1,0),(166,'Active Clients','SMS','NonTriggered','Client','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All clients with the status ‘Active’',0,1,0),(167,'Prospective Clients','SMS','NonTriggered','Client','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_loan l ON l.client_id = c.id\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.client_id IS NULL\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All clients with the status ‘Active’ who have never had a loan before',0,1,0),(168,'Active Loan Clients','SMS','NonTriggered','Client','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\", \r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\nounder.id AS \"officeNumber\", \r\nl.account_no AS \"loanAccountId\", \r\ngua.lastname AS \"guarantorLastName\", COUNT(gua.id) AS \"numberOfGuarantors\",\r\ng.display_name AS \"groupName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan l ON l.client_id = c.id\r\nJOIN m_product_loan pl ON pl.id = l.product_id\r\nLEFT JOIN m_group_client gc ON gc.client_id = c.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = l.currency_code\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nWHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.loan_status_id = 300 AND (DATEDIFF(CURDATE(), l.disbursedon_date) BETWEEN ${cycleX} AND ${cycleY})\r\nGROUP BY l.id\r\nORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no','All clients with an outstanding loan between cycleX and cycleY days',0,1,0),(169,'Loan in arrears','SMS','NonTriggered','Loan','SELECT \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nml.principal_disbursed_derived AS \"loanDisbursed\",\r\nlaa.overdue_since_date_derived AS \"paymentDueDate\",\r\nIFNULL(laa.total_overdue_derived, 0) AS \"totalDue\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountId\", \r\ngua.lastname AS \"guarantorLastName\", \r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ng.display_name AS \"groupName\"\r\n\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), laa.overdue_since_date_derived) BETWEEN ${fromX} AND ${toY})\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','All clients with an outstanding loan in arrears between fromX and toY days',0,1,0),(170,'Loan payments due','SMS','NonTriggered','Loan','SELECT \r\ncl.id AS \"id\", \r\ncl.firstname AS \"firstName\",\r\ncl.middlename AS \"middleName\",\r\ncl.lastname AS \"lastName\",\r\ncl.display_name AS \"fullName\",\r\ncl.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\",\r\nof.id AS \"officeNumber\",\r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\nls.duedate AS \"paymentDueDate\",\r\n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\r\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.interest_waived_derived),0)\r\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\r\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\r\n) AS \"totalDue\",\r\nlaa.total_overdue_derived AS \"totalOverdue\",\r\nl.account_no AS \"loanAccountId\",\r\ngua.lastname AS \"guarantorLastName\",\r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ngp.display_name AS \"groupName\"\r\n\r\nFROM m_office of\r\nLEFT JOIN m_client cl ON of.id = cl.office_id\r\nLEFT JOIN m_loan l ON cl.id = l.client_id\r\nLEFT JOIN m_group_client gc ON gc.client_id = cl.id\r\nLEFT JOIN m_group gp ON gp.id = l.group_id\r\nLEFT JOIN m_loan_repayment_schedule ls ON l.id = ls.loan_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=l.id\r\nWHERE of.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), ls.duedate) BETWEEN ${fromX} AND ${toY}) \r\nAND (of.hierarchy LIKE CONCAT((\r\nSELECT ino.hierarchy\r\nFROM m_office ino\r\nWHERE ino.id = ${officeId}),\"%\"))\r\nGROUP BY l.id\r\nORDER BY of.hierarchy, l.currency_code, cl.account_no, l.account_no','All clients with an unpaid installment due on their loan between fromX and toY days',0,1,0),(171,'Dormant Prospects','SMS','NonTriggered','Client','SELECT c.id AS \"id\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\",  \r\no.id AS \"officeNumber\", \r\nTIMESTAMPDIFF(MONTH, c.activation_date, CURDATE()) AS \"dormant\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_loan l ON l.client_id = c.id\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.client_id IS NULL AND (TIMESTAMPDIFF(MONTH, c.activation_date, CURDATE()) > 3)\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All individuals who have not yet received a loan but were also entered into the system more than 3 months',0,1,0),(172,'Active group leaders','SMS','NonTriggered','Client','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_group g ON g.office_id = ounder.id\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN m_group_client gc ON gc.group_id = g.id AND gc.client_id = c.id\r\nLEFT JOIN m_group_roles gr ON gr.group_id = g.id AND gr.client_id = c.id\r\nLEFT JOIN m_staff ms ON ms.id = c.staff_id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_code_value cv ON cv.id = gr.role_cv_id\r\nLEFT JOIN m_code code ON code.id = cv.code_id\r\nWHERE o.id = ${officeId} AND g.status_enum = 300 AND c.status_enum = 300  AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND code.code_name = \'GROUPROLE\' AND cv.code_value = \'Leader\'\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All active group chairmen',0,1,0),(173,'Loan payments due (Overdue Loans)','SMS','NonTriggered','Loan','SELECT \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nml.principal_disbursed_derived AS \"loanDisbursed\",\r\nlaa.overdue_since_date_derived AS \"paymentDueDate\",\r\n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\r\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.interest_waived_derived),0)\r\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\r\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\r\n) AS \"totalDue\",\r\nlaa.total_overdue_derived AS \"totalOverdue\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountId\", \r\ngua.lastname AS \"guarantorLastName\", \r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ng.display_name AS \"groupName\"\r\n\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nLEFT JOIN m_loan_repayment_schedule ls ON ls.loan_id = ml.id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) \r\nAND (DATEDIFF(CURDATE(), ls.duedate) BETWEEN ${fromX} AND ${toY})\r\nAND (DATEDIFF(CURDATE(), laa.overdue_since_date_derived) BETWEEN ${overdueX} AND ${overdueY})\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','Loan Payments Due between fromX to toY days for clients in arrears between overdueX and overdueY days',0,1,0),(174,'Loan payments received (Active Loans)','SMS','NonTriggered','Loan','SELECT \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountNumber\",\r\nSUM(lt.amount) AS \"repaymentAmount\"\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nINNER JOIN m_appuser au ON au.id = lt.appuser_id\r\nLEFT JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nLEFT JOIN m_payment_detail mpd ON mpd.id=lt.payment_detail_id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), lt.transaction_date) BETWEEN ${fromX} AND ${toY}) AND lt.is_reversed=0 AND lt.transaction_type_enum=2 AND laa.loan_id IS NULL\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','Payments received in the last fromX to toY days for any loan with the status Active (on-time)',0,1,0),(175,'Loan payments received (Overdue Loans)','SMS','NonTriggered','Loan','SELECT \r\nml.id AS \"loanId\", \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountNumber\",\r\nSUM(lt.amount) AS \"repaymentAmount\"\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nINNER JOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nINNER JOIN m_appuser au ON au.id = lt.appuser_id\r\nLEFT JOIN m_payment_detail mpd ON mpd.id=lt.payment_detail_id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), lt.transaction_date) BETWEEN ${fromX} AND ${toY}) AND (DATEDIFF(CURDATE(), laa.overdue_since_date_derived) BETWEEN ${overdueX} AND ${overdueY}) AND lt.is_reversed=0 AND lt.transaction_type_enum=2\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','Payments received in the last fromX to toY days for any loan with the status Overdue (arrears) between overdueX and overdueY days',0,1,0),(176,'Happy Birthday','SMS','NonTriggered','Client','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\", \r\nc.date_of_birth AS \"dateOfBirth\",\r\nIF(c.date_of_birth IS NULL, 0, CEIL(DATEDIFF (NOW(), c.date_of_birth)/365)) AS \"age\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_staff ms ON ms.id = c.staff_id\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND c.date_of_birth IS NOT NULL AND (DAY(c.date_of_birth)=DAY(NOW())) AND (MONTH(c.date_of_birth)=MONTH(NOW()))\r\nORDER BY ounder.hierarchy, c.account_no','This sends a message to all clients with the status Active on their Birthday',0,1,0),(177,'Loan fully repaid','SMS','NonTriggered','Loan','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\",\r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\no.id AS \"officeNumber\",\r\nl.account_no AS \"loanAccountId\",\r\ngua.lastname AS \"guarantorLastName\", COUNT(gua.id) AS \"numberOfGuarantors\",\r\nls.duedate AS \"dueDate\",\r\nlaa.total_overdue_derived AS \"totalDue\",\r\ngp.display_name AS \"groupName\",\r\nl.total_repayment_derived AS \"totalFullyPaid\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan l ON l.client_id = c.id\r\nLEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = l.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = c.id\r\nLEFT JOIN m_group gp ON gp.id = l.group_id\r\nLEFT JOIN m_loan_repayment_schedule ls ON l.id = ls.loan_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nLEFT JOIN m_loan_arrears_aging laa ON laa.loan_id=l.id\r\nWHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND \r\n(DATEDIFF(CURDATE(), l.closedon_date) BETWEEN ${fromX} AND ${toY})\r\n AND (l.loan_status_id IN (600, 700))\r\nGROUP BY l.id\r\nORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no','All loans that have been fully repaid (Closed or Overpaid) in the last fromX to toY days',0,1,0),(178,'Loan outstanding after final instalment date','SMS','NonTriggered','Loan','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\",\r\no.id AS \"officeNumber\",\r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\nls.duedate AS \"paymentDueDate\",\r\n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\r\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.interest_waived_derived),0)\r\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\r\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\r\n) AS \"totalDue\",\r\nlaa.total_overdue_derived AS \"totalOverdue\",\r\nl.account_no AS \"loanAccountId\",\r\ngua.lastname AS \"guarantorLastName\",\r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ngp.display_name AS \"groupName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan l ON l.client_id = c.id\r\nLEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = l.currency_code\r\nLEFT JOIN m_loan_arrears_aging laa ON laa.loan_id = l.id\r\nLEFT JOIN m_group_client gc ON gc.client_id = c.id\r\nLEFT JOIN m_group gp ON gp.id = l.group_id\r\nLEFT JOIN m_loan_repayment_schedule ls ON l.id = ls.loan_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nWHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.loan_status_id = 300 AND l.expected_maturedon_date < CURDATE() \r\nAND (DATEDIFF(CURDATE(), l.expected_maturedon_date) BETWEEN ${fromX} AND ${toY})\r\nGROUP BY l.id\r\nORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no','All active loans (with an outstanding balance) between fromX to toY days after the final instalment date on their loan schedule',0,1,0),(179,'Loan Repayment','SMS','Triggered',NULL,'select ml.id as loanId,mc.id, mc.firstname, ifnull(mc.middlename,\'\') as middlename, mc.lastname, mc.display_name as FullName, mobile_no as mobileNo, mc.group_name as GroupName, round(ml.principal_amount, ml.currency_digits) as LoanAmount, round(ml.`total_outstanding_derived`, ml.currency_digits) as LoanOutstanding,\nml.`account_no` as LoanAccountId, round(mlt.amountPaid, ml.currency_digits) as repaymentAmount\nFROM m_office mo\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\nAND ounder.hierarchy like CONCAT(\'.\', \'%\')\nLEFT JOIN (\n select \n ml.id as loanId, \n ifnull(mc.id,mc2.id) as id, \n ifnull(mc.firstname,mc2.firstname) as firstname, \n ifnull(mc.middlename,ifnull(mc2.middlename,(\'\'))) as middlename, \n ifnull(mc.lastname,mc2.lastname) as lastname, \n ifnull(mc.display_name,mc2.display_name) as display_name, \n ifnull(mc.status_enum,mc2.status_enum) as status_enum,\n ifnull(mc.mobile_no,mc2.mobile_no) as mobile_no,\n ifnull(mg.office_id,mc2.office_id) as office_id,\n ifnull(mg.staff_id,mc2.staff_id) as staff_id,\n mg.id as group_id, \nmg.display_name as group_name\n from\n m_loan ml\n left join m_group mg on mg.id = ml.group_id\n left join m_group_client mgc on mgc.group_id = mg.id\n left join m_client mc on mc.id = mgc.client_id\n left join m_client mc2 on mc2.id = ml.client_id\n order by loanId\n ) mc on mc.office_id = ounder.id\nright join m_loan as ml on mc.loanId = ml.id\nright join(\nselect mlt.amount as amountPaid,mlt.id,mlt.loan_id\nfrom m_loan_transaction mlt\nwhere mlt.is_reversed = 0 \ngroup by mlt.loan_id\n) as mlt on mlt.loan_id = ml.id\nright join m_loan_repayment_schedule as mls1 on ml.id = mls1.loan_id and mls1.`completed_derived` = 0\nand mls1.installment = (SELECT MIN(installment) from m_loan_repayment_schedule where loan_id = ml.id and duedate <= CURDATE() and completed_derived=0)\nwhere mc.status_enum = 300 and mobile_no is not null and ml.`loan_status_id` = 300\nand (mo.id = ${officeId} or ${officeId} = -1)\nand (mc.staff_id = ${loanOfficerId} or ${loanOfficerId} = -1)\nand (ml.loan_type_enum = ${loanType} or ${loanType} = -1)\nand ml.id in (select mla.loan_id from m_loan_arrears_aging mla)\ngroup by ml.id','Loan Repayment',0,0,0),(180,'Loan Approved','SMS','Triggered',NULL,'SELECT mc.id, mc.firstname, mc.middlename as middlename, mc.lastname, mc.display_name as FullName, mc.mobile_no as mobileNo, mc.group_name as GroupName, mo.name as officename, ml.id as loanId, ml.account_no as accountnumber, ml.principal_amount_proposed as loanamount, ml.annual_nominal_interest_rate as annualinterestrate FROM m_office mo JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\') AND ounder.hierarchy like CONCAT(\'.\', \'%\') LEFT JOIN ( select  ml.id as loanId,  ifnull(mc.id,mc2.id) as id,  ifnull(mc.firstname,mc2.firstname) as firstname,  ifnull(mc.middlename,ifnull(mc2.middlename,(\'\'))) as middlename,  ifnull(mc.lastname,mc2.lastname) as lastname,  ifnull(mc.display_name,mc2.display_name) as display_name,  ifnull(mc.status_enum,mc2.status_enum) as status_enum, ifnull(mc.mobile_no,mc2.mobile_no) as mobile_no, ifnull(mg.office_id,mc2.office_id) as office_id, ifnull(mg.staff_id,mc2.staff_id) as staff_id, mg.id as group_id, mg.display_name as group_name from m_loan ml left join m_group mg on mg.id = ml.group_id left join m_group_client mgc on mgc.group_id = mg.id left join m_client mc on mc.id = mgc.client_id left join m_client mc2 on mc2.id = ml.client_id order by loanId ) mc on mc.office_id = ounder.id  left join m_loan ml on ml.id = mc.loanId WHERE mc.status_enum = 300 and mc.mobile_no is not null and (mo.id = ${officeId} or ${officeId} = -1) and (mc.staff_id = ${loanOfficerId} or ${loanOfficerId} = -1)and (ml.id = ${loanId} or ${loanId} = -1)and (mc.id = ${clientId} or ${clientId} = -1)and (mc.group_id = ${groupId} or ${groupId} = -1)and (ml.loan_type_enum = ${loanType} or ${loanType} = -1)','Loan and client data of approved loan',0,0,0),(181,'Loan Rejected','SMS','Triggered',NULL,'SELECT mc.id, mc.firstname, mc.middlename as middlename, mc.lastname, mc.display_name as FullName, mc.mobile_no as mobileNo, mc.group_name as GroupName,  mo.name as officename, ml.id as loanId, ml.account_no as accountnumber, ml.principal_amount_proposed as loanamount, ml.annual_nominal_interest_rate as annualinterestrate  FROM  m_office mo  JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')  AND ounder.hierarchy like CONCAT(\'.\', \'%\')  LEFT JOIN (  select   ml.id as loanId,   ifnull(mc.id,mc2.id) as id,   ifnull(mc.firstname,mc2.firstname) as firstname,   ifnull(mc.middlename,ifnull(mc2.middlename,(\'\'))) as middlename,   ifnull(mc.lastname,mc2.lastname) as lastname,   ifnull(mc.display_name,mc2.display_name) as display_name,   ifnull(mc.status_enum,mc2.status_enum) as status_enum,  ifnull(mc.mobile_no,mc2.mobile_no) as mobile_no,  ifnull(mg.office_id,mc2.office_id) as office_id,  ifnull(mg.staff_id,mc2.staff_id) as staff_id,  mg.id as group_id,  mg.display_name as group_name  from  m_loan ml  left join m_group mg on mg.id = ml.group_id  left join m_group_client mgc on mgc.group_id = mg.id  left join m_client mc on mc.id = mgc.client_id  left join m_client mc2 on mc2.id = ml.client_id  order by loanId  ) mc on mc.office_id = ounder.id  left join m_loan ml on ml.id = mc.loanId  WHERE mc.status_enum = 300 and mc.mobile_no is not null  and (mo.id = ${officeId} or ${officeId} = -1)  and (mc.staff_id = ${loanOfficerId} or ${loanOfficerId} = -1) and (ml.id = ${loanId} or ${loanId} = -1) and (mc.id = ${clientId} or ${clientId} = -1) and (mc.group_id = ${groupId} or ${groupId} = -1)  and (ml.loan_type_enum = ${loanType} or ${loanType} = -1)','Loan and client data of rejected loan',0,0,0),(182,'Client Rejected','SMS','Triggered','Client','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nWHERE o.id = ${officeId} AND c.id = ${clientId} AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})','Client Rejection',0,1,0),(183,'Client Activated','SMS','Triggered','Client','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nWHERE o.id = ${officeId} AND c.id = ${clientId} AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})','Client Activation',0,1,0),(184,'Savings Rejected','SMS','Triggered','Savings','SELECT \r\nc.id AS \"id\",\r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\",\r\ns.account_no AS \"savingsAccountNo\",\r\nounder.id AS \"officeNumber\",\r\nounder.name AS \"officeName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_savings_account s ON s.client_id = c.id\r\nJOIN m_savings_product sp ON sp.id = s.product_id\r\nLEFT JOIN m_staff st ON st.id = s.field_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = s.currency_code\r\nWHERE o.id = ${officeId} AND (IFNULL(s.field_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND s.id = ${savingsId}','Savings Rejected',0,1,0),(185,'Savings Activated','SMS','Triggered','Savings','SELECT \r\nc.id AS \"id\",\r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\",\r\ns.account_no AS \"savingsAccountNo\",\r\nounder.id AS \"officeNumber\",\r\nounder.name AS \"officeName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_savings_account s ON s.client_id = c.id\r\nJOIN m_savings_product sp ON sp.id = s.product_id\r\nLEFT JOIN m_staff st ON st.id = s.field_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = s.currency_code\r\nWHERE o.id = ${officeId} AND (IFNULL(s.field_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND s.id = ${savingsId}','Savings Activation',0,1,0),(186,'Savings Deposit','SMS','Triggered',NULL,'SELECT sc.savingsId AS savingsId, sc.id AS clientId, sc.firstname, IFNULL(sc.middlename,\'\') AS middlename, sc.lastname, sc.display_name AS FullName, sc.mobile_no AS mobileNo,\r\nms.`account_no` AS savingsAccountNo, ROUND(mst.amountPaid, ms.currency_digits) AS depositAmount, ms.account_balance_derived AS balance, \r\nmst.transactionDate AS transactionDate\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\') AND ounder.hierarchy LIKE CONCAT(\'.\', \'%\')\r\nLEFT JOIN (\r\nSELECT \r\n sa.id AS savingsId, mc.id AS id, mc.firstname AS firstname, mc.middlename AS middlename, mc.lastname AS lastname, \r\n mc.display_name AS display_name, mc.status_enum AS status_enum, \r\n mc.mobile_no AS mobile_no, mc.office_id AS office_id, \r\n mc.staff_id AS staff_id\r\nFROM\r\nm_savings_account sa\r\nLEFT JOIN m_client mc ON mc.id = sa.client_id\r\nORDER BY savingsId) sc ON sc.office_id = ounder.id\r\nRIGHT JOIN m_savings_account AS ms ON sc.savingsId = ms.id\r\nRIGHT JOIN(\r\nSELECT st.amount AS amountPaid, st.id, st.savings_account_id, st.id AS savingsTransactionId, st.transaction_date AS transactionDate\r\nFROM m_savings_account_transaction st\r\nWHERE st.is_reversed = 0\r\nGROUP BY st.savings_account_id\r\n) AS mst ON mst.savings_account_id = ms.id\r\nWHERE sc.mobile_no IS NOT NULL AND (mo.id = ${officeId} OR ${officeId} = -1) AND (sc.staff_id = ${loanOfficerId} OR ${loanOfficerId} = -1) AND mst.savingsTransactionId = ${savingsTransactionId}','Savings Deposit',0,1,0),(187,'Savings Withdrawal','SMS','Triggered',NULL,'SELECT sc.savingsId AS savingsId, sc.id AS clientId, sc.firstname, IFNULL(sc.middlename,\'\') AS middlename, sc.lastname, sc.display_name AS FullName, sc.mobile_no AS mobileNo,\r\nms.`account_no` AS savingsAccountNo, ROUND(mst.amountPaid, ms.currency_digits) AS withdrawAmount, ms.account_balance_derived AS balance, \r\nmst.transactionDate AS transactionDate\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\') AND ounder.hierarchy LIKE CONCAT(\'.\', \'%\')\r\nLEFT JOIN (\r\nSELECT \r\n sa.id AS savingsId, mc.id AS id, mc.firstname AS firstname, mc.middlename AS middlename, mc.lastname AS lastname, \r\n mc.display_name AS display_name, mc.status_enum AS status_enum, \r\n mc.mobile_no AS mobile_no, mc.office_id AS office_id, \r\n mc.staff_id AS staff_id\r\nFROM\r\nm_savings_account sa\r\nLEFT JOIN m_client mc ON mc.id = sa.client_id\r\nORDER BY savingsId) sc ON sc.office_id = ounder.id\r\nRIGHT JOIN m_savings_account AS ms ON sc.savingsId = ms.id\r\nRIGHT JOIN(\r\nSELECT st.amount AS amountPaid, st.id, st.savings_account_id, st.id AS savingsTransactionId, st.transaction_date AS transactionDate\r\nFROM m_savings_account_transaction st\r\nWHERE st.is_reversed = 0\r\nGROUP BY st.savings_account_id\r\n) AS mst ON mst.savings_account_id = ms.id\r\nWHERE sc.mobile_no IS NOT NULL AND (mo.id = ${officeId} OR ${officeId} = -1) AND (sc.staff_id = ${loanOfficerId} OR ${loanOfficerId} = -1) AND mst.savingsTransactionId = ${savingsTransactionId}','Savings Withdrawal',0,1,0),(188,'Daily Teller Cash Report (Pentaho)','Pentaho',NULL,NULL,NULL,'Daily Teller Cash Report',1,1,0);
/*!40000 ALTER TABLE `stretchy_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report_parameter`
--

DROP TABLE IF EXISTS `stretchy_report_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `report_parameter_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_parameter_unique` (`report_id`,`parameter_id`),
  KEY `fk_report_parameter_001_idx` (`report_id`),
  KEY `fk_report_parameter_002_idx` (`parameter_id`),
  CONSTRAINT `fk_report_parameter_001` FOREIGN KEY (`report_id`) REFERENCES `stretchy_report` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_report_parameter_002` FOREIGN KEY (`parameter_id`) REFERENCES `stretchy_parameter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report_parameter`
--

LOCK TABLES `stretchy_report_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_report_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_report_parameter` VALUES (1,1,5,NULL),(2,2,5,NULL),(3,2,6,NULL),(4,2,10,NULL),(5,2,20,NULL),(6,2,25,NULL),(7,2,26,NULL),(8,5,5,NULL),(9,5,6,NULL),(10,5,10,NULL),(11,5,20,NULL),(12,5,25,NULL),(13,5,26,NULL),(14,6,5,NULL),(15,6,6,NULL),(16,6,10,NULL),(17,6,20,NULL),(18,6,25,NULL),(19,6,26,NULL),(20,7,5,NULL),(21,7,6,NULL),(22,7,10,NULL),(23,7,20,NULL),(24,7,25,NULL),(25,7,26,NULL),(26,8,5,NULL),(27,8,6,NULL),(28,8,10,NULL),(29,8,25,NULL),(30,8,26,NULL),(31,11,5,NULL),(32,11,6,NULL),(33,11,10,NULL),(34,11,20,NULL),(35,11,25,NULL),(36,11,26,NULL),(37,11,100,NULL),(38,12,5,NULL),(39,12,6,NULL),(40,12,10,NULL),(41,12,20,NULL),(42,12,25,NULL),(43,12,26,NULL),(44,13,1,NULL),(45,13,2,NULL),(46,13,3,NULL),(47,13,5,NULL),(48,13,6,NULL),(49,13,10,NULL),(50,13,20,NULL),(51,13,25,NULL),(52,13,26,NULL),(53,14,1,NULL),(54,14,2,NULL),(55,14,3,NULL),(56,14,5,NULL),(57,14,6,NULL),(58,14,10,NULL),(59,14,20,NULL),(60,14,25,NULL),(61,14,26,NULL),(62,15,5,NULL),(63,15,6,NULL),(64,15,10,NULL),(65,15,20,NULL),(66,15,25,NULL),(67,15,26,NULL),(68,15,100,NULL),(69,16,5,NULL),(70,16,6,NULL),(71,16,10,NULL),(72,16,20,NULL),(73,16,25,NULL),(74,16,26,NULL),(75,16,100,NULL),(76,20,1,NULL),(77,20,2,NULL),(78,20,10,NULL),(79,20,20,NULL),(80,21,1,NULL),(81,21,2,NULL),(82,21,5,NULL),(83,21,10,NULL),(84,21,20,NULL),(85,48,5,'branch'),(86,48,2,'date'),(87,49,5,'branch'),(88,49,1,'fromDate'),(89,49,2,'toDate'),(90,50,5,'branch'),(91,50,1,'fromDate'),(92,50,2,'toDate'),(93,51,1,NULL),(94,51,2,NULL),(95,51,5,NULL),(96,51,10,NULL),(97,51,25,NULL),(98,52,5,NULL),(99,53,5,NULL),(100,53,10,NULL),(101,54,1,NULL),(102,54,2,NULL),(103,54,5,NULL),(104,54,10,NULL),(105,54,25,NULL),(106,55,5,NULL),(107,55,6,NULL),(108,55,10,NULL),(109,55,20,NULL),(110,55,25,NULL),(111,55,26,NULL),(112,56,5,NULL),(113,56,6,NULL),(114,56,10,NULL),(115,56,20,NULL),(116,56,25,NULL),(117,56,26,NULL),(118,56,100,NULL),(119,57,5,NULL),(120,57,6,NULL),(121,57,10,NULL),(122,57,20,NULL),(123,57,25,NULL),(124,57,26,NULL),(125,58,5,NULL),(126,58,6,NULL),(127,58,10,NULL),(128,58,20,NULL),(129,58,25,NULL),(130,58,26,NULL),(131,58,100,NULL),(132,59,1,NULL),(133,59,2,NULL),(134,59,5,NULL),(135,59,6,NULL),(136,59,10,NULL),(137,59,20,NULL),(138,59,25,NULL),(139,59,26,NULL),(140,61,5,NULL),(141,61,10,NULL),(142,92,1,'fromDate'),(143,92,5,'selectOffice'),(144,92,2,'toDate'),(145,93,1,NULL),(146,93,2,NULL),(147,93,5,NULL),(148,93,6,NULL),(149,94,2,'endDate'),(150,94,6,'loanOfficerId'),(151,94,5,'officeId'),(152,94,1,'startDate'),(256,106,2,NULL),(257,106,6,NULL),(258,106,5,NULL),(259,106,1,NULL),(263,118,1,'fromDate'),(264,118,2,'toDate'),(265,118,1004,'accountNo'),(266,119,1,'fromDate'),(267,119,2,'toDate'),(268,119,5,'selectOffice'),(269,119,1005,'selectProduct'),(270,120,5,'branch'),(271,120,6,'loanOfficer'),(272,120,10,'currencyId'),(273,120,20,'fundId'),(274,120,25,'loanProductId'),(275,120,26,'loanPurposeId'),(276,121,5,'Branch'),(277,121,6,'loanOfficer'),(278,121,10,'CurrencyId'),(279,121,20,'fundId'),(280,121,25,'loanProductId'),(281,121,26,'loanPurposeId'),(282,121,100,'parType'),(283,122,5,'Branch'),(284,122,6,'loanOfficer'),(285,122,10,'CurrencyId'),(286,122,20,'fundId'),(287,122,25,'loanProductId'),(288,122,26,'loanPurposeId'),(289,122,1,'startDate'),(290,122,2,'endDate'),(291,123,5,'Branch'),(292,123,6,'Loan Officer'),(293,123,10,'CurrencyId'),(294,123,20,'fundId'),(295,123,25,'loanProductId'),(296,123,26,'loanPurposeId'),(297,123,100,'parType'),(298,124,5,'Branch'),(299,124,6,'Loan Officer'),(300,124,10,'CurrencyId'),(301,124,20,'fundId'),(302,124,25,'loanProductId'),(303,124,26,'loanPurposeId'),(304,125,5,'Branch'),(305,125,6,'Loan Officer'),(306,125,10,'CurrencyId'),(307,125,20,'fundId'),(308,125,25,'loanProductId'),(309,125,26,'loanPurposeId'),(310,125,100,'parType'),(311,126,5,'Branch'),(312,126,6,'Loan Officer'),(313,126,10,'CurrencyId'),(314,126,20,'fundId'),(315,126,25,'loanProductId'),(316,126,26,'loanPurposeId'),(317,127,5,'Branch'),(318,128,5,'Branch'),(319,128,10,'CurrencyId'),(320,129,5,'Branch'),(321,129,10,'CurrencyId'),(322,130,5,'selectOffice'),(323,131,5,'Branch'),(324,131,6,'Loan Officer'),(325,131,10,'CurrencyId'),(326,131,20,'fundId'),(327,131,25,'loanProductId'),(328,131,26,'loanPurposeId'),(329,132,5,'Branch'),(330,132,6,'Loan Officer'),(331,132,1,'startDate'),(332,132,2,'endDate'),(333,133,5,'Branch'),(334,133,10,'CurrencyId'),(335,133,20,'fundId'),(336,133,1,'startDate'),(337,133,2,'endDate'),(338,134,10,'CurrencyId'),(339,134,20,'fundId'),(340,134,1,'startDate'),(341,134,2,'endDate'),(342,135,5,'Branch'),(343,135,6,'Loan Officer'),(344,135,10,'CurrencyId'),(345,135,20,'fundId'),(346,135,25,'loanProductId'),(347,135,26,'loanPurposeId'),(348,136,5,'Branch'),(349,136,6,'Loan Officer'),(350,136,10,'CurrencyId'),(351,136,20,'fundId'),(352,136,25,'loanProductId'),(353,136,26,'loanPurposeId'),(354,137,5,'Branch'),(355,137,6,'Loan Officer'),(356,137,10,'CurrencyId'),(357,137,20,'fundId'),(358,137,25,'loanProductId'),(359,137,26,'loanPurposeId'),(360,138,5,'Branch'),(361,138,6,'Loan Officer'),(362,138,10,'CurrencyId'),(363,138,20,'fundId'),(364,138,25,'loanProductId'),(365,138,26,'loanPurposeId'),(366,139,5,'Branch'),(367,139,6,'Loan Officer'),(368,139,10,'CurrencyId'),(369,139,20,'fundId'),(370,139,25,'loanProductId'),(371,139,26,'loanPurposeId'),(372,139,1,'startDate'),(373,139,2,'endDate'),(374,139,3,'obligDateType'),(375,140,5,'Branch'),(376,140,6,'Loan Officer'),(377,140,10,'CurrencyId'),(378,140,20,'fundId'),(379,140,25,'loanProductId'),(380,140,26,'loanPurposeId'),(381,140,1,'Startdate'),(382,140,2,'Enddate'),(383,140,3,'obligDateType'),(384,141,5,'Branch'),(385,141,6,'Loan Officer'),(386,141,10,'CurrencyId'),(387,141,20,'fundId'),(388,141,25,'loanProductId'),(389,141,26,'loanPurposeId'),(390,141,100,'parType'),(391,142,5,'Branch'),(392,142,6,'loanOfficer'),(393,142,10,'CurrencyId'),(394,142,20,'fundId'),(395,142,25,'loanProductId'),(396,142,26,'loanPurposeId'),(397,142,100,'parType'),(398,143,5,'Branch'),(399,143,10,'CurrencyId'),(400,143,25,'loanProductId'),(401,143,1,'startDate'),(402,143,2,'endDate'),(403,144,5,'Branch'),(404,144,6,'Loan Officer'),(405,144,1,'startDate'),(406,144,2,'endDate'),(407,145,5,'Branch'),(408,145,10,'CurrencyId'),(409,145,25,'loanProductId'),(410,145,1,'startDate'),(411,145,2,'endDate'),(412,146,1,'startDate'),(413,146,2,'endDate'),(414,146,1004,'accountNo'),(415,147,1,'startDate'),(416,147,2,'endDate'),(417,147,1004,'selectLoan'),(418,149,5,''),(419,150,5,''),(420,151,5,''),(421,152,5,''),(422,153,5,''),(423,154,5,''),(424,155,5,''),(425,156,5,''),(426,157,1006,'transactionId'),(427,158,1006,'transactionId'),(428,159,1007,'centerId'),(429,160,1008,'account'),(430,160,1,'fromDate'),(431,160,2,'toDate'),(432,160,5,'branch'),(433,162,5,'branch'),(434,162,1009,'ondate'),(435,163,5,'branch'),(436,163,1,'fromDate'),(437,163,2,'toDate'),(438,164,5,'branch'),(439,164,1,'fromDate'),(440,164,2,'toDate'),(441,165,1010,NULL),(442,165,5,NULL),(443,166,5,'officeId'),(444,166,6,'loanOfficerId'),(445,167,5,'officeId'),(446,167,6,'loanOfficerId'),(447,168,5,'officeId'),(448,168,6,'loanOfficerId'),(449,168,1011,'cycleX'),(450,168,1012,'cycleY'),(451,169,5,'officeId'),(452,169,6,'loanOfficerId'),(453,169,1013,'fromX'),(454,169,1014,'toY'),(455,170,5,'officeId'),(456,170,6,'loanOfficerId'),(457,170,1013,'fromX'),(458,170,1014,'toY'),(459,171,5,'officeId'),(460,171,6,'loanOfficerId'),(461,172,5,'officeId'),(462,172,6,'loanOfficerId'),(463,173,5,'officeId'),(464,173,6,'loanOfficerId'),(465,173,1013,'fromX'),(466,173,1014,'toY'),(467,173,1015,'overdueX'),(468,173,1016,'overdueY'),(469,174,5,'officeId'),(470,174,6,'loanOfficerId'),(471,174,1013,'fromX'),(472,174,1014,'toY'),(473,175,5,'officeId'),(474,175,6,'loanOfficerId'),(475,175,1013,'fromX'),(476,175,1014,'toY'),(477,175,1015,'overdueX'),(478,175,1016,'overdueY'),(479,176,5,'officeId'),(480,176,6,'loanOfficerId'),(481,177,5,'officeId'),(482,177,6,'loanOfficerId'),(483,177,1013,'fromX'),(484,177,1014,'toY'),(485,178,5,'officeId'),(486,178,6,'loanOfficerId'),(487,178,1013,'fromX'),(488,178,1014,'toY'),(489,181,5,'officeId'),(490,180,5,'officeId'),(491,179,5,'officeId'),(492,181,6,'loanOfficerId'),(493,180,6,'loanOfficerId'),(494,179,6,'loanOfficerId'),(495,181,1017,'loanId'),(496,180,1017,'loanId'),(497,181,1018,'clientId'),(498,180,1018,'clientId'),(499,181,1019,'groupId'),(500,180,1019,'groupId'),(501,181,1020,'loanType'),(502,180,1020,'loanType'),(503,179,1020,'loanType'),(504,182,5,'officeId'),(505,183,5,'officeId'),(506,182,6,'loanOfficerId'),(507,183,6,'loanOfficerId'),(508,182,1018,'clientId'),(509,183,1018,'clientId'),(510,184,5,'officeId'),(511,184,6,'loanOfficerId'),(512,184,1021,'savingsId'),(513,185,5,'officeId'),(514,185,6,'loanOfficerId'),(515,185,1021,'savingsId'),(516,186,5,'officeId'),(517,186,6,'loanOfficerId'),(518,186,1022,'savingsTransactionId'),(519,187,5,'officeId'),(520,187,6,'loanOfficerId'),(521,187,1022,'savingsTransactionId'),(522,188,5,'officeId'),(523,188,1023,'tellerId'),(524,188,1024,'cashierId'),(525,188,1025,'currencyCode'),(526,188,1009,'asOnDate');
/*!40000 ALTER TABLE `stretchy_report_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `entity_id` bigint(20) NOT NULL,
  `entity_type` text NOT NULL,
  `member_type` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,'Super user of Head Office',1,1,'OFFICE','SUPER USER'),(2,'Self Service User of Head Office',1,1,'OFFICE','SELF SERVICE USER');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_subscriber`
--

DROP TABLE IF EXISTS `topic_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_subscriber` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `topic_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `subscription_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_topic_has_m_appuser_topic` (`topic_id`),
  KEY `fk_topic_has_m_appuser_m_appuser1` (`user_id`),
  CONSTRAINT `fk_topic_has_m_appuser_m_appuser1` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `fk_topic_has_m_appuser_topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_subscriber`
--

LOCK TABLES `topic_subscriber` WRITE;
/*!40000 ALTER TABLE `topic_subscriber` DISABLE KEYS */;
INSERT INTO `topic_subscriber` VALUES (1,1,1,'2019-04-04');
/*!40000 ALTER TABLE `topic_subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twofactor_access_token`
--

DROP TABLE IF EXISTS `twofactor_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twofactor_access_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `appuser_id` bigint(20) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime NOT NULL,
  `enabled` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_appuser_UNIQUE` (`token`,`appuser_id`),
  KEY `user` (`appuser_id`),
  KEY `token` (`token`),
  CONSTRAINT `fk_2fa_access_token_user_id` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twofactor_access_token`
--

LOCK TABLES `twofactor_access_token` WRITE;
/*!40000 ALTER TABLE `twofactor_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `twofactor_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twofactor_configuration`
--

DROP TABLE IF EXISTS `twofactor_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twofactor_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twofactor_configuration`
--

LOCK TABLES `twofactor_configuration` WRITE;
/*!40000 ALTER TABLE `twofactor_configuration` DISABLE KEYS */;
INSERT INTO `twofactor_configuration` VALUES (1,'otp-delivery-email-enable','true'),(2,'otp-delivery-email-subject','Fineract Two-Factor Authentication Token'),(3,'otp-delivery-email-body','Hello {{username}}.\nYour OTP login token is {{token}}.'),(4,'otp-delivery-sms-enable','false'),(5,'otp-delivery-sms-provider','1'),(6,'otp-delivery-sms-text','Your authentication token for Fineract is {{token}}.'),(7,'otp-token-live-time','300'),(8,'otp-token-length','5'),(9,'access-token-live-time','86400'),(10,'access-token-live-time-extended','604800');
/*!40000 ALTER TABLE `twofactor_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_registered_table`
--

DROP TABLE IF EXISTS `x_registered_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_registered_table` (
  `registered_table_name` varchar(50) NOT NULL,
  `application_table_name` varchar(50) NOT NULL,
  `category` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`registered_table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_registered_table`
--

LOCK TABLES `x_registered_table` WRITE;
/*!40000 ALTER TABLE `x_registered_table` DISABLE KEYS */;
INSERT INTO `x_registered_table` VALUES ('duplicate_loan','m_loan',100),('More Client Details','m_client',100),('motorbike_details','m_client',100);
/*!40000 ALTER TABLE `x_registered_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_table_column_code_mappings`
--

DROP TABLE IF EXISTS `x_table_column_code_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_table_column_code_mappings` (
  `column_alias_name` varchar(50) NOT NULL,
  `code_id` int(10) NOT NULL,
  PRIMARY KEY (`column_alias_name`),
  KEY `FK_x_code_id` (`code_id`),
  CONSTRAINT `FK_x_code_id` FOREIGN KEY (`code_id`) REFERENCES `m_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_table_column_code_mappings`
--

LOCK TABLES `x_table_column_code_mappings` WRITE;
/*!40000 ALTER TABLE `x_table_column_code_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `x_table_column_code_mappings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-09 13:01:35
