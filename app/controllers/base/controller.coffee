SiteView    = require 'views/site-view'
HeaderView  = require 'views/home/header-view'
ContentView = require 'views/home/content-view'

module.exports = class Controller extends Chaplin.Controller
  activeLink = undefined
  beforeAction: (params, {controller}) ->
    super
    activeLink or= controller
    @compose 'site', SiteView
    @compose 'header', HeaderView, {region: 'header', activeLink}
    @compose 'content', ContentView, region: 'main'
