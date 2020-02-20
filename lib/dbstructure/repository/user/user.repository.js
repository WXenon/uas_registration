var response = require('../../shared/response');

var TYPES = require('tedious').TYPES;

function UserRepository(dbContext) {
    function getAdmin(req, res) {
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });

        var query = "select admin from dbo.users where username = @username";

        dbContext.post(query, parameters, function (error, data) {
            return res.json(response(data, error));
        });
    }

    function createUsers(req, res){
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });
        parameters.push({ name: 'admin', type: TYPES.VarChar, val: req.body.admin });

        var query = "insert into dbo.users values(@username, @admin)";

        dbContext.post(query, parameters, function (error, data) {
            return res.json(response(data, error));
        });
    }

    return { 
        getAdmin,
        createUsers
    };
}

module.exports = UserRepository;