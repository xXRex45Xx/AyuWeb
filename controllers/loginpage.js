const userType = require("../utils/usertype")
const { AppError } = require("../utils/error")
const db = require("../utils/dbconnector")
const bcrypt = require("bcrypt");

module.exports.renderLoginPage = async (req, res, next) => {
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
}

module.exports.checkUser = async (req, res, next) => {
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
}