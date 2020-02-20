const _uasRepository = require('./uas.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function (router) {
    const uasrRepository = _uasrRepository(dbContext);

    router.route('/uasr')
        .get(uasrRepository.getAll)
        .post(uasrRepository.post)
        .delete(uasrRepository.delete);

//    router.use('/uas/:Id', uasRepository.intercept);

//    router.route('/uas/:Id')
//        .get(uasRepository.get)
//        .put(uasRepository.put)
//        .delete(employeeRepository.delete);

}
