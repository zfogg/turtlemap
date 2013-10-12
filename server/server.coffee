#!/usr/bin/coffee


{spawn}  = require 'child_process'
util     = require 'util'
path     = require 'path'
express  = require 'express'
mongoose = require 'mongoose'
moment   = require 'moment'
nodeio   = require 'node.io'
deferred = require 'deferred'

routes = require('./routes')

require('./bootstrap_db').bootstrap()


log = (x) ->
  console.log util.inspect x,
    showHidden: true
    colors: true
    depth: 1


# Initialize an app and export it as the module.
app = module.exports = express()


# Configuration.
app.configure ->
  app.use express.compress()
  app.use express.static(path.dirname(process.mainModule) + '/public')

  app.use express.bodyParser()

  app.use express.favicon()
  app.use express.methodOverride()

  app.use express.timeout()
  app.use app.router

  app.set 'port', process.env.PORT || 8001
  app.set 'mongoose', mongoose.connect 'mongodb://localhost/turtlemap'

app.configure 'development', ->
  app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', ->
  app.use express.errorHandler()


# Routes.
app.get '/user/:uid'                    , routes.user.byUID.get

app.get '/courses/scraper'              , routes.courses.scraper

app.get '/courses'                      , routes.courses.search
app.get '/courses/:name/:section/:type' , routes.courses.get

app.get '/buildings'                    , routes.buildings.search
app.get '/buildings/:number'            , routes.buildings.get


server = app.listen app.get('port'), ->
  console.log "Listening on " + app.get('port')

