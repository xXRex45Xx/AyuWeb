const express = require("express")
const { AppError, wrapAsync } = require("../utils/error")
const { userSchema } = require("../utils/validationSchemas")
const changePassword = require('../controllers/changepassword');

const router = express.Router()

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

router.route("/")
    .get(wrapAsync(changePassword.renderChangePasswordForm))
    .patch(validateUser, wrapAsync(changePassword.changeUserPassword))

module.exports = router