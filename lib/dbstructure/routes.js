const express = require('express'); 

function eRoutes() {
    const router = express.Router();
    var uas = require('./repository/uas/uas.routes')(router);
    var uasr = require('./repository/uas/uasr.routes')(router);
    var user = require('./repository/user/user.routes')(router);
    return router;
}

module.exports = eRoutes;