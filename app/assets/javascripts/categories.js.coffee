jQuery ->
  $('#dish_source_name').autocomplete
    source: $('#dish_source_name').data('autocomplete-source')