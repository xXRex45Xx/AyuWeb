const express = require('express')
const { wrapAsync } = require("../../utils/error")
const { receptionAuthorization } = require("../../utils/authorization")
const router = express.Router()

// router.use(receptionAuthorization)
// Enable autorization for the doctor (it is going directly to the reception's home page so you need to send a type of doctor to the autorization)

router.get('/', wrapAsync(async (req, res, next) => {
  res.render('Laboratorist/HomePage.ejs', { page: "laboratorist" })
}))

module.exports = router