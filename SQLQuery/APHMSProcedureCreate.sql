use APHMSDB;
delimiter &&
create procedure spReception_SearchPatient(in phoneNo int)
begin
	select * from ReceptionPatientSearchView
	where PhoneNumber = phoneNo;
end &&
    
delimiter &&
create procedure spReception_GetPatientInfo(in patientNo int)
begin
	select * from ReceptionPatientInfoView
	where PatientNumber = patientNo;
end &&

delimiter &&
create procedure spReception_GetPatientAppointments(in patientNo int)
begin
	select * from ReceptionPatientAppointmentView
	where PatientNumber = patientNo;
end &&