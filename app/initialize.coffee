{BrunchApplication} = require 'helpers'
{MainRouter}        = require 'routers/main_router'
{Channel}           = require 'models/channel'
{MenuView}          = require 'views/menu_view'

class exports.Application extends BrunchApplication

  initialize: ->
    @site_title = "The White Hotel"
    @menuId = 4962 #'the-white-hotel'
    @homeId = 4367 #'white-home'
    @menu = new Channel()
    
    $.when(@menu.maybeLoad @menuId).then => #after the menu collection passes maybeLoad:
      menuView = new MenuView
        title       : @site_title
        model       : @menu
        collection  : @menu.contents
      $('nav#primary').html menuView.render().el #
      @router = new MainRouter
        homeId      : @homeId
      Backbone.history.start()

window.app = new exports.Application