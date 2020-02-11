var TYPES = require('tedious').TYPES;
const User = {
    username: TYPES.VarChar,
    password: TYPES.VarChar,
    owner: TYPES.Int
}
