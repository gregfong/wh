class exports.BrunchApplication
  constructor: ->
    $ =>
      @initialize this

  initialize: ->
    null

  loading: ->
    start: ->
      $('#content').html('')
      $('#scrim').addClass('loading')
    stop: ->
      $('#scrim').removeClass('loading')