const express = require("express")
const router = express.Router()
const {AppError, wrapAsync} = require("../utils/error")
const mysql = require("mysql")

const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

router.get("/", wrapAsync(async (req, res, next) =>{
    if(!req.session.userId)
        return res.redirect("/")
    const {username} = req.session
    res.render("ChangeCredsPage.ejs", { username })
}))

router.patch("/", wrapAsync(async (req, res, next) =>{
    if(!req.session.userId)
        return res.redirect("/")
    const {userId} = req.session
    db.getConnection((err, con) =>{
        if(err){
            next(new AppError(500, "Database Error Occured!"))
            return
        }
        // con.query("spGetUserById(?)", )
    })
}))

module.exports = router