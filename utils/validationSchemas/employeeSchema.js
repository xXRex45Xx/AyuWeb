const Joi = require("joi")

let eighteen = new Date()
eighteen.setFullYear(eighteen.getFullYear() - 18)
eighteen = eighteen.toISOString().slice(0, 10)

module.exports = Joi.object({
    employee: Joi.object({
        firstName: Joi.string().max(25).required(),
        fatherName: Joi.string().max(25).required(),
        dateOfBirth: Joi.date().min('1-1-1990').max(eighteen).required(),
        phoneNo: Joi.number().positive().integer().required(),
        type: Joi.number().min(0).max(6).required(),
        speciality: Joi.string()
    }).required()
})