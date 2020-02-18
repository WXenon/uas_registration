const _uasRepository = require('./uas.respository');
const dbContext = require('../../Database/dbContext');

module.exports = function (router) {
    const uasRepository = _uasRepository(dbContext);

    router.route('/uas')
        .get(uasRepository.getAll)
        .post(uasRepository.post);
        
    router.route('/employees/department')
    .get(employeeRepository.getMulti);

    router.use('/uas/:Id', uasRepository.intercept);

    router.route('/uas/:Id')
        .get(uasRepository.get)
        .put(uasRepository.put)
        .delete(employeeRepository.delete);

}
