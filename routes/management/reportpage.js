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

router.get("/reception/search", wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query(`call spManagement_SearchReception(?)`, q, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                return
            }
            else
                res.render('Partials/ReportPage/ReceptionSearch.ejs', { receptionists: results[0] })
        })
        con.release()
    })
}))

router.get("/receptiontransaction/:id", wrapAsync(async (req, res, next) => {
    const { id } = req.params
    if (!id || isNaN(id))
        throw new AppError(400, "Invalid Parameters!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetReceptionInfo(?)", id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database Error Occured!", res.locals.type))
                return
            }
            con.query("call spManagement_GetReceptionTransactions(?)", id, (error, transactions, fields) => {
                if (error) {
                    next(new AppError(500, "Database Error Occured!", res.locals.type))
                    return
                }
                let total = 0
                for (let transaction of transactions[0]) {
                    total += transaction.Price
                }
                res.render("Partials/Reports/ReceptionTransactionReport.ejs", { info: info[0][0], transactions: transactions[0], total })
            })
        })
    })
}))

router.get("/dailyreport/:reportdate", wrapAsync(async (req, res, next) => {
    const { reportdate } = req.params
    if (!reportdate || isNaN(Date.parse(reportdate)))
        throw new AppError(400, "Invalid Parameters!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetDailyTransactions(?)", reportdate, (error, transactions, fields) => {
            if(error){
                next(new AppError(500, "Database Error Occured!", res.locals.type))
                return
            }
            let total = 0
            for(let transaction of transactions[0]){
                total += transaction.Price
            }
            res.render("Partials/Reports/DailyIncomeReport.ejs", {transactions: transactions[0], total})
        })
    })
}))

router.get("/patientpayment/:id", wrapAsync(async (req, res, next) => {
    const { id } = req.params
    if (!id || isNaN(id))
        throw new AppError(400, "Invalid Parameters!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetPatientInfo(?)", id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, error.sqlMessage, res.locals.type))
                return
            }
            con.query("call spManagement_GetPatientCompletedPayments(?)", id, (error, payments, fields) => {
                if (error) {
                    next(new AppError(500, "Database Error Occured!", res.locals.type))
                    return
                }
                // console.log(info[0][0], payments[0])
                let total = 0
                for (let payment of payments[0]) {
                    total += payment.Price
                }
                res.render("Partials/Reports/PatientPaymentReport.ejs", { info: info[0][0], payments: payments[0], total, attachment: false})
            })
        })
    })
}))

module.exports = router