const express = require('express')
const { wrapAsync } = require("../../utils/error")
const { homePage } = require('../../controllers/management');

const router = express.Router()

router.get('/', wrapAsync(homePage.renderHomePage))

module.exports = router