{Block} = require "models/block"

class exports.Blocks extends Backbone.Collection
  
  model: Block
  
  comparator: (block) ->
    block.get 'position'

  _filtered: (criteria) ->
    new exports.Blocks @filter(criteria)

  bySelection: (selection) ->
    @_filtered (block) ->
      block.get('selected') is true

  pluckImages: -> _.map @where({class: "Image"}), (model) -> model.get('image').original.url
    
  cleanConnections: ->
    menu_channels = app.menu.contents.where({type:'Channel'}).map((model)-> model.id)

    @each (model)->
      connections = _.filter model.get('connections'), (connection)-> 

        included = _.include menu_channels, connection.channel.id
        published = connection.channel.published
        
        return (included and published)

      model.set('connections', connections)