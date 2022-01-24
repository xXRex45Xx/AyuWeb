const Joi = require("joi")

module.exports.login = Joi.object({
    user: Joi.object({
        username: Joi.string().max(50).required(),
        password: Joi.string().max(50).required()
    })
})