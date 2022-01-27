const express = require("express")
const router = express.Router()
const { AppError, wrapAsync } = require("../utils/error")
const { userSchema } = require("../utils/validationSchemas")
const mysql = require("mysql")
const bcrypt = require("bcrypt")

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

const validateUser = async (req, res, next) => {
    try {
        const validation = userSchema.changePass.validate(req.body)
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
    if (!req.session.user)
        return res.redirect("/")
    const { username } = req.session.user
    res.render("ChangeCredsPage.ejs", { username })
}))

router.patch("/", validateUser, wrapAsync(async (req, res, next) => {
    if (!req.session.user)
        return res.redirect("/")
    const { userId } = req.session.user
    const { user } = req.body
    db.getConnection((err, con) => {
        if (err) {
            next(new AppError(500, "Database Error Occured!"))
            return
        }
        con.query("call spGetUserById(?)", userId, async (error, results, fields) => {
            if (error) {
                next(new AppError(500, error.sqlMessage))
                return
            }
            if (results[0][0]) {
                const foundUser = results[0][0]
                const isValid = await bcrypt.compare(user.oldPassword, foundUser.Password)
                if (isValid) {
                    const hash = await bcrypt.hash(user.newPassword, 12)
                    con.query("call spUpdateUser(?, ?)", [ userId, hash ], (error, results, fields) => {
                        if (error)
                        {
                            next(new AppError(500, error.sqlMessage))
                            return
                        }
                        delete req.session.user
                        req.flash("success", "Password Changed Successfully. Please, login with your new password.")
                        res.redirect("/")
                    })
                }
                else {
                    req.flash("error", "Incorrect Current Password Provided")
                    res.redirect("/changepass")
                }
            }
            else {
                next(new AppError(400, "Invalid User"))
                return
            }
        })
    })
}))

module.exports = router