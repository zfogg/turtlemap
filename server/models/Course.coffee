mongoose = require 'mongoose'
$        = require 'jquery'

Building = require './Building'


schema = new mongoose.Schema
  name       : String
  section    : String

  type       :
    type: String
    default: 'Lecture'

  title      : String

  instructor : String

  credits    : Number

  building   : { type: mongoose.Schema.Types.ObjectId, ref: 'Building' }
  room       : String

  core       : [String]
  gened      : [String]

  seats :
    total    : Number
    open     : Number
    waitlist : Number

  days : [
    day   : String
    start : String
    end   : String
  ]

schema.statics.findOrCreate = (name, data={}) ->
  Model.findOne({name})
  .pexec().then (course) ->
    return course if course
    if data.building
      Building.findOne({code: data.building})
        .pexec().then (building) ->
          m = new Model($.extend data, {name}, {building})
          m.bldg = building
          m.psave()
  .done()


Model = mongoose.model 'Course', schema


module.exports = Model

