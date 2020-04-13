var response = require('../../shared/response');

var TYPES = require('tedious').TYPES;

function UserRepository(dbContext) {
    function getAdmin(req, res) {
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });

        var query = "select admin from dbo.users where username = @username";

        dbContext.getQuery(query, parameters, false, function (error, data) {
            if (error){
                if(!res.finished)
                    return res.json(data)
            } else {
                if(!res.finished)
                    return res.json(data);
            }
        });
    }

    function getExisting(req, res) {
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });

        var query = "select * from dbo.users where username = @username";

        dbContext.getQuery(query, parameters, false, function (error, data) {
            if (error){
                if(!res.finished){
                    return res.json(error)
                }
            } else {
                if(!res.finished)
                    if (data === false){
                        return res.json({"username":"user not found","admin":"0"})
                    }
                    console.log(typeof(data))
                    return res.json(data);
            }
        });
    }

    function createUsers(req, res){
        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.data.username });
        parameters.push({ name: 'admin', type: TYPES.VarChar, val: "1" });

        var query = "insert into dbo.users values(@username, @admin)";

        dbContext.getQuery(query, parameters, false, function (error, data) {
            if (error){
                if(!res.finished)
                    return res.json(error)
            } else {
                if(!res.finished)
                    return res.json({"username":"success","admin":"0"});
            }
        });
    }

    return { 
        getAdmin,
        createUsers,
        getExisting
    };
}

module.exports = UserRepository;