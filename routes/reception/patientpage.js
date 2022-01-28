const express = require('express');
const mysql = require("mysql")
const { AppError, wrapAsync } = require("../../utils/error")
const methodOverride = require("method-override")
const {patientSchema} = require("../../utils/validationSchemas")
const generateCardNo = require("../../utils/card-number-generator")

const router = express.Router();

router.use(methodOverride("_method"))

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get('/', wrapAsync(async (req, res, next) => {
    res.render("Reception/PatientPage.ejs", { page: "patientpage" })
}))

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

router.get('/search', wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!",res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
            return
        }
        con.query(`call spReception_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
                con.release()
                next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
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
            next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
            return
        }
        con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
                return
            }
            else {
                con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error) {
                        next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
                        return
                    }
                    else {
                        if (!info[0][0]) {
                            con.release()
                            next(new AppError(404, "Patient Not Found",res.locals.type))
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
            next(new AppError(500, "Database error occured!",res.locals.type))
            return
        }
        con.query("call spReception_GetPatientPendingPayments(?)", id, (error, pendingPayments, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!",res.locals.type))
                return
            }
            con.query("call spReception_GetPatientCompletedPayments(?)", id, (error, completedPayments, fields) => {
                if (error) {
                    next(new AppError(500, "Database error occured!",res.locals.type))
                    return
                }
                res.render("Partials/PatientPage/payment.ejs", { pendingPayments, completedPayments })
                con.release()
            })
        })
    })
}))

router.delete("/:patientId/payment/:paymentId", wrapAsync(async (req,res,next) =>{
    const {patientId, paymentId} = req.params
    const{id} = req.params
    db.getConnection((err, con) =>{
        if(err){
            next(new AppError(500, "Database Error Occured",res.locals.type))
            return
        }
        con.query("call spReception_CancelPayment(?)",paymentId, (error, results, fields) =>{
            if(error){
                next(new AppError(500, "Database error occured!",res.locals.type))
                return
            }
            const {affectedRows} = results
            if(affectedRows == 0){
                con.release()
                next(new AppError(400, "Cannot delete selected payment!",res.locals.type))
                return
            }            
            req.flash("success", "Payment canceled successfuly.")
            res.render("Partials/Flash/successflash.ejs", {success: req.flash("success")})
        })
    })
}))

router.get('/new', wrapAsync(async (req, res, next) => {
    res.render("Partials/PatientPage/new.ejs")
}))

router.post('/', wrapAsync(validatePatient), wrapAsync(async (req, res, next) => {
    const { patient } = req.body
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please, contact your system administrator.",res.locals.type))
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
                    next(new AppError(500, error.sqlMessage,res.locals.type))
                    return
                }
                else {
                    const { lastId } = results[0][0]
                    const { lastCardNo } = results[1][0]
                    const cardNo = generateCardNo(lastCardNo)
                    con.query("call spReception_AddCard(?, ?)", [lastId, cardNo], (error, results, fields) => {
                        if (error) {
                            next(new AppError(500, "Database error occured!",res.locals.type))
                            return
                        }
                    })
                }
                con.release()
            })
        }
    })
    req.flash("success", "Patient added successfully.")
    res.redirect("/reception/patientpage")
}))

module.exports = router