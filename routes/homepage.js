const express = require('express')
const {AppError, wrapAsync} = require("../utils/error")
const router = express.Router()

router.get('/', wrapAsync(async (req, res, next) => {
    res.render('HomePage.ejs', { page: "homepage" })
}))

module.exports = router