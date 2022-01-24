const express = require("express")
const path = require("path")
const {AppError, wrapAsync} = require("./utils/error")
const methodOverride = require("method-override")
const appRoutes = require("./routes")
const session = require('express-session')
const flash = require('connect-flash')

const app = express()

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '/views'))

app.use(express.static(path.join(__dirname, '/views/Assets')))
app.use(express.urlencoded({ extended: true }))
app.use(methodOverride('_method'))
app.use(session({secret: 'passdfgpassdfg', resave: false, saveUninitialized: false}))
app.use(flash())

app.use((req, res, next) => {
    res.locals.success = req.flash("success")
    next()
})

app.get("/", (req, res, next) => {
    res.render("LoginPage.ejs")
})

app.use("/hompage", appRoutes.homepage)
app.use("/patientpage", appRoutes.patientpage)

app.all('*', (req, res, next) => {
    next(new AppError(404, "Page Not Found!"))
})

app.use((err, req, res, next) => {
    const { statusCode = 500 } = err
    res.status(statusCode).render("Partials/Error/error.ejs", { err })
})

app.listen(80, "localhost", () => {
    console.log("Server started")
})