View           = require 'views/base/view'
CollectionView = require 'views/base/collection-view'
Buildings      = require 'models/buildings'

utils = require 'lib/utils'

class BuildingView extends View
  tagName: 'tr'
  className: 'building'
  template: require './templates/building'

module.exports = class BuildingsView extends CollectionView
  className: 'buildings'
  listSelector: '.list-buildings'
  itemView: BuildingView
  template: require './templates/buildings'
  regions:
    buildings: '.list-buildings'

  initialize: ->
    super
    @$ => @publishEvent 'map:markers-clear', true

  render: ->
    super
    @listenTo @collection, 'add', (b) ->
      @publishEvent 'map:markers-add', b.getAttributes()

    @$ ->
      $('#building-search .query-input').each ->
        v = utils.param $(@).data 'query'
        $(@).val v unless $(@).is ':focus'
