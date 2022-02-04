const express = require('express')
const { AppError, wrapAsync } = require("../utils/error")
const mysql = require("mysql")
const userType = require("../utils/usertype")
const { userSchema } = require("../utils/validationSchemas")
const bcrypt = require("bcrypt")
const { management } = require('../utils/usertype')
const router = express.Router()

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

const validateUser = async (req, res, next) => {
    try {
        const validation = userSchema.login.validate(req.body)
        if (validation.error) {
            const msg = validation.error.details.map(e => e.message).join(', ')
            throw new AppError(400, msg)
        }
        else {
            next()
        }
    } catch (e) {
        next(e)
    }
}

router.get("/", wrapAsync(async (req, res, next) => {
    if (!req.session.user) {
        res.render("LoginPage.ejs")
        return
    }
    else {
        const { role } = req.session.user
        switch (role) {
            case userType.receptionist:
                res.redirect("/reception/homepage")
                break;
            case userType.labTechnician:
                res.redirect("/laboratorist/patientpage")
                break;
            case userType.management:
                res.redirect("/management/homepage")
                break;
            case userType.doctor:
                res.redirect("/doctor/homepage")
                break;
            default:
                throw new AppError(400, "Invalid User")
        }
    }
}))

router.post("/", validateUser, wrapAsync(async (req, res, next) => {
    const { user } = req.body;
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!"))
            return
        }
        con.query("call spGetUser(?)", user.username, async (err, results, fields) => {
            if (err) {
                next(new AppError(500, "Database Error Occured!"))
                return
            }
            if (results[0][0]) {
                const foundUser = results[0][0]
                const isValid = await bcrypt.compare(user.password, foundUser.Password)
                if (isValid) {
                    req.session.user = {
                        userId: foundUser.UserNumber,
                        username: foundUser.UserName,
                        role: foundUser.Role
                    }
                    res.redirect("/")
                    return
                }
            }
            req.flash("error", "Incorrect Username or Password!")
            res.redirect("/")
        })
    })
}))

module.exports = router;