HomeController       = require 'controllers/home-controller'
CoursesView          = require 'views/courses/courses-view'
CoursesContainerView = require 'views/courses/courses-container-view'
Courses              = require 'models/courses'
Collection           = require 'models/base/collection'

utils = require 'lib/utils'

module.exports = class CoursesController extends HomeController
  beforeAction: (params, route) ->
    super
    @compose 'courses-container', CoursesContainerView,
      region: 'panel'

  index: ->
    @view = new CoursesView
      region: 'courses_container'
      collection: new Courses [], {}

  search: ({query}, route) ->
    @view = new CoursesView
      region: 'courses_container'
      collection: new Courses [],
        name:    (utils.param 'name'   , '?'+query) or undefined
        section: (utils.param 'section', '?'+query)
