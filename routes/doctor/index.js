const express = require("express");
const homePage = require("./homepage");
const patientPage = require("./patientpage");
const { doctorAuthorization } = require("../../utils/authorization")
const route = express.Router();

route.use(doctorAuthorization)

route.use((req, res, next) => {
  homePage.locals = route.locals
  patientPage.locals = route.locals
  res.locals.type = "doctor";
  next();
});
route.use("/homepage", homePage);
route.use("/patientpage", patientPage);


module.exports = route;
