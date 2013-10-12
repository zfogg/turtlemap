Application = require 'application'
routes      = require 'routes'

# Initialize the application on DOM ready event.
$ ->
  new Application {
    title: 'Turtle Map',
    controllerSuffix: '-controller',
    routes,
    pushState: false
  }
