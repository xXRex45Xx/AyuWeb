module.exports = class AppError extends Error{
    constructor(statusCode, message, type){
        super();
        this.message = message
        this.statusCode = statusCode
        this.type = type // User type
    }
}