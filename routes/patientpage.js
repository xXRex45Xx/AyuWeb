const express = require('express');
const catchAsync = require("../utils/catchAsync")
const mysql = require("mysql")
const AppError = require("../utils/AppError")
const validationSchemas = require("../utils/validationSchemas")

const router = express.Router();

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get('/', catchAsync(async (req, res) => {
    res.render("PatientPage.ejs", { page: "patientpage" })
}))

const validatePatient = (req, res, next) => {
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
}

router.get('/search', catchAsync(async (req, res) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!")
    db.getConnection((err, con) => {
        if (err) {
            throw new AppError(500, "Database error occured! Please contact your system administrator.")
        }
        con.query(`call spReception_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
                con.release()
                throw new AppError(500, "Database error occured! Please contact your system administrator.")
            }
            else
                res.render('Partials/PatientPage/search.ejs', { patients: results })
        })
        con.release()
    })
}))

router.get('/:id/info', catchAsync(async (req, res) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err)
            throw new AppError(500, "Database error occured! Please contact your system administrator.")
        con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error) {
                con.release()
                throw new AppError(500, "Database error occured! Please, contact your system administrator.")
            }
            else {
                con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error) {
                        con.release()
                        throw new AppError(500, "Database error occured! Please contact your system administrator.")
                    }
                    else
                        res.render('Partials/PatientPage/info.ejs', { info, appointments })
                    con.release()
                })
            }
        })

    })
}))

router.get('/:id/payment', catchAsync(async (req, res) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err)
            throw new AppError(500, "Database error occured!")
        con.query("call spReception_GetPatientPendingPayments(?)", id, (error, pendingPayments, fields) => {
            if (error) {
                con.release()
                throw new AppError(500, "Database error occured!")
            }
            con.query("call spReception_GetPatientCompletedPayments(?)", id,(error, completedPayments, fields) =>{
                if(error){
                    con.release()
                    throw new AppError(500, "Database error occured!")
                }                
                res.render("Partials/PatientPage/payment.ejs", {pendingPayments, completedPayments})
            })
        })
    })
}))

router.get('/new', catchAsync(async (req, res) => {
    res.render("Partials/PatientPage/new.ejs")
}))

function generateCardNo(lastCardNo) {
    if (!lastCardNo)
        return null
    let cardNums = lastCardNo.substring(1, lastCardNo.length)
    if (cardNums === "9999") {
        firstLetter = String.fromCharCode(lastCardNo.charCodeAt(0) + 1)
        return firstLetter + "0000"
    }
    else
        return lastCardNo.charAt(0) + (parseInt(cardNums) + 1).toString()
}

router.post('/', validatePatient, catchAsync(async (req, res) => {
    if (!req.body.patient)
        throw new AppError(400, "Invalid Patient Data")
    const { patient } = req.body
    db.getConnection((err, con) => {
        if (err)
            throw new AppError(500, "Database error occured! Please, contact your system administrator.")
        else {
            if (patient.hospitalized)
                patient.hospitalized = true
            else
                patient.hospitalized = false
            const patientArr = [patient.firstName, patient.fatherName, patient.dateOfBirth, patient.gender, patient.address, patient.phoneNo, patient.hospitalized]
            con.query("call spReception_AddPatient(?, ?, ?, ?, ?, ?, ?)", patientArr, (error, results, fields) => {
                if (error) {
                    con.release()
                    throw new AppError(500, error.sqlMessage)
                }
                else {
                    console.log(results)
                    const { lastId } = results[0][0]
                    const { lastCardNo } = results[1][0]
                    const cardNo = generateCardNo(lastCardNo)
                    con.query("call spReception_AddCard(?, ?)", [lastId, cardNo], (error, results, fields) => {
                        if (error) {
                            con.release()
                            throw new AppError(500, error.sqlMessage)
                        }
                    })
                }
                con.release()
            })
        }
    })
    res.redirect("/patientpage")
}))

module.exports = router