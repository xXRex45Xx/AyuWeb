const express = require('express');
const mysql = require("mysql")
const { AppError, wrapAsync } = require("../../utils/error")

const router = express.Router()

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get("/", wrapAsync(async (req, res, next) => {
    res.render("Management/PatientPage.ejs", { page: "patientpage" })
}))

router.get('/search', wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!",res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
            return
        }
        con.query(`call spManagement_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
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
        con.query(`call spManagement_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.",res.locals.type))
                return
            }
            else {
                con.query(`call spManagement_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
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
            con.query("call spManagement_GetPatientCompletedPayments(?)", id, (error, completedPayments, fields) => {
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

module.exports = router