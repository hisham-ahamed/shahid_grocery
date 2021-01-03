const mongoose = require("mongoose");

const staffDetailsSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
  },
  mobileNumber:{
      type:String,
      required:true
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

module.exports = mongoose.model("staff", staffDetailsSchema);
