const express = require('express')
const { AppError, wrapAsync } = require("../../utils/error")
const { employeeSchema } = require("../../utils/validationSchemas")
const userType = require("../../utils/usertype")
const mysql = require("mysql")
const bcrypt = require("bcrypt")
const router = express.Router()

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

const validateEmployee = async (req, res, next) => {
    try {
        const validation = employeeSchema.validate(req.body)
        const { speciality } = req.body.employee
        if (validation.error) {
            const msg = validation.error.details.map(e => e.message).join(', ')
            throw new AppError(400, msg, res.locals.type)
        }
        else if (req.body.employee.type === userType.doctor) {
            switch (speciality) {
                case "gynecologist":
                    break;
                case "gp":
                    break;
                case "surgeon":
                    break;
                case "skin":
                    break;
                case "skeletal":
                    break;
                case "eye":
                    break;
                default:
                    throw new AppError(400, "Invalid Doctor Speciality", res.locals.type);
                    break;
            }
        }
        else {
            next()
        }
    } catch (e) {
        next(e)
    }
}

router.get('/', wrapAsync(async (req, res, next) => {
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetAllEmployee()", (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database Error Occured!", res.locals.type))
                return
            }
            const Doctors = results[0]
            const Receptions = results[1]
            const LabTechnicians = results[2]
            // console.log("Doctors: ", Doctors)
            // console.log("Receptions: ", Receptions)
            // console.log("LabTechnicians: ", LabTechnicians)

            res.render('Management/EmployeePage.ejs', { page: "employeepage", Doctors, Receptions, LabTechnicians })
        })
    })
}))

router.get('/search', wrapAsync(async (req, res, next) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!", res.locals.type)
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured!", res.locals.type))
            return
        }
        con.query(`call spManagement_SearchEmployee(?)`, q, (error, results, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!", res.locals.type))
                return
            }
            else
                res.render('Partials/EmployeePage/search.ejs', { doctors: results[0], labTechnicians: results[1], receptionists: results[2] })
        })
        con.release()
    })
}))

router.get('/:id/info', wrapAsync(async (req, res, next) => {
    const { id } = req.params
    const { role } = req.query
    if (!role || !id)
        throw new AppError(400, "Invalid Parameters!")
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database error occured!", res.locals.type))
            return
        }
        let query;
        if (role === "Doctor")
            query = "call spManagement_GetDoctorInfo(?)"
        else if (role === "Lab Technician")
            query = "call spManagement_GetLabTechnicianInfo(?)"
        else if (role === "Receptionist")
            query = "call spManagement_GetReceptionInfo(?)"
        else {
            next(new AppError(400, "Invalid Role"))
            return
        }
        con.query(query, id, (error, info, fields) => {
            if (error) {
                next(new AppError(500, "Database error occured!", res.locals.type))
                return
            }
            else {
                res.render("Partials/EmployeePage/info.ejs", { info: info[0], role })
            }
        })

    })
}))

router.get("/:id/transactions", wrapAsync(async (req, res, next) => {
    const { id } = req.params
    if (!id)
        throw new AppError(400, "Invalid Paramaters")
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!", res.locals.type))
            return
        }
        con.query("call spManagement_GetReceptionTransactions(?)", id, (error, results, fields) => {
            if (error) {
                next(new AppError(500, error.sqlMessage, res.locals.type))
                return
            }
            res.render("Partials/EmployeePage/transactions.ejs", { transactions: results[0] })
        })
    })
}))

router.get('/new', wrapAsync(async (req, res, next) => {
    res.render("Partials/EmployeePage/new.ejs")
}))

router.post("/", wrapAsync(validateEmployee), wrapAsync(async (req, res, next) => {
    const { employee } = req.body
    db.getConnection(async (err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured"))
            return
        }
        else {
            let username = employee.firstName + employee.phoneNo.toString().slice(-2);
            let password = await bcrypt.hash(username, 12)
            con.query("call spManagement_AddUser(?,?,?)", [username, password, employee.type], async (error, results, fields) => {
                if (error) {
                    next(new AppError(500, "Database Error Occured!", res.locals.type))
                    return
                }
                const { lastUserNo } = results[0][0]
                let q;
                employee.type = parseInt(employee.type)
                let queryParams = [employee.firstName, employee.fatherName, employee.dateOfBirth, employee.phoneNo, lastUserNo]
                if (employee.type === userType.receptionist)
                    q = "call spManagement_AddReception(?,?,?,?,?)"
                else if (employee.type === userType.doctor) {
                    q = "call spManagement_AddDoctor(?,?,?,?,?,?)"
                    queryParams = [employee.firstName, employee.fatherName, employee.dateOfBirth, employee.phoneNo, employee.speciality, lastUserNo]
                }
                else if (employee.type === userType.labTechnician)
                    q = "call spManagement_AddLabTechnician(?,?,?,?,?)"
                else {
                    next(new AppError(400, "Invalid Employee Type"))
                    return
                }
                con.query(q, queryParams, (error, results, fields) => {
                    if (error) {
                        next(new AppError(500, error.sqlMessage, res.locals.type))
                        return;
                    }
                    con.release()
                    req.flash("success", "Employee Added Successfully")
                    res.redirect("/management/employeepage")
                })
            })
        }
    })
}))

module.exports = router