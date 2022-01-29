use APHMSDB;

/* Reception Views*/
create view ReceptionPatientSearchView
as
select	P.patientNo as PatientNumber,
		firstName as FirstName,
		fatherName as FatherName,
		phoneNo as PhoneNumber,
		C.cardNo as CardNumber
from Patient as P
join Card as C
on P.patientNo = C.patientNo;

alter view ReceptionPatientInfoView
as
select	P.patientNo as PatientNumber,
		CONCAT(P.firstName, ' ', P.fatherName) as Name,
		(DATEDIFF(CURRENT_DATE(), P.dateOfBirth) / 365) as Age,
		P.gender as Gender,
		C.cardNo as CardNumber,
		P.address as Address,
		P.phoneNo as PhoneNumber
from Patient as P
join Card as C
on P.patientNo = C.patientNo;

create view ReceptionPatientAppointmentView
as
select	A.PatientNo as PatientNumber,
		CONCAT(D.firstName + ' ', D.fatherName) as DoctorName,
		DATE_FORMAT(A.DateOfAppointment, '%a, %b %e, %Y') as DateOfAppointment,
		A.TimeOfAppointment
from Appointment as A
join Doctor as D
on A.DoctorNo = D.doctorNo;

create view Reception_Patient_CompletedPaymentView
as
select
	Pay.patientNo as PatientNumber,
	Pay.paymentNo as PaymentNumber,
	Pay.paymentDetails as PaymentDetails,
	Pay.dateOfPayment as DateOfPayment,
    Pay.price as Price
from Payment as Pay
join Patient as Pat
on Pay.patientNo = Pat.patientNo
where Pay.PaymentCompleted = true;

create view Reception_Patient_PendingPaymentView
as
select
	Pay.patientNo as PatientNumber,
	Pay.paymentNo as PaymentNumber,
	Pay.paymentDetails as PaymentDetails,
    Pay.price as Price
from Payment as Pay
join Patient as Pat
on Pay.patientNo = Pat.patientNo
where Pay.PaymentCompleted = false;



/* Management Views*/
create view Management_Patient_SearchView
as
select	P.patientNo as PatientNumber,
		firstName as FirstName,
		fatherName as FatherName,
		phoneNo as PhoneNumber,
		C.cardNo as CardNumber
from Patient as P
join Card as C
on P.patientNo = C.patientNo;

create view Management_Patient_InfoView
as
select	P.patientNo as PatientNumber,
		CONCAT(P.firstName, ' ', P.fatherName) as Name,
		(DATEDIFF(CURRENT_DATE(), P.dateOfBirth) / 365) as Age,
		P.gender as Gender,
		C.cardNo as CardNumber,
		P.address as Address,
		P.phoneNo as PhoneNumber,
        P.type as Hospitalized
from Patient as P
join Card as C
on P.patientNo = C.patientNo;

create view Management_Patient_UpdateView
as
select	patientNo as PatientNumber,
		firstName as FirstName, 
        fatherName as FatherName,
		DATE_FORMAT(dateOfBirth, '%Y-%m-%d') as DateOfBirth,
		gender as Gender,
		address as Address,
		phoneNo as PhoneNumber,
        type as Hospitalized
from Patient;

create view Management_Patient_AppointmentView
as
select	A.PatientNo as PatientNumber,
		CONCAT(D.firstName + ' ', D.fatherName) as DoctorName,
		DATE_FORMAT(A.DateOfAppointment, '%a, %b %e, %Y') as DateOfAppointment,
		A.TimeOfAppointment
from Appointment as A
join Doctor as D
on A.DoctorNo = D.doctorNo;

create view Management_Patient_CompletedPaymentView
as
select
	Pay.patientNo as PatientNumber,
	Pay.paymentNo as PaymentNumber,
	Pay.paymentDetails as PaymentDetails,
	Pay.dateOfPayment as DateOfPayment,
    Pay.price as Price
from Payment as Pay
join Patient as Pat
on Pay.patientNo = Pat.patientNo
where Pay.PaymentCompleted = true;

create view Management_Patient_PendingPaymentView
as
select
	Pay.patientNo as PatientNumber,
	Pay.paymentNo as PaymentNumber,
	Pay.paymentDetails as PaymentDetails,
    Pay.price as Price
from Payment as Pay
join Patient as Pat
on Pay.patientNo = Pat.patientNo
where Pay.PaymentCompleted = false;

create view Management_Doctor_SearchView
as
select 
	doctorNo as DoctorNumber,
    firstName as FirstName,
    fatherName as FatherName,
    phoneNo as PhoneNumber
from Doctor;

create view Management_LabTechnician_SearchView
as
select
	technicianNo as TechnicianNumber,
    firstName as FirstName,
    fatherName as FatherName,
    phoneNo as PhoneNumber
from LabTechnician;

create view Management_Reception_SearchView
as
select
	receptionNo as ReceptionNumber,
    firstName as FirstName,
    fatherName as FatherName,
    phoneNo as PhoneNumber
from Reception;

create view Management_Doctor_InfoView
as
select
	D.doctorNo as DoctorNumber,
    CONCAT(D.firstName, ' ', D.fatherName) as DoctorName,
    DATE_FORMAT(D.dateOfBirth, "%a, %b %e, %Y") as DateOfBirth,
    D.phoneNo as PhoneNumber,
    D.speciality as Speciality,
    U.userName as UserName
from Doctor as D
join AppUser as U
on D.userNo = U.userNo;

create view Management_LabTechnician_InfoView
as
select
	T.technicianNo as TechnicianNumber,
    CONCAT(T.firstName, ' ', T.fatherName) as TechnicianName,
    DATE_FORMAT(T.dateOfBirth, "%a, %b %e, %Y") as DateOfBirth,
    T.phoneNo as PhoneNumber,
    U.userName as UserName
from LabTechnician as T
join AppUser as U
on T.userNo = U.userNo;

create view Management_Reception_InfoView
as
select
	R.receptionNo as ReceptionNumber,
    CONCAT(R.firstName, ' ', R.fatherName) as ReceptionName,
    DATE_FORMAT(R.dateOfBirth, "%a, %b %e, %Y") as DateOfBirth,
    R.phoneNo as PhoneNumber,
    U.userName as UserName
from Reception as R
join AppUser as U
on R.userNo = U.userNo;

create view Management_Reception_TransactionsView
as
select
	Pay.paymentNo as PaymentNumber,
    Pay.receptionNo as ReceptionNumber,
    CONCAT(Pat.firstName, ' ', Pat.fatherName) as PatientName,
    Pay.paymentDetails as PaymentDetails,
    DATE_FORMAT(Pay.dateOfPayment, "%a, %b %e, %Y") as DateOfPayment,
    Pay.price as Price
from Payment as Pay
join Reception as R
	on Pay.receptionNo = R.receptionNo
join Patient as Pat
	on Pay.patientNo = Pat.patientNo;

insert into Payment(paymentNo, patientNo, paymentDetails, price) values
(58, 29, "TESt", 50.00)

