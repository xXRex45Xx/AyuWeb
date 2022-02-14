const express = require("express");
const path = require("path");
const { AppError, wrapAsync } = require("./utils/error");
const methodOverride = require("method-override");
const appRoutes = require("./routes");
const session = require("express-session");
const helmet = require("helmet")
const flash = require("connect-flash");
const https = require("https")
const fs = require("fs")
const mysqlStore = require("connect-mysql")(session)

const app = express();

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "/views"));
app.set("queue", new Array());

const sessionConfig = {
  name: "session",
  secret: "vo&yFwT244b9?Q-;CR~#lVtQ.C(VQD",
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    expires: Date.now() + 24 * 60 * 60 * 1000,
    maxAge: 1000 * 60 * 60 * 24,
  },
  store: new mysqlStore({
    pool: true,
    config: {
        user: 'session-handler',
        password: 'session.123',
        database: 'APHMSDB'
    },
    retries: 5,
    cleanup: true
  })
};

app.use(helmet())
app.use(express.static(path.join(__dirname, "/views/Assets")));
app.use(express.urlencoded({ extended: true }));
app.use(methodOverride("_method"));
app.use(session(sessionConfig));
app.use(flash());

app.use((req, res, next) => {
  res.locals.success = req.flash("success");
  res.locals.error = req.flash("error");
  next();
});

appRoutes.reception.locals = app.locals;
appRoutes.doctor.locals = app.locals;

app.use("/", appRoutes.loginPage);
app.use("/reception", appRoutes.reception);
app.use("/management", appRoutes.management);
app.use("/changepass", appRoutes.changePassword);
app.use("/doctor", appRoutes.doctor);
app.use("/laboratorist", appRoutes.laboratorist);

app.get("/logout", wrapAsync(async (req, res, next) => {
  if (req.session) req.session.destroy();
  res.redirect("/");
}));

app.all("*", (req, res, next) => {
  next(new AppError(404, "Page Not Found!", res.locals.type));
});

app.use((err, req, res, next) => {
  const { statusCode = 500 } = err;
  res.status(statusCode).render("Partials/Error/error.ejs", { err });
});

https.createServer(
  {
    pfx: fs.readFileSync(path.join(__dirname, "/certs/cert.p12")),
    passphrase: "ayuprimary.789"
  },
  app
).listen(3000,() =>{
  console.log(`HTTPS Server Started in ${process.env.NODE_ENV} mode`)
})
