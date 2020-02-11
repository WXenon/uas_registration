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
        database: "UAS", //update me
        encrypt: true
      }
}

var connection = new Connection(config);

connection.on('connect', function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log('Connected');
    }
});

module.exports = connection;
