const Joi = require("joi")

module.exports.login = Joi.object({
    user: Joi.object({
        username: Joi.string().max(50).required(),
        password: Joi.string().max(50).required()
    })
})

module.exports.changePass = Joi.object({
    user: Joi.object({
        oldPassword: Joi.string().max(50).required(),
        newPassword: Joi.string().max(50).required()
    })
})