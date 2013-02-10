jQuery ->

  # jQuery.purr doesn't always recognize the browser
  # which breaks the script
  # spoofing it seems to fix for webkit and gecko
  $.browser = 'webkit'

  # Activate autocomplete on dish category field
  $('#dish_category_name').autocomplete
    source: $('#dish_category_name').data('autocomplete-source')

  # Activate autocomplete on dish source field
  $('#dish_source_name').autocomplete
    source: $('#dish_source_name').data('autocomplete-source')

  # Hide unnecessary helper text from autocomplete fields
  $('.ui-helper-hidden-accessible').hide()

  # Activate Timeago
  $('.timeago').timeago()

  # Activate Best in Place
  $('.best_in_place').best_in_place()

  # Add and remove hint class from elements to show/hide tooltip functionality
  $('.best_in_place').click ->
    $('.best_in_place').removeClass('hint hint--right')

  $('.best_in_place').focusout ->
    $('.best_in_place').addClass('hint hint--right')
