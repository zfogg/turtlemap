util                     = require 'util'
{User, Course, Building} = require '../models'
_                        = require 'underscore'


SCRAPING = false

SAMPLE_RESPONSE =
  success : Boolean
  error   : String
  data    : [{}]

WIN = (data={}) ->
  data

FAIL = (error='Default error message.') ->
  {error}

ERR_404 = (res) ->
  res.send FAIL('404: Resource not found.'), 404

ERR_500 = (res, err) ->
  res.send FAIL(err), 500

ERR_501 = (res) ->
  res.send FAIL('Not implemented.'), 500


log = (x) ->
  console.log util.inspect x,
    showHidden: true
    colors: true
    depth: 1


mapO = (f, o) ->
  _({}).extend _(o).tap (o) ->
    o[k] = f v, k, o for k, v of o

safeEqProp = (a, b, p) ->
  (a[p]? and b[p]?) and (a[p] is b[p])


regex_dotStar = _.partial mapO, (v) ->
  new RegExp "^.*#{v}.*$", 'i'

regex_strict = _.partial mapO, (v) ->
  new RegExp "^#{v}$", 'i'

regex_strictL = _.partial mapO, (v) ->
  new RegExp "^#{v}.*$", 'i'

regex_strictR = _.partial mapO, (v) ->
  new RegExp "^.*#{v}$", 'i'


exports.user =
  byUID:
    get: (req, res) ->
      User.findOne(_(req.params).pick 'uid').pexec()
        .then (user) ->
          if user
            res.send WIN user
          else ERR_404 res
        .done()
    put: (req, res) ->
      if not safeEqProp req.params, req.body, 'uid'
        ERR_500 res, 'Invalid UID for this URI.'
      else
        User.findOrCreate(req.params.uid)
          .catch((err) -> ERR_502 res, err)
          .done(-> res.send WIN())

exports.courses =
  get: ({params}, res) ->
    Course.findOne(regex_strict params)
      .populate('building')
      .pexec().then (course) ->
        if course then res.send WIN course
        else ERR_404 res
      .done()
  search: (req, res) ->
    {query} = req
    log req.type
    Course.find(regex_strictL query)
      .populate('building')
      .pexec().then (courses) ->
        if courses then res.send courses
        else res.send WIN []
      .done()
  put: (req, res) -> ERR_501 res

  scraper: require './scraper'

exports.buildings =
  get: ({params}, res) ->
    Building.findOne(regex_strict params).pexec()
      .then (building) ->
        if building then res.send WIN building
        else ERR_404 res
      .done()
  search: ({query}, res) ->
    Building.find(regex_dotStar query).pexec()
      .then (buildings) ->
        if buildings then res.send buildings
        else res.send WIN []
      .done()
