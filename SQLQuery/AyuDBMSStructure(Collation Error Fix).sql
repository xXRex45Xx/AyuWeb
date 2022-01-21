CREATE DATABASE  IF NOT EXISTS `APHMSDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `APHMSDB`;
-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: APHMSDB
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `AppUser`
--

DROP TABLE IF EXISTS `AppUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppUser` (
  `userNo` int NOT NULL,
  `userName` varchar(50) CHARACTER SET utf8mb4  NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4  NOT NULL,
  `role` tinyint unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`userNo`),
  UNIQUE KEY `UQ__AppUser__6E2DBEDE90185B9D` (`password`),
  UNIQUE KEY `UQ__AppUser__66DCF95CDD3CB569` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Appointment`
--

DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointment` (
  `PatientNo` int NOT NULL,
  `DoctorNo` int NOT NULL,
  `DateOfAppointment` date NOT NULL,
  `TimeOfAppointment` time(6) NOT NULL,
  `Remark` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`PatientNo`,`DoctorNo`,`DateOfAppointment`),
  KEY `IX_PatientNo` (`PatientNo`),
  KEY `IX_DoctorNo` (`DoctorNo`),
  CONSTRAINT `FK_dbo.Appointment_dbo.Doctor_DoctorNo` FOREIGN KEY (`DoctorNo`) REFERENCES `Doctor` (`doctorNo`),
  CONSTRAINT `FK_dbo.Appointment_dbo.Patient_PatientNo` FOREIGN KEY (`PatientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Card`
--

DROP TABLE IF EXISTS `Card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Card` (
  `cardNo` varchar(10) NOT NULL,
  `patientNo` int NOT NULL,
  PRIMARY KEY (`cardNo`),
  UNIQUE KEY `UQ__Card__A1702D6D0A40C543` (`patientNo`),
  KEY `IX_PatientNo` (`patientNo`),
  CONSTRAINT `fk_PatientCard` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Diagnosis`
--

