# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

c = (str) ->
  console.log(str)

$('[name="show-btn"]').click (el) ->

  $('[name="show-btn"]').each (i,btn) ->
    $(btn).removeClass('disabled')

  $( "#" + el.target.id ).addClass('disabled')

  $('[name="toggle-obj"]').each (i,obj) ->
    $(obj).hide()
    $("#{obj.id}-pagination").hide()

  id = el.target.id
  $( "#" + id.slice(id.indexOf('-') + 1,id.length) ).show()
  $( "#" + id.slice(id.indexOf('-') + 1,id.length) + '-pagination' ).show()
