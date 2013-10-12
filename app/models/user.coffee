Model = require '/models/base/model'

module.exports = class User extends Model
  urlRoot: '/course/'
  url: ->
    @urlRoot+"#{@get 'name'}"
  idAttribute: '_id'

