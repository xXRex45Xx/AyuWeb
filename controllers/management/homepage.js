const { AppError } = require('../../utils/error');
const db = require('../../utils/dbconnector');

module.exports.renderHomePage = async (req, res, next) => {
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError("Database Error Occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query("call spManagement_LoadDashboardData()", (error, results, fields) => {
            if (error) {
                next(new AppError("Database Error Occured! Please contact your system administrator.", res.locals.type))
                return
            }
            const { HospitalizedPatients } = results[0][0]
            const { TodaysPatients } = results[1][0]
            let { TotalIncome } = results[2][0]
            const WeekIncomes = results[3]
            const RecentPayments = results[4]
            if (TotalIncome)
                TotalIncome = TotalIncome.toFixed(2)
            const homePageData = {
                page: "homepage",
                HospitalizedPatients,
                TodaysPatients,
                TotalIncome,
                WeekIncomes,
                RecentPayments
            }
            res.render('Management/HomePage.ejs', homePageData)
        })
    })
}