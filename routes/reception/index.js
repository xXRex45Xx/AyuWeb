const express = require("express")
const homePage = require("./homepage")
const patientPage = require("./patientpage")
const { receptionAuthorization } = require("../../utils/authorization")
const router = express.Router()

router.use(receptionAuthorization)
router.use((req, res, next) => {
    patientPage.locals = router.locals
    res.locals.type = "reception";
    next()
})
router.use("/homepage", homePage)
router.use("/patientpage", patientPage)

module.exports = router