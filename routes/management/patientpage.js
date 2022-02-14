const express = require('express');
const { patientSchema } = require("../../utils/validationSchemas")
const { AppError, wrapAsync } = require("../../utils/error")
const {patientPage} = require('../../controllers/management');

const router = express.Router()

const validatePatient = async (req, res, next) => {
    try {
        const validation = patientSchema.validate(req.body)
        const { gender } = req.body.patient
        if (validation.error) {
            const msg = validation.error.details.map(e => e.message).join(', ')
            throw new AppError(400, msg, res.locals.type)
        }
        else if (gender !== 'M' && gender !== 'F')
            throw new AppError(400, "Invalid Gender", res.locals.type)
        else {
            next()
        }
    } catch (e) {
        next(e)
    }
}

router.get("/", wrapAsync(patientPage.renderPatientPage))

router.get('/search', wrapAsync(patientPage.searchPatient))

router.get('/:id/info', wrapAsync(patientPage.showPatientInfo))

router.get('/:id/payment', wrapAsync(patientPage.showPatientPayments))

router.get("/:id/edit", wrapAsync(patientPage.renderUpdatePatientForm))

router.put("/:id", wrapAsync(validatePatient), wrapAsync(patientPage.updatePatient))

module.exports = router