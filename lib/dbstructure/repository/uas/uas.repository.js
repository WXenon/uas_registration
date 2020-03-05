var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function UasRepository(dbContext) {

    function findUas(req, res, next) {

        if (req.params.uasId) {
            var parameters = [];

            parameters.push({ name: 'uasname', type: TYPES.VarChar, val: req.params.uasname });

            var query = "select * from [dbo.pending] where uasname = @uasname"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                if (data) {
                    req.data = data[0];
                    return next();
                } else{
                    return res.sendStatus(404);
                }
            });
        }
    }

    function getUas(req, res) {

        var query = "select * from dbo.pending"

        dbContext.getQuery(query, null, false, function (error, data) {
            if (error){
                if(!res.finished)
                    return res.sendStatus(400)
            } else {
                if(!res.finished)
                    return res.json(data);
            }
        });
    }

    function postUas(req, res) {

        var parameters = [];

        parameters.push({ name: 'username', type: TYPES.VarChar, val: req.body.username });
        parameters.push({ name: 'uasname', type: TYPES.VarChar, val: req.body.uasname });
        parameters.push({ name: 'baselinecheck', type: TYPES.VarChar, val: req.body.baselinecheck });
        parameters.push({ name: 'physicalarea', type: TYPES.VarChar, val: req.body.physicalarea});
        parameters.push({ name: 'uasdragcoef', type: TYPES.VarChar, val: req.body.uasdragcoef });
        parameters.push({ name: 'maxthrust', type: TYPES.VarChar, val: req.body.maxthrust });
        parameters.push({ name: 'propellerdiameter', type: TYPES.VarChar, val: req.body.propellerdiameter });
        parameters.push({ name: 'propellerweight', type: TYPES.VarChar, val: req.body.propellerweight });
        parameters.push({ name: 'noofbladepropeller', type: TYPES.VarChar, val: req.body.noofbladepropeller });
        parameters.push({ name: 'propellerrpm', type: TYPES.VarChar, val: req.body.propellerrpm });
        parameters.push({ name: 'propdragcoef', type: TYPES.VarChar, val: req.body.propdragcoef });
        parameters.push({ name: 'maxgpsverterr', type: TYPES.VarChar, val: req.body.maxgpsverterr });
        parameters.push({ name: 'maxgpshorerr', type: TYPES.VarChar, val: req.body.maxgpshorerr });
        parameters.push({ name: 'battmodel', type: TYPES.VarChar, val: req.body.battmodel });
        parameters.push({ name: 'batttype', type: TYPES.VarChar, val: req.body.batttype });
        parameters.push({ name: 'battcertstandard', type: TYPES.VarChar, val: req.body.battcertstandard });
        parameters.push({ name: 'battapproxtmaxtime', type: TYPES.VarChar, val: req.body.battapproxtmaxtime });
        parameters.push({ name: 'battcap', type: TYPES.VarChar, val: req.body.battcap });
        parameters.push({ name: 'battvolt', type: TYPES.VarChar, val: req.body.battvolt });
        parameters.push({ name: 'battenergy', type: TYPES.VarChar, val: req.body.battenergy});
        parameters.push({ name: 'oemoftethersystem', type: TYPES.VarChar, val: req.body.oemoftethersystem });
        parameters.push({ name: 'materialoftether', type: TYPES.VarChar, val: req.body.materialoftether });
        parameters.push({ name: 'strengthoftether', type: TYPES.VarChar, val: req.body.strengthoftether });
        parameters.push({ name: 'anchortetheranchor', type: TYPES.VarChar, val: req.body.anchortetheranchor });
        parameters.push({ name: 'jointtetheruas', type: TYPES.VarChar, val: req.body.jointtetheruas });
        parameters.push({ name: 'strengthanchortetheranchor', type: TYPES.VarChar, val: req.body.strengthanchortetheranchor });
        parameters.push({ name: 'strengthjointtetheruas', type: TYPES.VarChar, val: req.body.strengthjointtetheruas });
        parameters.push({ name: 'method', type: TYPES.VarChar, val: req.body.method });

        var query = "insert into dbo.pending values(@username, @uasname, @baselinecheck, @physicalarea, @uasdragcoef, @maxthrust, @propellerdiameter, @propellerweight, " +
                    "@noofbladepropeller, @propellerrpm, @propdragcoef, @maxgpsverterr, @maxgpshorerr, @battmodel, @batttype, @battcertstandard, @battapproxmaxtime, " +
                    "@battcap, @battvolt, @battenergy, @oemoftethersystem, @materialoftether, @strengthoftether, @anchortetheranchor, @jointtetheruas, @strengthanchortetheranchor, " +
                    "@strengthjointtetheruas, @method)";

        dbContext.post(query, parameters, false, function (error, data) {
            if (error)
                if(!res.finished)
                    return res.sendStatus(400)
            else
                if(!res.finished)
                    return res.json(data);
        });
    }

    function deleteUas(req, res) {

        var parameters = [];

        parameters.push({ name: 'uasname', type: TYPES.VarChar, val: req.data.uasname });

        var query = "delete from [dbo.pending] where uasname = @uasname"

        dbContext.getQuery(query, parameters, false, function (error, data, rowCount) {
            if (rowCount > 0) {
                if(!res.finished)
                    return res.json('Record is deleted');
            } else{
                if(!res.finished)
                    return res.sendStatus(404);
            }
        });
    }

    return {
        getAll: getUas,
        post: postUas,
        delete: deleteUas
    }
}

module.exports = UasRepository;