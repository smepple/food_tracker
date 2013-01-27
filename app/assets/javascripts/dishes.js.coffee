# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#dish_category_name').autocomplete
    source: $('#dish_category_name').data('autocomplete-source')

  $('#dish_source_name').autocomplete
    source: $('#dish_source_name').data('autocomplete-source')

  $('.ui-helper-hidden-accessible').hide()