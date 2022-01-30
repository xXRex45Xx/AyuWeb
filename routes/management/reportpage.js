const express = require("express")
const { AppError, wrapAsync } = require("../../utils/error")
const mysql = require("mysql")
const router = express.Router()

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get("/", wrapAsync(async (req, res, next) => {
    res.render("Management/ReportPage.ejs", { page: "reportpage" })
}))

router.get("/patientpayment", wrapAsync(async (req, res, next) => {
    res.render("Partials/ReportPage/PatientSelect.ejs")
}))

router.get("/patientpayment/:id", wrapAsync(async (req, res, next) => {
    const { id } = req.params
    if (!id || isNaN(id))
        throw new AppError(400, "Invalid Parameters!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", req.locals.type))
            return
        }
        con.query("call spManagement_GetPatientInfo(?)", id, (error, info, fields) => {
            if(error){
                next(new AppError(500, error.sqlMessage, res.locals.type))
                return
            }
            con.query("call spManagement_GetPatientCompletedPayments(?)", id, (error, payments, fields) => {
                if (error) {
                    next(new AppError(500, "Database Error Occured!", req.locals.type))
                    return
                }
                // console.log(info[0][0], payments[0])
                let total = 0
                for(let payment of payments[0]){
                    total += payment.Price
                } 
                res.render("Partials/Reports/PatientPaymentReport.ejs", {info: info[0][0], payments: payments[0], total})
            })
        })
    })
}))

module.exports = router