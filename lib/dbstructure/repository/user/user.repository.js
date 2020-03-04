var response = require('../../shared/response');

var TYPES = require('tedious').TYPES;

function UserRepository(dbContext) {
    function getAdmin(req, res) {
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });

        var query = "select admin from dbo.users where username = 'admin'";

        dbContext.getQuery(query, null, false, function (error, data) {
            if (error)
            return res.sendStatus(400)
            else
            return res.json(data);
        });
    }

    function createUsers(req, res){
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });
        parameters.push({ name: 'admin', type: TYPES.VarChar, val: 1 });

        var query = "insert into dbo.users values(@username, @admin)";

        dbContext.getQuery(query, parameters, false, function (error, data) {
            if (error)
            return res.sendStatus(400)
            else
            return res.json(data);
        });
    }

    return { 
        getAdmin,
        createUsers
    };
}

module.exports = UserRepository;