const mongoose = require("mongoose");

const addressDetailsSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  mobileNumber: {
    type: String,
    required: true,
  },
  buildingNumber: {
    type: String,
    required: false,
    default: " ",
  },
  streetName: {
    type: String,
    required: false,
    default: " ",
  },
  postalCode: {
    type: String,
    required: false,
    default: " ",
  },
  additional: {
    type: String,
    required: false,
    default: " ",
  },
  date: {
    type: Date,
    required: false,
    default: Date.now,
  },
});

module.exports = mongoose.model("address", addressDetailsSchema);
