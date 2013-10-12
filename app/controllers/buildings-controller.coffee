HomeController         = require 'controllers/home-controller'
BuildingsView          = require 'views/buildings/buildings-view'
BuildingsContainerView = require 'views/buildings/buildings-container-view'
Buildings              = require 'models/buildings'
Collection             = require 'models/base/collection'

utils = require 'lib/utils'

module.exports = class BuildingsController extends HomeController
  beforeAction: (params, route) ->
    super
    @compose 'buildings-container', BuildingsContainerView,
      region: 'panel'

  index: ->
    @view = new BuildingsView
      region: 'buildings_container'
      collection: new Buildings [], {}

  search: ({query}, route) ->
    @view = new BuildingsView
      region: 'buildings_container'
      collection: new Buildings [],
        name:   utils.param 'name'  , '?'+query
        code:   utils.param 'code'  , '?'+query
        number: utils.param 'number', '?'+query
