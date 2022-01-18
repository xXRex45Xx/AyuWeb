const express = require('express')
const router = express.Router()
const catchAsync = require("../utils/catchAsync")

router.get('/', catchAsync(async (req, res) => {
    res.render('HomePage.ejs', { page: "homepage" })
}))

module.exports = router