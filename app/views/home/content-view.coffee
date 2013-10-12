View = require 'views/base/view'

{LatLng, Map, Marker, LatLngBounds} = google.maps

utils = require 'lib/utils'

module.exports = class HomePageView extends View
  className: 'home-page-container'
  template: require './templates/content'
  regions:
    panel: '#panel'

  map: null

  initialize: (opts) ->
    super

  listen:
    'map:redraw mediator'        : 'map_redraw'
    'map:center mediator'        : 'map_center'
    'map:markers-clear mediator' : 'map_markersClear'
    'map:markers-set mediator'   : 'map_markersSet'
    'map:markers-add mediator'   : 'map_markersAdd'

  map_redraw: ->
    @map.refresh()
  map_center: ({lat, lng}) ->
    @map.setCenter lat, lng
  map_markersClear: ->
    @map.removeMarkers()
  map_markersSet: (xs) ->
    @map_markersClear()
    @map.addMarker {lat, lng} for {lat, lng} in xs
  map_markersAdd: ({lat, lng}) ->
    @map.addMarker {lat, lng}

  initialize: ->
    super
    @$ =>
      @map = new GMaps
        div: '#map'
        zoom: 15
        lat: 38.9925, lng: -76.9430 # Center of campus.
        disableDefaultUI: true

      @map.addListener "center_changed", do =>
        p = lat: 38.9925, lng: -76.9430
        c = @map.map.getCenter()
        d = 0.015

        b = new LatLngBounds \
          (new LatLng(p.lat - d, p.lng - d)),
          (new LatLng(p.lat + d, p.lng + d))

        ->
          if b.contains @getCenter()
          then c = @getCenter()
          else @panTo c

  render: ->
    super
    @$ =>
      @$(@map.el).height $('#page-container').height() - 20
      @map_redraw()
      window.map = @map # FIXME: debugging
