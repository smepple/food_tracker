# Add focus to first input field on page load
jQuery ->
  $("input:text:visible:first").focus();