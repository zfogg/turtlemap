mongoose = require 'mongoose'
deferred = require 'deferred'
util     = require 'util'


log = (x) ->
  console.log util.inspect x,
    showHidden: true
    colors: true
    depth: 4


schema = new mongoose.Schema
  uid:
    type: String
    min: 2
    max: 127
  courses: [require './Course']

schema.statics.findOrCreate = (uid) ->
  Model.findOne({uid})
  .pexec()
  .then (user) ->
    return user if user
    (new Model {uid}).psave()


Model = mongoose.model 'User', schema


module.exports = Model

