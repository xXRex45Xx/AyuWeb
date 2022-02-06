use APHMSDB;

/* Reception Procedures */
delimiter &&
CREATE PROCEDURE spReception_SearchPatient(in `@phoneNo` int)
begin
	select * from ReceptionPatientSearchView
	where PhoneNumber = `@phoneNo`;
end &&
    
delimiter &&
CREATE PROCEDURE spReception_GetPatientInfo(in `@patientNo` int)
begin
	select * from ReceptionPatientInfoView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spReception_GetPatientAppointments(in `@patientNo` int)
begin
	select * from ReceptionPatientAppointmentView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spReception_GetPatientCompletedPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Reception_Patient_CompletedPaymentView
    where  PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spReception_GetPatientPendingPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, Price
    from Reception_Patient_PendingPaymentView
    where PatientNumber = `@patientNo`;
end &&


insert into Payment (paymentNo, patientNo, paymentDetails, price) value
(1,1, "This is a test", 50.00)

delimiter &&
CREATE PROCEDURE spReception_AddPatient(
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
CREATE PROCEDURE spReception_AddCardandRegFee(
	in `@patientNo` int,
    in `@cardNo` varchar(10))
begin
	insert into Card(patientNo, cardNo) values
    (`@patientNo`, `@cardNo`);
    insert into Payment (patientNo, paymentDetails, price) values
    (`@patientNo`, "Registeration", 80);
end &&

delimiter &&
CREATE PROCEDURE spReception_CancelPayment(in `@paymentNo` int)
begin
	delete from Payment 
    where `@paymentNo` = paymentNo and PaymentCompleted = 0;
end &&

delimiter && 
CREATE PROCEDURE spReception_FinalizePayment( 
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
end &&

delimiter &&
CREATE PROCEDURE spReception_LoadDashboardData()
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
end &&

/* Management Procedures */
delimiter &&
CREATE PROCEDURE spManagement_SearchPatient(in `@phoneNo` int)
begin
	select * from Management_Patient_SearchView
	where PhoneNumber = `@phoneNo`;
end &&
    
delimiter &&
CREATE PROCEDURE spManagement_GetPatientInfo(in `@patientNo` int)
begin
	select * from Management_Patient_InfoView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetFullPatientInfo(in `@patientNo` int)
begin
	select * from Management_Patient_UpdateView
    where PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetPatientAppointments(in `@patientNo` int)
begin
	select * from Management_Patient_AppointmentView
	where PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetPatientCompletedPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, DateOfPayment, Price 
    from Management_Patient_CompletedPaymentView
    where  PatientNumber = `@patientNo`;
end &&

call spManagement_GetPatientCompletedPayments(29)

delimiter &&
CREATE PROCEDURE spManagement_GetPatientPendingPayments(in `@patientNo` int)
begin
	select PaymentNumber, PaymentDetails, Price
    from Management_Patient_PendingPaymentView
    where PatientNumber = `@patientNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_SearchEmployee(in `@phoneNo` int)
begin
	select * from Management_Doctor_InfoView
    where PhoneNumber = `@phoneNo`;
    select * from Management_LabTechnician_InfoView
    where PhoneNumber = `@phoneNo`;
    select * from Management_Reception_InfoView
    where PhoneNumber = `@phoneNo`;    
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetAllEmployee()
begin
	select * from Management_Doctor_InfoView;
    select * from Management_Reception_InfoView;
    select * from Management_LabTechnician_InfoView;
end &&

delimiter &&
CREATE PROCEDURE spManagement_SearchReception(in `@phoneNo` int)
begin
	select * from Management_Reception_SearchView
    where PhoneNumber = `@phoneNo`;   
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetDoctorInfo(in `@doctorNo` int)
begin
	select * from Management_Doctor_InfoView
    where DoctorNumber = `@doctorNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetLabTechnicianInfo(in `@labTechNo` int)
begin
	select * from Management_LabTechnician_InfoView
    where TechnicianNumber = `@labTechNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetReceptionInfo(in `@receptionNo` int)
begin
	select * from Management_Reception_InfoView
    where ReceptionNumber = `@receptionNo`;
end &&

delimiter &&
CREATE PROCEDURE spManagement_UpdateUser(
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
CREATE PROCEDURE spManagement_AddUser(
	in `@username` varchar(50),
    `@password` char(60) binary,
    `@role` tinyint)
begin
	insert into AppUser (userName, password, role) values
    (`@username`, `@password`, `@role`);
    select last_insert_id() as lastUserNo;
end &&

delimiter &&
CREATE PROCEDURE spManagement_AddReception(
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
CREATE PROCEDURE spManagement_AddDoctor(
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
end &&

delimiter &&
CREATE PROCEDURE spManagement_AddLabTechnician(
	in `@firstName` varchar(25),
    `@fatherName` varchar(25),
    `@dateOfBirth` date,
    `@phoneNo` int,
    `@userNo` int
)
begin
	insert into LabTechnician (firstName, fatherName, dateOfBirth, phoneNo, userNo) values
    (`@firstName`, `@fatherName`, `@dateOfBirth`, `@phoneNo`, `@userNo`);
end &&

delimiter &&
CREATE PROCEDURE spManagement_GetReceptionTransactions(in `@receptionNo` int)
begin
	select * from Management_Reception_TransactionsView
    where ReceptionNumber = `@receptionNo`;
end &&

delimiter && 
CREATE PROCEDURE spManagement_GetDailyTransactions(in `@dateOfPayment` date)
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

insert into Payment (patientNo, paymentDetails, price) values
(29, "Test", 50.99),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.00),
(29, "Test", 50.99)

/* User Procedures */
delimiter &&
CREATE PROCEDURE spGetUser(in `@username` varchar(50))
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
CREATE PROCEDURE spGetUserById(in `@userNo` int)
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
CREATE PROCEDURE spUpdateUser(
	in `@userNo` int,
	`@newPassword` char(60) binary
    )
begin
	update AppUser
    set password = `@newPassword`
    where userNo = `@userNo`;
end && 

delimiter &&
CREATE PROCEDURE spManagement_LoadDashboardData()
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
end &&


/* Doctor Procedures */
delimiter &&
CREATE PROCEDURE `spDoctor_AddAppointment`(
	in `@PatientNo` int,
    in `@DoctorNo` int,
    in `@DateOfAppointment` date,
    in `@TimeOfAppointment` time
)
begin
insert into appointment (PatientNo, DoctorNo, DateOfAppointment,TimeOfAppointment) values 
(`@PatientNo`,(select doctorNo from doctor where userNo =`@DoctorNo`),`@DateOfAppointment`,`@TimeOfAppointment`);
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_AddDiagnosis`(
	in `@patientNo` int,
    in `@dateOfDiagnosis` date,
    in `@userNo` int,
    in `@diagnosisDetails` longtext)
begin
	insert into diagnosis (cardNo, dateOfDiagnosis, doctorNo, diagnosisDetails) values
    ((select cardNO from card where patientNo = `@patientNo`), `@dateOfDiagnosis`, (select doctorNo from doctor where userNo =`@userNo`), `@diagnosisDetails`);
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_AddLabRequest`(
	in `@userId` int,
    in `@patientNo` int,
    in `@DateTimeOfRequest` datetime
)
begin
insert into labrequest (DoctorNo, PatientNo, DateTimeOfRequest)  values((select doctorNo from doctor where userNo = `@userId`),`@patientNo`,`@DateTimeOFRequest`);
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_AddLabRequestDetail`(
	in `@RequestNo` bigint,
    in `@ReportType` varchar(15)
)
begin
insert into labreport (RequestNo, ReportType) values(`@RequestNo`, `@ReportType`);
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_AddLabRequestPayment`(
	in `@patientNo` int,
	in `@price` decimal,
    in `@dateOfPayment` date
)
begin
	insert into payment (patientNo,paymentDetails,Price,dateOfPayment)
    values (`@patientNo`,'Lab Request',`@price`,`@dateOfPayment`);
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_AddLabRequestPayment`(
	in `@patientNo` int,
	in `@price` decimal,
    in `@dateOfPayment` date
)
begin
	insert into payment (patientNo,paymentDetails,Price,dateOfPayment)
    values (`@patientNo`,'Lab Request',`@price`,`@dateOfPayment`);
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_GetCountOfAppointment`(
	in `@PatientNo` int,
    in `@DoctorNo` int,
    in `@DateOfAppointment` date
)
begin
 select * from appointment where PatientNo = `@PatientNo`and DoctorNo = (select doctorNo from doctor where userNo =`@DoctorNo`) and DateOfAppointment = `@DateOfAppointment`;
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_GetLabReport`(	in `@patientNo` int)
begin
	SELECT labrequest.RequestNo, labrequest.PatientNo, labrequest.DateTimeOfRequest, labreport.ReportType, labreport.NormalValue, labreport.Result
FROM labreport 
inner join labrequest on labreport.RequestNo =labrequest.RequestNo
where labrequest.PatientNo = `@patientNo`
order by labrequest.RequestNo desc;
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_GetLastLabRequestId`()
begin
select RequestNo from labrequest order by RequestNo desc limit 1;
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_GetVitalSign`(	in `@vitalSignNo` int)
begin
	select * from vitalsign 
    where vitalSignNo = `@vitalSignNo`;
end &&

delimiter &&
CREATE PROCEDURE `spDoctor_UpdateAppointment`(
	in `@PatientNo` int,
    in `@DoctorNo` int,
    in `@DateOfAppointment` date,
    in `@TimeOfAppointment` time)
begin
delete from appointment 
where `DoctorNo` = (select doctorNo from doctor where userNo =`@DoctorNo`) 
and (`PatientNo`= `@PatientNo`) and (`DateOfAppointment`=`@DateOfAppointment`);
call spDoctor_AddAppointment(`@PatientNo`,`@DoctorNo`,`@DateOfAppointment`,`@TimeOfAppointment`);
end &&

/*Lab Technician*/
delimiter &&
CREATE PROCEDURE `spLaboratorist_AddLabReport`(
	in `@patientNo` int,
    in `@ReportType` varchar(15),
    in `@Result` varchar(20),
    in `@NormalValue` varchar(20))
begin
UPDATE labreport SET `Result` = `@Result`, `NormalValue` = `@NormalValue`
WHERE 	(`RequestNo` = (select RequestNo from labrequest where PatientNo = `@patientNo` order by RequestNo desc limit 1)) 
	and 
		(`ReportType` = `@ReportType`);
end &&