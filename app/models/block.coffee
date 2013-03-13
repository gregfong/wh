class exports.Block extends Backbone.Model

  fetchThumb: ->
    if @get('class') is 'Channel'
      $.ajax
        url: "http://api.are.na/v2/channels/#{@get('id')}/thumb"
        success: (data) =>
          thumb = data.contents[0]?.image?.thumb?.url
          app.router.channel.trigger 'channel:thumb', @id, thumb

  randomNext: (options)->
    main_channel = app.router.channel
    filtered = _.where @get('connections'), {user_id: app.accountId}

    if filtered.length
      random_connection = filtered[Math.floor(Math.random()*filtered.length)]
      $.when(main_channel.maybeLoad random_connection.slug).then =>
        random_block = _.randomItem main_channel.contents.models
        main_channel.trigger 'reload'
        app.router.navigate "#/#{random_connection.slug}/#{random_block.id}"
    else
      random_block = _.randomItem main_channel.contents.models
      app.router.navigate "#/#{main_channel.get('slug')}/#{random_block.id}"

  randomChannel: ->
    main_channel = app.router.channel
    menu = _.reject app.menu.get('contents'), (channel) -> channel.slug is main_channel.get('slug')
    random_channel = menu[Math.floor(Math.random()*menu.length)]
      
    $.when(main_channel.maybeLoad random_channel.slug).then =>
      random_block = _.randomItem main_channel.contents.models
      main_channel.trigger 'reload'
      app.router.navigate "#/#{random_channel.slug}/#{random_block.id}"

_.mixin
  randomItem: (list) -> list[_.random(list.length - 1)]