DROP TABLE IF EXISTS `Diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Diagnosis` (
  `cardNo` varchar(10) NOT NULL,
  `dateOfDiagnosis` date NOT NULL,
  `doctorNo` int NOT NULL,
  `diagnosisDetails` longtext NOT NULL,
  PRIMARY KEY (`cardNo`,`dateOfDiagnosis`),
  KEY `IX_CardNo` (`cardNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  CONSTRAINT `fk_CardDiagnosis` FOREIGN KEY (`cardNo`) REFERENCES `Card` (`cardNo`),
  CONSTRAINT `fk_DoctorDiagnosis` FOREIGN KEY (`doctorNo`) REFERENCES `Doctor` (`doctorNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Doctor`
--

DROP TABLE IF EXISTS `Doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctor` (
  `doctorNo` int NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `speciality` varchar(50) NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`doctorNo`),
  UNIQUE KEY `UQ__Doctor__CB9A040DCEC2B0E8` (`userNo`),
  UNIQUE KEY `UQ__Doctor__960F17EFEAF7FD5C` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_DoctorUser` FOREIGN KEY (`userNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DoctorOrder`
--

DROP TABLE IF EXISTS `DoctorOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DoctorOrder` (
  `orderNo` int NOT NULL,
  `doctorNo` int NOT NULL,
  `nurseNo` int NOT NULL,
  `patientNo` int NOT NULL,
  `orderDetail` longtext NOT NULL,
  `dateOfOrder` date NOT NULL,
  `timeOfOrder` time(6) NOT NULL,
  PRIMARY KEY (`orderNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  KEY `IX_NurseNo` (`nurseNo`),
  KEY `IX_PatientNo` (`patientNo`),
  CONSTRAINT `fk_DoctorOrder` FOREIGN KEY (`doctorNo`) REFERENCES `Doctor` (`doctorNo`),
  CONSTRAINT `fk_NurseOrder` FOREIGN KEY (`nurseNo`) REFERENCES `Nurse` (`nurseNo`),
  CONSTRAINT `fk_PatientOrder` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `itemNo` varchar(10) NOT NULL,
  `itemName` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  `unit` varchar(10) NOT NULL,
  `unitPrice` decimal(19,4) NOT NULL,
  PRIMARY KEY (`itemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `InventoryRecieve`
--

DROP TABLE IF EXISTS `InventoryRecieve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InventoryRecieve` (
  `supplierNo` int NOT NULL,
  `itemNo` varchar(10) NOT NULL,
  `pharmacistNo` int NOT NULL,
  `quantity` int NOT NULL,
  `unit` varchar(10) NOT NULL,
  `unitPrice` decimal(19,4) NOT NULL,
  `totalPrice` decimal(19,4) DEFAULT NULL,
  `dateOfReceive` date NOT NULL,
  `timeOfReceive` time(6) NOT NULL,
  PRIMARY KEY (`supplierNo`,`itemNo`,`dateOfReceive`),
  KEY `IX_SupplierNo` (`supplierNo`),
  KEY `IX_ItemNo` (`itemNo`),
  KEY `IX_PharmacistNo` (`pharmacistNo`),
  CONSTRAINT `fk_ItemSupplier` FOREIGN KEY (`supplierNo`) REFERENCES `Supplier` (`supplierNo`),
  CONSTRAINT `fk_PharmacistReceived` FOREIGN KEY (`pharmacistNo`) REFERENCES `Pharmacist` (`pharmacistNo`),
  CONSTRAINT `fk_ReceivedItemNo` FOREIGN KEY (`itemNo`) REFERENCES `Inventory` (`itemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `InventoryTransfer`
--

DROP TABLE IF EXISTS `InventoryTransfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InventoryTransfer` (
  `transferTo` varchar(50) NOT NULL,
  `itemNo` varchar(10) NOT NULL,
  `pharmacistNo` int NOT NULL,
  `quantity` int NOT NULL,
  `unitPrice` decimal(19,4) NOT NULL,
  `totalPrice` decimal(19,4) NOT NULL,
  `dateOfTransfer` date NOT NULL,
  `timeOfTransfer` time(6) NOT NULL,
  PRIMARY KEY (`transferTo`,`itemNo`,`dateOfTransfer`,`timeOfTransfer`),
  KEY `IX_ItemNo` (`itemNo`),
  KEY `IX_PharmacistNo` (`pharmacistNo`),
  CONSTRAINT `fk_itemNoSent` FOREIGN KEY (`itemNo`) REFERENCES `Inventory` (`itemNo`),
  CONSTRAINT `fk_Pharmacist` FOREIGN KEY (`pharmacistNo`) REFERENCES `Pharmacist` (`pharmacistNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LabReport`
--

DROP TABLE IF EXISTS `LabReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LabReport` (
  `RequestNo` bigint NOT NULL,
  `ReportType` tinyint unsigned NOT NULL,
  `Result` varchar(20) DEFAULT NULL,
  `NormalValue` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`RequestNo`,`ReportType`),
  KEY `IX_RequestNo` (`RequestNo`),
  CONSTRAINT `FK_dbo.LabReport_dbo.LabRequest_RequestNo` FOREIGN KEY (`RequestNo`) REFERENCES `LabRequest` (`RequestNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LabRequest`
--

DROP TABLE IF EXISTS `LabRequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LabRequest` (
  `RequestNo` bigint NOT NULL,
  `DoctorNo` int NOT NULL,
  `PatientNo` int NOT NULL,
  `TechnicianNo` int DEFAULT NULL,
  `DateTimeOfRequest` datetime(6) NOT NULL,
  PRIMARY KEY (`RequestNo`),
  KEY `IX_DoctorNo` (`DoctorNo`),
  KEY `IX_PatientNo` (`PatientNo`),
  KEY `IX_TechnicianNo` (`TechnicianNo`),
  CONSTRAINT `FK_dbo.LabRequest_dbo.Doctor_DoctorNo` FOREIGN KEY (`DoctorNo`) REFERENCES `Doctor` (`doctorNo`),
  CONSTRAINT `FK_dbo.LabRequest_dbo.LabTechnician_TechnicianNo` FOREIGN KEY (`TechnicianNo`) REFERENCES `LabTechnician` (`technicianNo`),
  CONSTRAINT `FK_dbo.LabRequest_dbo.Patient_PatientNo` FOREIGN KEY (`PatientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LabTechnician`
--

DROP TABLE IF EXISTS `LabTechnician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LabTechnician` (
  `technicianNo` int NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`technicianNo`),
  UNIQUE KEY `UQ__LabTechn__CB9A040D37E40F36` (`userNo`),
  UNIQUE KEY `UQ__LabTechn__960F17EFBBFDD360` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_TechnicianUser` FOREIGN KEY (`userNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Management`
--

DROP TABLE IF EXISTS `Management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Management` (
  `managementNo` int NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`managementNo`),
  UNIQUE KEY `UQ__Manageme__CB9A040D3D580403` (`userNo`),
  UNIQUE KEY `UQ__Manageme__960F17EF4835FF94` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_ManagementUser` FOREIGN KEY (`userNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MedicationDetail`
--

DROP TABLE IF EXISTS `MedicationDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicationDetail` (
  `nurseNo` int NOT NULL,
  `patientNo` int NOT NULL,
  `orderNo` int NOT NULL,
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
  CONSTRAINT `fk_MedicationOrder` FOREIGN KEY (`orderNo`) REFERENCES `DoctorOrder` (`orderNo`),
  CONSTRAINT `fk_NurseMedication` FOREIGN KEY (`nurseNo`) REFERENCES `Nurse` (`nurseNo`),
  CONSTRAINT `fk_PatientMedication` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MonitorDetail`
--

DROP TABLE IF EXISTS `MonitorDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MonitorDetail` (
  `nurseNo` int NOT NULL,
  `patientNo` int NOT NULL,
  `dateOfMonitor` date NOT NULL,
  `timeOfMonitor` time(6) NOT NULL,
  `vitalSignNo` int NOT NULL,
  `input` varchar(50) DEFAULT NULL,
  `output` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nurseNo`,`patientNo`,`dateOfMonitor`,`timeOfMonitor`),
  KEY `IX_NurseNo` (`nurseNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_VitalSignNo` (`vitalSignNo`),
  CONSTRAINT `fk_MonitorVitalSign` FOREIGN KEY (`vitalSignNo`) REFERENCES `VitalSign` (`vitalSignNo`),
  CONSTRAINT `fk_NurseMonitor` FOREIGN KEY (`nurseNo`) REFERENCES `Nurse` (`nurseNo`),
  CONSTRAINT `fk_PatientMonitor` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Nurse`
--

DROP TABLE IF EXISTS `Nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Nurse` (
  `nurseNo` int NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`nurseNo`),
  UNIQUE KEY `UQ__Nurse__CB9A040D15A57408` (`userNo`),
  UNIQUE KEY `UQ__Nurse__960F17EFC7E53FF3` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_NurseUser` FOREIGN KEY (`userNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `patientNo` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phoneNo` int NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`patientNo`),
  KEY `idx_PhoneNo` (`phoneNo`,`firstName`,`fatherName`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PatientProgress`
--

DROP TABLE IF EXISTS `PatientProgress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PatientProgress` (
  `progressNo` int NOT NULL,
  `patientNo` int NOT NULL,
  `doctorNo` int NOT NULL,
  `dateOfProgressNote` date NOT NULL,
  `timeOfProgressNote` time(6) NOT NULL,
  `clinicalNote` longtext NOT NULL,
  PRIMARY KEY (`progressNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  CONSTRAINT `fk_DoctorProgress` FOREIGN KEY (`doctorNo`) REFERENCES `Doctor` (`doctorNo`),
  CONSTRAINT `fk_PatientProgress` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `paymentNo` int NOT NULL,
  `receptionNo` int NOT NULL,
  `patientNo` int NOT NULL,
  `paymentDetails` varchar(1000) DEFAULT NULL,
  `price` decimal(19,4) NOT NULL,
  `dateOfPayment` date DEFAULT NULL,
  `PaymentCompleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`paymentNo`),
  KEY `IX_ReceptionNo` (`receptionNo`),
  KEY `IX_PatientNo` (`patientNo`),
  CONSTRAINT `fk_PatientPayment` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`),
  CONSTRAINT `fk_ReceptionPayment` FOREIGN KEY (`receptionNo`) REFERENCES `Reception` (`receptionNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pharmacist`
--

DROP TABLE IF EXISTS `Pharmacist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pharmacist` (
  `pharmacistNo` int NOT NULL,
  `firtName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`pharmacistNo`),
  UNIQUE KEY `UQ__Pharmaci__CB9A040D9683112F` (`userNo`),
  UNIQUE KEY `UQ__Pharmaci__960F17EFC8BC1892` (`phoneNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PharmacyCashier`
--

DROP TABLE IF EXISTS `PharmacyCashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PharmacyCashier` (
  `cashierNo` int NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`cashierNo`),
  UNIQUE KEY `UQ__Pharmacy__CB9A040D27B822C3` (`userNo`),
  UNIQUE KEY `UQ__Pharmacy__960F17EF2813C482` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_PharmacyCashier` FOREIGN KEY (`userNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Prescription`
--

DROP TABLE IF EXISTS `Prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prescription` (
  `prescriptionNo` int NOT NULL,
  `patientNo` int NOT NULL,
  `doctorNo` int NOT NULL,
  `pharmacistNo` int DEFAULT NULL,
  `totalPrice` decimal(19,4) NOT NULL,
  PRIMARY KEY (`prescriptionNo`),
  KEY `IX_PatientNo` (`patientNo`),
  KEY `IX_DoctorNo` (`doctorNo`),
  KEY `IX_PharmacistNo` (`pharmacistNo`),
  CONSTRAINT `fk_DoctorPrescription` FOREIGN KEY (`doctorNo`) REFERENCES `Doctor` (`doctorNo`),
  CONSTRAINT `fk_PatientPrescription` FOREIGN KEY (`patientNo`) REFERENCES `Patient` (`patientNo`),
  CONSTRAINT `fk_PharmacistPrescription` FOREIGN KEY (`pharmacistNo`) REFERENCES `Pharmacist` (`pharmacistNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PrescriptionDetail`
--

DROP TABLE IF EXISTS `PrescriptionDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PrescriptionDetail` (
  `detail` longtext NOT NULL,
  `prescriptionNo` int NOT NULL,
  KEY `ClusteredIndexPrescriptionNumber` (`prescriptionNo`),
  KEY `IX_PrescriptionNo` (`prescriptionNo`),
  CONSTRAINT `fk_PrescriptionDetail` FOREIGN KEY (`prescriptionNo`) REFERENCES `Prescription` (`prescriptionNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Radiologist`
--

DROP TABLE IF EXISTS `Radiologist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Radiologist` (
  `RadiologistNo` int NOT NULL,
  `FirstName` varchar(25) NOT NULL,
  `FatherName` varchar(25) NOT NULL,
  `DateOfBirth` datetime(6) NOT NULL,
  `PhoneNo` int NOT NULL,
  `UserNo` int NOT NULL,
  PRIMARY KEY (`RadiologistNo`),
  KEY `IX_UserNo` (`UserNo`),
  CONSTRAINT `FK_dbo.Radiologist_dbo.AppUser_UserNo` FOREIGN KEY (`UserNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RadiologyRequestAndReport`
--

DROP TABLE IF EXISTS `RadiologyRequestAndReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RadiologyRequestAndReport` (
  `PatientNo` int NOT NULL,
  `DoctorNo` int NOT NULL,
  `DateOfRequest` datetime(6) NOT NULL,
  `RequestType` varchar(60) NOT NULL,
  `ExamTypeDetail` varchar(200) DEFAULT NULL,
  `ClinicalData` varchar(400) DEFAULT NULL,
  `Report` varchar(2500) DEFAULT NULL,
  `DateOfReport` datetime(6) DEFAULT NULL,
  `RadiologistNo` int DEFAULT NULL,
  PRIMARY KEY (`PatientNo`,`DoctorNo`,`DateOfRequest`),
  KEY `IX_PatientNo` (`PatientNo`),
  KEY `IX_DoctorNo` (`DoctorNo`),
  KEY `IX_RadiologistNo` (`RadiologistNo`),
  CONSTRAINT `FK_dbo.RadiologyRequestAndReport_dbo.Doctor_DoctorNo` FOREIGN KEY (`DoctorNo`) REFERENCES `Doctor` (`doctorNo`),
  CONSTRAINT `FK_dbo.RadiologyRequestAndReport_dbo.Patient_PatientNo` FOREIGN KEY (`PatientNo`) REFERENCES `Patient` (`patientNo`),
  CONSTRAINT `FK_dbo.RadiologyRequestAndReport_dbo.Radiologist_RadiologistNo` FOREIGN KEY (`RadiologistNo`) REFERENCES `Radiologist` (`RadiologistNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Reception`
--

DROP TABLE IF EXISTS `Reception`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reception` (
  `receptionNo` int NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `fatherName` varchar(25) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phoneNo` int NOT NULL,
  `userNo` int NOT NULL,
  PRIMARY KEY (`receptionNo`),
  UNIQUE KEY `UQ__Receptio__CB9A040DD6FEE076` (`userNo`),
  UNIQUE KEY `UQ__Receptio__960F17EF1ED88C89` (`phoneNo`),
  KEY `IX_UserNo` (`userNo`),
  CONSTRAINT `fk_ReceptionUser` FOREIGN KEY (`userNo`) REFERENCES `AppUser` (`userNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `ReceptionPatientAppointmentView`
--

DROP TABLE IF EXISTS `ReceptionPatientAppointmentView`;
/*!50001 DROP VIEW IF EXISTS `ReceptionPatientAppointmentView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ReceptionPatientAppointmentView` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `DoctorName`,
 1 AS `DateOfAppointment`,
 1 AS `TimeOfAppointment`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ReceptionPatientInfoView`
--

DROP TABLE IF EXISTS `ReceptionPatientInfoView`;
/*!50001 DROP VIEW IF EXISTS `ReceptionPatientInfoView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ReceptionPatientInfoView` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `Name`,
 1 AS `Age`,
 1 AS `Gender`,
 1 AS `CardNumber`,
 1 AS `Address`,
 1 AS `PhoneNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ReceptionPatientSearchView`
--

DROP TABLE IF EXISTS `ReceptionPatientSearchView`;
/*!50001 DROP VIEW IF EXISTS `ReceptionPatientSearchView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ReceptionPatientSearchView` AS SELECT 
 1 AS `PatientNumber`,
 1 AS `FirstName`,
 1 AS `FatherName`,
 1 AS `PhoneNumber`,
 1 AS `CardNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Sale`
--

DROP TABLE IF EXISTS `Sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sale` (
  `FSNo` int NOT NULL,
  `reference` varchar(25) NOT NULL,
  `grandTotal` decimal(19,4) NOT NULL,
  `pharmacyCashierNo` int NOT NULL,
  PRIMARY KEY (`FSNo`),
  KEY `IX_PharmacyCashierNo` (`pharmacyCashierNo`),
  CONSTRAINT `fk_CashierSale` FOREIGN KEY (`pharmacyCashierNo`) REFERENCES `PharmacyCashier` (`cashierNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SaleDetail`
--

DROP TABLE IF EXISTS `SaleDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SaleDetail` (
  `detialNo` int NOT NULL,
  `saleNo` int NOT NULL,
  `itemNo` varchar(10) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `quantity` int NOT NULL,
  `totalPrice` decimal(19,4) NOT NULL,
  `dateOfSale` date NOT NULL,
  `timeOfSale` time(6) NOT NULL,
  PRIMARY KEY (`detialNo`),
  KEY `IX_SaleNo` (`saleNo`),
  KEY `IX_ItemNo` (`itemNo`),
  CONSTRAINT `fk_ItemSale` FOREIGN KEY (`itemNo`) REFERENCES `Inventory` (`itemNo`),
  CONSTRAINT `fk_SaleDetail` FOREIGN KEY (`saleNo`) REFERENCES `Sale` (`FSNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Supplier`
--

DROP TABLE IF EXISTS `Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supplier` (
  `supplierNo` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phoneNo` int NOT NULL,
  PRIMARY KEY (`supplierNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `VitalSign`
--

DROP TABLE IF EXISTS `VitalSign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VitalSign` (
  `vitalSignNo` int NOT NULL,
  `BPHigh` double NOT NULL,
  `BPLow` double NOT NULL,
  `PR` double NOT NULL,
  `RR` double NOT NULL,
  `Temprature` double NOT NULL,
  `SPO2` double NOT NULL,
  `Pain` double NOT NULL,
  PRIMARY KEY (`vitalSignNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `__MigrationHistory`
--

DROP TABLE IF EXISTS `__MigrationHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__MigrationHistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4  NOT NULL,
  `ContextKey` varchar(300) CHARACTER SET utf8mb4  NOT NULL,
  `Model` longblob NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4  NOT NULL,
  PRIMARY KEY (`MigrationId`,`ContextKey`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sysdiagrams`
--

DROP TABLE IF EXISTS `sysdiagrams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysdiagrams` (
  `name` varchar(160) NOT NULL,
  `principal_id` int NOT NULL,
  `diagram_id` int NOT NULL,
  `version` int DEFAULT NULL,
  `definition` longblob,
  PRIMARY KEY (`diagram_id`),
  UNIQUE KEY `UK_principal_name` (`principal_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'APHMSDB'
--
/*!50003 DROP PROCEDURE IF EXISTS `spReception_AddCard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;

/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReception_AddCard`(
	in `@patientNo` int,
    in `@cardNo` varchar(10))
begin
	insert into Card(patientNo, cardNo) values
    (`@patientNo`, `@cardNo`);
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
/*!50003 DROP PROCEDURE IF EXISTS `spReception_GetPatientAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;

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
/*!50003 DROP PROCEDURE IF EXISTS `spReception_GetPatientInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;

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
/*!50003 DROP PROCEDURE IF EXISTS `spReception_SearchPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;

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

--
-- Final view structure for view `ReceptionPatientAppointmentView`
--

/*!50001 DROP VIEW IF EXISTS `ReceptionPatientAppointmentView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;

/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ReceptionPatientAppointmentView` AS select `A`.`PatientNo` AS `PatientNumber`,concat((`D`.`firstName` + ' '),`D`.`fatherName`) AS `DoctorName`,date_format(`A`.`DateOfAppointment`,'%a, %b %e, %Y') AS `DateOfAppointment`,`A`.`TimeOfAppointment` AS `TimeOfAppointment` from (`Appointment` `A` join `Doctor` `D` on((`A`.`DoctorNo` = `D`.`doctorNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ReceptionPatientInfoView`
--

/*!50001 DROP VIEW IF EXISTS `ReceptionPatientInfoView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;

/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ReceptionPatientInfoView` AS select `P`.`patientNo` AS `PatientNumber`,concat(`P`.`firstName`,' ',`P`.`fatherName`) AS `Name`,((to_days(curdate()) - to_days(`P`.`dateOfBirth`)) / 365) AS `Age`,`P`.`gender` AS `Gender`,`C`.`cardNo` AS `CardNumber`,`P`.`address` AS `Address`,`P`.`phoneNo` AS `PhoneNumber` from (`Patient` `P` join `Card` `C` on((`P`.`patientNo` = `C`.`patientNo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ReceptionPatientSearchView`
--

/*!50001 DROP VIEW IF EXISTS `ReceptionPatientSearchView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;

/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ReceptionPatientSearchView` AS select `P`.`patientNo` AS `PatientNumber`,`P`.`firstName` AS `FirstName`,`P`.`fatherName` AS `FatherName`,`P`.`phoneNo` AS `PhoneNumber`,`C`.`cardNo` AS `CardNumber` from (`Patient` `P` join `Card` `C` on((`P`.`patientNo` = `C`.`patientNo`))) */;
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

-- Dump completed on 2022-01-18 10:28:49
