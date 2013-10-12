View = require 'views/base/view'

utils = require 'lib/utils'

module.exports = class CoursesContainerView extends View
  className: 'courses-wrapper'
  regions:
    courses_container: '.courses-container'
  template: require './templates/courses-container'

  initialize: ->
    super
    @delegate 'keyup', '.query-input', ({keyCode}) ->
      char_limit = 4
      c = String.fromCharCode keyCode
      inputs = @$('.query-input').filter -> $(@).val() isnt ''

      if keyCode is 8 or keyCode is 46 or c.match(/\w/) or keyCode is 13
        if @$('#name-input').val().length >= char_limit
          query = utils.qs.fromObjs inputs.map ->
            _.tap {}, (o) => o[$(@).data 'query'] = $(@).val()
          @publishEvent '!router:route', "/courses?#{query}"
        else
          @publishEvent '!router:route', "/courses"

  render: ->
    super
    @$ => utils.prettyPrint @el
