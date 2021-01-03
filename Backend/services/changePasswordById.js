const adminDetailsSchema = require("../models/adminDetailsSchema");

module.exports = (id, hash, res) => {
  adminDetailsSchema.findByIdAndUpdate(
    { _id: id },
    { password: hash },
    null,
    (err, result) => {
      if (result)
          res.send(
            JSON.stringify({
              tokenValidation: true,
              adminPasswordChange: true,
              message: "Password changed successfully",
            })
          );
      else
        res.send(
          JSON.stringify({
            tokenValidation: true,
            adminPasswordChange: false,
            message: "Password changing Failed",
          })
        );
    }
  );
};
