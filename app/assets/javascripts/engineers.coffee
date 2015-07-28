# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

c = (str) ->
  console.log(str)

#show
$('#show-popup-login-form').click () ->
  $('#popup-login-form').show()

$('body').click (e) ->
  if $(e.target).closest('[id="popup-login-form"]').attr('id') != 'popup-login-form' && $(e.target).attr('id') != 'show-popup-login-form'
    $('#popup-login-form').hide()
