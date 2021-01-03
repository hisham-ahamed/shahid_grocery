require("dotenv").config();
const hashPassword = require("../services/hashFromPassword");
const changePasswordById = require("../services/changePasswordById");
const verifyToken = require("../services/verifyToken");
const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const adminDetailsSchema = require("../models/adminDetailsSchema");
const staffDetailsSchema = require("../models/staffDetailsSchema");

router.post("/login", (req, res) => {
  console.log(req.body);
  adminDetailsSchema.findOne(
    { username: req.body.username },
    (err, objectFound) => {
      if (objectFound) {
        bcrypt.compare(
          req.body.password,
          objectFound.password,
          (err, result) => {
            if (result) {
              const token = jwt.sign(
                { id: objectFound.id },
                process.env.JWT_SECRET
              );
              res.send(
                JSON.stringify({
                  auth: true,
                  token: token,
                  message: "Successfully Authenticated!",
                })
              );
            } else {
              res.send(
                JSON.stringify({
                  auth: false,
                  token: null,
                  message: "Password Incorrect!",
                })
              );
            }
          }
        );
      } else {
        res.send(
          JSON.stringify({
            auth: false,
            token: null,
            message: "Unknown Error Occoured",
          })
        );
      }
    }
  );
});

router.post("/changepassword", verifyToken, (req, res) => {
  console.log(req.body);
  hashPassword(req, (hash) => {
    let id = "5f9ec4df2b8e6b895def4063";
    changePasswordById(id, hash, res);
    console.log("Process Finished Successfully");
  });
});

router.post("/addstaff", verifyToken, (req, res) => {
  let staffDetails = staffDetailsSchema({
    username: req.body.username,
    mobileNumber: req.body.mobileNumber,
    password: req.body.password,
  });
  staffDetails.save().then((executeThis) => {
    res.send(
      JSON.stringify({
        tokenValidation: true,
        staffDetailsSaved: true,
        message: "Staff details successfully added",
      })
    );
  });
});

router.post("/deletestaff", verifyToken, (req, res) => {
  staffDetailsSchema
    .deleteOne({ mobileNumber: req.body.mobileNumber })
    .then((executeThis) => {
      res.send(
        JSON.stringify({
          tokenValidation: true,
          staffDetailsdeleted: true,
          message: "Staff have been removed",
        })
      );
    });
});

module.exports = router;

// router.post("/register", (req, res) => {
//   bcrypt.genSalt(10,(err,salt)=>{
//     if(err) console.log(err);
//     bcrypt.hash(req.body.password,salt,(err,hash)=>{
//       if(err) console.log(err);
//       // let adminDetails = new adminDetailsSchema({
//       //   password:hash
//       // });
//       // adminDetails.save().then(executeThis=>{
//       //   res.send('Mufeed Details saved successfully');
//       // });
//       console.log(hash);
//       res.send('Register Success');
//     });
//   });

// });
