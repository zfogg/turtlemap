View = require 'views/base/view'

module.exports = class HeaderView extends View
  className: 'header'
  tagName: 'header'
  template: require './templates/header'

  initialize: ({activeLink}) ->
    super
    activeLink = '' if activeLink is 'home'

    @getTemplateData = -> {activeLink}

    @delegate 'click', '.nav-link', ({currentTarget}) ->
      @publishEvent 'header:nav-click', true
      $(currentTarget).siblings().removeClass 'active bold'
      $(currentTarget).addClass 'active bold'
    @delegate 'click', '.brand', ({currentTarget}) ->
      @$('#link-home').click()
      return true
