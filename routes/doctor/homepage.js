const express = require('express')
const mysql = require("mysql")
const { wrapAsync } = require("../../utils/error")
const router = express.Router()

const db = mysql.createPool({
  connectionLimit: 100,
  host: 'localhost',
  user: 'Ayu',
  password: 'ayu.123',
  database: 'APHMSDB'
})

router.get('/', wrapAsync(async (req, res, next) => {
  const pendingPatients = router.locals.settings.queue
  const pendingPatientsCount = pendingPatients.length
  var pendingPatientslist = new Array()

  db.getConnection((err, con) => {
      if (err) {
        next(new AppError(500, "Database error occured! Please, contact your system administrator.", res.locals.type))
        return
      }
      else {
        for (let i = 0; i < pendingPatientsCount; i++) {
        con.query("call spDoctor_LoadDashboardData_PendingPatient(?)", pendingPatients[i].patientId, (error, results, fields) => {
          if (error) {
            next(new AppError(500, error.sqlMessage, res.locals.type))
            return
          }
          pendingPatientslist.push(...results[0]);
        })
      }}
      con.release()
    })
    console.log(pendingPatientslist);



  res.render('Doctor/HomePage.ejs', { page: "homepage" })
}))

module.exports = router