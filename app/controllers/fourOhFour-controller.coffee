HomeController = require 'controllers/home-controller'
FourOhFourView = require 'views/fourOhFour-view'

module.exports = class FourOhFourController extends HomeController
  index: (params) ->
    @view = new FourOhFourView
      region: 'panel'

