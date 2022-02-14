const express = require('express');
const { AppError, wrapAsync } = require("../../utils/error")
const { patientSchema } = require("../../utils/validationSchemas")
const { patientPage } = require('../../controllers/reception');

const router = express.Router();

patientPage.locals = router.locals

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
router.route("/")
    .get(wrapAsync(patientPage.renderPatientPage))
    .post(wrapAsync(validatePatient), wrapAsync(patientPage.createPatient))

router.get('/search', wrapAsync(patientPage.searchPatient))

router.get("/payment/reciept", wrapAsync(patientPage.printPaymentReceipt))

router.get("/payment/register", wrapAsync(patientPage.registerPayment))

router.get('/new', wrapAsync(patientPage.renderNewPatientForm))

router.post("/queue", wrapAsync(async (req, res, next) => {
    req.locals = { queue: router.locals.settings.queue }
    next()
}), wrapAsync(patientPage.queuePatient))

router.get('/:id/info', wrapAsync(patientPage.showPatientInfo))

router.get('/:id/payment', wrapAsync(patientPage.showPatientPayments))

module.exports = router