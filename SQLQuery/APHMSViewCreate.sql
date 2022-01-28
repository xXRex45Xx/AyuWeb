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





