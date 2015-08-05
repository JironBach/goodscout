# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

skills_num = 0
$("[id^=skills_]").change (el) ->
  if $("#skills_#{skills_num}_id").val() > 0 && $("#skills_#{skills_num}_year").val() > 0 && 
    $("#skills_#{skills_num}_level").val() > 0 && $("[id=skills_#{skills_num}]").length == 1
      el = $("#skills_#{skills_num}").clone()
      skills_num += 1
      $(el.find("#skills_#{skills_num - 1}_id")[0]).attr('id',"skills_#{skills_num}_id").attr('name',"skills[#{skills_num}][id]")
      $(el.find("#skills_#{skills_num - 1}_year")[0]).attr('id',"skills_#{skills_num}_year").attr('name',"skills[#{skills_num}][year]")
      $(el.find("#skills_#{skills_num - 1}_level")[0]).attr('id',"skills_#{skills_num}_level").attr('name',"skills[#{skills_num}][level]")
      el.attr('id',"skills_#{skills_num}")
      $("#skills_table").append(el)
