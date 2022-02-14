const express = require('express')
const { AppError, wrapAsync } = require("../../utils/error")
const router = express.Router()
const db = require("../../utils/dbconnector")

router.get('/', wrapAsync(async (req, res, next) => {
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError("Database Error Occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query("call spReception_LoadDashboardData()", (error, results, fields) => {
            if(error)
            {
                next(new AppError("Database Error Occured! Please contact your system administrator", res.locals.type))
                return
            }
            const { HospitalizedPatients } = results[0][0]
            const { TodaysAppointments } = results[1][0]
            const { TodaysPatients } = results[2][0]
            let { TotalIncome } = results[3][0]
            const WeekAppointments = results[4]
            const WeekIncomes = results[5]
            const PendingPayments = results[6]
            if (TotalIncome)
                TotalIncome = TotalIncome.toFixed(2)
            const homePageData = {
                page: "homepage",
                HospitalizedPatients,
                TodaysAppointments,
                TodaysPatients,
                TotalIncome,
                WeekAppointments,
                WeekIncomes,
                PendingPayments
            }

            res.render('Reception/HomePage.ejs', homePageData)
        })
    })
}))

module.exports = router