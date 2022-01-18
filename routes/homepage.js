const express = require('express')
const router = express.Router()

router.get('/', async (req, res, next) => {
    try{
    res.render('HomePage.ejs', { page: "homepage" })
    }
    catch(e){
        next(e)
    }
})

module.exports = router