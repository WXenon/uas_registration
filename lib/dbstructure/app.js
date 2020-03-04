var express = require("express");

var bodyParser = require('body-parser');

var port = process.env.PORT || 3000;

var app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
var router = require('./routes')();

app.use('/api', router);

app.listen(port, () => {
  console.log("Hi This port is running");
});