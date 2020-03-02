const { Connection, Request } = require("tedious");

var express = require("express");

var bodyParser = require('body-parser');

var port = process.env.PORT || 3000;

var app = express();


app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
var router = require('./routes')();

app.use('/api', router);

//app.get('/', (req, res) => {
//
//  return res.send(getPw);
//});

//const getPw = (req, res) => {
//  executeStatement();
//  return res.status(200).JSON(req.body);
//};

// Create connection to database
//const config = {
//  authentication: {
//    options: {
//      userName: "rsafuavcadmin", // update me
//      password: "R5@fu4vc" // update me
//    },
//    type: "default"
//  },
//  server: "uasr.database.windows.net", // update me
//  options: {
//    database: "UAS", //update me
//    encrypt: true
//  }
//};
//
//const connection = new Connection(config);
//
//// Attempt to connect and execute queries if connection goes through
//connection.on("connect", err => {
//  if (err) {
//    console.error(err.message);
//  } else {
//    executeStatement();
//  }
//});
//
//function executeStatement() {
//  request = new Request(`SELECT owner FROM [dbo].[users] where username = '` + username + `'`, function(err, rowCount) {
//    if (err) {
//      console.log(err);
//    } else {
//      console.log(rowCount + ' rows');
//    }
//
//    connection.close();
//  });
//
//  request.on('row', function(columns) {
//    columns.forEach(function(column) {
//      if (column.value === null) {
//        console.log('NULL');
//      } else {
//        console.log(column.value);
//        password = JSON.parse(column.value);
//        console.log(typeof(password));
//      }
//    });
//  });
//
//  request.on('done', function(rowCount, more) {
//    console.log(rowCount + ' rows returned');
//  });
//
//  // In SQL Server 2000 you may need: connection.execSqlBatch(request);
//  connection.execSql(request);
//}
//
//module.exports = {
//
//}

app.listen(port, () => {
  console.log("Hi This port is running");
});