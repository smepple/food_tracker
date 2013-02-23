jQuery ->

  $(".add_comment").click ->
    # todo: only scroll if window is scrolled to top of the page
    window.scrollBy(0,50)

  $(".reply").click ->
    window.scrollBy(0,50)