const Joi = require('joi')

module.exports = Joi.object({
    patient: Joi.object({
        firstName: Joi.string().max(25).required(),
        fatherName: Joi.string().max(25).required(),
        dateOfBirth: Joi.date().required(),
        gender: Joi.string().max(1).uppercase().required(),
        address: Joi.string().max(100),
        phoneNo: Joi.number().positive().integer().required()
    }).required()
})