use APHMSDB;
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

alter view ReceptionPatientAppointmentView
as
select	A.PatientNo as PatientNumber,
		CONCAT(D.firstName + ' ', D.fatherName) as DoctorName,
		DATE_FORMAT(A.DateOfAppointment, '%a, %b %e, %Y') as DateOfAppointment,
		A.TimeOfAppointment
from Appointment as A
join Doctor as D
on A.DoctorNo = D.doctorNo;

alter view Reception_Patient_CompletedPaymentView
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

alter view Reception_Patient_PendingPaymentView
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




