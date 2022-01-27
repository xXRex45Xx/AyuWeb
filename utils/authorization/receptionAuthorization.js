const { response } = require("express");
const UserTypes = require("../usertype")

module.exports = async (req, res, next) => {
    if(req.session.user && (req.session.user.role === UserTypes.receptionist)){
        next();
        return
    }
    else{
        res.redirect("/")
    }
}