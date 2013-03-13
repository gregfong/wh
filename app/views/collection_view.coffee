class exports.CollectionView extends Backbone.View
  id: 'collection'

  initialize: ->
    document.title =  "#{window.app.site_title} - #{@model.get 'title'}"
    @template = require "./templates/collection"

    @model.on 'reload', @render, @
    @model.on 'channel:thumb', @updateThumb

  addAll: -> @model.contents.each @addOne
    
  addOne: (block) =>
    if block.id is @options.selected
      selected = "selected"
    else
      selected = ""

  fetchChannelThumbs: ->
    channels = @model.contents.where {class: "Channel"}
    _.each channels, (channel)-> channel.fetchThumb()

  updateThumb: (id, thumb) -> 
    $("#channel_#{id}").html $('<img/>', {'src': thumb} ) 
  
  render: ->
    @$el.html @template
      channel : @model.toJSON()
      blocks  : @model.contents.toJSON()

    @addAll()

    @fetchChannelThumbs()

    return this