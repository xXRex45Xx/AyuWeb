module.exports = class AppError extends Error{
    constructor(statusCode, message){
        super();
        this.message = message
        this.statusCode = statusCode
    }
}