const express = require('express');
const { AppError, wrapAsync } = require("../../utils/error")
const db = require("../../utils/dbconnector")
const { patientSchema } = require("../../utils/validationSchemas")
const generateCardNo = require("../../utils/card-number-generator")
const { receptionAuthorization } = require("../../utils/authorization")
const { patientPage } = require('../../controllers/laboratorist');

const router = express.Router();

router.get("/", wrapAsync(patientPage.renderPatientPage));

router.get("/search", wrapAsync(patientPage.searchPatient));

router.get('/:id/info', wrapAsync(patientPage.showPatientInfo))

router.get('/:id/labReport', wrapAsync(patientPage.getPatientLabReports))

router.post("/:id/labReportResponse", wrapAsync(patientPage.createLabReportResponse))

module.exports = router;
