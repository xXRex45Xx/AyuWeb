const express = require('express')
const { AppError, wrapAsync } = require("../../utils/error")
const { employeeSchema } = require("../../utils/validationSchemas")
const userType = require("../../utils/usertype")
const { employeePage } = require('../../controllers/management');

const router = express.Router()

const validateEmployee = async (req, res, next) => {
    try {
        const validation = employeeSchema.validate(req.body)
        const { speciality } = req.body.employee
        if (validation.error) {
            const msg = validation.error.details.map(e => e.message).join(', ')
            throw new AppError(400, msg, res.locals.type)
        }
        else if (req.body.employee.type === userType.doctor) {
            switch (speciality) {
                case "gynecologist":
                    break;
                case "gp":
                    break;
                case "surgeon":
                    break;
                case "skin":
                    break;
                case "skeletal":
                    break;
                case "eye":
                    break;
                default:
                    throw new AppError(400, "Invalid Doctor Speciality", res.locals.type);
                    break;
            }
        }
        else {
            next()
        }
    } catch (e) {
        next(e)
    }
}

router.route("/")
    .get(wrapAsync(employeePage.renderEmployeePage))
    .post(wrapAsync(validateEmployee), wrapAsync(employeePage.createEmployee))

router.get('/search', wrapAsync(employeePage.searchEmployee))

router.get('/new', wrapAsync(employeePage.renderNewEmployeeForm))

router.get("/:id/transactions", wrapAsync(employeePage.showEmployeeTransactions))

module.exports = router