const express = require('express')
const {AppError, wrapAsync} = require("../utils/error")
const {receptionAuthorization} = require("../utils/authorization")
const router = express.Router()

router.use(receptionAuthorization)

router.get('/', wrapAsync(async (req, res, next) => {
    res.render('HomePage.ejs', { page: "homepage" })
}))

module.exports = router