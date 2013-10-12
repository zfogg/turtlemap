# Application-specific utilities
# ------------------------------

FastClick.attach document.body

# Delegate to Chaplin’s utils module.
utils = Chaplin.utils.beget Chaplin.utils

_.mixin
  reduce1: (xs, f) ->
    _(xs[1..]).reduce f, xs[0]

# _(utils).extend
#  someMethod: ->

_(utils).extend

  param: (p, url=utils.url()) ->
    ($.url(url).param p) or ''

  url: -> window.location.hash[1..]

  hash: -> utils.url().split('?')[0]

  query: -> utils.url().split('?')[1]

  qs:
    custom: (xs, keyf=_.identity, valf=_.identity) ->
      _(xs)
        .map (x) ->
          "#{keyf x}=#{valf x}"
        .reduce1 (xs, x) ->
          xs+'&'+x
        .value()
    fromObjs: (objs) ->
      objs = _.filter objs, (o) -> _.values(o)[0]
      objs = [{undefined: true}] if objs.length is 0
      utils.qs.custom objs,
        (o) -> _.keys(o)[0],
        (o) -> _.values(o)[0]

  prettyPrint: (el, lang='coffeescript') ->
    $('.prettyprint', el).html \
      window.prettyPrintOne($('.prettyprint', el).html(), lang)

# Prevent creating new properties and stuff.
Object.seal? utils

module.exports = utils
