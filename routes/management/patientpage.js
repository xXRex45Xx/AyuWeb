const express = require('express');
const { patientSchema } = require("../../utils/validationSchemas")
const { AppError, wrapAsync } = require("../../utils/error")
const db = require("../../utils/dbconnector")

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

router.get("/", wrapAsync(async (req, res, next) => {
    res.render("Management/PatientPage.ejs", { page: "patientpage" })
}))

router.get('/search', wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query(`call spManagement_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                return
            }
            else
                res.render('Partials/PatientPage/search.ejs', { patients: results })
        })
        con.release()
    })
}))

router.get('/:id/info', wrapAsync(async (req, res, next) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query(`call spManagement_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                return
            }
            else {
                con.query(`call spManagement_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error) {
                        next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                        return
                    }
                    else {
                        if (!info[0][0]) {
                            con.release()
                            next(new AppError(404, "Patient Not Found", res.locals.type))
                            return
                        }
                        res.render('Partials/PatientPage/info.ejs', { info, appointments })
                    }
                    con.release()
                })
            }
        })

    })
}))

router.get('/:id/payment', wrapAsync(async (req, res, next) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured!", res.locals.type))
            return
        }
        con.query("call spReception_GetPatientPendingPayments(?)", id, (error, pendingPayments, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!", res.locals.type))
                return
            }
            con.query("call spManagement_GetPatientCompletedPayments(?)", id, (error, completedPayments, fields) => {
                if (error) {
                    next(new AppError(500, "Database error occured!", res.locals.type))
                    return
                }
                res.render("Partials/PatientPage/payment.ejs", { pendingPayments, completedPayments })
                con.release()
            })
        })
    })
}))

router.get("/:id/edit", wrapAsync(async (req, res, next) => {
    const { id } = req.params;
    if (!id)
        throw new AppError(400, "Invalid Parameters!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetFullPatientInfo(?)", id, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database Error Occured!", res.locals.type))
                return
            }
            res.render("Partials/PatientPage/update.ejs", { patient: results[0][0] })
            con.release()
        })
    })
}))

router.put("/:id", wrapAsync(validatePatient), wrapAsync(async (req, res, next) => {
    const { id } = req.params
    const { patient } = req.body
    if (!id)
        throw new AppError(400, "Invalid Parameters", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        if (patient.hospitalized)
            patient.hospitalized = true
        else
            patient.hospitalized = false
        const queryParams = [id, patient.firstName, patient.fatherName, patient.dateOfBirth, patient.gender, patient.address, patient.phoneNo, patient.hospitalized]
        con.query("call spManagement_UpdatePatient(?,?,?,?,?,?,?,?)", queryParams, (error,results,fields) =>{
            if(error){
                next(new AppError(500, error.sqlMessage, res.locals.type))
                return
            }
            con.release()
            req.flash("success", "Patient updated successfully.")
            res.redirect("/management/patientpage")
        })
    })
}))

module.exports = router