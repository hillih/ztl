class ChoreographyForm
  constructor: (@form)  ->
    @outfitCategory = @form.find('.choreography_outfit_category')
    @nameInput = @form.find('.choreography_name input')

  run: ->
    bindEvents.call(@)

  bindEvents = ->
    self = @
    @outfitCategory.on 'change', ->
      setName.call(self)

  setName = ->
    @nameInput.val(@outfitCategory.find(":selected").text())

$ ->
  (new ChoreographyForm(form)).run() if !!(form = $('form[id*=choreography]')).length
