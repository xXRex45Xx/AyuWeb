const express = require('express')
const {wrapAsync} = require("../../utils/error")
const router = express.Router()

router.get('/', wrapAsync(async (req, res, next) => {
    res.render('Management/HomePage.ejs', { page: "homepage"})
}))

module.exports = router