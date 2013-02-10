class exports.BlockView extends Backbone.View
  id: 'slide'

  initialize: (options) ->
    @channel = options.channel
    @template = require "./templates/block"
    $(window).resize => @center()

  events: 
    'click .single': 'closeView'
    'click .next'  : 'nextImage'

  center: ->
    margin_top = 36
    margin_bottom = $('#secondary').height() + 36

    w = @$('img').width()
    h = @$('img').height()

    win_w = $(window).innerWidth()
    win_h = $(window).innerHeight()

    @$('img').css 
      'max-height': win_h - margin_bottom - margin_top
      'max-width': win_w - (36 *2)

    return this

  nextImage: (e)->
    e.preventDefault()
    e.stopPropagation()
    console.log 'this block', @model
    @model.randomNext()
  
  render: ->
    @$el.html @template
      block: @model.toJSON()

    return this

  closeView: ->
    $('#block').hide()
    app.router.navigate "/#{@channel.get('slug')}"
    @remove()