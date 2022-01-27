const express = require("express")
const homePage = require("./homepage")
const router = express.Router()

router.use((req, res, next)=>{res.locals.type = "management";next()})
router.use("/homepage", homePage)

module.exports = router