const express = require("express")
const res = require("express/lib/response")
const { route } = require("./homepage")
const homePage = require("./homepage")
const patientPage = require("./patientpage")
const router = express.Router()

router.use((req, res, next)=>{res.locals.type = "reception";next()})
router.use("/homepage", homePage)
router.use("/patientpage", patientPage)

module.exports = router