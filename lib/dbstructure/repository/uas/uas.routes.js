const _uasRepository = require('./uas.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function (router) {
    const uasRepository = _uasRepository(dbContext);

    router.route('/uas')
        .get(uasRepository.getAll)
        .post(uasRepository.post)
        .delete(uasRepository.delete);

//    router.use('/uas/:Id', uasRepository.intercept);

//    router.route('/uas/:Id')
//        .get(uasRepository.get)
//        .put(uasRepository.put)
//        .delete(employeeRepository.delete);

}
