const bcrypt = require("bcrypt");

module.exports = (req, callback) => {
  bcrypt.genSalt(10, (err, salt) => {
    if (err) console.log(err);
    bcrypt.hash(req.body.password, salt, (err, hash) => {
      if (err) console.log(err);
      callback(hash);
    });
  });
};
