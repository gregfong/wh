class exports.Block extends Backbone.Model

  randomNext: (options)->
    main_channel = app.router.channel
    menu = _.reject app.menu.get('contents'), (channel) -> channel.slug is main_channel.get('slug')
    random_channel = menu[Math.floor(Math.random()*menu.length)]
      
    $.when(main_channel.maybeLoad random_channel.slug).then =>
      random_block = _.randomItem main_channel.contents.models
      main_channel.trigger 'reload'
      app.router.navigate "#/#{random_channel.slug}/#{random_block.id}"

_.mixin
  randomItem: (list) -> list[_.random(list.length - 1)]
