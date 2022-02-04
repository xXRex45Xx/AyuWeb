const express = require('express');
const mysql = require("mysql")
const { AppError, wrapAsync } = require("../../utils/error")
const methodOverride = require("method-override")
const { patientSchema } = require("../../utils/validationSchemas")
const generateCardNo = require("../../utils/card-number-generator");
const { object } = require('joi');
const labPrice = require('../../utils/LabRequestsPrice');

const router = express.Router();

router.use(methodOverride("_method"))

date = new Date();
day = date.getDate();
month = date.getMonth();
month = parseInt(month) + 1;
year = date.getFullYear();
var now = `${year}-${month}-${day}`


const db = mysql.createPool({
  connectionLimit: 100,
  host: 'localhost',
  user: 'Ayu',
  password: 'ayu.123',
  database: 'APHMSDB'
})

router.get("/", (req, res, next) => {
  res.render("Doctor/PatientPage.ejs", { page: "patientpage" });
});
router.get("/search", wrapAsync(async (req, res, next) => {
  const { q } = req.query;
  if (!q || isNaN(q)) {
    throw new appError(400, "Please enter a valid query", res.locals.type);
  }
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type));
      return;
    }
    con.query(
      `call spReception_SearchPatient(?)`,
      q,
      (error, results, fields) => {
        if (error) {
          con.release();
          next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type));
          return;
        }
        else {
          res.render('Partials/PatientPage/search.ejs', { patients: results })
        }
        con.release()
      }
    );
  });
})
);

router.get('/:id/info', wrapAsync(async (req, res, next) => {
  const { id } = req.params
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
      return
    }
    con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
      if (error) {
        next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
        return
      }
      else {
        con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
          if (error) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
          }
          else {
            con.query(`call spDoctor_GetVitalSign(?)`, id, (error, vitalSign, fields) => {
              if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                return
              }
              else {
                if (!info[0][0]) {
                  con.release()
                  next(new AppError(404, "Patient Not Found", res.locals.type))
                  return
                }
                res.render('Partials/DoctorPage/info.ejs', { info, appointments, vitalSign, day, month, year })
              }
              con.release()
            })
          }

        })
      }
    })

  })
}))

router.get('/:id/labReport', wrapAsync(async (req, res, next) => {
  const { id } = req.params
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
      return
    }
    con.query(`call spDoctor_GetLabReport(?)`, id, (error, labreport, fields) => {
      if (error) {
        next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
        return
      }
      else {
        var recent = []
        var previous = []
        if (labreport[0].length > 0) {
          let today = new Date()
          recent = labreport[0].filter(labreport => (today.getTime() - labreport.DateTimeOfRequest.getTime()) < 604800000)
          previous = labreport[0].filter(labreport => (today.getTime() - labreport.DateTimeOfRequest.getTime()) > 604800000)
          res.render('Partials/DoctorPage/labReport.ejs', { recent, previous })
        }
        else
          res.render('Partials/DoctorPage/labReport.ejs', { recent, previous })
        con.release()

      }
    })
  })
}))

router.get('/:id/labRequest', wrapAsync(async (req, res, next) => {
  const { id } = req.params
  res.render('Partials/DoctorPage/labRequest.ejs', { id })
}))

router.post("/:id/newlabRequest", (req, res, next) => {
  var labRequestsPrice = 0;
  const { labRequest } = req.body
  const { id } = req.params
  const { userId } = req.session.user
  var requestId;
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please, contact your system administrator.", res.locals.type))
      return
    }
    else {
      con.query("call spDoctor_AddLabRequest(?,?,?)", [userId, id, now], (error, results, fields) => {
        if (error) {
          next(new AppError(500, error.sqlMessage, res.locals.type))
          return
        }
        req.flash("success", "Lab Request added successfully.")
        res.redirect("/doctor/patientpage")
      })
      con.query("call spDoctor_GetLastLabRequestId()", (error, results, fields) => {
        if (error) {
          next(new AppError(500, error.sqlMessage, res.locals.type))
          return
        }
        requestId = results[0][0].RequestNo
        for (const type of Object.keys(labRequest)) {
          labRequestsPrice += labPrice.get(type.toString())
          con.query("call spDoctor_AddLabRequestDetail(?,?)", [requestId, type], (error, results, fields) => {
            if (error) {
              next(new AppError(500, error.sqlMessage, res.locals.type))
              return
            }
          })
        }
        con.query("call spDoctor_AddLabRequestPayment(?,?,?)", [id, labRequestsPrice, now], (error, results, fields) => {
          if (error) {
            next(new AppError(500, error.sqlMessage, res.locals.type))
            return
          }
        })
        con.release()
      })
    }
  })
})
router.get('/:id/diagnostics', wrapAsync(async (req, res, next) => {
  const { id } = req.params
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
      return
    }
    con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
      if (error) {
        next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
        return
      }
      else {
        con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
          if (error) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
          }
          else {
            if (!info[0][0]) {
              con.release()
              next(new AppError(404, "Can't make request", res.locals.type))
              return
            }
            res.render('Partials/DoctorPage/diagonstics.ejs', { info, appointments, id, day, month, year })
          }
          con.release()
        })
      }
    })

  })
}))

router.post("/:id/newDiagnosis", wrapAsync(async (req, res, next) => {
  const { diagnosis } = req.body
  const { id } = req.params
  const { userId } = req.session.user
  const diagnosisData = [id, now, userId, diagnosis.content]
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please, contact your system administrator.", res.locals.type))
      return
    }
    else {
      con.query("call spDoctor_AddDiagnosis(?,?,?,?)", diagnosisData, (error, results, fields) => {
        if (error) {
          next(new AppError(500, error.sqlMessage, res.locals.type))
          return
        }
        con.release()
      })
    }
  })
  req.flash("success", "Diagnosis added successfully.")
  res.redirect("/doctor/patientpage")
}))

router.post("/:id/appointment", wrapAsync(async (req, res, next) => {
  const { appointmentDate, appointmentTime, patientId } = req.body
  const { userId } = req.session.user
  db.getConnection((err, con) => {
    if (err) {
      next(new AppError(500, "Database error occured! Please, contact your system administrator.", res.locals.type))
      return
    }
    else {
      con.query("call spDoctor_GetCountOfAppointment(?,?,?)", [patientId, userId, appointmentDate], (error, results, fields) => {
        if (error) {
          next(new AppError(500, error.sqlMessage, res.locals.type))
          return
        }
        if (results[0].length > 0) {
          con.query("call spDoctor_UpdateAppointment(?,?,?,?)", [patientId, userId, appointmentDate, appointmentTime], (error, results, fields) => {
            if (error) {
              next(new AppError(500, error.sqlMessage, res.locals.type))
              return
            }
          })
        }
        else {
          con.query("call spDoctor_AddAppointment(?,?,?,?)", [patientId, userId, appointmentDate, appointmentTime], (error, results, fields) => {
            if (error) {
              next(new AppError(500, error.sqlMessage, res.locals.type))
              return
            }
          })
        }
        con.release()
      })
    }
  })
}))
module.exports = router;
