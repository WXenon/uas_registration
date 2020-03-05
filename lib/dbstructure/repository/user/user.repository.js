var response = require('../../shared/response');

var TYPES = require('tedious').TYPES;

function UserRepository(dbContext) {
    function getAdmin(req, res) {
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: 'admin' });

        var query = "select admin from dbo.users where username = @username";

        dbContext.getQuery(query, parameters, false, function (error, data) {
            if (error){
                if(!res.finished)
                    return res.sendStatus(400)
            } else {
                if(!res.finished)
                    return res.json(data);
            }
        });
    }

    function createUsers(req, res){
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });
        parameters.push({ name: 'admin', type: TYPES.VarChar, val: 1 });

        var query = "insert into dbo.users values(@username, @admin)";

        dbContext.post(query, parameters, false, function (error, data) {
            if (error){
                if(!res.finished)
                    return res.sendStatus(400)
            } else {
                if(!res.finished)
                    return res.json(data);
            }
        });
    }

    return { 
        getAdmin,
        createUsers
    };
}

module.exports = UserRepository;