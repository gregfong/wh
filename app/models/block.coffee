class exports.Block extends Backbone.Model

  randomNext: (options)->
    main_channel = app.router.channel
    
    if @get('connections').length > 0
      console.log 'find another channel'
      
      $.when(main_channel.maybeLoad @get('connections')[0].slug).then =>
        console.log 'channel loaded!', main_channel
        random_block = _.randomItem main_channel.contents.models
        console.log 'random_block', random_block

    else
      console.log 'must be current channel'



_.mixin
  randomItem: (list) -> list[_.random(list.length - 1)]
