{Blocks} = require 'collections/blocks'

class exports.Channel extends Backbone.Model

  url: -> "http://api.are.na/v2/channels/#{@get('id')}"

  maybeLoad: (colID) ->
    if colID is @get('id') # if passed slug matches 'slug' attribute of collection
      return true
    else
      @clear()
      @set 'id', colID
      @fetch
        success: =>
          @setupBlocks()
          app.loading().stop()
          return true
        error: (error) =>
          console.log "Error: #{error}"

  setupBlocks: ->
    @contents = new Blocks()
    @contents.channel = this
    @contents.add @get('contents') # Add 'contents' to model.contents
