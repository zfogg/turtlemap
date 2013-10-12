View = require 'views/base/view'

utils = require 'lib/utils'

module.exports = class BuildingsContainerView extends View
  className: 'buildings-wrapper'
  regions:
    buildings_container: '.buildings-container'
  template: require './templates/buildings-container'

  initialize: ->
    super
    @delegate 'keyup', 'input.form-control', ({keyCode}) ->
      char_limit = 2
      c = String.fromCharCode keyCode
      inputs = @$('.query-input').filter -> $(@).val() isnt ''

      if keyCode is 8 or keyCode is 46 or c.match(/\w/) or keyCode is 13
        if (_.any inputs, ((i) -> i.value.length >= char_limit))
          query = utils.qs.fromObjs inputs.map ->
            _.tap {}, (o) => o[$(@).data 'query'] = $(@).val()
          @publishEvent '!router:route', "/buildings?#{query}"
        else
          @publishEvent '!router:route', "/buildings"

  render: ->
    super
    @$ => utils.prettyPrint @el
