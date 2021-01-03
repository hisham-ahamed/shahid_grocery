require("dotenv").config();
const express = require("express");
const jwt = require("jsonwebtoken");
const staffDetailsSchema = require("../models/staffDetailsSchema");
const addressDetailsSchema = require("../models/addressDetailsSchema");
const deliveryDetailsSchema = require("../models/deliveryDetailsSchema");
const verifyToken = require("../services/verifyToken");
const router = express.Router();

router.post("/stafftoken", (req, res) => {
  const token = jwt.sign({ password: "mufeed@staff" }, process.env.JWT_SECRET);
  res.send(JSON.stringify({ token: token }));
});

router.get("/staffdetails", (req, res) => {
  staffDetailsSchema.find((err, doc) => {
    res.send(JSON.stringify(doc));
  });
});

router.post("/addaddress", verifyToken, (req, res) => {
  let addressDetails = addressDetailsSchema({
    name: req.body.name,
    mobileNumber: req.body.mobileNumber,
    buildingNumber:
      req.body.buildingNumber == null ? " " : req.body.buildingNumber,
    streetName: req.body.streetName == null ? " " : req.body.streetName,
    postalCode: req.body.postalCode == null ? " " : req.body.postalCode,
    additional: req.body.additional == null ? " " : req.body.additional,
  });
  addressDetails.save().then((executeThis) => {
    res.send(
      JSON.stringify({
        tokenValidation: true,
        addressDetailsSaved: true,
        message: "Address details successfully updated",
      })
    );
  });
});

router.get("/addressdetails", (req, res) => {
  addressDetailsSchema.find((err, doc) => {
    res.send(JSON.stringify(doc));
  });
});

router.post("/deleteaddress", verifyToken, (req, res) => {
  addressDetailsSchema
    .deleteOne({ mobileNumber: req.body.mobileNumber })
    .then((executeThis) => {
      res.send(
        JSON.stringify({
          tokenValidation: true,
          addressdeleted: true,
          message: "Address have been removed",
        })
      );
    });
});

router.post("/adddelivery", verifyToken, (req, res) => {
  let deliveryDetails = deliveryDetailsSchema({
    name: req.body.name,
    mobileNumber: req.body.mobileNumber,
    serialNumber: req.body.serialNumber,
    cashRiyal: req.body.cashRiyal,
    cashHalala: req.body.cashHalala,
    spnRiyal: req.body.spnRiyal,
    spnHalala: req.body.spnHalala,
    creditRiyal: req.body.creditRiyal,
    creditHalala: req.body.creditHalala,
    staff: req.body.staff,
  });
  deliveryDetails.save().then((executeThis) => {
    res.send(
      JSON.stringify({
        tokenValidation: true,
        deliveryDetailsSaved: true,
        message: "Delivery Completed Successfully",
      })
    );
  });
});

router.post("/deliverydetails", verifyToken, (req, res) => {
  var failedData = [
    {
      _id: "404",
      name: "null",
      mobileNumber: "0",
      serialNumber: "0",
      cashRiyal: "0",
      cashHalala: "0",
      spnRiyal: "0",
      spnHalala: "0",
      creditRiyal: "0",
      creditHalala: "0",
      staff: "null",
      date: "null",
      __v: 0,
    },
  ];
  deliveryDetailsSchema.find(
    {
      date: {
        $gte: req.body.start,
        $lte: req.body.end,
      },
    },
    (err, doc) => {
      if (err) console.log(err);
      if (doc != "") res.send(JSON.stringify(doc));
      else res.send(JSON.stringify(failedData));
    }
  );
});

router.post("/updatedeliverycheck", verifyToken, (req, res) => {
  deliveryDetailsSchema.findOneAndUpdate(
    { _id: req.body.id },
    { checkValue: req.body.checkValue },
    (err, doc) => {
      if (err) console.log(err);
      else
        res.send(
          JSON.stringify({
            tokenValidation: true,
            deliveryDetailsUpdated: true,
            message: "Delivery details updated successfully",
          })
        );
    }
  );
});

router.post("/editdeliverydetails", verifyToken, (req, res) => {
  deliveryDetailsSchema.findOneAndUpdate(
    { _id: req.body.id },
    {
      name: req.body.name,
      mobileNumber: req.body.mobileNumber,
      serialNumber: req.body.serialNumber,
      cashRiyal: req.body.cashRiyal,
      cashHalala: req.body.cashHalala,
      spnRiyal: req.body.spnRiyal,
      spnHalala: req.body.spnHalala,
      creditRiyal: req.body.creditRiyal,
      creditHalala: req.body.creditHalala,
      staff: req.body.staff,
    },
    (err, doc) => {
      if (err) console.log(err);
      else
        res.send(
          JSON.stringify({
            tokenValidation: true,
            deliveryDetailsEdited: true,
            message: "Details Updated Successfully",
          })
        );
    }
  );
});
module.exports = router;
