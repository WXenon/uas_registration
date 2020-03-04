// import Connection from 'tedious-async';

// const config = {
//   // Tedious configurations
//   authentication: {
//     options: {
//       userName: "rsafuavcadmin", // update me
//       password: "R5@fu4vc" // update me
//     },
//     type: "default"
//   },
//   server: "uasr.database.windows.net", // update me
//   options: {
//     database: "UASR", //update me
//     encrypt: true
//   }
// };

// const connection = new Connection(config);
var Connection = require('tedious').Connection;

var config = {
    authentication: {
        options: {
          userName: "rsafuavcadmin", // update me
          password: "R5@fu4vc" // update me
        },
        type: "default"
      },
      server: "uasr.database.windows.net", // update me
      options: {
        database: "UASR", //update me
        encrypt: true,
        enableArithAbort: true
      }
}

var connection = new Connection(config);
// var results = await connection.run("");
connection.on('connect', function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log('Connected');
    }
});

module.exports = connection;
