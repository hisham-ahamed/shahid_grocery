require('dotenv').config()

const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 3000;

mongoose
  .connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("Connected to MongoDB Atlas"))
  .catch((err) => console.log(err));
  mongoose.set('useFindAndModify', false);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/admin", require("./routes/admin"));
app.use("/common", require("./routes/common"));

app.get("/", (req, res) => {
  res.send(JSON.stringify({backendConnected:true}));
});

app.listen(PORT, () => {
  console.log("App is listening on Port 3000");
});
