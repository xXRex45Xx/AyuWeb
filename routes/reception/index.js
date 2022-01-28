const express = require("express")
const homePage = require("./homepage")
const patientPage = require("./patientpage")
const {receptionAuthorization} = require("../../utils/authorization")
const router = express.Router()

router.use(receptionAuthorization)
router.use((req, res, next) => {
    res.locals.type = "reception";
    next()
})
router.use("/homepage", homePage)
router.use("/patientpage", patientPage)

module.exports = router