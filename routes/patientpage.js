const express = require('express');
const mysql = require("mysql")
const { AppError, wrapAsync } = require("../utils/error")
const methodOverride = require("method-override")
const validationSchemas = require("../utils/validationSchemas")

const router = express.Router();

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get('/', wrapAsync(async (req, res, next) => {
    res.render("PatientPage.ejs", { page: "patientpage" })
}))

const validatePatient = async (req, res, next) => {
    try {
        const validation = validationSchemas.patientSchema.validate(req.body)
        const { gender } = req.body.patient
        if (validation.error) {
            const msg = validation.error.details.map(e => e.message).join(', ')
            throw new AppError(400, msg)
        }
        else if (gender !== 'M' && gender !== 'F')
            throw new AppError(400, "Invalid Gender")
        else {
            next()
        }
    } catch (e) {
        next(e)
    }
}

router.get('/search', wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!")
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator."))
            return
        }
        con.query(`call spReception_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
                con.release()
                next(new AppError(500, "Database error occured! Please contact your system administrator."))
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
            next(new AppError(500, "Database error occured! Please contact your system administrator."))
            return
        }
        con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error) {
                con.release()
                next(new AppError(500, "Database error occured! Please contact your system administrator."))
                return
            }
            else {
                con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error) {
                        con.release()
                        next(new AppError(500, "Database error occured! Please contact your system administrator."))
                        return
                    }
                    else {
                        if (!info[0][0]) {
                            con.release()
                            next(new AppError(404, "Patient Not Found"))
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
            next(new AppError(500, "Database error occured!"))
            return
        }
        con.query("call spReception_GetPatientPendingPayments(?)", id, (error, pendingPayments, fields) => {
            if (error) {
                con.release()
                next(new AppError(500, "Database error occured!"))
                return
            }
            con.query("call spReception_GetPatientCompletedPayments(?)", id, (error, completedPayments, fields) => {
                if (error) {
                    con.release()
                    next(new AppError(500, "Database error occured!"))
                    return
                }
                res.render("Partials/PatientPage/payment.ejs", { pendingPayments, completedPayments })
            })
        })
    })
}))

router.get('/new', wrapAsync(async (req, res, next) => {
    res.render("Partials/PatientPage/new.ejs")
}))

function generateCardNo(lastCardNo) {
    if (!lastCardNo) {
        return "A0000"
    }
    let cardNums = lastCardNo.substring(1, lastCardNo.length)
    if (cardNums === "9999") {
        firstLetter = String.fromCharCode(lastCardNo.charCodeAt(0) + 1)
        return firstLetter + "0000"
    }
    else
        return lastCardNo.charAt(0) + (parseInt(cardNums) + 1).toString()
}

router.post('/', wrapAsync(validatePatient), wrapAsync(async (req, res, next) => {
    const { patient } = req.body
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please, contact your system administrator."))
            return
        }
        else {
            if (patient.hospitalized)
                patient.hospitalized = true
            else
                patient.hospitalized = false
            const patientArr = [patient.firstName, patient.fatherName, patient.dateOfBirth, patient.gender, patient.address, patient.phoneNo, patient.hospitalized]
            con.query("call spReception_AddPatient(?, ?, ?, ?, ?, ?, ?)", patientArr, (error, results, fields) => {
                if (error) {
                    con.release()
                    next(new AppError(500, error.sqlMessage))
                    return
                }
                else {
                    const { lastId } = results[0][0]
                    const { lastCardNo } = results[1][0]
                    const cardNo = generateCardNo(lastCardNo)
                    con.query("call spReception_AddCard(?, ?)", [lastId, cardNo], (error, results, fields) => {
                        if (error) {
                            con.release()
                            next(new AppError(500, "Database error occured!"))
                            return
                        }
                    })
                }
                con.release()
            })
        }
    })
    req.flash("success", "Patient added successfully.")
    res.redirect("/patientpage")
}))

module.exports = router