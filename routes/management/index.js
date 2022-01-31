const express = require("express")
const homePage = require("./homepage")
const patientPage =require("./patientpage")
const employeePage = require("./employeepage")
const reportPage = require("./reportpage")
const {managementAuthorization} = require("../../utils/authorization")
const router = express.Router()


router.use(managementAuthorization)
router.use((req, res, next)=>{res.locals.type = "management";next()})
router.use("/homepage", homePage)
router.use("/patientpage", patientPage)
router.use("/employeepage", employeePage)
router.use("/reportpage", reportPage)

module.exports = router