const express = require('express')
const mysql = require("mysql")
const { wrapAsync } = require("../../utils/error")
const db = require("../../utils/dbconnector")

const router = express.Router()

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
        con.query("call spDoctor_LoadDashboardData_TodayAppointment()",(error, results, fields) => {
            if (error) {
              next(new AppError(500, error.sqlMessage, res.locals.type))
              return
            }
            const todayAppointment = results[0]
            if(pendingPatientsCount>0){
            for (let i = 0; i < pendingPatientsCount; i++) {
            con.query("call spDoctor_LoadDashboardData_PendingPatient(?)", pendingPatients[i].patientId, (error, results, fields) => {
              if (error) {
                next(new AppError(500, error.sqlMessage, res.locals.type))
                return
              }
              pendingPatientslist.push(...results[0]);
              if(i==pendingPatientsCount-1){
                res.render('Doctor/HomePage.ejs', { page: "homepage",todayAppointment,pendingPatientslist})
              }
            })}}
            else{
              res.render('Doctor/HomePage.ejs', { page: "homepage",todayAppointment,pendingPatientslist})
            }

            con.release()
          }
        )}
    })
  
}))

module.exports = router