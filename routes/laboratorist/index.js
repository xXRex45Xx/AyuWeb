const express = require("express");
const patientPage = require("./patientpage");
const { laboratoristAuthorization } = require("../../utils/authorization")
const route = express.Router();

route.use(laboratoristAuthorization)

route.use((req, res, next) => {
  res.locals.type = "laboratorist";
  next();
});
route.use("/patientpage", patientPage);

module.exports = route;
