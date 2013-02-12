{MenuView}       = require 'views/menu_view'
{CollectionView} = require 'views/collection_view'
{BlockView}      = require 'views/block_view'
{Channel}        = require 'models/channel'

class exports.MainRouter extends Backbone.Router
  routes:
    ''                : 'index'
    'about'           : 'about'
    'events'          : 'events'
    ':slug'           : 'collection'
    ':slug/:id'       : 'block'

  initialize: ->
    @channel = new Channel()
    @current_slug = ''

  index: -> @collection window.app.homeId

  collection: (slug) -> # take da slug
    window.scroll(0,0)
    
    if slug? # if da slug is passed, then
      $.when(@channel.maybeLoad slug).then =>
        @current_slug = slug
        @collectionView = new CollectionView
          model       : @channel
          selected    : @selected?.id
          
        $('#content').html @collectionView.render().el # render collectionView into #content  
        
  about: ->
    $('#content').html('ABOUT!')
    
  events: ->
    $('#content').html('EVENTS!')

  block: (slug, id) ->
    if @current_slug isnt slug
      @collection(slug)

    @block_view = new BlockView
      model: @channel.contents.get(id)
      channel: @channel

    $("#block").show().html @block_view.render().el

    @block_view.center()