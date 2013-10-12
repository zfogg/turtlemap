Controller = require 'controllers/base/controller'
HomeView   = require 'views/home/home-view'

module.exports = class HomeController extends Controller
  index: ->
    @view = new HomeView
      region: 'panel'
      autoRender: true
