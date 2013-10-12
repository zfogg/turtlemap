View = require 'views/base/view'

module.exports = class HomeView extends View
  template: require './templates/home'

  initialize: ->
    super
    @$ => @publishEvent 'map:markers-clear', true
