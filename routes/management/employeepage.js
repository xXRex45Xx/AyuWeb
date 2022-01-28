const express = require('express')
const {AppError,wrapAsync} = require("../../utils/error")
const mysql = require("mysql")
const router = express.Router()

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get('/', wrapAsync(async (req, res, next) => {
    res.render('Management/EmployeePage.ejs', { page: "employeepage"})
}))

router.get('/search', wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!",res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured!",res.locals.type))
            return
        }
        con.query(`call spManagement_SearchEmployee(?)`, q, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!",res.locals.type))
                return
            }
            else
                res.render('Partials/EmployeePage/search.ejs', { doctors: results[0], labTechnicians: results[1], receptionists: results[2] })
        })
        con.release()
    })
}))

router.get('/:id/info', wrapAsync(async (req, res, next) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured!",res.locals.type))
            return
        }
        con.query(`call spManagement_GetEmployeeInfo(?)`, id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!",res.locals.type))
                return
            }
            else {
                con.query(`call spManagement_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error) {
                        next(new AppError(500, "Database error occured!",res.locals.type))
                        return
                    }
                    else {
                        if (!info[0][0]) {
                            con.release()
                            next(new AppError(404, "Employee Not Found",res.locals.type))
                            return
                        }
                        res.render('Partials/EmployeePage/info.ejs', { info, appointments })
                    }
                    con.release()
                })
            }
        })

    })
}))

module.exports = router