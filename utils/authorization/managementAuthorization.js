const UserTypes = require("../usertype")

module.exports = async (req, res, next) => {
    if(req.session.user && (req.session.user.role === UserTypes.management)){
        next();
        return
    }
    else{
        res.redirect("/")
    }
}