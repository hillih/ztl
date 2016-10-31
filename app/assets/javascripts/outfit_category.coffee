class OutfitCategory
  constructor: (@form)  ->
    @last_category = @form.find('.outfit_category_last_category')
    @re_hire = @form.find('.outfit_category_re_hire')
    @outfit_element_type = @form.find('.outfit_category_outfit_element_type')
    @symbolInput = @form.find('.outfit_category_symbol input')

  run: ->
    bindEvents.call(@)
    toggleFields.call(@)

  bindEvents = ->
    self = @
    @last_category.on 'ifChanged', ->
      toggleFields.call(self)
    @outfit_element_type.on 'change', ->
      setSymbol.call(self)

  toggleFields = ->
    @re_hire.toggle @last_category.iCheck('update')[0].checked
    @outfit_element_type.toggle @last_category.iCheck('update')[0].checked

  setSymbol = ->
    @symbolInput.val(@outfit_element_type.find(":selected").data('symbol'))
$ ->
  (new OutfitCategory(form)).run() if !!(form = $('form[id*=outfit_category]')).length
