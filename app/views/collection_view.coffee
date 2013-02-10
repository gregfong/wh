class exports.CollectionView extends Backbone.View
  id: 'collection'

  initialize: ->
    document.title =  "#{window.app.site_title} - #{@model.get 'title'}"
    @template = require "./templates/collection"

  addAll: -> @collection.each @addOne
    
  addOne: (block) =>
    console.log 'selected', @options.selected
    if block.id is @options.selected
      selected = "selected"
    else
      selected = ""
  
  render: ->
    @$el.append @template
      channel : @model.toJSON()
      blocks  : @collection.toJSON()

    @addAll()

    return this