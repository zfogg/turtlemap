Collection = require 'models/base/collection'
Building   = require './building'

utils = require 'lib/utils'

module.exports = class Buildings extends Collection
  _.extend @prototype, Chaplin.SyncMachine

  model: Building

  url: ->
    "/buildings?" + utils.qs.fromObjs [{@name}, {@code}, {@number}]

  comparator: (b) ->
    (b.get 'code') + (b.get 'name')

  initialize: (models, {@name, @code, @number}) ->
    super
    @on 'request', @beginSync
    @on 'sync'   , @finishSync
    @on 'error'  , @unsync
    @fetch()
