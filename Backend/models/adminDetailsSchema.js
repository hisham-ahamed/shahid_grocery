const mongoose = require("mongoose");

const adminDetailsSchema = new mongoose.Schema({
  username: {
    type: String,
    required: false,
    default: "Mufeed",
  },
  password: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    required: false,
    default: Date.now,
  },
});

module.exports = mongoose.model("admin", adminDetailsSchema);
