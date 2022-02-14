const express = require("express")
const { wrapAsync } = require("../../utils/error")
const { reportPage } = require('../../controllers/management');

const router = express.Router()

router.get("/", wrapAsync(reportPage.renderReportPage))

router.get("/reception/search", wrapAsync(reportPage.searchReception))

router.get("/receptiontransaction/:id", wrapAsync(reportPage.showReceptionTransactionsReport))

router.get("/dailyreport/:reportdate", wrapAsync(reportPage.showDailyIncomeReport))

router.get("/patientpayment/:id", wrapAsync(reportPage.showPatientPaymentsReport))

module.exports = router