const express = require("express");
const route = express.Router();

route.get("/", function (req, res) {
  res.render("Doctor/HomePage.ejs", { page: "homepage" });
});

module.exports = route;
