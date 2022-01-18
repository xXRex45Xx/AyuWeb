const express = require("express")
const path = require("path")
const AppError = require("./utils/AppError")
const catchAsync = require("./utils/catchAsync")
const methodOverride = require("method-override")
const appRoutes = require("./routes")

const app = express()

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '/views'))

app.use(express.static(path.join(__dirname, '/views/Assets')))
app.use(express.urlencoded({ extended: true }))
app.use(methodOverride('_method'))

app.use("/", appRoutes.homepage)
app.use("/patientpage", appRoutes.patientpage)

app.all('*', catchAsync(async (req, res, next) => {
    throw new AppError(404, "Page Not Found!")
}))

app.use((err, req, res, next) => {
    const { statusCode = 500 } = err
    res.status(statusCode).render("Partials/error.ejs", { err })
})

app.listen(80, "localhost", () => {
    console.log("Server started")
})