const express = require('express')
const {wrapAsync} = require("../../utils/error")
const {managementAuthorization} = require("../../utils/authorization")
const router = express.Router()

router.use(managementAuthorization)

router.get('/', wrapAsync(async (req, res, next) => {
    res.render('Management/HomePage.ejs', { page: "homepage"})
}))

module.exports = router