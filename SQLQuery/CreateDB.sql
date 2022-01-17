create database APHMSDB;

use APHMSDB;

create table Patient (
	patientNo int primary key,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	gender char not null,
	address varchar(100),
	phoneNo int not null,
	type bit not null
);

alter table Patient
add constraint chk_Gender
check (gender in ('M','F'));

alter table Patient 
add constraint chk_type
check (type in (0,1));

create table Doctor (
	doctorNo int primary key auto_increment,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	speciality varchar(50) not null,
	userNo int unique not null
);

create table LabTechnician (
	technicianNo int primary key auto_increment,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	userNo int unique not null
);

create table Reception(
	receptionNo int primary key auto_increment,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	userNo int unique not null
);

create table Management (
	managementNo int primary key auto_increment,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	userNo int unique not null
);

create table AppUser(
	userNo int primary key auto_increment,
	userName nvarchar(50) unique not null,
	password nvarchar(50) unique not null,
	role tinyint not null
);

create table Card (
	cardNo varchar(10) primary key,
	patientNo int unique not null
);

create table Diagnosis (
	cardNo varchar(10) not null,
	dateOfDiagnosis date not null,
	diagnosis text not null,
	doctorNo int not null,
	primary key (cardNo, dateOfDiagnosis)
);

create table Payment (
	paymentNo int primary key auto_increment,
	receptionNo int not null,
	patientNo int not null,
	paymentDetails varchar(1000),
	price decimal(15,2) not null,
	dateOfPayment date not null
);

create table Nurse (
	nurseNo int primary key auto_increment,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	userNo int unique not null
);

create table MonitorDetail (
	nurseNo int not null,
	patientNo int not null,
	dateOfMonitor date not null,
	timeOfMonitor time not null,
	vitalSignNo int not null, 
	input varchar(50),
	output varchar(50),
	primary key (nurseNo, patientNo, dateOfMonitor, timeOfMonitor)
);

create table MedicationDetail(
	nurseNo int not null,
	patientNo int not null,
	orderNo int not null,
	dateOfMedication date not null,
	timeOfMedication time not null,
	medication varchar(300) not null,
	dose varchar(10) not null,
	route varchar(10) not null,
	frequency varchar(10),
	primary key(nurseNo, patientNo, dateOfMedication, timeOfMedication)
);

create table VitalSign(
	vitalSignNo int primary key auto_increment,
	BPHigh float not null,
	BPLow float not null,
	PR float not null,
	RR float not null,
	Temprature float not null,
	SPO2 float not null,
	Pain float not null
);

create table DoctorOrder (
	orderNo int primary key auto_increment,
	doctorNo int not null,
	nurseNo int not null,
	patientNo int not null,
	orderDetail text not null,
	dateOfOrder date not null,
	timeOfOrder time not null
); 

create table PatientProgress(
	progressNo int primary key auto_increment,
	patientNo int not null,
	doctorNo int not null,
	dateOfProgressNote date not null,
	timeOfProgressNote time not null,
	clinicalNote text not null
);

create table Pharmacist(
	pharmacistNo int primary key auto_increment,
	firtName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	userNo int unique not null
);

create table Supplier(
	supplierNo int primary key auto_increment,
	name varchar(50),
	phoneNo int not null
);

create table Inventory(
	itemNo varchar(10) primary key,
	itemName varchar(50) not null,
	quantity int not null,
	unit varchar(10) not null,
	unitPrice decimal(15,2) not null
);

create table PharmacyCashier(
	cashierNo int primary key auto_increment,
	firstName varchar(25) not null,
	fatherName varchar(25) not null,
	dateOfBirth date not null,
	phoneNo int unique not null,
	userNo int unique not null
);

create table InventoryRecieve(
	supplierNo int not null,
	itemNo varchar(10) not null,
	pharmacistNo int not null,
	quantity int not null,
	unit varchar(10) not null,
	unitPrice decimal(15,2) not null,
	totalPrice decimal(15,2) not null,/*check this*/ 
	dateOfReceive date not null,
	timeOfReceive time not null,
	primary key (supplierNo, itemNo, dateOfReceive)
);

