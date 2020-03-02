const _uasrRepository = require('./uasr.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function (router) {
    const uasrRepository = _uasrRepository(dbContext);

    router.route('/uasr/all').get(uasrRepository.getAll);
    router.route('/uasr/create').post(uasrRepository.post);
    router.route('/uasr/delete').delete(uasrRepository.delete);

//    router.use('/uas/:Id', uasRepository.intercept);

//    router.route('/uas/:Id')
//        .get(uasRepository.get)
//        .put(uasRepository.put)
//        .delete(employeeRepository.delete);

}
