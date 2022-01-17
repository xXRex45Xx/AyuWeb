const express = require("express")
const path = require("path")
const mysql = require("mysql")
const joi = require('joi')
const AppError = require("./utils/AppError")
const catchAsync = require("./utils/catchAsync")
const methodOverride = require("method-override")
const { string } = require("joi")

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
app.use(express.urlencoded({ extended: true }))
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
    db.getConnection((err, con) => {
        if (err) {
            throw new AppError(500, "Database error occured! Pleas contact your system administrator.")
        }
        con.query(`call spReception_SearchPatient(?)`, q, (error, results, fields) => {
            if (err)
                throw new AppError(500, "Database error occured! Pleas contact your system administrator.")
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
            throw new AppError(500, "Database error occured! Pleas contact your system administrator.")
        }
        con.query(`call spReception_GetPatientInfo(?)`, id, (error, info, fields) => {
            if (error)
                throw new AppError(500, "Database error occured! Please, contact your system administrator.")
            else {
                con.query(`call spReception_GetPatientAppointments(?)`, id, (error, appointments, fields) => {
                    if (error)
                        throw new AppError(500, "Database error occured! Pleas contact your system administrator.")
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

app.get('/patientpage/new', catchAsync(async (req, res) => {
    res.render("Partials/PatientPage/new.ejs")
}))

app.post('/patientpage', catchAsync(async (req, res) => {
    const {patient} = req.body
    db.getConnection((err, con) =>{
        if(err)
            throw new AppError(500, "Database error occured! Please, contact your system administrator.")
        else
        {
            if(patient.hospitalized)
                patient.hospitalized = true
            else
                patient.hospitalized = false            
            con.query("call spReception_AddPatient(?, ?, ?, ?, ?, ?, ?)", [patient.firstName,patient.fatherName, patient.dateOfBirth, patient.gender, patient.address, patient.phoneNo, patient.hospitalized], (error, results, fields) => {
                if(error)
                    throw new AppError(500, error.sqlMessage)
                else
                    console.log(results)
                con.release()
            })
        }
    })
    res.redirect("/patientpage")
}))

app.all('*', catchAsync(async (req, res, next) => {
    throw new AppError(404, "Page Not Found!")
}))

app.use((err, req, res, next) => {
    if (!err.statusCode) {
        res.status(500).send(err.message)
        console.log(err)
        return
    }
    res.status(err.statusCode).render("Partials/error.ejs", { err })
})

app.listen(3000, "192.168.1.200", () => {
    console.log("Server started")
})