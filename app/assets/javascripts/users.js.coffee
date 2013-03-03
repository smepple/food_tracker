jQuery ->
  $('.timeago').timeago()

  tz = jstz.determine()
  document.cookie = 'time_zone='+tz.name()+';'

  if $(".dish").length > 0
    $(".dishes-list").isotope
      itemSelector: ".dish"
      masonry:
        columnWidth: 30
      sortBy: "random"
