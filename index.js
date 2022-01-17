const express = require("express")
const path = require("path")
const mysql = require("mysql")
const joi = require('joi')
const AppError = require("./utils/AppError")
const catchAsync = require("./utils/catchAsync")
const methodOverride = require("method-override")
const req = require("express/lib/request")

//Create connection
const db = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: 'Ayu',
    password: 'ayu.123',
    database: 'APHMSDB'
})

const app = express((err) => {
    if (err)
        console.log("Error Occured")
})

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '/views'))

app.use(express.static(path.join(__dirname, '/views/Assets')))
app.use(express.urlencoded({extended: true}))
app.use(methodOverride('_method'))

app.get('/', catchAsync(async (req, res) => {
    res.render('HomePage.ejs', { page: "homepage" })
}))

app.get('/patientpage', catchAsync(async (req, res) => {
    res.render("PatientPage.ejs", { page: "patientpage" })
}))

app.get('/patientpage/search', catchAsync(async (req, res) => {
    const { q } = req.query;
    if (!q || isNaN(q))
        throw new AppError(400, "Please enter a valid phone number!")
    if(parseInt(q) === NaN){
        console.log("NaN")
        return
    }
    db.getConnection((err, con) => {
        if (err) {
            console.log(err)
            return
        }
        con.query(`call spReception_SearchPatient(?)`, q, (error, results, fields) => {
            if (err)
                console.log(error)
            else
                res.render('Partials/PatientPage/search.ejs', { patients: results })
        })
        con.release()
    })
}))

app.get('/patientpage/:id/info', catchAsync(async (req, res) => {
    const { id } = req.params
    db.getConnection((err, con) => {
        if (err) {
            console.log(err)
            return
        }
        con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error)
                console.log(error)
            else {
                con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error)
                        console.log(error)
                    else
                        res.render('Partials/PatientPage/info.ejs', { info, appointments })
                    con.release()
                })
            }
        })

    })
}))

app.get('/patientpage/:id/payment', catchAsync(async (req, res) => {
    const { id } = req.params
    res.render("Partials/PatientPage/payment.ejs")
}))

app.get('/patientpage/new', catchAsync(async (req, res) =>{
    res.render("Partials/PatientPage/new.ejs")
}))

app.all('*', catchAsync(async (req, res, next) => {
    throw new AppError(404, "Page Not Found!")
}))

app.use((err, req, res, next) => {
    if(!err.statusCode){
        res.status(500).send(err.message)
        console.log(err)
        return
    }
    res.status(err.statusCode).render("Partials/error.ejs", {err})
})

app.listen(3000, "192.168.1.200", () => {
    console.log("Server started")
})