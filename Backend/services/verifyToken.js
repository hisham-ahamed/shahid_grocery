require("dotenv").config();
const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.header("token");
  if (!token)
    res.send(
      JSON.stringify({
        tokenValidation: false,
        staffDetailsSaved: false,
        passwordChange: false,
        message: "Unknown Error, Try loging again!",
      })
    );

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err)
      res.send(
        JSON.stringify({
          tokenValidation: false,
          staffDetailsSaved: false,
          passwordChange: false,
          message: "Error Validation, Try loging again!",
        })
      );
      else next();
  });
};
