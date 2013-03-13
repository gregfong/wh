class exports.MenuView extends Backbone.View
  tagName: 'ul'
  
  initialize: -> @template = require "./templates/menu"
  
  events:
    "mouseover li a"  : "showTitle"
    "mouseout li a"   : "hideTitle"
    "click li"        : "setSection"

  render: ->
    @$el.html @template
      title   : @options.title
      channel : @model.toJSON()
      blocks  : @collection.toJSON()

    return this
    
  showTitle: (element) ->
    $(element.currentTarget).siblings("h2").fadeIn(150)
    
  hideTitle: (element) ->
    $(element.currentTarget).siblings("h2").fadeOut(150)
    
  setSection: (element) ->
    $(element.currentTarget).siblings().removeClass('selected')
    $(element.currentTarget).addClass('selected')