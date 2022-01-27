const express = require("express");
const app = express();

app.get("/", function (req, res) {
  // res.render("./views/Doctor/HomePage");
  res.send("he");
});

app.listen(3000, "localhost", () => {
  console.log("Server Started on port 3000");
});
