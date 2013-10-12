mongoose = require 'mongoose'
$        = require 'jquery'


schema = new mongoose.Schema
  name   : String
  code   : String

  number : String

  lng    : String
  lat    : String


Model = mongoose.model 'Building', schema


module.exports = Model
