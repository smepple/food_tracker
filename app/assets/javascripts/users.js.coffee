jQuery ->
  $('.timeago').timeago()

  tz = jstz.determine()
  document.cookie = 'time_zone='+tz.name()+';'
