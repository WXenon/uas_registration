const DepartmentRepository = require('./user.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function (router) {
const userRepository = UserRepository(dbContext);
    router.route('/users')
        .get(userRepository.getUsers);
}
