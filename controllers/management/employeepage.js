const { AppError } = require('../../utils/error');
const bcrypt = require('bcrypt');
const db = require('../../utils/dbconnector');
const userType = require('../../utils/usertype');


module.exports.renderEmployeePage = async (req, res, next) => {
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

            res.render('Management/EmployeePage.ejs', { page: "employeepage", Doctors, Receptions, LabTechnicians })
        })
    })
}

module.exports.searchEmployee = async (req, res, next) => {
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
                res.render('Partials/EmployeePage/search.ejs', { Doctors: results[0], LabTechnicians: results[1], Receptions: results[2] })
        })
        con.release()
    })
}

module.exports.showEmployeeTransactions = async (req, res, next) => {
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
}

module.exports.renderNewEmployeeForm = async (req, res, next) => {
    res.render("Partials/EmployeePage/new.ejs")
}

module.exports.createEmployee = async (req, res, next) => {
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
}