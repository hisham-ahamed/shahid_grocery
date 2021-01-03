const mongoose = require("mongoose");

var datetime = new Date();
var date = datetime.toISOString().slice(0, 10);

const deliveryDetailsSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  mobileNumber: {
    type: String,
    required: true,
  },
  serialNumber: {
    type: String,
    required: true,
  },
  cashRiyal: {
    type: String,
    required: true,
  },
  cashHalala: {
    type: String,
    required: true,
  },
  spnRiyal: {
    type: String,
    required: true,
  },
  spnHalala: {
    type: String,
    required: true,
  },
  creditRiyal: {
    type: String,
    required: true,
  },
  creditHalala: {
    type: String,
    required: true,
  },
  staff: {
    type: String,
    required: true,
  },
  checkValue: {
    type: Boolean,
    required: false,
    default: false,
  },
  date: {
    type: Date,
    required: false,
    default: Date.now,
  },
});

module.exports = mongoose.model("delivery", deliveryDetailsSchema);
