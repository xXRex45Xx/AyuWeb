const express = require("express");
const route = express.Router();

route.use("/", (req, res, next) => {
  res.render("Doctor/PatientPage.ejs", { page: "patientpage" });
});

module.exports = route;
