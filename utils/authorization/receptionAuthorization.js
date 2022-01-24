const UserTypes = require("../usertype")

module.exports = async (req, res, next) => {
    if(req.session.userId && (req.session.role === UserTypes.receptionist)){
        next();
        return
    }
    else{
        res.redirect("/")
    }
}