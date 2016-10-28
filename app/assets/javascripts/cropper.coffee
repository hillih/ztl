#= require cropper/dist/cropper

$.fn.cropper.setDefaults
  cropBoxResizable: false
  dragMode: 'move'
  viewMode: 1

class Cropper
  constructor: ->
    @form = $("form")
    @image = @form.find("img")

  run: ->
    cropper.call(@)

  cropper = ->
    form = @form
    image = @image
    image.cropper
      built: ->
        image.cropper 'setCropBoxData',
          width: 220
          height: 220
      crop: (e) ->
        $(form).find('[id*="crop_x"]').val e.x
        $(form).find('[id*="crop_y"]').val e.y
        $(form).find('[id*="crop_w"]').val e.width
        $(form).find('[id*="crop_h"]').val e.height

$ ->
    (new Cropper()).run() if $('body').data('controller') is 'profiles' && $('body').data('action') is 'avatar'
