use APHMSDB;
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

select * from Payment
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