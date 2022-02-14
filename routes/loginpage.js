const express = require('express')
const { AppError, wrapAsync } = require("../utils/error")
const { userSchema } = require("../utils/validationSchemas")
const loginPage = require("../controllers/loginpage")

const router = express.Router()

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

router.route("/")
    .get(wrapAsync(loginPage.renderLoginPage))
    .post(validateUser, wrapAsync(loginPage.checkUser))

module.exports = router;