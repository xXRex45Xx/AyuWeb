CREATE DATABASE  IF NOT EXISTS `aphmsdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `aphmsdb`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: aphmsdb
-- ------------------------------------------------------
-- Server version	5.7.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__migrationhistory`
--

DROP TABLE IF EXISTS `__migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__migrationhistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ContextKey` varchar(300) NOT NULL,
  `Model` longblob NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`,`ContextKey`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__migrationhistory`
--

LOCK TABLES `__migrationhistory` WRITE;
/*!40000 ALTER TABLE `__migrationhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `__migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `PatientNo` int(11) NOT NULL,
  `DoctorNo` int(11) NOT NULL,
  `DateOfAppointment` date NOT NULL,
  `TimeOfAppointment` time(6) NOT NULL,
  `Remark` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`PatientNo`,`DoctorNo`,`DateOfAppointment`),
  KEY `IX_PatientNo` (`PatientNo`),
  KEY `IX_DoctorNo` (`DoctorNo`),
  CONSTRAINT `FK_dbo.Appointment_dbo.Doctor_DoctorNo` FOREIGN KEY (`DoctorNo`) REFERENCES `doctor` (`doctorNo`),
  CONSTRAINT `FK_dbo.Appointment_dbo.Patient_PatientNo` FOREIGN KEY (`PatientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (29,1,'2022-02-03','10:00:00.000000',0),(29,1,'2022-02-04','10:00:00.000000',0),(29,1,'2022-02-05','10:00:00.000000',0),(29,1,'2022-02-06','10:00:00.000000',0),(29,1,'2022-02-07','10:00:00.000000',0),(29,1,'2022-02-09','10:00:00.000000',0),(29,1,'2022-02-10','10:00:00.000000',0),(30,1,'2022-02-03','12:00:00.000000',0);
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appuser`
--

DROP TABLE IF EXISTS `appuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appuser` (
  `userNo` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL,
  `password` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `role` tinyint(3) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`userNo`),
  UNIQUE KEY `UQ__AppUser__66DCF95CDD3CB569` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appuser`
--

LOCK TABLES `appuser` WRITE;
/*!40000 ALTER TABLE `appuser` DISABLE KEYS */;
INSERT INTO `appuser` VALUES (1,'user1','$2b$12$YKv3LiuyYK0ZGmuH/F78mevhXFwM.gVRVoPtQAxjHAoKBYfmRB5H.',1,0),(2,'user2','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(3,'user3','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(4,'user4','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(5,'user5','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(6,'user6','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(7,'user7','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(8,'user8','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(9,'user9','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(10,'user10','$2b$12$m6FNxeXzoIS.Y8H9MMvYeOmscdcD5WQlMzdkAswMLg1tXrfuWYuVW',1,0),(11,'user11','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(12,'user12','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(13,'user13','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(14,'user14','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(15,'user15','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(16,'user16','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(17,'user17','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(18,'user18','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(19,'user19','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(20,'user20','$2b$12$Hvw4lht3hhY.cOkKUxKXtuJbJSGVQRxyf/vzgRlcEFcyDBGKANjz.',0,0),(22,'askfjl90','$2b$12$1BOSL4QsuTK0ybcdLUyzqu39MoT6Yy6x/ZPQEW7d9TP4MR9ip/v.C',1,0),(24,'askfjalksdsf90','$2b$12$3On318wxwaRe839aGL5quOKZG6xS3/MES3VC353eTcmu5eelTtGUW',1,0),(25,'asjdkjfklj90','$2b$12$OFcHTRwslJ7aVlYmtYKlReFDXNRLRK5W4FIesbEKtww9KFVT1yTnC',1,0),(26,'askdfjksa90','$2b$12$XBTXiaFkRAAref1G099wcuLUNaDmYBWefWZR9Z67PnehHszeigJJa',1,0),(27,'Testtt90','$2b$12$QQA9659hJSWuA8AW3F/65uhRKmAkG7au4bVee1xBh8eO8ZD1wc406',1,0),(28,'askfjdladl11','$2b$12$jSi0MlSLcLEvMyjgS0pauOPUiQxeAKgb1NSycjK9lyr3qv1MSS1HC',2,0),(29,'aksfjklssajf11','$2b$12$PE58jisNBquunZVvmwYwkui44YVkLrclX7YECqlG5NQ9B9RYCdB1K',2,0),(31,'askdfdjkasdjf11','$2b$12$CWqaaP7eKKueYsHveEBio.4h03VfALfSYtHIHCpfVPmTTwrENaduy',2,0),(32,'klasjdflkjasf11','$2b$12$Uq1a3wKMP5alGMcKpkm7tuZAlkOGOTRqOjWEFvFlBWBErJxTtfzc2',2,0),(33,'asdkfjkasdf11','$2b$12$yCAPipWIXGG6w0bA1vnOP.GJy.mxYtkPVgCbMSEKTZ0GDA4DRyEmC',2,0),(34,'asjklddjfakls03','$2b$12$DFtzeSSzDU45JACdCy0Ise1JHd3GSQt27QHvMsZQt53TvIKAn2Ud6',2,0),(35,'lab11','$2b$12$/mElJTS7rryutY1wUPNstOnX/.EDoQn/4SNWIZx8XT2B30dR1p8dm',6,0),(36,'labtech90','$2b$12$TMGJs3zOH/dhysqDB/krNuxv0jn0S0YA1qu0T28tAhZn1cXWw682.',6,0),(37,'doctor34','$2b$12$oX9eIvkFTA6hC6IdkerVTO29Brc3HuEHmn6cQ.1ANejPS0a9vjO2e',2,0);
/*!40000 ALTER TABLE `appuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card` (
  `cardNo` varchar(10) NOT NULL,
  `patientNo` int(11) NOT NULL,
  PRIMARY KEY (`cardNo`),
  UNIQUE KEY `UQ__Card__A1702D6D0A40C543` (`patientNo`),
  KEY `IX_PatientNo` (`patientNo`),
  CONSTRAINT `fk_PatientCard` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES ('A0000',29),('A0001',30),('A0002',31),('A0003',32),('A0004',34),('A0005',35),('A0006',36),('A0007',37),('A0008',38),('A0009',39),('A00010',40),('A0010',43),('A0011',44),('A0012',45),('A0013',46),('A0014',47);
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosis` (
  `cardNo` varchar(10) NOT NULL,
  `dateOfDiagnosis` date NOT NULL,
  `doctorNo` int(11) NOT NULL,
  `diagnosisDetails` longtext NOT NULL,
  KEY `IX_CardNo` (`cardNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  CONSTRAINT `fk_CardDiagnosis` FOREIGN KEY (`cardNo`) REFERENCES `card` (`cardNo`),
  CONSTRAINT `fk_DoctorDiagnosis` FOREIGN KEY (`doctorNo`) REFERENCES `doctor` (`doctorNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosis`
--

LOCK TABLES `diagnosis` WRITE;
/*!40000 ALTER TABLE `diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `doctorNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `speciality` varchar(50) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`doctorNo`),
  UNIQUE KEY `UQ__Doctor__CB9A040DCEC2B0E8` (`userNo`),
  UNIQUE KEY `UQ__Doctor__960F17EFEAF7FD5C` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_DoctorUser` FOREIGN KEY (`userNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Test','Test','1998-01-01',111,'ENT',5),(3,'asjklddjfakls','kaslfjklsadfj','1993-08-24',103,'gp',34),(4,'doctor','doctor','1985-05-19',1234,'gp',37);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctororder`
--

DROP TABLE IF EXISTS `doctororder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctororder` (
  `orderNo` int(11) NOT NULL AUTO_INCREMENT,
  `doctorNo` int(11) NOT NULL,
  `nurseNo` int(11) NOT NULL,
  `patientNo` int(11) NOT NULL,
  `orderDetail` longtext NOT NULL,
  `dateOfOrder` date NOT NULL,
  `timeOfOrder` time(6) NOT NULL,
  PRIMARY KEY (`orderNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  KEY `IX_NurseNo` (`nurseNo`),
  KEY `IX_PatientNo` (`patientNo`),
  CONSTRAINT `fk_DoctorOrder` FOREIGN KEY (`doctorNo`) REFERENCES `doctor` (`doctorNo`),
  CONSTRAINT `fk_NurseOrder` FOREIGN KEY (`nurseNo`) REFERENCES `nurse` (`nurseNo`),
  CONSTRAINT `fk_PatientOrder` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctororder`
--

LOCK TABLES `doctororder` WRITE;
/*!40000 ALTER TABLE `doctororder` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctororder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `itemNo` varchar(10) NOT NULL,
  `itemName` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `unitPrice` decimal(19,4) NOT NULL,
  PRIMARY KEY (`itemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventoryrecieve`
--

DROP TABLE IF EXISTS `inventoryrecieve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventoryrecieve` (
  `supplierNo` int(11) NOT NULL,
  `itemNo` varchar(10) NOT NULL,
  `pharmacistNo` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `unitPrice` decimal(19,4) NOT NULL,
  `totalPrice` decimal(19,4) DEFAULT NULL,
  `dateOfReceive` date NOT NULL,
  `timeOfReceive` time(6) NOT NULL,
  PRIMARY KEY (`supplierNo`,`itemNo`,`dateOfReceive`),
  KEY `IX_SupplierNo` (`supplierNo`),
  KEY `IX_ItemNo` (`itemNo`),
  KEY `IX_PharmacistNo` (`pharmacistNo`),
  CONSTRAINT `fk_ItemSupplier` FOREIGN KEY (`supplierNo`) REFERENCES `supplier` (`supplierNo`),
  CONSTRAINT `fk_PharmacistReceived` FOREIGN KEY (`pharmacistNo`) REFERENCES `pharmacist` (`pharmacistNo`),
  CONSTRAINT `fk_ReceivedItemNo` FOREIGN KEY (`itemNo`) REFERENCES `inventory` (`itemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventoryrecieve`
--

LOCK TABLES `inventoryrecieve` WRITE;
/*!40000 ALTER TABLE `inventoryrecieve` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventoryrecieve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventorytransfer`
--

DROP TABLE IF EXISTS `inventorytransfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventorytransfer` (
  `transferTo` varchar(50) NOT NULL,
  `itemNo` varchar(10) NOT NULL,
  `pharmacistNo` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unitPrice` decimal(19,4) NOT NULL,
  `totalPrice` decimal(19,4) NOT NULL,
  `dateOfTransfer` date NOT NULL,
  `timeOfTransfer` time(6) NOT NULL,
  PRIMARY KEY (`transferTo`,`itemNo`,`dateOfTransfer`,`timeOfTransfer`),
  KEY `IX_ItemNo` (`itemNo`),
  KEY `IX_PharmacistNo` (`pharmacistNo`),
  CONSTRAINT `fk_Pharmacist` FOREIGN KEY (`pharmacistNo`) REFERENCES `pharmacist` (`pharmacistNo`),
  CONSTRAINT `fk_itemNoSent` FOREIGN KEY (`itemNo`) REFERENCES `inventory` (`itemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventorytransfer`
--

LOCK TABLES `inventorytransfer` WRITE;
/*!40000 ALTER TABLE `inventorytransfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventorytransfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labreport`
--

DROP TABLE IF EXISTS `labreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labreport` (
  `RequestNo` bigint(20) NOT NULL,
  `ReportType` varchar(15) NOT NULL,
  `Result` varchar(20) DEFAULT '___',
  `NormalValue` varchar(20) DEFAULT '___',
  `technicianNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`RequestNo`,`ReportType`),
  KEY `IX_RequestNo` (`RequestNo`),
  KEY `fk_labreport_labtechnician_technicianNo_idx` (`technicianNo`),
  CONSTRAINT `FK_dbo.LabReport_dbo.LabRequest_RequestNo` FOREIGN KEY (`RequestNo`) REFERENCES `labrequest` (`RequestNo`),
  CONSTRAINT `fk_labreport_labtechnician_technicianNo` FOREIGN KEY (`technicianNo`) REFERENCES `labtechnician` (`technicianNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_labrequest_labreport_requestNo` FOREIGN KEY (`RequestNo`) REFERENCES `labrequest` (`RequestNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labreport`
--

LOCK TABLES `labreport` WRITE;
/*!40000 ALTER TABLE `labreport` DISABLE KEYS */;
INSERT INTO `labreport` VALUES (1,'Barium Studies',NULL,NULL,NULL),(1,'IVP',NULL,NULL,NULL),(1,'Ultra Sound',NULL,NULL,NULL),(2,'Barium Studies','___','___',NULL),(2,'HSG','sa','sa',NULL),(2,'IVP','yu','yu',NULL);
/*!40000 ALTER TABLE `labreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labrequest`
--

DROP TABLE IF EXISTS `labrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labrequest` (
  `RequestNo` bigint(20) NOT NULL AUTO_INCREMENT,
  `DoctorNo` int(11) NOT NULL,
  `PatientNo` int(11) NOT NULL,
  `DateTimeOfRequest` datetime(6) NOT NULL,
  PRIMARY KEY (`RequestNo`),
  KEY `IX_DoctorNo` (`DoctorNo`),
  KEY `IX_PatientNo` (`PatientNo`),
  CONSTRAINT `FK_dbo.LabRequest_dbo.Doctor_DoctorNo` FOREIGN KEY (`DoctorNo`) REFERENCES `doctor` (`doctorNo`),
  CONSTRAINT `FK_dbo.LabRequest_dbo.Patient_PatientNo` FOREIGN KEY (`PatientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labrequest`
--

LOCK TABLES `labrequest` WRITE;
/*!40000 ALTER TABLE `labrequest` DISABLE KEYS */;
INSERT INTO `labrequest` VALUES (1,4,29,'2022-02-07 20:08:12.000000'),(2,4,30,'2022-02-07 20:12:28.000000');
/*!40000 ALTER TABLE `labrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labtechnician`
--

DROP TABLE IF EXISTS `labtechnician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labtechnician` (
  `technicianNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`technicianNo`),
  UNIQUE KEY `UQ__LabTechn__CB9A040D37E40F36` (`userNo`),
  UNIQUE KEY `UQ__LabTechn__960F17EFBBFDD360` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_TechnicianUser` FOREIGN KEY (`userNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labtechnician`
--

LOCK TABLES `labtechnician` WRITE;
/*!40000 ALTER TABLE `labtechnician` DISABLE KEYS */;
INSERT INTO `labtechnician` VALUES (2,'Test','Test','1998-01-01',111,6),(3,'labtech','labtech','1984-02-19',1234567890,36);
/*!40000 ALTER TABLE `labtechnician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management`
--

DROP TABLE IF EXISTS `management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `management` (
  `managementNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`managementNo`),
  UNIQUE KEY `UQ__Manageme__CB9A040D3D580403` (`userNo`),
  UNIQUE KEY `UQ__Manageme__960F17EF4835FF94` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_ManagementUser` FOREIGN KEY (`userNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management`
--

LOCK TABLES `management` WRITE;
/*!40000 ALTER TABLE `management` DISABLE KEYS */;
/*!40000 ALTER TABLE `management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `management_completedpaymentsview`
--

DROP TABLE IF EXISTS `management_completedpaymentsview`;
/*!50001 DROP VIEW IF EXISTS `management_completedpaymentsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_completedpaymentsview` AS SELECT 
 1 AS `PaymentNumber`,
 1 AS `ReceptionName`,
 1 AS `PatientName`,
 1 AS `PaymentDetails`,
 1 AS `DateOfPayment`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_doctor_infoview`
--

DROP TABLE IF EXISTS `management_doctor_infoview`;
/*!50001 DROP VIEW IF EXISTS `management_doctor_infoview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_doctor_infoview` AS SELECT 
 1 AS `DoctorNumber`,
 1 AS `DoctorName`,
 1 AS `DateOfBirth`,
 1 AS `PhoneNumber`,
 1 AS `Speciality`,
 1 AS `UserName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_doctor_searchview`
--

DROP TABLE IF EXISTS `management_doctor_searchview`;
/*!50001 DROP VIEW IF EXISTS `management_doctor_searchview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_doctor_searchview` AS SELECT 
 1 AS `DoctorNumber`,
 1 AS `DoctorName`,
 1 AS `PhoneNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_labtechnician_infoview`
--

DROP TABLE IF EXISTS `management_labtechnician_infoview`;
/*!50001 DROP VIEW IF EXISTS `management_labtechnician_infoview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_labtechnician_infoview` AS SELECT 
 1 AS `TechnicianNumber`,
 1 AS `TechnicianName`,
 1 AS `DateOfBirth`,
 1 AS `PhoneNumber`,
 1 AS `UserName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_labtechnician_searchview`
--

DROP TABLE IF EXISTS `management_labtechnician_searchview`;
/*!50001 DROP VIEW IF EXISTS `management_labtechnician_searchview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_labtechnician_searchview` AS SELECT 
 1 AS `TechnicianNumber`,
 1 AS `TechnicianName`,
 1 AS `PhoneNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_patient_appointmentview`
--

DROP TABLE IF EXISTS `management_patient_appointmentview`;
/*!50001 DROP VIEW IF EXISTS `management_patient_appointmentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_patient_appointmentview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `DoctorName`,
 1 AS `DateOfAppointment`,
 1 AS `TimeOfAppointment`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_patient_completedpaymentview`
--

DROP TABLE IF EXISTS `management_patient_completedpaymentview`;
/*!50001 DROP VIEW IF EXISTS `management_patient_completedpaymentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_patient_completedpaymentview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `PaymentNumber`,
 1 AS `PaymentDetails`,
 1 AS `DateOfPayment`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_patient_infoview`
--

DROP TABLE IF EXISTS `management_patient_infoview`;
/*!50001 DROP VIEW IF EXISTS `management_patient_infoview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_patient_infoview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `Name`,
 1 AS `Age`,
 1 AS `Gender`,
 1 AS `CardNumber`,
 1 AS `Address`,
 1 AS `PhoneNumber`,
 1 AS `Hospitalized`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_patient_pendingpaymentview`
--

DROP TABLE IF EXISTS `management_patient_pendingpaymentview`;
/*!50001 DROP VIEW IF EXISTS `management_patient_pendingpaymentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_patient_pendingpaymentview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `PaymentNumber`,
 1 AS `PaymentDetails`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_patient_searchview`
--

DROP TABLE IF EXISTS `management_patient_searchview`;
/*!50001 DROP VIEW IF EXISTS `management_patient_searchview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_patient_searchview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `FirstName`,
 1 AS `FatherName`,
 1 AS `PhoneNumber`,
 1 AS `CardNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_patient_updateview`
--

DROP TABLE IF EXISTS `management_patient_updateview`;
/*!50001 DROP VIEW IF EXISTS `management_patient_updateview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_patient_updateview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `FirstName`,
 1 AS `FatherName`,
 1 AS `DateOfBirth`,
 1 AS `Gender`,
 1 AS `Address`,
 1 AS `PhoneNumber`,
 1 AS `Hospitalized`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_reception_infoview`
--

DROP TABLE IF EXISTS `management_reception_infoview`;
/*!50001 DROP VIEW IF EXISTS `management_reception_infoview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_reception_infoview` AS SELECT 
 1 AS `ReceptionNumber`,
 1 AS `ReceptionName`,
 1 AS `DateOfBirth`,
 1 AS `PhoneNumber`,
 1 AS `UserName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_reception_searchview`
--

DROP TABLE IF EXISTS `management_reception_searchview`;
/*!50001 DROP VIEW IF EXISTS `management_reception_searchview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_reception_searchview` AS SELECT 
 1 AS `ReceptionNumber`,
 1 AS `ReceptionName`,
 1 AS `PhoneNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `management_reception_transactionsview`
--

DROP TABLE IF EXISTS `management_reception_transactionsview`;
/*!50001 DROP VIEW IF EXISTS `management_reception_transactionsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `management_reception_transactionsview` AS SELECT 
 1 AS `PaymentNumber`,
 1 AS `ReceptionNumber`,
 1 AS `PatientName`,
 1 AS `PaymentDetails`,
 1 AS `DateOfPayment`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `medicationdetail`
--

DROP TABLE IF EXISTS `medicationdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicationdetail` (
  `nurseNo` int(11) NOT NULL,
  `patientNo` int(11) NOT NULL,
  `orderNo` int(11) NOT NULL,
  `dateOfMedication` date NOT NULL,
  `timeOfMedication` time(6) NOT NULL,
  `medication` varchar(300) NOT NULL,
  `dose` varchar(10) NOT NULL,
  `route` varchar(10) NOT NULL,
  `frequency` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`nurseNo`,`patientNo`,`dateOfMedication`,`timeOfMedication`),
  KEY `IX_NurseNo` (`nurseNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_OrderNo` (`orderNo`),
  CONSTRAINT `fk_MedicationOrder` FOREIGN KEY (`orderNo`) REFERENCES `doctororder` (`orderNo`),
  CONSTRAINT `fk_NurseMedication` FOREIGN KEY (`nurseNo`) REFERENCES `nurse` (`nurseNo`),
  CONSTRAINT `fk_PatientMedication` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicationdetail`
--

LOCK TABLES `medicationdetail` WRITE;
/*!40000 ALTER TABLE `medicationdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicationdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitordetail`
--

DROP TABLE IF EXISTS `monitordetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitordetail` (
  `nurseNo` int(11) NOT NULL,
  `patientNo` int(11) NOT NULL,
  `dateOfMonitor` date NOT NULL,
  `timeOfMonitor` time(6) NOT NULL,
  `vitalSignNo` int(11) NOT NULL,
  `input` varchar(50) DEFAULT NULL,
  `output` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nurseNo`,`patientNo`,`dateOfMonitor`,`timeOfMonitor`),
  KEY `IX_NurseNo` (`nurseNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_VitalSignNo` (`vitalSignNo`),
  CONSTRAINT `fk_MonitorVitalSign` FOREIGN KEY (`vitalSignNo`) REFERENCES `vitalsign` (`vitalSignNo`),
  CONSTRAINT `fk_NurseMonitor` FOREIGN KEY (`nurseNo`) REFERENCES `nurse` (`nurseNo`),
  CONSTRAINT `fk_PatientMonitor` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitordetail`
--

LOCK TABLES `monitordetail` WRITE;
/*!40000 ALTER TABLE `monitordetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitordetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse` (
  `nurseNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`nurseNo`),
  UNIQUE KEY `UQ__Nurse__CB9A040D15A57408` (`userNo`),
  UNIQUE KEY `UQ__Nurse__960F17EFC7E53FF3` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_NurseUser` FOREIGN KEY (`userNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patientNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phoneNo` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`patientNo`),
  KEY `idx_PhoneNo` (`phoneNo`,`firstName`,`fatherName`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (29,'TESSS','TESSSSS','2014-07-21','M','kjdsalkdjf',111,0),(30,'Esrom Mulugeta','Tadesse','2015-10-23','M','Lebu',111,0),(31,'kasdddjflas','kjaslkdfjlk','2010-04-21','M','ajskdfjlk',111,0),(32,'TES','TES','2016-06-15','M','here',111,1),(33,'RegTest','RegTest','2002-06-17','M','here',111,0),(34,'RegTest','RegTest','2015-01-24','M','here',111,0),(35,'askldjfladsfsadf','fsadfadsfsadf','2013-07-27','F','sdajfkj',111,1),(36,'aksjfkl','lkfjsajsflk','2010-10-25','M','adskjflasjfld',111,0),(37,'kajsldkfj','kjaskdsfjlkajf','2006-07-23','M','ajkfjkadjsfk',111,0),(38,'aksdjdfskl','jkjfaskdjflk','2008-07-20','M','asdkjfkljl',111,0),(39,'kjkjl;j','kjkljlkjlk','2014-12-31','M','hjhjkhjklh',111,0),(40,'esse','saassa','1999-02-21','M','Lebu',929036035,0),(41,'aksdjdflksdajdf','asjflkjalsfdda','2010-03-21','M','aslssfklsjdfk',111,0),(42,'askdfjlk','aksdfjlk','2010-08-22','M','askdfjkasjfk',111,0),(43,'akjflksajfd','aksdjflk','2011-04-22','M','ajkssfdjl',111,0),(44,'asdfjlkasjflk','klajsdlkjflkasf','2011-05-22','M','askdjflkjasdf',111,0),(45,'asdsjfl','adkfjlk','2010-07-23','F','akldsfjlk',111,1),(46,'sadjaksdjfklj','kajdskflsa','2005-02-12','M','akfljsadlfjlk',111,0),(47,'ajksdaafj','akdfkj','2015-05-24','M','sajfdlksafd',111,1);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patientprogress`
--

DROP TABLE IF EXISTS `patientprogress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patientprogress` (
  `progressNo` int(11) NOT NULL,
  `patientNo` int(11) NOT NULL,
  `doctorNo` int(11) NOT NULL,
  `dateOfProgressNote` date NOT NULL,
  `timeOfProgressNote` time(6) NOT NULL,
  `clinicalNote` longtext NOT NULL,
  PRIMARY KEY (`progressNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  CONSTRAINT `fk_DoctorProgress` FOREIGN KEY (`doctorNo`) REFERENCES `doctor` (`doctorNo`),
  CONSTRAINT `fk_PatientProgress` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patientprogress`
--

LOCK TABLES `patientprogress` WRITE;
/*!40000 ALTER TABLE `patientprogress` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientprogress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `paymentNo` int(11) NOT NULL AUTO_INCREMENT,
  `receptionNo` int(11) DEFAULT NULL,
  `patientNo` int(11) NOT NULL,
  `paymentDetails` varchar(1000) DEFAULT NULL,
  `price` decimal(19,4) NOT NULL,
  `dateOfPayment` date DEFAULT NULL,
  `PaymentCompleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`paymentNo`),
  KEY `IX_ReceptionNo` (`receptionNo`),
  KEY `IX_PatientNo` (`patientNo`),
  CONSTRAINT `fk_PatientPayment` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`),
  CONSTRAINT `fk_ReceptionPayment` FOREIGN KEY (`receptionNo`) REFERENCES `reception` (`receptionNo`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (55,NULL,29,'TESt',50.0000,'2022-01-31',1),(56,NULL,29,'TESt',50.0000,'2022-01-31',1),(57,NULL,29,'TESt',50.0000,'2022-01-31',1),(58,NULL,29,'TESt',50.0000,'2022-01-31',1),(60,NULL,29,'Test',50.0000,'2022-01-30',1),(61,NULL,29,'Test',50.0000,'2022-01-30',1),(62,NULL,29,'Test',50.0000,'2022-01-30',1),(63,NULL,29,'Test',50.0000,'2022-01-30',1),(64,NULL,29,'Test',50.0000,'2022-01-30',1),(65,NULL,29,'Test',50.0000,'2022-01-30',1),(66,NULL,29,'Test',50.0000,'2022-01-30',1),(67,NULL,29,'Test',50.0000,'2022-01-30',1),(68,NULL,29,'Test',50.0000,'2022-01-30',1),(69,NULL,29,'Test',50.0000,'2022-01-30',1),(70,NULL,29,'Test',50.0000,'2022-01-30',1),(71,NULL,29,'Test',50.0000,'2022-01-30',1),(72,NULL,29,'Test',50.0000,'2022-01-30',1),(73,NULL,29,'Test',50.0000,'2022-01-30',1),(74,NULL,29,'Test',50.0000,'2022-01-30',1),(75,NULL,29,'Test',50.0000,'2022-01-30',1),(76,NULL,29,'Test',50.0000,'2022-01-30',1),(77,NULL,29,'Test',50.9900,'2022-01-30',1),(78,NULL,29,'Test',50.9900,'2022-01-31',1),(79,NULL,29,'Test',50.0000,'2022-01-31',1),(80,NULL,29,'Test',50.0000,'2022-01-31',1),(81,NULL,29,'Test',50.0000,'2022-01-31',1),(82,NULL,29,'Test',50.0000,'2022-01-31',1),(83,NULL,29,'Test',50.0000,'2022-01-31',1),(84,NULL,29,'Test',50.0000,'2022-01-31',1),(85,NULL,29,'Test',50.0000,'2022-01-31',1),(86,NULL,29,'Test',50.0000,'2022-01-31',1),(87,NULL,29,'Test',50.0000,'2022-01-31',1),(88,NULL,29,'Test',50.0000,'2022-01-31',1),(89,NULL,29,'Test',50.0000,'2022-01-31',1),(90,NULL,29,'Test',50.0000,'2022-01-31',1),(91,NULL,29,'Test',50.0000,'2022-01-31',1),(92,NULL,29,'Test',50.0000,'2022-01-31',1),(93,NULL,29,'Test',50.0000,'2022-01-31',1),(94,NULL,29,'Test',50.9900,'2022-01-31',1),(95,NULL,29,'Test',50.9900,'2022-01-31',1),(96,NULL,29,'Test',50.0000,'2022-01-31',1),(97,NULL,29,'Test',50.0000,'2022-01-31',1),(98,NULL,29,'Test',50.0000,'2022-01-31',1),(99,NULL,29,'Test',50.0000,'2022-01-31',1),(100,NULL,29,'Test',50.0000,'2022-01-31',1),(101,NULL,29,'Test',50.0000,'2022-01-31',1),(102,NULL,29,'Test',50.0000,'2022-01-31',1),(103,NULL,29,'Test',50.0000,'2022-01-31',1),(104,NULL,29,'Test',50.0000,'2022-01-31',1),(105,NULL,29,'Test',50.0000,'2022-01-31',1),(106,NULL,29,'Test',50.0000,'2022-01-31',1),(107,NULL,29,'Test',50.0000,'2022-01-31',1),(108,NULL,29,'Test',50.0000,'2022-01-31',1),(109,NULL,29,'Test',50.0000,'2022-01-31',1),(110,NULL,29,'Test',50.0000,'2022-01-31',1),(111,NULL,29,'Test',50.9900,'2022-01-31',1),(112,NULL,29,'Test',50.9900,'2022-01-31',1),(113,NULL,29,'Test',50.0000,'2022-01-31',1),(114,NULL,29,'Test',50.0000,'2022-01-31',1),(115,NULL,29,'Test',50.0000,'2022-01-31',1),(116,NULL,29,'Test',50.0000,'2022-01-31',1),(117,NULL,29,'Test',50.0000,'2022-01-31',1),(118,NULL,29,'Test',50.0000,'2022-01-31',1),(119,NULL,29,'Test',50.0000,'2022-01-31',1),(120,NULL,29,'Test',50.0000,'2022-01-31',1),(121,NULL,29,'Test',50.0000,'2022-01-31',1),(122,NULL,29,'Test',50.0000,'2022-01-31',1),(123,NULL,29,'Test',50.0000,'2022-01-31',1),(124,NULL,29,'Test',50.0000,'2022-01-31',1),(125,NULL,29,'Test',50.0000,'2022-01-31',1),(126,NULL,29,'Test',50.0000,'2022-01-31',1),(127,NULL,29,'Test',50.0000,'2022-02-02',1),(128,NULL,29,'Test',50.9900,'2022-01-31',1),(129,NULL,34,'Registeration',80.0000,'2022-01-31',1),(130,NULL,35,'Registeration',80.0000,NULL,0),(131,NULL,36,'Registeration',80.0000,NULL,0),(132,NULL,37,'Registeration',80.0000,NULL,0),(133,NULL,38,'Registeration',80.0000,NULL,0),(134,NULL,39,'Registeration',80.0000,NULL,0),(135,NULL,40,'Registeration',80.0000,NULL,0),(136,NULL,43,'Registeration',80.0000,'2022-02-02',1),(137,NULL,44,'Registeration',80.0000,'2022-02-02',1),(138,NULL,45,'Registeration',80.0000,'2022-02-02',1),(139,3,46,'Registeration',80.0000,'2022-02-03',1),(140,NULL,47,'Registeration',80.0000,'2022-02-03',1),(141,NULL,29,'Lab Request',30.0000,'2022-02-07',0),(142,NULL,30,'Lab Request',30.0000,'2022-02-07',0);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacist`
--

DROP TABLE IF EXISTS `pharmacist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacist` (
  `pharmacistNo` int(11) NOT NULL AUTO_INCREMENT,
  `firtName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`pharmacistNo`),
  UNIQUE KEY `UQ__Pharmaci__CB9A040D9683112F` (`userNo`),
  UNIQUE KEY `UQ__Pharmaci__960F17EFC8BC1892` (`phoneNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacist`
--

LOCK TABLES `pharmacist` WRITE;
/*!40000 ALTER TABLE `pharmacist` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacycashier`
--

DROP TABLE IF EXISTS `pharmacycashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacycashier` (
  `cashierNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`cashierNo`),
  UNIQUE KEY `UQ__Pharmacy__CB9A040D27B822C3` (`userNo`),
  UNIQUE KEY `UQ__Pharmacy__960F17EF2813C482` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_PharmacyCashier` FOREIGN KEY (`userNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacycashier`
--

LOCK TABLES `pharmacycashier` WRITE;
/*!40000 ALTER TABLE `pharmacycashier` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacycashier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `prescriptionNo` int(11) NOT NULL AUTO_INCREMENT,
  `patientNo` int(11) NOT NULL,
  `doctorNo` int(11) NOT NULL,
  `pharmacistNo` int(11) DEFAULT NULL,
  `totalPrice` decimal(19,4) NOT NULL,
  PRIMARY KEY (`prescriptionNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  KEY `IX_PharmacistNo` (`pharmacistNo`),
  CONSTRAINT `fk_DoctorPrescription` FOREIGN KEY (`doctorNo`) REFERENCES `doctor` (`doctorNo`),
  CONSTRAINT `fk_PatientPrescription` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`),
  CONSTRAINT `fk_PharmacistPrescription` FOREIGN KEY (`pharmacistNo`) REFERENCES `pharmacist` (`pharmacistNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptiondetail`
--

DROP TABLE IF EXISTS `prescriptiondetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptiondetail` (
  `detail` longtext NOT NULL,
  `prescriptionNo` int(11) NOT NULL,
  KEY `ClusteredIndexPrescriptionNumber` (`prescriptionNo`),
  KEY `IX_PrescriptionNo` (`prescriptionNo`),
  CONSTRAINT `fk_PrescriptionDetail` FOREIGN KEY (`prescriptionNo`) REFERENCES `prescription` (`prescriptionNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptiondetail`
--

LOCK TABLES `prescriptiondetail` WRITE;
/*!40000 ALTER TABLE `prescriptiondetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescriptiondetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiologist`
--

DROP TABLE IF EXISTS `radiologist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `radiologist` (
  `RadiologistNo` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(25) NOT NULL,
  `FatherName` varchar(25) NOT NULL,
  `DateOfBirth` datetime(6) NOT NULL,
  `PhoneNo` int(11) NOT NULL,
  `UserNo` int(11) NOT NULL,
  PRIMARY KEY (`RadiologistNo`),
  KEY `IX_UserNo` (`UserNo`),
  CONSTRAINT `FK_dbo.Radiologist_dbo.AppUser_UserNo` FOREIGN KEY (`UserNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiologist`
--

LOCK TABLES `radiologist` WRITE;
/*!40000 ALTER TABLE `radiologist` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiologist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiologyrequestandreport`
--

DROP TABLE IF EXISTS `radiologyrequestandreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `radiologyrequestandreport` (
  `PatientNo` int(11) NOT NULL,
  `DoctorNo` int(11) NOT NULL,
  `DateOfRequest` datetime(6) NOT NULL,
  `RequestType` varchar(60) NOT NULL,
  `ExamTypeDetail` varchar(200) DEFAULT NULL,
  `ClinicalData` varchar(400) DEFAULT NULL,
  `Report` varchar(2500) DEFAULT NULL,
  `DateOfReport` datetime(6) DEFAULT NULL,
  `RadiologistNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`PatientNo`,`DoctorNo`,`DateOfRequest`),
  KEY `IX_PatientNo` (`PatientNo`),
  KEY `IX_DoctorNo` (`DoctorNo`),
  KEY `IX_RadiologistNo` (`RadiologistNo`),
  CONSTRAINT `FK_dbo.RadiologyRequestAndReport_dbo.Doctor_DoctorNo` FOREIGN KEY (`DoctorNo`) REFERENCES `doctor` (`doctorNo`),
  CONSTRAINT `FK_dbo.RadiologyRequestAndReport_dbo.Patient_PatientNo` FOREIGN KEY (`PatientNo`) REFERENCES `patient` (`patientNo`),
  CONSTRAINT `FK_dbo.RadiologyRequestAndReport_dbo.Radiologist_RadiologistNo` FOREIGN KEY (`RadiologistNo`) REFERENCES `radiologist` (`RadiologistNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiologyrequestandreport`
--

LOCK TABLES `radiologyrequestandreport` WRITE;
/*!40000 ALTER TABLE `radiologyrequestandreport` DISABLE KEYS */;
/*!40000 ALTER TABLE `radiologyrequestandreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reception`
--

DROP TABLE IF EXISTS `reception`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reception` (
  `receptionNo` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  PRIMARY KEY (`receptionNo`),
  UNIQUE KEY `UQ__Receptio__CB9A040DD6FEE076` (`userNo`),
  UNIQUE KEY `UQ__Receptio__960F17EF1ED88C89` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_ReceptionUser` FOREIGN KEY (`userNo`) REFERENCES `appuser` (`userNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reception`
--

LOCK TABLES `reception` WRITE;
/*!40000 ALTER TABLE `reception` DISABLE KEYS */;
INSERT INTO `reception` VALUES (3,'Testtt','Testtt','2003-12-09',1234567890,27);
/*!40000 ALTER TABLE `reception` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reception_patient_completedpaymentview`
--

DROP TABLE IF EXISTS `reception_patient_completedpaymentview`;
/*!50001 DROP VIEW IF EXISTS `reception_patient_completedpaymentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reception_patient_completedpaymentview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `PatientName`,
 1 AS `PaymentNumber`,
 1 AS `PaymentDetails`,
 1 AS `DateOfPayment`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `reception_patient_pendingpaymentview`
--

DROP TABLE IF EXISTS `reception_patient_pendingpaymentview`;
/*!50001 DROP VIEW IF EXISTS `reception_patient_pendingpaymentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reception_patient_pendingpaymentview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `PaymentNumber`,
 1 AS `PaymentDetails`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `receptionpatientappointmentview`
--

DROP TABLE IF EXISTS `receptionpatientappointmentview`;
/*!50001 DROP VIEW IF EXISTS `receptionpatientappointmentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `receptionpatientappointmentview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `DoctorName`,
 1 AS `DateOfAppointment`,
 1 AS `TimeOfAppointment`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `receptionpatientinfoview`
--

DROP TABLE IF EXISTS `receptionpatientinfoview`;
/*!50001 DROP VIEW IF EXISTS `receptionpatientinfoview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `receptionpatientinfoview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `Name`,
 1 AS `Age`,
 1 AS `Gender`,
 1 AS `CardNumber`,
 1 AS `Address`,
 1 AS `PhoneNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `receptionpatientsearchview`
--

DROP TABLE IF EXISTS `receptionpatientsearchview`;
/*!50001 DROP VIEW IF EXISTS `receptionpatientsearchview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `receptionpatientsearchview` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `FirstName`,
 1 AS `FatherName`,
 1 AS `PhoneNumber`,
 1 AS `CardNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `FSNo` int(11) NOT NULL,
  `reference` varchar(25) NOT NULL,
  `grandTotal` decimal(19,4) NOT NULL,
  `pharmacyCashierNo` int(11) NOT NULL,
  PRIMARY KEY (`FSNo`),
  KEY `IX_PharmacyCashierNo` (`pharmacyCashierNo`),
  CONSTRAINT `fk_CashierSale` FOREIGN KEY (`pharmacyCashierNo`) REFERENCES `pharmacycashier` (`cashierNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saledetail`
--

DROP TABLE IF EXISTS `saledetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saledetail` (
  `detialNo` int(11) NOT NULL,
  `saleNo` int(11) NOT NULL,
  `itemNo` varchar(10) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `quantity` int(11) NOT NULL,
  `totalPrice` decimal(19,4) NOT NULL,
  `dateOfSale` date NOT NULL,
  `timeOfSale` time(6) NOT NULL,
  PRIMARY KEY (`detialNo`),
  KEY `IX_SaleNo` (`saleNo`),
  KEY `IX_ItemNo` (`itemNo`),
  CONSTRAINT `fk_ItemSale` FOREIGN KEY (`itemNo`) REFERENCES `inventory` (`itemNo`),
  CONSTRAINT `fk_SaleDetail` FOREIGN KEY (`saleNo`) REFERENCES `sale` (`FSNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saledetail`
--

LOCK TABLES `saledetail` WRITE;
/*!40000 ALTER TABLE `saledetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `saledetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `sid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session` text COLLATE utf8_unicode_ci NOT NULL,
  `expires` int(11) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('2Sih_KjFvWOyysOGayMY9sJsDLtE59Xr','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T08:50:46.016Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}',1644310246),('cR6rtTrsC6SVfR1_5sZ_e6zalT5N0W1g','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T08:51:23.333Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}',1644310283),('eswbJnimyEW6GJOXE82i988Wxl4JbeTB','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T08:51:31.819Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}',1644310292),('h4Hh9bR3dSGXzLz_HoNasKiEu_u94yW7','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T08:51:05.080Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}',1644310265),('Him31vWMI0R_MZZHKn5Nw6i_hEuroSzb','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T08:51:03.236Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}',1644310263),('njqpPGPe0k7sr7UAJ3z1Zsk14ren-3j1','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T17:12:44.350Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"user\":{\"userId\":36,\"username\":\"labtech90\",\"role\":6}}',1644340364),('PgAlm0PrSkPDbuHTL7SICAVhKsgrREEN','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2022-02-08T08:52:19.943Z\",\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}',1644310340);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplierNo` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phoneNo` int(11) NOT NULL,
  PRIMARY KEY (`supplierNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysdiagrams`
--

DROP TABLE IF EXISTS `sysdiagrams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysdiagrams` (
  `name` varchar(160) NOT NULL,
  `principal_id` int(11) NOT NULL,
  `diagram_id` int(11) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `definition` longblob,
  PRIMARY KEY (`diagram_id`),
  UNIQUE KEY `UK_principal_name` (`principal_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysdiagrams`
--

LOCK TABLES `sysdiagrams` WRITE;
/*!40000 ALTER TABLE `sysdiagrams` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysdiagrams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vitalsign`
--

DROP TABLE IF EXISTS `vitalsign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vitalsign` (
  `vitalSignNo` int(11) NOT NULL AUTO_INCREMENT,
  `BPHigh` double NOT NULL,
  `BPLow` double NOT NULL,
  `PR` double NOT NULL,
  `RR` double NOT NULL,
  `Temprature` double NOT NULL,
  `SPO2` double NOT NULL,
  `Pain` double NOT NULL,
  `patientNo` int(11) NOT NULL,
  PRIMARY KEY (`vitalSignNo`),
  KEY `fk_Patient_VitalSign` (`patientNo`),
  CONSTRAINT `fk_Patient_VitalSign` FOREIGN KEY (`patientNo`) REFERENCES `patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vitalsign`
--

LOCK TABLES `vitalsign` WRITE;
/*!40000 ALTER TABLE `vitalsign` DISABLE KEYS */;
/*!40000 ALTER TABLE `vitalsign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'aphmsdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_AddAppointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_AddAppointment`(
	in `@PatientNo` int,
    in `@DoctorNo` int,
    in `@DateOfAppointment` date,
    in `@TimeOfAppointment` time
)
begin
insert into appointment (PatientNo, DoctorNo, DateOfAppointment,TimeOfAppointment) values 
(`@PatientNo`,(select doctorNo from doctor where userNo =`@DoctorNo`),`@DateOfAppointment`,`@TimeOfAppointment`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_AddDiagnosis` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_AddDiagnosis`(
	in `@patientNo` int,
    in `@dateOfDiagnosis` date,
    in `@userNo` int,
    in `@diagnosisDetails` longtext)
begin
	insert into diagnosis (cardNo, dateOfDiagnosis, doctorNo, diagnosisDetails) values
    ((select cardNO from card where patientNo = `@patientNo`), `@dateOfDiagnosis`, (select doctorNo from doctor where userNo =`@userNo`), `@diagnosisDetails`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_AddLabRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_AddLabRequest`(
	in `@userId` int,
    in `@patientNo` int,
    in `@date` date
)
begin
insert into labrequest (DoctorNo, PatientNo, DateTimeOfRequest)  values((select doctorNo from doctor where userNo = `@userId`),`@patientNo`, now());
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_AddLabRequestDetail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_AddLabRequestDetail`(
	in `@RequestNo` bigint,
    in `@ReportType` varchar(15)
)
begin
insert into labreport (RequestNo, ReportType) values(`@RequestNo`, `@ReportType`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_AddLabRequestPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_AddLabRequestPayment`(
	in `@patientNo` int,
	in `@price` decimal,
    in `@dateOfPayment` date
)
begin
	insert into payment (patientNo,paymentDetails,Price,dateOfPayment)
    values (`@patientNo`,'Lab Request',`@price`,`@dateOfPayment`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_GetCountOfAppointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_GetCountOfAppointment`(
	in `@PatientNo` int,
    in `@DoctorNo` int,
    in `@DateOfAppointment` date
)
begin
 select * from appointment where PatientNo = `@PatientNo`and DoctorNo = (select doctorNo from doctor where userNo =`@DoctorNo`) and DateOfAppointment = `@DateOfAppointment`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_GetLabReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_GetLabReport`(	in `@patientNo` int)
begin
	SELECT labrequest.RequestNo, labrequest.PatientNo, labrequest.DateTimeOfRequest, labreport.ReportType, labreport.NormalValue, labreport.Result
FROM labreport 
inner join labrequest on labreport.RequestNo =labrequest.RequestNo
where labrequest.PatientNo = `@patientNo`
order by labrequest.RequestNo desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_GetLastLabRequestId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_GetLastLabRequestId`()
begin
select RequestNo from labrequest order by RequestNo desc limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_GetVitalSign` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_GetVitalSign`(	in `@vitalSignNo` int)
begin
	select * from vitalsign 
    where vitalSignNo = `@vitalSignNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDoctor_UpdateAppointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDoctor_UpdateAppointment`(
	in `@PatientNo` int,
    in `@DoctorNo` int,
    in `@DateOfAppointment` date,
    in `@TimeOfAppointment` time)
begin
delete from appointment 
where `DoctorNo` = (select doctorNo from doctor where userNo =`@DoctorNo`) 
and (`PatientNo`= `@PatientNo`) and (`DateOfAppointment`=`@DateOfAppointment`);
call spDoctor_AddAppointment(`@PatientNo`,`@DoctorNo`,`@DateOfAppointment`,`@TimeOfAppointment`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUser`(in `@username` varchar(50))
begin
	select 
		userNo as UserNumber,
		userName as UserName,
        password as Password,
        role as Role
	from AppUser
    where `@username` = userName;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetUserById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUserById`(in `@userNo` int)
begin
	select 
		userNo as UserNumber,
		userName as UserName,
        password as Password,
        role as Role
	from AppUser
    where `@userNo` = userNo;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLaboratorist_AddLabReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLaboratorist_AddLabReport`(
	in `@patientNo` int,
    in `@ReportType` varchar(15),
    in `@Result` varchar(20),
    in `@NormalValue` varchar(20))
begin
UPDATE labreport SET `Result` = `@Result`, `NormalValue` = `@NormalValue`
WHERE 	(`RequestNo` = (select RequestNo from labrequest where PatientNo = `@patientNo` order by RequestNo desc limit 1)) 
	and 
		(`ReportType` = `@ReportType`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_AddDoctor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_AddDoctor`(
	in `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@phoneNo` int,
    `@speciality` varchar(50),
    `@userNo` int
)
begin
	insert into Doctor (firstName, fatherName, dateOfBirth, phoneNo, speciality, userNo) values
    (`@firstName`, `@fatherName`, `@dateOfBirth`, `@phoneNo`, `@speciality`, `@userNo`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_AddLabTechnician` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_AddLabTechnician`(
	in `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@phoneNo` int,
    `@userNo` int
)
begin
	insert into LabTechnician (firstName, fatherName, dateOfBirth, phoneNo, userNo) values
    (`@firstName`, `@fatherName`, `@dateOfBirth`, `@phoneNo`, `@userNo`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_AddReception` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_AddReception`(
	in `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@phoneNo` int,
    `@userNo` int)
begin
	insert into reception (firstName, fatherName, dateOfBirth, phoneNo, userNo) values
    (`@firstName`, `@fatherName`, `@dateOfBirth`, `@phoneNo`, `@userNo`);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_AddUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_AddUser`(
	in `@username` varchar(50),
    `@password` char(60) binary,
    `@role` tinyint)
begin
	insert into AppUser (userName, password, role) values
    (`@username`, `@password`, `@role`);
    select last_insert_id() as lastUserNo;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetAllEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetAllEmployee`()
begin
	select * from Management_Doctor_InfoView;
    select * from Management_Reception_InfoView;
    select * from Management_LabTechnician_InfoView;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetDailyTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetDailyTransactions`(in `@dateOfPayment` date)
begin
	select PaymentNumber, ReceptionName, PatientName, PaymentDetails, DATE_FORMAT(DateOfPayment, "%a, %b %e, %Y") as DateOfPayment, Price 
    from Management_CompletedPaymentsView
    where DateOfPayment = `@dateOfPayment`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetDoctorInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetDoctorInfo`(in `@doctorNo` int)
begin
	select * from Management_Doctor_InfoView
    where DoctorNumber = `@doctorNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetFullPatientInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetFullPatientInfo`(in `@patientNo` int)
begin
	select * from Management_Patient_UpdateView
    where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetLabTechnicianInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetLabTechnicianInfo`(in `@labTechNo` int)
begin
	select * from Management_LabTechnician_InfoView
    where TechnicianNumber = `@labTechNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetPatientAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetPatientAppointments`(in `@patientNo` int)
begin
	select * from Management_Patient_AppointmentView
	where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetPatientCompletedPayments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetPatientCompletedPayments`(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Management_Patient_CompletedPaymentView
    where  PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetPatientInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetPatientInfo`(in `@patientNo` int)
begin
	select * from Management_Patient_InfoView
	where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetPatientPendingPayments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetPatientPendingPayments`(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, Price
    from Management_Patient_PendingPaymentView
    where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetReceptionInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetReceptionInfo`(in `@receptionNo` int)
begin
	select * from Management_Reception_InfoView
    where ReceptionNumber = `@receptionNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_GetReceptionTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_GetReceptionTransactions`(in `@receptionNo` int)
begin
	select * from Management_Reception_TransactionsView
    where ReceptionNumber = `@receptionNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_LoadDashboardData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_LoadDashboardData`()
begin
	select COUNT(*) as HospitalizedPatients from Patient
    where type = true;
    
    select COUNT(distinct cardNo) as TodaysPatients from diagnosis
    where dateOfDiagnosis = CURDATE();
    
    select SUM(price) as TotalIncome from payment
    where dateOfPayment = CURDATE() and PaymentCompleted = true;
    
    select weekday(dateOfPayment) as DayOfWeek, sum(price) as TotalIncome from Payment
	where week(dateOfPayment) = week(now()) and PaymentCompleted = true
	group by weekday(dateOfPayment);
    
    select
		CONCAT(Pat.firstName, ' ', Pat.fatherName) as PatientName,
		Pay.paymentDetails as PaymentDetails,
		Pay.price as Price,
		Pat.phoneNo as PhoneNumber
	from payment as Pay
	join patient as Pat
		on Pay.patientNo = Pat.patientNo
	where PaymentCompleted = true
	order by paymentNo desc
	limit 5;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_SearchEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_SearchEmployee`(in `@phoneNo` int)
begin
	select * from Management_Doctor_InfoView
    where PhoneNumber = `@phoneNo`;
    select * from Management_LabTechnician_InfoView
    where PhoneNumber = `@phoneNo`;
    select * from Management_Reception_InfoView
    where PhoneNumber = `@phoneNo`;    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_SearchPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_SearchPatient`(in `@phoneNo` int)
begin
	select * from Management_Patient_SearchView
	where PhoneNumber = `@phoneNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_SearchReception` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_SearchReception`(in `@phoneNo` int)
begin
	select * from Management_Reception_SearchView
    where PhoneNumber = `@phoneNo`;   
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_UpdatePatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_UpdatePatient`(
	in `@patientNo` int,
    `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@gender` char,
    `@address` varchar(100),
    `@phoneNo` int,
    `@hospitalized` tinyint)
begin
	update Patient
	set firstName = `@firstName`,
		fatherName = `@fatherName`,
		dateOfBirth = `@dateOfBirth`,
		gender = `@gender`,
		address = `@address`,
		phoneNo = `@phoneNo`,
		type = `@hospitalized`
	where patientNo = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spManagement_UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spManagement_UpdateUser`(
	in `@patientNo` int,
    `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@gender` char,
    `@address` varchar(100),
    `@phoneNo` int,
    `@hospitalized` tinyint)
update Patient
set firstName = `@firstName`,
	fatherName = `@fatherName`,
    dateOfBirth = `@dateOfBirth`,
    gender = `@gender`,
    address = `@address`,
    phoneNo = `@phoneNo`,
    type = `@hospitalized`
where patientNo = `@patientNo`; ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_AddCardandRegFee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_AddCardandRegFee`(
	in `@patientNo` int,
    in `@cardNo` varchar(10))
begin
	insert into Card(patientNo, cardNo) values
    (`@patientNo`, `@cardNo`);
    insert into Payment (patientNo, paymentDetails, price) values
    (`@patientNo`, "Registeration", 80);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_AddPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_AddPatient`(
	in `@firstName` varchar(25),
    in `@fatherName` varchar(25),
    in `@dateOfBirth` date,
    in `@gender` varchar(1),
    in `@address` varchar(100),
    in `@phoneNum` int,
    in `@hospitalized` tinyint(1))
begin
	insert into Patient(firstName, fatherName, dateOfBirth, gender, address, phoneNo, type) values
    (`@firstName`, `@fatherName`, `@dateOfBirth`, `@gender`, `@address`, `@phoneNum`, `@hospitalized`);
    select last_insert_id() as lastId;
    select max(cardNo) as lastCardNo from Card;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_CancelPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_CancelPayment`(in `@paymentNo` int)
begin
	delete from Payment 
    where `@paymentNo` = paymentNo and PaymentCompleted = 0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_FinalizePayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_FinalizePayment`( 
	in `@paymentNo` int,
    in `@dateOfPayment` date,
    `@userNo` int)
begin
	declare `@receptionNo` int;
    set `@receptionNo` = 
		(select receptionNo from reception
			where userNo = `@userNo`);
	update Payment
    set receptionNo = `@receptionNo`,
		dateOfPayment = `@dateOfPayment`,
		PaymentCompleted = true
	where paymentNo = `@paymentNo`;
	
    select PatientNumber, PatientName, PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Reception_Patient_CompletedPaymentView
    where PaymentNumber = `@paymentNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_GetPatientAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_GetPatientAppointments`(in `@patientNo` int)
begin
	select * from ReceptionPatientAppointmentView
	where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_GetPatientCompletedPayments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_GetPatientCompletedPayments`(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Reception_Patient_CompletedPaymentView
    where  PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_GetPatientInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_GetPatientInfo`(in `@patientNo` int)
begin
	select * from ReceptionPatientInfoView
	where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_GetPatientPendingPayments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_GetPatientPendingPayments`(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, Price
    from Reception_Patient_PendingPaymentView
    where PatientNumber = `@patientNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_LoadDashboardData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_LoadDashboardData`()
begin
	select COUNT(*) as HospitalizedPatients from Patient
    where type = true;
    
    select COUNT(*) TodaysAppointments from Appointment
    where DateOfAppointment = CURDATE();
    
    select COUNT(distinct cardNo) as TodaysPatients from diagnosis
    where dateOfDiagnosis = CURDATE();
    
    select SUM(price) as TotalIncome from payment
    where dateOfPayment = CURDATE() and PaymentCompleted = true;
    
    select weekday(dateOfAppointment) as DayOfWeek, count(patientNo) as NumberOfAppointments from Appointment
	where week(dateOfAppointment) = week(now())
	group by weekday(dateOfAppointment);
    
    select weekday(dateOfPayment) as DayOfWeek, sum(price) as TotalIncome from Payment
	where week(dateOfPayment) = week(now()) and PaymentCompleted = true
	group by weekday(dateOfPayment);
    
    select
		CONCAT(Pat.firstName, ' ', Pat.fatherName) as PatientName,
		Pay.paymentDetails as PaymentDetails,
		Pay.price as Price,
		Pat.phoneNo as PhoneNumber
	from payment as Pay
	join patient as Pat
		on Pay.patientNo = Pat.patientNo
	where PaymentCompleted = false
	order by paymentNo desc;
	-- limit 5;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spReception_SearchPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_SearchPatient`(in `@phoneNo` int)
begin
	select * from ReceptionPatientSearchView
	where PhoneNumber = `@phoneNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateUser`(
	in `@userNo` int,
	`@newPassword` char(60) binary
    )
begin
	update AppUser
    set password = `@newPassword`
    where userNo = `@userNo`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `management_completedpaymentsview`
--

/*!50001 DROP VIEW IF EXISTS `management_completedpaymentsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_completedpaymentsview` AS select `pay`.`paymentNo` AS `PaymentNumber`,concat(`r`.`firstName`,' ',`r`.`fatherName`) AS `ReceptionName`,concat(`pat`.`firstName`,' ',`pat`.`fatherName`) AS `PatientName`,`pay`.`paymentDetails` AS `PaymentDetails`,`pay`.`dateOfPayment` AS `DateOfPayment`,`pay`.`price` AS `Price` from ((`payment` `pay` join `reception` `r` on((`pay`.`receptionNo` = `r`.`receptionNo`))) join `patient` `pat` on((`pay`.`patientNo` = `pat`.`patientNo`))) where (`pay`.`PaymentCompleted` = TRUE) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_doctor_infoview`
--

/*!50001 DROP VIEW IF EXISTS `management_doctor_infoview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_doctor_infoview` AS select `d`.`doctorNo` AS `DoctorNumber`,concat(`d`.`firstName`,' ',`d`.`fatherName`) AS `DoctorName`,date_format(`d`.`dateOfBirth`,'%a, %b %e, %Y') AS `DateOfBirth`,`d`.`phoneNo` AS `PhoneNumber`,`d`.`speciality` AS `Speciality`,`u`.`userName` AS `UserName` from (`doctor` `d` join `appuser` `u` on((`d`.`userNo` = `u`.`userNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_doctor_searchview`
--

/*!50001 DROP VIEW IF EXISTS `management_doctor_searchview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_doctor_searchview` AS select `doctor`.`doctorNo` AS `DoctorNumber`,concat(`doctor`.`firstName`,' ',`doctor`.`fatherName`) AS `DoctorName`,`doctor`.`phoneNo` AS `PhoneNumber` from `doctor` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_labtechnician_infoview`
--

/*!50001 DROP VIEW IF EXISTS `management_labtechnician_infoview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_labtechnician_infoview` AS select `t`.`technicianNo` AS `TechnicianNumber`,concat(`t`.`firstName`,' ',`t`.`fatherName`) AS `TechnicianName`,date_format(`t`.`dateOfBirth`,'%a, %b %e, %Y') AS `DateOfBirth`,`t`.`phoneNo` AS `PhoneNumber`,`u`.`userName` AS `UserName` from (`labtechnician` `t` join `appuser` `u` on((`t`.`userNo` = `u`.`userNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_labtechnician_searchview`
--

/*!50001 DROP VIEW IF EXISTS `management_labtechnician_searchview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_labtechnician_searchview` AS select `labtechnician`.`technicianNo` AS `TechnicianNumber`,concat(`labtechnician`.`firstName`,' ',`labtechnician`.`fatherName`) AS `TechnicianName`,`labtechnician`.`phoneNo` AS `PhoneNumber` from `labtechnician` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_patient_appointmentview`
--

/*!50001 DROP VIEW IF EXISTS `management_patient_appointmentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_patient_appointmentview` AS select `a`.`PatientNo` AS `PatientNumber`,concat((`d`.`firstName` + ' '),`d`.`fatherName`) AS `DoctorName`,date_format(`a`.`DateOfAppointment`,'%a, %b %e, %Y') AS `DateOfAppointment`,`a`.`TimeOfAppointment` AS `TimeOfAppointment` from (`appointment` `a` join `doctor` `d` on((`a`.`DoctorNo` = `d`.`doctorNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_patient_completedpaymentview`
--

/*!50001 DROP VIEW IF EXISTS `management_patient_completedpaymentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_patient_completedpaymentview` AS select `pay`.`patientNo` AS `PatientNumber`,`pay`.`paymentNo` AS `PaymentNumber`,`pay`.`paymentDetails` AS `PaymentDetails`,date_format(`pay`.`dateOfPayment`,'%a, %b %e, %Y') AS `DateOfPayment`,`pay`.`price` AS `Price` from (`payment` `pay` join `patient` `pat` on((`pay`.`patientNo` = `pat`.`patientNo`))) where (`pay`.`PaymentCompleted` = TRUE) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_patient_infoview`
--

/*!50001 DROP VIEW IF EXISTS `management_patient_infoview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_patient_infoview` AS select `p`.`patientNo` AS `PatientNumber`,concat(`p`.`firstName`,' ',`p`.`fatherName`) AS `Name`,((to_days(curdate()) - to_days(`p`.`dateOfBirth`)) / 365) AS `Age`,`p`.`gender` AS `Gender`,`c`.`cardNo` AS `CardNumber`,`p`.`address` AS `Address`,`p`.`phoneNo` AS `PhoneNumber`,`p`.`type` AS `Hospitalized` from (`patient` `p` join `card` `c` on((`p`.`patientNo` = `c`.`patientNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_patient_pendingpaymentview`
--

/*!50001 DROP VIEW IF EXISTS `management_patient_pendingpaymentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_patient_pendingpaymentview` AS select `pay`.`patientNo` AS `PatientNumber`,`pay`.`paymentNo` AS `PaymentNumber`,`pay`.`paymentDetails` AS `PaymentDetails`,`pay`.`price` AS `Price` from (`payment` `pay` join `patient` `pat` on((`pay`.`patientNo` = `pat`.`patientNo`))) where (`pay`.`PaymentCompleted` = FALSE) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_patient_searchview`
--

/*!50001 DROP VIEW IF EXISTS `management_patient_searchview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_patient_searchview` AS select `p`.`patientNo` AS `PatientNumber`,`p`.`firstName` AS `FirstName`,`p`.`fatherName` AS `FatherName`,`p`.`phoneNo` AS `PhoneNumber`,`c`.`cardNo` AS `CardNumber` from (`patient` `p` join `card` `c` on((`p`.`patientNo` = `c`.`patientNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_patient_updateview`
--

/*!50001 DROP VIEW IF EXISTS `management_patient_updateview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_patient_updateview` AS select `patient`.`patientNo` AS `PatientNumber`,`patient`.`firstName` AS `FirstName`,`patient`.`fatherName` AS `FatherName`,date_format(`patient`.`dateOfBirth`,'%Y-%m-%d') AS `DateOfBirth`,`patient`.`gender` AS `Gender`,`patient`.`address` AS `Address`,`patient`.`phoneNo` AS `PhoneNumber`,`patient`.`type` AS `Hospitalized` from `patient` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_reception_infoview`
--

/*!50001 DROP VIEW IF EXISTS `management_reception_infoview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_reception_infoview` AS select `r`.`receptionNo` AS `ReceptionNumber`,concat(`r`.`firstName`,' ',`r`.`fatherName`) AS `ReceptionName`,date_format(`r`.`dateOfBirth`,'%a, %b %e, %Y') AS `DateOfBirth`,`r`.`phoneNo` AS `PhoneNumber`,`u`.`userName` AS `UserName` from (`reception` `r` join `appuser` `u` on((`r`.`userNo` = `u`.`userNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_reception_searchview`
--

/*!50001 DROP VIEW IF EXISTS `management_reception_searchview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_reception_searchview` AS select `reception`.`receptionNo` AS `ReceptionNumber`,concat(`reception`.`firstName`,' ',`reception`.`fatherName`) AS `ReceptionName`,`reception`.`phoneNo` AS `PhoneNumber` from `reception` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_reception_transactionsview`
--

/*!50001 DROP VIEW IF EXISTS `management_reception_transactionsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `management_reception_transactionsview` AS select `pay`.`paymentNo` AS `PaymentNumber`,`pay`.`receptionNo` AS `ReceptionNumber`,concat(`pat`.`firstName`,' ',`pat`.`fatherName`) AS `PatientName`,`pay`.`paymentDetails` AS `PaymentDetails`,date_format(`pay`.`dateOfPayment`,'%a, %b %e, %Y') AS `DateOfPayment`,`pay`.`price` AS `Price` from ((`payment` `pay` join `reception` `r` on((`pay`.`receptionNo` = `r`.`receptionNo`))) join `patient` `pat` on((`pay`.`patientNo` = `pat`.`patientNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reception_patient_completedpaymentview`
--

/*!50001 DROP VIEW IF EXISTS `reception_patient_completedpaymentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reception_patient_completedpaymentview` AS select `pat`.`patientNo` AS `PatientNumber`,concat(`pat`.`firstName`,' ',`pat`.`fatherName`) AS `PatientName`,`pay`.`paymentNo` AS `PaymentNumber`,`pay`.`paymentDetails` AS `PaymentDetails`,date_format(`pay`.`dateOfPayment`,'%a, %b %e, %Y') AS `DateOfPayment`,`pay`.`price` AS `Price` from (`payment` `pay` join `patient` `pat` on((`pay`.`patientNo` = `pat`.`patientNo`))) where (`pay`.`PaymentCompleted` = TRUE) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reception_patient_pendingpaymentview`
--

/*!50001 DROP VIEW IF EXISTS `reception_patient_pendingpaymentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reception_patient_pendingpaymentview` AS select `pay`.`patientNo` AS `PatientNumber`,`pay`.`paymentNo` AS `PaymentNumber`,`pay`.`paymentDetails` AS `PaymentDetails`,`pay`.`price` AS `Price` from (`payment` `pay` join `patient` `pat` on((`pay`.`patientNo` = `pat`.`patientNo`))) where (`pay`.`PaymentCompleted` = FALSE) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `receptionpatientappointmentview`
--

/*!50001 DROP VIEW IF EXISTS `receptionpatientappointmentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `receptionpatientappointmentview` AS select `a`.`PatientNo` AS `PatientNumber`,concat(`d`.`firstName`,' ',`d`.`fatherName`) AS `DoctorName`,date_format(`a`.`DateOfAppointment`,'%a, %b %e, %Y') AS `DateOfAppointment`,`a`.`TimeOfAppointment` AS `TimeOfAppointment` from (`appointment` `a` join `doctor` `d` on((`a`.`DoctorNo` = `d`.`doctorNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `receptionpatientinfoview`
--

/*!50001 DROP VIEW IF EXISTS `receptionpatientinfoview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `receptionpatientinfoview` AS select `p`.`patientNo` AS `PatientNumber`,concat(`p`.`firstName`,' ',`p`.`fatherName`) AS `Name`,((to_days(curdate()) - to_days(`p`.`dateOfBirth`)) / 365) AS `Age`,`p`.`gender` AS `Gender`,`c`.`cardNo` AS `CardNumber`,`p`.`address` AS `Address`,`p`.`phoneNo` AS `PhoneNumber` from (`patient` `p` join `card` `c` on((`p`.`patientNo` = `c`.`patientNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `receptionpatientsearchview`
--

/*!50001 DROP VIEW IF EXISTS `receptionpatientsearchview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `receptionpatientsearchview` AS select `p`.`patientNo` AS `PatientNumber`,`p`.`firstName` AS `FirstName`,`p`.`fatherName` AS `FatherName`,`p`.`phoneNo` AS `PhoneNumber`,`c`.`cardNo` AS `CardNumber` from (`patient` `p` join `card` `c` on((`p`.`patientNo` = `c`.`patientNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-07 21:31:24
