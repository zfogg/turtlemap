View           = require 'views/base/view'
CollectionView = require 'views/base/collection-view'
Courses        = require 'models/courses'

utils = require 'lib/utils'

class CourseView extends View
  tagName: 'tr'
  className: 'course'
  template: require './templates/course'

module.exports = class CoursesView extends CollectionView
  className: 'courses'
  listSelector: '.list-courses'
  itemView: CourseView
  template: require './templates/courses'
  regions:
    courses: '.list-courses'

  initialize: ->
    super
    @$ => @publishEvent 'map:markers-clear', true

  render: ->
    super
    @listenTo @collection, 'add', (c) ->
      @publishEvent 'map:markers-add', c.getAttributes().building

    @$ ->
      $('#building-search .query-input').each ->
        v = utils.param $(@).data 'query'
        $(@).val v unless $(@).is ':focus'
