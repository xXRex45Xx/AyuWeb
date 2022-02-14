const express = require('express')
const { wrapAsync } = require("../../utils/error")
const { homePage } = require('../../controllers/doctor');

const router = express.Router()

router.get('/', wrapAsync(async (req, res, next) => {
  req.locals = { queue: router.locals.settings.queue }
  next()
}), wrapAsync(homePage.renderHomePage))

module.exports = router