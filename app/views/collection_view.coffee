class exports.CollectionView extends Backbone.View
  id: 'collection'

  initialize: ->
    document.title =  "#{window.app.site_title} - #{@model.get 'title'}"
    @template = require "./templates/collection"

    @model.on 'reload', @render, @

  addAll: -> @model.contents.each @addOne
    
  addOne: (block) =>
    if block.id is @options.selected
      selected = "selected"
    else
      selected = ""
  
  render: ->
    @$el.html @template
      channel : @model.toJSON()
      blocks  : @model.contents.toJSON()

    @addAll()

    return this