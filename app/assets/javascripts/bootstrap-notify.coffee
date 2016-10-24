#= require remarkable-bootstrap-notify/dist/bootstrap-notify

$.notifyDefaults
  type: 'info'
  mouse_over: 'pause'
  offset:
    x: 15

class BootstrapNotify
  constructor:  ->
    @offsetTop = 30
    @flash = $('.flash-messages')

  run: ->
    if @flash.length isnt 0
      addNotify.call(@)

  addNotify = ->
    flashData = @flash.find('.flash-data')
    $.notify {
      message: flashData.data('message')
    },
      type: notifyType(flashData.data('type'))
      offset:
        y: @offsetTop
    @flash.remove()

  notifyType = (flashType) ->
    if flashType is 'notice'
      return 'info'
    else if flashType is 'alert'
      return 'danger'
    else
      return 'warning'

window.BootstrapNotify = BootstrapNotify

$ ->
  (new BootstrapNotify).run()
