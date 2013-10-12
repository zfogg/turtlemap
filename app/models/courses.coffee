Collection = require 'models/base/collection'
Course     = require './course'

utils = require 'lib/utils'

module.exports = class Courses extends Collection
  _.extend @prototype, Chaplin.SyncMachine

  model: Course

  url: ->
    '/courses?' + utils.qs.fromObjs [{@name}, {@section}]

  comparator: (c) ->
    (c.get 'name') + (c.get 'section')

  initialize: (models, {@name, @section}) ->
    super
    @on 'request' , @beginSync
    @on 'sync'    , @finishSync
    @on 'error'   , @unsync
    @fetch()
