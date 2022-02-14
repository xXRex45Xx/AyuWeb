const bcrypt = require("bcrypt")
const db = require("../utils/dbconnector")
const { AppError } = require('../utils/error');

module.exports.renderChangePasswordForm = async (req, res, next) => {
    if (!req.session.user)
        return res.redirect("/")
    const { username } = req.session.user
    res.render("ChangeCredsPage.ejs", { username })
}

module.exports.changeUserPassword = async (req, res, next) => {
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
                    con.query("call spUpdateUser(?, ?)", [userId, hash], (error, results, fields) => {
                        if (error) {
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
}