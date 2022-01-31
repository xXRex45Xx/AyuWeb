use APHMSDB;

/* Reception Procedures */
delimiter &&
create procedure spReception_SearchPatient(in `@phoneNo` int)
begin
	select * from ReceptionPatientSearchView
	where PhoneNumber = `@phoneNo`;
end &&
    
delimiter &&
create procedure spReception_GetPatientInfo(in `@patientNo` int)
begin
	select * from ReceptionPatientInfoView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spReception_GetPatientAppointments(in `@patientNo` int)
begin
	select * from ReceptionPatientAppointmentView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spReception_GetPatientCompletedPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Reception_Patient_CompletedPaymentView
    where  PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spReception_GetPatientPendingPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, Price
    from Reception_Patient_PendingPaymentView
    where PatientNumber = `@patientNo`;
end &&


insert into Payment (paymentNo, patientNo, paymentDetails, price) value
(1,1, "This is a test", 50.00)

delimiter &&
create procedure spReception_AddPatient(
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
end && 

delimiter &&
create procedure spReception_AddCard(
	in `@patientNo` int,
    in `@cardNo` varchar(10))
begin
	insert into Card(patientNo, cardNo) values
    (`@patientNo`, `@cardNo`);
end &&

delimiter &&
create procedure spReception_CancelPayment(in `@paymentNo` int)
begin
	delete from Payment 
    where `@paymentNo` = paymentNo and PaymentCompleted = 0;
end &&

/* Management Procedures */
delimiter &&
create procedure spManagement_SearchPatient(in `@phoneNo` int)
begin
	select * from Management_Patient_SearchView
	where PhoneNumber = `@phoneNo`;
end &&
    
delimiter &&
create procedure spManagement_GetPatientInfo(in `@patientNo` int)
begin
	select * from Management_Patient_InfoView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spManagement_GetFullPatientInfo(in `@patientNo` int)
begin
	select * from Management_Patient_UpdateView
    where PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spManagement_GetPatientAppointments(in `@patientNo` int)
begin
	select * from Management_Patient_AppointmentView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spManagement_GetPatientCompletedPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Management_Patient_CompletedPaymentView
    where  PatientNumber = `@patientNo`;
end &&

call spManagement_GetPatientCompletedPayments(29)

delimiter &&
create procedure spManagement_GetPatientPendingPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, Price
    from Management_Patient_PendingPaymentView
    where PatientNumber = `@patientNo`;
end &&

delimiter &&
create procedure spManagement_SearchEmployee(in `@phoneNo` int)
begin
	select * from Management_Doctor_SearchView
    where PhoneNumber = `@phoneNo`;
    select * from Management_LabTechnician_SearchView
    where PhoneNumber = `@phoneNo`;
    select * from Management_Reception_SearchView
    where PhoneNumber = `@phoneNo`;    
end &&

delimiter &&
create procedure spManagement_SearchReception(in `@phoneNo` int)
begin
	select * from Management_Reception_SearchView
    where PhoneNumber = `@phoneNo`;   
end &&

delimiter &&
create procedure spManagement_GetDoctorInfo(in `@doctorNo` int)
begin
	select * from Management_Doctor_InfoView
    where DoctorNumber = `@doctorNo`;
end &&

delimiter &&
create procedure spManagement_GetLabTechnicianInfo(in `@labTechNo` int)
begin
	select * from Management_LabTechnician_InfoView
    where TechnicianNumber = `@labTechNo`;
end &&

delimiter &&
create procedure spManagement_GetReceptionInfo(in `@receptionNo` int)
begin
	select * from Management_Reception_InfoView
    where ReceptionNumber = `@receptionNo`;
end &&

delimiter &&
create procedure spManagement_UpdateUser(
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
end &&

delimiter &&
create procedure spManagement_AddUser(
	in `@username` varchar(50),
    `@password` char(60) binary,
    `@role` tinyint)
begin
	insert into AppUser (userName, password, role) values
    (`@username`, `@password`, `@role`);
    select last_insert_id() as lastUserNo;
end &&

delimiter &&
create procedure spManagement_AddReception(
	in `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@phoneNo` int,
    `@userNo` int)
begin
	insert into reception (firstName, fatherName, dateOfBirth, phoneNo, userNo) values
    (`@firstName`, `@fatherName`, `@dateOfBirth`, `@phoneNo`, `@userNo`);
end &&

delimiter &&
create procedure spManagement_GetReceptionTransactions(in `@receptionNo` int)
begin
	select * from Management_Reception_TransactionsView
    where ReceptionNumber = `@receptionNo`;
end &&

delimiter && 
create procedure spManagement_GetDailyTransactions(in `@dateOfPayment` date)
begin
	select PaymentNumber, ReceptionName, PatientName, PaymentDetails, DATE_FORMAT(DateOfPayment, "%a, %b %e, %Y") as DateOfPayment, Price 
    from Management_CompletedPaymentsView
    where DateOfPayment = `@dateOfPayment`;
end &&

insert into Doctor (doctorNo, firstName, fatherName, dateOfBirth, phoneNo, speciality, userNo) values
(1, "Test", "Test", "1998-01-01", 111, "ENT",  5)

insert into LabTechnician (technicianNo, firstName, fatherName, dateOfBirth, phoneNo, userNo) values
(2, "Test", "Test", "1998-01-01", 111,  6)

insert into Reception (receptionNo, firstName, fatherName, dateOfBirth, phoneNo, userNo) values
(1, "Test", "Test", "1998-01-01", 111,  7)

select * from Payment

insert into Payment (receptionNo, patientNo, paymentDetails, price, dateOfPayment, PaymentCompleted) values
(3, 29, "Test", 50.99, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.00, "2022-01-30", 1),
(3, 29, "Test", 50.99, "2022-01-30", 1)

/* User Procedures */
delimiter &&
create procedure spGetUser(in `@username` varchar(50))
begin
	select 
		userNo as UserNumber,
		userName as UserName,
        password as Password,
        role as Role
	from AppUser
    where `@username` = userName;
end &&

delimiter &&
create procedure spGetUserById(in `@userNo` int)
begin
	select 
		userNo as UserNumber,
		userName as UserName,
        password as Password,
        role as Role
	from AppUser
    where `@userNo` = userNo;
end &&

delimiter &&
create procedure spUpdateUser(
	in `@userNo` int,
	`@newPassword` char(60) binary
    )
begin
	update AppUser
    set password = `@newPassword`
    where userNo = `@userNo`;
end && 

select * from AppUser