create table InventoryTransfer(
	transferTo varchar(50) not null,
	itemNo varchar(10) not null,
	pharmacistNo int not null,
	quantity int not null,
	unitPrice decimal(15,2) not null,
	totalPrice decimal(15,2) not null,
	dateOfTransfer date not null,
	timeOfTransfer time not null,
	primary key (transferTo, itemNo, dateOfTransfer, timeOfTransfer)
);

create table Sale(
	FSNo int primary key,
	reference varchar(25) not null,
	grandTotal decimal(15,2) not null,
	pharmacyCashierNo int not null
);
create table SaleDetail(
	detialNo int primary key auto_increment,
	saleNo int not null,
	itemNo varchar(10) not null,
	unit varchar(10) not null,
	quantity int not null,
	totalPrice decimal(15,2) not null,
	dateOfSale date not null,
	timeOfSale time not null
);

create table Prescription(
	prescriptionNo int primary key auto_increment,
	patientNo int not null,
	doctorNo int not null,
	pharmacistNo int,
	totalPrice decimal(15,2) not null
);

create table PrescriptionDetail(
	detail text not null,
	prescriptionNo int not null
);

-- CREATE nonclustered INDEX [idx_PhoneNo] ON [dbo].[Patient]
-- (
-- 	[phoneNo] ASC
-- )
-- INCLUDE([firstName],[fatherName]);
create index idx_PhoneNo on Patient(phoneNo asc);

alter table PrescriptionDetail
add constraint fk_PrescriptionDetail
foreign key (prescriptionNo) references Prescription(prescriptionNo);

alter table Prescription
add constraint fk_PatientPrescription
foreign key (patientNo) references Patient(patientNo);

alter table Prescription
add constraint fk_DoctorPrescription
foreign key(doctorNo) references Doctor(doctorNo);

alter table Prescription
add constraint fk_PharmacistPrescription
foreign key (pharmacistNo) references Pharmacist(pharmacistNo);

alter table Doctor
add constraint fk_DoctorUser
foreign key (userNo) references AppUser(userNo);

alter table LabTechnician 
add constraint fk_TechnicianUser
foreign key (userNo) references AppUser(userNo);

alter table Reception
add constraint fk_ReceptionUser
foreign key (userNo) references AppUser(userNo);

alter table Management 
add constraint fk_ManagementUser
foreign key (userNo) references AppUser(userNo);

alter table Card
add constraint fk_PatientCard
foreign key (patientNo) references Patient(patientNo);

alter table Diagnosis
add constraint fk_CardDiagnosis
foreign key (cardNo) references Card(cardNo);

alter table Diagnosis
add constraint fk_DoctorDiagnosis
foreign key (doctorNo) references Doctor(doctorNo);

alter table Payment
add constraint fk_ReceptionPayment
foreign key (receptionNo) references Reception(receptionNo);

alter table Payment
add constraint fk_PatientPayment
foreign key(patientNo) references Patient(patientNo);

alter table Nurse
add constraint fk_NurseUser
foreign key(userNo) references AppUser(userNo);

alter table PharmacyCashier 
add constraint fk_PharmacyCashier 
foreign key (userNo) references AppUser(userNo);

alter table InventoryRecieve 
add constraint fk_PharmacistReceived 
foreign key (pharmacistNo) references Pharmacist(pharmacistNo);

alter table InventoryRecieve 
add constraint fk_ReceivedItemNo 
foreign key (itemNo) references Inventory(itemNo);

alter table InventoryRecieve
add constraint fk_ItemSupplier
foreign key(supplierNo) references Supplier(supplierNo);

alter table SaleDetail 
add constraint fk_SaleDetail
foreign key (saleNo) references Sale(FSNo);


alter table InventoryTransfer 
add constraint fk_Pharmacist
foreign key (pharmacistNo) references Pharmacist(pharmacistNo);

alter table InventoryTransfer 
add constraint fk_itemNoSent
foreign key (itemNo) references Inventory(itemNo);

alter table Sale
add constraint fk_CashierSale
foreign key (pharmacyCashierNo) references PharmacyCashier(cashierNo);

alter table SaleDetail
add constraint fk_ItemSale
foreign key (itemNo) references Inventory(itemNo);

