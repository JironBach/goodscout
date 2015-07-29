c = (str) ->
  console.log(str)

#show
$('[name="show-popup-login-form"]').each (i,el) ->
  $(el).click () ->
    c('show')
    $('#popup-login-form').show()

$('body').click (e) ->
  if $(e.target).closest('[id="popup-login-form"]').attr('id') != 'popup-login-form' &&
      $(e.target).closest('[name="show-popup-login-form"]').attr('name') != 'show-popup-login-form'
    $('#popup-login-form').hide()
