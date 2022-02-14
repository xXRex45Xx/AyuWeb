const db = require("../../utils/dbconnector");
const {AppError} = require('../../utils/error');

module.exports.renderPatientPage = async (req, res, next) => {
    res.render("Management/PatientPage.ejs", { page: "patientpage" })
}

module.exports.searchPatient = async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query(`call spManagement_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                return
            }
            else
                res.render('Partials/PatientPage/search.ejs', { patients: results })
        })
        con.release()
    })
}

module.exports.showPatientInfo = async (req, res, next) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
            return
        }
        con.query(`call spManagement_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured! Please contact your system administrator.", res.locals.type))
                return
            }
            else {
                con.query(`call spManagement_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
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
                        res.render('Partials/PatientPage/info.ejs', { info, appointments, management: true })
                    }
                    con.release()
                })
            }
        })

    })
}

module.exports.showPatientPayments = async (req, res, next) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured!", res.locals.type))
            return
        }
        con.query("call spReception_GetPatientPendingPayments(?)", id, (error, pendingPayments, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!", res.locals.type))
                return
            }
            con.query("call spManagement_GetPatientCompletedPayments(?)", id, (error, completedPayments, fields) => {
                if (error) {
                    next(new AppError(500, "Database error occured!", res.locals.type))
                    return
                }
                res.render("Partials/PatientPage/payment.ejs", { pendingPayments, completedPayments })
                con.release()
            })
        })
    })
}

module.exports.renderUpdatePatientForm = async (req, res, next) => {
    const { id } = req.params;
    if (!id)
        throw new AppError(400, "Invalid Parameters!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetFullPatientInfo(?)", id, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database Error Occured!", res.locals.type))
                return
            }
            res.render("Partials/PatientPage/update.ejs", { patient: results[0][0] })
            con.release()
        })
    })
}

module.exports.updatePatient = async (req, res, next) => {
    const { id } = req.params
    const { patient } = req.body
    if (!id)
        throw new AppError(400, "Invalid Parameters", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        if (patient.hospitalized)
            patient.hospitalized = true
        else
            patient.hospitalized = false
        const queryParams = [id, patient.firstName, patient.fatherName, patient.dateOfBirth, patient.gender, patient.address, patient.phoneNo, patient.hospitalized]
        con.query("call spManagement_UpdatePatient(?,?,?,?,?,?,?,?)", queryParams, (error,results,fields) =>{
            if(error){
                next(new AppError(500, error.sqlMessage, res.locals.type))
                return
            }
            con.release()
            req.flash("success", "Patient updated successfully.")
            res.redirect("/management/patientpage")
        })
    })
}