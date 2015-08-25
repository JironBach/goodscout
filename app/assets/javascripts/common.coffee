c = (str) ->
  console.log(str)

#show
$('[name="show-popup-login-form"]').each (i,el) ->
  $(el).click () ->
    $("#popup-login-form").show()
    $("#cover").show()
    $('body').addClass('noscroll')

$('body').click (e) ->
  if $(e.target).closest('[name="popup"]').attr('name') != 'popup' &&
      $(e.target).closest('[name="show-popup-login-form"]').attr('name') != 'show-popup-login-form'
    $("[name='popup']").hide()
    $("#cover").hide()
    $('body').removeClass('noscroll')

$("[id^=rm-flash-]").click (el) ->
  $("#flash-#{el.target.id.match(/\d+/)[0]}").remove()
