
var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function UasRepository(dbContext) {

    function findUasr(req, res, next) {

        if (req.params.uasrId) {
            var parameters = [];

            parameters.push({ name: 'uasname', type: TYPES.VarChar, val: req.params.uasname });

            var query = "select * from [dbo.pending] where uasname = @uasname"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                if (data) {
                    req.data = data[0];
                    return next();
                }
                return res.sendStatus(404);
            });
        }
    }

    function getEmployees(req, res) {

        if (req.query.salary) {
            var parameters = [];

            parameters.push({ name: 'Salary', type: TYPES.Int, val: req.query.salary });

            var query = "select * from tbl_employee where salary>=@Salary"

            dbContext.getQuery(query, parameters, false, function (error, data) {
                return res.json(response(data, error));
            });
        }
        else {
            dbContext.get("getEmployee", function (error, data) {
                return res.json(response(data, error));
            });
        }
    }

    function getEmployee(req, res) {
        return res.json(req.data);
    }

    function postUasr(req, res) {

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

        // Object.entries(employee).forEach((property)=>{
        //     parameters.push({name:'@'+property[0]})
        // });

        dbContext.post("insertUasr", parameters, function (error, data) {
            return res.json(response(data, error));
        });
    }

//    function putEmployee(req, res) {
//
//        var parameters = [];
//
//        Object.entries(req.data).forEach((property) => {
//
//            if (req.body[property[0]]) {
//                parameters.push(
//                    {
//                        name: property[0],
//                        val: req.body[property[0]],
//                        type: TYPES.VarChar
//                    });
//            } else {
//
//                parameters.push(
//                    {
//                        name: property[0],
//                        val: property[1],
//                        type: TYPES.VarChar
//                    });
//            }
//        });
//
//        // parameters.push({ name: 'FirstName', type: TYPES.VarChar, val: req.body.FirstName });
//        // parameters.push({ name: 'LastName', type: TYPES.VarChar, val: req.body.LastName });
//        // parameters.push({ name: 'MiddleName', type: TYPES.VarChar, val: req.body.MiddleName });
//        // parameters.push({ name: 'DOB', type: TYPES.DateTime, val: new Date(req.body.DOB) });
//        // parameters.push({ name: 'Designation', type: TYPES.VarChar, val: req.body.Designation });
//        // parameters.push({ name: 'ReportingTo', type: TYPES.VarChar, val: req.body.ReportingTo });
//        // parameters.push({ name: 'Salary', type: TYPES.Int, val: req.body.Salary });
//
//        // Object.entries(req.body).forEach((property) => {
//        //     parameters.push({ name: '@' + property[0] })
//        // });
//
//        dbContext.post("InsertEmployee", parameters, function (error, data) {
//            return res.json(response(data, error));
//        });
//    }

    function deleteUasr(req, res) {

        var parameters = [];

        if (req.data.Id) {
            var parameters = [];

            parameters.push({ name: 'uasname', type: TYPES.VarChar, val: req.data.uasname });

            var query = "delete from [dbo.approved] where uasname = @uasname"

            dbContext.getQuery(query, parameters, false, function (error, data, rowCount) {
                if (rowCount > 0) {
                    return res.json('Record is deleted');
                }
                return res.sendStatus(404);
            });
        }
    }

//    function getEmployeesWothDepartment(req, res) {
//
//        dbContext.get("GetEmployeeWithDepartment", function (error, data) {
//            return res.json(response(data, error));
//        });
//    }

    function SearchEmployee(req, res) {

        var parameters = [];

        parameters.push({ name: 'Salary', type: TYPES.Int, val: req.query.salary });

        var query = "select * from tbl_employee where salary>=@Salary"

        dbContext.get(query, parameters, function (error, data) {
            return res.json(response(data, error));
        });
    }

    return {
        getAll: getEmployees,
        get: getEmployee,
        post: postEmployees,
        put: putEmployee,
        getMulti: getEmployeesWothDepartment,
        find: SearchEmployee,
        intercept: findEmployee,
        delete: deleteEmployee
    }
}

module.exports = UasRepository;