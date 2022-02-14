const express = require('express');
const { wrapAsync } = require("../../utils/error")
const { patientPage } = require('../../controllers/doctor');

const router = express.Router();

router.get("/", wrapAsync(patientPage.renderPatientPage));

router.get("/search", wrapAsync(patientPage.searchPatient));

router.get('/:id/info', wrapAsync(patientPage.showPatientInfo))

router.get('/:id/labReport', wrapAsync(patientPage.showPatientLabReports))

router.get('/:id/labRequest', wrapAsync(patientPage.renderNewLabRequestForm))

router.get('/:id/served', wrapAsync(patientPage.servePatient))

router.post("/:id/newlabRequest", wrapAsync(patientPage.createNewLabRequest));

router.get('/:id/newDiagnosis', wrapAsync(patientPage.renderNewDiagnosisForm))

router.post("/:id/newDiagnosis", wrapAsync(patientPage.createDiagnosis))

router.post("/:id/appointment", wrapAsync(patientPage.createAppointment))

module.exports = router;
