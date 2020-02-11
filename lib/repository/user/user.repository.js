var response = require('../../shared/response');

var TYPES = require('tedious').TYPES;

function UserRepository(dbContext) {
    function getUsers(req, res) {
        var params = [];

        dbContext.getQuery("SELECT password FROM [dbo].[users] where username = '" + username + "'", params, false, function (error, data) {
            
            return res.json(response(data, error));
        });
    }

    return { getUsers };
}

module.exports = UserRepository;