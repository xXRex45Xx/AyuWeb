// <<<<<<< HEAD
// const express = require("express");
// const path = require("path");
// const { AppError, wrapAsync } = require("./utils/error");
// const methodOverride = require("method-override");
// const appRoutes = require("./routes");
// const session = require("express-session");
// const flash = require("connect-flash");
// =======
const express = require("express")
const path = require("path")
const { AppError, wrapAsync } = require("./utils/error")
const methodOverride = require("method-override")
const appRoutes = require("./routes")
const session = require('express-session')
const flash = require('connect-flash')
// const cookieParser = require("cookie-parser")
>>>>>>> 3b0f9070651b02c2ac1a8d6a1411ef7ff5190ffe

const app = express();

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "/views"));

const sessionConfig = {
  secret: "passdfgpassdfg",
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    expires: Date.now() + 24 * 60 * 60 * 1000,
    maxAge: 1000 * 60 * 60 * 24,
  },
};

app.use(express.static(path.join(__dirname, "/views/Assets")));
app.use(express.urlencoded({ extended: true }));
app.use(methodOverride("_method"));
app.use(session(sessionConfig));
app.use(flash());

app.use((req, res, next) => {
<<<<<<< HEAD
  res.locals.success = req.flash("success");
  res.locals.error = req.flash("error");
  next();
});

app.use("/", appRoutes.loginPage);
app.use("/homepage", appRoutes.homePage);
app.use("/patientpage", appRoutes.patientPage);
app.use("/changepass", appRoutes.changePassword);

app.get("/logout", (req, res, next) => {
  if (req.session) req.session.destroy();
  res.redirect("/");
});

//For Doctor
app.get("/DHomepage", (req, res, next) => {
  res.render("Doctor/HomePage", { page: "homepage" });
});
app.get("/DPatientpage", (req, res, next) => {
  res.render("Doctor/PatientPage", { page: "homepage" });
});

//For Doctor

app.all("*", (req, res, next) => {
  next(new AppError(404, "Page Not Found!"));
});
=======
    res.locals.success = req.flash("success")
    res.locals.error = req.flash("error")
    next()
})

app.use("/", appRoutes.loginPage)
app.use("/reception", appRoutes.reception)
app.use("/changepass", appRoutes.changePassword)

app.get("/logout", (req, res, next)=>{
    if(req.session)
        req.session.destroy()
    res.redirect("/")
})

app.all('*', (req, res, next) => {
    next(new AppError(404, "Page Not Found!", res.locals.type))
})
>>>>>>> 3b0f9070651b02c2ac1a8d6a1411ef7ff5190ffe

app.use((err, req, res, next) => {
  const { statusCode = 500 } = err;
  res.status(statusCode).render("Partials/Error/error.ejs", { err });
});

app.listen(80, "localhost", () => {
  console.log("Server started");
});
