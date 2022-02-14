const {AppError} = require('../../utils/error');
const generateCardNo = require('../../utils/card-number-generator');
const db = require('../../utils/dbconnector');

module.exports.renderPatientPage = async (req, res, next) => {
    res.render("Reception/PatientPage.ejs", { page: "patientpage" })
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
        con.query(`call spReception_SearchPatient(?)`, q, (error, results, fields) => {
            if (error) {
                con.release()
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
                        res.render('Partials/PatientPage/info.ejs', { info, appointments })
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
            con.query("call spReception_GetPatientCompletedPayments(?)", id, (error, completedPayments, fields) => {
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

module.exports.printPaymentReceipt = async (req, res, next) => {
    const { selectedPayment } = req.query
    const { userId } = req.session.user
    if (!selectedPayment || (selectedPayment && selectedPayment.length === 0))
        throw new AppError(400, "Invalid Parameters1", res.locals.type)
    selectedPayment.forEach(element => {
        if (isNaN(element))
            throw new AppError(400, "Invalid Parameters!", res.locals.type)
    });
    db.getConnection(async (err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        let finalizedPayments = new Array()
        today = new Date().toISOString().slice(0, 10)
        for (let i = 0; i < selectedPayment.length; i++) {
            con.query("call spReception_FinalizePayment(?,?,?)", [selectedPayment[i], today, userId], (error, results, fields) => {
                if (error) {
                    next(new AppError(500, "Database Error Occured!", res.locals.type))
                    return
                }
                finalizedPayments.push({ ...results[0][0] })
                if (i === selectedPayment.length - 1) {
                    let total = 0
                    for (let payment of finalizedPayments) {
                        total += payment.Price
                    }
                    res.render("Partials/Reports/PatientPaymentReport.ejs", { payments: finalizedPayments, total: total.toFixed(2), attachment: true })
                }
            })
        }
    })
}

module.exports.registerPayment = async (req, res, next) => {
    const { selectedPayment } = req.query
    const { userId } = req.session.user
    if (!selectedPayment || (selectedPayment && selectedPayment.length === 0))
        throw new AppError(400, "Invalid Parameters1", res.locals.type)
    selectedPayment.forEach(element => {
        if (isNaN(element))
            throw new AppError(400, "Invalid Parameters!", res.locals.type)
    });
    db.getConnection(async (err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        today = new Date().toISOString().slice(0, 10)
        for (let i = 0; i < selectedPayment.length; i++) {
            con.query("call spReception_FinalizePayment(?,?,?)", [selectedPayment[i], today, userId], (error, results, fields) => {
                if (error) {
                    next(new AppError(500, "Database Error Occured!", res.locals.type))
                    return
                }

            })
        }
        res.send("success")
    })
}

module.exports.renderNewPatientForm = async (req, res, next) => {
    res.render("Partials/PatientPage/new.ejs")
}

module.exports.createPatient = async (req, res, next) => {
    const { patient } = req.body
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured! Please, contact your system administrator.", res.locals.type))
            return
        }
        else {
            if (patient.hospitalized)
                patient.hospitalized = true
            else
                patient.hospitalized = false
            const patientArr = [patient.firstName, patient.fatherName, patient.dateOfBirth, patient.gender, patient.address, patient.phoneNo, patient.hospitalized]
            con.query("call spReception_AddPatient(?, ?, ?, ?, ?, ?, ?)", patientArr, (error, results, fields) => {
                if (error) {
                    next(new AppError(500, error.sqlMessage, res.locals.type))
                    return
                }
                else {
                    const { lastId } = results[0][0]
                    const { lastCardNo } = results[1][0]
                    const cardNo = generateCardNo(lastCardNo)
                    con.query("call spReception_AddCardandRegFee(?, ?)", [lastId, cardNo], (error, results, fields) => {
                        if (error) {
                            next(new AppError(500, "Database error occured!", res.locals.type))
                            return
                        }
                    })
                }
                con.release()
                req.flash("success", "Patient added successfully.")
                res.redirect("/reception/patientpage")
            })
        }
    })
}

module.exports.queuePatient = async (req, res, next) => {
    const { doctorType, patientId } = req.body
    req.locals.queue.push({ doctorType, patientId })
    res.render("Partials/Flash/successflash.ejs", {success: "Patient Queued Successfully."})
}