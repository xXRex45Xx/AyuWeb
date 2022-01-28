const express = require('express');
const mysql = require("mysql")
const { AppError, wrapAsync } = require("../../utils/error")
const methodOverride = require("method-override")
const { patientSchema } = require("../../utils/validationSchemas")
const generateCardNo = require("../../utils/card-number-generator")
const { receptionAuthorization } = require("../../utils/authorization")

const router = express.Router();

router.use(methodOverride("_method"))
// router.use(receptionAuthorization)
// create a new authorization for the doctor


date = new Date();
day = date.getDate();
day = parseInt(day) - 1;
month = date.getMonth();
month = parseInt(month) + 1;
year = date.getFullYear();

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
            if (!info[0][0]) {
              con.release()
              next(new AppError(404, "Patient Not Found", res.locals.type))
              return
            }
            res.render('Partials/DoctorPage/info.ejs', { info, appointments, day, month, year })
          }
          con.release()
        })
      }
    })

  })
}))

module.exports = router;
