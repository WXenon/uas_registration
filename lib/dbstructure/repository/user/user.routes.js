const _userRepository = require('./user.repository');
const dbContext = require('../../Database/dbContext');

module.exports = function (router) {
    const userRepository = _userRepository(dbContext);

    router.route('/users/getAdmin').get(userRepository.getAdmin);
    router.route('/users/create').post(userRepository.createUsers);
}
