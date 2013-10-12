
mongoose  = require 'mongoose'
promisify = require('deferred').promisify

require 'express-mongoose'


mongoose.Query.prototype.pexec = promisify mongoose.Query.prototype.exec

mongoose.Model.prototype.psave = promisify mongoose.Model.prototype.save


exports.User     = require('./User')

exports.Course   = require('./Course')

exports.Building = require('./Building')

